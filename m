Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDBAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822B62087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfCZXWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:22:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732882AbfCZXWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:22:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNIfIV098316
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:33 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfuyg3g7f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:33 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:22:32 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:22:27 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNMPas24510676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:22:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB5B7B206E;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C8DFB206A;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B9C5316C60F7; Tue, 26 Mar 2019 16:22:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 02/11] rcu: Move RCU CPU stall-warning code out of tree_plugin.h
Date:   Tue, 26 Mar 2019 16:22:16 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326232208.GA20384@linux.ibm.com>
References: <20190326232208.GA20384@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0064-0000-0000-000003C06EC7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180136; UDB=6.00617574; IPR=6.00960851;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:22:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0065-0000-0000-00003CD8B776
Message-Id: <20190326232225.21332-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCU CPU stall-warning code for normal grace periods is currently
scattered across two files, due to earlier Tiny RCU support for RCU
CPU stall warnings and for old Kconfig options that have long since
been retired.  Given that it is hard for the lead RCU maintainer to
find relevant stall-warning code, it would be good to consolidate it.
This commit continues this process by moving stall-warning code from
kernel/rcu/tree_plugin.c to a new kernel/rcu/tree_stall.h file.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_plugin.h | 90 -------------------------------------
 kernel/rcu/tree_stall.h  | 95 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 90 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 97dba50f6fb2..7fa3bc4d481b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -642,79 +642,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
 
-/*
- * Dump detailed information for all tasks blocking the current RCU
- * grace period on the specified rcu_node structure.
- */
-static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
-{
-	unsigned long flags;
-	struct task_struct *t;
-
-	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-		return;
-	}
-	t = list_entry(rnp->gp_tasks->prev,
-		       struct task_struct, rcu_node_entry);
-	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
-		/*
-		 * We could be printing a lot while holding a spinlock.
-		 * Avoid triggering hard lockup.
-		 */
-		touch_nmi_watchdog();
-		sched_show_task(t);
-	}
-	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-}
-
-/*
- * Dump detailed information for all tasks blocking the current RCU
- * grace period.
- */
-static void rcu_print_detail_task_stall(void)
-{
-	struct rcu_node *rnp = rcu_get_root();
-
-	rcu_print_detail_task_stall_rnp(rnp);
-	rcu_for_each_leaf_node(rnp)
-		rcu_print_detail_task_stall_rnp(rnp);
-}
-
-static void rcu_print_task_stall_begin(struct rcu_node *rnp)
-{
-	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
-	       rnp->level, rnp->grplo, rnp->grphi);
-}
-
-static void rcu_print_task_stall_end(void)
-{
-	pr_cont("\n");
-}
-
-/*
- * Scan the current list of tasks blocked within RCU read-side critical
- * sections, printing out the tid of each.
- */
-static int rcu_print_task_stall(struct rcu_node *rnp)
-{
-	struct task_struct *t;
-	int ndetected = 0;
-
-	if (!rcu_preempt_blocked_readers_cgp(rnp))
-		return 0;
-	rcu_print_task_stall_begin(rnp);
-	t = list_entry(rnp->gp_tasks->prev,
-		       struct task_struct, rcu_node_entry);
-	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
-		pr_cont(" P%d", t->pid);
-		ndetected++;
-	}
-	rcu_print_task_stall_end();
-	return ndetected;
-}
-
 /*
  * Scan the current list of tasks blocked within RCU read-side critical
  * sections, printing out the tid of each that is blocking the current
@@ -979,23 +906,6 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 }
 static void rcu_preempt_deferred_qs(struct task_struct *t) { }
 
-/*
- * Because preemptible RCU does not exist, we never have to check for
- * tasks blocked within RCU read-side critical sections.
- */
-static void rcu_print_detail_task_stall(void)
-{
-}
-
-/*
- * Because preemptible RCU does not exist, we never have to check for
- * tasks blocked within RCU read-side critical sections.
- */
-static int rcu_print_task_stall(struct rcu_node *rnp)
-{
-	return 0;
-}
-
 /*
  * Because preemptible RCU does not exist, we never have to check for
  * tasks blocked within RCU read-side critical sections that are
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 682189f4d083..6f5f94944f49 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -61,3 +61,98 @@ static int __init check_cpu_stall_init(void)
 	return 0;
 }
 early_initcall(check_cpu_stall_init);
+
+#ifdef CONFIG_PREEMPT
+
+/*
+ * Dump detailed information for all tasks blocking the current RCU
+ * grace period on the specified rcu_node structure.
+ */
+static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
+{
+	unsigned long flags;
+	struct task_struct *t;
+
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		return;
+	}
+	t = list_entry(rnp->gp_tasks->prev,
+		       struct task_struct, rcu_node_entry);
+	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
+		/*
+		 * We could be printing a lot while holding a spinlock.
+		 * Avoid triggering hard lockup.
+		 */
+		touch_nmi_watchdog();
+		sched_show_task(t);
+	}
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+}
+
+/*
+ * Dump detailed information for all tasks blocking the current RCU
+ * grace period.
+ */
+static void rcu_print_detail_task_stall(void)
+{
+	struct rcu_node *rnp = rcu_get_root();
+
+	rcu_print_detail_task_stall_rnp(rnp);
+	rcu_for_each_leaf_node(rnp)
+		rcu_print_detail_task_stall_rnp(rnp);
+}
+
+static void rcu_print_task_stall_begin(struct rcu_node *rnp)
+{
+	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
+	       rnp->level, rnp->grplo, rnp->grphi);
+}
+
+static void rcu_print_task_stall_end(void)
+{
+	pr_cont("\n");
+}
+
+/*
+ * Scan the current list of tasks blocked within RCU read-side critical
+ * sections, printing out the tid of each.
+ */
+static int rcu_print_task_stall(struct rcu_node *rnp)
+{
+	struct task_struct *t;
+	int ndetected = 0;
+
+	if (!rcu_preempt_blocked_readers_cgp(rnp))
+		return 0;
+	rcu_print_task_stall_begin(rnp);
+	t = list_entry(rnp->gp_tasks->prev,
+		       struct task_struct, rcu_node_entry);
+	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
+		pr_cont(" P%d", t->pid);
+		ndetected++;
+	}
+	rcu_print_task_stall_end();
+	return ndetected;
+}
+
+#else /* #ifdef CONFIG_PREEMPT */
+
+/*
+ * Because preemptible RCU does not exist, we never have to check for
+ * tasks blocked within RCU read-side critical sections.
+ */
+static void rcu_print_detail_task_stall(void)
+{
+}
+
+/*
+ * Because preemptible RCU does not exist, we never have to check for
+ * tasks blocked within RCU read-side critical sections.
+ */
+static int rcu_print_task_stall(struct rcu_node *rnp)
+{
+	return 0;
+}
+#endif /* #else #ifdef CONFIG_PREEMPT */
-- 
2.17.1

