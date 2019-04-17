Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB0DC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3D1206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GF/Y3OPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbfDQMsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:48:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57002 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfDQMsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ysoZ3sVjvRWdTwbufj+Igr5ABXbNMvaHdrYelS78dMw=; b=GF/Y3OPYHRae/gJhvwUTeKDZT
        LCSjOBahVsNjRJA9vMJt4qZaLAgyKtUygjp5STuyxPOmWF+qhuRJHDDvRnV2M5FAaYIAvwsWcs9Ds
        V2HXsYkZjqVAry/wnmj2dZRO1DQI+c6KqREcuDG/5vYaFWZDomcXYsNGgzDIZ1/kJVV6uMIYDopav
        wMIrNjnEaS59fOQ3xKO0n/tFvNI0PTPfkA/6D57funtaVgZ4S5ihwNfkjn+7epPoW1Re/i2AsFjRf
        2Uo2Zz50t5FiINOCFi029b9VMgsSwqMJMX4AcO2lI4rCW0CYeMhmLyKftbA1xgLM+hp5FNZ9dwDyM
        WCPoelXSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGjyr-0002Mf-7P; Wed, 17 Apr 2019 12:48:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C72D729B5292A; Wed, 17 Apr 2019 14:47:59 +0200 (CEST)
Date:   Wed, 17 Apr 2019 14:47:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 08/16] locking/rwsem: Make rwsem_spin_on_owner()
 return owner state
Message-ID: <20190417124759.GT14281@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-9-longman@redhat.com>
 <20190417124101.GE4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417124101.GE4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 02:41:01PM +0200, Peter Zijlstra wrote:
> On Sat, Apr 13, 2019 at 01:22:51PM -0400, Waiman Long wrote:
> > In the special case that there is no active lock and the handoff bit
> > is set, optimistic spinning has to be stopped.
> 
> > @@ -500,9 +521,19 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
> >  
> >  	/*
> >  	 * If there is a new owner or the owner is not set, we continue
> > -	 * spinning.
> > +	 * spinning except when here is no active locks and the handoff bit
> > +	 * is set. In this case, we have to stop spinning.
> >  	 */
> > -	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner));
> > +	owner = READ_ONCE(sem->owner);
> > +	if (!is_rwsem_owner_spinnable(owner))
> > +		return OWNER_NONSPINNABLE;
> > +	if (owner && !is_rwsem_owner_reader(owner))
> > +		return OWNER_WRITER;
> > +
> > +	count = atomic_long_read(&sem->count);
> > +	if (RWSEM_COUNT_HANDOFF(count) && !RWSEM_COUNT_LOCKED(count))
> > +		return OWNER_NONSPINNABLE;
> > +	return !owner ? OWNER_NULL : OWNER_READER;
> >  }
> 
> So this fixes a straight up bug in the last patch (and thus should be
> done before so the bug never exists), and creates unreadable code while
> at it.
> 
> Also, I think only checking HANDOFF after the loop is wrong; the moment
> HANDOFF happens you have to terminate the loop, irrespective of what
> @owner does.
> 
> Does something like so work?
> 
> ---
> 
> enum owner_state {
> 	OWNER_NULL		= 1 << 0,
> 	OWNER_WRITER		= 1 << 1,
> 	OWNER_READER		= 1 << 2,
> 	OWNER_NONSPINNABLE	= 1 << 3,
> };
> #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER)

Hmm, we should not spin on OWNER_NULL. Or at least not mixed in with the
patch that changes the shape of all this. That should go in the RT
thingy patch, which comes after this.

> static inline enum owner_state rwsem_owner_state(unsigned long owner)
> {
> 	if (!owner)
> 		return OWNER_NULL;
> 
> 	if (owner & RWSEM_ANONYMOUSLY_OWNED)
> 		return OWNER_NONSPINNABLE;
> 
> 	if (owner & RWSEM_READER_OWNER)
> 		return OWNER_READER;
> 
> 	return OWNER_WRITER;
> }
> 
> static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
> {
> 	struct task_struct *tmp, *owner = READ_ONCE(sem->owner);
> 	enum owner_state state;
> 
> 	rcu_read_lock();
> 	for (;;) {
> 		state = rwsem_owner_state((unsigned long)owner);
> 		if (!(state & OWNER_SPINNABLE))
> 			break;
> 
> 		if (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF) {
> 			state = OWNER_NONSPINNABLE;
> 			break;
> 		}
> 
> 		tmp = READ_ONCE(sem->owner);
> 		if (tmp != owner) {
> 			state = rwsem_owner_state((unsigned long)tmp);
> 			break;
> 		}
> 
> 		/*
> 		 * Ensure we emit the owner->on_cpu, dereference _after_
> 		 * checking sem->owner still matches owner, if that fails,
> 		 * owner might point to free()d memory, if it still matches,
> 		 * the rcu_read_lock() ensures the memory stays valid.
> 		 */
> 		barrier();
> 
> 		if (need_resched() || !owner_on_cpu(owner)) {
> 			state = OWNER_NONSPINNABLE;
> 			break;
> 		}
> 
> 		cpu_relax();
> 	}
> 	rcu_read_unlock();
> 
> 	return state;
> }
