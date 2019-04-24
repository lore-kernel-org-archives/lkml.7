Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AECCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF86218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfDXIqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:46:14 -0400
Received: from foss.arm.com ([217.140.101.70]:39804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbfDXIqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:46:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD86680D;
        Wed, 24 Apr 2019 01:46:13 -0700 (PDT)
Received: from e107985-lin.cambridge.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB7523F5AF;
        Wed, 24 Apr 2019 01:46:12 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Remove rq->load
Date:   Wed, 24 Apr 2019 09:45:56 +0100
Message-Id: <20190424084556.604-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CFS class is the only one maintaining and using the CPU wide load
(rq->load(.weight)). The last use case of the CPU wide load in CFS's
set_next_entity() can be replaced by using the load of the CFS class
(rq->cfs.load(.weight)) instead.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/debug.c | 2 --
 kernel/sched/fair.c  | 7 ++-----
 kernel/sched/sched.h | 2 --
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8039d62ae36e..1148f43dbd42 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -656,8 +656,6 @@ do {									\
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", #x, SPLIT_NS(rq->x))
 
 	P(nr_running);
-	SEQ_printf(m, "  .%-30s: %lu\n", "load",
-		   rq->load.weight);
 	P(nr_switches);
 	P(nr_load_updates);
 	P(nr_uninterruptible);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a4d9e14bf138..73a6718f29cc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2682,8 +2682,6 @@ static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	update_load_add(&cfs_rq->load, se->load.weight);
-	if (!parent_entity(se))
-		update_load_add(&rq_of(cfs_rq)->load, se->load.weight);
 #ifdef CONFIG_SMP
 	if (entity_is_task(se)) {
 		struct rq *rq = rq_of(cfs_rq);
@@ -2699,8 +2697,6 @@ static void
 account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	update_load_sub(&cfs_rq->load, se->load.weight);
-	if (!parent_entity(se))
-		update_load_sub(&rq_of(cfs_rq)->load, se->load.weight);
 #ifdef CONFIG_SMP
 	if (entity_is_task(se)) {
 		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
@@ -4096,7 +4092,8 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 * least twice that of our own weight (i.e. dont track it
 	 * when there are only lesser-weight tasks around):
 	 */
-	if (schedstat_enabled() && rq_of(cfs_rq)->load.weight >= 2*se->load.weight) {
+	if (schedstat_enabled() &&
+	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
 		schedstat_set(se->statistics.slice_max,
 			max((u64)schedstat_val(se->statistics.slice_max),
 			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index efa686eeff26..e4059e81e99c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -830,8 +830,6 @@ struct rq {
 	atomic_t nohz_flags;
 #endif /* CONFIG_NO_HZ_COMMON */
 
-	/* capture load from *all* tasks on this CPU: */
-	struct load_weight	load;
 	unsigned long		nr_load_updates;
 	u64			nr_switches;
 
-- 
2.17.1

