Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5865C32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF292080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390300AbfHAXIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:08:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390239AbfHAXIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:08:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71N7CFS040156
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 19:08:18 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u475rvh62-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 19:08:18 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Aug 2019 00:08:17 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Aug 2019 00:08:12 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71N8BVE46006722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:08:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57800B2079;
        Thu,  1 Aug 2019 23:08:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A94BB206C;
        Thu,  1 Aug 2019 23:08:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:08:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 53DB716C9A53; Thu,  1 Aug 2019 16:08:12 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 12/18] rcu/nocb: Remove obsolete nocb_q_count and nocb_q_count_lazy fields
Date:   Thu,  1 Aug 2019 16:08:04 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801230744.GA19115@linux.ibm.com>
References: <20190801230744.GA19115@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080123-2213-0000-0000-000003B87401
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240744; UDB=6.00654300; IPR=6.01022167;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 23:08:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080123-2214-0000-0000-00005F7BA35C
Message-Id: <20190801230810.21570-12-paulmck@linux.ibm.com>
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

This commit removes the obsolete nocb_q_count and nocb_q_count_lazy
fields, also removing rcu_get_n_cbs_nocb_cpu(), adjusting
rcu_get_n_cbs_cpu(), and making rcutree_migrate_callbacks() once again
disable the ->cblist fields of offline CPUs.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c        |  6 +++---
 kernel/rcu/tree.h        |  3 ---
 kernel/rcu/tree_plugin.h | 14 --------------
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 054418d2d960..e5f30b364276 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -210,10 +210,9 @@ static long rcu_get_n_cbs_cpu(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
-	if (rcu_segcblist_is_enabled(&rdp->cblist) &&
-	    !rcu_segcblist_is_offloaded(&rdp->cblist)) /* Online normal CPU? */
+	if (rcu_segcblist_is_enabled(&rdp->cblist))
 		return rcu_segcblist_n_cbs(&rdp->cblist);
-	return rcu_get_n_cbs_nocb_cpu(rdp); /* Works for offline, too. */
+	return 0;
 }
 
 void rcu_softirq_qs(void)
@@ -3181,6 +3180,7 @@ void rcutree_migrate_callbacks(int cpu)
 	needwake = rcu_advance_cbs(my_rnp, rdp) ||
 		   rcu_advance_cbs(my_rnp, my_rdp);
 	rcu_segcblist_merge(&my_rdp->cblist, &rdp->cblist);
+	rcu_segcblist_disable(&rdp->cblist);
 	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) !=
 		     !rcu_segcblist_n_cbs(&my_rdp->cblist));
 	if (rcu_segcblist_is_offloaded(&my_rdp->cblist)) {
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 74e3a4ab8095..d1df192272fb 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -194,8 +194,6 @@ struct rcu_data {
 
 	/* 5) Callback offloading. */
 #ifdef CONFIG_RCU_NOCB_CPU
-	atomic_long_t nocb_q_count;	/* # CBs waiting for nocb */
-	atomic_long_t nocb_q_count_lazy; /*  invocation (all stages). */
 	struct rcu_head *nocb_cb_head;	/* CBs ready to invoke. */
 	struct rcu_head **nocb_cb_tail;
 	struct swait_queue_head nocb_cb_wq; /* For nocb kthreads to sleep on. */
@@ -437,7 +435,6 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 #ifdef CONFIG_RCU_NOCB_CPU
 static void __init rcu_organize_nocb_kthreads(void);
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
-static unsigned long rcu_get_n_cbs_nocb_cpu(struct rcu_data *rdp);
 static void rcu_bind_gp_kthread(void);
 static bool rcu_nohz_full_cpu(void);
 static void rcu_dynticks_task_enter(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 838e0caaf53a..458838c63a6c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2040,15 +2040,6 @@ void rcu_bind_current_to_nocb(void)
 }
 EXPORT_SYMBOL_GPL(rcu_bind_current_to_nocb);
 
-/*
- * Return the number of RCU callbacks still queued from the specified
- * CPU, which must be a nocbs CPU.
- */
-static unsigned long rcu_get_n_cbs_nocb_cpu(struct rcu_data *rdp)
-{
-	return atomic_long_read(&rdp->nocb_q_count);
-}
-
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 
 /* No ->nocb_lock to acquire.  */
@@ -2108,11 +2099,6 @@ static void __init rcu_spawn_nocb_kthreads(void)
 {
 }
 
-static unsigned long rcu_get_n_cbs_nocb_cpu(struct rcu_data *rdp)
-{
-	return 0;
-}
-
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
 /*
-- 
2.17.1

