Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E650C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78A32087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbfCZXXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:23:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732950AbfCZXWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:22:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNIaYC128818
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:34 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfwdgrnh9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:34 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:22:33 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:22:27 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNMQ9616318566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:22:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AA61B2066;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E66AB205F;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E4F2316C6128; Tue, 26 Mar 2019 16:22:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 10/11] rcu: Move forward-progress checkers into tree_stall.h
Date:   Tue, 26 Mar 2019 16:22:24 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326232208.GA20384@linux.ibm.com>
References: <20190326232208.GA20384@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0052-0000-0000-000003A187E8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180136; UDB=6.00617574; IPR=6.00960851;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:22:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0053-0000-0000-00006048DC39
Message-Id: <20190326232225.21332-10-paulmck@linux.ibm.com>
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

This commit further consolidates stall-warning functionality by moving
forward-progress checkers into kernel/rcu/tree_stall.h, updating a
comment or two while in the area.  More specifically, this commit moves
show_rcu_gp_kthreads(), rcu_check_gp_start_stall(), rcu_fwd_progress_check(),
sysrq_rcu, sysrq_show_rcu(), sysrq_rcudump_op, and rcu_sysrq_init() from
kernel/rcu/tree.c to kernel/rcu/tree_stall.h.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c       | 166 --------------------------------------
 kernel/rcu/tree.h       |   2 +
 kernel/rcu/tree_stall.h | 171 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+), 166 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 929531ed168c..4cb1ebd93b0c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -102,9 +102,6 @@ int rcu_num_lvls __read_mostly = RCU_NUM_LVLS;
 /* Number of rcu_nodes at specified level. */
 int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
 int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */
-/* Commandeer a sysrq key to dump RCU's tree. */
-static bool sysrq_rcu;
-module_param(sysrq_rcu, bool, 0444);
 
 /*
  * The rcu_scheduler_active variable is initialized to the value
@@ -510,74 +507,6 @@ static const char *gp_state_getname(short gs)
 	return gp_state_names[gs];
 }
 
-/*
- * Show the state of the grace-period kthreads.
- */
-void show_rcu_gp_kthreads(void)
-{
-	int cpu;
-	unsigned long j;
-	unsigned long ja;
-	unsigned long jr;
-	unsigned long jw;
-	struct rcu_data *rdp;
-	struct rcu_node *rnp;
-
-	j = jiffies;
-	ja = j - READ_ONCE(rcu_state.gp_activity);
-	jr = j - READ_ONCE(rcu_state.gp_req_activity);
-	jw = j - READ_ONCE(rcu_state.gp_wake_time);
-	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
-		rcu_state.name, gp_state_getname(rcu_state.gp_state),
-		rcu_state.gp_state,
-		rcu_state.gp_kthread ? rcu_state.gp_kthread->state : 0x1ffffL,
-		ja, jr, jw, (long)READ_ONCE(rcu_state.gp_wake_seq),
-		(long)READ_ONCE(rcu_state.gp_seq),
-		(long)READ_ONCE(rcu_get_root()->gp_seq_needed),
-		READ_ONCE(rcu_state.gp_flags));
-	rcu_for_each_node_breadth_first(rnp) {
-		if (ULONG_CMP_GE(rcu_state.gp_seq, rnp->gp_seq_needed))
-			continue;
-		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld\n",
-			rnp->grplo, rnp->grphi, (long)rnp->gp_seq,
-			(long)rnp->gp_seq_needed);
-		if (!rcu_is_leaf_node(rnp))
-			continue;
-		for_each_leaf_node_possible_cpu(rnp, cpu) {
-			rdp = per_cpu_ptr(&rcu_data, cpu);
-			if (rdp->gpwrap ||
-			    ULONG_CMP_GE(rcu_state.gp_seq,
-					 rdp->gp_seq_needed))
-				continue;
-			pr_info("\tcpu %d ->gp_seq_needed %ld\n",
-				cpu, (long)rdp->gp_seq_needed);
-		}
-	}
-	/* sched_show_task(rcu_state.gp_kthread); */
-}
-EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
-
-/* Dump grace-period-request information due to commandeered sysrq. */
-static void sysrq_show_rcu(int key)
-{
-	show_rcu_gp_kthreads();
-}
-
-static struct sysrq_key_op sysrq_rcudump_op = {
-	.handler = sysrq_show_rcu,
-	.help_msg = "show-rcu(y)",
-	.action_msg = "Show RCU tree",
-	.enable_mask = SYSRQ_ENABLE_DUMP,
-};
-
-static int __init rcu_sysrq_init(void)
-{
-	if (sysrq_rcu)
-		return register_sysrq_key('y', &sysrq_rcudump_op);
-	return 0;
-}
-early_initcall(rcu_sysrq_init);
-
 /*
  * Send along grace-period-related data for rcutorture diagnostics.
  */
@@ -2323,101 +2252,6 @@ void rcu_force_quiescent_state(void)
 }
 EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
 
