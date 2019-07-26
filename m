Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A484C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0411F20651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CVdRrrfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbfGZOnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:43:07 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:41887 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387471AbfGZOnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:43:07 -0400
Received: by mail-lf1-f50.google.com with SMTP id 62so32378991lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 07:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mpl77CvW7ME4wfikQ6cHmqgl+XeOAZuabji4KVrvTUA=;
        b=CVdRrrflhlNvbpwEZkHeBGp5GD1xutZ4G2Egj7r2L3MRTfN3UaEdiBxluPsgMg7mqr
         jpLYU/DFbNzt9UxtKA5eoPwTkB3OQUAEQ2WOb3Nvc2xv9eAr83Q5xW3TqC+HetPOst/7
         M/MLuLstQAdKYTPUlm2VPBGfk6+M8acp5aZGqCUAPDZUczG6gFbT86kpBGeNWHBwJeqo
         4cK8xqs2f9q2hVLaaGf1buBfDta/4bhq2iy0edYi+EVXJYzHTmj4Lu6STg/4py3wU5In
         iP1sMilNnUa5GFpIjiRNeD3FuLC0PuspqyZSWWjIKwwv6+pkOuFKWohbxb3jt8+Z40Kx
         rPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mpl77CvW7ME4wfikQ6cHmqgl+XeOAZuabji4KVrvTUA=;
        b=FNHJ2E0H+d02fAotV14d95M246ZY+t3kCFQkNFbmfBpZFZ170L8pT9xstHobaQYw9d
         CDTQy7sl/urTMUPi2y8MTylbZh2GLP/oHRrWaADWTh0IvHj7el6+agjS/suPF57hYtcu
         P4oj1vaGaEuW7/VukciGlQfv8rrjxUIyEE+mTb4WIU/eRUjYbZG69bXaAQ1qjzQYqFjd
         8agBdCOViUJsL0ntZBgAGXfJRpKycOKf1Mcqq0JL8n2Qw4N7BBaarGSkp8SN98q5Lflq
         5emKyv6EeZnGwVUjmlM6/2NBQxHIX16mgo1K610KbZQ2s+3Q5hzGjSnR3SymLRUPoc2g
         KM1g==
X-Gm-Message-State: APjAAAVDyKsyvLrkFaS1F472Sbk14HQZzVoMRQJInORURtWNCWusWf04
        wwSmE2qSkFez6484WCumDGWvfgmI4GO1cCqJAUR8QQ==
X-Google-Smtp-Source: APXvYqwVjt7RkRb/kghnlGzYUe0e5vuAe1TnxYOpo66g0IaFExVpy4sLLsh8IyWG919M7KolSFcFzXUAvEmhy4WGAjw=
X-Received: by 2002:ac2:5337:: with SMTP id f23mr45408944lfh.15.1564152184138;
 Fri, 26 Jul 2019 07:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org> <20190726135852.GB7168@linux.vnet.ibm.com>
In-Reply-To: <20190726135852.GB7168@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 26 Jul 2019 16:42:53 +0200
Message-ID: <CAKfTPtA7UKL4NJHkMTx=MgohbXqO6kJCwamEjBX-zu3nNO1XLA@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Phil Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 at 15:59, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> >
> > The type of sched_group has been extended to better reflect the type of
> > imbalance. We now have :
> >       group_has_spare
> >       group_fully_busy
> >       group_misfit_task
> >       group_asym_capacity
> >       group_imbalanced
> >       group_overloaded
>
> How is group_fully_busy different from group_overloaded?

group_fully_busy means that tasks have enough compute capacity whereas
group_overloaded means that tasks are competing to use the CPU and
need more compute capacity.
As an example:
a cpu is fully busy with 1 always running task
but a cpu is overloaded with 2 always running tasks or 2 task that
want 75% of the CPU as an example

>
> >
> > Based on the type fo sched_group, load_balance now sets what it wants to
> > move in order to fix the imnbalance. It can be some load as before but
> > also some utilization, a number of task or a type of task:
> >       migrate_task
> >       migrate_util
> >       migrate_load
> >       migrate_misfit
>
> Can we club migrate_util and migrate_misfit?

