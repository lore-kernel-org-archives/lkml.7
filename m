Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF8FC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 22:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D042C206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 22:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfKPWox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 17:44:53 -0500
Received: from foss.arm.com ([217.140.110.172]:47144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfKPWox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 17:44:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 551CF31B;
        Sat, 16 Nov 2019 14:44:52 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 611D33F6C4;
        Sat, 16 Nov 2019 14:44:51 -0800 (PST)
Subject: Re: [GIT PULL] scheduler fixes
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191116213742.GA7450@gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ab6f2b5a-57f0-6723-c62f-91a8ce6eddac@arm.com>
Date:   Sat, 16 Nov 2019 22:44:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191116213742.GA7450@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/11/2019 21:37, Ingo Molnar wrote:
> Peter Zijlstra (1):
>       sched/core: Avoid spurious lock dependencies
> 
> Qais Yousef (1):
>       sched/uclamp: Fix incorrect condition
> 
> Valentin Schneider (2):
>       sched/uclamp: Fix overzealous type replacement

This one got a v2 (was missing one location), acked by Vincent:

  20191115103908.27610-1-valentin.schneider@arm.com

>       sched/topology, cpuset: Account for housekeeping CPUs to avoid empty cpumasks

And this one is no longer needed, as Michal & I understood (IOW the fix in
rc6 is sufficient), see:

  c425c5cb-ba8a-e5f6-d91c-5479779cfb7a@arm.com

> 
> Vincent Guittot (1):
>       sched/pelt: Fix update of blocked PELT ordering
> 
> 
>  kernel/cgroup/cpuset.c |  8 +++++++-
>  kernel/sched/core.c    |  9 +++++----
>  kernel/sched/fair.c    | 29 ++++++++++++++++++++---------
>  kernel/sched/sched.h   |  2 +-
>  4 files changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c87ee6412b36..e4c10785dc7c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -798,8 +798,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
>  		    cpumask_subset(cp->cpus_allowed, top_cpuset.effective_cpus))
>  			continue;
>  
> +		/*
> +		 * Skip cpusets that would lead to an empty sched domain.
> +		 * That could be because effective_cpus is empty, or because
> +		 * it's only spanning CPUs outside the housekeeping mask.
> +		 */
>  		if (is_sched_load_balance(cp) &&
> -		    !cpumask_empty(cp->effective_cpus))
> +		    cpumask_intersects(cp->effective_cpus,
> +				       housekeeping_cpumask(HK_FLAG_DOMAIN)))
>  			csa[csn++] = cp;
>  
>  		/* skip @cp's subtree if not a partition root */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0f2eb3629070..a4f76d3f5011 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -853,7 +853,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
>  }
>  
>  static inline
> -enum uclamp_id uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
> +unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
>  				   unsigned int clamp_value)
>  {
>  	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
> @@ -918,7 +918,7 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
>  	return uc_req;
>  }
>  
> -enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
> +unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
>  {
>  	struct uclamp_se uc_eff;
>  
> @@ -1065,7 +1065,7 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
>  	 * affecting a valid clamp bucket, the next time it's enqueued,
>  	 * it will already see the updated clamp bucket value.
>  	 */
> -	if (!p->uclamp[clamp_id].active) {
> +	if (p->uclamp[clamp_id].active) {
>  		uclamp_rq_dec_id(rq, p, clamp_id);
>  		uclamp_rq_inc_id(rq, p, clamp_id);
>  	}
> @@ -6019,10 +6019,11 @@ void init_idle(struct task_struct *idle, int cpu)
>  	struct rq *rq = cpu_rq(cpu);
>  	unsigned long flags;
>  
> +	__sched_fork(0, idle);
> +
>  	raw_spin_lock_irqsave(&idle->pi_lock, flags);
>  	raw_spin_lock(&rq->lock);
>  
> -	__sched_fork(0, idle);
>  	idle->state = TASK_RUNNING;
>  	idle->se.exec_start = sched_clock();
>  	idle->flags |= PF_IDLE;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 22a2fed29054..69a81a5709ff 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7547,6 +7547,19 @@ static void update_blocked_averages(int cpu)
>  	rq_lock_irqsave(rq, &rf);
>  	update_rq_clock(rq);
>  
> +	/*
> +	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
> +	 * that RT, DL and IRQ signals have been updated before updating CFS.
> +	 */
> +	curr_class = rq->curr->sched_class;
> +	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> +	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> +	update_irq_load_avg(rq, 0);
> +
> +	/* Don't need periodic decay once load/util_avg are null */
> +	if (others_have_blocked(rq))
> +		done = false;
> +
>  	/*
>  	 * Iterates the task_group tree in a bottom up fashion, see
>  	 * list_add_leaf_cfs_rq() for details.
> @@ -7574,14 +7587,6 @@ static void update_blocked_averages(int cpu)
>  			done = false;
>  	}
>  
> -	curr_class = rq->curr->sched_class;
> -	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> -	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> -	update_irq_load_avg(rq, 0);
> -	/* Don't need periodic decay once load/util_avg are null */
> -	if (others_have_blocked(rq))
> -		done = false;
> -
>  	update_blocked_load_status(rq, !done);
>  	rq_unlock_irqrestore(rq, &rf);
>  }
> @@ -7642,12 +7647,18 @@ static inline void update_blocked_averages(int cpu)
>  
>  	rq_lock_irqsave(rq, &rf);
>  	update_rq_clock(rq);
> -	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
>  
> +	/*
> +	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
> +	 * that RT, DL and IRQ signals have been updated before updating CFS.
> +	 */
>  	curr_class = rq->curr->sched_class;
>  	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
>  	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
>  	update_irq_load_avg(rq, 0);
> +
> +	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
> +
>  	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
>  	rq_unlock_irqrestore(rq, &rf);
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c8870c5bd7df..49ed949f850c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2309,7 +2309,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
>  #endif /* CONFIG_CPU_FREQ */
>  
>  #ifdef CONFIG_UCLAMP_TASK
> -enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
> +unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
>  
>  static __always_inline
>  unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
> 
