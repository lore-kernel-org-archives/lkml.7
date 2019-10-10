Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AB5C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C8E2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I5hOwypd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbfJJLmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 07:42:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59014 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJJLmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 07:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NNV7t7BAd9KEmyeOOUHgb5/9NM7ZBVzz5Jl8ooP5ENo=; b=I5hOwypdIHjHVE5NL8CZTslIzT
        i/2tFxaaxqpj5Hu+ir4eahSOdtimJJZhGdVTiV8DJWZpf7Lm8pV9tYE583Q/j4XUFMuMrCHFiIAJn
        jzaA3TYWQQ4W5A2WmlAtMamxboplfO4ayKz38mdkg6qOllowEBBInrslz9CUSL2wBcbpZSGNtXsI6
        eeU6fqNQ/rhuhDtnkOCJsJzlFY51CN0YptvMQJvZGixfs2mlqNVLcjvyY6tYnK8sMq23nHc3L7zNT
        RGtGu6HsiZct2K8W+aAyARXFQoZfp6zKKU7hJadIJEQWDmlrvp/X4mTWM28OZFhz651f0q4qGetgp
        QAca2WWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIWqG-0006np-0F; Thu, 10 Oct 2019 11:42:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B19E8301224;
        Thu, 10 Oct 2019 13:41:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E647B205A4300; Thu, 10 Oct 2019 13:42:44 +0200 (CEST)
Date:   Thu, 10 Oct 2019 13:42:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        1vier1@web.de, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: wake_q memory ordering
Message-ID: <20191010114244.GS2311@hirez.programming.kicks-ass.net>
References: <990690aa-8281-41da-4a46-99bb8f9fec31@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <990690aa-8281-41da-4a46-99bb8f9fec31@colorfullife.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 12:41:11PM +0200, Manfred Spraul wrote:
> Hi,
> 
> Waiman Long noticed that the memory barriers in sem_lock() are not really
> documented, and while adding documentation, I ended up with one case where
> I'm not certain about the wake_q code:
> 
> Questions:
> - Does smp_mb__before_atomic() + a (failed) cmpxchg_relaxed provide an
>   ordering guarantee?

Yep. Either the atomic instruction implies ordering (eg. x86 LOCK
prefix) or it doesn't (most RISC LL/SC), if it does,
smp_mb__{before,after}_atomic() are a NO-OP and the ordering is
unconditinoal, if it does not, then smp_mb__{before,after}_atomic() are
unconditional barriers.

IOW, the only way to get a cmpxchg without barriers on failure, is with
LL/SC, and in that case smp_mb__{before,after}_atomic() are
unconditional.

For instance, the way ARM64 does cmpxchg() is:

cmpxchg(p, o, n)
	do {
		v = LL(p);
		if (v != o)
			return v;
	} while (!SC_RELEASE(p, n))
	smp_mb();
	return v;

And you'll note how on success the store-release constraints all prior
memory operations, and the smp_mb() constraints all later memops. But on
failure there's not a barrier to be found.

> - Is it ok that wake_up_q just writes wake_q->next, shouldn't
>   smp_store_acquire() be used? I.e.: guarantee that wake_up_process()
>   happens after cmpxchg_relaxed(), assuming that a failed cmpxchg_relaxed
>   provides any ordering.

There is no such thing as store_acquire, it is either load_acquire or
store_release. But just like how we can write load-aquire like
load+smp_mb(), so too I suppose we could write store-acquire like
store+smp_mb(), and that is exactly what is there (through the implied
barrier of wake_up_process()).

(arguably it should've been WRITE_ONCE() I suppose)

> 
> Example:
> - CPU2 never touches lock a. It is just an unrelated wake_q user that also
>   wants to wake up task 1234.
> - I've noticed already that smp_store_acquire() doesn't exist.
>   So smp_store_mb() is required. But from semantical point of view, we would
>   need an ACQUIRE: the wake_up_process() must happen after cmpxchg().
> - May wake_up_q() rely on the spinlocks/memory barriers in try_to_wake_up,
>   or should the function be safe by itself?
> 
> CPU1: /current=1234, inside do_semtimedop()/
>         g_wakee = current;
>         current->state = TASK_INTERRUPTIBLE;
>         spin_unlock(a);
> 
> CPU2: / arbitrary kernel thread that uses wake_q /
>                 wake_q_add(&unrelated_q, 1234);
>                 wake_up_q(&unrelated_q);
>                 <...ongoing>
> 
> CPU3: / do_semtimedop() + wake_up_sem_queue_prepare() /
>                         spin_lock(a);
>                         wake_q_add(,g_wakee);
>                         < within wake_q_add() >:
>                           smp_mb__before_atomic();
>                           if (unlikely(cmpxchg_relaxed(&node->next, NULL,
> WAKE_Q_TAIL)))
>                               return false; /* -> this happens */
> 
> CPU2:
>                 <within wake_up_q>
>                 1234->wake_q.next = NULL; <<<<<<<<< Ok? Is store_acquire()
> missing? >>>>>>>>>>>>

		/* smp_mb(); implied by the following wake_up_process() */

>                 wake_up_process(1234);
>                 < within wake_up_process/try_to_wake_up():
>                     raw_spin_lock_irqsave()
>                     smp_mb__after_spinlock()
>                     if(1234->state = TASK_RUNNING) return;
>                  >
> 
> 
> rewritten:
> 
> start condition: A = 1; B = 0;
> 
> CPU1:
>     B = 1;
>     RELEASE, unlock LockX;
> 
> CPU2:
>     lock LockX, ACQUIRE
>     if (LOAD A == 1) return; /* using cmp_xchg_relaxed */
> 
> CPU2:
>     A = 0;
>     ACQUIRE, lock LockY
>     smp_mb__after_spinlock();
>     READ B
> 
> Question: is A = 1, B = 0 possible?

Your example is incomplete (there is no A=1 assignment for example), but
I'm thinking I can guess where that should go given the earlier text.

I don't think this is broken.

