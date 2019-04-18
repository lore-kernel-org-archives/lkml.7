Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3059C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF792206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s4CGu/xB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbfDRJLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:11:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388352AbfDRJLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wMBRTO9KSntoxeImvL8vMrMDbfPWrp/XjHhkB2aDgKY=; b=s4CGu/xBUrYK3irwnr56HRqPp
        5ULLREg0diIjErgmJMNh44X2qhD0d5GsbKtncw/jHlXMiEYLqvnpHXhi/ENacpIoZnojAIEx3hcHZ
        MkOnPKnE9g63uyW0fC9NyEemZlMAGGUvM12EHBUZscJq7nX9TY1nUXyqBFwUJwerzsTCBEkkYkrnY
        Eek849vNzMRbWK6wXpQqZVIRFOvZEoN8zamGs6FR3OUPti4fzR4u3RiB4smQ5l5TRADshdRX3QnDT
        twQE5+IYz7yMFuVGoKpP0TJ6r3n/1mybIJTlk1v9J73pJnBuYm6viCijFii26DXcOcw4jo/XeUZ5P
        e4ymv+oUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH34Z-0006t3-Rf; Thu, 18 Apr 2019 09:11:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E657129BA6814; Thu, 18 Apr 2019 11:11:09 +0200 (CEST)
Date:   Thu, 18 Apr 2019 11:11:09 +0200
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
Message-ID: <20190418091109.GY12232@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-12-longman@redhat.com>
 <20190417140527.GJ4038@hirez.programming.kicks-ass.net>
 <d18aa365-cedc-cd45-36a5-48d78af2fcce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d18aa365-cedc-cd45-36a5-48d78af2fcce@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 01:51:24PM -0400, Waiman Long wrote:
> On 04/17/2019 10:05 AM, Peter Zijlstra wrote:
> > On Sat, Apr 13, 2019 at 01:22:54PM -0400, Waiman Long wrote:
> >> @@ -650,6 +686,33 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
> >>  	struct rwsem_waiter waiter;
> >>  	DEFINE_WAKE_Q(wake_q);
> >>  
> >> +	if (!rwsem_can_spin_on_owner(sem))
> >> +		goto queue;
> >> +
> >> +	/*
> >> +	 * Undo read bias from down_read() and do optimistic spinning.
> >> +	 */
> >> +	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
> >> +	adjustment = 0;
> >> +	if (rwsem_optimistic_spin(sem, false)) {
> >> +		unsigned long flags;
> >> +
> >> +		/*
> >> +		 * Opportunistically wake up other readers in the wait queue.
> >> +		 * It has another chance of wakeup at unlock time.
> >> +		 */
> >> +		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS) &&
> >> +		    raw_spin_trylock_irqsave(&sem->wait_lock, flags)) {
> > why trylock?

> I used trylock to avoid getting stuck in the spinlock while holding a
> read lock on the rwsem.

Is that a real concern? I would think that not waking further readers
would, esp. under high contention, be a bigger deal.
