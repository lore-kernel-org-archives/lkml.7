Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A621C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7ED2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbfCZXWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:22:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732839AbfCZXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:22:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNIboj040764
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:32 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfuyj3peu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:32 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:22:31 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:22:27 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNMPPb23986292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:22:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEA3EB2070;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A13BDB206B;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C096316C42B1; Tue, 26 Mar 2019 16:22:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 04/11] rcu: Inline RCU task stall-warning helper functions
Date:   Tue, 26 Mar 2019 16:22:18 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326232208.GA20384@linux.ibm.com>
References: <20190326232208.GA20384@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0052-0000-0000-000003A187E7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180136; UDB=6.00617574; IPR=6.00960851;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:22:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0053-0000-0000-00006048DC36
Message-Id: <20190326232225.21332-4-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=844 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_print_detail_task_stall(), rcu_print_task_stall_begin(), and
rcu_print_task_stall_end() functions were defined to allow long-gone
Kconfig options to provide an abbreviated RCU CPU stall warning printout.
This commit saves a few lines of code by inlining them into their sole
callers.

While in the area, a useless call of rcu_print_detail_task_stall_rnp()
on the root rcu_node structure was eliminated.  If there is only one
rcu_node structure, its tasks get printed twice, but if there are more,
the root rcu_node structure is guaranteed to have an empty list of blocked
tasks, hence the uselessness.  (Long ago, root rcu_node structures with
non-empty ->blkd_tasks lists could happen, but no longer.)

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.h       |  1 -
 kernel/rcu/tree_stall.h | 36 +++++++-----------------------------
 2 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 3c4e26fff806..c6df9a13dd06 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -445,7 +445,6 @@ static void rcu_dynticks_task_enter(void);
 static void rcu_dynticks_task_exit(void);
 
 /* Forward declarations for tree_stall.h */
-static void rcu_print_detail_task_stall(void);
 static int rcu_print_task_stall(struct rcu_node *rnp);
 static void record_gp_stall_check_time(void);
 static void check_cpu_stall(struct rcu_data *rdp);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index e0e73f493363..b476786b8ef7 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -94,30 +94,6 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
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
 /*
  * Scan the current list of tasks blocked within RCU read-side critical
  * sections, printing out the tid of each.
@@ -129,14 +105,15 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 
 	if (!rcu_preempt_blocked_readers_cgp(rnp))
 		return 0;
-	rcu_print_task_stall_begin(rnp);
+	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
+	       rnp->level, rnp->grplo, rnp->grphi);
 	t = list_entry(rnp->gp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
 		pr_cont(" P%d", t->pid);
 		ndetected++;
 	}
-	rcu_print_task_stall_end();
+	pr_cont("\n");
 	return ndetected;
 }
 
@@ -146,7 +123,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
  * Because preemptible RCU does not exist, we never have to check for
  * tasks blocked within RCU read-side critical sections.
  */
-static void rcu_print_detail_task_stall(void)
+static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
 {
 }
 
@@ -253,7 +230,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 	unsigned long gpa;
 	unsigned long j;
 	int ndetected = 0;
-	struct rcu_node *rnp = rcu_get_root();
+	struct rcu_node *rnp;
 	long totqlen = 0;
 
 	/* Kick and suppress, if so configured. */
@@ -291,7 +268,8 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 		rcu_dump_cpu_stacks();
 
 		/* Complain about tasks blocking the grace period. */
-		rcu_print_detail_task_stall();
+		rcu_for_each_leaf_node(rnp)
+			rcu_print_detail_task_stall_rnp(rnp);
 	} else {
 		if (rcu_seq_current(&rcu_state.gp_seq) != gp_seq) {
 			pr_err("INFO: Stall ended before state dump start\n");
-- 
2.17.1

