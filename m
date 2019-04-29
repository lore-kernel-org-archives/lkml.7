Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F611C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 03:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF3D206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 03:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfD2Dx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 23:53:28 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:42448 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbfD2Dx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 23:53:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TQTE8IF_1556510001;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TQTE8IF_1556510001)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Apr 2019 11:53:22 +0800
Date:   Mon, 29 Apr 2019 11:53:21 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190429035320.GB128241@aaronlu>
References: <20190423180238.GG22260@pauld.bos.csb>
 <20190423184527.6230-1-vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423184527.6230-1-vpillai@digitalocean.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 06:45:27PM +0000, Vineeth Remanan Pillai wrote:
> >> - Processes with different tags can still share the core
> 
> > I may have missed something... Could you explain this statement?
> 
> > This, to me, is the whole point of the patch series. If it's not
> > doing this then ... what?
> 
> What I meant was, the patch needs some more work to be accurate.
> There are some race conditions where the core violation can still
> happen. In our testing, we saw around 1 to 5% of the time being
> shared with incompatible processes. One example of this happening
> is as follows(let cpu 0 and 1 be siblings):
> - cpu 0 selects a process with a cookie
> - cpu 1 selects a higher priority process without cookie
> - Selection process restarts for cpu 0 and it might select a
>   process with cookie but with lesser priority.
> - Since it is lesser priority, the logic in pick_next_task
>   doesn't compare again for the cookie(trusts pick_task) and
>   proceeds.
> 
> This is one of the scenarios that we saw from traces, but there
> might be other race conditions as well. Fix seems a little
> involved and We are working on that.

This is what I have used to make sure no two unmatched tasks being
scheduled on the same core: (on top of v1, I thinks it's easier to just
show the diff instead of commenting on various places of the patches :-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb24a0141e57..0cdb1c6a00a4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -186,6 +186,10 @@ struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 	 */
 	match = idle_sched_class.pick_task(rq);
 
+	/* TODO: untagged tasks are not in the core tree */
+	if (!cookie)
+		goto out;
+
 	while (node) {
 		node_task = container_of(node, struct task_struct, core_node);
 
@@ -199,6 +203,7 @@ struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 		}
 	}
 
+out:
 	return match;
 }
 
@@ -3634,6 +3639,8 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 }
 
 // XXX fairness/fwd progress conditions
+// when max is unset, return class_pick;
+// when max is set, return cookie_pick unless class_pick has higher priority.
 static struct task_struct *
 pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
 {
@@ -3652,7 +3659,19 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 	}
 
 	class_pick = class->pick_task(rq);
-	if (!cookie)
+	/*
+	 * we can only return class_pick here when max is not set.
+	 *
+	 * when max is set and cookie is 0, we still have to check if
+	 * class_pick's cookie matches with max, or we can end up picking
+	 * an unmacthed task. e.g. max is untagged and class_pick here
+	 * is tagged.
+	 */
+	if (!cookie && !max)
+		return class_pick;
+
+	/* in case class_pick matches with max, no need to check priority */
+	if (class_pick && cookie_match(class_pick, max))
 		return class_pick;
 
 	cookie_pick = sched_core_find(rq, cookie);
@@ -3663,8 +3682,11 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 	 * If class > max && class > cookie, it is the highest priority task on
 	 * the core (so far) and it must be selected, otherwise we must go with
 	 * the cookie pick in order to satisfy the constraint.
+	 *
+	 * class_pick and cookie_pick are on the same cpu so use cpu_prio_less()
+	 * max and class_pick are on different cpus so use core_prio_less()
 	 */
-	if (cpu_prio_less(cookie_pick, class_pick) && cpu_prio_less(max, class_pick))
+	if (cpu_prio_less(cookie_pick, class_pick) && core_prio_less(max, class_pick))
 		return class_pick;
 
 	return cookie_pick;
@@ -3731,8 +3753,17 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		rq_i->core_pick = NULL;
 
-		if (i != cpu)
+		if (i != cpu) {
 			update_rq_clock(rq_i);
+			/*
+			 * we are going to pick tasks for both cpus, if our
+			 * sibling is idle and we have core_cookie set, now
+			 * is the time to clear/reset it so that we can do
+			 * an unconstained pick.
+			 */
+			if (is_idle_task(rq_i->curr) && rq_i->core->core_cookie)
+				rq_i->core->core_cookie = 0;
+		}
 	}
 
 	/*
@@ -3794,20 +3825,42 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 *
 			 * NOTE: this is a linear max-filter and is thus bounded
 			 * in execution time.
+			 *
+			 * The fact that pick_task() returns p with a different
+			 * cookie means p has higher priority and we need to
+			 * replace max with p.
 			 */
-			if (!max || core_prio_less(max, p)) {
+			if (!max || !cookie_match(max, p)) {
 				struct task_struct *old_max = max;
 
 				rq->core->core_cookie = p->core_cookie;
 				max = p;
 				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
 
-				if (old_max && !cookie_match(old_max, p)) {
+				if (old_max) {
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
 							continue;
 
 						cpu_rq(j)->core_pick = NULL;
+
+						/*
+						 * if max is untagged, then core_cookie
+						 * is zero and siblig can do a wrongly
+						 * unconstained pick. avoid that by doing
+						 * pick directly here. since there is no
+						 * untagged tasks in core tree, just
+						 * use idle for our sibling.
+						 * TODO: sibling may pick an untagged task.
+						 */
+						if (max->core_cookie)
+							cpu_rq(j)->core_pick = NULL;
+						else {
+							cpu_rq(j)->core_pick = idle_sched_class.pick_task(cpu_rq(j));
+							occ = 1;
+							goto out;
+						}
+
 					}
 					occ = 1;
 					goto again;
@@ -3817,6 +3870,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 next_class:;
 	}
 
+out:
 	rq->core->core_pick_seq = rq->core->core_task_seq;
 
 	/*
@@ -3834,6 +3888,17 @@ next_class:;
 
 		rq_i->core_pick->core_occupation = occ;
 
+		/* make sure we didn't break L1TF */
+		if (!is_idle_task(rq_i->core_pick) &&
+		    rq_i->core_pick->core_cookie != rq_i->core->core_cookie) {
+			trace_printk("cpu%d: cookie mismatch. %s/%d/0x%lx/0x%lx\n",
+					rq_i->cpu, rq_i->core_pick->comm,
+					rq_i->core_pick->pid,
+					rq_i->core_pick->core_cookie,
+					rq_i->core->core_cookie);
+			WARN_ON_ONCE(1);
+		}
+
 		if (i == cpu)
 			continue;
 
