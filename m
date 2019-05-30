Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D67C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CB825C5D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfE3PI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:08:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727450AbfE3PI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:08:56 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UF2esn008314
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:08:54 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stg3bv8yu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:08:54 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 16:08:53 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 16:08:48 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UF8l0V33685858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:08:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D063CB206A;
        Thu, 30 May 2019 15:08:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A87CFB2071;
        Thu, 30 May 2019 15:08:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:08:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 75E3B16C5D85; Thu, 30 May 2019 08:08:48 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 4/4] rcu/sync: Simplify the state machine
Date:   Thu, 30 May 2019 08:08:46 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530150816.GA32130@linux.ibm.com>
References: <20190530150816.GA32130@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053015-2213-0000-0000-00000397F59A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210788; UDB=6.00636159; IPR=6.00991823;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 15:08:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053015-2214-0000-0000-00005EA302D7
Message-Id: <20190530150846.32644-4-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@redhat.com>

With this patch rcu_sync has a single state variable and the transition rules
become really simple:

	GP_IDLE   - owned by the first rcu_sync_enter() which moves it to

	GP_ENTER  - owned by rcu-callback which moves it to

	GP_PASSED - owned by the last rcu_sync_exit() which moves it to

	GP_EXIT   - and this is the only "nontrivial" state.

		rcu-callback moves it back to GP_IDLE unless another enter()
		comes before a GP pass.

		If rcu-callback is invoked before the next rcu_sync_exit() it
		must see gp_count incremented by that enter() and set GP_PASSED.

		Otherwise, if the next rcu_sync_exit() wins the race, it will
		move it to

	GP_REPLAY - owned by rcu-callback which moves it to GP_EXIT

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
[ paulmck: While here, apply READ_ONCE() and WRITE_ONCE() to ->gp_state. ]
[ paulmck: Tweaks to make htmldocs happy. (Reported by kbuild test robot.) ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/rcu_sync.h |   4 +-
 kernel/rcu/sync.c        | 165 ++++++++++++++++++++++-----------------
 2 files changed, 96 insertions(+), 73 deletions(-)

diff --git a/include/linux/rcu_sync.h b/include/linux/rcu_sync.h
index 87971e85519c..9b83865d24f9 100644
--- a/include/linux/rcu_sync.h
+++ b/include/linux/rcu_sync.h
@@ -19,7 +19,6 @@ struct rcu_sync {
 	int			gp_count;
 	wait_queue_head_t	gp_wait;
 
-	int			cb_state;
 	struct rcu_head		cb_head;
 };
 
@@ -36,7 +35,7 @@ static inline bool rcu_sync_is_idle(struct rcu_sync *rsp)
 			 !rcu_read_lock_bh_held() &&
 			 !rcu_read_lock_sched_held(),
 			 "suspicious rcu_sync_is_idle() usage");
-	return !rsp->gp_state; /* GP_IDLE */
+	return !READ_ONCE(rsp->gp_state); /* GP_IDLE */
 }
 
 extern void rcu_sync_init(struct rcu_sync *);
@@ -49,7 +48,6 @@ extern void rcu_sync_dtor(struct rcu_sync *);
 		.gp_state = 0,						\
 		.gp_count = 0,						\
 		.gp_wait = __WAIT_QUEUE_HEAD_INITIALIZER(name.gp_wait),	\
-		.cb_state = 0,						\
 	}
 
 #define	DEFINE_RCU_SYNC(name)	\
diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index ee427e138dad..d4558ab7a07d 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -10,15 +10,13 @@
 #include <linux/rcu_sync.h>
 #include <linux/sched.h>
 
-enum { GP_IDLE = 0, GP_PENDING, GP_PASSED };
-enum { CB_IDLE = 0, CB_PENDING, CB_REPLAY };
+enum { GP_IDLE = 0, GP_ENTER, GP_PASSED, GP_EXIT, GP_REPLAY };
 
 #define	rss_lock	gp_wait.lock
 
 /**
  * rcu_sync_init() - Initialize an rcu_sync structure
  * @rsp: Pointer to rcu_sync structure to be initialized
- * @type: Flavor of RCU with which to synchronize rcu_sync structure
  */
 void rcu_sync_init(struct rcu_sync *rsp)
 {
@@ -41,56 +39,26 @@ void rcu_sync_enter_start(struct rcu_sync *rsp)
 	rsp->gp_state = GP_PASSED;
 }
 
