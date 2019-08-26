Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7E8C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B8120850
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbfHZRBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 13:01:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:17344 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729007AbfHZRBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:01:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 10:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="182503625"
Received: from mgross-mobl.amr.corp.intel.com (HELO localhost) ([10.7.198.58])
  by orsmga003.jf.intel.com with ESMTP; 26 Aug 2019 10:01:40 -0700
Date:   Mon, 26 Aug 2019 10:01:40 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 08/16] sched: Rework pick_next_task() slow-path
Message-ID: <20190826170140.GF2680@u1904>
Reply-To: mgross@linux.intel.com
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <aa34d24b36547139248f32a30138791ac6c02bd6.1559129225.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa34d24b36547139248f32a30138791ac6c02bd6.1559129225.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 08:36:44PM +0000, Vineeth Remanan Pillai wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Avoid the RETRY_TASK case in the pick_next_task() slow path.
> 
> By doing the put_prev_task() early, we get the rt/deadline pull done,
> and by testing rq->nr_running we know if we need newidle_balance().
> 
> This then gives a stable state to pick a task from.
> 
> Since the fast-path is fair only; it means the other classes will
> always have pick_next_task(.prev=NULL, .rf=NULL) and we can simplify.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c      | 19 ++++++++++++-------
>  kernel/sched/deadline.c  | 30 ++----------------------------
>  kernel/sched/fair.c      |  9 ++++++---
>  kernel/sched/idle.c      |  4 +++-
>  kernel/sched/rt.c        | 29 +----------------------------
>  kernel/sched/sched.h     | 13 ++++++++-----
>  kernel/sched/stop_task.c |  3 ++-
>  7 files changed, 34 insertions(+), 73 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9dfa0c53deb3..b883c70674ba 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3363,7 +3363,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  
>  		p = fair_sched_class.pick_next_task(rq, prev, rf);
>  		if (unlikely(p == RETRY_TASK))
> -			goto again;
> +			goto restart;
>  
>  		/* Assumes fair_sched_class->next == idle_sched_class */
>  		if (unlikely(!p))
> @@ -3372,14 +3372,19 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  		return p;
>  	}
>  
> -again:
> +restart:
> +	/*
> +	 * Ensure that we put DL/RT tasks before the pick loop, such that they
> +	 * can PULL higher prio tasks when we lower the RQ 'priority'.
> +	 */
> +	prev->sched_class->put_prev_task(rq, prev, rf);
> +	if (!rq->nr_running)
> +		newidle_balance(rq, rf);
> +
>  	for_each_class(class) {
> -		p = class->pick_next_task(rq, prev, rf);
> -		if (p) {
> -			if (unlikely(p == RETRY_TASK))
> -				goto again;
> +		p = class->pick_next_task(rq, NULL, NULL);
> +		if (p)
>  			return p;
> -		}
>  	}
>  
>  	/* The idle class should always have a runnable task: */
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 45425f971eec..d3904168857a 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1729,39 +1729,13 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	struct task_struct *p;
>  	struct dl_rq *dl_rq;
>  
> -	dl_rq = &rq->dl;
> -
> -	if (need_pull_dl_task(rq, prev)) {
> -		/*
> -		 * This is OK, because current is on_cpu, which avoids it being
> -		 * picked for load-balance and preemption/IRQs are still
> -		 * disabled avoiding further scheduler activity on it and we're
> -		 * being very careful to re-start the picking loop.
> -		 */
> -		rq_unpin_lock(rq, rf);
> -		pull_dl_task(rq);
> -		rq_repin_lock(rq, rf);
> -		/*
> -		 * pull_dl_task() can drop (and re-acquire) rq->lock; this
> -		 * means a stop task can slip in, in which case we need to
> -		 * re-start task selection.
> -		 */
> -		if (rq->stop && task_on_rq_queued(rq->stop))
> -			return RETRY_TASK;
> -	}
> +	WARN_ON_ONCE(prev || rf);
should there be a helpful message to go with this warning?

