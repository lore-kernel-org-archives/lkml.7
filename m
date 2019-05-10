Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F66C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA9C20850
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfEJLci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:32:38 -0400
Received: from foss.arm.com ([217.140.101.70]:44506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfEJLch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:32:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C8C015BF;
        Fri, 10 May 2019 04:32:36 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B00E3F6C4;
        Fri, 10 May 2019 04:32:34 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 2/7] sched: fair: move helper functions into fair.h
Date:   Fri, 10 May 2019 12:30:08 +0100
Message-Id: <20190510113013.1193-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510113013.1193-1-qais.yousef@arm.com>
References: <20190510113013.1193-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the small cfs rq helper functions that are inlined into fair.h
header.

In later patches we need a couple of functions and it made more sense to
move the majority of the functions into their own header rather than the
two needed only. This keeps the functions grouped together in the same
file.

Always include the new header in sched.h to make them accessible to all
sched subsystem files like autogroup.h

find_match_se() was excluded because it wasn't inlined.

The two required functions are:

	- cfs_rq_of()
	- group_rq_of()

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/fair.c  | 195 -----------------------------------------
 kernel/sched/fair.h  | 201 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |   1 +
 3 files changed, 202 insertions(+), 195 deletions(-)
 create mode 100644 kernel/sched/fair.h

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 35f3ea375084..2b4963bbeab4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -243,151 +243,7 @@ static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight
 
 const struct sched_class fair_sched_class;
 
-/**************************************************************
- * CFS operations on generic schedulable entities:
- */
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	SCHED_WARN_ON(!entity_is_task(se));
-	return container_of(se, struct task_struct, se);
-}
-
-/* Walk up scheduling entities hierarchy */
-#define for_each_sched_entity(se) \
-		for (; se; se = se->parent)
-
-static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
-{
-	return p->se.cfs_rq;
-}
-
-/* runqueue on which this entity is (to be) queued */
-static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
-{
-	return se->cfs_rq;
-}
-
-/* runqueue "owned" by this group */
-static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
-{
-	return grp->my_q;
-}
-
-static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
-{
-	struct rq *rq = rq_of(cfs_rq);
-	int cpu = cpu_of(rq);
-
-	if (cfs_rq->on_list)
-		return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;
-
-	cfs_rq->on_list = 1;
-
-	/*
-	 * Ensure we either appear before our parent (if already
-	 * enqueued) or force our parent to appear after us when it is
-	 * enqueued. The fact that we always enqueue bottom-up
-	 * reduces this to two cases and a special case for the root
-	 * cfs_rq. Furthermore, it also means that we will always reset
-	 * tmp_alone_branch either when the branch is connected
-	 * to a tree or when we reach the top of the tree
-	 */
-	if (cfs_rq->tg->parent &&
-	    cfs_rq->tg->parent->cfs_rq[cpu]->on_list) {
-		/*
-		 * If parent is already on the list, we add the child
-		 * just before. Thanks to circular linked property of
-		 * the list, this means to put the child at the tail
-		 * of the list that starts by parent.
-		 */
-		list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
-			&(cfs_rq->tg->parent->cfs_rq[cpu]->leaf_cfs_rq_list));
-		/*
-		 * The branch is now connected to its tree so we can
-		 * reset tmp_alone_branch to the beginning of the
-		 * list.
-		 */
-		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
-		return true;
-	}
-
-	if (!cfs_rq->tg->parent) {
-		/*
-		 * cfs rq without parent should be put
-		 * at the tail of the list.
-		 */
-		list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
-			&rq->leaf_cfs_rq_list);
-		/*
-		 * We have reach the top of a tree so we can reset
-		 * tmp_alone_branch to the beginning of the list.
-		 */
-		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
-		return true;
-	}
-
-	/*
-	 * The parent has not already been added so we want to
-	 * make sure that it will be put after us.
-	 * tmp_alone_branch points to the begin of the branch
-	 * where we will add parent.
-	 */
-	list_add_rcu(&cfs_rq->leaf_cfs_rq_list, rq->tmp_alone_branch);
-	/*
-	 * update tmp_alone_branch to points to the new begin
-	 * of the branch
-	 */
-	rq->tmp_alone_branch = &cfs_rq->leaf_cfs_rq_list;
-	return false;
-}
-
-static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
-{
-	if (cfs_rq->on_list) {
-		struct rq *rq = rq_of(cfs_rq);
-
-		/*
-		 * With cfs_rq being unthrottled/throttled during an enqueue,
-		 * it can happen the tmp_alone_branch points the a leaf that
-		 * we finally want to del. In this case, tmp_alone_branch moves
-		 * to the prev element but it will point to rq->leaf_cfs_rq_list
-		 * at the end of the enqueue.
-		 */
-		if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
-			rq->tmp_alone_branch = cfs_rq->leaf_cfs_rq_list.prev;
-
-		list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
-		cfs_rq->on_list = 0;
-	}
-}
-
-static inline void assert_list_leaf_cfs_rq(struct rq *rq)
-{
-	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
-}
-
-/* Iterate thr' all leaf cfs_rq's on a runqueue */
-#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
-	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
-				 leaf_cfs_rq_list)
-
-/* Do the two (enqueued) entities belong to the same group ? */
-static inline struct cfs_rq *
-is_same_group(struct sched_entity *se, struct sched_entity *pse)
-{
-	if (se->cfs_rq == pse->cfs_rq)
-		return se->cfs_rq;
-
-	return NULL;
-}
-
-static inline struct sched_entity *parent_entity(struct sched_entity *se)
-{
-	return se->parent;
-}
-
 static void
 find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 {
@@ -419,62 +275,11 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 		*pse = parent_entity(*pse);
 	}
 }