-/**
- * rcu_sync_enter() - Force readers onto slowpath
- * @rsp: Pointer to rcu_sync structure to use for synchronization
- *
- * This function is used by updaters who need readers to make use of
- * a slowpath during the update.  After this function returns, all
- * subsequent calls to rcu_sync_is_idle() will return false, which
- * tells readers to stay off their fastpaths.  A later call to
- * rcu_sync_exit() re-enables reader slowpaths.
- *
- * When called in isolation, rcu_sync_enter() must wait for a grace
- * period, however, closely spaced calls to rcu_sync_enter() can
- * optimize away the grace-period wait via a state machine implemented
- * by rcu_sync_enter(), rcu_sync_exit(), and rcu_sync_func().
- */
-void rcu_sync_enter(struct rcu_sync *rsp)
-{
-	bool need_wait, need_sync;
 
-	spin_lock_irq(&rsp->rss_lock);
-	need_wait = rsp->gp_count++;
-	need_sync = rsp->gp_state == GP_IDLE;
-	if (need_sync)
-		rsp->gp_state = GP_PENDING;
-	spin_unlock_irq(&rsp->rss_lock);
+static void rcu_sync_func(struct rcu_head *rhp);
 
-	WARN_ON_ONCE(need_wait && need_sync);
-	if (need_sync) {
-		synchronize_rcu();
-		rsp->gp_state = GP_PASSED;
-		wake_up_all(&rsp->gp_wait);
-	} else if (need_wait) {
-		wait_event(rsp->gp_wait, rsp->gp_state == GP_PASSED);
-	} else {
-		/*
-		 * Possible when there's a pending CB from a rcu_sync_exit().
-		 * Nobody has yet been allowed the 'fast' path and thus we can
-		 * avoid doing any sync(). The callback will get 'dropped'.
-		 */
-		WARN_ON_ONCE(rsp->gp_state != GP_PASSED);
-	}
+static void rcu_sync_call(struct rcu_sync *rsp)
+{
+	call_rcu(&rsp->cb_head, rcu_sync_func);
 }
 
 /**
  * rcu_sync_func() - Callback function managing reader access to fastpath
  * @rhp: Pointer to rcu_head in rcu_sync structure to use for synchronization
  *
- * This function is passed to one of the call_rcu() functions by
+ * This function is passed to call_rcu() function by rcu_sync_enter() and
  * rcu_sync_exit(), so that it is invoked after a grace period following the
- * that invocation of rcu_sync_exit().  It takes action based on events that
+ * that invocation of enter/exit.
+ *
+ * If it is called by rcu_sync_enter() it signals that all the readers were
+ * switched onto slow path.
+ *
+ * If it is called by rcu_sync_exit() it takes action based on events that
  * have taken place in the meantime, so that closely spaced rcu_sync_enter()
  * and rcu_sync_exit() pairs need not wait for a grace period.
  *
@@ -107,35 +75,88 @@ static void rcu_sync_func(struct rcu_head *rhp)
 	struct rcu_sync *rsp = container_of(rhp, struct rcu_sync, cb_head);
 	unsigned long flags;
 
-	WARN_ON_ONCE(rsp->gp_state != GP_PASSED);
-	WARN_ON_ONCE(rsp->cb_state == CB_IDLE);
+	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
+	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
 
 	spin_lock_irqsave(&rsp->rss_lock, flags);
 	if (rsp->gp_count) {
 		/*
-		 * A new rcu_sync_begin() has happened; drop the callback.
+		 * We're at least a GP after the GP_IDLE->GP_ENTER transition.
 		 */
-		rsp->cb_state = CB_IDLE;
-	} else if (rsp->cb_state == CB_REPLAY) {
+		WRITE_ONCE(rsp->gp_state, GP_PASSED);
+		wake_up_locked(&rsp->gp_wait);
+	} else if (rsp->gp_state == GP_REPLAY) {
 		/*
-		 * A new rcu_sync_exit() has happened; requeue the callback
-		 * to catch a later GP.
+		 * A new rcu_sync_exit() has happened; requeue the callback to
+		 * catch a later GP.
 		 */
-		rsp->cb_state = CB_PENDING;
-		call_rcu(&rsp->cb_head, rcu_sync_func);
+		WRITE_ONCE(rsp->gp_state, GP_EXIT);
+		rcu_sync_call(rsp);
 	} else {
 		/*
-		 * We're at least a GP after rcu_sync_exit(); eveybody will now
-		 * have observed the write side critical section. Let 'em rip!.
+		 * We're at least a GP after the last rcu_sync_exit(); eveybody
+		 * will now have observed the write side critical section.
+		 * Let 'em rip!.
 		 */
-		rsp->cb_state = CB_IDLE;
-		rsp->gp_state = GP_IDLE;
+		WRITE_ONCE(rsp->gp_state, GP_IDLE);
 	}
 	spin_unlock_irqrestore(&rsp->rss_lock, flags);
 }
 
 /**
- * rcu_sync_exit() - Allow readers back onto fast patch after grace period
+ * rcu_sync_enter() - Force readers onto slowpath
+ * @rsp: Pointer to rcu_sync structure to use for synchronization
+ *
+ * This function is used by updaters who need readers to make use of
+ * a slowpath during the update.  After this function returns, all
+ * subsequent calls to rcu_sync_is_idle() will return false, which
+ * tells readers to stay off their fastpaths.  A later call to
+ * rcu_sync_exit() re-enables reader slowpaths.
+ *
+ * When called in isolation, rcu_sync_enter() must wait for a grace
+ * period, however, closely spaced calls to rcu_sync_enter() can
+ * optimize away the grace-period wait via a state machine implemented
+ * by rcu_sync_enter(), rcu_sync_exit(), and rcu_sync_func().
+ */
+void rcu_sync_enter(struct rcu_sync *rsp)
+{
+	int gp_state;
+
+	spin_lock_irq(&rsp->rss_lock);
+	gp_state = rsp->gp_state;
+	if (gp_state == GP_IDLE) {
+		WRITE_ONCE(rsp->gp_state, GP_ENTER);
+		WARN_ON_ONCE(rsp->gp_count);
+		/*
+		 * Note that we could simply do rcu_sync_call(rsp) here and
+		 * avoid the "if (gp_state == GP_IDLE)" block below.
+		 *
+		 * However, synchronize_rcu() can be faster if rcu_expedited
+		 * or rcu_blocking_is_gp() is true.
+		 *
+		 * Another reason is that we can't wait for rcu callback if
+		 * we are called at early boot time but this shouldn't happen.
+		 */
+	}
+	rsp->gp_count++;
+	spin_unlock_irq(&rsp->rss_lock);
+
+	if (gp_state == GP_IDLE) {
+		/*
+		 * See the comment above, this simply does the "synchronous"
+		 * call_rcu(rcu_sync_func) which does GP_ENTER -> GP_PASSED.
+		 */
+		synchronize_rcu();
+		rcu_sync_func(&rsp->cb_head);
+		/* Not really needed, wait_event() would see GP_PASSED. */
+		return;
+	}
+
+	wait_event(rsp->gp_wait, READ_ONCE(rsp->gp_state) >= GP_PASSED);
+}
+
+/**
+ * rcu_sync_exit() - Allow readers back onto fast path after grace period
  * @rsp: Pointer to rcu_sync structure to use for synchronization
  *
  * This function is used by updaters who have completed, and can therefore
@@ -146,13 +167,16 @@ static void rcu_sync_func(struct rcu_head *rhp)
  */
 void rcu_sync_exit(struct rcu_sync *rsp)
 {
+	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
+	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
+
 	spin_lock_irq(&rsp->rss_lock);
 	if (!--rsp->gp_count) {
-		if (rsp->cb_state == CB_IDLE) {
-			rsp->cb_state = CB_PENDING;
-			call_rcu(&rsp->cb_head, rcu_sync_func);
-		} else if (rsp->cb_state == CB_PENDING) {
-			rsp->cb_state = CB_REPLAY;
+		if (rsp->gp_state == GP_PASSED) {
+			WRITE_ONCE(rsp->gp_state, GP_EXIT);
+			rcu_sync_call(rsp);
+		} else if (rsp->gp_state == GP_EXIT) {
+			WRITE_ONCE(rsp->gp_state, GP_REPLAY);
 		}
 	}
 	spin_unlock_irq(&rsp->rss_lock);
@@ -164,18 +188,19 @@ void rcu_sync_exit(struct rcu_sync *rsp)
  */
 void rcu_sync_dtor(struct rcu_sync *rsp)
 {
-	int cb_state;
+	int gp_state;
 
-	WARN_ON_ONCE(rsp->gp_count);
+	WARN_ON_ONCE(READ_ONCE(rsp->gp_count));
+	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
 
 	spin_lock_irq(&rsp->rss_lock);
-	if (rsp->cb_state == CB_REPLAY)
-		rsp->cb_state = CB_PENDING;
-	cb_state = rsp->cb_state;
+	if (rsp->gp_state == GP_REPLAY)
+		WRITE_ONCE(rsp->gp_state, GP_EXIT);
+	gp_state = rsp->gp_state;
 	spin_unlock_irq(&rsp->rss_lock);
 
-	if (cb_state != CB_IDLE) {
+	if (gp_state != GP_IDLE) {
 		rcu_barrier();
-		WARN_ON_ONCE(rsp->cb_state != CB_IDLE);
+		WARN_ON_ONCE(rsp->gp_state != GP_IDLE);
 	}
 }
-- 
2.17.1

