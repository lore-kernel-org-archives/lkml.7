Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7389C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E4025BBD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfE3Ox1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:53:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727080AbfE3OxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:53:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEppsp105210;
        Thu, 30 May 2019 10:52:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgu3sje6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 10:52:32 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x4UEq9Ds108971;
        Thu, 30 May 2019 10:52:32 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgu3sjdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 10:52:32 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x4UCsgpx014735;
        Thu, 30 May 2019 12:55:04 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2spwb96ny8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 12:55:04 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEqUNU18481572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:52:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 049A4B205F;
        Thu, 30 May 2019 14:52:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D59EDB206B;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 60EB716C366B; Thu, 30 May 2019 07:52:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 11/12] rcu: Rename rcu_data's ->deferred_qs to ->exp_deferred_qs
Date:   Thu, 30 May 2019 07:52:28 -0700
Message-Id: <20190530145229.29565-11-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530145204.GA28526@linux.ibm.com>
References: <20190530145204.GA28526@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_data structure's ->deferred_qs field is used to indicate that the
current CPU is blocking an expedited grace period (perhaps a future one).
Given that it is used only for expedited grace periods, its current name
is misleading, so this commit renames it to ->exp_deferred_qs.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_exp.h    |  8 ++++----
 kernel/rcu/tree_plugin.h | 14 +++++++-------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 21d740f0b8dc..7acaf3a62d39 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -154,7 +154,7 @@ struct rcu_data {
 	bool		core_needs_qs;	/* Core waits for quiesc state. */
 	bool		beenonline;	/* CPU online at least once. */
 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
-	bool		deferred_qs;	/* This CPU awaiting a deferred QS? */
+	bool		exp_deferred_qs; /* This CPU awaiting a deferred QS? */
 	struct rcu_node *mynode;	/* This CPU's leaf of hierarchy */
 	unsigned long grpmask;		/* Mask to apply to leaf qsmask. */
 	unsigned long	ticks_this_gp;	/* The number of scheduling-clock */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index de1b4acf6979..e0c928d04be5 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -250,7 +250,7 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
  */
 static void rcu_report_exp_rdp(struct rcu_data *rdp)
 {
-	WRITE_ONCE(rdp->deferred_qs, false);
+	WRITE_ONCE(rdp->exp_deferred_qs, false);
 	rcu_report_exp_cpu_mult(rdp->mynode, rdp->grpmask, true);
 }
 
@@ -616,7 +616,7 @@ static void rcu_exp_handler(void *unused)
 		    rcu_dynticks_curr_cpu_in_eqs()) {
 			rcu_report_exp_rdp(rdp);
 		} else {
-			rdp->deferred_qs = true;
+			rdp->exp_deferred_qs = true;
 			set_tsk_need_resched(t);
 			set_preempt_need_resched();
 		}
@@ -638,7 +638,7 @@ static void rcu_exp_handler(void *unused)
 	if (t->rcu_read_lock_nesting > 0) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmask & rdp->grpmask) {
-			rdp->deferred_qs = true;
+			rdp->exp_deferred_qs = true;
 			t->rcu_read_unlock_special.b.exp_hint = true;
 		}
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -661,7 +661,7 @@ static void rcu_exp_handler(void *unused)
 	 *
 	 * Otherwise, force a context switch after the CPU enables everything.
 	 */
-	rdp->deferred_qs = true;
+	rdp->exp_deferred_qs = true;
 	if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
 	    WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs())) {
 		rcu_preempt_deferred_qs(t);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 58c7853f19e7..1aeb4ae187ce 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -237,10 +237,10 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * no need to check for a subsequent expedited GP.  (Though we are
 	 * still in a quiescent state in any case.)
 	 */
-	if (blkd_state & RCU_EXP_BLKD && rdp->deferred_qs)
+	if (blkd_state & RCU_EXP_BLKD && rdp->exp_deferred_qs)
 		rcu_report_exp_rdp(rdp);
 	else
-		WARN_ON_ONCE(rdp->deferred_qs);
+		WARN_ON_ONCE(rdp->exp_deferred_qs);
 }
 
 /*
@@ -337,7 +337,7 @@ void rcu_note_context_switch(bool preempt)
 	 * means that we continue to block the current grace period.
 	 */
 	rcu_qs();
-	if (rdp->deferred_qs)
+	if (rdp->exp_deferred_qs)
 		rcu_report_exp_rdp(rdp);
 	trace_rcu_utilization(TPS("End context switch"));
 	barrier(); /* Avoid RCU read-side critical sections leaking up. */
@@ -451,7 +451,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 */
 	special = t->rcu_read_unlock_special;
 	rdp = this_cpu_ptr(&rcu_data);
-	if (!special.s && !rdp->deferred_qs) {
+	if (!special.s && !rdp->exp_deferred_qs) {
 		local_irq_restore(flags);
 		return;
 	}
@@ -459,7 +459,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	if (special.b.need_qs) {
 		rcu_qs();
 		t->rcu_read_unlock_special.b.need_qs = false;
-		if (!t->rcu_read_unlock_special.s && !rdp->deferred_qs) {
+		if (!t->rcu_read_unlock_special.s && !rdp->exp_deferred_qs) {
 			local_irq_restore(flags);
 			return;
 		}
@@ -471,7 +471,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * tasks are handled when removing the task from the
 	 * blocked-tasks list below.
 	 */
-	if (rdp->deferred_qs) {
+	if (rdp->exp_deferred_qs) {
 		rcu_report_exp_rdp(rdp);
 		if (!t->rcu_read_unlock_special.s) {
 			local_irq_restore(flags);
@@ -560,7 +560,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
  */
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
-	return (__this_cpu_read(rcu_data.deferred_qs) ||
+	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
 	       t->rcu_read_lock_nesting <= 0;
 }
-- 
2.17.1

