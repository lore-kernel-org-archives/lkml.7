Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A7BC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859D121901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbfGYObi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:31:38 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45767 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbfGYObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:31:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0TXmj5u6_1564065087;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TXmj5u6_1564065087)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Jul 2019 22:31:29 +0800
Date:   Thu, 25 Jul 2019 22:31:27 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 1/3] wrapper for cfs_rq->min_vruntime
Message-ID: <20190725143127.GB992@aaronlu>
References: <20190531210816.GA24027@sinkpad>
 <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad>
 <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725143003.GA992@aaronlu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper function cfs_rq_min_vruntime(cfs_rq) to
return cfs_rq->min_vruntime.

It will be used in the following patch, no functionality
change.

Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
---
 kernel/sched/fair.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 26d29126d6a5..a7b26c96f46b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -431,6 +431,11 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
 
+static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->min_vruntime;
+}
+
 static __always_inline
 void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
 
@@ -467,7 +472,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	struct sched_entity *curr = cfs_rq->curr;
 	struct rb_node *leftmost = rb_first_cached(&cfs_rq->tasks_timeline);
 
-	u64 vruntime = cfs_rq->min_vruntime;
+	u64 vruntime = cfs_rq_min_vruntime(cfs_rq);
 
 	if (curr) {
 		if (curr->on_rq)
@@ -487,7 +492,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	}
 
 	/* ensure we never gain time by being placed backwards. */
-	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);
+	cfs_rq->min_vruntime = max_vruntime(cfs_rq_min_vruntime(cfs_rq), vruntime);
 #ifndef CONFIG_64BIT
 	smp_wmb();
 	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
@@ -3742,7 +3747,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 #ifdef CONFIG_SCHED_DEBUG
-	s64 d = se->vruntime - cfs_rq->min_vruntime;
+	s64 d = se->vruntime - cfs_rq_min_vruntime(cfs_rq);
 
 	if (d < 0)
 		d = -d;
@@ -3755,7 +3760,7 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
-	u64 vruntime = cfs_rq->min_vruntime;
+	u64 vruntime = cfs_rq_min_vruntime(cfs_rq);
 
 	/*
 	 * The 'current' period is already promised to the current tasks,
@@ -3848,7 +3853,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * update_curr().
 	 */
 	if (renorm && curr)
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 
 	update_curr(cfs_rq);
 
@@ -3859,7 +3864,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * fairness detriment of existing tasks.
 	 */
 	if (renorm && !curr)
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 
 	/*
 	 * When enqueuing a sched_entity, we must:
@@ -3972,7 +3977,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * can move min_vruntime forward still more.
 	 */
 	if (!(flags & DEQUEUE_SLEEP))
-		se->vruntime -= cfs_rq->min_vruntime;
+		se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 
 	/* return excess runtime on last dequeue */
 	return_cfs_rq_runtime(cfs_rq);
@@ -6722,7 +6727,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 			min_vruntime = cfs_rq->min_vruntime;
 		} while (min_vruntime != min_vruntime_copy);
 #else
-		min_vruntime = cfs_rq->min_vruntime;
+		min_vruntime = cfs_rq_min_vruntime(cfs_rq);
 #endif
 
 		se->vruntime -= min_vruntime;
@@ -10215,7 +10220,7 @@ static void task_fork_fair(struct task_struct *p)
 		resched_curr(rq);
 	}
 
-	se->vruntime -= cfs_rq->min_vruntime;
+	se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 	rq_unlock(rq, &rf);
 }
 
@@ -10335,7 +10340,7 @@ static void detach_task_cfs_rq(struct task_struct *p)
 		 * cause 'unlimited' sleep bonus.
 		 */
 		place_entity(cfs_rq, se, 0);
-		se->vruntime -= cfs_rq->min_vruntime;
+		se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 	}
 
 	detach_entity_cfs_rq(se);
@@ -10349,7 +10354,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
 	attach_entity_cfs_rq(se);
 
 	if (!vruntime_normalized(p))
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 }
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
-- 
2.19.1.3.ge56e4f7

