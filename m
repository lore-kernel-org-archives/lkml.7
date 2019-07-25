Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CF6C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5CE21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfGYOdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:33:02 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39961 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387460AbfGYOdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:33:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0TXmkDME_1564065169;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TXmkDME_1564065169)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Jul 2019 22:32:51 +0800
Date:   Thu, 25 Jul 2019 22:32:49 +0800
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
Subject: [PATCH 2/3] core vruntime comparison
Message-ID: <20190725143248.GC992@aaronlu>
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

This patch provides a vruntime based way to compare two cfs task's
priority, be it on the same cpu or different threads of the same core.

When the two tasks are on the same CPU, we just need to find a common
cfs_rq both sched_entities are on and then do the comparison.

When the two tasks are on differen threads of the same core, the root
level sched_entities to which the two tasks belong will be used to do
the comparison.

An ugly illustration for the cross CPU case:

   cpu0         cpu1
 /   |  \     /   |  \
se1 se2 se3  se4 se5 se6
    /  \            /   \
  se21 se22       se61  se62

Assume CPU0 and CPU1 are smt siblings and task A's se is se21 while
task B's se is se61. To compare priority of task A and B, we compare
priority of se2 and se6. Whose vruntime is smaller, who wins.

To make this work, the root level se should have a common cfs_rq min
vuntime, which I call it the core cfs_rq min vruntime.

Potential issues: when core scheduling is enabled, if there are tasks
already in some CPU's rq, then new tasks will be queued with the per-core
cfs_rq min vruntime while the old tasks are using the original root
level cfs_rq's min_vruntime. The two values can differ greatly and can
cause tasks with a large vruntime starve. So enable core scheduling
early when the system is still kind of idle for the time being to avoid
this problem.

Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
---
 kernel/sched/core.c  | 15 ++-------
 kernel/sched/fair.c  | 79 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  2 ++
 3 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90655c9ad937..bc746ea4cc82 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -105,19 +105,8 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
-		u64 vruntime = b->se.vruntime;
-
-		/*
-		 * Normalize the vruntime if tasks are in different cpus.
-		 */
-		if (task_cpu(a) != task_cpu(b)) {
-			vruntime -= task_cfs_rq(b)->min_vruntime;
-			vruntime += task_cfs_rq(a)->min_vruntime;
-		}
-
-		return !((s64)(a->se.vruntime - vruntime) <= 0);
-	}
+	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
+		return cfs_prio_less(a, b);
 
 	return false;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a7b26c96f46b..43babc2a12a5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -431,9 +431,85 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
 
+static inline struct cfs_rq *root_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return &rq_of(cfs_rq)->cfs;
+}
+
+static inline bool is_root_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq == root_cfs_rq(cfs_rq);
+}
+
+static inline struct cfs_rq *core_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return &rq_of(cfs_rq)->core->cfs;
+}
+
 static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
 {
-	return cfs_rq->min_vruntime;
+	if (!sched_core_enabled(rq_of(cfs_rq)))
+		return cfs_rq->min_vruntime;
+
+	if (is_root_cfs_rq(cfs_rq))
+		return core_cfs_rq(cfs_rq)->min_vruntime;
+	else
+		return cfs_rq->min_vruntime;
+}
+
+static void update_core_cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
+{
+	struct cfs_rq *cfs_rq_core;
+
+	if (!sched_core_enabled(rq_of(cfs_rq)))
+		return;
+
+	if (!is_root_cfs_rq(cfs_rq))
+		return;
+
+	cfs_rq_core = core_cfs_rq(cfs_rq);
+	cfs_rq_core->min_vruntime = max(cfs_rq_core->min_vruntime,
+					cfs_rq->min_vruntime);
+}
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
+{
+	struct sched_entity *sea = &a->se;
+	struct sched_entity *seb = &b->se;
+	bool samecpu = task_cpu(a) == task_cpu(b);
+	struct task_struct *p;
+	s64 delta;
+
+	if (samecpu) {
+		/* vruntime is per cfs_rq */
+		while (!is_same_group(sea, seb)) {
+			int sea_depth = sea->depth;
+			int seb_depth = seb->depth;
+
+			if (sea_depth >= seb_depth)
+				sea = parent_entity(sea);
+			if (sea_depth <= seb_depth)
+				seb = parent_entity(seb);
+		}
+
+		delta = (s64)(sea->vruntime - seb->vruntime);
+		goto out;
+	}
+
+	/* crosscpu: compare root level se's vruntime to decide priority */
+	while (sea->parent)
+		sea = sea->parent;
+	while (seb->parent)
+		seb = seb->parent;
+	delta = (s64)(sea->vruntime - seb->vruntime);
+
+out:
+	p = delta > 0 ? b : a;
+	trace_printk("picked %s/%d %s: %Ld %Ld %Ld\n", p->comm, p->pid,
+			samecpu ? "samecpu" : "crosscpu",
+			sea->vruntime, seb->vruntime, delta);
+
+	return delta > 0;
 }
 
 static __always_inline
@@ -493,6 +569,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 
 	/* ensure we never gain time by being placed backwards. */
 	cfs_rq->min_vruntime = max_vruntime(cfs_rq_min_vruntime(cfs_rq), vruntime);
+	update_core_cfs_rq_min_vruntime(cfs_rq);
 #ifndef CONFIG_64BIT
 	smp_wmb();
 	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e91c188a452c..02a6d71704f0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2454,3 +2454,5 @@ static inline bool sched_energy_enabled(void)
 static inline bool sched_energy_enabled(void) { return false; }
 
 #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
-- 
2.19.1.3.ge56e4f7

