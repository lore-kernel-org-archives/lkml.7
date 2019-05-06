Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA69C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C344A20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o6EFrkcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfEFPsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:48:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56726 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEFPsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DaTpJOsoWJo0WD81bfV28hB3ID8vE/x9eUnd1XmiwjA=; b=o6EFrkcpgSZ7tjPl+W115Qe2u
        FjbJMoZVJo8y1cI5MrtfPfZ2bXKqndEbfiiOVXhM9k1o/toaE/u7ToPCD/kymkdYKqjCGxSWsgr5h
        XMsFY/43rh855nsd6Z2BgBsijO5K+jAA297j59mVjmuwjAcChoN5RHCW/9y8nQjrQQJCx314beRjh
        saYJQo2BykPmC4c+PwhTxSRf5J+TVYHsT3wlaSZlswdzTbfC9DTG2VvdFy/SDsU907s0E7lfD9qDx
        rgpiNQ4WIs1zTpHck3xCrSoR+0PHH0inU29ACvaTZTjYkTjrSDS+xHstvArRhVCSvJXWYIsihPniT
        GMor0Q1kA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNfqR-0005VK-JO; Mon, 06 May 2019 15:47:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACB852029F882; Mon,  6 May 2019 17:47:56 +0200 (CEST)
Date:   Mon, 6 May 2019 17:47:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v7 14/20] locking/rwsem: Enable time-based spinning
 on reader-owned rwsem
Message-ID: <20190506154756.GK2623@hirez.programming.kicks-ass.net>
References: <20190428212557.13482-1-longman@redhat.com>
 <20190428212557.13482-15-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428212557.13482-15-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 05:25:51PM -0400, Waiman Long wrote:

> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 6b11dce3139d..62fcb8bacfab 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c

> @@ -56,7 +61,9 @@
>   * a rwsem, but the overhead is simply too big.
>   */
>  #define RWSEM_READER_OWNED	(1UL << 0)
> -#define RWSEM_NONSPINNABLE	(1UL << 1)
> +#define RWSEM_RD_NONSPINNABLE	(1UL << 1)
> +#define RWSEM_WR_NONSPINNABLE	(1UL << 2)
> +#define RWSEM_NONSPINNABLE	(RWSEM_RD_NONSPINNABLE | RWSEM_WR_NONSPINNABLE)
>  #define RWSEM_OWNER_FLAGS_MASK	(RWSEM_READER_OWNED | RWSEM_NONSPINNABLE)
>  
>  #ifdef CONFIG_DEBUG_RWSEMS

> @@ -149,9 +155,27 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
>   * and steal the lock.
>   * N.B. !owner is considered spinnable.
>   */
> -static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
> +static inline bool is_rwsem_owner_spinnable(struct task_struct *owner, bool wr)
>  {
> -	return !((unsigned long)owner & RWSEM_NONSPINNABLE);
> +	unsigned long bit = wr ? RWSEM_WR_NONSPINNABLE : RWSEM_RD_NONSPINNABLE;
> +
> +	return !((unsigned long)owner & bit);
> +}

You _could_ write that as:

  return !((unsigned long)owner & (1UL << (1 + wr)));

> +/*
> + * Return true if the rwsem is spinnable.
> + */
> +static inline bool is_rwsem_spinnable(struct rw_semaphore *sem, bool wr)
> +{
> +	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner), wr);
> +}

I think we can do without this; see below.

> +/*
> + * Remove all the flag bits from owner.
> + */
> +static inline struct task_struct *owner_without_flags(struct task_struct *owner)
> +{
> +	return (struct task_struct *)((long)owner & ~RWSEM_OWNER_FLAGS_MASK);
>  }

I hates the name on this one...

> @@ -163,11 +187,11 @@ static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
>   */
>  static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
>  {
> +	unsigned long owner = (unsigned long)READ_ONCE(sem->owner);
> +
> +	if ((owner & ~RWSEM_OWNER_FLAGS_MASK) == (unsigned long)current)
>  		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
> -				RWSEM_READER_OWNED | RWSEM_NONSPINNABLE);
> +				owner & RWSEM_OWNER_FLAGS_MASK);

Missing { }, also, I think this is all broken, this sem->owner stuff
mixes regular writes and cmpxchg() which is known broken on a number of
platforms :/ Also the cmpxchg here can fail due to the cmpchg in
rwsem_set_nonspinnable().

