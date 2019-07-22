Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632EAC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C6721903
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfGVReo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:34:44 -0400
Received: from shelob.surriel.com ([96.67.55.147]:37892 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbfGVReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:34:24 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hpcC8-0003HL-7G; Mon, 22 Jul 2019 13:33:52 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 06/14] sched,cfs: use explicit cfs_rq of parent se helper
Date:   Mon, 22 Jul 2019 13:33:40 -0400
Message-Id: <20190722173348.9241-7-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722173348.9241-1-riel@surriel.com>
References: <20190722173348.9241-1-riel@surriel.com>
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
index d6a8aa78a948..39f7a2d810e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -276,6 +276,15 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return grp->my_q;
 }
 
+/* runqueue owned by the parent entity; the root cfs_rq for a top level se */
+static inline struct cfs_rq *group_cfs_rq_of_parent(struct sched_entity *se)
+{
+	if (se->parent)
+		return group_cfs_rq(se->parent);
+
+	return cfs_rq_of(se);
+}
+
 static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
@@ -3317,7 +3326,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 
 	gcfs_rq->propagate = 0;
 
-	cfs_rq = cfs_rq_of(se);
+	cfs_rq = group_cfs_rq_of_parent(se);
 
 	add_tg_cfs_propagate(cfs_rq, gcfs_rq->prop_runnable_sum);
 
@@ -7794,7 +7803,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 
 	WRITE_ONCE(cfs_rq->h_load_next, NULL);
 	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
+		cfs_rq = group_cfs_rq_of_parent(se);
 		WRITE_ONCE(cfs_rq->h_load_next, se);
 		if (cfs_rq->last_h_load_update == now)
 			break;
@@ -7817,7 +7826,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 
 static unsigned long task_se_h_load(struct sched_entity *se)
 {
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	struct cfs_rq *cfs_rq = group_cfs_rq_of_parent(se);
 
 	update_cfs_rq_h_load(cfs_rq);
 	return div64_ul(se->avg.load_avg * cfs_rq->h_load,
@@ -10164,7 +10173,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	struct sched_entity *se = &curr->se;
 
 	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
+		cfs_rq = group_cfs_rq_of_parent(se);
 		entity_tick(cfs_rq, se, queued);
 	}
 
-- 
2.20.1

