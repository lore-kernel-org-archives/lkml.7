Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD72C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C762208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="VeHZC2jO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfDWQTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:19:39 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55850 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbfDWQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:50 -0400
Received: by mail-it1-f195.google.com with SMTP id y134so1104546itc.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vieSdjoNYF6NzgE1PfUgCEL5OOFN/MgXGZdbiusBB3U=;
        b=VeHZC2jO+g1X5BZ5nc7yaCnTtgGTyRNoKm+cFlH6Uo0EsT2b17mVKlAU40wtAaeImZ
         IPhwvpoWupk48VMpY4478FFc2cEWxogBU01F8ld8DSxfqvqlWVlHqygWOoocpqD16qoQ
         DbknorByBTN9riupr1NtLCQkLQ3v1fvx/irIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vieSdjoNYF6NzgE1PfUgCEL5OOFN/MgXGZdbiusBB3U=;
        b=klrZavjUY4CW/oT+FkVifjffRB4xSosxWZryv+PTIYfWg1qBJxGM44OsYnloZXDdtC
         wDhfE5aAt8d37+c2pTlUWaQ8RUyUPnjZWLRA//x+aaBa9DWHvxrCLC1yTnmlZagzDoYu
         Od3o4KJm+uGogGEhwTGqxwhLpU/9vyz13jJvJI7/kTXbC8TiTMEjNTGMUG+WCJbUHf82
         auzH3O7A1Zv1U3zNqnWbOe2uhoH1KgbLZcEk8RQ2DPcb16KbTuAW4RlqwzyQLBfh37FX
         5t4AH4fjqQnCdpprx1bLRHdMgowPsO/tXJB2MLFxo7ACt/FH6nUA2F1hQqHlMy1rcFjB
         lTdA==
X-Gm-Message-State: APjAAAWs/JG/Vvfqeb6RIZyYgJZWkSySNHFgiM5z1ECSJrCpfytIUD7r
        TyFKsk6MGfNMHIttKs0jlKKLzA==
X-Google-Smtp-Source: APXvYqyV+rpDQwwB0bMrbE5ASmlNEToeFwlnUO/31IUv64qZbbdygRWocuQvxj2NnimkD/ZpYe18TA==
X-Received: by 2002:a24:7456:: with SMTP id o83mr2799363itc.61.1556036328889;
        Tue, 23 Apr 2019 09:18:48 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id u63sm6264888ita.3.2019.04.23.09.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:18:48 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 08/17] sched: Rework pick_next_task() slow-path
Date:   Tue, 23 Apr 2019 16:18:13 +0000
Message-Id: <b78cac7afa840d5e7f3602e5ad13d1ae3a3bf3a0.1556025155.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

Avoid the RETRY_TASK case in the pick_next_task() slow path.

By doing the put_prev_task() early, we get the rt/deadline pull done,
and by testing rq->nr_running we know if we need newidle_balance().

This then gives a stable state to pick a task from.

Since the fast-path is fair only; it means the other classes will
always have pick_next_task(.prev=NULL, .rf=NULL) and we can simplify.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
index 9dfa0c53deb3..b883c70674ba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3363,7 +3363,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		p = fair_sched_class.pick_next_task(rq, prev, rf);
 		if (unlikely(p == RETRY_TASK))
-			goto again;
+			goto restart;
 
 		/* Assumes fair_sched_class->next == idle_sched_class */
 		if (unlikely(!p))
@@ -3372,14 +3372,19 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
index 56791c0318a2..249310e68592 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1730,39 +1730,13 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
index 41ec5e68e1c5..c055bad249a9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6950,7 +6950,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		goto idle;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	if (prev->sched_class != &fair_sched_class)
+	if (!prev || prev->sched_class != &fair_sched_class)
 		goto simple;
 
 	/*
@@ -7027,8 +7027,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	goto done;
 simple:
 #endif
-
-	put_prev_task(rq, prev);
+	if (prev)
+		put_prev_task(rq, prev);
 
 	do {
 		se = pick_next_entity(cfs_rq, NULL);
@@ -7056,6 +7056,9 @@ done: __maybe_unused;
 	return p;
 
 idle:
+	if (!rf)
+		return NULL;
+
 	new_tasks = newidle_balance(rq, rf);
 
 	/*
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 1b65a4c3683e..7ece8e820b5d 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -388,7 +388,9 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 {
 	struct task_struct *next = rq->idle;
 
-	put_prev_task(rq, prev);
+	if (prev)
+		put_prev_task(rq, prev);
+
 	set_next_task_idle(rq, next);
 
 	return next;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 51ee87c5a28a..79f2e60516ef 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1554,38 +1554,11 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
index 4cbe2bef92e4..460dd04e76af 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1665,12 +1665,15 @@ struct sched_class {
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
-- 
2.17.1

