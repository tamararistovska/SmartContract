// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract VendingMachine {

    address public owner;
    mapping (address => uint) public donutBalances;

  
    constructor() {
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }

    function restock(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock.");
        donutBalances[address(this)] += amount;
    }

    function purchase(uint amount) public payable {
    uint purchaseAmount = amount * 1e15; 
    require(msg.value >= purchaseAmount, "You must pay at least 0.0010 ETH per donut");
    require(donutBalances[address(this)] >= amount, "Not enough donuts in stock to complete this purchase");
    donutBalances[address(this)] -= amount;
    donutBalances[msg.sender] += amount;
}

}
