Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE07C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B96A21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388308AbfKGLLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:11:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47291 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKGLLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:11:19 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSfgz-0003xy-Sl; Thu, 07 Nov 2019 12:11:10 +0100
Date:   Thu, 7 Nov 2019 12:11:08 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jan Stancek <jstancek@redhat.com>
cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>, longman@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] futex: don't retry futex_wait() with stale uaddr/val
 after spurious wakeup
In-Reply-To: <9179dbc3505e1de99ee36b09b0a12995239d73c3.1573079868.git.jstancek@redhat.com>
Message-ID: <alpine.DEB.2.21.1911070009040.1869@nanos.tec.linutronix.de>
References: <9179dbc3505e1de99ee36b09b0a12995239d73c3.1573079868.git.jstancek@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan!

On Wed, 6 Nov 2019, Jan Stancek wrote:
> Assume following scenario: process A is sleeping on futex (uaddr1)
> inside futex_wait(). Process B requeues this waiter via FUTEX_CMP_REQUEUE
> to uaddr2, but doesn't wake it up. Later, process A spuriously wakes up
> and futex_wait() retries to queue again with same uaddr1/val1:
>         if (!signal_pending(current))
>                 goto retry;

My brain is already wreckaged by staring into futex code for several days
in a row. So it might be just me, but the above qualifies for 'word
salad' as Peter Zijlstra named a similar changelog.

Please try to explain problems in very clear and understandable ways. The
futex code is confusing enough already.

> Problem: Userspace fails to wake process A with futex(uaddr2, FUTEX_WAKE)
> 
> Store target uaddr/val in futex_requeue() and let futex_wait()
> retry after spurious wake up using stored values.

A bit less terse explanations might make the reader actually understand
right away what you are trying to say.

You're describing the WHAT, not the WHY.

> diff --git a/kernel/futex.c b/kernel/futex.c
> index bd18f60e4c6c..c13cfee25d35 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -237,6 +237,9 @@ struct futex_q {
>  	struct rt_mutex_waiter *rt_waiter;
>  	union futex_key *requeue_pi_key;
>  	u32 bitset;
> +
> +	u32 *uaddr;
> +	u32 val;
>  } __randomize_layout;
>  
>  static const struct futex_q futex_q_init = {
> @@ -1939,6 +1942,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
>  	struct futex_hash_bucket *hb1, *hb2;
>  	struct futex_q *this, *next;
>  	DEFINE_WAKE_Q(wake_q);
> +	u32 curval, targetval;
>  
>  	if (nr_wake < 0 || nr_requeue < 0)
>  		return -EINVAL;
> @@ -2005,30 +2009,32 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
>  	hb_waiters_inc(hb2);
>  	double_lock_hb(hb1, hb2);
>  
> -	if (likely(cmpval != NULL)) {
> -		u32 curval;
> -
> +	ret = get_futex_value_locked(&targetval, uaddr2);

Storing that value is meaningless as it is subject to change right after
the requeue operation has finished.

Also there is absolutely no requirement for this address to be accessible
at the time of this call. At least not for CMP_REQUEUE, CMP_REQUEUE_PI is a
different case.

> +	if (!ret && likely(cmpval != NULL))
>  		ret = get_futex_value_locked(&curval, uaddr1);
>  
> -		if (unlikely(ret)) {
> -			double_unlock_hb(hb1, hb2);
> -			hb_waiters_dec(hb2);
> +	if (unlikely(ret)) {
> +		double_unlock_hb(hb1, hb2);
> +		hb_waiters_dec(hb2);
>  
> +		ret = get_user(targetval, uaddr2);
> +		if (!ret && likely(cmpval != NULL))
>  			ret = get_user(curval, uaddr1);
> -			if (ret)
> -				goto out_put_keys;
>  
> -			if (!(flags & FLAGS_SHARED))
> -				goto retry_private;
> +		if (ret)
> +			goto out_put_keys;
>  
> -			put_futex_key(&key2);
> -			put_futex_key(&key1);
> -			goto retry;
> -		}
> -		if (curval != *cmpval) {
> -			ret = -EAGAIN;
> -			goto out_unlock;
> -		}
> +		if (!(flags & FLAGS_SHARED))
> +			goto retry_private;
> +
> +		put_futex_key(&key2);
> +		put_futex_key(&key1);
> +		goto retry;
> +	}
> +
> +	if (likely(cmpval != NULL) && (curval != *cmpval)) {
> +		ret = -EAGAIN;
> +		goto out_unlock;
>  	}

I can halfways understand the chunks below this, but the above is
absolutely unclear why this needs to be reshuffled. There is no explanation
whatsoever why that code needs to be changed to achive the below.

This changes the code flow massively and there is absolutely no indication
why this is equivivalent to the previous state.

If at all, and I doubt it, this restructuring wants to be a separate patch.

> @@ -2725,7 +2739,7 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
>  	 * Prepare to wait on uaddr. On success, holds hb lock and increments
>  	 * q.key refs.
>  	 */
> -	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
> +	ret = futex_wait_setup(q.uaddr, q.val, flags, &q, &hb);
>  	if (ret)
>  		goto out;
>  

So you go great length to "fix" the spurious wakeup case, but what happens if
there is an actual signal?

It will return to handle the signal and then run into the exactly same
situation because it restarts the syscall with the original uaddr1/uval,
right?

That means that the shortcut which was added in commit d58e6576b0de
("futex: Handle spurious wake up") is equivalent to the actual signal case.

So the above churn is pretty pointless because it "fixes" not even half of
the problem and you can't fix the -ERESTARTSYS case at all.

IIRC the uaddr1 value is supposed to change on a requeue operation so that
a late incoming waiter goes back with -EWOULDBLOCK. And excatly the same
would happen on the retry.

Aside of that you are completely failing to explain in which context you
observe this problem. Is that failing on libc, some test case or some other
maybe experimental code?

If there is an actual use case for keeping the uaddr1 value the same across
a requeue then this needs to be described properly and also needs to be
handled differently and consistently in all cases not just for a spurious
wakeup.

But let's talk about that once you came up with a proper explanation for
what you are trying to solve and why you think it's correct.

Thanks,

	tglx
