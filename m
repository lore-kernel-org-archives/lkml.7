Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7151C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8532B218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388747AbfGZTTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:19:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50187 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388521AbfGZTS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:18:58 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr5jz-00019z-KV; Fri, 26 Jul 2019 21:18:55 +0200
Message-Id: <20190726185753.077004842@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 20:30:52 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 04/12] sched: Mark hrtimers to expire in hard interrupt context
References: <20190726183048.982726647@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The scheduler related hrtimers need to expire in hard interrupt context
even on PREEMPT_RT enabled kernels. Mark then as such.

No functional change.

[ tglx: Split out from larger combo patch. Add changelog. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c     |    2 +-
 kernel/sched/deadline.c |    2 +-
 kernel/sched/fair.c     |    6 ++++--
 kernel/sched/rt.c       |    4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -328,7 +328,7 @@ static void hrtick_rq_init(struct rq *rq
 	rq->hrtick_csd.info = rq;
 #endif
 
-	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	rq->hrtick_timer.function = hrtick;
 }
 #else	/* CONFIG_SCHED_HRTICK */
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1053,7 +1053,7 @@ void init_dl_task_timer(struct sched_dl_
 {
 	struct hrtimer *timer = &dl_se->dl_timer;
 
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	timer->function = dl_task_timer;
 }
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4972,9 +4972,11 @@ void init_cfs_bandwidth(struct cfs_bandw
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_ABS_PINNED_HARD);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL_HARD);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 	cfs_b->distribute_running = 0;
 	cfs_b->slack_started = false;
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -45,8 +45,8 @@ void init_rt_bandwidth(struct rt_bandwid
 
 	raw_spin_lock_init(&rt_b->rt_runtime_lock);
 
-	hrtimer_init(&rt_b->rt_period_timer,
-			CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&rt_b->rt_period_timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL_HARD);
 	rt_b->rt_period_timer.function = sched_rt_period_timer;
 }
 


