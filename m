Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958DEC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FCA2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfE0GVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:21:43 -0400
Received: from foss.arm.com ([217.140.101.70]:56154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfE0GVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:21:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D67E374;
        Sun, 26 May 2019 23:21:41 -0700 (PDT)
Received: from e107985-lin.cambridge.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C5A13F59C;
        Sun, 26 May 2019 23:21:39 -0700 (PDT)
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
Subject: [PATCH 4/7] sched: Remove rq->cpu_load[]
Date:   Mon, 27 May 2019 07:21:13 +0100
Message-Id: <20190527062116.11512-5-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527062116.11512-1-dietmar.eggemann@arm.com>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per rq load array values also disappear from the cpu#X sections in
/proc/sched_debug.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  | 6 +-----
 kernel/sched/debug.c | 5 -----
 kernel/sched/sched.h | 2 --
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e8bee37b78fd..068b2dd5e456 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5900,8 +5900,8 @@ DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
 
 void __init sched_init(void)
 {
-	int i, j;
 	unsigned long alloc_size = 0, ptr;
+	int i;
 
 	wait_bit_init();
 
@@ -6003,10 +6003,6 @@ void __init sched_init(void)
 #ifdef CONFIG_RT_GROUP_SCHED
 		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
 #endif
-
-		for (j = 0; j < CPU_LOAD_IDX_MAX; j++)
-			rq->cpu_load[j] = 0;
-
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
 		rq->rd = NULL;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index b070fb61caca..c2eeaa44b274 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -656,11 +656,6 @@ do {									\
 	SEQ_printf(m, "  .%-30s: %ld\n", "curr->pid", (long)(task_pid_nr(rq->curr)));
 	PN(clock);
 	PN(clock_task);
-	P(cpu_load[0]);
-	P(cpu_load[1]);
-	P(cpu_load[2]);
-	P(cpu_load[3]);
-	P(cpu_load[4]);
 #undef P
 #undef PN
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a83827eec1d1..e43c29920fa8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -812,8 +812,6 @@ struct rq {
 	unsigned int		nr_preferred_running;
 	unsigned int		numa_migrate_on;
 #endif
-	#define CPU_LOAD_IDX_MAX 5
-	unsigned long		cpu_load[CPU_LOAD_IDX_MAX];
 #ifdef CONFIG_NO_HZ_COMMON
 #ifdef CONFIG_SMP
 	unsigned long		last_load_update_tick;
-- 
2.17.1

