Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90449C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6196B217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389894AbfGRKH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:07:27 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:38249 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbfGRKH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:07:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0TXCBWtI_1563444434;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TXCBWtI_1563444434)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Jul 2019 18:07:21 +0800
Date:   Thu, 18 Jul 2019 18:07:14 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
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
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190718100714.GA469@aaronlu>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <20190531210816.GA24027@sinkpad>
 <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619183302.GA6775@sinkpad>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 02:33:02PM -0400, Julien Desfossez wrote:
> On 17-Jun-2019 10:51:27 AM, Aubrey Li wrote:
> > The result looks still unfair, and particularly, the variance is too high,
> 
> I just want to confirm that I am also seeing the same issue with a
> similar setup. I also tried with the priority boost fix we previously
> posted, the results are slightly better, but we are still seeing a very
> high variance.
> 
> On average, the results I get for 10 30-seconds runs are still much
> better than nosmt (both sysbench pinned on the same sibling) for the
> memory benchmark, and pretty similar for the CPU benchmark, but the high
> variance between runs is indeed concerning.

I was thinking to use util_avg signal to decide which task win in
__prio_less() in the cross cpu case. The reason util_avg is chosen
is because it represents how cpu intensive the task is, so the end
result is, less cpu intensive task will preempt more cpu intensive
task.

Here is the test I have done to see how util_avg works
(on a single node, 16 cores, 32 cpus vm):
1 Start tmux and then start 3 windows with each running bash;
2 Place two shells into two different cgroups and both have cpu.tag set;
3 Switch to the 1st tmux window, start
  will-it-scale/page_fault1_processes -t 16 -s 30
  in the first tagged shell;
4 Switch to the 2nd tmux window;
5 Start
  will-it-scale/page_fault1_processes -t 16 -s 30
  in the 2nd tagged shell;
6 Switch to the 3rd tmux window;
7 Do some simple things in the 3rd untagged shell like ls to see if
  untagged task is able to proceed;
8 Wait for the two page_fault workloads to finish.

With v3 here, I can not do step 4 and later steps, i.e. the 16
page_fault1 processes started in step 3 will occupy all 16 cores and
other tasks do not have a chance to run, including tmux, which made
switching tmux window impossible.

With the below patch on top of v3 that makes use of util_avg to decide
which task win, I can do all 8 steps and the final scores of the 2
workloads are: 1796191 and 2199586. The score number are not close,
suggesting some unfairness, but I can finish the test now...

Here is the diff(consider it as a POC):

---
 kernel/sched/core.c  | 35 ++---------------------------------
 kernel/sched/fair.c  | 36 ++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  2 ++
 3 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 26fea68f7f54..7557a7bbb481 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -105,25 +105,8 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
-		u64 a_vruntime = a->se.vruntime;
-		u64 b_vruntime = b->se.vruntime;
-
-		/*
-		 * Normalize the vruntime if tasks are in different cpus.
-		 */
-		if (task_cpu(a) != task_cpu(b)) {
-			b_vruntime -= task_cfs_rq(b)->min_vruntime;
-			b_vruntime += task_cfs_rq(a)->min_vruntime;
-
-			trace_printk("(%d:%Lu,%Lu,%Lu) <> (%d:%Lu,%Lu,%Lu)\n",
-				     a->pid, a_vruntime, a->se.vruntime, task_cfs_rq(a)->min_vruntime,
-				     b->pid, b_vruntime, b->se.vruntime, task_cfs_rq(b)->min_vruntime);
-
-		}
-
-		return !((s64)(a_vruntime - b_vruntime) <= 0);
-	}
+	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
+		return cfs_prio_less(a, b);
 
 	return false;
 }
@@ -3663,20 +3646,6 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 	if (!class_pick)
 		return NULL;
 
-	if (!cookie) {
-		/*
-		 * If class_pick is tagged, return it only if it has
-		 * higher priority than max.
-		 */
-		bool max_is_higher = sched_feat(CORESCHED_STALL_FIX) ?
-				     max && !prio_less(max, class_pick) :
-				     max && prio_less(class_pick, max);
-		if (class_pick->core_cookie && max_is_higher)
-			return idle_sched_class.pick_task(rq);
-
-		return class_pick;
-	}
-
 	/*
 	 * If class_pick is idle or matches cookie, return early.
 	 */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 26d29126d6a5..06fb00689db1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10740,3 +10740,39 @@ __init void init_sched_fair_class(void)
 #endif /* SMP */
 
 }
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
+{
+	struct sched_entity *sea = &a->se;
+	struct sched_entity *seb = &b->se;
+	bool samecore = task_cpu(a) == task_cpu(b);
+	struct task_struct *p;
+	s64 delta;
+
+	if (samecore) {
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
+	}
+
+	/* across cpu: use util_avg to decide which task to run */
+	delta = (s64)(sea->avg.util_avg - seb->avg.util_avg);
+
+	p = delta > 0 ? b : a;
+	trace_printk("picked %s/%d %s: %Lu %Lu %Ld\n", p->comm, p->pid,
+			samecore ? "vruntime" : "util_avg",
+			samecore ? sea->vruntime : sea->avg.util_avg,
+			samecore ? seb->vruntime : seb->avg.util_avg,
+			delta);
+
+	return delta > 0;
+}
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

