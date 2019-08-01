Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA56C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA21820B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfHAApn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:45:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33444 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfHAApn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:45:43 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hszDv-0001p4-9m; Thu, 01 Aug 2019 02:45:39 +0200
Date:   Thu, 1 Aug 2019 02:45:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Zebediah Figura <z.figura12@gmail.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Subject: Re: [PATCH RFC 2/2] futex: Implement mechanism to wait on any of
 several futexes
In-Reply-To: <20190730220602.28781-2-krisman@collabora.com>
Message-ID: <alpine.DEB.2.21.1908010039470.1788@nanos.tec.linutronix.de>
References: <20190730220602.28781-1-krisman@collabora.com> <20190730220602.28781-2-krisman@collabora.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019, Gabriel Krisman Bertazi wrote:
> + retry:
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
> +			put_futex_key(&qs[i].key);
> +
> +			/* Undo the partial work we did. */
> +			for (--i; i >= 0; i--)
> +				unqueue_me(&qs[i]);

That lacks a comment why this does not evaluate the return value of
unqueue_me(). If one of the already queued futexes got woken, then it's
debatable whether that counts as success or not. Whatever the decision is
it needs to be documented instead of documenting the obvious.

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
> +		queue_me(&qs[i], hb);
> +	}

Why  does this use two loops and two cleanup loops instead of doing
it in a single one?

> +
> +	/* There is no easy to way to check if we are wake already on
> +	 * multiple futexes without waking through each one of them.  So

waking?

> +	ret = -ERESTARTSYS;
> +	if (!abs_time)
> +		goto out;
> +
> +	ret = -ERESTART_RESTARTBLOCK;
> + out:

There is surely no more convoluted way to write this? That goto above is
just making my eyes bleed. Yes I know where you copied that from and then
removed everthing between the goto and the assignement.

     	ret = abs_time ? -ERESTART_RESTARTBLOCK : -ERESTARTSYS;

would be too simple to read.

Also this is a new interface and there is absolutely no reason to make it
misfeature compatible to FUTEX_WAIT even for the case that this might share
code. Supporting relative timeouts is wrong to begin with and for absolute
timeouts there is no reason to use restartblock.

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
> +
> +	wb = kcalloc(count, sizeof(struct futex_wait_block), GFP_KERNEL);

There are a couple of wrongs here:

  - Lacks a sane upper limit for count. Relying on kcalloc() to fail is
    just wrong.
  
  - kcalloc() does a pointless zeroing for a buffer which is going to be
    overwritten anyway

  - sizeof(struct foo) instead of sizeof(*wb)

count * sizeof(*wb) must be calculated anyway because copy_from_user()
needs it. So using kcalloc() is pointless.

> +	if (!wb)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(wb, uaddr,
> +			   count * sizeof(struct futex_wait_block))) {

And doing the size calculation only once spares that fugly line break.

But that's cosmetic. The way more serious issue is:

How is that supposed to work with compat tasks? 32bit and 64 bit apps do
not share the same pointer size and your UAPI struct is:

> +struct futex_wait_block {
> +	__u32 __user *uaddr;
> +	__u32 val;
> +	__u32 bitset;
> +};

A 64 bit kernel will happily read beyond the user buffer when called from a
32bit task and all struct members turn into garbage. That can be solved
with padding so pointer conversion can be avoided, but you have to be
careful about endianness.

Coming back to to allocation itself:

do_futex_wait_multiple() does another allocation depending on count. So you
call into the memory allocator twice in a row and on the way out you do the
same thing again with free.

Looking at the size constraints.

If I assume a maximum of 65 futexes which got mentioned in one of the
replies then this will allocate 7280 bytes alone for the futex_q array with
a stock debian config which has no debug options enabled which would bloat
the struct. Adding the futex_wait_block array into the same allocation
becomes larger than 8K which already exceeds thelimit of SLUB kmem
caches and forces the whole thing into the page allocator directly.

This sucks.

Also I'm confused about the 64 maximum resulting in 65 futexes comment in
one of the mails.

Can you please explain what you are trying to do exatly on the user space
side?

Thanks,

	tglx

