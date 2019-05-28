Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A8DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8832620989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfE1UHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:07:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51858 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfE1UHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:07:44 -0400
Received: from 50-233-100-202-static.hfc.comcastbusiness.net ([50.233.100.202] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hViNn-00076L-PK; Tue, 28 May 2019 22:07:40 +0200
Date:   Tue, 28 May 2019 13:07:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     fweisbec@gmail.com, mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline() lockdep
 complaint
In-Reply-To: <20190527143932.GA10527@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1905281300340.1859@nanos.tec.linutronix.de>
References: <20190527143932.GA10527@linux.ibm.com>
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

On Mon, 27 May 2019, Paul E. McKenney wrote:

> The TASKS03 and TREE04 rcutorture scenarios produce the following
> lockdep complaint:
> 
> ================================
> WARNING: inconsistent lock state
> 5.2.0-rc1+ #513 Not tainted
> --------------------------------
> inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> migration/1/14 [HC0[0]:SC0[0]:HE1:SE1] takes:
> (____ptrval____) (tick_broadcast_lock){?...}, at: tick_broadcast_offline+0xf/0x70
> {IN-HARDIRQ-W} state was registered at:
>   lock_acquire+0xb0/0x1c0
>   _raw_spin_lock_irqsave+0x3c/0x50
>   tick_broadcast_switch_to_oneshot+0xd/0x40
>   tick_switch_to_oneshot+0x4f/0xd0
>   hrtimer_run_queues+0xf3/0x130
>   run_local_timers+0x1c/0x50
>   update_process_times+0x1c/0x50
>   tick_periodic+0x26/0xc0
>   tick_handle_periodic+0x1a/0x60
>   smp_apic_timer_interrupt+0x80/0x2a0
>   apic_timer_interrupt+0xf/0x20
>   _raw_spin_unlock_irqrestore+0x4e/0x60
>   rcu_nocb_gp_kthread+0x15d/0x590
>   kthread+0xf3/0x130
>   ret_from_fork+0x3a/0x50
> irq event stamp: 171
> hardirqs last  enabled at (171): [<ffffffff8a201a37>] trace_hardirqs_on_thunk+0x1a/0x1c
> hardirqs last disabled at (170): [<ffffffff8a201a53>] trace_hardirqs_off_thunk+0x1a/0x1c
> softirqs last  enabled at (0): [<ffffffff8a264ee0>] copy_process.part.56+0x650/0x1cb0
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(tick_broadcast_lock);
>   <Interrupt>
>     lock(tick_broadcast_lock);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by migration/1/14:
>  #0: (____ptrval____) (clockevents_lock){+.+.}, at: tick_offline_cpu+0xf/0x30
> 
> stack backtrace:
> CPU: 1 PID: 14 Comm: migration/1 Not tainted 5.2.0-rc1+ #513
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Bochs 01/01/2011
> Call Trace:
>  dump_stack+0x5e/0x8b
>  print_usage_bug+0x1fc/0x216
>  ? print_shortest_lock_dependencies+0x1b0/0x1b0
>  mark_lock+0x1f2/0x280
>  __lock_acquire+0x1e0/0x18f0
>  ? __lock_acquire+0x21b/0x18f0
>  ? _raw_spin_unlock_irqrestore+0x4e/0x60
>  lock_acquire+0xb0/0x1c0
>  ? tick_broadcast_offline+0xf/0x70
>  _raw_spin_lock+0x33/0x40
>  ? tick_broadcast_offline+0xf/0x70
>  tick_broadcast_offline+0xf/0x70
>  tick_offline_cpu+0x16/0x30
>  take_cpu_down+0x7d/0xa0
>  multi_cpu_stop+0xa2/0xe0
>  ? cpu_stop_queue_work+0xc0/0xc0
>  cpu_stopper_thread+0x6d/0x100
>  smpboot_thread_fn+0x169/0x240
>  kthread+0xf3/0x130
>  ? sort_range+0x20/0x20
>  ? kthread_cancel_delayed_work_sync+0x10/0x10
>  ret_from_fork+0x3a/0x50
> 
> It turns out that tick_broadcast_offline() can be invoked with interrupts
> enabled, so this commit fixes this issue by replacing the raw_spin_lock()
> with raw_spin_lock_irqsave().

What?

take_cpu_down() is called from multi_cpu_stop() with interrupts disabled.

So this is just papering over the fact that something called from
take_cpu_down() enabled interrupts. That needs to be found and fixed.

Thanks,

	tglx
