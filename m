Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B218C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1FB22BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="45YifFRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390182AbfGYQOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:14:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41029 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfGYQOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:14:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGEbp31074789
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:14:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGEbp31074789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071278;
        bh=zgcyJljCzme48yRRppqFQ53HQPRurU26j98fcYAua1Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=45YifFREsmEo+kHl+Wcq5HJcg51vZerMimD3uXpNLgc2VDlbs1GLKZtQMJy3Zi0rT
         EJ67qfoj7CdKir17PaBREh98SF/qaBXj/7FBVn0COXMSHp+i4ck16LrttvQHjPMw9e
         rvGDeu7N4Xwa8whT9I8UQTI2Z3cfNHGWPPzt+X7MnbrPk6fdR/lkBM78saG8fmdja2
         4a3YNL9S228ZYf7ooKxHMnlpPAzCEZ1Q38xP6BN4cw6VyWt4DUHssHE6FVOp38FL/4
         uqIQCfqU9Nf+7exFRVnINXWbsVSQ31UTtvSOyCEKRL3FuIxrkIYODEW6gxolMMhXW0
         Kp+PjB4cLcgKg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGEapT1074785;
        Thu, 25 Jul 2019 09:14:36 -0700
Date:   Thu, 25 Jul 2019 09:14:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-84ec3a0787086fcd25f284f59b3aa01fd6fc0a5d@git.kernel.org>
Cc:     hpa@zytor.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, paulmck@linux.ibm.com,
        mingo@kernel.org, peterz@infradead.org, frederic@kernel.org,
        tglx@linutronix.de
Reply-To: paulmck@linux.ibm.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
          peterz@infradead.org, mingo@kernel.org, frederic@kernel.org
In-Reply-To: <20190625165238.GJ26519@linux.ibm.com>
References: <20190625165238.GJ26519@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Git-Commit-ID: 84ec3a0787086fcd25f284f59b3aa01fd6fc0a5d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  84ec3a0787086fcd25f284f59b3aa01fd6fc0a5d
Gitweb:     https://git.kernel.org/tip/84ec3a0787086fcd25f284f59b3aa01fd6fc0a5d
Author:     Paul E. McKenney <paulmck@linux.ibm.com>
AuthorDate: Tue, 25 Jun 2019 09:52:38 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:51:53 +0200

time/tick-broadcast: Fix tick_broadcast_offline() lockdep complaint

time/tick-broadcast: Fix tick_broadcast_offline() lockdep complaint

The TASKS03 and TREE04 rcutorture scenarios produce the following
lockdep complaint:

	WARNING: inconsistent lock state
	5.2.0-rc1+ #513 Not tainted
	--------------------------------
	inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
	migration/1/14 [HC0[0]:SC0[0]:HE1:SE1] takes:
	(____ptrval____) (tick_broadcast_lock){?...}, at: tick_broadcast_offline+0xf/0x70
	{IN-HARDIRQ-W} state was registered at:
	  lock_acquire+0xb0/0x1c0
	  _raw_spin_lock_irqsave+0x3c/0x50
	  tick_broadcast_switch_to_oneshot+0xd/0x40
	  tick_switch_to_oneshot+0x4f/0xd0
	  hrtimer_run_queues+0xf3/0x130
	  run_local_timers+0x1c/0x50
	  update_process_times+0x1c/0x50
	  tick_periodic+0x26/0xc0
	  tick_handle_periodic+0x1a/0x60
	  smp_apic_timer_interrupt+0x80/0x2a0
	  apic_timer_interrupt+0xf/0x20
	  _raw_spin_unlock_irqrestore+0x4e/0x60
	  rcu_nocb_gp_kthread+0x15d/0x590
	  kthread+0xf3/0x130
	  ret_from_fork+0x3a/0x50
	irq event stamp: 171
	hardirqs last  enabled at (171): [<ffffffff8a201a37>] trace_hardirqs_on_thunk+0x1a/0x1c
	hardirqs last disabled at (170): [<ffffffff8a201a53>] trace_hardirqs_off_thunk+0x1a/0x1c
	softirqs last  enabled at (0): [<ffffffff8a264ee0>] copy_process.part.56+0x650/0x1cb0
	softirqs last disabled at (0): [<0000000000000000>] 0x0

        [...]

To reproduce, run the following rcutorture test:

 $ tools/testing/selftests/rcutorture/bin/kvm.sh --duration 5 --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --configs "TASKS03 TREE04"

It turns out that tick_broadcast_offline() was an innocent bystander.
After all, interrupts are supposed to be disabled throughout
take_cpu_down(), and therefore should have been disabled upon entry to
tick_offline_cpu() and thus to tick_broadcast_offline().  This suggests
that one of the CPU-hotplug notifiers was incorrectly enabling interrupts,
and leaving them enabled on return.

Some debugging code showed that the culprit was sched_cpu_dying().
It had irqs enabled after return from sched_tick_stop().  Which in turn
had irqs enabled after return from cancel_delayed_work_sync().  Which is a
wrapper around __cancel_work_timer().  Which can sleep in the case where
something else is concurrently trying to cancel the same delayed work,
and as Thomas Gleixner pointed out on IRC, sleeping is a decidedly bad
idea when you are invoked from take_cpu_down(), regardless of the state
you leave interrupts in upon return.

