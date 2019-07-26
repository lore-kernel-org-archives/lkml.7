Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D4BC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D38322BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FodCm5BY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfGZJBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:01:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41480 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZJBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:01:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so31683161lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gyY7Zrf0Jsqz6rovd53nrayVDXMTVFSxxUVBnxucT7w=;
        b=FodCm5BYPh0fouXIR2YHkZhThrxi+Lo8XQAbp6oyotJjmxSrn77V2Ga865OMuMmYAx
         8n6EMEuGgXU+/z+0OZ2P+s9LVnL+Y3n764UfZhhVdg+oeIrEle58kJrSrdRxsg3pz92W
         W8v43VoSKS2FBfcfgULriOf7I08aelk4aZEzjpEhRC0Ls60NlRwsDIKhwr9rz1cX3DbO
         gkKwZKUBrlkNxqTPjMIe68Jf68rRTAMxDvpLrDSrtKTKLUKDnwstV3N2nAdQeUy3qV5v
         QLedwUthcs5NYRhqqpv2H7bVsMwAugZSBfNVuHMKzD/GO3rwmrjmqS9aKYr3O2XXBgYx
         Rn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gyY7Zrf0Jsqz6rovd53nrayVDXMTVFSxxUVBnxucT7w=;
        b=jm5uno7IZhVM4VIQa5flS+AKqrDhjkhLWfcKtP1xZ0Ypc6Xk6AkTO9eyh7F8H0aWrv
         gJ5zEUdcJaW4sBcue+MBMiM16rdVObJ+XcEXxutMwb5C09GhKUMhXSUJM0znxGhXkSsk
         mopS/BMYrZx6FML+Bzz3uiq8z8HmlxCE1tzto3Zt+M0E0ISP+G5C59/HiRAbbnHCInUn
         rMJryi9tj8j8vvwnLXMvrNVVgqIiMGIdMUpKMJifvZvquuiLwOB1AwEytL7NXULSLxlT
         h8Luwl435jMOKAQrF+T9wuv5cOM3Kzco84ZENVHzxmzcSJmsj7P11DgZ3vomQyStaFHX
         JVQQ==
X-Gm-Message-State: APjAAAUgLciKHuqjy+GkKRiGT33GFl+NEQDtAHrwI48VH6gmlYkYVwJU
        9KKMIvL91lFBuhXMvHAweKszNuDdM5Ma58tb/qZLCg==
X-Google-Smtp-Source: APXvYqyfOMdfCfkcvqN8lNAIt4EI0kP6EDCaXPoe+fl6twHkTv/8OW1TfuDDxwV+jBXXjN/akfbpWlA+Zw0SbXkEecI=
X-Received: by 2002:a19:ec15:: with SMTP id b21mr19288235lfa.32.1564131676571;
 Fri, 26 Jul 2019 02:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org> <d55f906e-6e91-9f49-5c2c-7ec2e6bd68b0@arm.com>
In-Reply-To: <d55f906e-6e91-9f49-5c2c-7ec2e6bd68b0@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 26 Jul 2019 11:01:05 +0200
Message-ID: <CAKfTPtD2hDxnHSaa5C_Jrtabb_ogJSgkLE=5UPyystKZqUmzWA@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
To:     Valentin Schneider <valentin.schneider@arm.com>
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

On Thu, 25 Jul 2019 at 19:17, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi Vincent,
>
> first batch of questions/comments here...
>
> On 19/07/2019 08:58, Vincent Guittot wrote:
> [...]
> >  kernel/sched/fair.c | 539 ++++++++++++++++++++++++++++------------------------
> >  1 file changed, 289 insertions(+), 250 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 67f0acd..472959df 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3771,7 +3771,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> >               return;
> >       }
> >
> > -     rq->misfit_task_load = task_h_load(p);
> > +     rq->misfit_task_load = task_util_est(p);
>
> Huh, interesting. Why go for utilization?

Mainly because that's what is used to detect a misfit task and not the load

>
> Right now we store the load of the task and use it to pick the "biggest"
> misfit (in terms of load) when there are more than one misfit tasks to
> choose:

But having a big load doesn't mean that you have a big utilization

so you can trig the misfit case because of task A with a big
utilization that doesn't fit to its local cpu. But then select a task
B in detach_tasks that has a small utilization but a big weight and as
a result a higher load
And task B will never trig the misfit UC by itself and should not
steal the pulling opportunity of task A