-
 #else	/* !CONFIG_FAIR_GROUP_SCHED */
-
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	return container_of(se, struct task_struct, se);
-}
-
-#define for_each_sched_entity(se) \
-		for (; se; se = NULL)
-
-static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
-{
-	return &task_rq(p)->cfs;
-}
-
-static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
-{
-	struct task_struct *p = task_of(se);
-	struct rq *rq = task_rq(p);
-
-	return &rq->cfs;
-}
-
-/* runqueue "owned" by this group */
-static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
-{
-	return NULL;
-}
-
-static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
-{
-	return true;
-}
-
-static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
-{
-}
-
-static inline void assert_list_leaf_cfs_rq(struct rq *rq)
-{
-}
-
-#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)	\
-		for (cfs_rq = &rq->cfs, pos = NULL; cfs_rq; cfs_rq = pos)
-
-static inline struct sched_entity *parent_entity(struct sched_entity *se)
-{
-	return NULL;
-}
-
 static inline void
 find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 {
 }
-
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
 
 static __always_inline
diff --git a/kernel/sched/fair.h b/kernel/sched/fair.h
new file mode 100644
index 000000000000..2e5aefaf56de
--- /dev/null
+++ b/kernel/sched/fair.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * CFS operations on generic schedulable entities:
+ */
+#ifndef __SCHED_FAIR_H
+#define __SCHED_FAIR_H
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+static inline struct task_struct *task_of(struct sched_entity *se)
+{
+	SCHED_WARN_ON(!entity_is_task(se));
+	return container_of(se, struct task_struct, se);
+}
+
+/* Walk up scheduling entities hierarchy */
+#define for_each_sched_entity(se) \
+		for (; se; se = se->parent)
+
+static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
+{
+	return p->se.cfs_rq;
+}
+
+/* runqueue on which this entity is (to be) queued */
+static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
+{
+	return se->cfs_rq;
+}
+
+/* runqueue "owned" by this group */
+static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
+{
+	return grp->my_q;
+}
+
+static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	struct rq *rq = rq_of(cfs_rq);
+	int cpu = cpu_of(rq);
+
+	if (cfs_rq->on_list)
+		return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;
+
+	cfs_rq->on_list = 1;
+
+	/*
+	 * Ensure we either appear before our parent (if already
+	 * enqueued) or force our parent to appear after us when it is
+	 * enqueued. The fact that we always enqueue bottom-up
+	 * reduces this to two cases and a special case for the root
+	 * cfs_rq. Furthermore, it also means that we will always reset
+	 * tmp_alone_branch either when the branch is connected
+	 * to a tree or when we reach the top of the tree
+	 */
+	if (cfs_rq->tg->parent &&
+	    cfs_rq->tg->parent->cfs_rq[cpu]->on_list) {
+		/*
+		 * If parent is already on the list, we add the child
+		 * just before. Thanks to circular linked property of
+		 * the list, this means to put the child at the tail
+		 * of the list that starts by parent.
+		 */
+		list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
+			&(cfs_rq->tg->parent->cfs_rq[cpu]->leaf_cfs_rq_list));
+		/*
+		 * The branch is now connected to its tree so we can
+		 * reset tmp_alone_branch to the beginning of the
+		 * list.
+		 */
+		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
+		return true;
+	}
+
+	if (!cfs_rq->tg->parent) {
+		/*
+		 * cfs rq without parent should be put
+		 * at the tail of the list.
+		 */
+		list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
+			&rq->leaf_cfs_rq_list);
+		/*
+		 * We have reach the top of a tree so we can reset
+		 * tmp_alone_branch to the beginning of the list.
+		 */
+		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
+		return true;
+	}
+
+	/*
+	 * The parent has not already been added so we want to
+	 * make sure that it will be put after us.
+	 * tmp_alone_branch points to the begin of the branch
+	 * where we will add parent.
+	 */
+	list_add_rcu(&cfs_rq->leaf_cfs_rq_list, rq->tmp_alone_branch);
+	/*
+	 * update tmp_alone_branch to points to the new begin
+	 * of the branch
+	 */
+	rq->tmp_alone_branch = &cfs_rq->leaf_cfs_rq_list;
+	return false;
+}
+
+static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	if (cfs_rq->on_list) {
+		struct rq *rq = rq_of(cfs_rq);
+
+		/*
+		 * With cfs_rq being unthrottled/throttled during an enqueue,
+		 * it can happen the tmp_alone_branch points the a leaf that
+		 * we finally want to del. In this case, tmp_alone_branch moves
+		 * to the prev element but it will point to rq->leaf_cfs_rq_list
+		 * at the end of the enqueue.
+		 */
+		if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
+			rq->tmp_alone_branch = cfs_rq->leaf_cfs_rq_list.prev;
+
+		list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
+		cfs_rq->on_list = 0;
+	}
+}
+
+static inline void assert_list_leaf_cfs_rq(struct rq *rq)
+{
+	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
+}
+
+/* Iterate thr' all leaf cfs_rq's on a runqueue */
+#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
+	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
+				 leaf_cfs_rq_list)
+
+/* Do the two (enqueued) entities belong to the same group ? */
+static inline struct cfs_rq *
+is_same_group(struct sched_entity *se, struct sched_entity *pse)
+{
+	if (se->cfs_rq == pse->cfs_rq)
+		return se->cfs_rq;
+
+	return NULL;
+}
+
+static inline struct sched_entity *parent_entity(struct sched_entity *se)
+{
+	return se->parent;
+}
+
+#else	/* !CONFIG_FAIR_GROUP_SCHED */
+
+static inline struct task_struct *task_of(struct sched_entity *se)
+{
+	return container_of(se, struct task_struct, se);
+}
+
+#define for_each_sched_entity(se) \
+		for (; se; se = NULL)
+
+static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
+{
+	return &task_rq(p)->cfs;
+}
+
+static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
+{
+	struct task_struct *p = task_of(se);
+	struct rq *rq = task_rq(p);
+
+	return &rq->cfs;
+}
+
+/* runqueue "owned" by this group */
+static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
+{
+	return NULL;
+}
+
+static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return true;
+}
+
+static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
+{
+}
+
+static inline void assert_list_leaf_cfs_rq(struct rq *rq)
+{
+}
+
+#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)	\
+		for (cfs_rq = &rq->cfs, pos = NULL; cfs_rq; cfs_rq = pos)
+
+static inline struct sched_entity *parent_entity(struct sched_entity *se)
+{
+	return NULL;
+}
+
+#endif	/* CONFIG_FAIR_GROUP_SCHED */
+
+#endif /* __SCHED_FAIR_H */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index efa686eeff26..509c1dba77fc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1418,6 +1418,7 @@ static inline void sched_ttwu_pending(void) { }
 
 #include "stats.h"
 #include "autogroup.h"
+#include "fair.h"
 
 #ifdef CONFIG_CGROUP_SCHED
 
-- 
2.17.1