Code inspection located no reason why the delayed work absolutely
needed to be canceled from sched_tick_stop():  The work is not
bound to the outgoing CPU by design, given that the whole point is
to collect statistics without disturbing the outgoing CPU.

This commit therefore simply drops the cancel_delayed_work_sync() from
sched_tick_stop().  Instead, a new ->state field is added to the tick_work
structure so that the delayed-work handler function sched_tick_remote()
can avoid reposting itself.  A cpu_is_offline() check is also added to
sched_tick_remote() to avoid mucking with the state of an offlined CPU
(though it does appear safe to do so).  The sched_tick_start() and
sched_tick_stop() functions also update ->state, and sched_tick_start()
also schedules the delayed work if ->state indicates that it is not
already in flight.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
[ paulmck: Apply Peter Zijlstra and Frederic Weisbecker atomics feedback. ]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190625165238.GJ26519@linux.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 57 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..0b22e55cebe8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3486,8 +3486,36 @@ void scheduler_tick(void)
 
 struct tick_work {
 	int			cpu;
+	atomic_t		state;
 	struct delayed_work	work;
 };
+/* Values for ->state, see diagram below. */
+#define TICK_SCHED_REMOTE_OFFLINE	0
+#define TICK_SCHED_REMOTE_OFFLINING	1
+#define TICK_SCHED_REMOTE_RUNNING	2
+
+/*
+ * State diagram for ->state:
+ *
+ *
+ *          TICK_SCHED_REMOTE_OFFLINE
+ *                    |   ^
+ *                    |   |
+ *                    |   | sched_tick_remote()
+ *                    |   |
+ *                    |   |
+ *                    +--TICK_SCHED_REMOTE_OFFLINING
+ *                    |   ^
+ *                    |   |
+ * sched_tick_start() |   | sched_tick_stop()
+ *                    |   |
+ *                    V   |
+ *          TICK_SCHED_REMOTE_RUNNING
+ *
+ *
+ * Other transitions get WARN_ON_ONCE(), except that sched_tick_remote()
+ * and sched_tick_start() are happy to leave the state in RUNNING.
+ */
 
 static struct tick_work __percpu *tick_work_cpu;
 
@@ -3500,6 +3528,7 @@ static void sched_tick_remote(struct work_struct *work)
 	struct task_struct *curr;
 	struct rq_flags rf;
 	u64 delta;
+	int os;
 
 	/*
 	 * Handle the tick only if it appears the remote CPU is running in full
@@ -3513,7 +3542,7 @@ static void sched_tick_remote(struct work_struct *work)
 
 	rq_lock_irq(rq, &rf);
 	curr = rq->curr;
-	if (is_idle_task(curr))
+	if (is_idle_task(curr) || cpu_is_offline(cpu))
 		goto out_unlock;
 
 	update_rq_clock(rq);
@@ -3533,13 +3562,18 @@ out_requeue:
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary
 	 * frequency is large enough to avoid overload but short enough
-	 * to keep scheduler internal stats reasonably up to date.
+	 * to keep scheduler internal stats reasonably up to date.  But
+	 * first update state to reflect hotplug activity if required.
 	 */
-	queue_delayed_work(system_unbound_wq, dwork, HZ);
+	os = atomic_fetch_add_unless(&twork->state, -1, TICK_SCHED_REMOTE_RUNNING);
+	WARN_ON_ONCE(os == TICK_SCHED_REMOTE_OFFLINE);
+	if (os == TICK_SCHED_REMOTE_RUNNING)
+		queue_delayed_work(system_unbound_wq, dwork, HZ);
 }
 
 static void sched_tick_start(int cpu)
 {
+	int os;
 	struct tick_work *twork;
 
 	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
@@ -3548,15 +3582,20 @@ static void sched_tick_start(int cpu)
 	WARN_ON_ONCE(!tick_work_cpu);
 
 	twork = per_cpu_ptr(tick_work_cpu, cpu);
-	twork->cpu = cpu;
-	INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
-	queue_delayed_work(system_unbound_wq, &twork->work, HZ);
+	os = atomic_xchg(&twork->state, TICK_SCHED_REMOTE_RUNNING);
+	WARN_ON_ONCE(os == TICK_SCHED_REMOTE_RUNNING);
+	if (os == TICK_SCHED_REMOTE_OFFLINE) {
+		twork->cpu = cpu;
+		INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
+		queue_delayed_work(system_unbound_wq, &twork->work, HZ);
+	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
 static void sched_tick_stop(int cpu)
 {
 	struct tick_work *twork;
+	int os;
 
 	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
 		return;
@@ -3564,7 +3603,10 @@ static void sched_tick_stop(int cpu)
 	WARN_ON_ONCE(!tick_work_cpu);
 
 	twork = per_cpu_ptr(tick_work_cpu, cpu);
-	cancel_delayed_work_sync(&twork->work);
+	/* There cannot be competing actions, but don't rely on stop-machine. */
+	os = atomic_xchg(&twork->state, TICK_SCHED_REMOTE_OFFLINING);
+	WARN_ON_ONCE(os != TICK_SCHED_REMOTE_RUNNING);
+	/* Don't cancel, as this would mess up the state machine. */
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
@@ -3572,7 +3614,6 @@ int __init sched_tick_offload_init(void)
 {
 	tick_work_cpu = alloc_percpu(struct tick_work);
 	BUG_ON(!tick_work_cpu);
-
 	return 0;
 }
 
