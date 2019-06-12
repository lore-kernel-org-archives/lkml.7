Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F59C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F38B20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfFLTdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:33:06 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50474 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbfFLTct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:32:49 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hb8z2-0001BN-2Y; Wed, 12 Jun 2019 15:32:32 -0400
From:   Rik van Riel <riel@surriel.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 7/8] sched,fair: refactor enqueue/dequeue_entity
Date:   Wed, 12 Jun 2019 15:32:26 -0400
Message-Id: <20190612193227.993-8-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190612193227.993-1-riel@surriel.com>
References: <20190612193227.993-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor enqueue_entity, dequeue_entity, and update_load_avg, in order
to split out the things we still want to happen at every level in the
cgroup hierarchy with a flat runqueue from the things we only need to
happen once.

No functional changes.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 65 +++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 35153a89d5c5..c2baf3c8a879 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3481,17 +3481,17 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 #define DO_ATTACH	0x4
 
 /* Update task and its cfs_rq load average */
-static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 now = cfs_rq_clock_pelt(cfs_rq);
-	int decayed;
+	int decayed, updated = 0;
 
 	/*
 	 * Track task load average for carrying it to new CPU after migrated, and
 	 * track group sched_entity load average for task_h_load calc in migration
 	 */
 	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
-		__update_load_avg_se(now, cfs_rq, se);
+		updated = __update_load_avg_se(now, cfs_rq, se);
 
 	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
 	decayed |= propagate_entity_load_avg(se);
@@ -3510,6 +3510,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	} else if (decayed && (flags & UPDATE_TG))
 		update_tg_load_avg(cfs_rq, 0);
+
+	return decayed | updated;
 }
 
 #ifndef CONFIG_64BIT
@@ -3851,6 +3853,24 @@ static inline void check_schedstat_required(void)
  * CPU and an up-to-date min_vruntime on the destination CPU.
  */
 
+static bool
+enqueue_entity_groups(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+{
+	/*
+	 * When enqueuing a sched_entity, we must:
+	 *   - Update loads to have both entity and cfs_rq synced with now.
+	 *   - Add its load to cfs_rq->runnable_avg
+	 *   - For group_entity, update its weight to reflect the new share of
+	 *     its group cfs_rq
+	 *   - Add its new weight to cfs_rq->load.weight
+	 */
+	if (!update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH))
+		return false;
+
+	update_cfs_group(se);
+	return true;
+}
+
 static void
 enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
@@ -3875,16 +3895,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if (renorm && !curr)
 		se->vruntime += cfs_rq->min_vruntime;
 
-	/*
-	 * When enqueuing a sched_entity, we must:
-	 *   - Update loads to have both entity and cfs_rq synced with now.
-	 *   - Add its load to cfs_rq->runnable_avg
-	 *   - For group_entity, update its weight to reflect the new share of
-	 *     its group cfs_rq
-	 *   - Add its new weight to cfs_rq->load.weight
-	 */
-	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
-	update_cfs_group(se);
 	enqueue_runnable_load_avg(cfs_rq, se);
 	account_entity_enqueue(cfs_rq, se);
 
@@ -3951,14 +3961,9 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
-static void
-dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+static bool 
+dequeue_entity_groups(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	/*
-	 * Update run-time statistics of the 'current'.
-	 */
-	update_curr(cfs_rq);
-
 	/*
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
@@ -3967,7 +3972,21 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
-	update_load_avg(cfs_rq, se, UPDATE_TG);
+	if (!update_load_avg(cfs_rq, se, UPDATE_TG))
+		return false;
+	update_cfs_group(se);
+
+	return true;
+}
+
+static void
+dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+{
+	/*
+	 * Update run-time statistics of the 'current'.
+	 */
+	update_curr(cfs_rq);
+
 	dequeue_runnable_load_avg(cfs_rq, se);
 
 	update_stats_dequeue(cfs_rq, se, flags);
@@ -3991,8 +4010,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/* return excess runtime on last dequeue */
 	return_cfs_rq_runtime(cfs_rq);
 
-	update_cfs_group(se);
-
 	/*
 	 * Now advance min_vruntime if @se was the entity holding it back,
 	 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
@@ -5157,6 +5174,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (se->on_rq)
 			break;
 		cfs_rq = cfs_rq_of(se);
+		enqueue_entity_groups(cfs_rq, se, flags);
 		enqueue_entity(cfs_rq, se, flags);
 
 		/*
@@ -5239,6 +5257,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
+		dequeue_entity_groups(cfs_rq, se, flags);
 		dequeue_entity(cfs_rq, se, flags);
 
 		/*
-- 
2.20.1

