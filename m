Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D118AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B708421848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405217AbfHWSOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 14:14:45 -0400
Received: from foss.arm.com ([217.140.110.172]:37948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404393AbfHWSOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 14:14:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C81E7337;
        Fri, 23 Aug 2019 11:14:43 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AE6C3F246;
        Fri, 23 Aug 2019 11:14:42 -0700 (PDT)
Subject: Re: [PATCH 11/15] sched,fair: flatten hierarchical runqueues
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, peterz@infradead.org,
        mingo@redhat.com, morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
References: <20190822021740.15554-1-riel@surriel.com>
 <20190822021740.15554-12-riel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <967114b2-15a7-b445-3133-074732b20e34@arm.com>
Date:   Fri, 23 Aug 2019 20:14:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822021740.15554-12-riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2019 04:17, Rik van Riel wrote:
> Flatten the hierarchical runqueues into just the per CPU rq.cfs runqueue.
> 
> Iteration of the sched_entity hierarchy is rate limited to once per jiffy
> per sched_entity, which is a smaller change than it seems, because load
> average adjustments were already rate limited to once per jiffy before this
> patch series.
> 
> This patch breaks CONFIG_CFS_BANDWIDTH. The plan for that is to park tasks
> from throttled cgroups onto their cgroup runqueues, and slowly (using the
> GENTLE_FAIR_SLEEPERS) wake them back up, in vruntime order, once the cgroup
> gets unthrottled, to prevent thundering herd issues.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> 
> Header from folded patch 'fix-attach-detach_enticy_cfs_rq.patch~':
> 
> Subject: sched,fair: fix attach/detach_entity_cfs_rq
> 
> While attach_entity_cfs_rq and detach_entity_cfs_rq should iterate over
> the hierarchy, they do not need to so that twice.
> 
> Passing flags into propagate_entity_cfs_rq allows us to reuse that same
> loop from other functions.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> 
> 
> Header from folded patch 'enqueue-order.patch':
> 
> Subject: sched,fair: better ordering at enqueue_task_fair time
> 
> In order to get useful numbers for the task's hierarchical weight,
> task priority, etc things need to be done in a certain order at task
> enqueue time.
> 
> Specifically:
> 1) static load/weight to "local" cfs_rq
> 2) propagate load/weight up the tree
> 3) add runnable load avg to root cfs_rq
> 
> The reason is that each step depends on the things done by the
> step beforehand, and we can end up with nonsense numbers if we
> do not do things right.
> 
> Also, make sure that we walk all the way up the hierarchy at
> enqueue_task_fair time in order to get the benefit from the ramp-up
> logic in update_cfs_group.

[...]

>  /*
> @@ -6953,7 +6849,6 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>  	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
>  		return;
>  
> -	find_matching_se(&se, &pse);
>  	update_curr(cfs_rq_of(se));
>  	BUG_ON(!pse);
>  	if (wakeup_preempt_entity(se, pse) == 1) {
> @@ -6994,100 +6889,18 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  	struct task_struct *p;
>  	int new_tasks;
>  
> +	put_prev_task(rq, prev);
>  again:
>  	if (!cfs_rq->nr_running)
>  		goto idle;
>  
> -#ifdef CONFIG_FAIR_GROUP_SCHED
> -	if (prev->sched_class != &fair_sched_class)
> -		goto simple;
> -
> -	/*
> -	 * Because of the set_next_buddy() in dequeue_task_fair() it is rather
> -	 * likely that a next task is from the same cgroup as the current.
> -	 *
> -	 * Therefore attempt to avoid putting and setting the entire cgroup
> -	 * hierarchy, only change the part that actually changes.
> -	 */
> -
> -	do {
> -		struct sched_entity *curr = cfs_rq->curr;
> -
> -		/*
> -		 * Since we got here without doing put_prev_entity() we also
> -		 * have to consider cfs_rq->curr. If it is still a runnable
> -		 * entity, update_curr() will update its vruntime, otherwise
> -		 * forget we've ever seen it.
> -		 */
> -		if (curr) {
> -			if (curr->on_rq)
> -				update_curr(cfs_rq);
> -			else
> -				curr = NULL;
> -
> -			/*
> -			 * This call to check_cfs_rq_runtime() will do the
> -			 * throttle and dequeue its entity in the parent(s).
> -			 * Therefore the nr_running test will indeed
> -			 * be correct.
> -			 */
> -			if (unlikely(check_cfs_rq_runtime(cfs_rq))) {
> -				cfs_rq = &rq->cfs;
> -
> -				if (!cfs_rq->nr_running)
> -					goto idle;
> -
> -				goto simple;
> -			}
> -		}
> -
> -		se = pick_next_entity(cfs_rq, curr);
> -		cfs_rq = group_cfs_rq(se);
> -	} while (cfs_rq);
> -
> -	p = task_of(se);
> -
> -	/*
> -	 * Since we haven't yet done put_prev_entity and if the selected task
> -	 * is a different task than we started out with, try and touch the
> -	 * least amount of cfs_rqs.
> -	 */
> -	if (prev != p) {
> -		struct sched_entity *pse = &prev->se;
> -
> -		while (!(cfs_rq = is_same_group(se, pse))) {
> -			int se_depth = se->depth;
> -			int pse_depth = pse->depth;
> -
> -			if (se_depth <= pse_depth) {
> -				put_prev_entity(cfs_rq_of(pse), pse);
> -				pse = parent_entity(pse);
> -			}
> -			if (se_depth >= pse_depth) {
> -				set_next_entity(cfs_rq_of(se), se);
> -				se = parent_entity(se);
> -			}

Looks like with the se->depth related code gone here in
pick_next_task_fair() and the call to find_matching_se() in
check_preempt_wakeup() you could remove se->depth entirely.

[...]
