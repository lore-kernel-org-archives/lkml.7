Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63721CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2387220856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="fIdpbmmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfJ3SeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:19 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43194 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfJ3SeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:16 -0400
Received: by mail-yb1-f196.google.com with SMTP id t11so1298001ybk.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=biksFxojxImQpQ9t3eE/NASP2rXB4gSiRiDfGWYDE+w=;
        b=fIdpbmmM03L45/MP6gtB43T7G4h/QMD6WD6FfoxveuXBnEyvmV6/kQh4NO4E5GFCYL
         DIca6ZwnZ+RbUau5wOfj1coRLxl1592VOUBHEKrW5kJfy9D6iKXmVmkHS5HmFytILrly
         eco6WVIDP9NlIkHelqjANqlSo2lxP28fhfofs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=biksFxojxImQpQ9t3eE/NASP2rXB4gSiRiDfGWYDE+w=;
        b=F698tBaypAxTvsYlcHN0jLe4Rd8TcOc8tlAmsIS6CVVkQjBJlPCtr7e2k8yqMuYTrW
         /s1RdgNOqqOhAQUDfk0TXos+XRtL+cqyNbVssLnSKalnFDiAFMVLO6JcgEsgCd0OCvff
         TImrEmogb8uKaRK7OdIxjcbpyuEHTNHDK6BOzH7b/KSfImyrP6kZ2MtB1q9deOxsgCoW
         zNvUJVL5G7ENQu7tWVxB/5TX7sYhm99Eu+G9/kVTSB3m89ozd2q5rtfol1wbE0XqNy+q
         jZ3Qs0+rumAEG50BdUHbcY9d6dyxK4LP/bGJz1FtNDRzK2B3mRsB/3bTpwXMyEuc0LdP
         U29g==
X-Gm-Message-State: APjAAAWyVCq8SzdmYSvtZiGNg5aI1mCpPpA5KhAuQV5BKjL9mig7dxyx
        rxRVAGVwPX7pfJ1vhPrYX0aSgA==
X-Google-Smtp-Source: APXvYqwcJNySQYiFb/SkCK9sKsSXx9peHcmcSCiQruO0clev7Dx/KEM8PnHw8amNCLqgMcfvpddd2g==
X-Received: by 2002:a25:3c84:: with SMTP id j126mr624464yba.482.1572460455301;
        Wed, 30 Oct 2019 11:34:15 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id c13sm312560ywm.109.2019.10.30.11.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:14 -0700 (PDT)
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
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v4 08/19] sched: Rework pick_next_task() slow-path
Date:   Wed, 30 Oct 2019 18:33:21 +0000
Message-Id: <13460d224a949977935be948d007f4e11938cabd.1572437285.git.vpillai@digitalocean.com>
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
index 3fa7d37f2879..1f40211ff29a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3739,7 +3739,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		p = fair_sched_class.pick_next_task(rq, prev, rf);
 		if (unlikely(p == RETRY_TASK))
-			goto again;
+			goto restart;
 
 		/* Assumes fair_sched_class->next == idle_sched_class */
 		if (unlikely(!p))
@@ -3748,14 +3748,19 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
index 416e06c97e98..0c7a51745813 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1729,39 +1729,13 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
index 7ee57472d88e..850e235c9209 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6799,7 +6799,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		goto idle;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	if (prev->sched_class != &fair_sched_class)
+	if (!prev || prev->sched_class != &fair_sched_class)
 		goto simple;
 
 	/*
@@ -6876,8 +6876,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	goto done;
 simple:
 #endif
-
-	put_prev_task(rq, prev);
+	if (prev)
+		put_prev_task(rq, prev);
 
 	do {
 		se = pick_next_entity(cfs_rq, NULL);
@@ -6905,6 +6905,9 @@ done: __maybe_unused;
 	return p;
 
 idle:
+	if (!rf)
+		return NULL;
+
 	new_tasks = newidle_balance(rq, rf);
 
 	/*
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 5848ae3d5210..5bb8d44fbff9 100644
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
index a7d9656f70b5..09c317a916aa 100644
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
index 8b86b24a3ccd..16c9654ac750 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1708,12 +1708,15 @@ struct sched_class {
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

