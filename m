Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C349BC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DD020850
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbfHZQvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:51:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:16493 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbfHZQvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:51:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 09:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="204647764"
Received: from mgross-mobl.amr.corp.intel.com (HELO localhost) ([10.7.198.58])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2019 09:51:48 -0700
Date:   Mon, 26 Aug 2019 09:51:47 -0700
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
Subject: Re: [RFC PATCH v3 07/16] sched: Allow put_prev_task() to drop
 rq->lock
Message-ID: <20190826165147.GE2680@u1904>
Reply-To: mgross@linux.intel.com
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <e4519f6850477ab7f3d257062796e6425ee4ba7c.1559129225.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4519f6850477ab7f3d257062796e6425ee4ba7c.1559129225.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 08:36:43PM +0000, Vineeth Remanan Pillai wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Currently the pick_next_task() loop is convoluted and ugly because of
> how it can drop the rq->lock and needs to restart the picking.
> 
> For the RT/Deadline classes, it is put_prev_task() where we do
> balancing, and we could do this before the picking loop. Make this
> possible.

Maybe explain why adding strtu rq_flags pointers to the function call supports
the above commit coment.  

--mark

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c      |  2 +-
>  kernel/sched/deadline.c  | 14 +++++++++++++-
>  kernel/sched/fair.c      |  2 +-
>  kernel/sched/idle.c      |  2 +-
>  kernel/sched/rt.c        | 14 +++++++++++++-
>  kernel/sched/sched.h     |  4 ++--
>  kernel/sched/stop_task.c |  2 +-
>  7 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 32ea79fb8d29..9dfa0c53deb3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5595,7 +5595,7 @@ static void calc_load_migrate(struct rq *rq)
>  		atomic_long_add(delta, &calc_load_tasks);
>  }
>  
> -static void put_prev_task_fake(struct rq *rq, struct task_struct *prev)
> +static void put_prev_task_fake(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
>  }
>  
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c02b3229e2c3..45425f971eec 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1772,13 +1772,25 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	return p;
>  }
>  
> -static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
> +static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
>  {
>  	update_curr_dl(rq);
>  
>  	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
>  	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
>  		enqueue_pushable_dl_task(rq, p);
> +
> +	if (rf && !on_dl_rq(&p->dl) && need_pull_dl_task(rq, p)) {
> +		/*
> +		 * This is OK, because current is on_cpu, which avoids it being
> +		 * picked for load-balance and preemption/IRQs are still
> +		 * disabled avoiding further scheduler activity on it and we've
> +		 * not yet started the picking loop.
> +		 */
> +		rq_unpin_lock(rq, rf);
> +		pull_dl_task(rq);
> +		rq_repin_lock(rq, rf);
> +	}
>  }
>  
>  /*
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 49707b4797de..8e3eb243fd9f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7110,7 +7110,7 @@ done: __maybe_unused;
>  /*
>   * Account for a descheduled task:
>   */
> -static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
> +static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
>  	struct sched_entity *se = &prev->se;
>  	struct cfs_rq *cfs_rq;
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index dd64be34881d..1b65a4c3683e 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -373,7 +373,7 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
>  	resched_curr(rq);
>  }
>  
> -static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
> +static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
>  }
>  
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index adec98a94f2b..51ee87c5a28a 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1593,7 +1593,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	return p;
>  }
>  
> -static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
> +static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
>  {
>  	update_curr_rt(rq);
>  
> @@ -1605,6 +1605,18 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>  	 */
>  	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
>  		enqueue_pushable_task(rq, p);
> +
> +	if (rf && !on_rt_rq(&p->rt) && need_pull_rt_task(rq, p)) {
> +		/*
> +		 * This is OK, because current is on_cpu, which avoids it being
> +		 * picked for load-balance and preemption/IRQs are still
> +		 * disabled avoiding further scheduler activity on it and we've
> +		 * not yet started the picking loop.
> +		 */
> +		rq_unpin_lock(rq, rf);
> +		pull_rt_task(rq);
> +		rq_repin_lock(rq, rf);
> +	}
>  }
>  
>  #ifdef CONFIG_SMP
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index bfcbcbb25646..4cbe2bef92e4 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1675,7 +1675,7 @@ struct sched_class {
>  	struct task_struct * (*pick_next_task)(struct rq *rq,
>  					       struct task_struct *prev,
>  					       struct rq_flags *rf);
> -	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
> +	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct rq_flags *rf);
>  	void (*set_next_task)(struct rq *rq, struct task_struct *p);
>  
>  #ifdef CONFIG_SMP
> @@ -1721,7 +1721,7 @@ struct sched_class {
>  static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
>  {
>  	WARN_ON_ONCE(rq->curr != prev);
> -	prev->sched_class->put_prev_task(rq, prev);
> +	prev->sched_class->put_prev_task(rq, prev, NULL);
>  }
>  
>  static inline void set_next_task(struct rq *rq, struct task_struct *next)
> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> index 47a3d2a18a9a..8f414018d5e0 100644
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -59,7 +59,7 @@ static void yield_task_stop(struct rq *rq)
>  	BUG(); /* the stop task should never yield, its pointless. */
>  }
>  
> -static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
> +static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
>  	struct task_struct *curr = rq->curr;
>  	u64 delta_exec;
> -- 
> 2.17.1
> 
