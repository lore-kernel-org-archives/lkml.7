Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8F0C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7836420715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKVOh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:37:58 -0500
Received: from foss.arm.com ([217.140.110.172]:48302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfKVOh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:37:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 510CDFEC;
        Fri, 22 Nov 2019 06:37:57 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE48D3F703;
        Fri, 22 Nov 2019 06:37:55 -0800 (PST)
Subject: Re: [PATCH] sched/fair: fix rework of find_idlest_group()
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        riel@surriel.com, rong.a.chen@intel.com
References: <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
 <1571762798-25900-1-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <2bb75047-4a93-4f1d-e2ff-99c499b5a070@arm.com>
Date:   Fri, 22 Nov 2019 14:37:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571762798-25900-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

I took the liberty of adding some commenting nits in my review. I
know this is already in tip, but as Mel pointed out this should be merged
with the rework when sent out to mainline (similar to the removal of
fix_small_imbalance() & the LB rework).

On 22/10/2019 17:46, Vincent Guittot wrote:
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
>  kernel/sched/fair.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 83 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a81c364..0ad4b21 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5379,6 +5379,36 @@ static unsigned long cpu_load(struct rq *rq)
>  {
>  	return cfs_rq_load_avg(&rq->cfs);
>  }
> +/*
> + * cpu_load_without - compute cpu load without any contributions from *p
> + * @cpu: the CPU which load is requested
> + * @p: the task which load should be discounted

For both @cpu and @p, s/which/whose/ (also applies to cpu_util_without()
which inspired this).

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

s/util/load

> +	lsub_positive(&load, task_h_load(p));
> +
> +	return load;
> +}
>  
>  static unsigned long capacity_of(int cpu)
>  {
> @@ -8117,10 +8147,55 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
>  struct sg_lb_stats;
>  
>  /*
> + * task_running_on_cpu - return 1 if @p is running on @cpu.
> + */
> +
> +static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
          ^^^^^^^^^^^^
That could very well be bool, right?


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
          ^^^
Ditto on the boolean return values

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
>   * update_sg_wakeup_stats - Update sched_group's statistics for wakeup.
> - * @denv: The ched_domain level to look for idlest group.
> + * @sd: The sched_domain level to look for idlest group.
>   * @group: sched_group whose statistics are to be updated.
>   * @sgs: variable to hold the statistics for this group.
> + * @p: The task for which we look for the idlest group/CPU.
>   */
>  static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>  					  struct sched_group *group,
