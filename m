Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A65C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A1020818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfKKJdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:33:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55834 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfKKJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:33:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iU63m-00038T-RS; Mon, 11 Nov 2019 10:32:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6B4DA1C0093;
        Mon, 11 Nov 2019 10:32:34 +0100 (CET)
Date:   Mon, 11 Nov 2019 09:32:34 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Further clarify sched_class::set_next_task()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        ktkhai@virtuozzo.com, mgorman@suse.de, qais.yousef@arm.com,
        qperret@google.com, rostedt@goodmis.org,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108131909.775434698@infradead.org>
References: <20191108131909.775434698@infradead.org>
MIME-Version: 1.0
Message-ID: <157346475407.29376.10359988629214177511.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a0e813f26ebcb25c0b5e504498fbd796cca1a4ba
Gitweb:        https://git.kernel.org/tip/a0e813f26ebcb25c0b5e504498fbd796cca1a4ba
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Nov 2019 14:16:00 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Nov 2019 08:35:21 +01:00

sched/core: Further clarify sched_class::set_next_task()

It turns out there really is something special to the first
set_next_task() invocation. In specific the 'change' pattern really
should not cause balance callbacks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bsegall@google.com
Cc: dietmar.eggemann@arm.com
Cc: juri.lelli@redhat.com
Cc: ktkhai@virtuozzo.com
Cc: mgorman@suse.de
Cc: qais.yousef@arm.com
Cc: qperret@google.com
Cc: rostedt@goodmis.org
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Fixes: f95d4eaee6d0 ("sched/{rt,deadline}: Fix set_next_task vs pick_next_task")
Link: https://lkml.kernel.org/r/20191108131909.775434698@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/deadline.c  | 7 +++++--
 kernel/sched/fair.c      | 2 +-
 kernel/sched/idle.c      | 4 ++--
 kernel/sched/rt.c        | 7 +++++--
 kernel/sched/sched.h     | 4 ++--
 kernel/sched/stop_task.c | 4 ++--
 6 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f7fbb44..43323f8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1743,13 +1743,16 @@ static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
 }
 #endif
 
-static void set_next_task_dl(struct rq *rq, struct task_struct *p)
+static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 {
 	p->se.exec_start = rq_clock_task(rq);
 
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
 
+	if (!first)
+		return;
+
 	if (hrtick_enabled(rq))
 		start_hrtick_dl(rq, p);
 
@@ -1782,7 +1785,7 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 	dl_se = pick_next_dl_entity(rq, dl_rq);
 	BUG_ON(!dl_se);
 	p = dl_task_of(dl_se);
-	set_next_task_dl(rq, p);
+	set_next_task_dl(rq, p, true);
 	return p;
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ba97d1a..81eba55 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10344,7 +10344,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
  * This routine is mostly called to set cfs_rq->curr field when a task
  * migrates between groups/classes.
  */
-static void set_next_task_fair(struct rq *rq, struct task_struct *p)
+static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct sched_entity *se = &p->se;
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f88b79e..428cd05 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -385,7 +385,7 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
 }
 
-static void set_next_task_idle(struct rq *rq, struct task_struct *next)
+static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
@@ -395,7 +395,7 @@ struct task_struct *pick_next_task_idle(struct rq *rq)
 {
 	struct task_struct *next = rq->idle;
 
-	set_next_task_idle(rq, next);
+	set_next_task_idle(rq, next, true);
 
 	return next;
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 38027c0..e591d40 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1515,13 +1515,16 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 #endif
 }
 
-static inline void set_next_task_rt(struct rq *rq, struct task_struct *p)
+static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
 {
 	p->se.exec_start = rq_clock_task(rq);
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
 
+	if (!first)
+		return;
+
 	/*
 	 * If prev task was rt, put_prev_task() has already updated the
 	 * utilization. We only care of the case where we start to schedule a
@@ -1572,7 +1575,7 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
 		return NULL;
 
 	p = _pick_next_task_rt(rq);
-	set_next_task_rt(rq, p);
+	set_next_task_rt(rq, p, true);
 	return p;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 75d96cc..05c2827 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1716,7 +1716,7 @@ struct sched_class {
 	struct task_struct *(*pick_next_task)(struct rq *rq);
 
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
-	void (*set_next_task)(struct rq *rq, struct task_struct *p);
+	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
 
 #ifdef CONFIG_SMP
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
@@ -1768,7 +1768,7 @@ static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
 	WARN_ON_ONCE(rq->curr != next);
-	next->sched_class->set_next_task(rq, next);
+	next->sched_class->set_next_task(rq, next, false);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 0aefdfb..4c9e997 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -29,7 +29,7 @@ check_preempt_curr_stop(struct rq *rq, struct task_struct *p, int flags)
 	/* we're never preempted */
 }
 
-static void set_next_task_stop(struct rq *rq, struct task_struct *stop)
+static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool first)
 {
 	stop->se.exec_start = rq_clock_task(rq);
 }
@@ -39,7 +39,7 @@ static struct task_struct *pick_next_task_stop(struct rq *rq)
 	if (!sched_stop_runnable(rq))
 		return NULL;
 
-	set_next_task_stop(rq, rq->stop);
+	set_next_task_stop(rq, rq->stop, true);
 	return rq->stop;
 }
 
