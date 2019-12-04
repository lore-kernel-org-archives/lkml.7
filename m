Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6B8C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94284207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575490314;
	bh=D4qpTGsQMbDNFhhQsZp5ti9x/D9bkd0fXg2P7gm9mvQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=RGojZ+KwzU/9TspbwxtNHupQT8RJ6NNofd23kNBFSkjJheL2TL2UxlCzB1onZQ4ib
	 5LxMAzC8zHGzMsaGMrND5eBDSQY3ptdVSgp9WwPiX7s5cahywHhvCI5byya6Tg4mtt
	 1pwJe5IFSjvA2/qd8zjd5oyADqZA6RvgKAH/GdN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfLDULx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfLDULx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:11:53 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0D3F2077B;
        Wed,  4 Dec 2019 20:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575490311;
        bh=D4qpTGsQMbDNFhhQsZp5ti9x/D9bkd0fXg2P7gm9mvQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IoN9ktSE/iEfZlt9g8/RU5+R/BFg0SXkX8YK3vwvQ/VjSds2xfIajHWtTZPuxdV3r
         2Y0Lu0frY7Zvo4LDrvD1SP7o76buKmL0UIvV8SoDGtqXPsxJocqhrQKPtnXuF6zmA6
         2LK+Zdk6423brDliZM46Cg8VLUKcuHhPrgbL1BWk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F1C223520BAE; Wed,  4 Dec 2019 12:11:50 -0800 (PST)
Date:   Wed, 4 Dec 2019 12:11:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191204201150.GA14040@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191125230312.GP2889@paulmck-ThinkPad-P72>
 <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191203095521.GH2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203095521.GH2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:55:21AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 02, 2019 at 12:13:38PM -0800, Tejun Heo wrote:
> > Hello, Paul.
> > 
> > (cc'ing scheduler folks - workqueue rescuer is very occassionally
> > triggering a warning which says that it isn't on the cpu it should be
> > on under rcu cpu hotplug torture test.  It's checking smp_processor_id
> > is the expected one after a successful set_cpus_allowed_ptr() call.)
> > 
> > On Sun, Dec 01, 2019 at 05:55:48PM -0800, Paul E. McKenney wrote:
> > > > And hyperthreading seems to have done the trick!  One splat thus far,
> > > > shown below.  The run should complete this evening, Pacific Time.
> > > 
> > > That was the only one for that run, but another 24*56-hour run got three
> > > more.  All of them expected to be on CPU 0 (which never goes offline, so
> > > why?) and the "XXX" diagnostic never did print.
> > 
> > Heh, I didn't expect that, so maybe set_cpus_allowed_ptr() is
> > returning 0 while not migrating the rescuer task to the target cpu for
> > some reason?
> > 
> > The rescuer is always calling to migrate itself, so it must always be
> > running.  set_cpus_allowed_ptr() migrates live ones by calling
> > stop_one_cpu() which schedules a migration function which runs from a
> > highpri task on the target cpu.  Please take a look at the following.
> > 
> >   static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
> >   {
> >           ...
> > 	  enabled = stopper->enabled;
> > 	  if (enabled)
> > 		  __cpu_stop_queue_work(stopper, work, &wakeq);
> > 	  else if (work->done)
> > 		  cpu_stop_signal_done(work->done);
> >           ...
> >   }
> > 
> > So, if stopper->enabled is clear, it'll signal completion without
> > running the work.
> 
> Is there ever a valid case for this? That is, why isn't that a WARN()?
> 
> > stopper->enabled is cleared during cpu hotunplug
> > and restored from bringup_cpu() while cpu is being brought back up.
> > 
> >   static int bringup_wait_for_ap(unsigned int cpu)
> >   {
> >           ...
> > 	  stop_machine_unpark(cpu);
> >           ....
> >   }
> > 
> >   static int bringup_cpu(unsigned int cpu)
> >   {
> > 	  ...
> > 	  ret = __cpu_up(cpu, idle);
> >           ...
> > 	  return bringup_wait_for_ap(cpu);
> >   }
> > 
> > __cpu_up() is what marks the cpu online and once the cpu is online,
> > kthreads are free to migrate into the cpu, so it looks like there's a
> > brief window where a cpu is marked online but the stopper thread is
> > still disabled meaning that a kthread may schedule into the cpu but
> > not out of it, which would explain the symptom that you were seeing.
> 
> Yes.
> 
> > It could be that I'm misreading the code.  What do you guys think?
> 
> The below seems to not insta explode...

