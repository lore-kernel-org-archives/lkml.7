Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AF8C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BE321901
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RxLsxoz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfGZQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:20:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbfGZQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1b4EtHS9UElvRi3jhTmRTHgqbUNJ8Nk14PkWsQ58Cl0=; b=RxLsxoz8mnNvYOgeshF12V0rbl
        3KOrj0ZgN6lk6Pmt9ykEorCboAokah3MVSJUqxXp4Z39stl6QbqRaNtQT442cblaVj4Cb0BZwQ8fv
        MpAC1cdiusOlv5VFIgeFNN5dFWwp1W4wIl3chiG0sVKZj6lfAevXvFhuFiw8mOAWMuFwowug3byGH
        TSWwx+kXTZoMk4Dvoj7HWDHXVwIbSWkI7NtikSp4SqToI0IoehN6iNoZ2ax6Cby4DZ/Zjk4urcVbM
        wEsNNTttOgUkgmrRBRGtkwGfLFvNg3ffVpP+ivyXollMPK9wbEVOe1z9nqzemnq0IO7iUsUdwGPGR
        Lw2j+Vpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr2wz-0006vp-9j; Fri, 26 Jul 2019 16:20:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 582E220229753; Fri, 26 Jul 2019 18:20:05 +0200 (CEST)
Message-Id: <20190726161357.755285526@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 16:54:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org, peterz@infradead.org
Subject: [RFC][PATCH 07/13] sched: Allow put_prev_task() to drop rq->lock
References: <20190726145409.947503076@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the pick_next_task() loop is convoluted and ugly because of
how it can drop the rq->lock and needs to restart the picking.

For the RT/Deadline classes, it is put_prev_task() where we do
balancing, and we could do this before the picking loop. Make this
possible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |    2 +-
 kernel/sched/deadline.c  |   14 +++++++++++++-
 kernel/sched/fair.c      |    2 +-
 kernel/sched/idle.c      |    2 +-
 kernel/sched/rt.c        |   14 +++++++++++++-
 kernel/sched/sched.h     |    4 ++--
 kernel/sched/stop_task.c |    2 +-
 7 files changed, 32 insertions(+), 8 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6012,7 +6012,7 @@ static void calc_load_migrate(struct rq
 		atomic_long_add(delta, &calc_load_tasks);
 }
 
-static void put_prev_task_fake(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_fake(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 }
 
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1772,13 +1772,25 @@ pick_next_task_dl(struct rq *rq, struct
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
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6871,7 +6871,7 @@ done: __maybe_unused;
 /*
  * Account for a descheduled task:
  */
-static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -374,7 +374,7 @@ static void check_preempt_curr_idle(stru
 	resched_curr(rq);
 }
 
-static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 }
 
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1593,7 +1593,7 @@ pick_next_task_rt(struct rq *rq, struct
 	return p;
 }
 
-static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
+static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 {
 	update_curr_rt(rq);
 
@@ -1605,6 +1605,18 @@ static void put_prev_task_rt(struct rq *
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
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1714,7 +1714,7 @@ struct sched_class {
 	struct task_struct * (*pick_next_task)(struct rq *rq,
 					       struct task_struct *prev,
 					       struct rq_flags *rf);
-	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
+	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct rq_flags *rf);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 
 #ifdef CONFIG_SMP
@@ -1760,7 +1760,7 @@ struct sched_class {
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
 	WARN_ON_ONCE(rq->curr != prev);
-	prev->sched_class->put_prev_task(rq, prev);
+	prev->sched_class->put_prev_task(rq, prev, NULL);
 }
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -59,7 +59,7 @@ static void yield_task_stop(struct rq *r
 	BUG(); /* the stop task should never yield, its pointless. */
 }
 
-static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct task_struct *curr = rq->curr;
 	u64 delta_exec;


