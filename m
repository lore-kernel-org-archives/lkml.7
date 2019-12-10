Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E10AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ED220836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575952029;
	bh=UvqPH8KGP2teZiHdUsosVSBBj5Gb/IKBzG45J8z/tuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A9AOojW1rfpmNNVaA19nr6TTt9pv2Pm5WLRy7uZy60n/z4Xo5d8L4XA8KyHc5ji2F
	 l1ysZSs91x5t8Z95hn6VKFqjBZLvBzmXqRKn7IcGns3Tl1Ujmt1Gpf/ETC1GkcGxMk
	 LKLGgQAX+9JXfBeCstNBO1QpXhOsRXyCAUSf4q9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfLJE1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbfLJE0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:26:36 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7352D24679;
        Tue, 10 Dec 2019 04:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951995;
        bh=UvqPH8KGP2teZiHdUsosVSBBj5Gb/IKBzG45J8z/tuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c32MNEekPdboo365ph8TaYzom9kFpwYp7bqp7z2tlngbGtYDnOFLO1NsPMM634LkX
         Z2op2WCPqf++rp2a0xQlLecrzrCpW4bhDgmHppKuvgRqI3ofekb7tSE/gma7S4fygV
         2f6HFsnc6AnYklVe23p7wJGl17X8qegVfM/YjdGc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH tip/core/rcu 05/11] rcu: Use CONFIG_PREEMPTION where appropriate
Date:   Mon,  9 Dec 2019 20:26:23 -0800
Message-Id: <20191210042629.3808-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210042606.GA3624@paulmck-ThinkPad-P72>
References: <20191210042606.GA3624@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The config option `CONFIG_PREEMPT' is used for the preemption model
"Low-Latency Desktop". The config option `CONFIG_PREEMPTION' is enabled
when kernel preemption is enabled which is true for the preemption model
`CONFIG_PREEMPT' and `CONFIG_PREEMPT_RT'.

Use `CONFIG_PREEMPTION' if it applies to both preemption models and not
just to `CONFIG_PREEMPT'.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 4 ++--
 kernel/rcu/Kconfig       | 4 ++--
 kernel/rcu/rcutorture.c  | 2 +-
 kernel/rcu/srcutiny.c    | 2 +-
 kernel/rcu/tree.c        | 4 ++--
 kernel/rcu/tree_exp.h    | 2 +-
 kernel/rcu/tree_plugin.h | 4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 70a41cd..eb32fff 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -154,7 +154,7 @@ static inline void exit_tasks_rcu_finish(void) { }
  *
  * This macro resembles cond_resched(), except that it is defined to
  * report potential quiescent states to RCU-tasks even if the cond_resched()
- * machinery were to be shut off, as some advocate for PREEMPT kernels.
+ * machinery were to be shut off, as some advocate for PREEMPTION kernels.
  */
 #define cond_resched_tasks_rcu_qs() \
 do { \
@@ -598,7 +598,7 @@ do {									      \
  *
  * You can avoid reading and understanding the next paragraph by
  * following this rule: don't put anything in an rcu_read_lock() RCU
- * read-side critical section that would block in a !PREEMPT kernel.
+ * read-side critical section that would block in a !PREEMPTION kernel.
  * But if you want the full story, read on!
  *
  * In non-preemptible RCU implementations (pure TREE_RCU and TINY_RCU),
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 0303934..1cc940f 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -201,8 +201,8 @@ config RCU_NOCB_CPU
 	  specified at boot time by the rcu_nocbs parameter.  For each
 	  such CPU, a kthread ("rcuox/N") will be created to invoke
 	  callbacks, where the "N" is the CPU being offloaded, and where
-	  the "p" for RCU-preempt (PREEMPT kernels) and "s" for RCU-sched
-	  (!PREEMPT kernels).  Nothing prevents this kthread from running
+	  the "p" for RCU-preempt (PREEMPTION kernels) and "s" for RCU-sched
+	  (!PREEMPTION kernels).  Nothing prevents this kthread from running
 	  on the specified CPUs, but (1) the kthreads may be preempted
 	  between each callback, and (2) affinity or cgroups can be used
 	  to force the kthreads to run on whatever set of CPUs is desired.
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index dee043f..121a050 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1730,7 +1730,7 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 // Give the scheduler a chance, even on nohz_full CPUs.
 static void rcu_torture_fwd_prog_cond_resched(unsigned long iter)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT) && IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+	if (IS_ENABLED(CONFIG_PREEMPTION) && IS_ENABLED(CONFIG_NO_HZ_FULL)) {
 		// Real call_rcu() floods hit userspace, so emulate that.
 		if (need_resched() || (iter & 0xfff))
 			schedule();
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 44d6606..6208c1d 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -103,7 +103,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
 /*
  * Workqueue handler to drive one grace period and invoke any callbacks
- * that become ready as a result.  Single-CPU and !PREEMPT operation
+ * that become ready as a result.  Single-CPU and !PREEMPTION operation
  * means that we get away with murder on synchronization.  ;-)
  */
 void srcu_drive_gp(struct work_struct *wp)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1694a6b..c9dbb05 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2698,9 +2698,9 @@ EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
 /*
  * During early boot, any blocking grace-period wait automatically
- * implies a grace period.  Later on, this is never the case for PREEMPT.
+ * implies a grace period.  Later on, this is never the case for PREEMPTION.
  *
- * Howevr, because a context switch is a grace period for !PREEMPT, any
+ * Howevr, because a context switch is a grace period for !PREEMPTION, any
  * blocking grace-period wait automatically implies a grace period if
  * there is only one CPU online at any point time during execution of
  * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d632cd0..98d078c 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -670,7 +670,7 @@ static void rcu_exp_handler(void *unused)
 	}
 }
 
-/* PREEMPT=y, so no PREEMPT=n expedited grace period to clean up after. */
+/* PREEMPTION=y, so no PREEMPTION=n expedited grace period to clean up after. */
 static void sync_sched_exp_online_cleanup(int cpu)
 {
 }
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ed54d36..8cdce11 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -789,7 +789,7 @@ static void __init rcu_bootup_announce(void)
 }
 
 /*
- * Note a quiescent state for PREEMPT=n.  Because we do not need to know
+ * Note a quiescent state for PREEMPTION=n.  Because we do not need to know
  * how many quiescent states passed, just if there was at least one since
  * the start of the grace period, this just sets a flag.  The caller must
  * have disabled preemption.
@@ -839,7 +839,7 @@ void rcu_all_qs(void)
 EXPORT_SYMBOL_GPL(rcu_all_qs);
 
 /*
- * Note a PREEMPT=n context switch.  The caller must have disabled interrupts.
+ * Note a PREEMPTION=n context switch. The caller must have disabled interrupts.
  */
 void rcu_note_context_switch(bool preempt)
 {
-- 
2.9.5

