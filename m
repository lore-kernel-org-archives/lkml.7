Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B6DC17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA3C2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfKKJc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:32:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55814 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKKJc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:32:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iU63n-00038t-OW; Mon, 11 Nov 2019 10:32:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5AAF31C0093;
        Mon, 11 Nov 2019 10:32:35 +0100 (CET)
Date:   Mon, 11 Nov 2019 09:32:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Simplify sched_class::pick_next_task()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        ktkhai@virtuozzo.com, mgorman@suse.de, qais.yousef@arm.com,
        qperret@google.com, rostedt@goodmis.org,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108131909.660595546@infradead.org>
References: <20191108131909.660595546@infradead.org>
MIME-Version: 1.0
Message-ID: <157346475502.29376.15329961374914157251.tip-bot2@tip-bot2>
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

Commit-ID:     98c2f700edb413e4baa4a0368c5861d96211a775
Gitweb:        https://git.kernel.org/tip/98c2f700edb413e4baa4a0368c5861d96211a775
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Nov 2019 14:15:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Nov 2019 08:35:20 +01:00

sched/core: Simplify sched_class::pick_next_task()

Now that the indirect class call never uses the last two arguments of
pick_next_task(), remove them.

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
Link: https://lkml.kernel.org/r/20191108131909.660595546@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c      |  6 +++---
 kernel/sched/deadline.c  |  5 +----
 kernel/sched/fair.c      |  7 ++++++-
 kernel/sched/idle.c      |  5 +----
 kernel/sched/rt.c        |  5 +----
 kernel/sched/sched.h     | 18 +++---------------
 kernel/sched/stop_task.c |  5 +----
 7 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7cf6547..513a479 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3924,7 +3924,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		/* Assumes fair_sched_class->next == idle_sched_class */
 		if (!p) {
 			put_prev_task(rq, prev);
-			p = pick_next_task_idle(rq, NULL, NULL);
+			p = pick_next_task_idle(rq);
 		}
 
 		return p;
@@ -3949,7 +3949,7 @@ restart:
 	put_prev_task(rq, prev);
 
 	for_each_class(class) {
-		p = class->pick_next_task(rq, NULL, NULL);
+		p = class->pick_next_task(rq);
 		if (p)
 			return p;
 	}
@@ -6210,7 +6210,7 @@ static struct task_struct *__pick_migrate_task(struct rq *rq)
 	struct task_struct *next;
 
 	for_each_class(class) {
-		next = class->pick_next_task(rq, NULL, NULL);
+		next = class->pick_next_task(rq);
 		if (next) {
 			next->sched_class->put_prev_task(rq, next);
 			return next;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a8a0803..f7fbb44 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1770,15 +1770,12 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 	return rb_entry(left, struct sched_dl_entity, rb_node);
 }
 
-static struct task_struct *
-pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static struct task_struct *pick_next_task_dl(struct rq *rq)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
 	struct task_struct *p;
 
-	WARN_ON_ONCE(prev || rf);
-
 	if (!sched_dl_runnable(rq))
 		return NULL;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da81451..1789193 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6755,6 +6755,11 @@ idle:
 	return NULL;
 }
 
+static struct task_struct *__pick_next_task_fair(struct rq *rq)
+{
+	return pick_next_task_fair(rq, NULL, NULL);
+}
+
 /*
  * Account for a descheduled task:
  */
@@ -10622,7 +10627,7 @@ const struct sched_class fair_sched_class = {
 
 	.check_preempt_curr	= check_preempt_wakeup,
 
-	.pick_next_task		= pick_next_task_fair,
+	.pick_next_task		= __pick_next_task_fair,
 	.put_prev_task		= put_prev_task_fair,
 	.set_next_task          = set_next_task_fair,
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 0fdceac..f88b79e 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -391,13 +391,10 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next)
 	schedstat_inc(rq->sched_goidle);
 }
 
-struct task_struct *
-pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+struct task_struct *pick_next_task_idle(struct rq *rq)
 {
 	struct task_struct *next = rq->idle;
 
-	WARN_ON_ONCE(prev || rf);
-
 	set_next_task_idle(rq, next);
 
 	return next;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 9b8adc0..38027c0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1564,13 +1564,10 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *
-pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static struct task_struct *pick_next_task_rt(struct rq *rq)
 {
 	struct task_struct *p;
 
-	WARN_ON_ONCE(prev || rf);
-
 	if (!sched_rt_runnable(rq))
 		return NULL;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 66172a3..75d96cc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1713,20 +1713,8 @@ struct sched_class {
 
 	void (*check_preempt_curr)(struct rq *rq, struct task_struct *p, int flags);
 
-	/*
-	 * Both @prev and @rf are optional and may be NULL, in which case the
-	 * caller must already have invoked put_prev_task(rq, prev, rf).
-	 *
-	 * Otherwise it is the responsibility of the pick_next_task() to call
-	 * put_prev_task() on the @prev task or something equivalent, IFF it
-	 * returns a next task.
-	 *
-	 * In that case (@rf != NULL) it may return RETRY_TASK when it finds a
-	 * higher prio class has runnable tasks.
-	 */
-	struct task_struct * (*pick_next_task)(struct rq *rq,
-					       struct task_struct *prev,
-					       struct rq_flags *rf);
+	struct task_struct *(*pick_next_task)(struct rq *rq);
+
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 
@@ -1822,7 +1810,7 @@ static inline bool sched_fair_runnable(struct rq *rq)
 }
 
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-extern struct task_struct *pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
+extern struct task_struct *pick_next_task_idle(struct rq *rq);
 
 #ifdef CONFIG_SMP
 
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index c064073..0aefdfb 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -34,11 +34,8 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop)
 	stop->se.exec_start = rq_clock_task(rq);
 }
 
-static struct task_struct *
-pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static struct task_struct *pick_next_task_stop(struct rq *rq)
 {
-	WARN_ON_ONCE(prev || rf);
-
 	if (!sched_stop_runnable(rq))
 		return NULL;
 