-/*
- * This function checks for grace-period requests that fail to motivate
- * RCU to come out of its idle mode.
- */
-void
-rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
-			 const unsigned long gpssdelay)
-{
-	unsigned long flags;
-	unsigned long j;
-	struct rcu_node *rnp_root = rcu_get_root();
-	static atomic_t warned = ATOMIC_INIT(0);
-
-	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress() ||
-	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed))
-		return;
-	j = jiffies; /* Expensive access, and in common case don't get here. */
-	if (time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
-	    time_before(j, READ_ONCE(rcu_state.gp_activity) + gpssdelay) ||
-	    atomic_read(&warned))
-		return;
-
-	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	j = jiffies;
-	if (rcu_gp_in_progress() ||
-	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
-	    time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
-	    time_before(j, READ_ONCE(rcu_state.gp_activity) + gpssdelay) ||
-	    atomic_read(&warned)) {
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-		return;
-	}
-	/* Hold onto the leaf lock to make others see warned==1. */
-
-	if (rnp_root != rnp)
-		raw_spin_lock_rcu_node(rnp_root); /* irqs already disabled. */
-	j = jiffies;
-	if (rcu_gp_in_progress() ||
-	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
-	    time_before(j, rcu_state.gp_req_activity + gpssdelay) ||
-	    time_before(j, rcu_state.gp_activity + gpssdelay) ||
-	    atomic_xchg(&warned, 1)) {
-		raw_spin_unlock_rcu_node(rnp_root); /* irqs remain disabled. */
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-		return;
-	}
-	WARN_ON(1);
-	if (rnp_root != rnp)
-		raw_spin_unlock_rcu_node(rnp_root);
-	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	show_rcu_gp_kthreads();
-}
-
-/*
- * Do a forward-progress check for rcutorture.  This is normally invoked
- * due to an OOM event.  The argument "j" gives the time period during
- * which rcutorture would like progress to have been made.
- */
-void rcu_fwd_progress_check(unsigned long j)
-{
-	unsigned long cbs;
-	int cpu;
-	unsigned long max_cbs = 0;
-	int max_cpu = -1;
-	struct rcu_data *rdp;
-
-	if (rcu_gp_in_progress()) {
-		pr_info("%s: GP age %lu jiffies\n",
-			__func__, jiffies - rcu_state.gp_start);
-		show_rcu_gp_kthreads();
-	} else {
-		pr_info("%s: Last GP end %lu jiffies ago\n",
-			__func__, jiffies - rcu_state.gp_end);
-		preempt_disable();
-		rdp = this_cpu_ptr(&rcu_data);
-		rcu_check_gp_start_stall(rdp->mynode, rdp, j);
-		preempt_enable();
-	}
-	for_each_possible_cpu(cpu) {
-		cbs = rcu_get_n_cbs_cpu(cpu);
-		if (!cbs)
-			continue;
-		if (max_cpu < 0)
-			pr_info("%s: callbacks", __func__);
-		pr_cont(" %d: %lu", cpu, cbs);
-		if (cbs <= max_cbs)
-			continue;
-		max_cbs = cbs;
-		max_cpu = cpu;
-	}
-	if (max_cpu >= 0)
-		pr_cont("\n");
-}
-EXPORT_SYMBOL_GPL(rcu_fwd_progress_check);
-
 /* Perform RCU core processing work for the current CPU.  */
 static __latent_entropy void rcu_core(struct softirq_action *unused)
 {
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index f882ce3ca5a5..e253d11af3c4 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -445,3 +445,5 @@ static void rcu_dynticks_task_exit(void);
 static void record_gp_stall_check_time(void);
 static void rcu_iw_handler(struct irq_work *iwp);
 static void check_cpu_stall(struct rcu_data *rdp);
+static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
+				     const unsigned long gpssdelay);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 526e223e41ce..9e3db08d02bc 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -536,3 +536,174 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		print_other_cpu_stall(gs2);
 	}
 }
