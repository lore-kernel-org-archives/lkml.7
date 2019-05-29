Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852ABC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4714B24188
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="aFM5oJjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfE2UhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:37:20 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52712 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfE2UhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:37:11 -0400
Received: by mail-it1-f193.google.com with SMTP id t184so6254589itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=c7uDKTM5GVSyOjmP6T5NwoOzUiKzfD8ekVfxOX1V4o4=;
        b=aFM5oJjCCF+uqdfYXmLrHJ/C8rlfoCNod53cLh8f3KrqM+LvtnBFdJCvt//hoGlk6K
         h8NpLfVeHEL1xSrFYkCQG14x3qTnl053jlAOsdx3CDLBMlCn4L5rvFULfE7AKD8T1Sff
         IYPXa+6NG2XX+D/IEsSWGx5FD1gO5dv9fdjj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=c7uDKTM5GVSyOjmP6T5NwoOzUiKzfD8ekVfxOX1V4o4=;
        b=bJRauxWwIOPlbx+UvG3ZTQ2d6JvJRsGPRe3TPklj1OQhqLkXtH9dMJbe17V6k8oqVV
         ivwARycKQapO4OuvQ3ShGg6LTU3hS5ss6tW2yTN9vhu5th4IZnxASxMzv4EmUdVqZOOe
         mG2pCtgowOWAO6yKzI7YTcu/i+YOo5XSO4v0xuPPzSUJbu1wJNlJBKpaBcoodjkKP127
         99f32LBEo43HFO5CAu5+L6Ea1Cn5gpZPoIkhs2EpqMMz9Z+sY7/ZFzTGEj9Rvw282jMe
         G7S4wm/MD7yk2n3rd0gk00e/u6n+n746Q14dd5+XINYsfdwf1MaPYN13pAqsaq6CL/ek
         947Q==
X-Gm-Message-State: APjAAAUEMhIyoMlXpWhFqNaGOPSbY1OFndOgZjM3LlzPC3lJ5HQU9gmk
        AaR3XqbU4z2kF8OMUlrwyBxgYA==
X-Google-Smtp-Source: APXvYqyY9Rc0yUUQppb6mNurzgdQ0J7e7eofZtbZfIsyNoxOA4fXqAVTOd6nYYi3CxK/DRqI7+tjIw==
X-Received: by 2002:a05:660c:251:: with SMTP id t17mr162841itk.7.1559162230153;
        Wed, 29 May 2019 13:37:10 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id w186sm204289ita.3.2019.05.29.13.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:37:09 -0700 (PDT)
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
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH v3 13/16] sched: Add core wide task selection and scheduling.
Date:   Wed, 29 May 2019 20:36:49 +0000
Message-Id: <f7d51cdfc5672677084e0f4b01b28eabbcdd99a6.1559129225.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Instead of only selecting a local task, select a task for all SMT
siblings for every reschedule on the core (irrespective which logical
CPU does the reschedule).

NOTE: there is still potential for siblings rivalry.
NOTE: this is far too complicated; but thus far I've failed to
      simplify it further.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
---

Changes in v3
-------------
- Fixes the issue of sibling picking an incompatible task.
  - Aaron Lu
  - Peter Zijlstra
  - Vineeth Pillai
  - Julien Desfossez

---
 kernel/sched/core.c  | 271 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   6 +-
 2 files changed, 274 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3164c6b33553..e25811b81562 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3556,7 +3556,7 @@ static inline void schedule_debug(struct task_struct *prev)
  * Pick up the highest-prio task:
  */
 static inline struct task_struct *
-pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+__pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -3601,6 +3601,268 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	BUG();
 }
 
