Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7928FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4EB208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbfCZXWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:22:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732879AbfCZXWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:22:34 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNIbha051448
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:33 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfuftcsca-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:33 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:22:32 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:22:27 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNMQ5223527516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:22:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47194B2068;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18188B206B;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D9B7516C611D; Tue, 26 Mar 2019 16:22:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 08/11] rcu: Organize functions in tree_stall.h
Date:   Tue, 26 Mar 2019 16:22:22 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326232208.GA20384@linux.ibm.com>
References: <20190326232208.GA20384@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0040-0000-0000-000004D7AF49
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180136; UDB=6.00606765; IPR=6.00960851;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:22:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0041-0000-0000-000008E2D09A
Message-Id: <20190326232225.21332-8-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit does only code movement, removal of now-unneeded forward
declarations, and addition of comments.  It organizes the functions
that implement RCU CPU stall warnings for normal grace periods into
three categories:

1.	Control of RCU CPU stall warnings, including computing timeouts.

2.	Interaction of stall warnings with grace periods.

3.	Actual printing of the RCU CPU stall-warning messages.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.h       |   1 -
 kernel/rcu/tree_stall.h | 180 ++++++++++++++++++++++------------------
 2 files changed, 97 insertions(+), 84 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 49bf3b00bb50..099410dbcbe9 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -442,6 +442,5 @@ static void rcu_dynticks_task_enter(void);
 static void rcu_dynticks_task_exit(void);
 
 /* Forward declarations for tree_stall.h */
-static int rcu_print_task_stall(struct rcu_node *rnp);
 static void record_gp_stall_check_time(void);
 static void check_cpu_stall(struct rcu_data *rdp);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 19b915380a6f..03ed47883d8a 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -7,6 +7,9 @@
  * Author: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+//////////////////////////////////////////////////////////////////////////////
+//
+// Controlling CPU stall warnings, including delay calculation.
 
 /* panic() on RCU Stall sysctl. */
 int sysctl_panic_on_rcu_stall __read_mostly;
@@ -17,6 +20,7 @@ int sysctl_panic_on_rcu_stall __read_mostly;
 #define RCU_STALL_DELAY_DELTA	       0
 #endif
 
+/* Limit-check stall timeouts specified at boottime and runtime. */
 int rcu_jiffies_till_stall_check(void)
 {
 	int till_stall_check = READ_ONCE(rcu_cpu_stall_timeout);
@@ -36,6 +40,7 @@ int rcu_jiffies_till_stall_check(void)
 }
 EXPORT_SYMBOL_GPL(rcu_jiffies_till_stall_check);
 
+/* Don't do RCU CPU stall warnings during long sysrq printouts. */
 void rcu_sysrq_start(void)
 {
 	if (!rcu_cpu_stall_suppress)
@@ -48,6 +53,7 @@ void rcu_sysrq_end(void)
 		rcu_cpu_stall_suppress = 0;
 }
 
+/* Don't print RCU CPU stall warnings during a kernel panic. */
 static int rcu_panic(struct notifier_block *this, unsigned long ev, void *ptr)
 {
 	rcu_cpu_stall_suppress = 1;
@@ -65,6 +71,78 @@ static int __init check_cpu_stall_init(void)
 }
 early_initcall(check_cpu_stall_init);
 
+/* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
+static void panic_on_rcu_stall(void)
+{
+	if (sysctl_panic_on_rcu_stall)
+		panic("RCU Stall\n");
+}
+
+/**
+ * rcu_cpu_stall_reset - prevent further stall warnings in current grace period
+ *
+ * Set the stall-warning timeout way off into the future, thus preventing
+ * any RCU CPU stall-warning messages from appearing in the current set of
+ * RCU grace periods.
+ *
+ * The caller must disable hard irqs.
+ */
+void rcu_cpu_stall_reset(void)
+{
+	WRITE_ONCE(rcu_state.jiffies_stall, jiffies + ULONG_MAX / 2);
+}
+
+//////////////////////////////////////////////////////////////////////////////
+//
+// Interaction with RCU grace periods
+
+/* Start of new grace period, so record stall time (and forcing times). */
+static void record_gp_stall_check_time(void)
+{
+	unsigned long j = jiffies;
+	unsigned long j1;
+
+	rcu_state.gp_start = j;
+	j1 = rcu_jiffies_till_stall_check();
+	/* Record ->gp_start before ->jiffies_stall. */
+	smp_store_release(&rcu_state.jiffies_stall, j + j1); /* ^^^ */
+	rcu_state.jiffies_resched = j + j1 / 2;
+	rcu_state.n_force_qs_gpstart = READ_ONCE(rcu_state.n_force_qs);
+}
+
+/* Zero ->ticks_this_gp and snapshot the number of RCU softirq handlers. */
+static void zero_cpu_stall_ticks(struct rcu_data *rdp)
+{
+	rdp->ticks_this_gp = 0;
+	rdp->softirq_snap = kstat_softirqs_cpu(RCU_SOFTIRQ, smp_processor_id());
+	WRITE_ONCE(rdp->last_fqs_resched, jiffies);
+}
+
+/*
+ * If too much time has passed in the current grace period, and if
+ * so configured, go kick the relevant kthreads.
+ */
+static void rcu_stall_kick_kthreads(void)
+{
+	unsigned long j;
+
+	if (!rcu_kick_kthreads)
+		return;
+	j = READ_ONCE(rcu_state.jiffies_kick_kthreads);
+	if (time_after(jiffies, j) && rcu_state.gp_kthread &&
+	    (rcu_gp_in_progress() || READ_ONCE(rcu_state.gp_flags))) {
+		WARN_ONCE(1, "Kicking %s grace-period kthread\n",
+			  rcu_state.name);
+		rcu_ftrace_dump(DUMP_ALL);
+		wake_up_process(rcu_state.gp_kthread);
+		WRITE_ONCE(rcu_state.jiffies_kick_kthreads, j + HZ);
+	}
+}
+
+//////////////////////////////////////////////////////////////////////////////
+//
+// Printing RCU CPU stall warnings
+
 #ifdef CONFIG_PREEMPT
 
 /*
@@ -137,43 +215,6 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 }
 #endif /* #else #ifdef CONFIG_PREEMPT */
 
