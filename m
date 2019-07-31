Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7983C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F03206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y6JjRtnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfGaMGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:06:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfGaMGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Z9ZbCHEVPCiOrZv0cTtLSmcON8MXzcglXRCnU88rwM=; b=Y6JjRtnQbB/u3GszpUa9LGC5M
        Y65ha+dS9ae0HZeJ8X+KvGQDeByQrxXlCD6VLlp2KTI+3V65qT+8yEcrBcZrsFQJnoXL5nXjgODro
        b/eMlS5Gbb/1rEp9lqWVx50gOf72biTlE+dzauh5f0EpXaWvNRZ0Em5Gos3dsY9p4u4b9LbHADtgN
        ijDYO/haLKspKiu7a6M2SvFJOK4Kk2nOGjhz7TVhnoOiistRULad1BHaPxUre3DOARirzHk6FuKxQ
        usIlDtxqqn570azVU0xWdIDiMnwLfPjLINPOyqdNgKashsDYtlPRx8XZ2vwcpcCdNmI+HqWT7CwVm
        KOkIt7rmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsnMo-0002Ub-AO; Wed, 31 Jul 2019 12:06:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 190B62029F869; Wed, 31 Jul 2019 14:06:00 +0200 (CEST)
Date:   Wed, 31 Jul 2019 14:06:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Zebediah Figura <z.figura12@gmail.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        viro@zeniv.linux.org.uk, jannh@google.com
Subject: Re: [PATCH RFC 2/2] futex: Implement mechanism to wait on any of
 several futexes
Message-ID: <20190731120600.GT31381@hirez.programming.kicks-ass.net>
References: <20190730220602.28781-1-krisman@collabora.com>
 <20190730220602.28781-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730220602.28781-2-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 06:06:02PM -0400, Gabriel Krisman Bertazi wrote:
> This is a new futex operation, called FUTEX_WAIT_MULTIPLE, which allows
> a thread to wait on several futexes at the same time, and be awoken by
> any of them.  In a sense, it implements one of the features that was
> supported by pooling on the old FUTEX_FD interface.
> 
> My use case for this operation lies in Wine, where we want to implement
> a similar interface available in Windows, used mainly for event
> handling.  The wine folks have an implementation that uses eventfd, but
> it suffers from FD exhaustion (I was told they have application that go
> to the order of multi-milion FDs), and higher CPU utilization.

So is multi-million the range we expect for @count ?

If so, we're having problems, see below.

> In time, we are also proposing modifications to glibc and libpthread to
> make this feature available for Linux native multithreaded applications
> using libpthread, which can benefit from the behavior of waiting on any
> of a group of futexes.
> 
> In particular, using futexes in our Wine use case reduced the CPU
> utilization by 4% for the game Beat Saber and by 1.5% for the game
> Shadow of Tomb Raider, both running over Proton (a wine based solution
> for Windows emulation), when compared to the eventfd interface. This
> implementation also doesn't rely of file descriptors, so it doesn't risk
> overflowing the resource.
> 
> Technically, the existing FUTEX_WAIT implementation can be easily
> reworked by using do_futex_wait_multiple with a count of one, and I
> have a patch showing how it works.  I'm not proposing it, since
> futex is such a tricky code, that I'd be more confortable to have
> FUTEX_WAIT_MULTIPLE running upstream for a couple development cycles,
> before considering modifying FUTEX_WAIT.
> 
> From an implementation perspective, the futex list is passed as an array
> of (pointer,value,bitset) to the kernel, which will enqueue all of them
> and sleep if none was already triggered. It returns a hint of which
> futex caused the wake up event to userspace, but the hint doesn't
> guarantee that is the only futex triggered.  Before calling the syscall
> again, userspace should traverse the list, trying to re-acquire any of
> the other futexes, to prevent an immediate -EWOULDBLOCK return code from
> the kernel.

> Signed-off-by: Zebediah Figura <z.figura12@gmail.com>
> Signed-off-by: Steven Noonan <steven@valvesoftware.com>
> Signed-off-by: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

That is not a valid SoB chain.

> ---
>  include/uapi/linux/futex.h |   7 ++
>  kernel/futex.c             | 161 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 164 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
> index a89eb0accd5e..2401c4cf5095 100644
> --- a/include/uapi/linux/futex.h
> +++ b/include/uapi/linux/futex.h

