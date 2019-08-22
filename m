Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C63CC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C761216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbfHVCSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:18:45 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34016 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfHVCSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:18:13 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i0cfX-0001S6-GY; Wed, 21 Aug 2019 22:17:43 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 12/15] sched,fair: flatten update_curr functionality
Date:   Wed, 21 Aug 2019 22:17:37 -0400
Message-Id: <20190822021740.15554-13-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822021740.15554-1-riel@surriel.com>
References: <20190822021740.15554-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it clear that update_curr only works on tasks any more.

There is no need for task_tick_fair to call it on every sched entity up
the hierarchy, so move the call out of entity_tick.

Signed-off-by: Rik van Riel <riel@surriel.com>`
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fa8e88731821..5cfa3dbeba49 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -872,10 +872,11 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
 static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
+	struct task_struct *curtask;
 	u64 now = rq_clock_task(rq_of(cfs_rq));
 	u64 delta_exec;
 
-	if (unlikely(!curr))
+	if (unlikely(!curr) || !entity_is_task(curr))
 		return;
 
 	delta_exec = now - curr->exec_start;
@@ -893,13 +894,10 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	update_min_vruntime(cfs_rq);
 
-	if (entity_is_task(curr)) {
-		struct task_struct *curtask = task_of(curr);
-
-		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
-		cgroup_account_cputime(curtask, delta_exec);
-		account_group_exec_runtime(curtask, delta_exec);
-	}
+	curtask = task_of(curr);
+	trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
+	cgroup_account_cputime(curtask, delta_exec);
+	account_group_exec_runtime(curtask, delta_exec);
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
@@ -4196,11 +4194,6 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 static void
 entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 {
-	/*
-	 * Update run-time statistics of the 'current'.
-	 */
-	update_curr(cfs_rq);
-
 	/*
 	 * Ensure that runnable average is periodically updated.
 	 */
@@ -10032,6 +10025,11 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &curr->se;
 
+	/*
+	 * Update run-time statistics of the 'current'.
+	 */
+	update_curr(&rq->cfs);
+
 	for_each_sched_entity(se) {
 		cfs_rq = group_cfs_rq_of_parent(se);
 		entity_tick(cfs_rq, se, queued);
-- 
2.20.1

