Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61600C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C8F2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="urB6Hv2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbfHHK7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:59:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47523 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHK7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:59:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78AwjiY3127973
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 03:58:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78AwjiY3127973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565261925;
        bh=NJSJma+mK9+wqBvelA3hphNOwL4DNEshM/EJHZ+DEBI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=urB6Hv2iZU7mQsKSIcEQsq1JvKvXcxVLeDPs1lZO8axIz/agiFDjjJu5zzmgO8Smp
         yCL3DQknW6Yt4OQJ/iJKgeFasNNnqHmH06VjS+VnVjj5dT7FTsn4WtIDZvZLNd9j4H
         CuIzBFUwQ7dbk+RZK4bxqat5rinSNq9/qGulyT0R5vTdTaOi1XAHOqT+0fQFOu3T42
         PnMxQ1ZV270Tz+m0GGzHPHRvhOeYkpTqeTeRNewbKQxAjVzNvvTqbRz6D31UD6oQto
         YYlT6LQ/oS5MP0CNWXhwRfxrVd96nvNmfF8Q2TPGDngCvau51pzcc72R4UrdsEjocJ
         muLTTvyDIEa7w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78Awj8E3127970;
        Thu, 8 Aug 2019 03:58:45 -0700
Date:   Thu, 8 Aug 2019 03:58:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-5f2a45fc9e89e022233085e6f0f352eb6ff770bb@git.kernel.org>
Cc:     aaron.lwe@gmail.com, naravamudan@digitalocean.com,
        pauld@redhat.com, mingo@kernel.org, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, hpa@zytor.com, jdesfossez@digitalocean.com
Reply-To: pauld@redhat.com, valentin.schneider@arm.com, mingo@kernel.org,
          naravamudan@digitalocean.com, aaron.lwe@gmail.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          peterz@infradead.org, hpa@zytor.com, jdesfossez@digitalocean.com
In-Reply-To: <e4519f6850477ab7f3d257062796e6425ee4ba7c.1559129225.git.vpillai@digitalocean.com>
References: <e4519f6850477ab7f3d257062796e6425ee4ba7c.1559129225.git.vpillai@digitalocean.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched: Allow put_prev_task() to drop rq->lock
Git-Commit-ID: 5f2a45fc9e89e022233085e6f0f352eb6ff770bb
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

Commit-ID:  5f2a45fc9e89e022233085e6f0f352eb6ff770bb
Gitweb:     https://git.kernel.org/tip/5f2a45fc9e89e022233085e6f0f352eb6ff770bb
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 29 May 2019 20:36:43 +0000
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:31 +0200

sched: Allow put_prev_task() to drop rq->lock

Currently the pick_next_task() loop is convoluted and ugly because of
how it can drop the rq->lock and needs to restart the picking.

For the RT/Deadline classes, it is put_prev_task() where we do
balancing, and we could do this before the picking loop. Make this
possible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Aaron Lu <aaron.lwe@gmail.com>
Cc: mingo@kernel.org
Cc: Phil Auld <pauld@redhat.com>
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
Link: https://lkml.kernel.org/r/e4519f6850477ab7f3d257062796e6425ee4ba7c.1559129225.git.vpillai@digitalocean.com
---
 kernel/sched/core.c      |  2 +-
 kernel/sched/deadline.c  | 14 +++++++++++++-
 kernel/sched/fair.c      |  2 +-
 kernel/sched/idle.c      |  2 +-
 kernel/sched/rt.c        | 14 +++++++++++++-
 kernel/sched/sched.h     |  4 ++--
 kernel/sched/stop_task.c |  2 +-
 7 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0c4220789092..7bbe78a31ba5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6090,7 +6090,7 @@ static struct task_struct *__pick_migrate_task(struct rq *rq)
 	for_each_class(class) {
 		next = class->pick_next_task(rq, NULL, NULL);
 		if (next) {
-			next->sched_class->put_prev_task(rq, next);
+			next->sched_class->put_prev_task(rq, next, NULL);
 			return next;
 		}
 	}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6eae79350303..2872e15a87cd 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1804,13 +1804,25 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return p;
 }
 
-static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
+static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 {
 	update_curr_dl(rq);
 
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
+
+	if (rf && !on_dl_rq(&p->dl) && need_pull_dl_task(rq, p)) {
+		/*
+		 * This is OK, because current is on_cpu, which avoids it being
+		 * picked for load-balance and preemption/IRQs are still
+		 * disabled avoiding further scheduler activity on it and we've
+		 * not yet started the picking loop.
+		 */
+		rq_unpin_lock(rq, rf);
+		pull_dl_task(rq);
+		rq_repin_lock(rq, rf);
+	}
 }
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7c27eda9f24..4418c1998e69 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6901,7 +6901,7 @@ idle:
 /*
  * Account for a descheduled task:
  */
-static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 54194d41035c..8d59de2e4a6e 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -374,7 +374,7 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 	resched_curr(rq);
 }
 
-static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f71bcbe1a00c..dbdabd76f192 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1592,7 +1592,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return p;
 }
 
-static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
+static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 {
 	update_curr_rt(rq);
 
@@ -1604,6 +1604,18 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 	 */
 	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rq, p);
+
+	if (rf && !on_rt_rq(&p->rt) && need_pull_rt_task(rq, p)) {
+		/*
+		 * This is OK, because current is on_cpu, which avoids it being
+		 * picked for load-balance and preemption/IRQs are still
+		 * disabled avoiding further scheduler activity on it and we've
+		 * not yet started the picking loop.
+		 */
+		rq_unpin_lock(rq, rf);
+		pull_rt_task(rq);
+		rq_repin_lock(rq, rf);
+	}
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 304d98e712bf..e085cffb8004 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1710,7 +1710,7 @@ struct sched_class {
 	struct task_struct * (*pick_next_task)(struct rq *rq,
 					       struct task_struct *prev,
 					       struct rq_flags *rf);
-	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
+	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct rq_flags *rf);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 
 #ifdef CONFIG_SMP
@@ -1756,7 +1756,7 @@ struct sched_class {
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
 	WARN_ON_ONCE(rq->curr != prev);
-	prev->sched_class->put_prev_task(rq, prev);
+	prev->sched_class->put_prev_task(rq, prev, NULL);
 }
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 47a3d2a18a9a..8f414018d5e0 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -59,7 +59,7 @@ static void yield_task_stop(struct rq *rq)
 	BUG(); /* the stop task should never yield, its pointless. */
 }
 
-static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct task_struct *curr = rq->curr;
 	u64 delta_exec;
