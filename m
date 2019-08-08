Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344BDC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE61F2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UCVmX1ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbfHHK4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:56:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44755 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732082AbfHHK4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:56:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78Atik03127366
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 03:55:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78Atik03127366
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565261745;
        bh=NG2wsUcW2YaTJ2LhVOLqnaSfqPi5EFOBk2xW+xZ/nYc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UCVmX1tiPScQyc1zWVOcgkoT3VM5BCo65QcjqcLIRgJsqtgnTq4UCokfqnI8YrFqu
         879zyf0HKueLGDQ4c4ZQXxJ4glo+RzGKW+P0YHsK3YiJKdvGflPvD+vDQ2uw/GXq8r
         6cLqwKwQOHPCzpG5im6u8ohBkTAU9qEjwsL4anV7vleza3REnKHQ1+b9Q8Ad03AyK4
         025f6Wgtv488DHpi6WJXYw1KTLlhD4tc33ZA/x/H7aQTZoWxboqCV4K89QsuRV+xmZ
         2DqyAq0rdRq91Imh6aiiZs8ZGZKL7/TXX+v431RAqS2EJSbnF44Eom2Jc/TgTPf6zp
         kmom4bLJPdiEA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78Atimq3127363;
        Thu, 8 Aug 2019 03:55:44 -0700
Date:   Thu, 8 Aug 2019 03:55:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-f95d4eaee6d0207bff2dc93371133d31227d4cfb@git.kernel.org>
Cc:     aaron.lwe@gmail.com, valentin.schneider@arm.com, pauld@redhat.com,
        peterz@infradead.org, hpa@zytor.com, jdesfossez@digitalocean.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        naravamudan@digitalocean.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          naravamudan@digitalocean.com, mingo@kernel.org,
          jdesfossez@digitalocean.com, hpa@zytor.com, pauld@redhat.com,
          peterz@infradead.org, valentin.schneider@arm.com,
          aaron.lwe@gmail.com
In-Reply-To: <38c61d5240553e043c27c5e00b9dd0d184dd6081.1559129225.git.vpillai@digitalocean.com>
References: <38c61d5240553e043c27c5e00b9dd0d184dd6081.1559129225.git.vpillai@digitalocean.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/{rt,deadline}: Fix set_next_task vs
 pick_next_task
Git-Commit-ID: f95d4eaee6d0207bff2dc93371133d31227d4cfb
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

Commit-ID:  f95d4eaee6d0207bff2dc93371133d31227d4cfb
Gitweb:     https://git.kernel.org/tip/f95d4eaee6d0207bff2dc93371133d31227d4cfb
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 29 May 2019 20:36:40 +0000
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:30 +0200

sched/{rt,deadline}: Fix set_next_task vs pick_next_task

Because pick_next_task() implies set_curr_task() and some of the
details haven't mattered too much, some of what _should_ be in
set_curr_task() ended up in pick_next_task, correct this.

This prepares the way for a pick_next_task() variant that does not
affect the current state; allowing remote picking.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Aaron Lu <aaron.lwe@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: mingo@kernel.org
Cc: Phil Auld <pauld@redhat.com>
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
Link: https://lkml.kernel.org/r/38c61d5240553e043c27c5e00b9dd0d184dd6081.1559129225.git.vpillai@digitalocean.com
---
 kernel/sched/deadline.c | 22 +++++++++++-----------
 kernel/sched/rt.c       | 26 +++++++++++++-------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 039dde2b1dac..2dc2784b196c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1727,12 +1727,20 @@ static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
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
+	deadline_queue_push_tasks(rq);
 }
 
 static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
@@ -1791,15 +1799,7 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
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
@@ -1846,7 +1846,7 @@ static void task_fork_dl(struct task_struct *p)
 
 static void set_curr_task_dl(struct rq *rq)
 {
-	set_next_task(rq, rq->curr);
+	set_next_task_dl(rq, rq->curr);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a532558a5176..40bb71004325 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1498,12 +1498,22 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
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
+	rt_queue_push_tasks(rq);
 }
 
 static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
@@ -1577,17 +1587,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
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
@@ -2356,7 +2356,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 
 static void set_curr_task_rt(struct rq *rq)
 {
-	set_next_task(rq, rq->curr);
+	set_next_task_rt(rq, rq->curr);
 }
 
 static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
