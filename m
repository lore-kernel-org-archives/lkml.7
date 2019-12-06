Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E830C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC1924679
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575658332;
	bh=6MslA0G9d2mkJX5HjO2oRLRV6mBYmWeHXVt0lz47ZKI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=rKL+qOXCp0BtuxMFHGgor1ijdlKxhF4iP4n94fqcZ0nbdLQCvxuaDzo6BrLaawrX1
	 uIIKkeFzIJeKiTPl6DYUlGFEYqf8mIgeixzQ6rMsnxpdU33uwYtFwP2KxlmTpgsFtG
	 rGBC81Teoj3uqZYdO8CLIuumxrlglSOIvkPBIl58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLFSwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:52:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfLFSwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:52:10 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13474206DF;
        Fri,  6 Dec 2019 18:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575658329;
        bh=6MslA0G9d2mkJX5HjO2oRLRV6mBYmWeHXVt0lz47ZKI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LpKUDyboUSg+jDJz5EbK6kTnYJXxCYSY3uhxQbbEjMzMkfvtWM6WYVxNMzhXP830F
         /cdFuy5ztmHyPY1yqjR7XeepkOQiwSt+8NG4LH5T3OamrmcVQAYbXwFTxvvUMvgePL
         1sMpCze0B9qTGBXbEen4TFbiuOOu1zl1csr4u8FU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DF12135206AB; Fri,  6 Dec 2019 10:52:08 -0800 (PST)
Date:   Fri, 6 Dec 2019 10:52:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191206185208.GA25636@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191203095521.GH2827@hirez.programming.kicks-ass.net>
 <20191204201150.GA14040@paulmck-ThinkPad-P72>
 <20191205102928.GG2810@hirez.programming.kicks-ass.net>
 <20191205103213.GB2871@hirez.programming.kicks-ass.net>
 <20191205144805.GR2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205144805.GR2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 06:48:05AM -0800, Paul E. McKenney wrote:
> On Thu, Dec 05, 2019 at 11:32:13AM +0100, Peter Zijlstra wrote:
> > On Thu, Dec 05, 2019 at 11:29:28AM +0100, Peter Zijlstra wrote:
> > > On Wed, Dec 04, 2019 at 12:11:50PM -0800, Paul E. McKenney wrote:
> > > 
> > > > And the good news is that I didn't see the workqueue splat, though my
> > > > best guess is that I had about a 13% chance of not seeing it due to
> > > > random chance (and I am currently trying an idea that I hope will make
> > > > it more probable).  But I did get a couple of new complaints about RCU
> > > > being used illegally from an offline CPU.  Splats below.
> > > 
> > > Shiny!
> 
> And my attempt to speed things up did succeed, but the success was limited
> to finding more places where rcutorture chokes on CPUs being slow to boot.
> Fixing those and trying again...

And I finally did manage to get a clean run.  There are probably a few
more things that a large slow-booting hyperthreaded system can do to
confuse rcutorture, but it is at least down to a dull roar.

> > > > Your patch did rearrange the CPU-online sequence, so let's see if I
> > > > can piece things together...
> > > > 
> > > > RCU considers a CPU to be online at rcu_cpu_starting() time.  This is
> > > > called from notify_cpu_starting(), which is called from the arch-specific
> > > > CPU-bringup code.  Any RCU readers before rcu_cpu_starting() will trigger
> > > > the warning I am seeing.
> > > 
> > > Right.
> > > 
> > > > The original location of the stop_machine_unpark() was in
> > > > bringup_wait_for_ap(), which is called from bringup_cpu(), which is in
> > > > the CPUHP_BRINGUP_CPU entry of cpuhp_hp_states[].  Which, if I am not
> > > > too confused, is invoked by some CPU other than the to-be-incoming CPU.
> > > 
> > > Correct.
> > > 
> > > > The new location of the stop_machine_unpark() is in cpuhp_online_idle(),
> > > > which is called from cpu_startup_entry(), which is invoked from
> > > > the arch-specific bringup code that runs on the incoming CPU.
> > > 
> > > The new place is the final piece of bringup, it is right before where
> > > the freshly woken CPU will drop into the idle loop and start scheduling
> > > (for the first time).
> > > 
> > > > Which
> > > > is the same code that invokes notify_cpu_starting(), so we need
> > > > notify_cpu_starting() to be invoked before cpu_startup_entry().
> > > 
> > > Right, that is right before we run what used to be the CPU_STARTING
> > > notifiers. This is in fact (on x86) before the CPU is marked
> > > cpu_online(). It has to be before cpu_startup_entry(), before this is
> > > ran with IRQs disabled, while cpu_startup_entry() demands IRQs are
> > > enabled.
> > > 
> > > > The order is not immediately obvious on IA64.  But it looks like
> > > > everything else does it in the required order, so I am a bit confused
> > > > about this.
> > > 
> > > That makes two of us, afaict we have RCU up and running when we get to
> > > the idle loop.
> > 
> > Or did we need rcutree_online_cpu() to have ran? Because that is ran
> > much later than this...
> 
> No, rcu_cpu_starting() does the trick.  So I remain confused.
> 
> My thought is to add some printk()s or tracing to rcu_cpu_starting()
> and its counterpart, rcu_report_dead().  But is there a better way?

