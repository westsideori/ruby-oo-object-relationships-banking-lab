class Transfer

    attr_accessor :sender, :receiver, :amount, :status

    def initialize(sender, receiver, amount)
      @sender = sender 
      @receiver = receiver
      @amount = amount
      @status = 'pending'
    end

    def valid?
      sender.valid? && receiver.valid? ? true : false
    end

    def transaction_send(sender,receiver, status)
      sender.balance -= amount 
      receiver.deposit(amount)
      self.status = status
    end
    
    def transaction_rejected
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end

    def execute_transaction
      Transfer.new(sender, receiver, amount).valid? && self.status == "pending" && sender.balance > amount ? self.transaction_send(sender,receiver,"complete") : self.transaction_rejected
    end

    def reverse_transfer
      self.transaction_send(receiver,sender, "reversed") if self.execute_transaction
    end

end