>  
> -	/*
> -	 * When prev is DL, we may throttle it in put_prev_task().
> -	 * So, we update time before we check for dl_nr_running.
> -	 */
> -	if (prev->sched_class == &dl_sched_class)
> -		update_curr_dl(rq);
> +	dl_rq = &rq->dl;
>  
>  	if (unlikely(!dl_rq->dl_nr_running))
>  		return NULL;
>  
> -	put_prev_task(rq, prev);
> -
>  	dl_se = pick_next_dl_entity(rq, dl_rq);
>  	BUG_ON(!dl_se);
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8e3eb243fd9f..e65f2dfda77a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6979,7 +6979,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  		goto idle;
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -	if (prev->sched_class != &fair_sched_class)
> +	if (!prev || prev->sched_class != &fair_sched_class)
>  		goto simple;
>  
>  	/*
> @@ -7056,8 +7056,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  	goto done;
>  simple:
>  #endif
> -
> -	put_prev_task(rq, prev);
> +	if (prev)
> +		put_prev_task(rq, prev);
>  
>  	do {
>  		se = pick_next_entity(cfs_rq, NULL);
> @@ -7085,6 +7085,9 @@ done: __maybe_unused;
>  	return p;
>  
>  idle:
> +	if (!rf)
> +		return NULL;
> +
>  	new_tasks = newidle_balance(rq, rf);
>  
>  	/*
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 1b65a4c3683e..7ece8e820b5d 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -388,7 +388,9 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  {
>  	struct task_struct *next = rq->idle;
>  
> -	put_prev_task(rq, prev);
> +	if (prev)
> +		put_prev_task(rq, prev);
> +
>  	set_next_task_idle(rq, next);
>  
>  	return next;
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 51ee87c5a28a..79f2e60516ef 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1554,38 +1554,11 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	struct task_struct *p;
>  	struct rt_rq *rt_rq = &rq->rt;
>  
> -	if (need_pull_rt_task(rq, prev)) {
> -		/*
> -		 * This is OK, because current is on_cpu, which avoids it being
> -		 * picked for load-balance and preemption/IRQs are still
> -		 * disabled avoiding further scheduler activity on it and we're
> -		 * being very careful to re-start the picking loop.
> -		 */
> -		rq_unpin_lock(rq, rf);
> -		pull_rt_task(rq);
> -		rq_repin_lock(rq, rf);
> -		/*
> -		 * pull_rt_task() can drop (and re-acquire) rq->lock; this
> -		 * means a dl or stop task can slip in, in which case we need
> -		 * to re-start task selection.
> -		 */
> -		if (unlikely((rq->stop && task_on_rq_queued(rq->stop)) ||
> -			     rq->dl.dl_nr_running))
> -			return RETRY_TASK;
> -	}
> -
> -	/*
> -	 * We may dequeue prev's rt_rq in put_prev_task().
> -	 * So, we update time before rt_queued check.
> -	 */
> -	if (prev->sched_class == &rt_sched_class)
> -		update_curr_rt(rq);
> +	WARN_ON_ONCE(prev || rf);
>  
>  	if (!rt_rq->rt_queued)
>  		return NULL;
>  
> -	put_prev_task(rq, prev);
> -
>  	p = _pick_next_task_rt(rq);
>  
>  	set_next_task_rt(rq, p);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 4cbe2bef92e4..460dd04e76af 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1665,12 +1665,15 @@ struct sched_class {
>  	void (*check_preempt_curr)(struct rq *rq, struct task_struct *p, int flags);
>  
>  	/*
> -	 * It is the responsibility of the pick_next_task() method that will
> -	 * return the next task to call put_prev_task() on the @prev task or
> -	 * something equivalent.
> +	 * Both @prev and @rf are optional and may be NULL, in which case the
> +	 * caller must already have invoked put_prev_task(rq, prev, rf).
>  	 *
> -	 * May return RETRY_TASK when it finds a higher prio class has runnable
> -	 * tasks.
> +	 * Otherwise it is the responsibility of the pick_next_task() to call
> +	 * put_prev_task() on the @prev task or something equivalent, IFF it
> +	 * returns a next task.
> +	 *
> +	 * In that case (@rf != NULL) it may return RETRY_TASK when it finds a
> +	 * higher prio class has runnable tasks.
>  	 */
>  	struct task_struct * (*pick_next_task)(struct rq *rq,
>  					       struct task_struct *prev,
> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> index 8f414018d5e0..7e1cee4e65b2 100644
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -33,10 +33,11 @@ pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  {
>  	struct task_struct *stop = rq->stop;
>  
> +	WARN_ON_ONCE(prev || rf);
should there be a helpful message to go with this warning?
--mark

> +
>  	if (!stop || !task_on_rq_queued(stop))
>  		return NULL;
>  
> -	put_prev_task(rq, prev);
>  	set_next_task_stop(rq, stop);
>  
>  	return stop;
> -- 
> 2.17.1
> 