And the answer is...

This splat happens even without your fix!

Which goes a long way to explaining why neither of us could figure out
how your fix could have caused it.  It apparently was the increased
stress required to reproduce quickly rather than your fix that made it
happen more frequently.  Though there are few enough occurrences that
it might just be random chance.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

[   98.468097] =============================
[   98.468097] WARNING: suspicious RCU usage
[   98.468098] 5.4.0-rc1+ #128 Not tainted
[   98.468099] -----------------------------
[   98.468099] kernel/sched/fair.c:6458 suspicious rcu_dereference_check() usage!
[   98.468099] 
[   98.468100] other info that might help us debug this:
[   98.468100] 
[   98.468101] 
[   98.468101] RCU used illegally from offline CPU!
[   98.468102] rcu_scheduler_active = 2, debug_locks = 1
[   98.468105] 3 locks held by swapper/1/0:
[   98.468107]  #0: ffffffff91462958 ((console_sem).lock){-.-.}, at: up+0xd/0x50
[   98.468120]  #1: ffff9dc89ecd87c0 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x51/0x980
[   98.468131]  #2: ffffffff914647e0 (rcu_read_lock){....}, at: select_task_rq_fair+0xdb/0x12f0
[   98.468161] initcall init_netconsole+0x0/0x21a returned 0 after 470496 usecs
[   98.468164] 
[   98.468167] stack backtrace:
[   98.468169] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.4.0-rc1+ #128
[   98.468172] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[   98.468177] Call Trace:
[   98.468178]  dump_stack+0x5e/0x8b
[   98.468178]  select_task_rq_fair+0x8ef/0x12f0
[   98.468179]  ? select_task_rq_fair+0xdb/0x12f0
[   98.468179]  ? try_to_wake_up+0x51/0x980
[   98.468180]  try_to_wake_up+0x171/0x980
[   98.468180]  up+0x3b/0x50
[   98.468180]  __up_console_sem+0x2e/0x50
[   98.468181]  console_unlock+0x3eb/0x5a0
[   98.468181]  ? console_unlock+0x19d/0x5a0
[   98.468182]  vprintk_emit+0xfc/0x2c0
[   98.468182]  printk+0x53/0x6a
[   98.468182]  ? slow_virt_to_phys+0x22/0x120
[   98.468183]  start_secondary+0x41/0x190
[   98.468183]  secondary_startup_64+0xa4/0xb0
[   98.468183] 
[   98.468184] =============================
[   98.468184] WARNING: suspicious RCU usage
[   98.468185] 5.4.0-rc1+ #128 Not tainted
[   98.468185] -----------------------------
[   98.468185] kernel/sched/fair.c:6010 suspicious rcu_dereference_check() usage!
[   98.468186] 
[   98.468186] other info that might help us debug this:
[   98.468187] 
[   98.468187] 
[   98.468187] RCU used illegally from offline CPU!
[   98.468188] rcu_scheduler_active = 2, debug_locks = 1
[   98.468188] 3 locks held by swapper/1/0:
[   98.468189]  #0: ffffffff91462958 ((console_sem).lock){-.-.}, at: up+0xd/0x50
[   98.468191]  #1: ffff9dc89ecd87c0 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x51/0x980
[   98.468193]  #2: ffffffff914647e0 (rcu_read_lock){....}, at: select_task_rq_fair+0xdb/0x12f0
[   98.468195] 
[   98.468195] stack backtrace:
[   98.468196] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.4.0-rc1+ #128
[   98.468196] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[   98.468197] Call Trace:
[   98.468197]  dump_stack+0x5e/0x8b
[   98.468197]  select_task_rq_fair+0x967/0x12f0
[   98.468198]  ? select_task_rq_fair+0xdb/0x12f0
[   98.468198]  ? try_to_wake_up+0x51/0x980
[   98.468199]  try_to_wake_up+0x171/0x980
[   98.468199]  up+0x3b/0x50
[   98.468199]  __up_console_sem+0x2e/0x50
[   98.468200]  console_unlock+0x3eb/0x5a0
[   98.468200]  ? console_unlock+0x19d/0x5a0
[   98.468201]  vprintk_emit+0xfc/0x2c0
[   98.468201]  printk+0x53/0x6a
[   98.468201]  ? slow_virt_to_phys+0x22/0x120
[   98.468202]  start_secondary+0x41/0x190
[   98.468202]  secondary_startup_64+0xa4/0xb0
