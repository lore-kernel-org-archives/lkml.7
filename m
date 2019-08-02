Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDC1C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B53D204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbfHBPPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:15:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387683AbfHBPPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:15:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72F7iLW182825
        for <linux-kernel@vger.kernel.org>; Fri, 2 Aug 2019 11:15:07 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u4nckp7wk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 11:15:07 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Aug 2019 16:15:06 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Aug 2019 16:15:01 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72FF0Im48234838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 15:15:00 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92235B206E;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63F2CB205F;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DED7C16C9993; Fri,  2 Aug 2019 08:15:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC tip/core/rcu 01/14] rcu/nocb: Atomic ->len field in rcu_segcblist structure
Date:   Fri,  2 Aug 2019 08:14:48 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802151435.GA1081@linux.ibm.com>
References: <20190802151435.GA1081@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080215-0052-0000-0000-000003E80574
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011538; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01241059; UDB=6.00654494; IPR=6.01022491;
 MB=3.00028010; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-02 15:15:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080215-0053-0000-0000-000061F15F14
Message-Id: <20190802151501.13069-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upcoming ->nocb_lock contention-reduction work requires that the
rcu_segcblist structure's ->len field be concurrently manipulated,
but only if there are no-CBs CPUs in the kernel.  This commit
therefore makes this ->len field be an atomic_long_t, but only
in CONFIG_RCU_NOCB_CPU=y kernels.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/rcu_segcblist.h |  4 ++
 kernel/rcu/rcu_segcblist.c    | 86 ++++++++++++++++++++++++++++++++---
 kernel/rcu/rcu_segcblist.h    | 12 ++++-
 3 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 82977726da29..38e4b811af9b 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -65,7 +65,11 @@ struct rcu_segcblist {
 	struct rcu_head *head;
 	struct rcu_head **tails[RCU_CBLIST_NSEGS];
 	unsigned long gp_seq[RCU_CBLIST_NSEGS];
+#ifdef CONFIG_RCU_NOCB_CPU
+	atomic_long_t len;
+#else
 	long len;
+#endif
 	long len_lazy;
 	u8 enabled;
 	u8 offloaded;
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 92968b856593..ff431cc83037 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -23,6 +23,19 @@ void rcu_cblist_init(struct rcu_cblist *rclp)
 	rclp->len_lazy = 0;
 }
 
+/*
+ * Enqueue an rcu_head structure onto the specified callback list.
+ * This function assumes that the callback is non-lazy because it
+ * is intended for use by no-CBs CPUs, which do not distinguish
+ * between lazy and non-lazy RCU callbacks.
+ */
+void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp)
+{
+	*rclp->tail = rhp;
+	rclp->tail = &rhp->next;
+	WRITE_ONCE(rclp->len, rclp->len + 1);
+}
+
 /*
  * Dequeue the oldest rcu_head structure from the specified callback
  * list.  This function assumes that the callback is non-lazy, but
@@ -44,6 +57,67 @@ struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp)
 	return rhp;
 }
 
+/* Set the length of an rcu_segcblist structure. */
+void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	atomic_long_set(&rsclp->len, v);
+#else
+	WRITE_ONCE(rsclp->len, v);
+#endif
+}
+
+/*
+ * Increase the numeric length of an rcu_segcblist structure by the
+ * specified amount, which can be negative.  This can cause the ->len
+ * field to disagree with the actual number of callbacks on the structure.
+ * This increase is fully ordered with respect to the callers accesses
+ * both before and after.
+ */
+void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	smp_mb__before_atomic(); /* Up to the caller! */
+	atomic_long_add(v, &rsclp->len);
+	smp_mb__after_atomic(); /* Up to the caller! */
+#else
+	smp_mb(); /* Up to the caller! */
+	WRITE_ONCE(rsclp->len, rsclp->len + v);
+	smp_mb(); /* Up to the caller! */
+#endif
+}
+
+/*
+ * Increase the numeric length of an rcu_segcblist structure by one.
+ * This can cause the ->len field to disagree with the actual number of
+ * callbacks on the structure.  This increase is fully ordered with respect
+ * to the callers accesses both before and after.
+ */
+void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp)
+{
+	rcu_segcblist_add_len(rsclp, 1);
+}
+
+/*
+ * Exchange the numeric length of the specified rcu_segcblist structure
+ * with the specified value.  This can cause the ->len field to disagree
+ * with the actual number of callbacks on the structure.  This exchange is
+ * fully ordered with respect to the callers accesses both before and after.
+ */
+long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	return atomic_long_xchg(&rsclp->len, v);
+#else
+	long ret = rsclp->len;
+
+	smp_mb(); /* Up to the caller! */
+	WRITE_ONCE(rsclp->len, v);
+	smp_mb(); /* Up to the caller! */
+	return ret;
+#endif
+}
+
 /*
  * Initialize an rcu_segcblist structure.
  */
