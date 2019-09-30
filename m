Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CE8C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8998B2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbfI3QY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:24:28 -0400
Received: from foss.arm.com ([217.140.110.172]:57852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfI3QY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:24:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 522761000;
        Mon, 30 Sep 2019 09:24:27 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 201AB3F534;
        Mon, 30 Sep 2019 09:24:23 -0700 (PDT)
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <9bfb3252-c268-8c0c-9c72-65f872e9c8b2@arm.com>
Date:   Mon, 30 Sep 2019 18:24:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 19/09/2019 09:33, Vincent Guittot wrote:

these are just some comments & questions based on a code study. Haven't
run any tests with it yet.

[...]

> The type of sched_group has been extended to better reflect the type of
> imbalance. We now have :
>         group_has_spare
>         group_fully_busy
>         group_misfit_task
>         group_asym_capacity

s/group_asym_capacity/group_asym_packing

>         group_imbalanced
>         group_overloaded
>
> Based on the type fo sched_group, load_balance now sets what it wants to

s/fo/for

> move in order to fix the imbalance. It can be some load as before but also
> some utilization, a number of task or a type of task:
>         migrate_task
>         migrate_util
>         migrate_load
>         migrate_misfit
>
> This new load_balance algorithm fixes several pending wrong tasks
> placement:
> - the 1 task per CPU case with asymmetrics system

s/asymmetrics/asymmetric

This stands for ASYM_CPUCAPACITY and ASYM_PACKING, right?

[...]

>   #define LBF_ALL_PINNED       0x01
> @@ -7115,7 +7130,7 @@ struct lb_env {
>         unsigned int            loop_max;
>  
>         enum fbq_type           fbq_type;
> -     enum group_type         src_grp_type;
> +     enum migration_type     balance_type;

Minor thing:

Why not
     enum migration_type migration_type;
or
     enum balance_type balance_type;

We do the same for other enums like fbq_type or group_type.

>         struct list_head        tasks;
>   };
>  

The detach_tasks() comment still mentions only runnable load.

> @@ -7347,7 +7362,7 @@ static int detach_tasks(struct lb_env *env)
>   {
>         struct list_head *tasks = &env->src_rq->cfs_tasks;
>         struct task_struct *p;
> -     unsigned long load;
> +     unsigned long util, load;

Minor: Order by length or reduce scope to while loop ?

>         int detached = 0;
>  
>         lockdep_assert_held(&env->src_rq->lock);
> @@ -7380,19 +7395,53 @@ static int detach_tasks(struct lb_env *env)
>                 if (!can_migrate_task(p, env))
>                         goto next;
>  
> -             load = task_h_load(p);
> +             switch (env->balance_type) {
> +             case migrate_load:
> +                     load = task_h_load(p);
>  
> -             if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
> -                     goto next;
> +                     if (sched_feat(LB_MIN) &&
> +                         load < 16 && !env->sd->nr_balance_failed)
> +                             goto next;
>  
> -             if ((load / 2) > env->imbalance)
> -                     goto next;
> +                     if ((load / 2) > env->imbalance)
> +                             goto next;
> +
> +                     env->imbalance -= load;
> +                     break;
> +
> +             case migrate_util:
> +                     util = task_util_est(p);
> +
> +                     if (util > env->imbalance)
> +                             goto next;
> +
> +                     env->imbalance -= util;
> +                     break;
> +
> +             case migrate_task:
> +                     /* Migrate task */

Minor: IMHO, this comment is not necessary.

> +                     env->imbalance--;
> +                     break;
> +
> +             case migrate_misfit:
> +                     load = task_h_load(p);
> +
> +                     /*
> +                      * utilization of misfit task might decrease a bit

This patch still uses load. IMHO this comments becomes true only with 08/10.

[...]

> @@ -7707,13 +7755,11 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
>         *sds = (struct sd_lb_stats){
>                 .busiest = NULL,
>                 .local = NULL,
> -             .total_running = 0UL,
>                 .total_load = 0UL,
>                 .total_capacity = 0UL,
>                 .busiest_stat = {
> -                     .avg_load = 0UL,

There is a sentence in the comment above explaining why avg_load has to
be cleared. And IMHO local group isn't cleared anymore but set/initialized.

> -                     .sum_h_nr_running = 0,
> -                     .group_type = group_other,
> +                     .idle_cpus = UINT_MAX,
> +                     .group_type = group_has_spare,
>                 },
>         };
>   }

[...]

> @@ -8042,14 +8104,24 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 }
>         }
>  
> -     /* Adjust by relative CPU capacity of the group */
> +     /* Check if dst cpu is idle and preferred to this group */

s/preferred to/preferred by ? or the preferred CPU of this group ?

[...]

> @@ -8283,69 +8363,133 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>    */
>   static inline void calculate_imbalance(struct lb_env *env, struct
sd_lb_stats *sds)
>   {
> -     unsigned long max_pull, load_above_capacity = ~0UL;
>         struct sg_lb_stats *local, *busiest;
>  
>         local = &sds->local_stat;
>         busiest = &sds->busiest_stat;
>  
> -     if (busiest->group_asym_packing) {
> +     if (busiest->group_type == group_misfit_task) {
> +             /* Set imbalance to allow misfit task to be balanced. */
> +             env->balance_type = migrate_misfit;
> +             env->imbalance = busiest->group_misfit_task_load;
> +             return;
> +     }
> +
> +     if (busiest->group_type == group_asym_packing) {
> +             /*
> +              * In case of asym capacity, we will try to migrate all load to

Does asym capacity stands for asym packing or asym cpu capacity?

> +              * the preferred CPU.
> +              */
> +             env->balance_type = migrate_load;
>                 env->imbalance = busiest->group_load;
>                 return;
>         }
>  
> +     if (busiest->group_type == group_imbalanced) {
> +             /*
> +              * In the group_imb case we cannot rely on group-wide averages
> +              * to ensure CPU-load equilibrium, try to move any task to fix
> +              * the imbalance. The next load balance will take care of
> +              * balancing back the system.

balancing back ?

> +              */
> +             env->balance_type = migrate_task;
> +             env->imbalance = 1;
> +             return;
> +     }
> +
>         /*
> -      * Avg load of busiest sg can be less and avg load of local sg can
> -      * be greater than avg load across all sgs of sd because avg load
> -      * factors in sg capacity and sgs with smaller group_type are
> -      * skipped when updating the busiest sg:
> +      * Try to use spare capacity of local group without overloading it or
> +      * emptying busiest
>          */
> -     if (busiest->group_type != group_misfit_task &&
> -         (busiest->avg_load <= sds->avg_load ||
> -          local->avg_load >= sds->avg_load)) {
> -             env->imbalance = 0;
> +     if (local->group_type == group_has_spare) {
> +             if (busiest->group_type > group_fully_busy) {

So this could be 'busiest->group_type == group_overloaded' here to match
the comment below? Since you handle group_misfit_task,
group_asym_packing, group_imbalanced above and return.

> +                     /*
> +                      * If busiest is overloaded, try to fill spare
> +                      * capacity. This might end up creating spare capacity
> +                      * in busiest or busiest still being overloaded but
> +                      * there is no simple way to directly compute the
> +                      * amount of load to migrate in order to balance the
> +                      * system.
> +                      */
> +                     env->balance_type = migrate_util;
> +                     env->imbalance = max(local->group_capacity, local->group_util) -
> +                                 local->group_util;
> +                     return;
> +             }
> +
> +             if (busiest->group_weight == 1 || sds->prefer_sibling) {
> +                     /*
> +                      * When prefer sibling, evenly spread running tasks on
> +                      * groups.
> +                      */
> +                     env->balance_type = migrate_task;
> +                     env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
> +                     return;
> +             }
> +
> +             /*
> +              * If there is no overload, we just want to even the number of
> +              * idle cpus.
> +              */
> +             env->balance_type = migrate_task;
> +             env->imbalance = max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1);

Why do we need a max_t(long, 0, ...) here and not for the 'if
(busiest->group_weight == 1 || sds->prefer_sibling)' case?

>                 return;
>         }
>  
>         /*
> -      * If there aren't any idle CPUs, avoid creating some.
> +      * Local is fully busy but have to take more load to relieve the

s/have/has

> +      * busiest group
>          */

I thought that 'local->group_type == group_imbalanced' is allowed as
well? So 'if (local->group_type < group_overloaded)' (further down)
could include that?

> -     if (busiest->group_type == group_overloaded &&
> -         local->group_type   == group_overloaded) {
> -             load_above_capacity = busiest->sum_h_nr_running * SCHED_CAPACITY_SCALE;
> -             if (load_above_capacity > busiest->group_capacity) {
> -                     load_above_capacity -= busiest->group_capacity;
> -                     load_above_capacity *= scale_load_down(NICE_0_LOAD);
> -                     load_above_capacity /= busiest->group_capacity;
> -             } else
> -                     load_above_capacity = ~0UL;
> +     if (local->group_type < group_overloaded) {
> +             /*
> +              * Local will become overloaded so the avg_load metrics are
> +              * finally needed.
> +              */

How does this relate to the decision_matrix[local, busiest] (dm[])? E.g.
dm[overload, overload] == avg_load or dm[fully_busy, overload] == force.
It would be nice to be able to match all allowed fields of dm to code sections.

[...]

>   /******* find_busiest_group() helpers end here *********************/
>  
> +/*
> + * Decision matrix according to the local and busiest group state

Minor s/state/type ?

> + *
> + * busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
> + * has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
> + * fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
> + * misfit_task      force     N/A        N/A    N/A  force      force
> + * asym_capacity    force     force      N/A    N/A  force      force

s/asym_capacity/asym_packing

> + * imbalanced       force     force      N/A    N/A  force      force
> + * overloaded       force     force      N/A    N/A  force      avg_load
> + *
> + * N/A :      Not Applicable because already filtered while updating
> + *            statistics.
> + * balanced : The system is balanced for these 2 groups.
> + * force :    Calculate the imbalance as load migration is probably needed.
> + * avg_load : Only if imbalance is significant enough.
> + * nr_idle :  dst_cpu is not busy and the number of idle cpus is quite
> + *            different in groups.
> + */
> +
>   /**
>    * find_busiest_group - Returns the busiest group within the sched_domain
>    * if there is an imbalance.
> @@ -8380,17 +8524,17 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>         local = &sds.local_stat;
>         busiest = &sds.busiest_stat;
>  
> -     /* ASYM feature bypasses nice load balance check */
> -     if (busiest->group_asym_packing)
> -             goto force_balance;
> -
>         /* There is no busy sibling group to pull tasks from */
> -     if (!sds.busiest || busiest->sum_h_nr_running == 0)
> +     if (!sds.busiest)
>                 goto out_balanced;
>  
> -     /* XXX broken for overlapping NUMA groups */
> -     sds.avg_load = (SCHED_CAPACITY_SCALE * sds.total_load)
> -                                             / sds.total_capacity;
> +     /* Misfit tasks should be dealt with regardless of the avg load */
> +     if (busiest->group_type == group_misfit_task)
> +             goto force_balance;
> +
> +     /* ASYM feature bypasses nice load balance check */

Minor: s/ASYM feature/ASYM_PACKING ... to distinguish clearly from
ASYM_CPUCAPACITY.

> +     if (busiest->group_type == group_asym_packing)
> +             goto force_balance;

[...]

