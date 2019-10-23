Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDE5CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0190C2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390024AbfJWHud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:50:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:61334 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbfJWHud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:50:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 00:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="201057386"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.64]) ([10.255.28.64])
  by orsmga003.jf.intel.com with ESMTP; 23 Oct 2019 00:50:29 -0700
Subject: Re: [PATCH] sched/fair: fix rework of find_idlest_group()
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com
References: <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
 <1571762798-25900-1-git-send-email-vincent.guittot@linaro.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <b6dafa6d-6d9a-3499-85b8-52c5163cd38d@intel.com>
Date:   Wed, 23 Oct 2019 15:50:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571762798-25900-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: kernel test robot <rong.a.chen@intel.com>

On 10/23/2019 12:46 AM, Vincent Guittot wrote:
> The task, for which the scheduler looks for the idlest group of CPUs, must
> be discounted from all statistics in order to get a fair comparison
> between groups. This includes utilization, load, nr_running and idle_cpus.
>
> Such unfairness can be easily highlighted with the unixbench execl 1 task.
> This test continuously call execve() and the scheduler looks for the idlest
> group/CPU on which it should place the task. Because the task runs on the
> local group/CPU, the latter seems already busy even if there is nothing
> else running on it. As a result, the scheduler will always select another
> group/CPU than the local one.
>
> Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>
> This recover most of the perf regression on my system and I have asked
> Rong if he can rerun the test with the patch to check that it fixes his
> system as well.
>
>   kernel/sched/fair.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 83 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a81c364..0ad4b21 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5379,6 +5379,36 @@ static unsigned long cpu_load(struct rq *rq)
>   {
>   	return cfs_rq_load_avg(&rq->cfs);
>   }
> +/*
> + * cpu_load_without - compute cpu load without any contributions from *p
> + * @cpu: the CPU which load is requested
> + * @p: the task which load should be discounted
> + *
> + * The load of a CPU is defined by the load of tasks currently enqueued on that
> + * CPU as well as tasks which are currently sleeping after an execution on that
> + * CPU.
> + *
> + * This method returns the load of the specified CPU by discounting the load of
> + * the specified task, whenever the task is currently contributing to the CPU
> + * load.
> + */
> +static unsigned long cpu_load_without(struct rq *rq, struct task_struct *p)
> +{
> +	struct cfs_rq *cfs_rq;
> +	unsigned int load;
> +
> +	/* Task has no contribution or is new */
> +	if (cpu_of(rq) != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
> +		return cpu_load(rq);
> +
> +	cfs_rq = &rq->cfs;
> +	load = READ_ONCE(cfs_rq->avg.load_avg);
> +
> +	/* Discount task's util from CPU's util */
> +	lsub_positive(&load, task_h_load(p));
> +
> +	return load;
> +}
>   
>   static unsigned long capacity_of(int cpu)
>   {
> @@ -8117,10 +8147,55 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
>   struct sg_lb_stats;
>   
>   /*
> + * task_running_on_cpu - return 1 if @p is running on @cpu.
> + */
> +
> +static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
> +{
> +	/* Task has no contribution or is new */
> +	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
> +		return 0;
> +
> +	if (task_on_rq_queued(p))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/**
> + * idle_cpu_without - would a given CPU be idle without p ?
> + * @cpu: the processor on which idleness is tested.
> + * @p: task which should be ignored.
> + *
> + * Return: 1 if the CPU would be idle. 0 otherwise.
> + */
> +static int idle_cpu_without(int cpu, struct task_struct *p)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	if ((rq->curr != rq->idle) && (rq->curr != p))
> +		return 0;
> +
> +	/*
> +	 * rq->nr_running can't be used but an updated version without the
> +	 * impact of p on cpu must be used instead. The updated nr_running
> +	 * be computed and tested before calling idle_cpu_without().
> +	 */
> +
> +#ifdef CONFIG_SMP
> +	if (!llist_empty(&rq->wake_list))
> +		return 0;
> +#endif
> +
> +	return 1;
> +}
> +
> +/*
>    * update_sg_wakeup_stats - Update sched_group's statistics for wakeup.
> - * @denv: The ched_domain level to look for idlest group.
> + * @sd: The sched_domain level to look for idlest group.
>    * @group: sched_group whose statistics are to be updated.
>    * @sgs: variable to hold the statistics for this group.
> + * @p: The task for which we look for the idlest group/CPU.
>    */
>   static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>   					  struct sched_group *group,
> @@ -8133,21 +8208,22 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>   
>   	for_each_cpu(i, sched_group_span(group)) {
>   		struct rq *rq = cpu_rq(i);
> +		unsigned int local;
>   
> -		sgs->group_load += cpu_load(rq);
> +		sgs->group_load += cpu_load_without(rq, p);
>   		sgs->group_util += cpu_util_without(i, p);
> -		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
> +		local = task_running_on_cpu(i, p);
> +		sgs->sum_h_nr_running += rq->cfs.h_nr_running - local;
>   
> -		nr_running = rq->nr_running;
> +		nr_running = rq->nr_running - local;
>   		sgs->sum_nr_running += nr_running;
>   
>   		/*
> -		 * No need to call idle_cpu() if nr_running is not 0
> +		 * No need to call idle_cpu_without() if nr_running is not 0
>   		 */
> -		if (!nr_running && idle_cpu(i))
> +		if (!nr_running && idle_cpu_without(i, p))
>   			sgs->idle_cpus++;
>   
> -
>   	}
>   
>   	/* Check if task fits in the group */

