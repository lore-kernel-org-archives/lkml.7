Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05582C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5091218EA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i2nl6omO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfGZQU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:20:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbfGZQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Yz9Xtm2sZUJQiP7HnbPwNasUB4b81OC8P1nglrmAuoQ=; b=i2nl6omOecnIfjXkC3qrF9hfS3
        4M78gC12E+KgUXleRqQdna/LhFi4f1nVaNFNJXfGAZPjwi7I3lDSjzbZoMhDSbQSRt39Wz7GyI8Uh
        +sN0qMCJ2KH/fq1CZhJ33Qs3fMPgPUduY75qg2HeHcYV0i7BmxpXsEKg8kAY6OcaBgngIjsO8KhuH
        r2HDy3nYpKzIE9KX0ndJ04eCZpt8FtMKbNBzhIbAdErR/4yR+oUvXF4macJU0ZUubIO3H4jZtoqKy
        zFouVwIGj/6bNnzJ3YkQ2kfwSIK7U+iPMtT7+n5jsQyuPxZra2/Okp4BW7IuKdX7WI6rBRGaa+tgD
        bmLbdwVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr2wz-0006vx-AC; Fri, 26 Jul 2019 16:20:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5C2A320229754; Fri, 26 Jul 2019 18:20:05 +0200 (CEST)
Message-Id: <20190726161357.812535015@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 16:54:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org, peterz@infradead.org
Subject: [RFC][PATCH 08/13] sched: Rework pick_next_task() slow-path
References: <20190726145409.947503076@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the RETRY_TASK case in the pick_next_task() slow path.

By doing the put_prev_task() early, we get the rt/deadline pull done,
and by testing rq->nr_running we know if we need newidle_balance().

This then gives a stable state to pick a task from.

