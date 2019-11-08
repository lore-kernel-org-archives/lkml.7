Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB0C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F0521D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FcWbjedC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfKHNVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:21:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfKHNVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hygrSi0ztJbd+dBSkhH6ffAddwGBz8EoqwwX8uIlEKg=; b=FcWbjedCtVxT9eMmCbXUt5TB3O
        hNbz5maqjlUJOcixnhbukli4mauHkdIRYMJZYiPg9kUYm8XFa1bs8xFrxkbYsQ4tt2RJL7Qj1kht1
        pUgcZaAjUQwg/2BZRTmdXgd0HLXf+jLXqwUMUzVlTbMCwRiCEfkYa1WaWOlM6bxnec2OSx4+ZBKp3
        uKv6oRnefMTEwvdLsRurTpldYlMf0QWzeRdwrD9uMDs6F+nEm0t6iJ7O5M0yETfi5BI71gMEJ0MVS
        pinqVqwTEUTirNgl4xtNAPeEylrtuD/gxywQXLWSn0CXyBX15CO98siuK+wLe3xP99b06JBoxfZXG
        7QptLfSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT4Ca-0006lR-Oi; Fri, 08 Nov 2019 13:21:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2C11306CBC;
        Fri,  8 Nov 2019 14:20:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5493620C10EBC; Fri,  8 Nov 2019 14:21:20 +0100 (CET)
Message-Id: <20191108131909.775434698@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 14:16:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, qperret@google.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        ktkhai@virtuozzo.com, peterz@infradead.org
Subject: [PATCH 7/7] sched: Further clarify sched_class::set_next_task()
References: <20191108131553.027892369@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out there really is something special to the first
set_next_task() invocation. In specific the 'change' pattern really
should not cause balance_callbacks.

Fixes: f95d4eaee6d0 ("sched/{rt,deadline}: Fix set_next_task vs pick_next_task")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c  |    7 +++++--
 kernel/sched/fair.c      |    2 +-
 kernel/sched/idle.c      |    4 ++--
 kernel/sched/rt.c        |    7 +++++--
 kernel/sched/sched.h     |    4 ++--
 kernel/sched/stop_task.c |    4 ++--
 6 files changed, 17 insertions(+), 11 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1743,13 +1743,16 @@ static void start_hrtick_dl(struct rq *r
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
 
@@ -1782,7 +1785,7 @@ static struct task_struct *pick_next_tas
 	dl_se = pick_next_dl_entity(rq, dl_rq);
 	BUG_ON(!dl_se);
 	p = dl_task_of(dl_se);
-	set_next_task_dl(rq, p);
+	set_next_task_dl(rq, p, true);
 	return p;
 }
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10343,7 +10343,7 @@ static void switched_to_fair(struct rq *
  * This routine is mostly called to set cfs_rq->curr field when a task
  * migrates between groups/classes.
  */
-static void set_next_task_fair(struct rq *rq, struct task_struct *p)
+static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct sched_entity *se = &p->se;
 
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -385,7 +385,7 @@ static void put_prev_task_idle(struct rq
 {
 }
 
-static void set_next_task_idle(struct rq *rq, struct task_struct *next)
+static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
@@ -395,7 +395,7 @@ struct task_struct *pick_next_task_idle(
 {
 	struct task_struct *next = rq->idle;
 
-	set_next_task_idle(rq, next);
+	set_next_task_idle(rq, next, true);
 
 	return next;
 }
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1515,13 +1515,16 @@ static void check_preempt_curr_rt(struct
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
@@ -1572,7 +1575,7 @@ static struct task_struct *pick_next_tas
 		return NULL;
 
 	p = _pick_next_task_rt(rq);
-	set_next_task_rt(rq, p);
+	set_next_task_rt(rq, p, true);
 	return p;
 }
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1716,7 +1716,7 @@ struct sched_class {
 	struct task_struct *(*pick_next_task)(struct rq *rq);
 
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
-	void (*set_next_task)(struct rq *rq, struct task_struct *p);
+	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
 
 #ifdef CONFIG_SMP
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
@@ -1768,7 +1768,7 @@ static inline void put_prev_task(struct
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
 	WARN_ON_ONCE(rq->curr != next);
-	next->sched_class->set_next_task(rq, next);
+	next->sched_class->set_next_task(rq, next, false);
 }
 
 #ifdef CONFIG_SMP
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -29,7 +29,7 @@ check_preempt_curr_stop(struct rq *rq, s
 	/* we're never preempted */
 }
 
-static void set_next_task_stop(struct rq *rq, struct task_struct *stop)
+static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool first)
 {
 	stop->se.exec_start = rq_clock_task(rq);
 }
@@ -39,7 +39,7 @@ static struct task_struct *pick_next_tas
 	if (!sched_stop_runnable(rq))
 		return NULL;
 
-	set_next_task_stop(rq, rq->stop);
+	set_next_task_stop(rq, rq->stop, true);
 	return rq->stop;
 }
 


