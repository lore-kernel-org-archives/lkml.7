Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79700C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FB521670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406347AbfIFTOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:14:42 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38132 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406260AbfIFTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:14:09 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i6Jey-0003p8-Gj; Fri, 06 Sep 2019 15:12:40 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 08/15] sched,fair: refactor enqueue/dequeue_entity
Date:   Fri,  6 Sep 2019 15:12:30 -0400
Message-Id: <20190906191237.27006-9-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906191237.27006-1-riel@surriel.com>
References: <20190906191237.27006-1-riel@surriel.com>
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
 kernel/sched/fair.c | 64 +++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 00d774833df5..3e294e9c9994 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3518,7 +3518,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 #define DO_ATTACH	0x4
 
 /* Update task and its cfs_rq load average */
-static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 now = cfs_rq_clock_pelt(cfs_rq);
 	int decayed;
@@ -3547,6 +3547,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	} else if (decayed && (flags & UPDATE_TG))
 		update_tg_load_avg(cfs_rq, 0);
+
+	return decayed;
 }
 
 #ifndef CONFIG_64BIT
@@ -3763,9 +3765,10 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 #define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
 
-static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
+static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
 	cfs_rq_util_change(cfs_rq, 0);
+	return false;
 }
 
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
@@ -3888,6 +3891,24 @@ static inline void check_schedstat_required(void)
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
@@ -3912,16 +3933,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
 
@@ -3988,14 +3999,9 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
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
@@ -4004,7 +4010,21 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
@@ -4028,8 +4048,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/* return excess runtime on last dequeue */
 	return_cfs_rq_runtime(cfs_rq);
 
-	update_cfs_group(se);
-
 	/*
 	 * Now advance min_vruntime if @se was the entity holding it back,
 	 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
@@ -5194,6 +5212,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (se->on_rq)
 			break;
 		cfs_rq = cfs_rq_of(se);
+		enqueue_entity_groups(cfs_rq, se, flags);
 		enqueue_entity(cfs_rq, se, flags);
 
 		/*
@@ -5276,6 +5295,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
+		dequeue_entity_groups(cfs_rq, se, flags);
 		dequeue_entity(cfs_rq, se, flags);
 
 		/*
-- 
2.20.1

