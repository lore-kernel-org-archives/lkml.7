Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F3CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C5B2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfHAXQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:16:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733166AbfHAXQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:16:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71NDgxB012527
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 19:16:43 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u47v13aes-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 19:16:42 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Aug 2019 00:16:42 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Aug 2019 00:16:36 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71NGZah53543204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:16:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC637B2066;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B12DB2068;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0AEA016C9A4C; Thu,  1 Aug 2019 16:16:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 05/10] rcu/nocb: Avoid ->nocb_lock capture by corresponding CPU
Date:   Thu,  1 Aug 2019 16:16:30 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801231619.GA22610@linux.ibm.com>
References: <20190801231619.GA22610@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080123-0060-0000-0000-0000036772B8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240747; UDB=6.00654302; IPR=6.01022171;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 23:16:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080123-0061-0000-0000-00004A628E29
Message-Id: <20190801231636.23115-5-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A given rcu_data structure's ->nocb_lock can be acquired very frequently
by the corresponding CPU and occasionally by the corresponding no-CBs
grace-period and callbacks kthreads.  In particular, these two kthreads
will have frequent gaps between ->nocb_lock acquisitions that are roughly
a grace period in duration.  This means that any excessive ->nocb_lock
contention will be due to the CPU's acquisitions, and this in turn
enables a very naive contention-avoidance strategy to be quite effective.

This commit therefore modifies rcu_nocb_lock() to first
attempt a raw_spin_trylock(), and to atomically increment a
separate ->nocb_lock_contended across a raw_spin_lock().  This new
->nocb_lock_contended field is checked in __call_rcu_nocb_wake() when
interrupts are enabled, with a spin-wait for contending acquisitions
to complete, thus allowing the kthreads a chance to acquire the lock.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.h        | 18 ++++++++++-
 kernel/rcu/tree_plugin.h | 68 ++++++++++++++++++++++++++--------------
 2 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index c12e85c12310..7062f9d9c053 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -197,6 +197,7 @@ struct rcu_data {
 	struct swait_queue_head nocb_cb_wq; /* For nocb kthreads to sleep on. */
 	struct task_struct *nocb_gp_kthread;
 	raw_spinlock_t nocb_lock;	/* Guard following pair of fields. */
+	atomic_t nocb_lock_contended;	/* Contention experienced. */
 	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
 
@@ -430,7 +431,22 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 				       unsigned long flags);
 #ifdef CONFIG_RCU_NOCB_CPU
 static void __init rcu_organize_nocb_kthreads(void);
-#endif /* #ifdef CONFIG_RCU_NOCB_CPU */
+#define rcu_nocb_lock_irqsave(rdp, flags)				\
+do {									\
+	if (!rcu_segcblist_is_offloaded(&(rdp)->cblist)) {		\
+		local_irq_save(flags);					\
+	} else if (!raw_spin_trylock_irqsave(&(rdp)->nocb_lock, (flags))) {\
+		atomic_inc(&(rdp)->nocb_lock_contended);		\
+		smp_mb__after_atomic(); /* atomic_inc() before lock. */	\
+		raw_spin_lock_irqsave(&(rdp)->nocb_lock, (flags));	\
+		smp_mb__before_atomic(); /* atomic_dec() after lock. */	\
+		atomic_dec(&(rdp)->nocb_lock_contended);		\
+	}								\
+} while (0)
+#else /* #ifdef CONFIG_RCU_NOCB_CPU */
+#define rcu_nocb_lock_irqsave(rdp, flags) local_irq_save(flags)
+#endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
+
 static void rcu_bind_gp_kthread(void);
 static bool rcu_nohz_full_cpu(void);
 static void rcu_dynticks_task_enter(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index bda86098ca38..b6d9ed169edc 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1496,14 +1496,36 @@ early_param("rcu_nocb_poll", parse_rcu_nocb_poll);
 
 /*
  * Acquire the specified rcu_data structure's ->nocb_lock, but only
- * if it corresponds to a no-CBs CPU.
+ * if it corresponds to a no-CBs CPU.  If the lock isn't immediately
+ * available, increment ->nocb_lock_contended to flag the contention.
  */
 static void rcu_nocb_lock(struct rcu_data *rdp)
 {
-	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
-		lockdep_assert_irqs_disabled();
-		raw_spin_lock(&rdp->nocb_lock);
-	}
+	lockdep_assert_irqs_disabled();
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist) ||
+	    raw_spin_trylock(&rdp->nocb_lock))
+		return;
+	atomic_inc(&rdp->nocb_lock_contended);
+	smp_mb__after_atomic(); /* atomic_inc() before lock. */
+	raw_spin_lock(&rdp->nocb_lock);
+	smp_mb__before_atomic(); /* atomic_dec() after lock. */
+	atomic_dec(&rdp->nocb_lock_contended);
+}
+
+/*
+ * Spinwait until the specified rcu_data structure's ->nocb_lock is
+ * not contended.  Please note that this is extremely special-purpose,
+ * relying on the fact that at most two kthreads and one CPU contend for
+ * this lock, and also that the two kthreads are guaranteed to have frequent
+ * grace-period-duration time intervals between successive acquisitions
+ * of the lock.  This allows us to use an extremely simple throttling
+ * mechanism, and further to apply it only to the CPU doing floods of
+ * call_rcu() invocations.  Don't try this at home!
+ */
+static void rcu_nocb_wait_contended(struct rcu_data *rdp)
+{
+	while (atomic_read(&rdp->nocb_lock_contended))
+		cpu_relax();
 }
 
 /*
@@ -1573,19 +1595,19 @@ static void wake_nocb_gp(struct rcu_data *rdp, bool force,
 
 	lockdep_assert_held(&rdp->nocb_lock);
 	if (!READ_ONCE(rdp_gp->nocb_gp_kthread)) {
-		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 		return;
 	}
 	if (READ_ONCE(rdp_gp->nocb_gp_sleep) || force) {
 		del_timer(&rdp->nocb_timer);
-		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 		smp_mb(); /* enqueue before ->nocb_gp_sleep. */
-		raw_spin_lock_irqsave(&rdp_gp->nocb_lock, flags);
+		rcu_nocb_lock_irqsave(rdp_gp, flags);
 		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
