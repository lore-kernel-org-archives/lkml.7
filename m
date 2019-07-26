Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDE9C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D3D21901
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2jziYZST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfGZQUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:20:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57062 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbfGZQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SpMi5sOhIYD3roQa84wOPn7StPj6QRDmcoeVo4NB+S0=; b=2jziYZSTmijt7b5N7WLNFH7oQC
        SsXXxtlyPAmpsX4Eg/ZGZn6sW5q8Glp5T9OTlDlamPG+xnGA1xNG4+ML8Rjn2lC0JQ07oEl5xwqoF
        fCFiBCJ3TdN60BjDzCnC+t9iKywQcoPwssKmR9fda6Xkxn17vIEMllrhZ6HJ9hhrSPiqNIbGWNTeC
        r2I96W8ZIfVCLf5vqzhABrJ+udV6xi1pDWfKaMdOOM6v5PHmHV2KDvEuetdF7vzv/3UFCs0Q76HNH
        8KTaq3wH6qjKbSG9Hn7vUpdXHjxMZ0OEUyoAhXxgpuBQbWk9RiuBT0PH0xJRJk7C4ehsVgq7c6ghx
        7aRUzwjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr2wz-00066d-OT; Fri, 26 Jul 2019 16:20:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 74DE820229759; Fri, 26 Jul 2019 18:20:05 +0200 (CEST)
Message-Id: <20190726161358.113257053@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 16:54:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org, peterz@infradead.org
Subject: [RFC][PATCH 13/13] sched/fair: Add trivial fair server
References: <20190726145409.947503076@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c     |    6 +++++-
 kernel/sched/deadline.c |    2 ++
 kernel/sched/fair.c     |   29 +++++++++++++++++++++++++++++
 kernel/sched/sched.h    |    6 +++++-
 4 files changed, 41 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6501,6 +6504,7 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+		fair_server_init(rq);
 	}
 
 	set_load_weight(&init_task, false);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5239,6 +5239,9 @@ enqueue_task_fair(struct rq *rq, struct
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
+	if (!rq->cfs.h_nr_running)
+		dl_server_start(&rq->fair_server);
+
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -5374,6 +5377,9 @@ static void dequeue_task_fair(struct rq
 	if (!se)
 		sub_nr_running(rq, 1);
 
+	if (!rq->cfs.h_nr_running)
+		dl_server_stop(&rq->fair_server);
+
 	util_est_dequeue(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -6903,6 +6909,29 @@ done: __maybe_unused;
 	return NULL;
 }
 
+static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
+{
+	return !!dl_se->rq->cfs.nr_running;
+}
+
+static struct task_struct *fair_server_pick(struct sched_dl_entity *dl_se)
+{
+	return pick_next_task_fair(dl_se->rq, NULL, NULL);
+}
+
+void fair_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->fair_server;
+
+	init_dl_entity(dl_se);
+
+	dl_se->dl_runtime = TICK_NSEC;
+	dl_se->dl_deadline = 20 * TICK_NSEC;
+	dl_se->dl_period = 20 * TICK_NSEC;
+
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
+}
+
 /*
  * Account for a descheduled task:
  */
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -345,6 +345,8 @@ extern void dl_server_init(struct sched_
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick);
 
+extern void fair_server_init(struct rq *);
+
 #ifdef CONFIG_CGROUP_SCHED
 
 #include <linux/cgroup.h>
@@ -905,6 +907,8 @@ struct rq {
 	struct rt_rq		rt;
 	struct dl_rq		dl;
 
+	struct sched_dl_entity	fair_server;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
 	struct list_head	leaf_cfs_rq_list;
@@ -968,7 +972,7 @@ struct rq {
 
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
-#endif
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;