Also; below you've used atomic_long_andnot(); it seems to me you can do
the same here:

	atomic_long_andnot(RWSEM_OWNER_FLAGS_MASK,
			   (atomic_long_t *)&sem->owner);

(ideally without the cast, because you've made sem->owner atomic_long_t)

>  }
>  #else
>  static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
> @@ -175,6 +199,22 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
>  }
>  #endif
>  
> +/*
> + * Set the RWSEM_NONSPINNABLE bits if the RWSEM_READER_OWNED flag
> + * remains set. Otherwise, the operation will be aborted.
> + */
> +static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
> +{
> +	long owner = (long)READ_ONCE(sem->owner);
> +
> +	while (owner & RWSEM_READER_OWNED) {
> +		if (!is_rwsem_owner_spinnable((void *)owner, false))
> +			break;

		if (owner & RWSEM_RD_NONSPINNABLE)
			break;

is _much_ more readable. Also, afaict, this function doesn't do what the
comment on top says it does. If it has RD_NONSPINNABLE set, it will
never set WR_NONSPINNABLE.

> +		owner = cmpxchg((long *)&sem->owner, owner,
> +				owner | RWSEM_NONSPINNABLE);

Same comment for mixing normal stores and cmpxchg.

> +	}
> +}
> +
>  /*
>   * Guide to the rw_semaphore's count field.
>   *
> @@ -496,6 +536,11 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
>  
>  static inline bool owner_on_cpu(struct task_struct *owner)
>  {
> +	/*
> +	 * Clear all the flag bits in owner
> +	 */
> +	owner = owner_without_flags(owner);

Pointless comment; it says the exact same thing the function name says.

Why is this added now? How come we could never have bits set before this
patch?

Also note how you're doing this twice, the only callsite already does
owner_without_flags() on it before calling this.

>  	/*
>  	 * As lock holder preemption issue, we both skip spinning if
>  	 * task is not on cpu or its cpu is preempted
> @@ -503,12 +548,12 @@ static inline bool owner_on_cpu(struct task_struct *owner)
>  	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
>  }
>  
> -static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
> +static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
>  {
>  	struct task_struct *owner;
>  	bool ret = true;
>  
> -	BUILD_BUG_ON(is_rwsem_owner_spinnable(RWSEM_OWNER_UNKNOWN));
> +	BUILD_BUG_ON(is_rwsem_owner_spinnable(RWSEM_OWNER_UNKNOWN, true));

	BUILD_BUG_ON(!((unsigned long)RWSEM_OWNER_UNKNOWN & RWSEM_WR_NONSPINABLE));

>  
>  	if (need_resched()) {
>  		lockevent_inc(rwsem_opt_fail);
> @@ -517,14 +562,17 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>  
>  	preempt_disable();
>  	rcu_read_lock();
> +
>  	owner = READ_ONCE(sem->owner);
> +	if (!is_rwsem_owner_spinnable(owner, wr))
> +		ret = false;
> +	else if ((unsigned long)owner & RWSEM_READER_OWNED)
> +		ret = true;
> +	else if ((owner = owner_without_flags(owner)))
> +		ret = owner_on_cpu(owner);
> +

	state = rwsem_owner_state(owner, wr);
	if (state & OWNER_NONSPINNABLE)
		ret = false;
	else if (state & OWNER_READER)
		ret = true;
	else
		ret = owner_on_cpu(owner);

>  	rcu_read_unlock();
>  	preempt_enable();
> -
>  	lockevent_cond_inc(rwsem_opt_fail, !ret);
>  	return ret;
>  }

> @@ -603,10 +652,53 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
>  	return state;
>  }
>  
> +/*
> + * Calculate reader-owned rwsem spinning threshold for writer
> + *
> + * It is assumed that the more readers own the rwsem, the longer it will

No assumptions needed; its a direct concequence of the propagation of
uncertaintly:

  https://en.wikipedia.org/wiki/Propagation_of_uncertainty

Basically, if we can characterize a single read-side critical section as
a mean and stdev error, then for N readers the mean hold-time will be
identical, but the error will be sqrt(N*s^2).

And therefore the more readers, the more likely we'll see longer hold
times.

> + * take for them to wind down and free the rwsem. So the formula to
> + * determine the actual spinning time limit is:
> + *
> + * 1) RWSEM_FLAG_WAITERS set
> + *    Spinning threshold = (10 + nr_readers/2)us
> + *
> + * 2) RWSEM_FLAG_WAITERS not set
> + *    Spinning threshold = 25us
> + *
> + * In the first case when RWSEM_FLAG_WAITERS is set, no new reader can
> + * become rwsem owner. It is assumed that the more readers own the rwsem,
> + * the longer it will take for them to wind down and free the rwsem. In
> + * addition, if it happens that a previous task that releases the lock
> + * is in the process of waking up readers one-by-one, the process will
> + * take longer when more readers needed to be woken up. This is subjected
> + * to a maximum value of 25us.
> + *
> + * In the second case with RWSEM_FLAG_WAITERS off, new readers can join
> + * and become one of the owners. So assuming for the worst case and spin
> + * for at most 25us.
> + */
> +static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
> +{
> +	long count = atomic_long_read(&sem->count);
> +	u64 delta = 25 * NSEC_PER_USEC;
> +
> +	if (count & RWSEM_FLAG_WAITERS) {
> +		int readers = count >> RWSEM_READER_SHIFT;
> +
> +		if (readers > 30)
> +			readers = 30;
> +		delta = (20 + readers) * NSEC_PER_USEC / 2;
> +	}
> +
> +	return sched_clock() + delta;
> +}