+#ifdef CONFIG_SCHED_CORE
+
+static inline bool cookie_equals(struct task_struct *a, unsigned long cookie)
+{
+	return is_idle_task(a) || (a->core_cookie == cookie);
+}
+
+static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
+{
+	if (is_idle_task(a) || is_idle_task(b))
+		return true;
+
+	return a->core_cookie == b->core_cookie;
+}
+
+// XXX fairness/fwd progress conditions
+/*
+ * Returns
+ * - NULL if there is no runnable task for this class.
+ * - the highest priority task for this runqueue if it matches
+ *   rq->core->core_cookie or its priority is greater than max.
+ * - Else returns idle_task.
+ */
+static struct task_struct *
+pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
+{
+	struct task_struct *class_pick, *cookie_pick;
+	unsigned long cookie = rq->core->core_cookie;
+
+	class_pick = class->pick_task(rq);
+	if (!class_pick)
+		return NULL;
+
+	if (!cookie) {
+		/*
+		 * If class_pick is tagged, return it only if it has
+		 * higher priority than max.
+		 */
+		if (max && class_pick->core_cookie &&
+		    prio_less(class_pick, max))
+			return idle_sched_class.pick_task(rq);
+
+		return class_pick;
+	}
+
+	/*
+	 * If class_pick is idle or matches cookie, return early.
+	 */
+	if (cookie_equals(class_pick, cookie))
+		return class_pick;
+
+	cookie_pick = sched_core_find(rq, cookie);
+
+	/*
+	 * If class > max && class > cookie, it is the highest priority task on
+	 * the core (so far) and it must be selected, otherwise we must go with
+	 * the cookie pick in order to satisfy the constraint.
+	 */
+	if (prio_less(cookie_pick, class_pick) &&
+	    (!max || prio_less(max, class_pick)))
+		return class_pick;
+
+	return cookie_pick;
+}
+
+static struct task_struct *
+pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *next, *max = NULL;
+	const struct sched_class *class;
+	const struct cpumask *smt_mask;
+	int i, j, cpu;
+	bool need_sync = false;
+
+	if (!sched_core_enabled(rq))
+		return __pick_next_task(rq, prev, rf);
+
+	/*
+	 * If there were no {en,de}queues since we picked (IOW, the task
+	 * pointers are all still valid), and we haven't scheduled the last
+	 * pick yet, do so now.
+	 */
+	if (rq->core->core_pick_seq == rq->core->core_task_seq &&
+	    rq->core->core_pick_seq != rq->core_sched_seq) {
+		WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
+
+		next = rq->core_pick;
+		if (next != prev) {
+			put_prev_task(rq, prev);
+			set_next_task(rq, next);
+		}
+		return next;
+	}
+
+	prev->sched_class->put_prev_task(rq, prev, rf);
+	if (!rq->nr_running)
+		newidle_balance(rq, rf);
+
+	cpu = cpu_of(rq);
+	smt_mask = cpu_smt_mask(cpu);
+
+	/*
+	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
+	 *
+	 * @task_seq guards the task state ({en,de}queues)
+	 * @pick_seq is the @task_seq we did a selection on
+	 * @sched_seq is the @pick_seq we scheduled
+	 *
+	 * However, preemptions can cause multiple picks on the same task set.
+	 * 'Fix' this by also increasing @task_seq for every pick.
+	 */
+	rq->core->core_task_seq++;
+	need_sync = !!rq->core->core_cookie;
+
+	/* reset state */
+	rq->core->core_cookie = 0UL;
+	for_each_cpu(i, smt_mask) {
+		struct rq *rq_i = cpu_rq(i);
+
+		rq_i->core_pick = NULL;
+
+		if (rq_i->core_forceidle) {
+			need_sync = true;
+			rq_i->core_forceidle = false;
+		}
+
+		if (i != cpu)
+			update_rq_clock(rq_i);
+	}
+
+	/*
+	 * Try and select tasks for each sibling in decending sched_class
+	 * order.
+	 */
+	for_each_class(class) {
+again:
+		for_each_cpu_wrap(i, smt_mask, cpu) {
+			struct rq *rq_i = cpu_rq(i);
+			struct task_struct *p;
+
+			if (cpu_is_offline(i))
+				continue;
+
+			if (rq_i->core_pick)
+				continue;
+
+			/*
+			 * If this sibling doesn't yet have a suitable task to
+			 * run; ask for the most elegible task, given the
+			 * highest priority task already selected for this
+			 * core.
+			 */
+			p = pick_task(rq_i, class, max);
+			if (!p) {
+				/*
+				 * If there weren't no cookies; we don't need
+				 * to bother with the other siblings.
+				 */
+				if (i == cpu && !need_sync)
+					goto next_class;
+
+				continue;
+			}
+
+			/*
+			 * Optimize the 'normal' case where there aren't any
+			 * cookies and we don't need to sync up.
+			 */
+			if (i == cpu && !need_sync && !p->core_cookie) {
+				next = p;
+				goto done;
+			}
+
+			rq_i->core_pick = p;
+
+			/*
+			 * If this new candidate is of higher priority than the
+			 * previous; and they're incompatible; we need to wipe
+			 * the slate and start over. pick_task makes sure that
+			 * p's priority is more than max if it doesn't match
+			 * max's cookie.
+			 *
+			 * NOTE: this is a linear max-filter and is thus bounded
+			 * in execution time.
+			 */
+			if (!max || !cookie_match(max, p)) {
+				struct task_struct *old_max = max;
+
+				rq->core->core_cookie = p->core_cookie;
+				max = p;
+
+				if (old_max) {
+					for_each_cpu(j, smt_mask) {
+						if (j == i)
+							continue;
+
+						cpu_rq(j)->core_pick = NULL;
+					}
+					goto again;
+				} else {
+					/*
+					 * Once we select a task for a cpu, we
+					 * should not be doing an unconstrained
+					 * pick because it might starve a task
+					 * on a forced idle cpu.
+					 */
+					need_sync = true;
+				}
+
+			}
+		}
+next_class:;
+	}
+
+	rq->core->core_pick_seq = rq->core->core_task_seq;
+	next = rq->core_pick;
+	rq->core_sched_seq = rq->core->core_pick_seq;
+
+	/*
+	 * Reschedule siblings
+	 *
+	 * NOTE: L1TF -- at this point we're no longer running the old task and
+	 * sending an IPI (below) ensures the sibling will no longer be running
+	 * their task. This ensures there is no inter-sibling overlap between
+	 * non-matching user state.
+	 */
+	for_each_cpu(i, smt_mask) {
+		struct rq *rq_i = cpu_rq(i);
+
+		if (cpu_is_offline(i))
+			continue;
+
+		WARN_ON_ONCE(!rq_i->core_pick);
+
+		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
+			rq->core_forceidle = true;
+
+		if (i == cpu)
+			continue;
+
+		if (rq_i->curr != rq_i->core_pick)
+			resched_curr(rq_i);
+
+		/* Did we break L1TF mitigation requirements? */
+		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
+	}
+
+done:
+	set_next_task(rq, next);
+	return next;
+}
+
+#else /* !CONFIG_SCHED_CORE */
+
+static struct task_struct *
+pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	return __pick_next_task(rq, prev, rf);
+}
+
+#endif /* CONFIG_SCHED_CORE */
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -5870,7 +6132,7 @@ static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
 		/*
 		 * pick_next_task() assumes pinned rq->lock:
 		 */
-		next = pick_next_task(rq, &fake_task, rf);
+		next = __pick_next_task(rq, &fake_task, rf);
 		BUG_ON(!next);
 		put_prev_task(rq, next);
 
@@ -6344,7 +6606,12 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = NULL;
+		rq->core_pick = NULL;
 		rq->core_enabled = 0;
+		rq->core_tree = RB_ROOT;
+		rq->core_forceidle = false;
+
+		rq->core_cookie = 0UL;
 #endif
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bd9b473ebde2..cd8ced09826f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -960,11 +960,16 @@ struct rq {
 #ifdef CONFIG_SCHED_CORE
 	/* per rq */
 	struct rq		*core;
+	struct task_struct	*core_pick;
 	unsigned int		core_enabled;
+	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
+	bool			core_forceidle;
 
 	/* shared state */
 	unsigned int		core_task_seq;
+	unsigned int		core_pick_seq;
+	unsigned long		core_cookie;
 #endif
 };
 
@@ -1821,7 +1826,6 @@ static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
-	WARN_ON_ONCE(rq->curr != next);
 	next->sched_class->set_next_task(rq, next);
 }
 
-- 
2.17.1

