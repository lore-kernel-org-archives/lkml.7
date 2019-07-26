Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E565CC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FDD218EA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MKYVoWRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfGZQUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:20:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57060 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfGZQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vg95r2KBamuGSEOXqgQn9SlssmM0thVs3rKhlq+wsdU=; b=MKYVoWRV/vqExsEpYFK6nvvc6f
        cQVGTtkrfs9xNuAkc9j4hOUWA3U72MdTp9mYSkKa9VcFQmzJ+NAI81bvr4oIDzLn+1TIv5zxD1RLi
        oZiWpK5cyhFH+/zIME8mxWjS9KaJ9Dtzk44cQuxErtgFnCeJHXlwerFqY6TWrc3wcLrTNG4hZK8IO
        rSKiaqxyuu2IPt/SV9DjgHIZBryhgq+TLc+4Xa726waryfNhAm/hiSDz+PwWtWRU+miIZ33UJEQgm
        +OuilqbXA2xG+CoH9hg10QJtHky7F4QPmm/8htt6KZIQ9/bRSmku5LYVeUrdIDiAikRiLHVjCaZa0
        L+vp0dMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr2wy-00066S-3C; Fri, 26 Jul 2019 16:20:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4C4DE20229750; Fri, 26 Jul 2019 18:20:05 +0200 (CEST)
Message-Id: <20190726161357.579899041@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 16:54:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org, peterz@infradead.org
Subject: [RFC][PATCH 04/13] sched/{rt,deadline}: Fix set_next_task vs pick_next_task
References: <20190726145409.947503076@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because pick_next_task() implies set_curr_task() and some of the
details haven't matter too much, some of what _should_ be in
set_curr_task() ended up in pick_next_task, correct this.

This prepares the way for a pick_next_task() variant that does not
affect the current state; allowing remote picking.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c |   23 ++++++++++++-----------
 kernel/sched/rt.c       |   27 ++++++++++++++-------------
 2 files changed, 26 insertions(+), 24 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1694,12 +1694,21 @@ static void start_hrtick_dl(struct rq *r
 }
 #endif
 
-static inline void set_next_task(struct rq *rq, struct task_struct *p)
+static void set_next_task_dl(struct rq *rq, struct task_struct *p)
 {
 	p->se.exec_start = rq_clock_task(rq);
 
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
+
+	if (hrtick_enabled(rq))
+		start_hrtick_dl(rq, p);
+
+	if (rq->curr->sched_class != &dl_sched_class)
+		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+
+	if (rq->curr != p)
+		deadline_queue_push_tasks(rq);
 }
 
 static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
@@ -1758,15 +1767,7 @@ pick_next_task_dl(struct rq *rq, struct
 
 	p = dl_task_of(dl_se);
 
-	set_next_task(rq, p);
-
-	if (hrtick_enabled(rq))
-		start_hrtick_dl(rq, p);
-
-	deadline_queue_push_tasks(rq);
-
-	if (rq->curr->sched_class != &dl_sched_class)
-		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+	set_next_task_dl(rq, p);
 
 	return p;
 }
@@ -1813,7 +1814,7 @@ static void task_fork_dl(struct task_str
 
 static void set_curr_task_dl(struct rq *rq)
 {
-	set_next_task(rq, rq->curr);
+	set_next_task_dl(rq, rq->curr);
 }
 
 #ifdef CONFIG_SMP
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1498,12 +1498,23 @@ static void check_preempt_curr_rt(struct
 #endif
 }
 
-static inline void set_next_task(struct rq *rq, struct task_struct *p)
+static inline void set_next_task_rt(struct rq *rq, struct task_struct *p)
 {
 	p->se.exec_start = rq_clock_task(rq);
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
+
+	/*
+	 * If prev task was rt, put_prev_task() has already updated the
+	 * utilization. We only care of the case where we start to schedule a
+	 * rt task
+	 */
+	if (rq->curr->sched_class != &rt_sched_class)
+		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+
+	if (rq->curr != p)
+		rt_queue_push_tasks(rq);
 }
 
 static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
@@ -1577,17 +1588,7 @@ pick_next_task_rt(struct rq *rq, struct
 
 	p = _pick_next_task_rt(rq);
 
-	set_next_task(rq, p);
-
-	rt_queue_push_tasks(rq);
-
-	/*
-	 * If prev task was rt, put_prev_task() has already updated the
-	 * utilization. We only care of the case where we start to schedule a
-	 * rt task
-	 */
-	if (rq->curr->sched_class != &rt_sched_class)
-		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+	set_next_task_rt(rq, p);
 
 	return p;
 }
@@ -2356,7 +2357,7 @@ static void task_tick_rt(struct rq *rq,
 
 static void set_curr_task_rt(struct rq *rq)
 {
-	set_next_task(rq, rq->curr);
+	set_next_task_rt(rq, rq->curr);
 }
 
 static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)


