Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566CAC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37179216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfFZNyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:54:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48190 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZNyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:54:53 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hg8Nr-0002Wo-EX; Wed, 26 Jun 2019 15:54:47 +0200
Date:   Wed, 26 Jun 2019 15:54:47 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

one of my boxes boots with "threadirqs" and since commit 05f415715ce45
("rcu: Speed up expedited GPs when interrupting RCU reader") I run
reliably into the following deadlock:

| ============================================
| WARNING: possible recursive locking detected
| 5.2.0-rc6 #279 Not tainted
| --------------------------------------------
| (cron)/2109 is trying to acquire lock:
| 0000000088464daa (&p->pi_lock){-.-.}, at: try_to_wake_up+0x37/0x700
|
| but task is already holding lock:
| 0000000088464daa (&p->pi_lock){-.-.}, at: try_to_wake_up+0x37/0x700
|
| other info that might help us debug this:
|  Possible unsafe locking scenario:
|
|        CPU0
|        ----
|   lock(&p->pi_lock);  
|   lock(&p->pi_lock);  
|
|  *** DEADLOCK ***
|
|  May be due to missing lock nesting notation
|
| 4 locks held by (cron)/2109:
|  #0: 00000000c0ae63d9 (&sb->s_type->i_mutex_key){++++}, at: iterate_dir+0x3d/0x170
|  #1: 0000000088464daa (&p->pi_lock){-.-.}, at: try_to_wake_up+0x37/0x700
|  #2: 00000000f62f14cf (&rq->lock){-.-.}, at: try_to_wake_up+0x209/0x700
|  #3: 000000000d32568e (rcu_read_lock){....}, at: cpuacct_charge+0x37/0x1e0
|
| stack backtrace:
| CPU: 3 PID: 2109 Comm: (cron) Not tainted 5.2.0-rc6 #279
| Call Trace:
|  <IRQ>
|  dump_stack+0x67/0x90 
|  __lock_acquire.cold.63+0x142/0x23a
|  lock_acquire+0x9b/0x1a0
|  ? try_to_wake_up+0x37/0x700
|  _raw_spin_lock_irqsave+0x33/0x50
|  ? try_to_wake_up+0x37/0x700
|  try_to_wake_up+0x37/0x700
wake up ksoftirqd

|  rcu_read_unlock_special+0x61/0xa0
|  __rcu_read_unlock+0x58/0x60
|  cpuacct_charge+0xeb/0x1e0
|  update_curr+0x15d/0x350
|  enqueue_entity+0x115/0x7e0
|  enqueue_task_fair+0x78/0x450
|  activate_task+0x41/0x90
|  ttwu_do_activate+0x49/0x80
|  try_to_wake_up+0x23f/0x700

wake up ksoftirqd

|  irq_exit+0xba/0xc0   
|  smp_apic_timer_interrupt+0xb2/0x2a0
|  apic_timer_interrupt+0xf/0x20
|  </IRQ>

based one the commit it seems the problem was always there but now the
mix of raise_softirq_irqoff() and set_tsk_need_resched() seems to hit
the window quite reliably. Replacing it with 

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1102765f91fd1..baab36f4d0f45 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -627,14 +627,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
        if (preempt_bh_were_disabled || irqs_were_disabled) {
                WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
                /* Need to defer quiescent state until everything is enabled. */
-               if (irqs_were_disabled) {
-                       /* Enabling irqs does not reschedule, so... */
-                       raise_softirq_irqoff(RCU_SOFTIRQ);
-               } else {
-                       /* Enabling BH or preempt does reschedule, so... */
-                       set_tsk_need_resched(current);
-                       set_preempt_need_resched();
-               }
+               raise_softirq_irqoff(RCU_SOFTIRQ);
                local_irq_restore(flags);
                return;
        }

will make it go away.
Any suggestions?

Sebastian