Since the fast-path is fair only; it means the other classes will
always have pick_next_task(.prev=NULL, .rf=NULL) and we can simplify.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |   19 ++++++++++++-------
 kernel/sched/deadline.c  |   30 ++----------------------------
 kernel/sched/fair.c      |    9 ++++++---
 kernel/sched/idle.c      |    4 +++-
 kernel/sched/rt.c        |   29 +----------------------------
 kernel/sched/sched.h     |   13 ++++++++-----
 kernel/sched/stop_task.c |    3 ++-
 7 files changed, 34 insertions(+), 73 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3739,7 +3739,7 @@ pick_next_task(struct rq *rq, struct tas
 
 		p = fair_sched_class.pick_next_task(rq, prev, rf);
 		if (unlikely(p == RETRY_TASK))
-			goto again;
+			goto restart;
 
 		/* Assumes fair_sched_class->next == idle_sched_class */
 		if (unlikely(!p))
@@ -3748,14 +3748,19 @@ pick_next_task(struct rq *rq, struct tas
 		return p;
 	}
 
-again:
+restart:
+	/*
+	 * Ensure that we put DL/RT tasks before the pick loop, such that they
+	 * can PULL higher prio tasks when we lower the RQ 'priority'.
+	 */
+	prev->sched_class->put_prev_task(rq, prev, rf);
+	if (!rq->nr_running)
+		newidle_balance(rq, rf);
+
 	for_each_class(class) {
-		p = class->pick_next_task(rq, prev, rf);
-		if (p) {
-			if (unlikely(p == RETRY_TASK))
-				goto again;
+		p = class->pick_next_task(rq, NULL, NULL);
+		if (p)
 			return p;
-		}
 	}
 
 	/* The idle class should always have a runnable task: */
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1729,39 +1729,13 @@ pick_next_task_dl(struct rq *rq, struct
 	struct task_struct *p;
 	struct dl_rq *dl_rq;
 
-	dl_rq = &rq->dl;
-
-	if (need_pull_dl_task(rq, prev)) {
-		/*
-		 * This is OK, because current is on_cpu, which avoids it being
-		 * picked for load-balance and preemption/IRQs are still
-		 * disabled avoiding further scheduler activity on it and we're
-		 * being very careful to re-start the picking loop.
-		 */
-		rq_unpin_lock(rq, rf);
-		pull_dl_task(rq);
-		rq_repin_lock(rq, rf);
-		/*
-		 * pull_dl_task() can drop (and re-acquire) rq->lock; this
-		 * means a stop task can slip in, in which case we need to
-		 * re-start task selection.
-		 */
-		if (rq->stop && task_on_rq_queued(rq->stop))
-			return RETRY_TASK;
-	}
+	WARN_ON_ONCE(prev || rf);
 
-	/*
-	 * When prev is DL, we may throttle it in put_prev_task().
-	 * So, we update time before we check for dl_nr_running.
-	 */
-	if (prev->sched_class == &dl_sched_class)
-		update_curr_dl(rq);
+	dl_rq = &rq->dl;
 
 	if (unlikely(!dl_rq->dl_nr_running))
 		return NULL;
 
-	put_prev_task(rq, prev);
-
 	dl_se = pick_next_dl_entity(rq, dl_rq);
 	BUG_ON(!dl_se);
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6740,7 +6740,7 @@ pick_next_task_fair(struct rq *rq, struc
 		goto idle;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	if (prev->sched_class != &fair_sched_class)
+	if (!prev || prev->sched_class != &fair_sched_class)
 		goto simple;
 
 	/*
@@ -6817,8 +6817,8 @@ pick_next_task_fair(struct rq *rq, struc
 	goto done;
 simple:
 #endif
-
-	put_prev_task(rq, prev);
+	if (prev)
+		put_prev_task(rq, prev);
 
 	do {
 		se = pick_next_entity(cfs_rq, NULL);
@@ -6846,6 +6846,9 @@ done: __maybe_unused;
 	return p;
 
 idle:
+	if (!rf)
+		return NULL;
+
 	new_tasks = newidle_balance(rq, rf);
 
 	/*
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -389,7 +389,9 @@ pick_next_task_idle(struct rq *rq, struc
 {
 	struct task_struct *next = rq->idle;
 
-	put_prev_task(rq, prev);
+	if (prev)
+		put_prev_task(rq, prev);
+
 	set_next_task_idle(rq, next);
 
 	return next;
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1554,38 +1554,11 @@ pick_next_task_rt(struct rq *rq, struct
 	struct task_struct *p;
 	struct rt_rq *rt_rq = &rq->rt;
 
-	if (need_pull_rt_task(rq, prev)) {
-		/*
-		 * This is OK, because current is on_cpu, which avoids it being
-		 * picked for load-balance and preemption/IRQs are still
-		 * disabled avoiding further scheduler activity on it and we're
-		 * being very careful to re-start the picking loop.
-		 */
-		rq_unpin_lock(rq, rf);
-		pull_rt_task(rq);
-		rq_repin_lock(rq, rf);
-		/*
-		 * pull_rt_task() can drop (and re-acquire) rq->lock; this
-		 * means a dl or stop task can slip in, in which case we need
-		 * to re-start task selection.
-		 */
-		if (unlikely((rq->stop && task_on_rq_queued(rq->stop)) ||
-			     rq->dl.dl_nr_running))
-			return RETRY_TASK;
-	}
-
-	/*
-	 * We may dequeue prev's rt_rq in put_prev_task().
-	 * So, we update time before rt_queued check.
-	 */
-	if (prev->sched_class == &rt_sched_class)
-		update_curr_rt(rq);
+	WARN_ON_ONCE(prev || rf);
 
 	if (!rt_rq->rt_queued)
 		return NULL;
 
-	put_prev_task(rq, prev);
-
 	p = _pick_next_task_rt(rq);
 
 	set_next_task_rt(rq, p);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1704,12 +1704,15 @@ struct sched_class {
 	void (*check_preempt_curr)(struct rq *rq, struct task_struct *p, int flags);
 
 	/*
-	 * It is the responsibility of the pick_next_task() method that will
-	 * return the next task to call put_prev_task() on the @prev task or
-	 * something equivalent.
+	 * Both @prev and @rf are optional and may be NULL, in which case the
+	 * caller must already have invoked put_prev_task(rq, prev, rf).
 	 *
-	 * May return RETRY_TASK when it finds a higher prio class has runnable
-	 * tasks.
+	 * Otherwise it is the responsibility of the pick_next_task() to call
+	 * put_prev_task() on the @prev task or something equivalent, IFF it
+	 * returns a next task.
+	 *
+	 * In that case (@rf != NULL) it may return RETRY_TASK when it finds a
+	 * higher prio class has runnable tasks.
 	 */
 	struct task_struct * (*pick_next_task)(struct rq *rq,
 					       struct task_struct *prev,
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -33,10 +33,11 @@ pick_next_task_stop(struct rq *rq, struc
 {
 	struct task_struct *stop = rq->stop;
 
+	WARN_ON_ONCE(prev || rf);
+
 	if (!stop || !task_on_rq_queued(stop))
 		return NULL;
 
-	put_prev_task(rq, prev);
 	set_next_task_stop(rq, stop);
 
 	return stop;


