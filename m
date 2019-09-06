Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFFDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E284F21670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405304AbfIFTOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:14:55 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38128 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406259AbfIFTOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:14:08 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i6Jey-0003p8-Ns; Fri, 06 Sep 2019 15:12:40 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 12/15] sched,fair: propagate sum_exec_runtime up the hierarchy
Date:   Fri,  6 Sep 2019 15:12:34 -0400
Message-Id: <20190906191237.27006-13-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906191237.27006-1-riel@surriel.com>
References: <20190906191237.27006-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that enqueue_task_fair and dequeue_task_fair no longer iterate up
the hierarchy all the time, a method to lazily propagate sum_exec_runtime
up the hierarchy is necessary.

Once a tick, propagate the newly accumulated exec_runtime up the hierarchy,
and feed it into CFS bandwidth control.

Remove the pointless call to account_cfs_rq_runtime from update_curr,
which is always called with a root cfs_rq.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   |  1 +
 kernel/sched/fair.c   | 22 ++++++++++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 901c710363e7..bdca15b3afe7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -454,6 +454,7 @@ struct sched_entity {
 	int				depth;
 	unsigned long			enqueued_h_load;
 	unsigned long			enqueued_h_weight;
+	u64				propagated_exec_runtime;
 	struct load_weight		h_load;
 	struct sched_entity		*parent;
 	/* rq on which this entity is (to be) queued: */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fbd96900f715..9915d20e84a9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2137,6 +2137,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	INIT_LIST_HEAD(&p->se.group_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+	p->se.propagated_exec_runtime	= 0;
 	p->se.cfs_rq			= NULL;
 #endif
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5dc6d70e0df1..84481c9ca51d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -916,8 +916,6 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
 	cgroup_account_cputime(curtask, delta_exec);
 	account_group_exec_runtime(curtask, delta_exec);
-
-	account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
 
 static void update_curr_fair(struct rq *rq)
@@ -3430,6 +3428,20 @@ static inline bool skip_blocked_update(struct sched_entity *se)
 	return true;
 }
 
+static void propagate_exec_runtime(struct cfs_rq *cfs_rq,
+				struct sched_entity *se)
+{
+	struct sched_entity *parent = se->parent;
+	u64 diff = se->sum_exec_runtime - se->propagated_exec_runtime;
+
+	if (parent) {
+		parent->sum_exec_runtime += diff;
+		account_cfs_rq_runtime(cfs_rq, diff);
+	}
+
+	se->propagated_exec_runtime = se->sum_exec_runtime;
+}
+
 #else /* CONFIG_FAIR_GROUP_SCHED */
 
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force) {}
@@ -3441,6 +3453,11 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum) {}
 
+static void propagate_exec_runtime(struct cfs_rq *cfs_rq,
+				struct sched_entity *se);
+{
+}
+
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 /**
@@ -10175,6 +10192,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se, int flags)
 			if (!(flags & DO_ATTACH))
 				break;
 
+		propagate_exec_runtime(cfs_rq, se);
 		update_cfs_group(se);
 	}
 }
-- 
2.20.1

