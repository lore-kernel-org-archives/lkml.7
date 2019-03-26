Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB19C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20192087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbfCZXXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:23:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732947AbfCZXWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:22:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNIapT051243
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:34 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfuftcsct-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:33 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:22:32 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:22:27 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNMQ8417301626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:22:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3874CB2074;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19D47B2072;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DFDCD16C6125; Tue, 26 Mar 2019 16:22:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 09/11] rcu: Move irq-disabled stall-warning checking to tree_stall.h
Date:   Tue, 26 Mar 2019 16:22:23 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326232208.GA20384@linux.ibm.com>
References: <20190326232208.GA20384@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0064-0000-0000-000003C06EC9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180136; UDB=6.00617574; IPR=6.00960851;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:22:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0065-0000-0000-00003CD8B778
Message-Id: <20190326232225.21332-9-paulmck@linux.ibm.com>
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

The rcu_iw_handler() function's sole purpose in life is to indicate
whether a stalled CPU had interrupts disabled, so it belongs in
kernel/rcu/tree_stall.h.  This commit therefore makes that move,
clarifying its header comment while in the area.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c       | 21 ---------------------
 kernel/rcu/tree.h       |  1 +
 kernel/rcu/tree_stall.h | 20 ++++++++++++++++++++
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 001dd05f6e38..929531ed168c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1031,27 +1031,6 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 	return 0;
 }
 
-/*
- * Handler for the irq_work request posted when a grace period has
- * gone on for too long, but not yet long enough for an RCU CPU
- * stall warning.  Set state appropriately, but just complain if
- * there is unexpected state on entry.
- */
-static void rcu_iw_handler(struct irq_work *iwp)
-{
-	struct rcu_data *rdp;
-	struct rcu_node *rnp;
-
-	rdp = container_of(iwp, struct rcu_data, rcu_iw);
-	rnp = rdp->mynode;
-	raw_spin_lock_rcu_node(rnp);
-	if (!WARN_ON_ONCE(!rdp->rcu_iw_pending)) {
-		rdp->rcu_iw_gp_seq = rnp->gp_seq;
-		rdp->rcu_iw_pending = false;
-	}
-	raw_spin_unlock_rcu_node(rnp);
-}
-
 /*
  * Return true if the specified CPU has passed through a quiescent
  * state by virtue of being in or having passed through an dynticks
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 099410dbcbe9..f882ce3ca5a5 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -443,4 +443,5 @@ static void rcu_dynticks_task_exit(void);
 
 /* Forward declarations for tree_stall.h */
 static void record_gp_stall_check_time(void);
+static void rcu_iw_handler(struct irq_work *iwp);
 static void check_cpu_stall(struct rcu_data *rdp);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 03ed47883d8a..526e223e41ce 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -139,6 +139,26 @@ static void rcu_stall_kick_kthreads(void)
 	}
 }
 
+/*
+ * Handler for the irq_work request posted about halfway into the RCU CPU
+ * stall timeout, and used to detect excessive irq disabling.  Set state
+ * appropriately, but just complain if there is unexpected state on entry.
+ */
+static void rcu_iw_handler(struct irq_work *iwp)
+{
+	struct rcu_data *rdp;
+	struct rcu_node *rnp;
+
+	rdp = container_of(iwp, struct rcu_data, rcu_iw);
+	rnp = rdp->mynode;
+	raw_spin_lock_rcu_node(rnp);
+	if (!WARN_ON_ONCE(!rdp->rcu_iw_pending)) {
+		rdp->rcu_iw_gp_seq = rnp->gp_seq;
+		rdp->rcu_iw_pending = false;
+	}
+	raw_spin_unlock_rcu_node(rnp);
+}
+
 //////////////////////////////////////////////////////////////////////////////
 //
 // Printing RCU CPU stall warnings
-- 
2.17.1

