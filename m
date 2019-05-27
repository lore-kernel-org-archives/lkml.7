Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D609C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDC0217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfE0GVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:21:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56190 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfE0GVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:21:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4BC71684;
        Sun, 26 May 2019 23:21:45 -0700 (PDT)
Received: from e107985-lin.cambridge.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B45313F59C;
        Sun, 26 May 2019 23:21:43 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] sched/fair: Remove sgs->sum_weighted_load
Date:   Mon, 27 May 2019 07:21:15 +0100
Message-Id: <20190527062116.11512-7-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527062116.11512-1-dietmar.eggemann@arm.com>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since sg_lb_stats::sum_weighted_load is now identical with
sg_lb_stats::group_load remove it and replace its use case
(calculating load per task) with the latter.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 88779c45e8e6..a33f196703a7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7580,7 +7580,6 @@ static unsigned long task_h_load(struct task_struct *p)
 struct sg_lb_stats {
 	unsigned long avg_load; /*Avg load across the CPUs of the group */
 	unsigned long group_load; /* Total load over the CPUs of the group */
-	unsigned long sum_weighted_load; /* Weighted load of group's tasks */
 	unsigned long load_per_task;
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
@@ -7947,7 +7946,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->nr_numa_running += rq->nr_numa_running;
 		sgs->nr_preferred_running += rq->nr_preferred_running;
 #endif
-		sgs->sum_weighted_load += weighted_cpuload(rq);
 		/*
 		 * No need to call idle_cpu() if nr_running is not 0
 		 */
@@ -7966,7 +7964,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
 
 	if (sgs->sum_nr_running)
-		sgs->load_per_task = sgs->sum_weighted_load / sgs->sum_nr_running;
+		sgs->load_per_task = sgs->group_load / sgs->sum_nr_running;
 
 	sgs->group_weight = group->group_weight;
 
-- 
2.17.1

