Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FFBC43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553E72070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406319AbfIFTO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:14:27 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38282 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406269AbfIFTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:14:09 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i6Jey-0003p8-RC; Fri, 06 Sep 2019 15:12:40 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 15/15] sched,fair: remove se->depth
Date:   Fri,  6 Sep 2019 15:12:37 -0400
Message-Id: <20190906191237.27006-16-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906191237.27006-1-riel@surriel.com>
References: <20190906191237.27006-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove se->depth and the code that touches it, since we no longer need
any of that.

Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/sched.h |  1 -
 kernel/sched/fair.c   | 50 ++-----------------------------------------
 2 files changed, 2 insertions(+), 49 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index bdca15b3afe7..94aec4065fd1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -451,7 +451,6 @@ struct sched_entity {
 	struct sched_statistics		statistics;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	int				depth;
 	unsigned long			enqueued_h_load;
 	unsigned long			enqueued_h_weight;
 	u64				propagated_exec_runtime;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3c25ab666799..0fb3de853d45 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -438,38 +438,6 @@ static inline bool task_se_in_cgroup(struct sched_entity *se)
 	return parent_entity(se);
 }
 
-static void
-find_matching_se(struct sched_entity **se, struct sched_entity **pse)
-{
-	int se_depth, pse_depth;
-
-	/*
-	 * preemption test can be made between sibling entities who are in the
-	 * same cfs_rq i.e who have a common parent. Walk up the hierarchy of
-	 * both tasks until we find their ancestors who are siblings of common
-	 * parent.
-	 */
-
-	/* First walk up until both entities are at same depth */
-	se_depth = (*se)->depth;
-	pse_depth = (*pse)->depth;
-
-	while (se_depth > pse_depth) {
-		se_depth--;
-		*se = parent_entity(*se);
-	}
-
-	while (pse_depth > se_depth) {
-		pse_depth--;
-		*pse = parent_entity(*pse);
-	}
-
-	while (!is_same_group(*se, *pse)) {
-		*se = parent_entity(*se);
-		*pse = parent_entity(*pse);
-	}
-}
-
 /* Add the cgroup cfs_rqs to the list, for update_blocked_averages */
 static void enqueue_entity_cfs_rqs(struct sched_entity *se)
 {
@@ -10221,14 +10189,6 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
 	int flags = sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD;
 	struct cfs_rq *cfs_rq = group_cfs_rq_of_parent(se);
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
-	/*
-	 * Since the real-depth could have been changed (only FAIR
-	 * class maintain depth value), reset depth properly.
-	 */
-	se->depth = se->parent ? se->parent->depth + 1 : 0;
-#endif
-
 	/* Synchronize entity with its cfs_rq */
 	update_load_avg(cfs_rq, se, flags);
 	attach_entity_load_avg(cfs_rq, se, 0);
@@ -10316,10 +10276,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void task_set_group_fair(struct task_struct *p)
 {
-	struct sched_entity *se = &p->se;
-
 	set_task_rq(p, task_cpu(p));
-	se->depth = se->parent ? se->parent->depth + 1 : 0;
 }
 
 static void task_move_group_fair(struct task_struct *p)
@@ -10465,13 +10422,10 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	if (!se)
 		return;
 
-	if (!parent) {
+	if (!parent)
 		se->cfs_rq = &rq->cfs;
-		se->depth = 0;
-	} else {
+	else
 		se->cfs_rq = parent->my_q;
-		se->depth = parent->depth + 1;
-	}
 
 	se->my_q = cfs_rq;
 	/* guarantee group entities always have weight */
-- 
2.20.1