> @@ -150,4 +151,10 @@ struct robust_list_head {
>    (((op & 0xf) << 28) | ((cmp & 0xf) << 24)		\
>     | ((oparg & 0xfff) << 12) | (cmparg & 0xfff))
>  
> +struct futex_wait_block {
> +	__u32 __user *uaddr;
> +	__u32 val;
> +	__u32 bitset;
> +};

That is not compat invariant and I see a distinct lack of compat code in
this patch.

> diff --git a/kernel/futex.c b/kernel/futex.c
> index 91f3db335c57..2623e8f152cd 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c

no function comment in sight

> +static int do_futex_wait_multiple(struct futex_wait_block *wb,
> +				  u32 count, unsigned int flags,
> +				  ktime_t *abs_time)
> +{
> +

(spurious empty line)

> +	struct hrtimer_sleeper timeout, *to;
> +	struct futex_hash_bucket *hb;
> +	struct futex_q *qs = NULL;
> +	int ret;
> +	int i;
> +
> +	qs = kcalloc(count, sizeof(struct futex_q), GFP_KERNEL);
> +	if (!qs)
> +		return -ENOMEM;

This will not work for @count ~ 1e6, or rather, MAX_ORDER is 11, so we
can, at most, allocate 4096 << 11 bytes, and since sizeof(futex_q) ==
112, that gives: ~75k objects.

Also; this is the only actual limit placed on @count.

Jann, Al, this also allows a single task to increment i_count or
mm_count by ~75k, which might be really awesome for refcount smashing
attacks.

> +
> +	to = futex_setup_timer(abs_time, &timeout, flags,
> +			       current->timer_slack_ns);
> + retry:

(wrongly indented label)

> +	for (i = 0; i < count; i++) {
> +		qs[i].key = FUTEX_KEY_INIT;
> +		qs[i].bitset = wb[i].bitset;
> +
> +		ret = get_futex_key(wb[i].uaddr, flags & FLAGS_SHARED,
> +				    &qs[i].key, FUTEX_READ);
> +		if (unlikely(ret != 0)) {
> +			for (--i; i >= 0; i--)
> +				put_futex_key(&qs[i].key);
> +			goto out;
> +		}
> +	}
> +
> +	set_current_state(TASK_INTERRUPTIBLE);
> +
> +	for (i = 0; i < count; i++) {
> +		ret = __futex_wait_setup(wb[i].uaddr, wb[i].val,
> +					 flags, &qs[i], &hb);
> +		if (ret) {
> +			/* Drop the failed key directly.  keys 0..(i-1)
> +			 * will be put by unqueue_me.
> +			 */

(broken comment style)

> +			put_futex_key(&qs[i].key);
> +
> +			/* Undo the partial work we did. */
> +			for (--i; i >= 0; i--)
> +				unqueue_me(&qs[i]);
> +
> +			__set_current_state(TASK_RUNNING);
> +			if (ret > 0)
> +				goto retry;
> +			goto out;
> +		}
> +
> +		/* We can't hold to the bucket lock when dealing with
> +		 * the next futex. Queue ourselves now so we can unlock
> +		 * it before moving on.
> +		 */

(broken comment style)

> +		queue_me(&qs[i], hb);
> +	}
> +
> +	if (to)
> +		hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
> +
> +	/* There is no easy to way to check if we are wake already on
> +	 * multiple futexes without waking through each one of them.  So
> +	 * just sleep and let the scheduler handle it.
> +	 */

(broken comment style)

> +	if (!to || to->task)
> +		freezable_schedule();
> +
> +	__set_current_state(TASK_RUNNING);
> +
> +	ret = -ETIMEDOUT;
> +	/* If we were woken (and unqueued), we succeeded. */
> +	for (i = 0; i < count; i++)
> +		if (!unqueue_me(&qs[i]))
> +			ret = i;

(missing {})

> +
> +	/* Succeed wakeup */
> +	if (ret >= 0)
> +		goto out;
> +
> +	/* Woken by triggered timeout */
> +	if (to && !to->task)
> +		goto out;
> +
> +	/*
> +	 * We expect signal_pending(current), but we might be the
> +	 * victim of a spurious wakeup as well.
> +	 */

(curiously correct comment style -- which makes the patch
self-inconsistent)

> +	if (!signal_pending(current))
> +		goto retry;

I think that if you invest in a few helper functions; the above can be
reduced and written more like a normal wait loop.

> +
> +	ret = -ERESTARTSYS;
> +	if (!abs_time)
> +		goto out;
> +
> +	ret = -ERESTART_RESTARTBLOCK;
> + out:

(wrong label indent)

> +	if (to) {
> +		hrtimer_cancel(&to->timer);
> +		destroy_hrtimer_on_stack(&to->timer);
> +	}
> +
> +	kfree(qs);
> +	return ret;
> +}
> +

distinct lack of function comments

> +static int futex_wait_multiple(u32 __user *uaddr, unsigned int flags,
> +			       u32 count, ktime_t *abs_time)
> +{
> +	struct futex_wait_block *wb;
> +	struct restart_block *restart;
> +	int ret;
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	wb = kcalloc(count, sizeof(struct futex_wait_block), GFP_KERNEL);
> +	if (!wb)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(wb, uaddr,
> +			   count * sizeof(struct futex_wait_block))) {
> +		ret = -EFAULT;
> +		goto out;
> +	}

I'm thinking we can do away with this giant copy and do it one at a time
from the other function, just extend the storage allocated there to
store whatever values are still required later.

Do we want to impose alignment constraints on uaddr?

> +	ret = do_futex_wait_multiple(wb, count, flags, abs_time);
> +
> +	if (ret == -ERESTART_RESTARTBLOCK) {
> +		restart = &current->restart_block;
> +		restart->fn = futex_wait_restart;
> +		restart->futex.uaddr = uaddr;
> +		restart->futex.val = count;
> +		restart->futex.time = *abs_time;
> +		restart->futex.flags = (flags | FLAGS_HAS_TIMEOUT |
> +					FLAGS_WAKE_MULTIPLE);
> +	}
> +
> +out:

(inconsistent correctly indented label)

> +	kfree(wb);
> +	return ret;
> +}