+
+//////////////////////////////////////////////////////////////////////////////
+//
+// RCU forward-progress mechanisms, including of callback invocation.
+
+
+/*
+ * Show the state of the grace-period kthreads.
+ */
+void show_rcu_gp_kthreads(void)
+{
+	int cpu;
+	unsigned long j;
+	unsigned long ja;
+	unsigned long jr;
+	unsigned long jw;
+	struct rcu_data *rdp;
+	struct rcu_node *rnp;
+
+	j = jiffies;
+	ja = j - READ_ONCE(rcu_state.gp_activity);
+	jr = j - READ_ONCE(rcu_state.gp_req_activity);
+	jw = j - READ_ONCE(rcu_state.gp_wake_time);
+	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
+		rcu_state.name, gp_state_getname(rcu_state.gp_state),
+		rcu_state.gp_state,
+		rcu_state.gp_kthread ? rcu_state.gp_kthread->state : 0x1ffffL,
+		ja, jr, jw, (long)READ_ONCE(rcu_state.gp_wake_seq),
+		(long)READ_ONCE(rcu_state.gp_seq),
+		(long)READ_ONCE(rcu_get_root()->gp_seq_needed),
+		READ_ONCE(rcu_state.gp_flags));
+	rcu_for_each_node_breadth_first(rnp) {
+		if (ULONG_CMP_GE(rcu_state.gp_seq, rnp->gp_seq_needed))
+			continue;
+		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld\n",
+			rnp->grplo, rnp->grphi, (long)rnp->gp_seq,
+			(long)rnp->gp_seq_needed);
+		if (!rcu_is_leaf_node(rnp))
+			continue;
+		for_each_leaf_node_possible_cpu(rnp, cpu) {
+			rdp = per_cpu_ptr(&rcu_data, cpu);
+			if (rdp->gpwrap ||
+			    ULONG_CMP_GE(rcu_state.gp_seq,
+					 rdp->gp_seq_needed))
+				continue;
+			pr_info("\tcpu %d ->gp_seq_needed %ld\n",
+				cpu, (long)rdp->gp_seq_needed);
+		}
+	}
+	/* sched_show_task(rcu_state.gp_kthread); */
+}
+EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
+
+/*
+ * This function checks for grace-period requests that fail to motivate
+ * RCU to come out of its idle mode.
+ */
+static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
+				     const unsigned long gpssdelay)
+{
+	unsigned long flags;
+	unsigned long j;
+	struct rcu_node *rnp_root = rcu_get_root();
+	static atomic_t warned = ATOMIC_INIT(0);
+
+	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress() ||
+	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed))
+		return;
+	j = jiffies; /* Expensive access, and in common case don't get here. */
+	if (time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
+	    time_before(j, READ_ONCE(rcu_state.gp_activity) + gpssdelay) ||
+	    atomic_read(&warned))
+		return;
+
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	j = jiffies;
+	if (rcu_gp_in_progress() ||
+	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
+	    time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
+	    time_before(j, READ_ONCE(rcu_state.gp_activity) + gpssdelay) ||
+	    atomic_read(&warned)) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		return;
+	}
+	/* Hold onto the leaf lock to make others see warned==1. */
+
+	if (rnp_root != rnp)
+		raw_spin_lock_rcu_node(rnp_root); /* irqs already disabled. */
+	j = jiffies;
+	if (rcu_gp_in_progress() ||
+	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
+	    time_before(j, rcu_state.gp_req_activity + gpssdelay) ||
+	    time_before(j, rcu_state.gp_activity + gpssdelay) ||
+	    atomic_xchg(&warned, 1)) {
+		raw_spin_unlock_rcu_node(rnp_root); /* irqs remain disabled. */
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		return;
+	}
+	WARN_ON(1);
+	if (rnp_root != rnp)
+		raw_spin_unlock_rcu_node(rnp_root);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	show_rcu_gp_kthreads();
+}
+
+/*
+ * Do a forward-progress check for rcutorture.  This is normally invoked
+ * due to an OOM event.  The argument "j" gives the time period during
+ * which rcutorture would like progress to have been made.
+ */
+void rcu_fwd_progress_check(unsigned long j)
+{
+	unsigned long cbs;
+	int cpu;
+	unsigned long max_cbs = 0;
+	int max_cpu = -1;
+	struct rcu_data *rdp;
+
+	if (rcu_gp_in_progress()) {
+		pr_info("%s: GP age %lu jiffies\n",
+			__func__, jiffies - rcu_state.gp_start);
+		show_rcu_gp_kthreads();
+	} else {
+		pr_info("%s: Last GP end %lu jiffies ago\n",
+			__func__, jiffies - rcu_state.gp_end);
+		preempt_disable();
+		rdp = this_cpu_ptr(&rcu_data);
+		rcu_check_gp_start_stall(rdp->mynode, rdp, j);
+		preempt_enable();
+	}
+	for_each_possible_cpu(cpu) {
+		cbs = rcu_get_n_cbs_cpu(cpu);
+		if (!cbs)
+			continue;
+		if (max_cpu < 0)
+			pr_info("%s: callbacks", __func__);
+		pr_cont(" %d: %lu", cpu, cbs);
+		if (cbs <= max_cbs)
+			continue;
+		max_cbs = cbs;
+		max_cpu = cpu;
+	}
+	if (max_cpu >= 0)
+		pr_cont("\n");
+}
+EXPORT_SYMBOL_GPL(rcu_fwd_progress_check);
+
+/* Commandeer a sysrq key to dump RCU's tree. */
+static bool sysrq_rcu;
+module_param(sysrq_rcu, bool, 0444);
+
+/* Dump grace-period-request information due to commandeered sysrq. */
+static void sysrq_show_rcu(int key)
+{
+	show_rcu_gp_kthreads();
+}
+
+static struct sysrq_key_op sysrq_rcudump_op = {
+	.handler = sysrq_show_rcu,
+	.help_msg = "show-rcu(y)",
+	.action_msg = "Show RCU tree",
+	.enable_mask = SYSRQ_ENABLE_DUMP,
+};
+
+static int __init rcu_sysrq_init(void)
+{
+	if (sysrq_rcu)
+		return register_sysrq_key('y', &sysrq_rcudump_op);
+	return 0;
+}
+early_initcall(rcu_sysrq_init);
-- 
2.17.1

