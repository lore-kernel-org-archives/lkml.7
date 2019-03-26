Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB05C2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbfCZXWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:22:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732889AbfCZXWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:22:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNIgdu098426
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:33 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfuyg3g7p-1
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
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNMQeS17956868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:22:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9C68B2068;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9CF4B205F;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C6C0516C6107; Tue, 26 Mar 2019 16:22:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 05/11] rcu: Move rcu_print_task_exp_stall() to tree_exp.h
Date:   Tue, 26 Mar 2019 16:22:19 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326232208.GA20384@linux.ibm.com>
References: <20190326232208.GA20384@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0064-0000-0000-000003C06EC6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180136; UDB=6.00617574; IPR=6.00960851;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:22:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0065-0000-0000-00003CD8B777
Message-Id: <20190326232225.21332-5-paulmck@linux.ibm.com>
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

Because expedited CPU stall warnings are contained within the
kernel/rcu/tree_exp.h file, rcu_print_task_exp_stall() should live
there too.  This commit carries out the required code motion.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_exp.h    | 32 ++++++++++++++++++++++++++++++++
 kernel/rcu/tree_plugin.h | 31 -------------------------------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 4c2a0189e748..7be3e085ddd6 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -10,6 +10,7 @@
 #include <linux/lockdep.h>
 
 static void rcu_exp_handler(void *unused);
+static int rcu_print_task_exp_stall(struct rcu_node *rnp);
 
 /*
  * Record the start of an expedited grace period.
@@ -670,6 +671,27 @@ static void sync_sched_exp_online_cleanup(int cpu)
 {
 }
 
+/*
+ * Scan the current list of tasks blocked within RCU read-side critical
+ * sections, printing out the tid of each that is blocking the current
+ * expedited grace period.
+ */
+static int rcu_print_task_exp_stall(struct rcu_node *rnp)
+{
+	struct task_struct *t;
+	int ndetected = 0;
+
+	if (!rnp->exp_tasks)
+		return 0;
+	t = list_entry(rnp->exp_tasks->prev,
+		       struct task_struct, rcu_node_entry);
+	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
+		pr_cont(" P%d", t->pid);
+		ndetected++;
+	}
+	return ndetected;
+}
+
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
 /* Invoked on each online non-idle CPU for expedited quiescent state. */
@@ -709,6 +731,16 @@ static void sync_sched_exp_online_cleanup(int cpu)
 	WARN_ON_ONCE(ret);
 }
 
+/*
+ * Because preemptible RCU does not exist, we never have to check for
+ * tasks blocked within RCU read-side critical sections that are
+ * blocking the current expedited grace period.
+ */
+static int rcu_print_task_exp_stall(struct rcu_node *rnp)
+{
+	return 0;
+}
+
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
 /**
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7fa3bc4d481b..72519c57f656 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -642,27 +642,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
 
-/*
- * Scan the current list of tasks blocked within RCU read-side critical
- * sections, printing out the tid of each that is blocking the current
- * expedited grace period.
- */
-static int rcu_print_task_exp_stall(struct rcu_node *rnp)
-{
-	struct task_struct *t;
-	int ndetected = 0;
-
-	if (!rnp->exp_tasks)
-		return 0;
-	t = list_entry(rnp->exp_tasks->prev,
-		       struct task_struct, rcu_node_entry);
-	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
-		pr_cont(" P%d", t->pid);
-		ndetected++;
-	}
-	return ndetected;
-}
-
 /*
  * Check that the list of blocked tasks for the newly completed grace
  * period is in fact empty.  It is a serious bug to complete a grace
@@ -906,16 +885,6 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 }
 static void rcu_preempt_deferred_qs(struct task_struct *t) { }
 
-/*
- * Because preemptible RCU does not exist, we never have to check for
- * tasks blocked within RCU read-side critical sections that are
- * blocking the current expedited grace period.
- */
-static int rcu_print_task_exp_stall(struct rcu_node *rnp)
-{
-	return 0;
-}
-
 /*
  * Because there is no preemptible RCU, there can be no readers blocked,
  * so there is no need to check for blocked tasks.  So check only for
-- 
2.17.1

