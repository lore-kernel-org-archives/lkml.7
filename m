Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FAEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C4D2173B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405254AbfIFTPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:15:12 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38300 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406267AbfIFTOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:14:08 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i6Jey-0003p8-Ch; Fri, 06 Sep 2019 15:12:40 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 05/15] sched,fair: remove cfs_rqs from leaf_cfs_rq_list bottom up
Date:   Fri,  6 Sep 2019 15:12:27 -0400
Message-Id: <20190906191237.27006-6-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906191237.27006-1-riel@surriel.com>
References: <20190906191237.27006-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reducing the overhead of the CPU controller is achieved by not walking
all the sched_entities every time a task is enqueued or dequeued.

One of the things being checked every single time is whether the cfs_rq
is on the rq->leaf_cfs_rq_list.

By only removing a cfs_rq from the list once it no longer has children
on the list, we can avoid walking the sched_entity hierarchy if the bottom
cfs_rq is on the list, once the runqueues have been flattened.

Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index af9458d8828f..1c1593611291 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -369,6 +369,39 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
 }
 
+/*
+ * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
+ * immediately before a parent cfs_rq, and cfs_rqs are removed from the list
+ * bottom-up, we only have to test whether the cfs_rq before us on the list
+ * is our child.
+ */
+static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
+{
+	struct cfs_rq *prev_cfs_rq;
+	struct list_head *prev;
+
+	prev = cfs_rq->leaf_cfs_rq_list.prev;
+	prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
+
+	return (prev_cfs_rq->tg->parent == cfs_rq->tg);
+}
+
+/*
+ * Remove a cfs_rq from the list if it has no children on the list.
+ * The scheduler iterates over the list regularly; if conditions for
+ * removal are still true, we'll get to this cfs_rq in the future.
+ */
+static inline void list_del_leaf_cfs_rq_bottom(struct cfs_rq *cfs_rq)
+{
+	if (!cfs_rq->on_list)
+		return;
+
+	if (child_cfs_rq_on_list(cfs_rq))
+		return;
+
+	list_del_leaf_cfs_rq(cfs_rq);
+}
+
 /* Iterate thr' all leaf cfs_rq's on a runqueue */
 #define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
 	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
@@ -7723,7 +7756,7 @@ static void update_blocked_averages(int cpu)
 		 * decayed cfs_rqs linger on the list.
 		 */
 		if (cfs_rq_is_decayed(cfs_rq))
-			list_del_leaf_cfs_rq(cfs_rq);
+			list_del_leaf_cfs_rq_bottom(cfs_rq);
 
 		/* Don't need periodic decay once load/util_avg are null */
 		if (cfs_rq_has_blocked(cfs_rq))
-- 
2.20.1