-static void record_gp_stall_check_time(void)
-{
-	unsigned long j = jiffies;
-	unsigned long j1;
-
-	rcu_state.gp_start = j;
-	j1 = rcu_jiffies_till_stall_check();
-	/* Record ->gp_start before ->jiffies_stall. */
-	smp_store_release(&rcu_state.jiffies_stall, j + j1); /* ^^^ */
-	rcu_state.jiffies_resched = j + j1 / 2;
-	rcu_state.n_force_qs_gpstart = READ_ONCE(rcu_state.n_force_qs);
-}
-
-/*
- * Complain about starvation of grace-period kthread.
- */
-static void rcu_check_gp_kthread_starvation(void)
-{
-	struct task_struct *gpk = rcu_state.gp_kthread;
-	unsigned long j;
-
-	j = jiffies - READ_ONCE(rcu_state.gp_activity);
-	if (j > 2 * HZ) {
-		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
-		       rcu_state.name, j,
-		       (long)rcu_seq_current(&rcu_state.gp_seq),
-		       READ_ONCE(rcu_state.gp_flags),
-		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
-		       gpk ? gpk->state : ~0, gpk ? task_cpu(gpk) : -1);
-		if (gpk) {
-			pr_err("RCU grace-period kthread stack dump:\n");
-			sched_show_task(gpk);
-			wake_up_process(gpk);
-		}
-	}
-}
-
 /*
  * Dump stacks of all tasks running on stalled CPUs.  First try using
  * NMIs, but fall back to manual remote stack tracing on architectures
@@ -196,33 +237,6 @@ static void rcu_dump_cpu_stacks(void)
 	}
 }
 
-/*
- * If too much time has passed in the current grace period, and if
- * so configured, go kick the relevant kthreads.
- */
-static void rcu_stall_kick_kthreads(void)
-{
-	unsigned long j;
-
-	if (!rcu_kick_kthreads)
-		return;
-	j = READ_ONCE(rcu_state.jiffies_kick_kthreads);
-	if (time_after(jiffies, j) && rcu_state.gp_kthread &&
-	    (rcu_gp_in_progress() || READ_ONCE(rcu_state.gp_flags))) {
-		WARN_ONCE(1, "Kicking %s grace-period kthread\n",
-			  rcu_state.name);
-		rcu_ftrace_dump(DUMP_ALL);
-		wake_up_process(rcu_state.gp_kthread);
-		WRITE_ONCE(rcu_state.jiffies_kick_kthreads, j + HZ);
-	}
-}
-
-static void panic_on_rcu_stall(void)
-{
-	if (sysctl_panic_on_rcu_stall)
-		panic("RCU Stall\n");
-}
-
 #ifdef CONFIG_RCU_FAST_NO_HZ
 
 static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
@@ -295,12 +309,26 @@ static void print_cpu_stall_info(int cpu)
 	       fast_no_hz);
 }
 
-/* Zero ->ticks_this_gp and snapshot the number of RCU softirq handlers. */
-static void zero_cpu_stall_ticks(struct rcu_data *rdp)
+/* Complain about starvation of grace-period kthread.  */
+static void rcu_check_gp_kthread_starvation(void)
 {
-	rdp->ticks_this_gp = 0;
-	rdp->softirq_snap = kstat_softirqs_cpu(RCU_SOFTIRQ, smp_processor_id());
-	WRITE_ONCE(rdp->last_fqs_resched, jiffies);
+	struct task_struct *gpk = rcu_state.gp_kthread;
+	unsigned long j;
+
+	j = jiffies - READ_ONCE(rcu_state.gp_activity);
+	if (j > 2 * HZ) {
+		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
+		       rcu_state.name, j,
+		       (long)rcu_seq_current(&rcu_state.gp_seq),
+		       READ_ONCE(rcu_state.gp_flags),
+		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
+		       gpk ? gpk->state : ~0, gpk ? task_cpu(gpk) : -1);
+		if (gpk) {
+			pr_err("RCU grace-period kthread stack dump:\n");
+			sched_show_task(gpk);
+			wake_up_process(gpk);
+		}
+	}
 }
 
 static void print_other_cpu_stall(unsigned long gp_seq)
@@ -488,17 +516,3 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		print_other_cpu_stall(gs2);
 	}
 }
-
-/**
- * rcu_cpu_stall_reset - prevent further stall warnings in current grace period
- *
- * Set the stall-warning timeout way off into the future, thus preventing
- * any RCU CPU stall-warning messages from appearing in the current set of
- * RCU grace periods.
- *
- * The caller must disable hard irqs.
- */
-void rcu_cpu_stall_reset(void)
-{
-	WRITE_ONCE(rcu_state.jiffies_stall, jiffies + ULONG_MAX / 2);
-}
-- 
2.17.1

