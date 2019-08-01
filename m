Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF864C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC25206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbfHAXJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:09:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388027AbfHAXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:08:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71N7C4d059428;
        Thu, 1 Aug 2019 19:08:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48hahr3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:08:13 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71N7jgv061137;
        Thu, 1 Aug 2019 19:08:13 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48hahr2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:08:13 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71N590P013067;
        Thu, 1 Aug 2019 23:08:11 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 2u0e85w7aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 23:08:11 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71N8A3U14353072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:08:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC004B206B;
        Thu,  1 Aug 2019 23:08:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD0F1B2064;
        Thu,  1 Aug 2019 23:08:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:08:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1A02216C9A3D; Thu,  1 Aug 2019 16:08:12 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 02/18] rcu/nocb: Use separate flag to indicate offloaded ->cblist
Date:   Thu,  1 Aug 2019 16:07:54 -0700
Message-Id: <20190801230810.21570-2-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801230744.GA19115@linux.ibm.com>
References: <20190801230744.GA19115@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=716 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU callback processing currently uses rcu_is_nocb_cpu() to determine
whether or not the current CPU's callbacks are to be offloaded.
This works, but it is not so good for cache locality.  Plus use of
->cblist for offloaded callbacks will greatly increase the frequency
of these checks.  This commit therefore adds a ->offloaded flag to the
rcu_segcblist structure to provide a more flexible and cache-friendly
means of checking for callback offloading.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/rcu_segcblist.h |  1 +
 kernel/rcu/rcu_segcblist.c    | 12 ++++++++++++
 kernel/rcu/rcu_segcblist.h    |  7 +++++++
 kernel/rcu/tree.c             | 10 ++++++----
 kernel/rcu/tree_plugin.h      | 11 +++++++----
 5 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index f48888040332..82977726da29 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -68,6 +68,7 @@ struct rcu_segcblist {
 	long len;
 	long len_lazy;
 	u8 enabled;
+	u8 offloaded;
 };
 
 #define RCU_SEGCBLIST_INITIALIZER(n) \
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index b305dcac34c9..700779f4c0cb 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -73,6 +73,18 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
 	rsclp->enabled = 0;
 }
 
+/*
+ * Mark the specified rcu_segcblist structure as offloaded.  This
+ * structure must be empty.
+ */
+void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
+{
+	WARN_ON_ONCE(!rcu_segcblist_empty(rsclp));
+	WARN_ON_ONCE(rcu_segcblist_n_cbs(rsclp));
+	WARN_ON_ONCE(rcu_segcblist_n_lazy_cbs(rsclp));
+	rsclp->offloaded = 1;
+}
+
 /*
  * Does the specified rcu_segcblist structure contain callbacks that
  * are ready to be invoked?
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index b2de7b32da29..8f3783391075 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -66,6 +66,12 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 	return rsclp->enabled;
 }
 
+/* Is the specified rcu_segcblist offloaded?  */
+static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
+{
+	return rsclp->offloaded;
+}
+
 /*
  * Are all segments following the specified segment of the specified
  * rcu_segcblist structure empty of callbacks?  (The specified
@@ -78,6 +84,7 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
 
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
 void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
+void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a14e5fbbea46..6f5c96c4f9a3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2858,10 +2858,11 @@ void rcu_barrier(void)
 	 * corresponding CPU's preceding callbacks have been invoked.
 	 */
 	for_each_possible_cpu(cpu) {
-		if (!cpu_online(cpu) && !rcu_is_nocb_cpu(cpu))
-			continue;
 		rdp = per_cpu_ptr(&rcu_data, cpu);
-		if (rcu_is_nocb_cpu(cpu)) {
+		if (!cpu_online(cpu) &&
+		    !rcu_segcblist_is_offloaded(&rdp->cblist))
+			continue;
+		if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
 			if (!rcu_nocb_cpu_needs_barrier(cpu)) {
 				rcu_barrier_trace(TPS("OfflineNoCB"), cpu,
 						   rcu_state.barrier_sequence);
@@ -3155,7 +3156,8 @@ void rcutree_migrate_callbacks(int cpu)
 	struct rcu_node *rnp_root = rcu_get_root();
 	bool needwake;
 
-	if (rcu_is_nocb_cpu(cpu) || rcu_segcblist_empty(&rdp->cblist))
+	if (rcu_segcblist_is_offloaded(&rdp->cblist) ||
+	    rcu_segcblist_empty(&rdp->cblist))
 		return;  /* No callbacks to migrate. */
 
 	local_irq_save(flags);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b8a43cf9bb4e..fc6133eed50a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1382,7 +1382,7 @@ static void rcu_prepare_for_idle(void)
 	int tne;
 
 	lockdep_assert_irqs_disabled();
-	if (rcu_is_nocb_cpu(smp_processor_id()))
+	if (rcu_segcblist_is_offloaded(&rdp->cblist))
 		return;
 
 	/* Handle nohz enablement switches conservatively. */
@@ -1431,8 +1431,10 @@ static void rcu_prepare_for_idle(void)
  */
 static void rcu_cleanup_after_idle(void)
 {
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+
 	lockdep_assert_irqs_disabled();
-	if (rcu_is_nocb_cpu(smp_processor_id()))
+	if (rcu_segcblist_is_offloaded(&rdp->cblist))
 		return;
 	if (rcu_try_advance_all_cbs())
 		invoke_rcu_core();
@@ -1694,7 +1696,7 @@ static bool __call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *rhp,
 			    bool lazy, unsigned long flags)
 {
 
-	if (!rcu_is_nocb_cpu(rdp->cpu))
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist))
 		return false;
 	__call_rcu_nocb_enqueue(rdp, rhp, &rhp->next, 1, lazy, flags);
 	if (__is_kfree_rcu_offset((unsigned long)rhp->func))
@@ -1729,7 +1731,7 @@ static bool __maybe_unused rcu_nocb_adopt_orphan_cbs(struct rcu_data *my_rdp,
 						     unsigned long flags)
 {
 	lockdep_assert_irqs_disabled();
-	if (!rcu_is_nocb_cpu(smp_processor_id()))
+	if (!rcu_segcblist_is_offloaded(&my_rdp->cblist))
 		return false; /* Not NOCBs CPU, caller must migrate CBs. */
 	__call_rcu_nocb_enqueue(my_rdp, rcu_segcblist_head(&rdp->cblist),
 				rcu_segcblist_tail(&rdp->cblist),
@@ -2192,6 +2194,7 @@ static bool init_nocb_callback_list(struct rcu_data *rdp)
 	}
 	rcu_segcblist_init(&rdp->cblist);
 	rcu_segcblist_disable(&rdp->cblist);
+	rcu_segcblist_offload(&rdp->cblist);
 	return true;
 }
 
-- 
2.17.1

