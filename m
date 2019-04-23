Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87915C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AF5208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="RAWTFzMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfDWQTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:19:22 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35846 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbfDWQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:55 -0400
Received: by mail-it1-f194.google.com with SMTP id y10so1131697itc.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=D1ZONVzime/jUZGOwsyzAXl4tUiRcGeB5vZq+RHxrno=;
        b=RAWTFzMqPgYtmSGxwTpId00Ogw0iHU1CG/+aaqzyx4PmMk1NrCiklnXmgpn25uqKta
         GtWCYFXsMqPwZ/c0FINd052phoDz5BQMHRXP4ieQYCLxHucmPtsIjyyCu38dvk6C3cmu
         +W12+OhbLgHY4Vk6u4aB0DN6nmWHlUbaKUVpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=D1ZONVzime/jUZGOwsyzAXl4tUiRcGeB5vZq+RHxrno=;
        b=PpNOFuVEaOiGBD0BFZfSmOiK1eJiNC5CmdBNIlzfIT2c+g1PINL63ZssieR+f0NjgL
         cQd5c+U+oh05voLql3SYf/LsTfaEDLjHu++CrPZL2MPZfgpdpOWmn0dP6Eesm8zPcA0z
         YqNree5RRc/Q7KP1Our1v98G/m1pJeEoqTCJEi6wWRzggNn+C21kAFbTVlDwgsItGMVi
         EFP4capRpTA26oqulstdLHlzr13huvJw/cFNnZmTYODWGNseUUeH/Z6sPAs9imuojT8K
         3Iy/ZaIw7NEiO/jO5gD4R14Afz9oIvtk0XJzgrqnC2PGODoyzPG8RUnx+i14KvNMRnOn
         n1YA==
X-Gm-Message-State: APjAAAWOIsVDTMZOcyd11jAT/2xwHbIlKBu72+2+etgWkVrucwsc2MQw
        4OV54+OtgBKxjggUjU4Hc5e4kw==
X-Google-Smtp-Source: APXvYqx5l5JzcvXf12wSd6vLSwt1JNmaZVuOeothrx0669A0A30Eer+dhHH3u/Kh5e673w19e8Dk7g==
X-Received: by 2002:a24:3d4a:: with SMTP id n71mr2891723itn.55.1556036334006;
        Tue, 23 Apr 2019 09:18:54 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id o64sm37921ito.2.2019.04.23.09.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:18:53 -0700 (PDT)
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
Subject: [RFC PATCH v2 13/17] sched: Add core wide task selection and scheduling.
Date:   Tue, 23 Apr 2019 16:18:18 +0000
Message-Id: <edd4c014e69b68b90160766c6049f2ed922793c7.1556025155.git.vpillai@digitalocean.com>
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

Instead of only selecting a local task, select a task for all SMT
siblings for every reschedule on the core (irrespective which logical
CPU does the reschedule).

NOTE: there is still potential for siblings rivalry.
NOTE: this is far too complicated; but thus far I've failed to
      simplify it further.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  | 222 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   5 +-
 2 files changed, 224 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e5bdc1c4d8d7..9e6e90c6f9b9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3574,7 +3574,7 @@ static inline void schedule_debug(struct task_struct *prev)
  * Pick up the highest-prio task:
  */
 static inline struct task_struct *
-pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+__pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -3619,6 +3619,220 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	BUG();
 }
 
+#ifdef CONFIG_SCHED_CORE
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
+static struct task_struct *
+pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
+{
+	struct task_struct *class_pick, *cookie_pick;
+	unsigned long cookie = 0UL;
+
+	/*
+	 * We must not rely on rq->core->core_cookie here, because we fail to reset
+	 * rq->core->core_cookie on new picks, such that we can detect if we need
+	 * to do single vs multi rq task selection.
+	 */
+
+	if (max && max->core_cookie) {
+		WARN_ON_ONCE(rq->core->core_cookie != max->core_cookie);
+		cookie = max->core_cookie;
+	}
+
+	class_pick = class->pick_task(rq);
+	if (!cookie)
+		return class_pick;
+
+	cookie_pick = sched_core_find(rq, cookie);
+	if (!class_pick)
+		return cookie_pick;
+
+	/*
+	 * If class > max && class > cookie, it is the highest priority task on
+	 * the core (so far) and it must be selected, otherwise we must go with
+	 * the cookie pick in order to satisfy the constraint.
+	 */
+	if (cpu_prio_less(cookie_pick, class_pick) && core_prio_less(max, class_pick))
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
+
+	/* reset state */
+	for_each_cpu(i, smt_mask) {
+		struct rq *rq_i = cpu_rq(i);
+
+		rq_i->core_pick = NULL;
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
+				if (i == cpu && !rq->core->core_cookie)
+					goto next_class;
+
+				continue;
+			}
+
+			/*
+			 * Optimize the 'normal' case where there aren't any
+			 * cookies and we don't need to sync up.
+			 */
+			if (i == cpu && !rq->core->core_cookie && !p->core_cookie) {
+				next = p;
+				goto done;
+			}
+
+			rq_i->core_pick = p;
+
+			/*
+			 * If this new candidate is of higher priority than the
+			 * previous; and they're incompatible; we need to wipe
+			 * the slate and start over.
+			 *
+			 * NOTE: this is a linear max-filter and is thus bounded
+			 * in execution time.
+			 */
+			if (!max || core_prio_less(max, p)) {
+				struct task_struct *old_max = max;
+
+				rq->core->core_cookie = p->core_cookie;
+				max = p;
+
+				if (old_max && !cookie_match(old_max, p)) {
+					for_each_cpu(j, smt_mask) {
+						if (j == i)
+							continue;
+
+						cpu_rq(j)->core_pick = NULL;
+					}
+					goto again;
+				}
+			}
+		}
+next_class:;
+	}
+
+	rq->core->core_pick_seq = rq->core->core_task_seq;
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
+		WARN_ON_ONCE(!rq_i->core_pick);
+
+		if (i == cpu)
+			continue;
+
+		if (rq_i->curr != rq_i->core_pick)
+			resched_curr(rq_i);
+	}
+
+	rq->core_sched_seq = rq->core->core_pick_seq;
+	next = rq->core_pick;
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
@@ -5888,7 +6102,7 @@ static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
 		/*
 		 * pick_next_task() assumes pinned rq->lock:
 		 */
-		next = pick_next_task(rq, &fake_task, rf);
+		next = __pick_next_task(rq, &fake_task, rf);
 		BUG_ON(!next);
 		put_prev_task(rq, next);
 
@@ -6344,7 +6558,11 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = NULL;
+		rq->core_pick = NULL;
 		rq->core_enabled = 0;
+		rq->core_tree = RB_ROOT;
+
+		rq->core_cookie = 0UL;
 #endif
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 16fb236eab7b..4cfde289610d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -960,11 +960,15 @@ struct rq {
 #ifdef CONFIG_SCHED_CORE
 	/* per rq */
 	struct rq		*core;
+	struct task_struct	*core_pick;
 	unsigned int		core_enabled;
+	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
 
 	/* shared state */
 	unsigned int		core_task_seq;
+	unsigned int		core_pick_seq;
+	unsigned long		core_cookie;
 #endif
 };
 
@@ -1770,7 +1774,6 @@ static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
-	WARN_ON_ONCE(rq->curr != next);
 	next->sched_class->set_next_task(rq, next);
 }
 
-- 
2.17.1

