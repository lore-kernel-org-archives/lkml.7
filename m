Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF66C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A532087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbfCZXPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:15:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732815AbfCZXPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:15:41 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QN9MGB114379
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:15:40 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfst60umc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:15:39 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:15:38 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:15:33 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNFWZs24707224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:15:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F055B2064;
        Tue, 26 Mar 2019 23:15:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B0BEB2068;
        Tue, 26 Mar 2019 23:15:31 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:15:31 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 87F8516C60F7; Tue, 26 Mar 2019 16:15:32 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 2/2] srcu: Remove cleanup_srcu_struct_quiesced()
Date:   Tue, 26 Mar 2019 16:15:31 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326231512.GA19843@linux.ibm.com>
References: <20190326231512.GA19843@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0040-0000-0000-000004D7AED7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180134; UDB=6.00606765; IPR=6.00960849;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:15:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0041-0000-0000-000008E2D025
Message-Id: <20190326231531.20047-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=38 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cleanup_srcu_struct_quiesced() function was added because NVME
used WQ_MEM_RECLAIM workqueues and SRCU did not, which meant that
NVME workqueues waiting on SRCU workqueues could result in deadlocks
during low-memory conditions.  However, SRCU now also has WQ_MEM_RECLAIM
workqueues, so there is no longer a potential for deadlock.  Furthermore,
it turns out to be extremely hard to use cleanup_srcu_struct_quiesced()
correctly due to the fact that SRCU callback invocation accesses the
srcu_struct structure's per-CPU data area just after callbacks are
invoked.  Therefore, the usual practice of using srcu_barrier() to wait
for callbacks to be invoked before invoking cleanup_srcu_struct_quiesced()
fails because SRCU's callback-invocation workqueue handler might be
delayed, which can result in cleanup_srcu_struct_quiesced() being invoked
(and thus freeing the per-CPU data) before the SRCU's callback-invocation
workqueue handler is finished using that per-CPU data.  Nor is this a
theoretical problem: KASAN emitted use-after-free warnings because of
this problem on actual runs.

In short, NVME can now safely invoke cleanup_srcu_struct(), which
avoids the use-after-free scenario.  And cleanup_srcu_struct_quiesced()
is quite difficult to use safely.  This commit therefore removes
cleanup_srcu_struct_quiesced(), switching its sole user back to
cleanup_srcu_struct().  This effectively reverts the following pair
of commits:

f7194ac32ca2 ("srcu: Add cleanup_srcu_struct_quiesced()")
4317228ad9b8 ("nvme: Avoid flush dependency in delete controller flow")

Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/host/core.c |  2 +-
 include/linux/srcu.h     | 36 +-----------------------------------
 kernel/rcu/rcutorture.c  |  7 +------
 kernel/rcu/srcutiny.c    |  9 +++------
 kernel/rcu/srcutree.c    | 30 ++++++++++++------------------
 5 files changed, 18 insertions(+), 66 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 470601980794..739c5b4830d7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -388,7 +388,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	nvme_mpath_remove_disk(head);
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	list_del_init(&head->entry);
-	cleanup_srcu_struct_quiesced(&head->srcu);
+	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
 	kfree(head);
 }
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index c495b2d51569..e432cc92c73d 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -56,45 +56,11 @@ struct srcu_struct { };
 
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
 		void (*func)(struct rcu_head *head));
-void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced);
+void cleanup_srcu_struct(struct srcu_struct *ssp);
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
 void synchronize_srcu(struct srcu_struct *ssp);
 
