Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4D4C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AB120865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K7ykV8a/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfKHNVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:21:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbfKHNVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x9saMFImixsxOxkUO0AAt4+/Da45uLV/ytMqEdGsD4w=; b=K7ykV8a/cTqIkLQt4wsEskc+Zi
        3p6KRqvDO9wRdhciWyTA3NjR7/ofykeLq1WRvsmk2aHkxqRBFFBqEqck3Rl/Cpi7K8K1beT5PJUsF
        pu7PJgPS8NEMLdtkiwCQlfiYewLbG9itFf8AW+lpA4fYvRSjp5xJBDTEOTStE0SOR8WDaM94WkiwW
        RTRUL0BAdppxN56Rb6EtcDgwE/ivTAmb5p8KL/X/f4oDNCN5kvqyWUnSTZjBVB6W3HIvbKF6LZYCm
        fRZkfSHUxzwhBayYnFptD3JWNGo5tT0s5NLCHmXYzYKLQVN/dzyrecYaDgSd0kfxTxoRJVdHEwrit
        ZJiYjy/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT4CY-0006lJ-T7; Fri, 08 Nov 2019 13:21:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD3BE306C06;
        Fri,  8 Nov 2019 14:20:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4DECB20C10EB9; Fri,  8 Nov 2019 14:21:20 +0100 (CET)
Message-Id: <20191108131909.660595546@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 14:15:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, qperret@google.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        ktkhai@virtuozzo.com, peterz@infradead.org
Subject: [PATCH 5/7] sched: Simplify sched_class::pick_next_task()
References: <20191108131553.027892369@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the indirect class call never uses the last two arguments of
pick_next_task(), remove them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |    6 +++---
 kernel/sched/deadline.c  |    5 +----
 kernel/sched/fair.c      |    7 ++++++-
 kernel/sched/idle.c      |    5 +----
 kernel/sched/rt.c        |    5 +----
 kernel/sched/sched.h     |   18 +++---------------
 kernel/sched/stop_task.c |    5 +----
 7 files changed, 16 insertions(+), 35 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3924,7 +3924,7 @@ pick_next_task(struct rq *rq, struct tas
 		/* Assumes fair_sched_class->next == idle_sched_class */
 		if (!p) {
 			put_prev_task(rq, prev);
-			p = pick_next_task_idle(rq, NULL, NULL);
+			p = pick_next_task_idle(rq);
 		}
 
 		return p;
@@ -3941,7 +3941,7 @@ pick_next_task(struct rq *rq, struct tas
 	put_prev_task(rq, prev);
 
 	for_each_class(class) {
-		p = class->pick_next_task(rq, NULL, NULL);
+		p = class->pick_next_task(rq);
 		if (p)
 			return p;
 	}
@@ -6203,7 +6203,7 @@ static struct task_struct *__pick_migrat
 	struct task_struct *next;
 
 	for_each_class(class) {
-		next = class->pick_next_task(rq, NULL, NULL);
+		next = class->pick_next_task(rq);
 		if (next) {
 			next->sched_class->put_prev_task(rq, next);
 			return next;
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1770,15 +1770,12 @@ static struct sched_dl_entity *pick_next
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
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6743,6 +6743,11 @@ done: __maybe_unused;
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
@@ -10621,7 +10626,7 @@ const struct sched_class fair_sched_clas
 
 	.check_preempt_curr	= check_preempt_wakeup,
 
-	.pick_next_task		= pick_next_task_fair,
+	.pick_next_task		= __pick_next_task_fair,
 	.put_prev_task		= put_prev_task_fair,
 	.set_next_task          = set_next_task_fair,
 
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -391,13 +391,10 @@ static void set_next_task_idle(struct rq
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
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1564,13 +1564,10 @@ static struct task_struct *_pick_next_ta
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
 
@@ -1822,7 +1810,7 @@ static inline bool sched_fair_runnable(s
 }
 
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-extern struct task_struct *pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
+extern struct task_struct *pick_next_task_idle(struct rq *rq);
 
 #ifdef CONFIG_SMP
 
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -34,11 +34,8 @@ static void set_next_task_stop(struct rq
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
 