@@ -56,7 +130,7 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
 	rsclp->head = NULL;
 	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
 		rsclp->tails[i] = &rsclp->head;
-	rsclp->len = 0;
+	rcu_segcblist_set_len(rsclp, 0);
 	rsclp->len_lazy = 0;
 	rsclp->enabled = 1;
 }
@@ -151,7 +225,7 @@ bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp)
 void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp, bool lazy)
 {
-	WRITE_ONCE(rsclp->len, rsclp->len + 1); /* ->len sampled locklessly. */
+	rcu_segcblist_inc_len(rsclp);
 	if (lazy)
 		rsclp->len_lazy++;
 	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
@@ -177,7 +251,7 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 
 	if (rcu_segcblist_n_cbs(rsclp) == 0)
 		return false;
-	WRITE_ONCE(rsclp->len, rsclp->len + 1);
+	rcu_segcblist_inc_len(rsclp);
 	if (lazy)
 		rsclp->len_lazy++;
 	smp_mb(); /* Ensure counts are updated before callback is entrained. */
@@ -204,9 +278,8 @@ void rcu_segcblist_extract_count(struct rcu_segcblist *rsclp,
 					       struct rcu_cblist *rclp)
 {
 	rclp->len_lazy += rsclp->len_lazy;
-	rclp->len += rsclp->len;
 	rsclp->len_lazy = 0;
-	WRITE_ONCE(rsclp->len, 0); /* ->len sampled locklessly. */
+	rclp->len = rcu_segcblist_xchg_len(rsclp, 0);
 }
 
 /*
@@ -259,8 +332,7 @@ void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
 				struct rcu_cblist *rclp)
 {
 	rsclp->len_lazy += rclp->len_lazy;
-	/* ->len sampled locklessly. */
-	WRITE_ONCE(rsclp->len, rsclp->len + rclp->len);
+	rcu_segcblist_add_len(rsclp, rclp->len);
 	rclp->len_lazy = 0;
 	rclp->len = 0;
 }
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index db38f0a512c4..1ff996647d3c 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -9,6 +9,12 @@
 
 #include <linux/rcu_segcblist.h>
 
+/* Return number of callbacks in the specified callback list. */
+static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
+{
+	return READ_ONCE(rclp->len);
+}
+
 /*
  * Account for the fact that a previously dequeued callback turned out
  * to be marked as lazy.
@@ -42,7 +48,11 @@ static inline bool rcu_segcblist_empty(struct rcu_segcblist *rsclp)
 /* Return number of callbacks in segmented callback list. */
 static inline long rcu_segcblist_n_cbs(struct rcu_segcblist *rsclp)
 {
+#ifdef CONFIG_RCU_NOCB_CPU
+	return atomic_long_read(&rsclp->len);
+#else
 	return READ_ONCE(rsclp->len);
+#endif
 }
 
 /* Return number of lazy callbacks in segmented callback list. */
@@ -54,7 +64,7 @@ static inline long rcu_segcblist_n_lazy_cbs(struct rcu_segcblist *rsclp)
 /* Return number of lazy callbacks in segmented callback list. */
 static inline long rcu_segcblist_n_nonlazy_cbs(struct rcu_segcblist *rsclp)
 {
-	return rsclp->len - rsclp->len_lazy;
+	return rcu_segcblist_n_cbs(rsclp) - rsclp->len_lazy;
 }
 
 /*
-- 
2.17.1

