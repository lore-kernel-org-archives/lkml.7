Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF296C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05712089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfFGQJB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:09:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50519 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfFGQJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:09:01 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hZHQH-0000Oa-Iw; Fri, 07 Jun 2019 18:08:57 +0200
Date:   Fri, 7 Jun 2019 18:08:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: Review of RCU-related patches in -rt
Message-ID: <20190607160857.nsxkrytedyfroxf3@linutronix.de>
References: <20190528205030.GA27149@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190528205030.GA27149@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-28 13:50:30 [-0700], Paul E. McKenney wrote:
> Hello, Sebastian,
Hi Paul,

> Finally getting around to taking another look:
> 
> c7e07056a108 EXP rcu: skip the workqueue path on RT
> 
> 	This one makes sense given the later commit setting the
> 	rcu_normal_after_boot kernel parameter.  Otherwise, it is
> 	slowing down expedited grace periods for no reason.  But
> 	should the check also include rcu_normal_after_boot and
> 	rcu_normal?  For example:
> 
> 		if ((IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
> 		     (rcu_normal || rcu_normal_after_boot) ||
> 		    !READ_ONCE(rcu_par_gp_wq) ||
> 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
> 		    rcu_is_last_leaf_node(rnp)) {

I recently dropped that patch from the queue because the workqueue
problem vanished.

> 	Alternatively, one approach would be to take the kernel
> 	parameters out in -rt:
> 
> 		static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
> 		#ifndef CONFIG_PREEMPT_RT_FULL
> 		module_param(rcu_normal_after_boot, int, 0);
> 		#endif
> 
> 	And similar for rcu_normal and rcu_expedited.

This makes sense.

> 	Or is there some reason to allow run-time expedited grace
> 	periods in CONFIG_PREEMPT_RT_FULL=y kernels?

No, I doubt there is any need to use the `expedited' version. The
problem is that it increases latencies.

> d1f52391bd8a rcu: Disable RCU_FAST_NO_HZ on RT
> 
> 	Looks good.  More complexity could be added if too many people
> 	get themselves in trouble via "select RCU_FAST_NO_HZ".

That patch disables RCU_FAST_NO_HZ and claims that it has something to
do with a timer_list timer and IRQ-off section. We couldn't schedule
timers from IRQ-off regions but not anymore. Only del_timer_sync() can't
be invoked from IRQ-off regions.
I just booted a box with this enabled together with NO_HZ/ NO_HZ_FULL
and I not complains yet. So I might drop that…

> 42b346870326 rcu: make RCU_BOOST default on RT
> 
> 	To avoid complaints about this showing up when people don't
> 	expected, could you please instead "select RCU_BOOST" in
> 	the Kconfig definition of PREEMPT_RT_FULL?
> 
> 	Or do people really want to be able to disable boosting?

I have no idea. I guess most people don't know what it does and stay
with the default. It become default on RT once a few people complained
that they run OOM during boot on some "memory contrained systems". That
option avoided it.
So yes, will make it depend on RT.

> 457c1b0d9c0e sched: Do not account rcu_preempt_depth on RT in might_sleep()
> 
> 	The idea behind this one is to avoid false-positive complaints
> 	about -rt's sleeping spinlocks, correct?

Correct. Maybe we could invoke a different schedule() primitiv so RCU is
aware that this is a sleeping spinlock and not a regular sleeping lock.

> 7ee13e640b01 rbtree: don't include the rcu header
> c9b0c9b87081 rtmutex: annotate sleeping lock context
> 
> 	No specific comments.
> 
> 7912d002ebf9 rcu: Eliminate softirq processing from rcutree
> 
> 	This hasn't caused any problems in -rcu from what I can see.
> 	I am therefore planning to submit the -rcu variant of this to
> 	mainline during the next merge window.

wonderful.

> f06d34ebdbbb srcu: Remove srcu_queue_delayed_work_on()
> 
> 	Looks plausible.  I will check more carefully for mainline.

Hmmm. I though this was already upstream.
That said, we can now schedule work from a preempt_disable() section but
I still like the negative diffstat here :)

> aeb04e894cc9 srcu: replace local_irqsave() with a locallock
> e48989b033ad irqwork: push most work into softirq context
> 
> 	These look to still be -rt only.

I might get rid of the local_lock in srcu. Will have to check.

Thank you Paul.

> 							Thanx, Paul

Sebastian
