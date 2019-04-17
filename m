Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076D5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82CA2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KsqX64pA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbfDQNA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:00:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57124 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbfDQNA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x3TB78eLMmND4F0NhqqOIiB/RJHNLVhUND4CEfUPCFo=; b=KsqX64pA42RMrZpuxVvORZeR4
        n1hmBacM6fYUjLCs4X33e45ezLlY05VAcOyhWtdaxJ2quXC+JjQCzIfw8S2ynuq3gLfF2449WlAOw
        jt/hlDYCJUiv5JvMBVelaW4jJWy9M6fiK7Ihu7xb2FMYrn03IN9HzPrrKFvY3QJXqMbpVtXrioPA9
        hEDbSHLt3/5r4xMNRlhSP2uqR5SIQJIgJ1eJ5CUTbkf3yCUPKhwVzEVZwOsoj+Uv7Qm89Ajv1vrGD
        nMhnOqvo2OG1MlMvEwaSuP1xQA06JjHsbWzDFEw/ZME9UNFYOcloEwx5qcL3QqjNKAxBK1/twp+IY
        fw+o0dMhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGkAj-0002VF-Qi; Wed, 17 Apr 2019 13:00:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 92AD429AD7C08; Wed, 17 Apr 2019 15:00:16 +0200 (CEST)
Date:   Wed, 17 Apr 2019 15:00:16 +0200
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
Message-ID: <20190417130016.GU14281@hirez.programming.kicks-ass.net>
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

enum owner_state {
	OWNER_NULL		= 1 << 0,
	OWNER_WRITER		= 1 << 1,
	OWNER_READER		= 1 << 2,
	OWNER_NONSPINNABLE	= 1 << 3,
};
#define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER)

static inline enum owner_state rwsem_owner_state(unsigned long owner)
{
	if (!owner)
		return OWNER_NULL;

	if (owner & RWSEM_ANONYMOUSLY_OWNED)
		return OWNER_NONSPINNABLE;

	if (owner & RWSEM_READER_OWNER)
		return OWNER_READER;

	return OWNER_WRITER;
}

static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
{
	struct task_struct *tmp, *owner = READ_ONCE(sem->owner);
	enum owner_state state = rwsem_owner_state((unsigned long)owner);

	if (state != OWNER_WRITER)
		return state;

	rcu_read_lock();
	for (;;) {
		if (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF) {
			state = OWNER_NONSPINNABLE;
			break;
		}

		tmp = READ_ONCE(sem->owner);
		if (tmp != owner) {
			state = rwsem_owner_state((unsigned long)tmp);
			break;
		}

		/*
		 * Ensure we emit the owner->on_cpu, dereference _after_
		 * checking sem->owner still matches owner, if that fails,
		 * owner might point to free()d memory, if it still matches,
		 * the rcu_read_lock() ensures the memory stays valid.
		 */
		barrier();

		if (need_resched() || !owner_on_cpu(owner)) {
			state = OWNER_NONSPINNABLE;
			break;
		}

		cpu_relax();
	}
	rcu_read_unlock();

	return state;
}
