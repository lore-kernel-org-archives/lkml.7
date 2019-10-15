Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDD9ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FBC20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbfJOTTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:19:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45738 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389526AbfJOTTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:19:02 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSLC-00067i-OW; Tue, 15 Oct 2019 21:18:42 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
Subject: [PATCH 27/34] rcu: Use CONFIG_PREEMPTION where appropriate
Date:   Tue, 15 Oct 2019 21:18:14 +0200
Message-Id: <20191015191821.11479-28-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 75a2eded7aa2c..1e3dad252d61f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -154,7 +154,7 @@ static inline void exit_tasks_rcu_finish(void) { }
  *
  * This macro resembles cond_resched(), except that it is defined to
  * report potential quiescent states to RCU-tasks even if the cond_resched=
()
- * machinery were to be shut off, as some advocate for PREEMPT kernels.
+ * machinery were to be shut off, as some advocate for PREEMPTION kernels.
  */
 #define cond_resched_tasks_rcu_qs() \
 do { \
@@ -580,7 +580,7 @@ do {									      \
  *
  * You can avoid reading and understanding the next paragraph by
  * following this rule: don't put anything in an rcu_read_lock() RCU
- * read-side critical section that would block in a !PREEMPT kernel.
+ * read-side critical section that would block in a !PREEMPTION kernel.
  * But if you want the full story, read on!
  *
  * In non-preemptible RCU implementations (TREE_RCU and TINY_RCU),
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 7644eda17d624..01b56177464d8 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -200,8 +200,8 @@ config RCU_NOCB_CPU
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
index 3c9feca1eab17..c070d103f34d6 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1725,7 +1725,7 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rh=
p)
 // Give the scheduler a chance, even on nohz_full CPUs.
 static void rcu_torture_fwd_prog_cond_resched(unsigned long iter)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT) && IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+	if (IS_ENABLED(CONFIG_PREEMPTION) && IS_ENABLED(CONFIG_NO_HZ_FULL)) {
 		// Real call_rcu() floods hit userspace, so emulate that.
 		if (need_resched() || (iter & 0xfff))
 			schedule();
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 44d6606b83257..6208c1dae5c95 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -103,7 +103,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
=20
 /*
  * Workqueue handler to drive one grace period and invoke any callbacks
- * that become ready as a result.  Single-CPU and !PREEMPT operation
+ * that become ready as a result.  Single-CPU and !PREEMPTION operation
  * means that we get away with murder on synchronization.  ;-)
  */
 void srcu_drive_gp(struct work_struct *wp)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 81105141b6a82..1c5de816ae9e5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2667,9 +2667,9 @@ EXPORT_SYMBOL_GPL(kfree_call_rcu);
=20
 /*
  * During early boot, any blocking grace-period wait automatically
- * implies a grace period.  Later on, this is never the case for PREEMPT.
+ * implies a grace period.  Later on, this is never the case for PREEMPTIO=
N.
  *
- * Howevr, because a context switch is a grace period for !PREEMPT, any
+ * Howevr, because a context switch is a grace period for !PREEMPTION, any
  * blocking grace-period wait automatically implies a grace period if
  * there is only one CPU online at any point time during execution of
  * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d632cd0195975..98d078cafa5a6 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -670,7 +670,7 @@ static void rcu_exp_handler(void *unused)
 	}
 }
=20
-/* PREEMPT=3Dy, so no PREEMPT=3Dn expedited grace period to clean up after=
. */
+/* PREEMPTION=3Dy, so no PREEMPTION=3Dn expedited grace period to clean up=
 after. */
 static void sync_sched_exp_online_cleanup(int cpu)
 {
 }
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2defc7fe74c39..e6c987d171cbe 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -788,7 +788,7 @@ static void __init rcu_bootup_announce(void)
 }
=20
 /*
- * Note a quiescent state for PREEMPT=3Dn.  Because we do not need to know
+ * Note a quiescent state for PREEMPTION=3Dn.  Because we do not need to k=
now
  * how many quiescent states passed, just if there was at least one since
  * the start of the grace period, this just sets a flag.  The caller must
  * have disabled preemption.
@@ -838,7 +838,7 @@ void rcu_all_qs(void)
 EXPORT_SYMBOL_GPL(rcu_all_qs);
=20
 /*
- * Note a PREEMPT=3Dn context switch.  The caller must have disabled inter=
rupts.
+ * Note a PREEMPTION=3Dn context switch. The caller must have disabled int=
errupts.
  */
 void rcu_note_context_switch(bool preempt)
 {
--=20
2.23.0

