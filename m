Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D873C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7808920679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfH1Hvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:51:40 -0400
Received: from foss.arm.com ([217.140.110.172]:54556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfH1Hvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:51:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E247344;
        Wed, 28 Aug 2019 00:51:39 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1D793F59C;
        Wed, 28 Aug 2019 00:51:37 -0700 (PDT)
Subject: Re: [PATCH 13/15] sched,fair: propagate sum_exec_runtime up the
 hierarchy
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, peterz@infradead.org,
        mingo@redhat.com, morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
References: <20190822021740.15554-1-riel@surriel.com>
 <20190822021740.15554-14-riel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f940abf6-3020-014c-74d7-d9be334e201c@arm.com>
Date:   Wed, 28 Aug 2019 09:51:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822021740.15554-14-riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2019 04:17, Rik van Riel wrote:
> Now that enqueue_task_fair and dequeue_task_fair no longer iterate up
> the hierarchy all the time, a method to lazily propagate sum_exec_runtime
> up the hierarchy is necessary.
> 
> Once a tick, propagate the newly accumulated exec_runtime up the hierarchy,
> and feed it into CFS bandwidth control.
> 
> Remove the pointless call to account_cfs_rq_runtime from update_curr,
> which is always called with a root cfs_rq.

But what about the call to account_cfs_rq_runtime() in
set_curr_task_fair()? Here you always call it with the root cfs_rq.
Shouldn't this be called also in a loop over all se's until !se->parent
(like in propagate_exec_runtime() further below).

> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  include/linux/sched.h |  1 +
>  kernel/sched/core.c   |  1 +
>  kernel/sched/fair.c   | 22 ++++++++++++++++++++--
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 901c710363e7..bdca15b3afe7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -454,6 +454,7 @@ struct sched_entity {
>  	int				depth;
>  	unsigned long			enqueued_h_load;
>  	unsigned long			enqueued_h_weight;
> +	u64				propagated_exec_runtime;
>  	struct load_weight		h_load;
>  	struct sched_entity		*parent;
>  	/* rq on which this entity is (to be) queued: */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fbd96900f715..9915d20e84a9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2137,6 +2137,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>  	INIT_LIST_HEAD(&p->se.group_node);
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> +	p->se.propagated_exec_runtime	= 0;
>  	p->se.cfs_rq			= NULL;
>  #endif
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5cfa3dbeba49..d6c881c5c4d5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -898,8 +898,6 @@ static void update_curr(struct cfs_rq *cfs_rq)
>  	trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
>  	cgroup_account_cputime(curtask, delta_exec);
>  	account_group_exec_runtime(curtask, delta_exec);
> -
> -	account_cfs_rq_runtime(cfs_rq, delta_exec);
>  }
>  
>  static void update_curr_fair(struct rq *rq)
> @@ -3412,6 +3410,20 @@ static inline bool skip_blocked_update(struct sched_entity *se)
>  	return true;
>  }
>  
> +static void propagate_exec_runtime(struct cfs_rq *cfs_rq,
> +				struct sched_entity *se)
> +{
> +	struct sched_entity *parent = se->parent;
> +	u64 diff = se->sum_exec_runtime - se->propagated_exec_runtime;
> +
> +	if (parent) {
> +		parent->sum_exec_runtime += diff;
> +		account_cfs_rq_runtime(cfs_rq, diff);
> +	}
> +
> +	se->propagated_exec_runtime = se->sum_exec_runtime;
> +}
> +
>  #else /* CONFIG_FAIR_GROUP_SCHED */
>  
>  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force) {}
> @@ -3423,6 +3435,11 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
>  
>  static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum) {}
>  
> +static void propagate_exec_runtime(struct cfs_rq *cfs_rq,
> +				struct sched_entity *se);
> +{
> +}
> +
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>  
>  /**
> @@ -10157,6 +10174,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se, int flags)
>  			if (!(flags & DO_ATTACH))
>  				break;
>  
> +		propagate_exec_runtime(cfs_rq, se);
>  		update_cfs_group(se);
>  	}
>  }
> 