Which, to me, would suggest we just use the active reader count. That
is, I'm still somewhat puzzled by the WAITERS thing.


> @@ -636,6 +727,39 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
>  		if (taken)
>  			break;
>  
> +		/*
> +		 * Time-based reader-owned rwsem optimistic spinning
> +		 */
> +		if (wlock && (owner_state == OWNER_READER)) {
> +			/*
> +			 * Re-initialize rspin_threshold every time when
> +			 * the owner state changes from non-reader to reader.
> +			 * This allows a writer to steal the lock in between
> +			 * 2 reader phases and have the threshold reset at
> +			 * the beginning of the 2nd reader phase.
> +			 */
> +			if (prev_owner_state != OWNER_READER) {
> +				if (!is_rwsem_spinnable(sem, wlock))

would that not be the same as: state & OWNER_NONSPINNABLE ?
Which then removes the last user of that function.

> +					break;
> +				rspin_threshold = rwsem_rspin_threshold(sem);
> +				loop = 0;
> +			}
> +
> +			/*
> +			 * Check time threshold once every 16 iterations to
> +			 * avoid calling sched_clock() too frequently so
> +			 * as to reduce the average latency between the times
> +			 * when the lock becomes free and when the spinner
> +			 * is ready to do a trylock.
> +			 */
> +			else if (!(++loop & 0xf) &&
> +				 (sched_clock() > rspin_threshold)) {
> +				rwsem_set_nonspinnable(sem);
> +				lockevent_inc(rwsem_opt_nospin);
> +				break;
> +			}
> +		}
> +
>  		/*
>  		 * An RT task cannot do optimistic spinning if it cannot
>  		 * be sure the lock holder is running or live-lock may
> @@ -690,8 +814,25 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
>  	lockevent_cond_inc(rwsem_opt_fail, !taken);
>  	return taken;
>  }
> +
> +/*
> + * Clear the owner's RWSEM_WR_NONSPINNABLE bit if it is set. This should
> + * only be called when the reader count reaches 0.
> + *
> + * This give writers better chance to acquire the rwsem first before
> + * readers when the rwsem was being held by readers for a relatively long
> + * period of time. Race can happen that an optimistic spinner may have
> + * just stolen the rwsem and set the owner, but just clearing the
> + * RWSEM_WR_NONSPINNABLE bit will do no harm anyway.
> + */
> +static inline void clear_wr_nonspinnable(struct rw_semaphore *sem)
> +{
> +	if (!is_rwsem_spinnable(sem, true))
> +		atomic_long_andnot(RWSEM_WR_NONSPINNABLE,
> +				  (atomic_long_t *)&sem->owner);
> +}

That's atrocious... and another clue that ->owner should maybe also be
atomic_long_t.

Something like:

static inline void clear_wr_nonspinnable(struct rw_semaphore *sem)
{
	if (READ_ONCE(sem->owner) & RWSEM_WR_NONSPINNABLE) {
		atomic_long_andnot(RWSEM_WR_NONSPINNABLE,
				   (atomic_long_t *)&sem->owner);
	}
}

>  #else
> -static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
> +static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
>  {
>  	return false;
>  }