And the good news is that I didn't see the workqueue splat, though my
best guess is that I had about a 13% chance of not seeing it due to
random chance (and I am currently trying an idea that I hope will make
it more probable).  But I did get a couple of new complaints about RCU
being used illegally from an offline CPU.  Splats below.

Your patch did rearrange the CPU-online sequence, so let's see if I
can piece things together...

RCU considers a CPU to be online at rcu_cpu_starting() time.  This is
called from notify_cpu_starting(), which is called from the arch-specific
CPU-bringup code.  Any RCU readers before rcu_cpu_starting() will trigger
the warning I am seeing.

The original location of the stop_machine_unpark() was in
bringup_wait_for_ap(), which is called from bringup_cpu(), which is in
the CPUHP_BRINGUP_CPU entry of cpuhp_hp_states[].  Which, if I am not
too confused, is invoked by some CPU other than the to-be-incoming CPU.

The new location of the stop_machine_unpark() is in cpuhp_online_idle(),
which is called from cpu_startup_entry(), which is invoked from
the arch-specific bringup code that runs on the incoming CPU.  Which
is the same code that invokes notify_cpu_starting(), so we need
notify_cpu_starting() to be invoked before cpu_startup_entry().

The order is not immediately obvious on IA64.  But it looks like
everything else does it in the required order, so I am a bit confused
about this.

							Thanx, Paul

> ---
>  kernel/cpu.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index a59cc980adad..9eaedd002f41 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -525,8 +525,7 @@ static int bringup_wait_for_ap(unsigned int cpu)
>  	if (WARN_ON_ONCE((!cpu_online(cpu))))
>  		return -ECANCELED;
>  
> -	/* Unpark the stopper thread and the hotplug thread of the target cpu */
> -	stop_machine_unpark(cpu);
> +	/* Unpark the hotplug thread of the target cpu */
>  	kthread_unpark(st->thread);
>  
>  	/*
> @@ -1089,8 +1088,8 @@ void notify_cpu_starting(unsigned int cpu)
>  
>  /*
>   * Called from the idle task. Wake up the controlling task which brings the
> - * stopper and the hotplug thread of the upcoming CPU up and then delegates
> - * the rest of the online bringup to the hotplug thread.
> + * hotplug thread of the upcoming CPU up and then delegates the rest of the
> + * online bringup to the hotplug thread.
>   */
>  void cpuhp_online_idle(enum cpuhp_state state)
>  {
> @@ -1100,6 +1099,12 @@ void cpuhp_online_idle(enum cpuhp_state state)
>  	if (state != CPUHP_AP_ONLINE_IDLE)
>  		return;
>  
> +	/*
> +	 * Unpark the stopper thread before we start the idle thread; this
> +	 * ensures the stopper is always available.
> +	 */
> +	stop_machine_unpark(smp_processor_id());
> +
>  	st->state = CPUHP_AP_ONLINE_IDLE;
>  	complete_ap_thread(st, true);
>  }

------------------------------------------------------------------------

2019.12.03-08.34.52/SRCU-P.2