>
> update_sd_pick_busiest():
> ,----
> | /*
> |  * If we have more than one misfit sg go with the biggest misfit.
> |  */
> | if (sgs->group_type == group_misfit_task &&
> |     sgs->group_misfit_task_load < busiest->group_misfit_task_load)
> |       return false;
> `----
>
> I don't think it makes much sense to maximize utilization for misfit tasks:
> they're over the capacity margin, which exactly means "I can't really tell
> you much on that utilization other than it doesn't fit".
>
> At the very least, this rq field should be renamed "misfit_task_util".

yes. I agree that i should rename the field

>
> [...]
>
> > @@ -7060,12 +7048,21 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
> >  enum fbq_type { regular, remote, all };
> >
> >  enum group_type {
> > -     group_other = 0,
> > +     group_has_spare = 0,
> > +     group_fully_busy,
> >       group_misfit_task,
> > +     group_asym_capacity,
> >       group_imbalanced,
> >       group_overloaded,
> >  };
> >
> > +enum group_migration {
> > +     migrate_task = 0,
> > +     migrate_util,
> > +     migrate_load,
> > +     migrate_misfit,
>
> Can't we have only 3 imbalance types (task, util, load), and make misfit
> fall in that first one? Arguably it is a special kind of task balance,
> since it would go straight for the active balance, but it would fit a
> `migrate_task` imbalance with a "go straight for active balance" flag
> somewhere.

migrate_misfit uses its own special condition to detect the task that
can be pulled compared to the other ones

>
> [...]
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
> > +
> > +                     env->imbalance -= load;
> > +             } else  if (env->src_grp_type == migrate_util) {
> > +                     unsigned long util = task_util_est(p);
> > +
> > +                     if (util > env->imbalance)
> > +                             goto next;
> > +
> > +                     env->imbalance -= util;
> > +             } else if (env->src_grp_type == migrate_misfit) {
> > +                     unsigned long util = task_util_est(p);
> > +
> > +                     /*
> > +                      * utilization of misfit task might decrease a bit
> > +                      * since it has been recorded. Be conservative in the
> > +                      * condition.
> > +                      */
> > +                     if (2*util < env->imbalance)
> > +                             goto next;
>
> Other than I'm not convinced we should track utilization for misfit tasks,
> can the utilization of the task really be halved between the last
> update_misfit_status() and here?

No it's not but this margin is quite simple to compute and should
cover all cases:
It's high enough to filter others non misfit tasks and small enough to
cope with a decrease of the utilization of the misfit task since we
detected the UC

>
> > +
> > +                     env->imbalance = 0;
> > +             } else {
> > +                     /* Migrate task */
> > +                     env->imbalance--;
> > +             }
> >
> > -             if ((load / 2) > env->imbalance)
> > -                     goto next;
> >
> >               detach_task(p, env);
> >               list_add(&p->se.group_node, &env->tasks);
> >
> >               detached++;
> > -             env->imbalance -= load;
> >
> >  #ifdef CONFIG_PREEMPT
> >               /*
>
> [...]
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
>
> Rather than filling the local group, shouldn't we follow the same strategy
> as for load, IOW try to reach an average without pushing local above nor
> busiest below ?

But we don't know if this will be enough to make the busiest group not
overloaded anymore

This is a transient state:
a group is overloaded, another one has spare capacity
How to balance the system will depend of how much overload if in the
group and we don't know this value.
The only solution is to:
- try to pull as much task as possible to fill the spare capacity
- Is the group still overloaded ? use avg_load to balance the system
because both group will be overloaded
- Is the group no more overloaded ? balance the number of idle cpus

>
> We could build an sds->avg_util similar to sds->avg_load.

When there is spare capacity, we balances the number of idle cpus

>
> > +             }
> > +
> > +             env->imbalance = imbalance;
> > +             return;
> >       }
> [...]
> > +/*
> > + * Decision matrix according to the local and busiest group state
> > + *
> > + * busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
> > + * has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
> > + * fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
> > + * misfit_task      force     N/A        N/A    N/A  force      force
> > + * asym_capacity    force     force      N/A    N/A  force      force
> > + * imbalanced       force     force      N/A    N/A  force      force
> > + * overloaded       force     force      N/A    N/A  force      avg_load
> > + *
> > + * N/A :      Not Applicable because already filtered while updating
> > + *            statistics.
> > + * balanced : The system is balanced for these 2 groups.
> > + * force :    Calculate the imbalance as load migration is probably needed.
> > + * avg_load : Only if imbalance is significant enough.
> > + * nr_idle :  dst_cpu is not busy and the number of idle cpus is quite
> > + *            different in groups.
> > + */
> > +
>
> Nice!
