Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CC2C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B9A2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfF1Uth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:49:37 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38476 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfF1Utf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:49:35 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hgxo6-0007TL-KI; Fri, 28 Jun 2019 16:49:18 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 05/10] sched,fair: remove cfs rqs from leaf_cfs_rq_list bottom up
Date:   Fri, 28 Jun 2019 16:49:08 -0400
Message-Id: <20190628204913.10287-6-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628204913.10287-1-riel@surriel.com>
References: <20190628204913.10287-1-riel@surriel.com>
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
---
 kernel/sched/fair.c  | 17 +++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 63cb40253b26..e41feacc45d9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -286,6 +286,13 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 
 	cfs_rq->on_list = 1;
 
+	/*
+	 * If the tmp_alone_branch cursor was moved, it means a child cfs_rq
+	 * is already on the list ahead of us.
+	 */
+	if (rq->tmp_alone_branch != &rq->leaf_cfs_rq_list)
+		cfs_rq->children_on_list++;
+
 	/*
 	 * Ensure we either appear before our parent (if already
 	 * enqueued) or force our parent to appear after us when it is
@@ -311,6 +318,7 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 		 * list.
 		 */
 		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
+		cfs_rq->tg->parent->cfs_rq[cpu]->children_on_list++;
 		return true;
 	}
 
@@ -359,6 +367,11 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 		if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
 			rq->tmp_alone_branch = cfs_rq->leaf_cfs_rq_list.prev;
 
+		if (cfs_rq->tg->parent) {
+			int cpu = cpu_of(rq);
+			cfs_rq->tg->parent->cfs_rq[cpu]->children_on_list--;
+		}
+
 		list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
 		cfs_rq->on_list = 0;
 	}
@@ -7687,6 +7700,10 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.util_sum)
 		return false;
 
+	/* Remove decayed parents once their decayed children are gone. */
+	if (cfs_rq->children_on_list)
+		return false;
+
 	return true;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 32978a8de8ce..4f8acbab0fb2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -557,6 +557,7 @@ struct cfs_rq {
 	 * This list is used during load balance.
 	 */
 	int			on_list;
+	int			children_on_list;
 	struct list_head	leaf_cfs_rq_list;
 	struct task_group	*tg;	/* group that "owns" this runqueue */
 
-- 
2.20.1

