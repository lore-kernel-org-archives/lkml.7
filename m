Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED36C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48483206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfDYQtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:49:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfDYQtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:49:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7CCF93147B24;
        Thu, 25 Apr 2019 16:49:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id C48014B4;
        Thu, 25 Apr 2019 16:49:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Apr 2019 18:49:41 +0200 (CEST)
Date:   Thu, 25 Apr 2019 18:49:39 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] rcu/sync: simplify the state machine
Message-ID: <20190425164939.GB21412@redhat.com>
References: <20190425164054.GA21309@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425164054.GA21309@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 25 Apr 2019 16:49:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 include/linux/rcu_sync.h |   2 -
 kernel/rcu/sync.c        | 165 +++++++++++++++++++++++++++--------------------
 2 files changed, 95 insertions(+), 72 deletions(-)

diff --git a/include/linux/rcu_sync.h b/include/linux/rcu_sync.h
index e7ae221..3156a14 100644
--- a/include/linux/rcu_sync.h
+++ b/include/linux/rcu_sync.h
@@ -19,7 +19,6 @@ struct rcu_sync {
 	int			gp_count;
 	wait_queue_head_t	gp_wait;
 
-	int			cb_state;
 	struct rcu_head		cb_head;
 };
 
@@ -47,7 +46,6 @@ extern void rcu_sync_dtor(struct rcu_sync *);
 		.gp_state = 0,						\
 		.gp_count = 0,						\
 		.gp_wait = __WAIT_QUEUE_HEAD_INITIALIZER(name.gp_wait),	\
-		.cb_state = 0,						\
 	}
 
 #define	DEFINE_RCU_SYNC(name)	\
diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index ee427e1..d9f80fc 100644
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
+static void rcu_sync_func(struct rcu_head *rcu);
 
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
@@ -102,40 +70,93 @@ void rcu_sync_enter(struct rcu_sync *rsp)
  * rcu_sync_exit().  Otherwise, set all state back to idle so that readers
  * can again use their fastpaths.
  */
-static void rcu_sync_func(struct rcu_head *rhp)
+static void rcu_sync_func(struct rcu_head *rcu)
 {
-	struct rcu_sync *rsp = container_of(rhp, struct rcu_sync, cb_head);
+	struct rcu_sync *rsp = container_of(rcu, struct rcu_sync, cb_head);
 	unsigned long flags;
 
-	WARN_ON_ONCE(rsp->gp_state != GP_PASSED);
-	WARN_ON_ONCE(rsp->cb_state == CB_IDLE);
+	WARN_ON_ONCE(rsp->gp_state == GP_IDLE);
+	WARN_ON_ONCE(rsp->gp_state == GP_PASSED);
 
 	spin_lock_irqsave(&rsp->rss_lock, flags);
 	if (rsp->gp_count) {
 		/*
-		 * A new rcu_sync_begin() has happened; drop the callback.
+		 * We're at least a GP after the GP_IDLE->GP_ENTER transition.
 		 */
-		rsp->cb_state = CB_IDLE;
-	} else if (rsp->cb_state == CB_REPLAY) {
+		rsp->gp_state = GP_PASSED;
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
+		rsp->gp_state = GP_EXIT;
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
 		rsp->gp_state = GP_IDLE;
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
+		rsp->gp_state = GP_ENTER;
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
+	wait_event(rsp->gp_wait, rsp->gp_state >= GP_PASSED);
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
+	WARN_ON_ONCE(rsp->gp_state == GP_IDLE);
+	WARN_ON_ONCE(rsp->gp_count == 0);
+
 	spin_lock_irq(&rsp->rss_lock);
 	if (!--rsp->gp_count) {
-		if (rsp->cb_state == CB_IDLE) {
-			rsp->cb_state = CB_PENDING;
-			call_rcu(&rsp->cb_head, rcu_sync_func);
-		} else if (rsp->cb_state == CB_PENDING) {
-			rsp->cb_state = CB_REPLAY;
+		if (rsp->gp_state == GP_PASSED) {
+			rsp->gp_state = GP_EXIT;
+			rcu_sync_call(rsp);
+		} else if (rsp->gp_state == GP_EXIT) {
+			rsp->gp_state = GP_REPLAY;
 		}
 	}
 	spin_unlock_irq(&rsp->rss_lock);
@@ -164,18 +188,19 @@ void rcu_sync_exit(struct rcu_sync *rsp)
  */
 void rcu_sync_dtor(struct rcu_sync *rsp)
 {
-	int cb_state;
+	int gp_state;
 
 	WARN_ON_ONCE(rsp->gp_count);
+	WARN_ON_ONCE(rsp->gp_state == GP_PASSED);
 
 	spin_lock_irq(&rsp->rss_lock);
-	if (rsp->cb_state == CB_REPLAY)
-		rsp->cb_state = CB_PENDING;
-	cb_state = rsp->cb_state;
+	if (rsp->gp_state == GP_REPLAY)
+		rsp->gp_state = GP_EXIT;
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
2.5.0