-/**
- * cleanup_srcu_struct - deconstruct a sleep-RCU structure
- * @ssp: structure to clean up.
- *
- * Must invoke this after you are finished using a given srcu_struct that
- * was initialized via init_srcu_struct(), else you leak memory.
- */
-static inline void cleanup_srcu_struct(struct srcu_struct *ssp)
-{
-	_cleanup_srcu_struct(ssp, false);
-}
-
-/**
- * cleanup_srcu_struct_quiesced - deconstruct a quiesced sleep-RCU structure
- * @ssp: structure to clean up.
- *
- * Must invoke this after you are finished using a given srcu_struct that
- * was initialized via init_srcu_struct(), else you leak memory.  Also,
- * all grace-period processing must have completed.
- *
- * "Completed" means that the last synchronize_srcu() and
- * synchronize_srcu_expedited() calls must have returned before the call
- * to cleanup_srcu_struct_quiesced().  It also means that the callback
- * from the last call_srcu() must have been invoked before the call to
- * cleanup_srcu_struct_quiesced(), but you can use srcu_barrier() to help
- * with this last.  Violating these rules will get you a WARN_ON() splat
- * (with high probability, anyway), and will also cause the srcu_struct
- * to be leaked.
- */
-static inline void cleanup_srcu_struct_quiesced(struct srcu_struct *ssp)
-{
-	_cleanup_srcu_struct(ssp, true);
-}
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 /**
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f14d1b18a74f..d2b226110835 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -592,12 +592,7 @@ static void srcu_torture_init(void)
 
 static void srcu_torture_cleanup(void)
 {
-	static DEFINE_TORTURE_RANDOM(rand);
-
-	if (torture_random(&rand) & 0x800)
-		cleanup_srcu_struct(&srcu_ctld);
-	else
-		cleanup_srcu_struct_quiesced(&srcu_ctld);
+	cleanup_srcu_struct(&srcu_ctld);
 	srcu_ctlp = &srcu_ctl; /* In case of a later rcutorture run. */
 }
 
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 5d4a39a6505a..44d6606b8325 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -76,19 +76,16 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
  * Must invoke this after you are finished using a given srcu_struct that
  * was initialized via init_srcu_struct(), else you leak memory.
  */
-void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
+void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	WARN_ON(ssp->srcu_lock_nesting[0] || ssp->srcu_lock_nesting[1]);
-	if (quiesced)
-		WARN_ON(work_pending(&ssp->srcu_work));
-	else
-		flush_work(&ssp->srcu_work);
+	flush_work(&ssp->srcu_work);
 	WARN_ON(ssp->srcu_gp_running);
 	WARN_ON(ssp->srcu_gp_waiting);
 	WARN_ON(ssp->srcu_cb_head);
 	WARN_ON(&ssp->srcu_cb_head != ssp->srcu_cb_tail);
 }
-EXPORT_SYMBOL_GPL(_cleanup_srcu_struct);
+EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
 
 /*
  * Removes the count for the old reader from the appropriate element of
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 4f30f3ecabc1..9b761e546de8 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -360,8 +360,14 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 	return SRCU_INTERVAL;
 }
 
-/* Helper for cleanup_srcu_struct() and cleanup_srcu_struct_quiesced(). */
-void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
+/**
+ * cleanup_srcu_struct - deconstruct a sleep-RCU structure
+ * @ssp: structure to clean up.
+ *
+ * Must invoke this after you are finished using a given srcu_struct that
+ * was initialized via init_srcu_struct(), else you leak memory.
+ */
+void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	int cpu;
 
@@ -369,24 +375,12 @@ void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
 		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(ssp)))
 		return; /* Just leak it! */
-	if (quiesced) {
-		if (WARN_ON(delayed_work_pending(&ssp->work)))
-			return; /* Just leak it! */
-	} else {
-		flush_delayed_work(&ssp->work);
-	}
+	flush_delayed_work(&ssp->work);
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		if (quiesced) {
-			if (WARN_ON(timer_pending(&sdp->delay_work)))
-				return; /* Just leak it! */
-			if (WARN_ON(work_pending(&sdp->work)))
-				return; /* Just leak it! */
-		} else {
-			del_timer_sync(&sdp->delay_work);
-			flush_work(&sdp->work);
-		}
+		del_timer_sync(&sdp->delay_work);
+		flush_work(&sdp->work);
 		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
 			return; /* Forgot srcu_barrier(), so just leak it! */
 	}
@@ -399,7 +393,7 @@ void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
 	free_percpu(ssp->sda);
 	ssp->sda = NULL;
 }
-EXPORT_SYMBOL_GPL(_cleanup_srcu_struct);
+EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
 
 /*
  * Counts the new reader in the appropriate per-CPU element of the
-- 
2.17.1

