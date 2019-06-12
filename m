Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77659C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CDD20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfFLTcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:32:50 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50440 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfFLTcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:32:48 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hb8z2-0001BN-0R; Wed, 12 Jun 2019 15:32:32 -0400
From:   Rik van Riel <riel@surriel.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 5/8] sched,cfs: use explicit cfs_rq of parent se helper
Date:   Wed, 12 Jun 2019 15:32:24 -0400
Message-Id: <20190612193227.993-6-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190612193227.993-1-riel@surriel.com>
References: <20190612193227.993-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an explicit "cfs_rq of parent sched_entity" helper in a few
strategic places, where cfs_rq_of(se) may no longer point at the
right runqueue once we flatten the hierarchical cgroup runqueues.

No functional change.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dcc521d251e3..c6ede2ecc935 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -275,6 +275,15 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return grp->my_q;
 }
 
+/* runqueue owned by the parent entity */
+static inline struct cfs_rq *group_cfs_rq_of_parent(struct sched_entity *se)
+{
+	if (se->parent)
+		return group_cfs_rq(se->parent);
+
+	return &cfs_rq_of(se)->rq->cfs;
+}
+
 static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
@@ -3298,7 +3307,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 
 	gcfs_rq->propagate = 0;
 
-	cfs_rq = cfs_rq_of(se);
+	cfs_rq = group_cfs_rq_of_parent(se);
 
 	add_tg_cfs_propagate(cfs_rq, gcfs_rq->prop_runnable_sum);
 
@@ -7779,7 +7788,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 
 	WRITE_ONCE(cfs_rq->h_load_next, NULL);
 	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
+		cfs_rq = group_cfs_rq_of_parent(se);
 		WRITE_ONCE(cfs_rq->h_load_next, se);
 		if (cfs_rq->last_h_load_update == now)
 			break;
@@ -7802,7 +7811,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 
 static unsigned long task_se_h_load(struct sched_entity *se)
 {
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	struct cfs_rq *cfs_rq = group_cfs_rq_of_parent(se);
 
 	update_cfs_rq_h_load(cfs_rq);
 	return div64_ul(se->avg.load_avg * cfs_rq->h_load,
@@ -10159,7 +10168,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	struct sched_entity *se = &curr->se;
 
 	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
+		cfs_rq = group_cfs_rq_of_parent(se);
 		entity_tick(cfs_rq, se, queued);
 	}
 
-- 
2.20.1

