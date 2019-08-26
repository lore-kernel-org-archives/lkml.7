Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41430C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E905C21852
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uK3fx+mV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbfHZKLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:11:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39258 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfHZKLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:11:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id x3so11830984lfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASUhQbZZWnwMdFOtlf7q/5Hj+QucvRub8AGF+NJYF2M=;
        b=uK3fx+mVHJqAO29QK5nD6+1i44iQMBJqMTTzRyk3i38eWJ+cb91s4Hg//gzh61wHqK
         8cSkvjB4UjqNAYNTToIUTNkBE+g+kR9Wm5SyDIRrNZOvdLjUPLLsIGeHaBdL+nhu5iiE
         P6KA5HfUyy6/aNrA+Ft9N/OdvBXzh9Cvqqhv4Jcb83Df190PQTJDSi/Qg6U9+QYRBN3C
         9BVJgHN12oTRDSVl6tAMjKU7RokQKzrDlTA7bUf7/UIdd3lf9HPJHhniW3AQvIL4M4qM
         zEwHEe754ksbJ+qyYglI5FwKusPSXOMa8Ziwj/o5kyu8OiCIW0Mj1wy78tapGg/+0eO0
         BS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASUhQbZZWnwMdFOtlf7q/5Hj+QucvRub8AGF+NJYF2M=;
        b=f4lj/P6CVjoTwtRzX45xZYitqzetremkY8ygQWHAEpzoBvf8rulO+/NQL13irJm/uQ
         Q1nxGo1MBX8M4Sr0dxSiJWvqGFUZmpGrOqxnjFPT4HyKMfNcvcezWhCzpMW+GEG2QvQ3
         bQtcQWNFd9zILfQSNi6ORTX4Tl/OL2NHkOtL8w1djgh+j/HPlbkjomiZcmqu2rbzqCD9
         Dh09RB+pqFnHRf6g+dNSYgyCu6HBOyKTC3ds0wpGbeIoVuU4bMPoLk2FnwU6zObJ6Aa/
         LQgMjkbUHbZzTtl6m9pwUKe6Z6R1tFKUxXgT7GIIlKSlv8Z8rto/o7EpRHSSsu5+IS3e
         uxOA==
X-Gm-Message-State: APjAAAU/CGIxYHgMsIGKdkjFl/J5oIAgvw/QMgZCbkh6g0rkZLPmjEqy
        x5tTuIbQlxK+W1ryFx2JDE4LDyYp52FRj0+/U2nRKA==
X-Google-Smtp-Source: APXvYqyZZV5VG4GeDf2IVhsd+oyCfCnAtHrbUGyUAmxKRv36iM0RsWx3O90LrycY6uUa/lAxZHw0Ld3ZGGdftrG+65I=
X-Received: by 2002:ac2:44af:: with SMTP id c15mr11339664lfm.32.1566814307111;
 Mon, 26 Aug 2019 03:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-5-git-send-email-vincent.guittot@linaro.org> <74bb33d7-3ba4-aabe-c7a2-3865d5759281@arm.com>
In-Reply-To: <74bb33d7-3ba4-aabe-c7a2-3865d5759281@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 26 Aug 2019 12:11:35 +0200
Message-ID: <CAKfTPtA_=_ukj-8cQL4+5qU7bLHX5v4wuPODcGsX6a+o2HmBDQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] sched/fair: rework load_balance
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 at 19:17, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Second batch, get it while it's hot...
>
> On 01/08/2019 15:40, Vincent Guittot wrote:
> [...]
> > @@ -7438,19 +7453,53 @@ static int detach_tasks(struct lb_env *env)
> >               if (!can_migrate_task(p, env))
> >                       goto next;
> >
> > -             load = task_h_load(p);
> > +             switch (env->balance_type) {
> > +             case migrate_task:
> > +                     /* Migrate task */
> > +                     env->imbalance--;
> > +                     break;
> >
> > -             if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
> > -                     goto next;
> > +             case migrate_util:
> > +                     util = task_util_est(p);
> >
> > -             if ((load / 2) > env->imbalance)
> > -                     goto next;
> > +                     if (util > env->imbalance)
> > +                             goto next;
> > +
> > +                     env->imbalance -= util;
> > +                     break;
> > +
> > +             case migrate_load:
> > +                     load = task_h_load(p);
> > +
> > +                     if (sched_feat(LB_MIN) &&
> > +                         load < 16 && !env->sd->nr_balance_failed)
> > +                             goto next;
> > +
> > +                     if ((load / 2) > env->imbalance)
> > +                             goto next;
> > +
> > +                     env->imbalance -= load;
> > +                     break;
> > +
> > +             case migrate_misfit:
> > +                     load = task_h_load(p);
> > +
> > +                     /*
> > +                      * utilization of misfit task might decrease a bit
> > +                      * since it has been recorded. Be conservative in the
> > +                      * condition.
> > +                      */
> > +                     if (load < env->imbalance)
> > +                             goto next;
> > +
> > +                     env->imbalance = 0;
> > +                     break;
> > +             }
> >
> >               detach_task(p, env);
> >               list_add(&p->se.group_node, &env->tasks);
> >
> >               detached++;
> > -             env->imbalance -= load;
> >
>
> It's missing something like this:

yes

>
> -----8<-----
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b0631ff2a4bd..055563e19090 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7506,7 +7506,7 @@ static int detach_tasks(struct lb_env *env)
>
>                 /*
>                  * We only want to steal up to the prescribed amount of
> -                * runnable load.
> +                * load/util/tasks
>                  */
>                 if (env->imbalance <= 0)
>                         break;
> ----->8-----
>
> [...]
> > @@ -8013,19 +8059,26 @@ group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
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
> >               return group_imbalanced;
> >
> > +     if (sgs->group_asym_capacity)
> > +             return group_asym_capacity;
> > +
> >       if (sgs->group_misfit_task_load)
> >               return group_misfit_task;
> >
> > -     return group_other;
> > +     if (!group_has_capacity(env, sgs))
> > +             return group_fully_busy;
>
> If I got my booleans right, reaching group_fully_busy means
> !group_is_overloaded() && !group_has_capacity(), which gives us:
>
> - If nr_running > group_weight, then we had to have
>   sgs->group_capacity * 100 == sgs->group_util * env->sd->imbalance_pct
>
> - If nr_running == group_weight, then we had to have
>   sgs->group_capacity * 100 <= sgs->group_util * env->sd->imbalance_pct
>
> - (if nr_running < group_weight we go to group_has_spare)
>
> That first equality seems somewhat odd considering how rarely it will
> occur, but then we still want the util check to fall down to
> group_has_spare when
>
>   nr_running >= group_weight &&
>   sgs->group_capacity * 100 > sgs->group_util * env->sd->imbalance_pct
>
> Maybe we could change group_has_capacity()'s util comparison from '>' to
> '>=' to avoid this weird "artefact".
>
> > +
> > +     return group_has_spare;
> >  }
> >
> >  static bool update_nohz_stats(struct rq *rq, bool force)
>
> [...]
> > @@ -8147,11 +8223,67 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >       if (sgs->group_type < busiest->group_type)
> >               return false;
> >
> > -     if (sgs->avg_load <= busiest->avg_load)
> > +     /*
> > +      * The candidate and the current busiest group are the same type of
> > +      * group. Let check which one is the busiest according to the type.
> > +      */
> > +
> > +     switch (sgs->group_type) {
> > +     case group_overloaded:
> > +             /* Select the overloaded group with highest avg_load. */
> > +             if (sgs->avg_load <= busiest->avg_load)
> > +                     return false;
> > +             break;
> > +
> > +     case group_imbalanced:
> > +             /* Select the 1st imbalanced group as we don't have
> > +              * any way to choose one more than another
> > +              */
> >               return false;
> > +             break;
> >
> > -     if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
> > -             goto asym_packing;
> > +     case group_asym_capacity:
> > +             /* Prefer to move from lowest priority CPU's work */
> > +             if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
> > +                      return false;
> > +             break;
> > +
> > +     case group_misfit_task:
> > +             /*
> > +              * If we have more than one misfit sg go with the
> > +              * biggest misfit.
> > +              */
> > +             if (sgs->group_misfit_task_load < busiest->group_misfit_task_load)
> > +                     return false;
> > +             break;
> > +
> > +     case group_fully_busy:
> > +             /*
> > +              * Select the fully busy group with highest avg_load.
> > +              * In theory, there is no need to pull task from such
> > +              * kind of group because tasks have all compute
> > +              * capacity that they need but we can still improve the
> > +              * overall throughput by reducing contention when
> > +              * accessing shared HW resources.
> > +              * XXX for now avg_load is not computed and always 0 so
> > +              * we select the 1st one.
> > +              */
>
> What's wrong with unconditionally computing avg_load in update_sg_lb_stats()?

removing useless division which can be expensive

> We already unconditionally accumulate group_load anyway.

accumulation must be done while looping on the group whereas computing
avg_load can be done only when needed

>
> If it's to make way for patch 6/8 (using load instead of runnable load),
> then I think you are doing things in the wrong order. IMO in this patch we
> should unconditionally compute avg_load (using runnable load), and then
> you could tweak it up in a subsequent patch.

In fact, it's not link to patch 6/8.
It's only that I initially wanted to used load only when overloaded
but then I got this case and thought that comparing avg_load could be
interesting but without any proof that it's worth.
As mentioned in the comment, tasks in this group have enough capacity
and there is no need to move task in theory. This is there mainly to
trigger the discuss and keep in mind a possible area of improvement in
a next step.
I haven't run tests or done more study on this particular case to make
sure that there would be some benefit to compare avg_load.

So in the future, we might end up always computing avg_load and
comparing it for selecting busiest fully busy group

>
> > +             if (sgs->avg_load <= busiest->avg_load)
> > +                     return false;
> > +             break;
> > +
> > +     case group_has_spare:
> > +             /*
> > +              * Select not overloaded group with lowest number of
> > +              * idle cpus. We could also compare the spare capacity
> > +              * which is more stable but it can end up that the
> > +              * group has less spare capacity but finally more idle
> > +              * cpus which means less opportunity to pull tasks.
> > +              */
> > +             if (sgs->idle_cpus >= busiest->idle_cpus)
> > +                     return false;
> > +             break;
> > +     }
> >
> >       /*
> >        * Candidate sg has no more than one task per CPU and
>
> [...]
> > @@ -8341,69 +8421,132 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >   */
> >  static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
> >  {
> > -     unsigned long max_pull, load_above_capacity = ~0UL;
> >       struct sg_lb_stats *local, *busiest;
> >
> >       local = &sds->local_stat;
> >       busiest = &sds->busiest_stat;
> > +     if (busiest->group_type == group_imbalanced) {
> > +             /*
> > +              * In the group_imb case we cannot rely on group-wide averages
> > +              * to ensure CPU-load equilibrium, try to move any task to fix
> > +              * the imbalance. The next load balance will take care of
> > +              * balancing back the system.
> > +              */
> > +             env->balance_type = migrate_task;
> > +             env->imbalance = 1;
> > +             return;
> > +     }
> >
> > -     if (busiest->group_asym_capacity) {
> > +     if (busiest->group_type == group_asym_capacity) {
> > +             /*
> > +              * In case of asym capacity, we will try to migrate all load
> > +              * to the preferred CPU
> > +              */
> > +             env->balance_type = migrate_load;
> >               env->imbalance = busiest->group_load;
> >               return;
> >       }
> >
> > +     if (busiest->group_type == group_misfit_task) {
> > +             /* Set imbalance to allow misfit task to be balanced. */
> > +             env->balance_type = migrate_misfit;
> > +             env->imbalance = busiest->group_misfit_task_load;
>
> AFAICT we don't ever use this value, other than setting it to 0 in
> detach_tasks(), so what we actually set it to doesn't matter (as long as
> it's > 0).

not yet.
it's only in patch 8/8 that we check if the tasks fits the cpu's
capacity during the detach_tasks

>
> I'd re-suggest folding migrate_misfit into migrate_task, which is doable if
> we re-instore lb_env.src_grp_type (or rather, not delete it in this patch),
> though it makes some other places somewhat uglier. The good thing is that
> it actually does end up being implemented as a special kind of task
> migration, rather than being loosely related.

I prefer to keep it separate instead of adding a sub case in migrate_task

>
> Below's a diff, only compile-tested but should help show my point.
> -----8<-----
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a8681c32445b..b0631ff2a4bd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7155,7 +7155,6 @@ enum migration_type {
>         migrate_task = 0,
>         migrate_util,
>         migrate_load,
> -       migrate_misfit,
>  };
>
>  #define LBF_ALL_PINNED 0x01
> @@ -7188,6 +7187,7 @@ struct lb_env {
>         unsigned int            loop_max;
>
>         enum fbq_type           fbq_type;
> +       enum group_type         src_grp_type;
>         enum migration_type     balance_type;
>         struct list_head        tasks;
>  };
> @@ -7455,6 +7455,13 @@ static int detach_tasks(struct lb_env *env)
>
>                 switch (env->balance_type) {
>                 case migrate_task:
> +                       /* Check for special kinds of tasks */
> +                       if (env->src_grp_type == group_misfit_task) {
> +                               /* This isn't the misfit task */
> +                               if (task_fits_capacity(p, capacity_of(env->src_cpu)))
> +                                       goto next;
> +                       }
> +
>                         /* Migrate task */
>                         env->imbalance--;
>                         break;
> @@ -7480,20 +7487,6 @@ static int detach_tasks(struct lb_env *env)
>
>                         env->imbalance -= load;
>                         break;
> -
> -               case migrate_misfit:
> -                       load = task_h_load(p);
> -
> -                       /*
> -                        * utilization of misfit task might decrease a bit
> -                        * since it has been recorded. Be conservative in the
> -                        * condition.
> -                        */
> -                       if (load < env->imbalance)
> -                               goto next;
> -
> -                       env->imbalance = 0;
> -                       break;
>                 }
>
>                 detach_task(p, env);
> @@ -8449,8 +8442,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>
>         if (busiest->group_type == group_misfit_task) {
>                 /* Set imbalance to allow misfit task to be balanced. */
> -               env->balance_type = migrate_misfit;
> -               env->imbalance = busiest->group_misfit_task_load;
> +               env->balance_type = migrate_task;
> +               env->imbalance = 1;
>                 return;
>         }
>
> @@ -8661,8 +8654,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>
>  force_balance:
>         /* Looks like there is an imbalance. Compute it */
> +       env->src_grp_type = busiest->group_type;
>         calculate_imbalance(env, &sds);
> -
>         return env->imbalance ? sds.busiest : NULL;
>
>  out_balanced:
> @@ -8728,7 +8721,15 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>
>                 switch (env->balance_type) {
>                 case migrate_task:
> -                       if (busiest_nr < nr_running) {
> +                       /*
> +                        * For ASYM_CPUCAPACITY domains with misfit tasks we simply
> +                        * seek the "biggest" misfit task.
> +                        */
> +                       if (env->src_grp_type == group_misfit_task &&
> +                           rq->misfit_task_load > busiest_load) {
> +                               busiest_load = rq->misfit_task_load;
> +                               busiest = rq;
> +                       } else if (busiest_nr < nr_running) {
>                                 busiest_nr = nr_running;
>                                 busiest = rq;
>                         }
> @@ -8771,19 +8772,6 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>                                 busiest = rq;
>                         }
>                         break;
> -
> -               case migrate_misfit:
> -                       /*
> -                        * For ASYM_CPUCAPACITY domains with misfit tasks we simply
> -                        * seek the "biggest" misfit task.
> -                        */
> -                       if (rq->misfit_task_load > busiest_load) {
> -                               busiest_load = rq->misfit_task_load;
> -                               busiest = rq;
> -                       }
> -
> -                       break;
> -
>                 }
>         }
>
> @@ -8829,7 +8817,7 @@ voluntary_active_balance(struct lb_env *env)
>                         return 1;
>         }
>
> -       if (env->balance_type == migrate_misfit)
> +       if (env->src_grp_type == group_misfit_task)
>                 return 1;
>
>         return 0;
> ----->8-----
>
>
> > +             return;
> > +     }
> > +
>
> Also, I think these three busiest->group_type conditions could be turned
> into a switch case.
>
> >       /*
> > -      * Avg load of busiest sg can be less and avg load of local sg can
> > -      * be greater than avg load across all sgs of sd because avg load
> > -      * factors in sg capacity and sgs with smaller group_type are
> > -      * skipped when updating the busiest sg:
> > +      * Try to use spare capacity of local group without overloading it or
> > +      * emptying busiest
> >        */
> > -     if (busiest->group_type != group_misfit_task &&
> > -         (busiest->avg_load <= sds->avg_load ||
> > -          local->avg_load >= sds->avg_load)) {
> > -             env->imbalance = 0;
> > +     if (local->group_type == group_has_spare) {
> > +             if (busiest->group_type > group_fully_busy) {
> > +                     /*
> > +                      * If busiest is overloaded, try to fill spare
> > +                      * capacity. This might end up creating spare capacity
> > +                      * in busiest or busiest still being overloaded but
> > +                      * there is no simple way to directly compute the
> > +                      * amount of load to migrate in order to balance the
> > +                      * system.
> > +                      */
> > +                     env->balance_type = migrate_util;
> > +                     env->imbalance = max(local->group_capacity, local->group_util) -
> > +                                 local->group_util;
> > +                     return;
> > +             }
> > +
> > +             if (busiest->group_weight == 1 || sds->prefer_sibling) {
> > +                     /*
> > +                      * When prefer sibling, evenly spread running tasks on
> > +                      * groups.
> > +                      */
> > +                     env->balance_type = migrate_task;
> > +                     env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
> > +                     return;
> > +             }
> > +
> > +             /*
> > +              * If there is no overload, we just want to even the number of
> > +              * idle cpus.
> > +              */
> > +             env->balance_type = migrate_task;
> > +             env->imbalance = max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1);
> >               return;
> >       }
> >
> >       /*
> > -      * If there aren't any idle CPUs, avoid creating some.
> > +      * Local is fully busy but have to take more load to relieve the
> > +      * busiest group
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
> > +     if (local->group_type < group_overloaded) {
> > +             /*
> > +              * Local will become overvloaded so the avg_load metrics are
>                                      ^^^^^^^^^^^
>                             s/overvloaded/overloaded/
>
> > +              * finally needed
> > +              */
> > +
> > +             local->avg_load = (local->group_load * SCHED_CAPACITY_SCALE) /
> > +                               local->group_capacity;
> > +
> > +             sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
> > +                             sds->total_capacity;
> >       }
> >
> >       /*
> > -      * We're trying to get all the CPUs to the average_load, so we don't
> > -      * want to push ourselves above the average load, nor do we wish to
> > -      * reduce the max loaded CPU below the average load. At the same time,
> > -      * we also don't want to reduce the group load below the group
> > -      * capacity. Thus we look for the minimum possible imbalance.
> > +      * Both group are or will become overloaded and we're trying to get
> > +      * all the CPUs to the average_load, so we don't want to push
> > +      * ourselves above the average load, nor do we wish to reduce the
> > +      * max loaded CPU below the average load. At the same time, we also
> > +      * don't want to reduce the group load below the group capacity.
> > +      * Thus we look for the minimum possible imbalance.
> >        */
> > -     max_pull = min(busiest->avg_load - sds->avg_load, load_above_capacity);
> > -
> > -     /* How much load to actually move to equalise the imbalance */
> > +     env->balance_type = migrate_load;
> >       env->imbalance = min(
> > -             max_pull * busiest->group_capacity,
> > +             (busiest->avg_load - sds->avg_load) * busiest->group_capacity,
> >               (sds->avg_load - local->avg_load) * local->group_capacity
> >       ) / SCHED_CAPACITY_SCALE;
> > -
> > -     /* Boost imbalance to allow misfit task to be balanced. */
> > -     if (busiest->group_type == group_misfit_task) {
> > -             env->imbalance = max_t(long, env->imbalance,
> > -                                    busiest->group_misfit_task_load);
> > -     }
> > -
> >  }
> >
> >  /******* find_busiest_group() helpers end here *********************/
> >
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
> >  /**
> >   * find_busiest_group - Returns the busiest group within the sched_domain
> >   * if there is an imbalance.
>
> [...]
> > @@ -8459,59 +8602,71 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> >               goto force_balance;
> >
>
> As for their counterpart in calculate_imbalance(), maybe go for a switch?
>
> Also, it would be nice if the ordering of these matched the one in
> calculate_imbalance() - right now it's the exact reverse order.
>
> Finally, would it hurt much to just move the balance_type and imbalance
> computation for these group types here? It breaks the nice partitions
> you've set up between find_busiest_group() and calculate_imbalance(),
> but it leads to less redirections for what in the end is just a simple
> condition.
>
> >       /*
> > -      * When dst_cpu is idle, prevent SMP nice and/or asymmetric group
> > -      * capacities from resulting in underutilization due to avg_load.
> > -      */
> > -     if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> > -         busiest->group_no_capacity)
> > -             goto force_balance;
> > -
> > -     /* Misfit tasks should be dealt with regardless of the avg load */
> > -     if (busiest->group_type == group_misfit_task)
> > -             goto force_balance;
> > -
> > -     /*
> >        * If the local group is busier than the selected busiest group
> >        * don't try and pull any tasks.
> >        */
> > -     if (local->avg_load >= busiest->avg_load)
> > +     if (local->group_type > busiest->group_type)
> >               goto out_balanced;
> >
> >       /*
> > -      * Don't pull any tasks if this group is already above the domain
> > -      * average load.
> > +      * When groups are overloaded, use the avg_load to ensure fairness
> > +      * between tasks.
> >        */
> > -     if (local->avg_load >= sds.avg_load)
> > -             goto out_balanced;
> > +     if (local->group_type == group_overloaded) {
> > +             /*
> > +              * If the local group is more loaded than the selected
> > +              * busiest group don't try and pull any tasks.
> > +              */
> > +             if (local->avg_load >= busiest->avg_load)
> > +                     goto out_balanced;
> > +
> > +             /* XXX broken for overlapping NUMA groups */
> > +             sds.avg_load = (sds.total_load * SCHED_CAPACITY_SCALE) /
> > +                             sds.total_capacity;
> >
> > -     if (env->idle == CPU_IDLE) {
> >               /*
> > -              * This CPU is idle. If the busiest group is not overloaded
> > -              * and there is no imbalance between this and busiest group
> > -              * wrt idle CPUs, it is balanced. The imbalance becomes
> > -              * significant if the diff is greater than 1 otherwise we
> > -              * might end up to just move the imbalance on another group
> > +              * Don't pull any tasks if this group is already above the
> > +              * domain average load.
> >                */
> > -             if ((busiest->group_type != group_overloaded) &&
> > -                             (local->idle_cpus <= (busiest->idle_cpus + 1)))
> > +             if (local->avg_load >= sds.avg_load)
> >                       goto out_balanced;
> > -     } else {
> > +
> >               /*
> > -              * In the CPU_NEWLY_IDLE, CPU_NOT_IDLE cases, use
> > -              * imbalance_pct to be conservative.
> > +              * If the busiest group is more loaded, use imbalance_pct to be
> > +              * conservative.
> >                */
> >               if (100 * busiest->avg_load <=
> >                               env->sd->imbalance_pct * local->avg_load)
> >                       goto out_balanced;
> > +
> >       }
> >
> > +     /* Try to move all excess tasks to child's sibling domain */
> > +     if (sds.prefer_sibling && local->group_type == group_has_spare &&
> > +         busiest->sum_h_nr_running > local->sum_h_nr_running + 1)
> > +             goto force_balance;
> > +
> > +     if (busiest->group_type != group_overloaded &&
> > +          (env->idle == CPU_NOT_IDLE ||
>
> Disregarding the idle_cpus count, we never balance load when the busiest
> is < group_misfit_task and we're CPU_NOT_IDLE.
>
> I *think* that's okay, since AFAICT that should mean
>
>   (local)   nr_running < group_weight
>   (busiest) nr_running <= group_weight
>             (or that weird == case)
>
> and if we (local) are not idle then we shouldn't pull anything. Bleh, guess
> it made me scratch my head for nothing.
>
> > +           local->idle_cpus <= (busiest->idle_cpus + 1)))
> > +             /*
> > +              * If the busiest group is not overloaded
> > +              * and there is no imbalance between this and busiest group
> > +              * wrt idle CPUs, it is balanced. The imbalance
> > +              * becomes significant if the diff is greater than 1 otherwise
> > +              * we might end up to just move the imbalance on another
> > +              * group.
> > +              */
> > +             goto out_balanced;
> > +
> >  force_balance:
> >       /* Looks like there is an imbalance. Compute it */
> > -     env->src_grp_type = busiest->group_type;
> >       calculate_imbalance(env, &sds);
> > +
> >       return env->imbalance ? sds.busiest : NULL;
> >
> >  out_balanced:
> > +
> >       env->imbalance = 0;
> >       return NULL;
> >  }
>
> [...]
> > @@ -8765,7 +8942,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >       env.src_rq = busiest;
> >
> >       ld_moved = 0;
> > -     if (busiest->cfs.h_nr_running > 1) {
> > +     if (busiest->nr_running > 1) {
>
> Shouldn't that stay h_nr_running ? We can't do much if those aren't CFS
> tasks.

There is the case raised by srikar where we have for example 1 RT task
and 1 CFS task. cfs.h_nr_running==1 but we don't need active balance
because CFS is not the running task

>
> >               /*
> >                * Attempt to move tasks. If find_busiest_group has found
> >                * an imbalance but busiest->nr_running <= 1, the group is
> >