-		raw_spin_unlock_irqrestore(&rdp_gp->nocb_lock, flags);
+		rcu_nocb_unlock_irqrestore(rdp_gp, flags);
 		wake_up_process(rdp_gp->nocb_gp_kthread);
 	} else {
-		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 	}
 }
 
@@ -1644,23 +1666,23 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		if (!rdp->nocb_cb_sleep &&
 		    rcu_segcblist_ready_cbs(&rdp->cblist)) {
 			// Already going full tilt, so don't try to rewake.
-			rcu_nocb_unlock_irqrestore(rdp, flags);
 		} else if (rcu_segcblist_pend_cbs(&rdp->cblist) &&
 			   raw_spin_trylock_rcu_node(rdp->mynode)) {
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			raw_spin_unlock_rcu_node(rdp->mynode);
-			rcu_nocb_unlock_irqrestore(rdp, flags);
 		} else {
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					   TPS("WakeOvfIsDeferred"));
-			rcu_nocb_unlock_irqrestore(rdp, flags);
 		}
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 	} else {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 	}
-	if (!irqs_disabled_flags(flags))
+	if (!irqs_disabled_flags(flags)) {
 		lockdep_assert_irqs_enabled();
+		rcu_nocb_wait_contended(rdp);
+	}
 	return;
 }
 
@@ -1690,7 +1712,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		if (rcu_segcblist_empty(&rdp->cblist))
 			continue; /* No callbacks here, try next. */
 		rnp = rdp->mynode;
-		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+		rcu_nocb_lock_irqsave(rdp, flags);
 		WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
 		del_timer(&my_rdp->nocb_timer);
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
@@ -1710,7 +1732,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		} else {
 			needwake = false;
 		}
-		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 		if (needwake) {
 			swake_up_one(&rdp->nocb_cb_wq);
 			gotcbs = true;
@@ -1739,9 +1761,9 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("EndWait"));
 	}
 	if (!rcu_nocb_poll) {
-		raw_spin_lock_irqsave(&my_rdp->nocb_lock, flags);
+		rcu_nocb_lock_irqsave(my_rdp, flags);
 		WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
-		raw_spin_unlock_irqrestore(&my_rdp->nocb_lock, flags);
+		rcu_nocb_unlock_irqrestore(my_rdp, flags);
 	}
 	WARN_ON(signal_pending(current));
 }
@@ -1782,12 +1804,12 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	rcu_do_batch(rdp);
 	local_bh_enable();
 	lockdep_assert_irqs_enabled();
-	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+	rcu_nocb_lock_irqsave(rdp, flags);
 	raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
 	needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
 	raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 	if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
-		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 		if (needwake_gp)
 			rcu_gp_kthread_wake();
 		return;
@@ -1795,7 +1817,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
 	WRITE_ONCE(rdp->nocb_cb_sleep, true);
-	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+	rcu_nocb_unlock_irqrestore(rdp, flags);
 	if (needwake_gp)
 		rcu_gp_kthread_wake();
 	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
@@ -1837,9 +1859,9 @@ static void do_nocb_deferred_wakeup_common(struct rcu_data *rdp)
 	unsigned long flags;
 	int ndw;
 
-	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+	rcu_nocb_lock_irqsave(rdp, flags);
 	if (!rcu_nocb_need_deferred_wakeup(rdp)) {
-		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 		return;
 	}
 	ndw = READ_ONCE(rdp->nocb_defer_wakeup);
-- 
2.17.1

