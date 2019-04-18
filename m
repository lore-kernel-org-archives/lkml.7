Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F4AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78D320674
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BmTzNWq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388995AbfDRNGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:06:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRNGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5Ys9ORuyuzEuq7FWhaeRxs5dE4tcTtfyYwM/xjXQKxU=; b=BmTzNWq0a0NM0S3wJOIVV1r3S
        Tsiq2nN0U0azjMi/4oXq3NUZ/o9kGiM16phsVvEHllb0/Xh/EM2lEr+E7idBw4i+16aXB4FM4Qxwz
        dEw3pov3jn9buIQuDE3aN3aU57wym5f3P3pA5S4NLIg+M++ZBbwvzYn4ZQBSiCQXbvaIs1hYwORq/
        fo6zYWjVvjX/Twmtyefe9XeNTmAdeAjPSB/US2JrKPOIiuj3kyR8oJmJIPsSSD9Z/N3yfgS+rZeZX
        iY4UzvRZNWmp4VYqhS6mMM8OoowNpjBtN3yil9pmXGx4wdDEFUwBPWaAHwQ7BSwYpG4pOM5oK2w5D
        rsyQV2pwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH6k2-0003Ts-2x; Thu, 18 Apr 2019 13:06:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD7E729B9B7B8; Thu, 18 Apr 2019 15:06:11 +0200 (CEST)
Date:   Thu, 18 Apr 2019 15:06:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 12/16] locking/rwsem: Enable time-based spinning on
 reader-owned rwsem
Message-ID: <20190418130611.GK4038@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-13-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413172259.2740-13-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


So I really dislike time based spinning, and we've always rejected it
before.

On Sat, Apr 13, 2019 at 01:22:55PM -0400, Waiman Long wrote:

> +static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
> +{
> +	long count = atomic_long_read(&sem->count);
> +	int reader_cnt = atomic_long_read(&sem->count) >> RWSEM_READER_SHIFT;
> +
> +	if (reader_cnt > 30)
> +		reader_cnt = 30;
> +	return sched_clock() + ((count & RWSEM_FLAG_WAITERS)
> +		? 10 * NSEC_PER_USEC + reader_cnt * NSEC_PER_USEC/2
> +		: 25 * NSEC_PER_USEC);
> +}

Urgh, why do you _have_ to write unreadable code :-(

static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
{
	long count = atomic_long_read(&sem->count);
	u64 delta = 25 * NSEC_PER_USEC;

	if (count & RWSEM_FLAG_WAITERS) {
		int readers = count >> RWSEM_READER_SHIFT;

		if (readers > 30)
			readers = 30;

		delta = (20 + readers) * NSEC_PER_USEC / 2;
	}

	return sched_clock() + delta;
}

I don't get it though; the number of current read-owners is independent
of WAITERS, while the hold time does correspond to it.

So why do we have that WAITERS check in there?

> @@ -616,6 +678,35 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
>  		if (taken)
>  			break;
>  
> +		/*
> +		 * Time-based reader-owned rwsem optimistic spinning
> +		 */

This relies on rwsem_spin_on_owner() not actually spinning for
read-owned.

> +		if (wlock && (owner_state == OWNER_READER)) {
> +			/*
> +			 * Initialize rspin_threshold when the owner
> +			 * state changes from non-reader to reader.
> +			 */
> +			if (prev_owner_state != OWNER_READER) {
> +				if (!is_rwsem_spinnable(sem))
> +					break;
> +				rspin_threshold = rwsem_rspin_threshold(sem);
> +				loop = 0;
> +			}

This seems fragile, why not to the rspin_threshold thing _once_ at the
start of this function?

This way it can be reset.

> +			/*
> +			 * Check time threshold every 16 iterations to
> +			 * avoid calling sched_clock() too frequently.
> +			 * This will make the actual spinning time a
> +			 * bit more than that specified in the threshold.
> +			 */
> +			else if (!(++loop & 0xf) &&
> +				 (sched_clock() > rspin_threshold)) {

Why is calling sched_clock() lots a problem?

> +				rwsem_set_nonspinnable(sem);
> +				lockevent_inc(rwsem_opt_nospin);
> +				break;
> +			}
> +		}
> +
>  		/*
>  		 * An RT task cannot do optimistic spinning if it cannot
>  		 * be sure the lock holder is running or live-lock may


