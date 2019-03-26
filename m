Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC58BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D72F2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbfCZXWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:22:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732864AbfCZXWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:22:34 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNIa5Q128810
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:33 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfwdgrngc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:33 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:22:31 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:22:27 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNMQOU8913014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:22:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48856B206C;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16DE1B2067;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D3EE516C610F; Tue, 26 Mar 2019 16:22:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 07/11] rcu: Move FAST_NO_HZ stall-warning code to tree_stall.h
Date:   Tue, 26 Mar 2019 16:22:21 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326232208.GA20384@linux.ibm.com>
References: <20190326232208.GA20384@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0064-0000-0000-000003C06EC8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180136; UDB=6.00617574; IPR=6.00960851;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:22:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0065-0000-0000-00003CD8B779
Message-Id: <20190326232225.21332-7-paulmck@linux.ibm.com>
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

This commit further consolidates the stall-warning code by moving
print_cpu_stall_info() and its helper functions along with
zero_cpu_stall_ticks() to kernel/rcu/tree_stall.h.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_plugin.h | 80 ----------------------------------------
 kernel/rcu/tree_stall.h  | 80 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 81 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d73472af49e7..49bf3b00bb50 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -416,7 +416,6 @@ static void rcu_prepare_for_idle(void);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
 static void rcu_preempt_deferred_qs(struct task_struct *t);
-static void print_cpu_stall_info(int cpu);
 static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static bool rcu_nocb_cpu_needs_barrier(int cpu);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2df5bb04fd7a..a1f9d7c15bd8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1528,86 +1528,6 @@ static void rcu_cleanup_after_idle(void)
 
 #endif /* #else #if !defined(CONFIG_RCU_FAST_NO_HZ) */
 
-#ifdef CONFIG_RCU_FAST_NO_HZ
-
-static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
-{
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-
-	sprintf(cp, "last_accelerate: %04lx/%04lx, Nonlazy posted: %c%c%c",
-		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
-		".l"[rdp->all_lazy],
-		".L"[!rcu_segcblist_n_nonlazy_cbs(&rdp->cblist)],
-		".D"[!rdp->tick_nohz_enabled_snap]);
-}
-
-#else /* #ifdef CONFIG_RCU_FAST_NO_HZ */
-
-static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
-{
-	*cp = '\0';
-}
-
-#endif /* #else #ifdef CONFIG_RCU_FAST_NO_HZ */
-
-/*
- * Print out diagnostic information for the specified stalled CPU.
- *
- * If the specified CPU is aware of the current RCU grace period, then
- * print the number of scheduling clock interrupts the CPU has taken
- * during the time that it has been aware.  Otherwise, print the number
- * of RCU grace periods that this CPU is ignorant of, for example, "1"
- * if the CPU was aware of the previous grace period.
- *
- * Also print out idle and (if CONFIG_RCU_FAST_NO_HZ) idle-entry info.
- */
-static void print_cpu_stall_info(int cpu)
-{
-	unsigned long delta;
-	char fast_no_hz[72];
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	char *ticks_title;
-	unsigned long ticks_value;
-
-	/*
-	 * We could be printing a lot while holding a spinlock.  Avoid
-	 * triggering hard lockup.
-	 */
-	touch_nmi_watchdog();
-
-	ticks_value = rcu_seq_ctr(rcu_state.gp_seq - rdp->gp_seq);
-	if (ticks_value) {
-		ticks_title = "GPs behind";
-	} else {
-		ticks_title = "ticks this GP";
-		ticks_value = rdp->ticks_this_gp;
-	}
-	print_cpu_stall_fast_no_hz(fast_no_hz, cpu);
-	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
-	       cpu,
-	       "O."[!!cpu_online(cpu)],
-	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
-	       "N."[!!(rdp->grpmask & rdp->mynode->qsmaskinitnext)],
-	       !IS_ENABLED(CONFIG_IRQ_WORK) ? '?' :
-			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
-				"!."[!delta],
-	       ticks_value, ticks_title,
-	       rcu_dynticks_snap(rdp) & 0xfff,
-	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
-	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
-	       READ_ONCE(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-	       fast_no_hz);
-}
-
-/* Zero ->ticks_this_gp and snapshot the number of RCU softirq handlers. */
-static void zero_cpu_stall_ticks(struct rcu_data *rdp)
-{
-	rdp->ticks_this_gp = 0;
-	rdp->softirq_snap = kstat_softirqs_cpu(RCU_SOFTIRQ, smp_processor_id());
-	WRITE_ONCE(rdp->last_fqs_resched, jiffies);
-}
-
 #ifdef CONFIG_RCU_NOCB_CPU
 
 /*
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 7ef3b596e45f..19b915380a6f 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -223,6 +223,86 @@ static void panic_on_rcu_stall(void)
 		panic("RCU Stall\n");
 }
 
+#ifdef CONFIG_RCU_FAST_NO_HZ
+
+static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
+{
+	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+
+	sprintf(cp, "last_accelerate: %04lx/%04lx, Nonlazy posted: %c%c%c",
+		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
+		".l"[rdp->all_lazy],
+		".L"[!rcu_segcblist_n_nonlazy_cbs(&rdp->cblist)],
+		".D"[!rdp->tick_nohz_enabled_snap]);
+}
+
+#else /* #ifdef CONFIG_RCU_FAST_NO_HZ */
+
+static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
+{
+	*cp = '\0';
+}
+
+#endif /* #else #ifdef CONFIG_RCU_FAST_NO_HZ */
+
+/*
+ * Print out diagnostic information for the specified stalled CPU.
+ *
+ * If the specified CPU is aware of the current RCU grace period, then
+ * print the number of scheduling clock interrupts the CPU has taken
+ * during the time that it has been aware.  Otherwise, print the number
+ * of RCU grace periods that this CPU is ignorant of, for example, "1"
+ * if the CPU was aware of the previous grace period.
+ *
+ * Also print out idle and (if CONFIG_RCU_FAST_NO_HZ) idle-entry info.
+ */
+static void print_cpu_stall_info(int cpu)
+{
+	unsigned long delta;
+	char fast_no_hz[72];
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	char *ticks_title;
+	unsigned long ticks_value;
+
+	/*
+	 * We could be printing a lot while holding a spinlock.  Avoid
+	 * triggering hard lockup.
+	 */
+	touch_nmi_watchdog();
+
+	ticks_value = rcu_seq_ctr(rcu_state.gp_seq - rdp->gp_seq);
+	if (ticks_value) {
+		ticks_title = "GPs behind";
+	} else {
+		ticks_title = "ticks this GP";
+		ticks_value = rdp->ticks_this_gp;
+	}
+	print_cpu_stall_fast_no_hz(fast_no_hz, cpu);
+	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
+	       cpu,
+	       "O."[!!cpu_online(cpu)],
+	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
+	       "N."[!!(rdp->grpmask & rdp->mynode->qsmaskinitnext)],
+	       !IS_ENABLED(CONFIG_IRQ_WORK) ? '?' :
+			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
+				"!."[!delta],
+	       ticks_value, ticks_title,
+	       rcu_dynticks_snap(rdp) & 0xfff,
+	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
+	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
+	       READ_ONCE(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
+	       fast_no_hz);
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
 static void print_other_cpu_stall(unsigned long gp_seq)
 {
 	int cpu;
-- 
2.17.1

