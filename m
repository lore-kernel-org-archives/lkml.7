Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056B4CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7D4208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="PXceGjAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfJ3SfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:35:05 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44315 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfJ3SeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:24 -0400
Received: by mail-yb1-f194.google.com with SMTP id g38so973924ybe.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3GPDQAeMcQQT62Q845FuVNuwzSvchMT+iWwfl79i+24=;
        b=PXceGjAeGQnRGUzgKv4WbgZO87ieYLoqMdRstwFQUQekFx53x7xcO4BsPzWnXk5LDz
         isZv9akR3fCD9upPi7Kyk4gnFKYJp6ClNcTuLOSLntTyVw689Ynx2dlV+a7R7PCl3b4Z
         TE65eesWcODstwx7ZMFiEycygZqGBJk9qoz5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3GPDQAeMcQQT62Q845FuVNuwzSvchMT+iWwfl79i+24=;
        b=SWCuo5JYLAwmAgysoqBA6pXJtSooEX07XoAgcqayBVDb7CO+d+hZ2ApYKwq9fNtu6g
         VMIafOBjwAnGh57L86xfxyZjQM83w7fgoVNZ+m3ga+/a/FuA5xrHDCS3bv9nGrmRlhBv
         rRBhA2kr4M+zraBnrLIFXiuMTHArYEkoMpuXPUgFOwXs8T4ZFQmpxInqmmQWPvo82oZW
         gOpeEOG+4pduCwBZ63E6DFTJBdo8E+uPlocGOA10KUEHiMnnlISo6s2UDYYlFBotI5cI
         5HRgYzmVBCDKCyml0W0kYSTF0527OTVtFQWsmp6V2iugL0+lDPHbzumU6V0c4TXb+2C4
         vtYw==
X-Gm-Message-State: APjAAAVg6Tee7AHtUx3MO+LhktMNeWFjdYciE4kQ6qUHNY9zmTifsu7X
        5qWPx9oIIFd4yLiszwFtWr5l4w==
X-Google-Smtp-Source: APXvYqwSrq4UDIzBc0ksxJz9ZUjjncfEKHBGERkKnprBkBt7l95RbblmYn3a32T5NAtKXh+QIE7pGA==
X-Received: by 2002:a25:4b04:: with SMTP id y4mr624750yba.480.1572460463260;
        Wed, 30 Oct 2019 11:34:23 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id i5sm300228ywe.110.2019.10.30.11.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:22 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: [RFC PATCH v4 13/19] sched: Add core wide task selection and scheduling.
Date:   Wed, 30 Oct 2019 18:33:26 +0000
Message-Id: <a38626d94310c3dea5a0c91e874a15796f01ba7c.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
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
Signed-off-by: Aaron Lu <aaron.lu@linux.alibaba.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c  | 271 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   6 +-
 2 files changed, 274 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 27af86aa9a8b..10b20de100e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3932,7 +3932,7 @@ static inline void schedule_debug(struct task_struct *prev)
  * Pick up the highest-prio task:
  */
 static inline struct task_struct *
-pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+__pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -3977,6 +3977,268 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
+			rq_i->core_forceidle = true;
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
@@ -6290,7 +6552,7 @@ static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
 		/*
 		 * pick_next_task() assumes pinned rq->lock:
 		 */
-		next = pick_next_task(rq, &fake_task, rf);
+		next = __pick_next_task(rq, &fake_task, rf);
 		BUG_ON(!next);
 		put_prev_task(rq, next);
 
@@ -6760,7 +7022,12 @@ void __init sched_init(void)
 
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
index 0442a5abec01..fa92f6d3c73b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -999,11 +999,16 @@ struct rq {
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
 
@@ -1864,7 +1869,6 @@ static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
-	WARN_ON_ONCE(rq->curr != next);
 	next->sched_class->set_next_task(rq, next);
 }
 
-- 
2.17.1