migrate_misfit want to move 1 task whereas migrate_util want to
migrate an amount of utilization which can lead to migrate several
tasks

>
> > @@ -7361,19 +7357,46 @@ static int detach_tasks(struct lb_env *env)
> >               if (!can_migrate_task(p, env))
> >                       goto next;
> >
> > -             load = task_h_load(p);
> > +             if (env->src_grp_type == migrate_load) {
> > +                     unsigned long load = task_h_load(p);
> >
> > -             if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
> > -                     goto next;
> > +                     if (sched_feat(LB_MIN) &&
> > +                         load < 16 && !env->sd->nr_balance_failed)
> > +                             goto next;
> > +
> > +                     if ((load / 2) > env->imbalance)
> > +                             goto next;
>
> I know this existed before too but if the load is exactly or around 2x of
> env->imbalance, the resultant imbalance after the load balance operation
> would still be around env->imbalance. We may lose some cache affinity too.
>
> Can we do something like.
>                 if (2 * load > 3 * env->imbalance)
>                         goto next;

TBH, I don't know what should be the best value and it's probably
worth doing some investigation but i would prefer to do that as a
separate patch to get a similar behavior in the overloaded case
Why do you propose 3/2 instead of 2 ?

>
> > @@ -7690,14 +7711,14 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
> >       *sds = (struct sd_lb_stats){
> >               .busiest = NULL,
> >               .local = NULL,
> > -             .total_running = 0UL,
> >               .total_load = 0UL,
> >               .total_capacity = 0UL,
> >               .busiest_stat = {
> >                       .avg_load = 0UL,
> >                       .sum_nr_running = 0,
> >                       .sum_h_nr_running = 0,
> > -                     .group_type = group_other,
> > +                     .idle_cpus = UINT_MAX,
>
> Why are we initializing idle_cpus to UINT_MAX? Shouldnt this be set to 0?

This is the default busiest statistics attached to env

> I only see an increment and compare.

In update_sd_pick_busiest(), we look for the group_has_spare_capacity
with lowest number of idle cpus which we expect to be the busiest.
So the 1st group with spare capacity will have for sure less idle_cpus
and will replace the default one

>
> > +                     .group_type = group_has_spare,
> >               },
> >       };
> >  }
> >
> >  static inline enum
> > -group_type group_classify(struct sched_group *group,
> > +group_type group_classify(struct lb_env *env,
> > +                       struct sched_group *group,
> >                         struct sg_lb_stats *sgs)
> >  {
> > -     if (sgs->group_no_capacity)
> > +     if (group_is_overloaded(env, sgs))
> >               return group_overloaded;
> >
> >       if (sg_imbalanced(group))
> > @@ -7953,7 +7975,13 @@ group_type group_classify(struct sched_group *group,
> >       if (sgs->group_misfit_task_load)
> >               return group_misfit_task;
> >
> > -     return group_other;
> > +     if (sgs->group_asym_capacity)
> > +             return group_asym_capacity;
> > +
> > +     if (group_has_capacity(env, sgs))
> > +             return group_has_spare;
> > +
> > +     return group_fully_busy;
>
> If its not overloaded but also doesnt have capacity.
> Does it mean its capacity is completely filled.
> Cant we consider that as same as overloaded?

I have answered to this in the 1st question

>
> >  }
> >
> >
> > -     if (sgs->sum_h_nr_running)
> > -             sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
> > +     sgs->group_capacity = group->sgc->capacity;
> >
> >       sgs->group_weight = group->group_weight;
> >
> > -     sgs->group_no_capacity = group_is_overloaded(env, sgs);
> > -     sgs->group_type = group_classify(group, sgs);
> > +     sgs->group_type = group_classify(env, group, sgs);
> > +
> > +     /* Computing avg_load makes sense only when group is overloaded */
> > +     if (sgs->group_type != group_overloaded)
> > +             sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) /
> > +                             sgs->group_capacity;
>
> Mismatch in comment and code?

I may need to add more comments but at this step, the group should be
either overloaded or fully busy but it can also be imbalanced.
In case of a group fully busy or imbalanced (sgs->group_type !=
group_overloaded), we haven't computed avg_load yet so we have to do
so because:
-In the case of fully_busy, we are going to be overloaded which the
next step after fully busy when you are about to pull more load
-In case of imbalance, we don't know the real state of the local group
so we fall back to this default behavior

>
> > @@ -8079,11 +8120,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >       if (sgs->group_type < busiest->group_type)
> >               return false;
> >
> > -     if (sgs->avg_load <= busiest->avg_load)
> > +     /* Select the overloaded group with highest avg_load */
> > +     if (sgs->group_type == group_overloaded &&
> > +         sgs->avg_load <= busiest->avg_load)
> > +             return false;
> > +
> > +     /* Prefer to move from lowest priority CPU's work */
> > +     if (sgs->group_type == group_asym_capacity && sds->busiest &&
> > +         sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
> >               return false;
>
> I thought this should have been
>         /* Prefer to move from lowest priority CPU's work */
>         if (sgs->group_type == group_asym_capacity && sds->busiest &&
>             sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
>                 return true;

Here we want to select the "busiest" group_asym_capacity which means
the one with the lowest priority
If sg->asym_prefer_cpu is prefered to be used instead of
sds->busiest->asym_prefer_cpu, we should keep busiest as the group to
be emptied and return false to not replace the latter

>
> > @@ -8357,72 +8318,115 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >       if (busiest->group_type == group_imbalanced) {
> >               /*
> >                * In the group_imb case we cannot rely on group-wide averages
> > -              * to ensure CPU-load equilibrium, look at wider averages. XXX
> > +              * to ensure CPU-load equilibrium, try to move any task to fix
> > +              * the imbalance. The next load balance will take care of
> > +              * balancing back the system.
> >                */
> > -             busiest->load_per_task =
> > -                     min(busiest->load_per_task, sds->avg_load);
> > +             env->src_grp_type = migrate_task;
> > +             env->imbalance = 1;
> > +             return;
> >       }
> >
> > -     /*
> > -      * Avg load of busiest sg can be less and avg load of local sg can
> > -      * be greater than avg load across all sgs of sd because avg load
> > -      * factors in sg capacity and sgs with smaller group_type are
> > -      * skipped when updating the busiest sg:
> > -      */
> > -     if (busiest->group_type != group_misfit_task &&
> > -         (busiest->avg_load <= sds->avg_load ||
> > -          local->avg_load >= sds->avg_load)) {
> > -             env->imbalance = 0;
> > -             return fix_small_imbalance(env, sds);
> > +     if (busiest->group_type == group_misfit_task) {
> > +             /* Set imbalance to allow misfit task to be balanced. */
> > +             env->src_grp_type = migrate_misfit;
> > +             env->imbalance = busiest->group_misfit_task_load;
> > +             return;
> >       }
> >
> >       /*
> > -      * If there aren't any idle CPUs, avoid creating some.
> > +      * Try to use spare capacity of local group without overloading it or
> > +      * emptying busiest
> >        */
> > -     if (busiest->group_type == group_overloaded &&
> > -         local->group_type   == group_overloaded) {
> > -             load_above_capacity = busiest->sum_h_nr_running * SCHED_CAPACITY_SCALE;
> > -             if (load_above_capacity > busiest->group_capacity) {
> > -                     load_above_capacity -= busiest->group_capacity;
> > -                     load_above_capacity *= scale_load_down(NICE_0_LOAD);
> > -                     load_above_capacity /= busiest->group_capacity;
> > -             } else
> > -                     load_above_capacity = ~0UL;
> > +     if (local->group_type == group_has_spare) {
> > +             long imbalance;
> > +
> > +             /*
> > +              * If there is no overload, we just want to even the number of
> > +              * idle cpus.
> > +              */
> > +             env->src_grp_type = migrate_task;
> > +             imbalance = max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1);
>
> Shouldnt this be?
>                 imbalance = max_t(long, 0, (busiest->idle_cpus - local->idle_cpus) >> 1);

local has more idle_cpus than busiest otherwise we don't try to pull task

> > +
> > +             if (sds->prefer_sibling)
> > +                     /*
> > +                      * When prefer sibling, evenly spread running tasks on
> > +                      * groups.
> > +                      */
> > +                     imbalance = (busiest->sum_nr_running - local->sum_nr_running) >> 1;
> > +
> > +             if (busiest->group_type > group_fully_busy) {
> > +                     /*
> > +                      * If busiest is overloaded, try to fill spare
> > +                      * capacity. This might end up creating spare capacity
> > +                      * in busiest or busiest still being overloaded but
> > +                      * there is no simple way to directly compute the
> > +                      * amount of load to migrate in order to balance the
> > +                      * system.
> > +                      */
> > +                     env->src_grp_type = migrate_util;
> > +                     imbalance = max(local->group_capacity, local->group_util) -
> > +                                 local->group_util;
> > +             }
> > +
> > +             env->imbalance = imbalance;
> > +             return;
> >       }
> >
> >       /*
> > -      * We're trying to get all the CPUs to the average_load, so we don't
> > -      * want to push ourselves above the average load, nor do we wish to
> > -      * reduce the max loaded CPU below the average load. At the same time,
> > -      * we also don't want to reduce the group load below the group
> > -      * capacity. Thus we look for the minimum possible imbalance.
> > +      * Local is fully busy but have to take more load to relieve the
> > +      * busiest group
> >        */
> > -     max_pull = min(busiest->avg_load - sds->avg_load, load_above_capacity);
> > +     if (local->group_type < group_overloaded) {
>
>
> What action are we taking if we find the local->group_type to be group_imbalanced
> or group_misfit ?  We will fall here but I dont know if it right to look for
> avg_load in that case.

local->group_type can't be misfit
For local->group_type is imbalance , I answered in a previous comment

>
> > +             /*
> > +              * Local will become overvloaded so the avg_load metrics are
> > +              * finally needed
> > +              */
> >
> > -     /* How much load to actually move to equalise the imbalance */
> > -     env->imbalance = min(
> > -             max_pull * busiest->group_capacity,
> > -             (sds->avg_load - local->avg_load) * local->group_capacity
> > -     ) / SCHED_CAPACITY_SCALE;
> > +             local->avg_load = (local->group_load*SCHED_CAPACITY_SCALE)
> > +                                             / local->group_capacity;
> >
> > -     /* Boost imbalance to allow misfit task to be balanced. */
> > -     if (busiest->group_type == group_misfit_task) {
> > -             env->imbalance = max_t(long, env->imbalance,
> > -                                    busiest->group_misfit_task_load);
> > +             sds->avg_load = (SCHED_CAPACITY_SCALE * sds->total_load)
> > +                                             / sds->total_capacity;
> >       }
> >
> >       /*
> > -      * if *imbalance is less than the average load per runnable task
> > -      * there is no guarantee that any tasks will be moved so we'll have
> > -      * a think about bumping its value to force at least one task to be
> > -      * moved
> > +      * Both group are or will become overloaded and we're trying to get
> > +      * all the CPUs to the average_load, so we don't want to push
> > +      * ourselves above the average load, nor do we wish to reduce the
> > +      * max loaded CPU below the average load. At the same time, we also
> > +      * don't want to reduce the group load below the group capacity.
> > +      * Thus we look for the minimum possible imbalance.
> >        */
> > -     if (env->imbalance < busiest->load_per_task)
> > -             return fix_small_imbalance(env, sds);
> > +     env->src_grp_type = migrate_load;
> > +     env->imbalance = min(
> > +             (busiest->avg_load - sds->avg_load) * busiest->group_capacity,
> > +             (sds->avg_load - local->avg_load) * local->group_capacity
> > +     ) / SCHED_CAPACITY_SCALE;
> >  }
>
> We calculated avg_load for !group_overloaded case, but seem to be using for
> group_overloaded cases too.

for group_overloaded case, we already computed it in update_sg_lb_stats()

>
>
> --
> Thanks and Regards
> Srikar Dronamraju
>
