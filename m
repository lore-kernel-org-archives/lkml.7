Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB504ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13B92168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbfJAQxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:53:08 -0400
Received: from foss.arm.com ([217.140.110.172]:54182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfJAQxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:53:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FB2E337;
        Tue,  1 Oct 2019 09:53:05 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C81543F706;
        Tue,  1 Oct 2019 09:53:03 -0700 (PDT)
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <9bfb3252-c268-8c0c-9c72-65f872e9c8b2@arm.com>
 <CAKfTPtDUFMFnD+RZndx0+8A+V9HV9Hv0TN+p=mAge0VsqS6xmA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <3dca46c5-c395-e2b3-a7e8-e9208ba741c8@arm.com>
Date:   Tue, 1 Oct 2019 18:52:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDUFMFnD+RZndx0+8A+V9HV9Hv0TN+p=mAge0VsqS6xmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2019 10:14, Vincent Guittot wrote:
> On Mon, 30 Sep 2019 at 18:24, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> Hi Vincent,
>>
>> On 19/09/2019 09:33, Vincent Guittot wrote:

[...]

>>> @@ -7347,7 +7362,7 @@ static int detach_tasks(struct lb_env *env)
>>>   {
>>>         struct list_head *tasks = &env->src_rq->cfs_tasks;
>>>         struct task_struct *p;
>>> -     unsigned long load;
>>> +     unsigned long util, load;
>>
>> Minor: Order by length or reduce scope to while loop ?
> 
> I don't get your point here

Nothing dramatic here! Just

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d0c3aa1dc290..a08f342ead89 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7333,8 +7333,8 @@ static const unsigned int sched_nr_migrate_break = 32;
 static int detach_tasks(struct lb_env *env)
 {
        struct list_head *tasks = &env->src_rq->cfs_tasks;
-       struct task_struct *p;
        unsigned long load, util;
+       struct task_struct *p;
        int detached = 0;

        lockdep_assert_held(&env->src_rq->lock);

or

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d0c3aa1dc290..4d1864d43ed7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7334,7 +7334,6 @@ static int detach_tasks(struct lb_env *env)
 {
        struct list_head *tasks = &env->src_rq->cfs_tasks;
        struct task_struct *p;
-       unsigned long load, util;
        int detached = 0;

        lockdep_assert_held(&env->src_rq->lock);
@@ -7343,6 +7342,8 @@ static int detach_tasks(struct lb_env *env)
                return 0;

        while (!list_empty(tasks)) {
+               unsigned long load, util;
+
                /*

[...]

>>> @@ -8042,14 +8104,24 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>>                 }
>>>         }
>>>
>>> -     /* Adjust by relative CPU capacity of the group */
>>> +     /* Check if dst cpu is idle and preferred to this group */
>>
>> s/preferred to/preferred by ? or the preferred CPU of this group ?
> 
> dst cpu doesn't belong to this group. We compare asym_prefer_cpu of
> this group vs dst_cpu which belongs to another group

Ah, in the sense of 'preferred over'. Got it now!

[...]

>>> +     if (busiest->group_type == group_imbalanced) {
>>> +             /*
>>> +              * In the group_imb case we cannot rely on group-wide averages
>>> +              * to ensure CPU-load equilibrium, try to move any task to fix
>>> +              * the imbalance. The next load balance will take care of
>>> +              * balancing back the system.
>>
>> balancing back ?
> 
> In case of imbalance, we don't try to balance the system but only try
> to get rid of the pinned tasks problem. The system will still be
> unbalanced after the migration and the next load balance will take
> care of balancing the system

OK.

[...]

>>>         /*
>>> -      * Avg load of busiest sg can be less and avg load of local sg can
>>> -      * be greater than avg load across all sgs of sd because avg load
>>> -      * factors in sg capacity and sgs with smaller group_type are
>>> -      * skipped when updating the busiest sg:
>>> +      * Try to use spare capacity of local group without overloading it or
>>> +      * emptying busiest
>>>          */
>>> -     if (busiest->group_type != group_misfit_task &&
>>> -         (busiest->avg_load <= sds->avg_load ||
>>> -          local->avg_load >= sds->avg_load)) {
>>> -             env->imbalance = 0;
>>> +     if (local->group_type == group_has_spare) {
>>> +             if (busiest->group_type > group_fully_busy) {
>>
>> So this could be 'busiest->group_type == group_overloaded' here to match
>> the comment below? Since you handle group_misfit_task,
>> group_asym_packing, group_imbalanced above and return.
> 
> This is just to be more robust in case some new states are added later

OK, although I doubt that additional states can be added easily w/o
carefully auditing the entire lb code ;-)

[...]

>>> +             if (busiest->group_weight == 1 || sds->prefer_sibling) {
>>> +                     /*
>>> +                      * When prefer sibling, evenly spread running tasks on
>>> +                      * groups.
>>> +                      */
>>> +                     env->balance_type = migrate_task;
>>> +                     env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
>>> +                     return;
>>> +             }
>>> +
>>> +             /*
>>> +              * If there is no overload, we just want to even the number of
>>> +              * idle cpus.
>>> +              */
>>> +             env->balance_type = migrate_task;
>>> +             env->imbalance = max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1);
>>
>> Why do we need a max_t(long, 0, ...) here and not for the 'if
>> (busiest->group_weight == 1 || sds->prefer_sibling)' case?
> 
> For env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
> 
> either we have sds->prefer_sibling && busiest->sum_nr_running >
> local->sum_nr_running + 1

I see, this corresponds to

/* Try to move all excess tasks to child's sibling domain */
       if (sds.prefer_sibling && local->group_type == group_has_spare &&
           busiest->sum_h_nr_running > local->sum_h_nr_running + 1)
               goto force_balance;

in find_busiest_group, I assume.

Haven't been able to recreate this yet on my arm64 platform since there
is no prefer_sibling and in case local and busiest have
group_type=group_has_spare they bailout in

         if (busiest->group_type != group_overloaded &&
              (env->idle == CPU_NOT_IDLE ||
               local->idle_cpus <= (busiest->idle_cpus + 1)))
                 goto out_balanced;


[...]

>>> -     if (busiest->group_type == group_overloaded &&
>>> -         local->group_type   == group_overloaded) {
>>> -             load_above_capacity = busiest->sum_h_nr_running * SCHED_CAPACITY_SCALE;
>>> -             if (load_above_capacity > busiest->group_capacity) {
>>> -                     load_above_capacity -= busiest->group_capacity;
>>> -                     load_above_capacity *= scale_load_down(NICE_0_LOAD);
>>> -                     load_above_capacity /= busiest->group_capacity;
>>> -             } else
>>> -                     load_above_capacity = ~0UL;
>>> +     if (local->group_type < group_overloaded) {
>>> +             /*
>>> +              * Local will become overloaded so the avg_load metrics are
>>> +              * finally needed.
>>> +              */
>>
>> How does this relate to the decision_matrix[local, busiest] (dm[])? E.g.
>> dm[overload, overload] == avg_load or dm[fully_busy, overload] == force.
>> It would be nice to be able to match all allowed fields of dm to code sections.
> 
> decision_matrix describes how it decides between balanced or unbalanced.
> In case of dm[overload, overload], we use the avg_load to decide if it
> is balanced or not

OK, that's why you calculate sgs->avg_load in update_sg_lb_stats() only
for 'sgs->group_type == group_overloaded'.

> In case of dm[fully_busy, overload], the groups are unbalanced because
> fully_busy < overload and we force the balance. Then
> calculate_imbalance() uses the avg_load to decide how much will be
> moved

And in this case 'local->group_type < group_overloaded' in
calculate_imbalance(), 'local->avg_load' and 'sds->avg_load' have to be
calculated before using them in env->imbalance = min(...).

OK, got it now.

> dm[overload, overload]=force means that we force the balance and we
> will compute later the imbalance. avg_load may be used to calculate
> the imbalance
> dm[overload, overload]=avg_load means that we compare the avg_load to
> decide whether we need to balance load between groups
> dm[overload, overload]=nr_idle means that we compare the number of
> idle cpus to decide whether we need to balance.  In fact this is no
> more true with patch 7 because we also take into account the number of
> nr_h_running when weight =1

This becomes clearer now ... slowly.

[...]
