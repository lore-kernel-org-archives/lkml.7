Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21418C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C78206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q0tkYLno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbfDQOFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:05:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57770 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbfDQOFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uaqhWcEMhOppFxNJuJkkefm8Cb4IwH32m7Y7mt4G/+E=; b=Q0tkYLnoZXcTq0NRUrlkEZW81
        /KULfxKRSGSUKITkBkbhRVZxpA1kdFhPWtqenxHfduZZ08ickZYjg9HnWiiXYBAy/WcPN7EWSyv7k
        67wqjAxsoUAmau3b+5owHktakJsdqWR2pgQrbvDsr/hXhz5W1O6Cea3emGn/T8fdevZebw6OLFLxi
        k/T7FpvEBZhTLx+U7ODUPy52CjxQbEnjF8Px5S3RHMP6zNdcNxC1/jEBKKbUDoNJG4IDElOMBhklm
        uj0dilWVH7bkc4Dx71LLQZe7qv9383VAUkapzcwVGuj5uquZxhG4g5yYwiXVG0slSASQnsiItV633
        dGAllolTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGlBp-0003Zo-06; Wed, 17 Apr 2019 14:05:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7474929B5292C; Wed, 17 Apr 2019 16:05:27 +0200 (CEST)
Date:   Wed, 17 Apr 2019 16:05:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 11/16] locking/rwsem: Enable readers spinning on writer
Message-ID: <20190417140527.GJ4038@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-12-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413172259.2740-12-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 01:22:54PM -0400, Waiman Long wrote:
> @@ -650,6 +686,33 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
>  	struct rwsem_waiter waiter;
>  	DEFINE_WAKE_Q(wake_q);
>  
> +	if (!rwsem_can_spin_on_owner(sem))
> +		goto queue;
> +
> +	/*
> +	 * Undo read bias from down_read() and do optimistic spinning.
> +	 */
> +	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
> +	adjustment = 0;
> +	if (rwsem_optimistic_spin(sem, false)) {
> +		unsigned long flags;
> +
> +		/*
> +		 * Opportunistically wake up other readers in the wait queue.
> +		 * It has another chance of wakeup at unlock time.
> +		 */
> +		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS) &&
> +		    raw_spin_trylock_irqsave(&sem->wait_lock, flags)) {

why trylock? Also the rest of this function uses _irq(). Having had to
define @flags should've been a clue.

You simply cnanot do down_*() with IRQs disabled.

> +			if (!list_empty(&sem->wait_list))
> +				__rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
> +						  &wake_q);
> +			raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
> +			wake_up_q(&wake_q);
> +		}
> +		return sem;
> +	}
> +
> +queue:
>  	waiter.task = current;
>  	waiter.type = RWSEM_WAITING_FOR_READ;
>  	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