[   68.018656] =============================
[   68.018657] WARNING: suspicious RCU usage
[   68.018658] 5.4.0-rc1+ #103 Not tainted
[   68.018658] -----------------------------
[   68.018659] kernel/sched/fair.c:6458 suspicious rcu_dereference_check() usage!
[   68.018671] 
[   68.018671] other info that might help us debug this:
[   68.018672] 
[   68.018672] 
[   68.018672] RCU used illegally from offline CPU!
[   68.018673] rcu_scheduler_active = 2, debug_locks = 1
[   68.018673] 3 locks held by swapper/7/0:
[   68.018674]  #0: ffffffff92262998 ((console_sem).lock){..-.}, at: up+0xd/0x50
[   68.018678]  #1: ffff8d6b5ece87d8 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x51/0x980
[   68.018680]  #2: ffffffff92264f20 (rcu_read_lock){....}, at: select_task_rq_fair+0xdb/0x12f0
[   68.018682] 
[   68.018682] stack backtrace:
[   68.018682] CPU: 7 PID: 0 Comm: swapper/7 Not tainted 5.4.0-rc1+ #103
[   68.018683] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[   68.018683] Call Trace:
[   68.018684]  dump_stack+0x5e/0x8b
[   68.018684]  select_task_rq_fair+0x8e0/0x12f0
[   68.018685]  ? select_task_rq_fair+0xdb/0x12f0
[   68.018685]  ? try_to_wake_up+0x51/0x980
[   68.018686]  try_to_wake_up+0x171/0x980
[   68.018686]  up+0x3b/0x50
[   68.018687]  __up_console_sem+0x2e/0x50
[   68.018687]  console_unlock+0x3eb/0x5a0
[   68.018687]  ? console_unlock+0x19d/0x5a0
[   68.018687]  vprintk_emit+0xfc/0x2c0
[   68.018688]  ? vprintk_emit+0x1fe/0x2c0
[   68.018688]  printk+0x53/0x6a
[   68.018688]  ? slow_virt_to_phys+0x22/0x120
[   68.018689]  start_secondary+0x41/0x190
[   68.018689]  secondary_startup_64+0xa4/0xb0

-----------------

2019.12.03-08.34.52/SRCU-P.5

[   67.313866] =============================
[   67.313867] WARNING: suspicious RCU usage
[   67.313867] 5.4.0-rc1+ #103 Not tainted
[   67.313868] -----------------------------
[   67.313868] kernel/sched/fair.c:6458 suspicious rcu_dereference_check() usage!
[   67.313869] 
[   67.313869] other info that might help us debug this:
[   67.313869] 
[   67.313870] 
[   67.313870] RCU used illegally from offline CPU!
[   67.313871] rcu_scheduler_active = 2, debug_locks = 1
[   67.313871] 3 locks held by swapper/3/0:
[   67.313872]  #0: ffffffffa6862998 ((console_sem).lock){..-.}, at: up+0xd/0x50
[   67.313875]  #1: ffffa3aa1ece87d8 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x51/0x980
[   67.313877]  #2: ffffffffa6864f20 (rcu_read_lock){....}, at: select_task_rq_fair+0xdb/0x12f0
[   67.313879] 
[   67.313879] stack backtrace:
[   67.313880] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.4.0-rc1+ #103
[   67.313880] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[   67.313881] Call Trace:
[   67.313881]  dump_stack+0x5e/0x8b
[   67.313881]  select_task_rq_fair+0x8e0/0x12f0
[   67.313882]  ? select_task_rq_fair+0xdb/0x12f0
[   67.313882]  ? try_to_wake_up+0x51/0x980
[   67.313882]  try_to_wake_up+0x171/0x980
[   67.313883]  up+0x3b/0x50
[   67.313883]  __up_console_sem+0x2e/0x50
[   67.313884]  console_unlock+0x3eb/0x5a0
[   67.313884]  ? console_unlock+0x19d/0x5a0
[   67.313884]  vprintk_emit+0xfc/0x2c0
[   67.313885]  ? vprintk_emit+0x1fe/0x2c0
[   67.313885]  printk+0x53/0x6a
[   67.313885]  ? slow_virt_to_phys+0x22/0x120
[   67.313886]  start_secondary+0x41/0x190
[   67.313886]  secondary_startup_64+0xa4/0xb0
