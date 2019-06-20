Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA751C48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC04E2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfFTWvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 18:51:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53628 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfFTWvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 18:51:03 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1he5tN-00052S-1l; Fri, 21 Jun 2019 00:50:53 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer implementation
References: <20190607162349.18199-1-john.ogness@linutronix.de>
        <20190607162349.18199-2-john.ogness@linutronix.de>
        <20190618112237.GP3436@hirez.programming.kicks-ass.net>
        <87a7eebk71.fsf@linutronix.de> <20190619104655.GA6668@andrea>
Date:   Fri, 21 Jun 2019 00:50:45 +0200
In-Reply-To: <20190619104655.GA6668@andrea> (Andrea Parri's message of "Wed,
        19 Jun 2019 12:46:55 +0200")
Message-ID: <87fto327ne.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-19, Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
>> I would appreciate it if you could point out a source file that
>> documents its memory barriers the way you would like to see these memory
>> barriers documented.
>
> IMO, you could find some inspiration by looking at the memory barriers
> comments from:
>
>   kernel/sched/core.c:try_to_wake_up()
>   include/linux/wait.h:waitqueue_active()
>   kernel/futex.c [header _and inline annotations]
>
> I'll detail a single example here, and then conclude with some general
> guidelines:
>
> ---
> [from kernel/sched/rt.c]
>
> static inline void rt_set_overload(struct rq *rq)
> {
> 	if (!rq->online)
> 		return;
>
> 	cpumask_set_cpu(rq->cpu, rq->rd->rto_mask);
> 	/*
> 	 * Make sure the mask is visible before we set
> 	 * the overload count. That is checked to determine
> 	 * if we should look at the mask. It would be a shame
> 	 * if we looked at the mask, but the mask was not
> 	 * updated yet.
> 	 *
> 	 * Matched by the barrier in pull_rt_task().
> 	 */
> 	smp_wmb();
> 	atomic_inc(&rq->rd->rto_count);
> }
>
> static void pull_rt_task(struct rq *this_rq)
> {
> 	int this_cpu = this_rq->cpu, cpu;
> 	bool resched = false;
> 	struct task_struct *p;
> 	struct rq *src_rq;
> 	int rt_overload_count = rt_overloaded(this_rq);
>
> 	if (likely(!rt_overload_count))
> 		return;
>
> 	/*
> 	 * Match the barrier from rt_set_overloaded; this guarantees that if we
> 	 * see overloaded we must also see the rto_mask bit.
> 	 */
> 	smp_rmb();
>
> 	/* If we are the only overloaded CPU do nothing */
> 	if (rt_overload_count == 1 &&
> 	    cpumask_test_cpu(this_rq->cpu, this_rq->rd->rto_mask))
> 		return;
>
> 	[...]
>
> }
> ---
>
> Notice that the comments provide the following information: for _each_
> memory barrier primitive,
>
>   1) the _memory accesses_ being ordered
>
>      the store to ->rto_mask and the store to ->rto_count for the smp_wmb()
>      the load from ->rto_count and the from ->rto_mask for the smp_rmb()
>
>   2) the _matching barrier_ (and its location)
>
>   3) an informal description of the _underlying guarantee(s)_  (c.f.,
>      "if we see overloaded we must also see the rto_mask bit").
>
> One can provide this information by embedding some snippet/pseudo-code
> in its comments as illustrated in the examples pointed out above.
>
> I'd suggest to _not be stingy with memory barriers explanations:  this
> eases/makes it possible the review itself as well as future changes or
> fixes to the implementation.

Thank you for the specific examples and explanations. I need to frame
your email and hang it next to my monitor for reference.

> FWIW (and as anticipated time ago in a private email), when I see code
> like this I tend to look elsewhere...  ;-/

Do you really mean "code" or are you just referring to "code comments"?
If you really mean code, then I'd appreciate some feedback about what
should change.

Your private email helped me a great deal. The memory barrier work in v2
is vastly superior to v1, even if it still crap in your eyes. I
appreciate you continuing to support me on this.

John Ogness
