Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D51AC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 14:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EB52085B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 14:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfHJOQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 10:16:16 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:41477 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbfHJOQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 10:16:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TZ5d3qr_1565446556;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TZ5d3qr_1565446556)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 10 Aug 2019 22:16:04 +0800
Date:   Sat, 10 Aug 2019 22:15:56 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
Message-ID: <20190810141556.GA73644@aaronlu>
References: <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com>
 <20190806032418.GA54717@aaronlu>
 <e1c4a7ed-822e-93cb-ff1d-6a0842db115f@linux.intel.com>
 <20190806171241.GQ2349@hirez.programming.kicks-ass.net>
 <21933a50-f796-3d28-664c-030cb7c98431@linux.intel.com>
 <20190808064731.GA5121@aaronlu>
 <70d1ff90-9be9-7b05-f1ff-e751f266183b@linux.intel.com>
 <b7a83fcb-5c34-9794-5688-55c52697fd84@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a83fcb-5c34-9794-5688-55c52697fd84@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 02:42:57PM -0700, Tim Chen wrote:
> On 8/8/19 10:27 AM, Tim Chen wrote:
> > On 8/7/19 11:47 PM, Aaron Lu wrote:
> >> On Tue, Aug 06, 2019 at 02:19:57PM -0700, Tim Chen wrote:
> >>> +void account_core_idletime(struct task_struct *p, u64 exec)
> >>> +{
> >>> +	const struct cpumask *smt_mask;
> >>> +	struct rq *rq;
> >>> +	bool force_idle, refill;
> >>> +	int i, cpu;
> >>> +
> >>> +	rq = task_rq(p);
> >>> +	if (!sched_core_enabled(rq) || !p->core_cookie)
> >>> +		return;
> >>
> >> I don't see why return here for untagged task. Untagged task can also
> >> preempt tagged task and force a CPU thread enter idle state.
> >> Untagged is just another tag to me, unless we want to allow untagged
> >> task to coschedule with a tagged task.
> > 
> > You are right.  This needs to be fixed.
> > 
> 
> Here's the updated patchset, including Aaron's fix and also
> added accounting of force idle time by deadline and rt tasks.

I have two other small changes that I think are worth sending out.

The first simplify logic in pick_task() and the 2nd avoid task pick all
over again when max is preempted. I also refined the previous hack patch to
make schedule always happen only for root cfs rq. Please see below for
details, thanks.

patch1:

From cea56db35fe9f393c357cdb1bdcb2ef9b56cfe97 Mon Sep 17 00:00:00 2001
From: Aaron Lu <ziqian.lzq@antfin.com>
Date: Mon, 5 Aug 2019 21:21:25 +0800
Subject: [PATCH 1/3] sched/core: simplify pick_task()

No need to special case !cookie case in pick_task(), we just need to
make it possible to return idle in sched_core_find() for !cookie query.
And cookie_pick will always have less priority than class_pick, so
remove the redundant check of prio_less(cookie_pick, class_pick).

Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
---
 kernel/sched/core.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90655c9ad937..84fec9933b74 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -186,6 +186,8 @@ static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 	 * The idle task always matches any cookie!
 	 */
 	match = idle_sched_class.pick_task(rq);
+	if (!cookie)
+		goto out;
 
 	while (node) {
 		node_task = container_of(node, struct task_struct, core_node);
@@ -199,7 +201,7 @@ static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 			node = node->rb_left;
 		}
 	}
-
+out:
 	return match;
 }
 
@@ -3657,18 +3659,6 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 	if (!class_pick)
 		return NULL;
 
-	if (!cookie) {
-		/*
-		 * If class_pick is tagged, return it only if it has
-		 * higher priority than max.
-		 */
-		if (max && class_pick->core_cookie &&
-		    prio_less(class_pick, max))
-			return idle_sched_class.pick_task(rq);
-
-		return class_pick;
-	}
-
 	/*
 	 * If class_pick is idle or matches cookie, return early.
 	 */
@@ -3682,8 +3672,7 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 	 * the core (so far) and it must be selected, otherwise we must go with
 	 * the cookie pick in order to satisfy the constraint.
 	 */
-	if (prio_less(cookie_pick, class_pick) &&
-	    (!max || prio_less(max, class_pick)))
+	if (!max || prio_less(max, class_pick))
 		return class_pick;
 
 	return cookie_pick;
-- 
2.19.1.3.ge56e4f7

patch2:

From 487950dc53a40d5c566602f775ce46a0bab7a412 Mon Sep 17 00:00:00 2001
From: Aaron Lu <ziqian.lzq@antfin.com>
Date: Fri, 9 Aug 2019 14:48:01 +0800
Subject: [PATCH 2/3] sched/core: no need to pick again after max is preempted

When sibling's task preempts current max, there is no need to do the
pick all over again - the preempted cpu could just pick idle and done.

Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
---
 kernel/sched/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 84fec9933b74..e88583860abe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3756,7 +3756,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * order.
 	 */
 	for_each_class(class) {
-again:
 		for_each_cpu_wrap(i, smt_mask, cpu) {
 			struct rq *rq_i = cpu_rq(i);
 			struct task_struct *p;
@@ -3828,10 +3827,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 						if (j == i)
 							continue;
 
-						cpu_rq(j)->core_pick = NULL;
+						cpu_rq(j)->core_pick = idle_sched_class.pick_task(cpu_rq(j));
 					}
 					occ = 1;
-					goto again;
+					goto out;
 				} else {
 					/*
 					 * Once we select a task for a cpu, we
@@ -3846,7 +3845,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 next_class:;
 	}
-
+out:
 	rq->core->core_pick_seq = rq->core->core_task_seq;
 	next = rq->core_pick;
 	rq->core_sched_seq = rq->core->core_pick_seq;
-- 
2.19.1.3.ge56e4f7

patch3:

From 2d396d99e0dd7157b0b4f7a037c8b84ed135ea56 Mon Sep 17 00:00:00 2001
From: Aaron Lu <ziqian.lzq@antfin.com>
Date: Thu, 25 Jul 2019 19:57:21 +0800
Subject: [PATCH 3/3] sched/fair: make tick based schedule always happen

When a hyperthread is forced idle and the other hyperthread has a single
CPU intensive task running, the running task can occupy the hyperthread
for a long time with no scheduling point and starve the other
hyperthread.

Fix this temporarily by always checking if the task has exceed its
timeslice and if so, for root cfs_rq, do a schedule.

Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
---
 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 26d29126d6a5..b1f0defdad91 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4011,6 +4011,9 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 		return;
 	}
 
+	if (cfs_rq->nr_running <= 1)
+		return;
+
 	/*
 	 * Ensure that a task that missed wakeup preemption by a
 	 * narrow margin doesn't have to wait for a full slice.
@@ -4179,7 +4182,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 		return;
 #endif
 
-	if (cfs_rq->nr_running > 1)
+	if (cfs_rq->nr_running > 1 || cfs_rq->tg == &root_task_group)
 		check_preempt_tick(cfs_rq, curr);
 }
 
-- 
2.19.1.3.ge56e4f7

