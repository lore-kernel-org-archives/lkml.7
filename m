Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46219C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0687A21874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ru0sdyT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbfHHK7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:59:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49339 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfHHK7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:59:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78AxSeL3128049
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 03:59:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78AxSeL3128049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565261969;
        bh=P7laZAUNn9oRbMGYi3bfdl7OzBoNy8Oc8XL5Q2kmqN4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ru0sdyT4u/QIcD1I06m3anhcKbjk0URIVyP/eMpY93EVipYB22SNghUgi7B3J7kGH
         fgC7aqAfbjYgV6fO4ZysGeAjkN42df7looI9WYCfXY0d4NZqVesBAk0xrhlJMHgAML
         aqkGuqGAegierLuK60mVVAPxnYN6pwGoKrMZaKaQXPLdndzjeVI/7cZ50VM+jXy4j1
         8/+KdAlyaUsAtxxXk7aw2quW8ZXKBqfxY7sXpgs/xfb+g3CHAXJU6c4xds+eoHHVw9
         0aVtAEIM8/qgQy1VBroMufJKZl/YXqIn7H7hM/PEwn+rVF3m/2DEziIqhqv/Wp0AM2
         Uwwx9nO/1IWTw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78AxSiO3128043;
        Thu, 8 Aug 2019 03:59:28 -0700
Date:   Thu, 8 Aug 2019 03:59:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-67692435c411e5c53a1c588ecca2037aebd81f2e@git.kernel.org>
Cc:     tglx@linutronix.de, jdesfossez@digitalocean.com,
        peterz@infradead.org, naravamudan@digitalocean.com,
        linux-kernel@vger.kernel.org, aaron.lwe@gmail.com, hpa@zytor.com,
        valentin.schneider@arm.com, pauld@redhat.com, mingo@kernel.org
Reply-To: valentin.schneider@arm.com, hpa@zytor.com, aaron.lwe@gmail.com,
          mingo@kernel.org, pauld@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, naravamudan@digitalocean.com,
          peterz@infradead.org, jdesfossez@digitalocean.com
In-Reply-To: <aa34d24b36547139248f32a30138791ac6c02bd6.1559129225.git.vpillai@digitalocean.com>
References: <aa34d24b36547139248f32a30138791ac6c02bd6.1559129225.git.vpillai@digitalocean.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched: Rework pick_next_task() slow-path
Git-Commit-ID: 67692435c411e5c53a1c588ecca2037aebd81f2e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  67692435c411e5c53a1c588ecca2037aebd81f2e
Gitweb:     https://git.kernel.org/tip/67692435c411e5c53a1c588ecca2037aebd81f2e
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 29 May 2019 20:36:44 +0000
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:31 +0200

sched: Rework pick_next_task() slow-path

Avoid the RETRY_TASK case in the pick_next_task() slow path.

By doing the put_prev_task() early, we get the rt/deadline pull done,
and by testing rq->nr_running we know if we need newidle_balance().

This then gives a stable state to pick a task from.

Since the fast-path is fair only; it means the other classes will
always have pick_next_task(.prev=NULL, .rf=NULL) and we can simplify.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Aaron Lu <aaron.lwe@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: mingo@kernel.org
Cc: Phil Auld <pauld@redhat.com>
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
Link: https://lkml.kernel.org/r/aa34d24b36547139248f32a30138791ac6c02bd6.1559129225.git.vpillai@digitalocean.com
---
 kernel/sched/core.c      | 19 ++++++++++++-------
 kernel/sched/deadline.c  | 30 ++----------------------------
 kernel/sched/fair.c      |  9 ++++++---
 kernel/sched/idle.c      |  4 +++-
 kernel/sched/rt.c        | 29 +----------------------------
 kernel/sched/sched.h     | 13 ++++++++-----
 kernel/sched/stop_task.c |  3 ++-
 7 files changed, 34 insertions(+), 73 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7bbe78a31ba5..a6661852907b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3791,7 +3791,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		p = fair_sched_class.pick_next_task(rq, prev, rf);
 		if (unlikely(p == RETRY_TASK))
-			goto again;
+			goto restart;
 
 		/* Assumes fair_sched_class->next == idle_sched_class */
 		if (unlikely(!p))
@@ -3800,14 +3800,19 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2872e15a87cd..0b9cbfb2b1d4 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1761,39 +1761,13 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4418c1998e69..19c58599e967 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6770,7 +6770,7 @@ again:
 		goto idle;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	if (prev->sched_class != &fair_sched_class)
+	if (!prev || prev->sched_class != &fair_sched_class)
 		goto simple;
 
 	/*
@@ -6847,8 +6847,8 @@ again:
 	goto done;
 simple:
 #endif
-
-	put_prev_task(rq, prev);
+	if (prev)
+		put_prev_task(rq, prev);
 
 	do {
 		se = pick_next_entity(cfs_rq, NULL);
@@ -6876,6 +6876,9 @@ done: __maybe_unused;
 	return p;
 
 idle:
+	if (!rf)
+		return NULL;
+
 	new_tasks = newidle_balance(rq, rf);
 
 	/*
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8d59de2e4a6e..7c54550dda6a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -389,7 +389,9 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 {
 	struct task_struct *next = rq->idle;
 
-	put_prev_task(rq, prev);
+	if (prev)
+		put_prev_task(rq, prev);
+
 	set_next_task_idle(rq, next);
 
 	return next;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index dbdabd76f192..858c4cc6f99b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1553,38 +1553,11 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e085cffb8004..7111e3a1eeb4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1700,12 +1700,15 @@ struct sched_class {
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
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 8f414018d5e0..7e1cee4e65b2 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -33,10 +33,11 @@ pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 {
 	struct task_struct *stop = rq->stop;
 
+	WARN_ON_ONCE(prev || rf);
+
 	if (!stop || !task_on_rq_queued(stop))
 		return NULL;
 
-	put_prev_task(rq, prev);
 	set_next_task_stop(rq, stop);
 
 	return stop;
