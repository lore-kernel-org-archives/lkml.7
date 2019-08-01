Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20896C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51022083B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbfHAXJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:09:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388237AbfHAXI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:08:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71N7vQg041884;
        Thu, 1 Aug 2019 19:08:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u477ymeeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:08:14 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71N8Dss043140;
        Thu, 1 Aug 2019 19:08:13 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u477ymedu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:08:13 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71N50Px006222;
        Thu, 1 Aug 2019 23:08:12 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 2u0e85xgns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 23:08:12 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71N8Bw850528762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:08:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52433B2077;
        Thu,  1 Aug 2019 23:08:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 244D8B2068;
        Thu,  1 Aug 2019 23:08:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:08:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 41E4016C9A50; Thu,  1 Aug 2019 16:08:12 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 09/18] rcu/nocb: Leave ->cblist enabled for no-CBs CPUs
Date:   Thu,  1 Aug 2019 16:08:01 -0700
Message-Id: <20190801230810.21570-9-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801230744.GA19115@linux.ibm.com>
References: <20190801230744.GA19115@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a first step towards making no-CBs CPUs use the ->cblist, this commit
leaves the ->cblist enabled for these CPUs.  The main reason to make
no-CBs CPUs use ->cblist is to take advantage of callback numbering,
which will reduce the effects of missed grace periods which in turn will
reduce forward-progress problems for no-CBs CPUs.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcu_segcblist.c |  3 ---
 kernel/rcu/rcu_segcblist.h |  2 +-
 kernel/rcu/tree.c          |  5 +++--
 kernel/rcu/tree.h          |  1 -
 kernel/rcu/tree_plugin.h   | 35 +++++++----------------------------
 5 files changed, 11 insertions(+), 35 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 06435a368be5..9ac28f175627 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -79,9 +79,6 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
 {
-	WARN_ON_ONCE(!rcu_segcblist_empty(rsclp));
-	WARN_ON_ONCE(rcu_segcblist_n_cbs(rsclp));
-	WARN_ON_ONCE(rcu_segcblist_n_lazy_cbs(rsclp));
 	rsclp->offloaded = 1;
 }
 
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index d9142b3590a8..ed3fcece39a9 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -59,7 +59,7 @@ static inline long rcu_segcblist_n_nonlazy_cbs(struct rcu_segcblist *rsclp)
 
 /*
  * Is the specified rcu_segcblist enabled, for example, not corresponding
- * to an offline or callback-offloaded CPU?
+ * to an offline CPU?
  */
 static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 {
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f1a25d17e3a0..2917ce379b23 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2964,7 +2964,8 @@ rcu_boot_init_percpu_data(int cpu)
  * Initializes a CPU's per-CPU RCU data.  Note that only one online or
  * offline event can be happening at a given time.  Note also that we can
  * accept some slop in the rsp->gp_seq access due to the fact that this
- * CPU cannot possibly have any RCU callbacks in flight yet.
+ * CPU cannot possibly have any non-offloaded RCU callbacks in flight yet.
+ * And any offloaded callbacks are being numbered elsewhere.
  */
 int rcutree_prepare_cpu(unsigned int cpu)
 {
@@ -2978,7 +2979,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->n_force_qs_snap = rcu_state.n_force_qs;
 	rdp->blimit = blimit;
 	if (rcu_segcblist_empty(&rdp->cblist) && /* No early-boot CBs? */
-	    !init_nocb_callback_list(rdp))
+	    !rcu_segcblist_is_offloaded(&rdp->cblist))
 		rcu_segcblist_init(&rdp->cblist);  /* Re-enable callbacks. */
 	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
 	rcu_dynticks_eqs_online();
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index dc3c53cb9608..8d9cfcac6757 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -438,7 +438,6 @@ static void __init rcu_spawn_nocb_kthreads(void);
 #ifdef CONFIG_RCU_NOCB_CPU
 static void __init rcu_organize_nocb_kthreads(void);
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
-static bool init_nocb_callback_list(struct rcu_data *rdp);
 static unsigned long rcu_get_n_cbs_nocb_cpu(struct rcu_data *rdp);
 static void rcu_bind_gp_kthread(void);
 static bool rcu_nohz_full_cpu(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9936a66b80bb..2d37fd3fa0d4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2007,6 +2007,7 @@ void __init rcu_init_nohz(void)
 {
 	int cpu;
 	bool need_rcu_nocb_mask = false;
+	struct rcu_data *rdp;
 
 #if defined(CONFIG_NO_HZ_FULL)
 	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
@@ -2040,8 +2041,12 @@ void __init rcu_init_nohz(void)
 	if (rcu_nocb_poll)
 		pr_info("\tPoll for callbacks from no-CBs CPUs.\n");
 
-	for_each_cpu(cpu, rcu_nocb_mask)
-		init_nocb_callback_list(per_cpu_ptr(&rcu_data, cpu));
+	for_each_cpu(cpu, rcu_nocb_mask) {
+		rdp = per_cpu_ptr(&rcu_data, cpu);
+		if (rcu_segcblist_empty(&rdp->cblist))
+			rcu_segcblist_init(&rdp->cblist);
+		rcu_segcblist_offload(&rdp->cblist);
+	}
 	rcu_organize_nocb_kthreads();
 }
 
@@ -2167,27 +2172,6 @@ static void __init rcu_organize_nocb_kthreads(void)
 	}
 }
 
-/* Prevent __call_rcu() from enqueuing callbacks on no-CBs CPUs */
-static bool init_nocb_callback_list(struct rcu_data *rdp)
-{
-	if (!rcu_is_nocb_cpu(rdp->cpu))
-		return false;
-
-	/* If there are early-boot callbacks, move them to nocb lists. */
-	if (!rcu_segcblist_empty(&rdp->cblist)) {
-		rdp->nocb_head = rcu_segcblist_head(&rdp->cblist);
-		rdp->nocb_tail = rcu_segcblist_tail(&rdp->cblist);
-		atomic_long_set(&rdp->nocb_q_count,
-				rcu_segcblist_n_cbs(&rdp->cblist));
-		atomic_long_set(&rdp->nocb_q_count_lazy,
-				rcu_segcblist_n_lazy_cbs(&rdp->cblist));
-	}
-	rcu_segcblist_init(&rdp->cblist);
-	rcu_segcblist_disable(&rdp->cblist);
-	rcu_segcblist_offload(&rdp->cblist);
-	return true;
-}
-
 /*
  * Bind the current task to the offloaded CPUs.  If there are no offloaded
  * CPUs, leave the task unbound.  Splat if the bind attempt fails.
@@ -2263,11 +2247,6 @@ static void __init rcu_spawn_nocb_kthreads(void)
 {
 }
 
-static bool init_nocb_callback_list(struct rcu_data *rdp)
-{
-	return false;
-}
-
 static unsigned long rcu_get_n_cbs_nocb_cpu(struct rcu_data *rdp)
 {
 	return 0;
-- 
2.17.1

