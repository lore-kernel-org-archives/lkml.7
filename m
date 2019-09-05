Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12962C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA894206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbfIEKFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:05:24 -0400
Received: from foss.arm.com ([217.140.110.172]:40928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731215AbfIEKFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:05:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9403B1576;
        Thu,  5 Sep 2019 03:05:22 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB4F03F67D;
        Thu,  5 Sep 2019 03:05:20 -0700 (PDT)
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com> <20190830174944.21741-2-subhra.mazumdar@oracle.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net,
        parth@linux.ibm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
In-reply-to: <20190830174944.21741-2-subhra.mazumdar@oracle.com>
Date:   Thu, 05 Sep 2019 11:05:18 +0100
Message-ID: <87pnkf2h41.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


We already commented on adding the cgroup API after the per-task API.

However, for the cgroup bits will be super important to have

 [ +tejun ]

in CC since here we are at discussing the idea to add a new cpu
controller's attribute.

There are opinions about which kind of attributes can be added to
cgroups and I'm sure a "latency-nice" attribute will generate an
interesting discussion. :)

LPC is coming up, perhaps we can get the chance to have a chat with
Tejun about the manoeuvring space in this area.

On Fri, Aug 30, 2019 at 18:49:36 +0100, subhra mazumdar wrote...

> Add Cgroup interface for latency-nice. Each CPU Cgroup adds a new file
> "latency-nice" which is shared by all the threads in that Cgroup.
>
> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
> ---
>  include/linux/sched.h |  1 +
>  kernel/sched/core.c   | 40 ++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c   |  1 +
>  kernel/sched/sched.h  |  8 ++++++++
>  4 files changed, 50 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1183741..b4a79c3 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -631,6 +631,7 @@ struct task_struct {
>  	int				static_prio;
>  	int				normal_prio;
>  	unsigned int			rt_priority;
> +	u64				latency_nice;

I guess we can save some bit here... or, if we are very brave, maybe we
can explore the possibility to pack all prios into a single u64?

 ( ( (tomatoes target here) ) )

>  	const struct sched_class	*sched_class;
>  	struct sched_entity		se;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 874c427..47969bc 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5976,6 +5976,7 @@ void __init sched_init(void)
>  		init_dl_rq(&rq->dl);
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
> +		root_task_group.latency_nice = LATENCY_NICE_DEFAULT;
>  		INIT_LIST_HEAD(&rq->leaf_cfs_rq_list);
>  		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
>  		/*
> @@ -6345,6 +6346,7 @@ static void sched_change_group(struct task_struct *tsk, int type)
>  	 */
>  	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
>  			  struct task_group, css);
> +	tsk->latency_nice = tg->latency_nice;
>  	tg = autogroup_task_group(tsk, tg);
>  	tsk->sched_task_group = tg;
>  
> @@ -6812,6 +6814,34 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
>  }
>  #endif /* CONFIG_RT_GROUP_SCHED */
>  
> +static u64 cpu_latency_nice_read_u64(struct cgroup_subsys_state *css,
> +				     struct cftype *cft)
> +{
> +	struct task_group *tg = css_tg(css);
> +
> +	return tg->latency_nice;
> +}
> +
> +static int cpu_latency_nice_write_u64(struct cgroup_subsys_state *css,
> +				      struct cftype *cft, u64 latency_nice)
> +{
> +	struct task_group *tg = css_tg(css);
> +	struct css_task_iter it;
> +	struct task_struct *p;
> +
> +	if (latency_nice < LATENCY_NICE_MIN || latency_nice > LATENCY_NICE_MAX)
> +		return -ERANGE;
> +
> +	tg->latency_nice = latency_nice;
> +
> +	css_task_iter_start(css, 0, &it);
> +	while ((p = css_task_iter_next(&it)))
> +		p->latency_nice = latency_nice;

Once (and if) the cgroup API is added we can avoid this (potentially
massive) "update on write" in favour of an "on demand composition at
wakeup-time".

We don't care about updating the latency-nice of NON RUNNABLE tasks,
do we?

AFAIK, we need that value only (or mostly) at wakeup time. Thus, when a
task wakeup up we can easily compose (and eventually cache) it's
current latency-nice value by considering, in priority order:

  - the system wide upper-bound
  - the task group restriction
  - the task specific relaxation

Something similar to what we already do for uclamp composition with this
patch currently in tip/sched/core:

   commit 3eac870a3247 ("sched/uclamp: Use TG's clamps to restrict TASK's clamps")


> +	css_task_iter_end(&it);
> +
> +	return 0;
> +}
> +
>  static struct cftype cpu_legacy_files[] = {
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	{
> @@ -6848,6 +6878,11 @@ static struct cftype cpu_legacy_files[] = {
>  		.write_u64 = cpu_rt_period_write_uint,
>  	},
>  #endif
> +	{
> +		.name = "latency-nice",
> +		.read_u64 = cpu_latency_nice_read_u64,
> +		.write_u64 = cpu_latency_nice_write_u64,
> +	},
>  	{ }	/* Terminate */
>  };
>  
> @@ -7015,6 +7050,11 @@ static struct cftype cpu_files[] = {
>  		.write = cpu_max_write,
>  	},
>  #endif
> +	{
> +		.name = "latency-nice",
> +		.read_u64 = cpu_latency_nice_read_u64,
> +		.write_u64 = cpu_latency_nice_write_u64,
> +	},
>  	{ }	/* terminate */
>  };
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f35930f..b08d00c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10479,6 +10479,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
>  		goto err;
>  
>  	tg->shares = NICE_0_LOAD;
> +	tg->latency_nice = LATENCY_NICE_DEFAULT;
                           ^^^^^^^^^^^^^^^^^^^^
Maybe better NICE_0_LATENCY to be more consistent?


>  	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b52ed1a..365c928 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -143,6 +143,13 @@ static inline void cpu_load_update_active(struct rq *this_rq) { }
>  #define NICE_0_LOAD		(1L << NICE_0_LOAD_SHIFT)
>  
>  /*
> + * Latency-nice default value
> + */
> +#define	LATENCY_NICE_DEFAULT	5
> +#define	LATENCY_NICE_MIN	1
> +#define	LATENCY_NICE_MAX	100

Values 1 and 5 looks kind of arbitrary.
For the range specifically, I already commented in this other message:

   Message-ID: <87r24v2i14.fsf@arm.com>
   https://lore.kernel.org/lkml/87r24v2i14.fsf@arm.com/

> +
> +/*
>   * Single value that decides SCHED_DEADLINE internal math precision.
>   * 10 -> just above 1us
>   * 9  -> just above 0.5us
> @@ -362,6 +369,7 @@ struct cfs_bandwidth {
>  /* Task group related information */
>  struct task_group {
>  	struct cgroup_subsys_state css;
> +	u64 latency_nice;
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	/* schedulable entities of this group on each CPU */


Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
