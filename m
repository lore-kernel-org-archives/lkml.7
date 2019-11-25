Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F494C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EF020740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLBBqoCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKYKAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:00:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34789 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfKYKAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:00:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id m6so7696299ljc.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 02:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I549ncP5PRWqjt5DRX0VMkqmyEjfieJQwJYG8xptYIg=;
        b=dLBBqoCjX49lmBpaz/i0pUlB1GyYxLUd43v8lfppODRBjSwh+JkPG5PRZxHJfI5Lm3
         5LnQR9STGbjArOy79saOFpp0rK4skftHjQJVxWcytzDT0dYq93p9AzFrHuVYJAsV1ZcC
         W4GvDyrGXO0Txf78yX3gZRJRqQC9U6HX+LdfaqamT6fNJvmB/eJ1VYhXCydePTTNW9tR
         a5KEXvEWS1usjFeIAedN6R+O7VMxALafqFITQuMQ89MtsyMTsbisWQtBJkrf4lmbuwbx
         t7fzrvfnBDnalMaRddkCHhmGqOo/SI8h7i7LVJb8YTk8Z5lRCKDmh1X65QAbVxz0Zece
         WpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I549ncP5PRWqjt5DRX0VMkqmyEjfieJQwJYG8xptYIg=;
        b=AiI+3l4fD8lHrceZkPUC/KqmMopH7AubbGIUtMv3lirCwlB5VCrXi8YSZvZFqyzPnu
         5l1By/du4Zzss8VTJe+J+SQ7A0YTLvrLozM0vpmzbr1Gl26gzlJHAI8mgYFf40yvLERO
         08+toG5/NCW9ZX97MH2hdm9S1ql22cmUgkxurY8k8kJgE38H6nwS0fIlU0Iy5qweRkU/
         R8eArcKs+UVP7R4sA7B50ZZB5P0W75eE4gCDIYx8ZP4rSdYjld5xX80qq90WMOm/o/IQ
         Q++8tpOyQnXI7B6QH5aedXwOJ2JAe8v3to2MjvVUnrBkL5MCPGbyzOu6ugt48MptS9vf
         KXqA==
X-Gm-Message-State: APjAAAXveV5SQ6PXpZhFXQy82T2ozOzw8KFzoPL1qytSY7aiM6vpc0MB
        bci+lHcTtFwVEa2DYGwIyMVLL298yD1Mc8z3CeugHQ==
X-Google-Smtp-Source: APXvYqw1EFpXFc9pJjYpUEW+8V7lTx4kTCWpq0EkI5L1QGJryuQluhCpFtF3viboRM4H+4BGZ0z0r0/C+1mR7mg6EN0=
X-Received: by 2002:a2e:7811:: with SMTP id t17mr21905119ljc.225.1574676005751;
 Mon, 25 Nov 2019 02:00:05 -0800 (PST)
MIME-Version: 1.0
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org> <5b4d204f-ce18-948a-416b-1920bcea7cf7@arm.com>
In-Reply-To: <5b4d204f-ce18-948a-416b-1920bcea7cf7@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 25 Nov 2019 10:59:54 +0100
Message-ID: <CAKfTPtDHY6oQRyMr0uH69UTCWyptyfdu9uEac3Um=fgGb5-eCQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] sched/fair: rework find_idlest_group
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 at 15:34, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi Vincent,
>
> Apologies for the delayed review on that one. I have a few comments inline,
> otherwise for the misfit part, if at all still relevant:
>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>
> On 18/10/2019 14:26, Vincent Guittot wrote:
> >  static struct sched_group *
> >  find_idlest_group(struct sched_domain *sd, struct task_struct *p,
> > +               int this_cpu, int sd_flag);
>                                     ^^^^^^^
> That parameter is now unused. AFAICT it was only used to special-case fork
> events (sd flag & SD_BALANCE_FORK). I didn't see any explicit handling of
> this case in the rework, I assume the new group type classification makes
> it possible to forgo?
>
> > @@ -8241,6 +8123,252 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
> >  }
> >  #endif /* CONFIG_NUMA_BALANCING */
> >
> > +
> > +struct sg_lb_stats;
> > +
> > +/*
> > + * update_sg_wakeup_stats - Update sched_group's statistics for wakeup.
> > + * @denv: The ched_domain level to look for idlest group.
> > + * @group: sched_group whose statistics are to be updated.
> > + * @sgs: variable to hold the statistics for this group.
> > + */
> > +static inline void update_sg_wakeup_stats(struct sched_domain *sd,
> > +                                       struct sched_group *group,
> > +                                       struct sg_lb_stats *sgs,
> > +                                       struct task_struct *p)
> > +{
> > +     int i, nr_running;
> > +
> > +     memset(sgs, 0, sizeof(*sgs));
> > +
> > +     for_each_cpu(i, sched_group_span(group)) {
> > +             struct rq *rq = cpu_rq(i);
> > +
> > +             sgs->group_load += cpu_load(rq);
> > +             sgs->group_util += cpu_util_without(i, p);
> > +             sgs->sum_h_nr_running += rq->cfs.h_nr_running;
> > +
> > +             nr_running = rq->nr_running;
> > +             sgs->sum_nr_running += nr_running;
> > +
> > +             /*
> > +              * No need to call idle_cpu() if nr_running is not 0
> > +              */
> > +             if (!nr_running && idle_cpu(i))
> > +                     sgs->idle_cpus++;
> > +
> > +
> > +     }
> > +
> > +     /* Check if task fits in the group */
> > +     if (sd->flags & SD_ASYM_CPUCAPACITY &&
> > +         !task_fits_capacity(p, group->sgc->max_capacity)) {
> > +             sgs->group_misfit_task_load = 1;
> > +     }
> > +
> > +     sgs->group_capacity = group->sgc->capacity;
> > +
> > +     sgs->group_type = group_classify(sd->imbalance_pct, group, sgs);
> > +
> > +     /*
> > +      * Computing avg_load makes sense only when group is fully busy or
> > +      * overloaded
> > +      */
> > +     if (sgs->group_type < group_fully_busy)
> > +             sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
> > +                             sgs->group_capacity;
> > +}
> > +
> > +static bool update_pick_idlest(struct sched_group *idlest,
>
> Nit: could we name this update_sd_pick_idlest() to follow
> update_sd_pick_busiest()? It's the kind of thing where if I typed
> "update_sd" in gtags I'd like to see both listed, seeing as they are
> *very* similar. And we already have update_sg_{wakeup, lb}_stats().
>
> > +                            struct sg_lb_stats *idlest_sgs,
> > +                            struct sched_group *group,
> > +                            struct sg_lb_stats *sgs)
> > +{
> > +     if (sgs->group_type < idlest_sgs->group_type)
> > +             return true;
> > +
> > +     if (sgs->group_type > idlest_sgs->group_type)
> > +             return false;
> > +
> > +     /*
> > +      * The candidate and the current idles group are the same type of
> > +      * group. Let check which one is the idlest according to the type.
> > +      */
> > +
> > +     switch (sgs->group_type) {
> > +     case group_overloaded:
> > +     case group_fully_busy:
> > +             /* Select the group with lowest avg_load. */
> > +             if (idlest_sgs->avg_load <= sgs->avg_load)
> > +                     return false;
> > +             break;
> > +
> > +     case group_imbalanced:
> > +     case group_asym_packing:
> > +             /* Those types are not used in the slow wakeup path */
> > +             return false;
> > +
> > +     case group_misfit_task:
> > +             /* Select group with the highest max capacity */
> > +             if (idlest->sgc->max_capacity >= group->sgc->max_capacity)
> > +                     return false;
> > +             break;
> > +
> > +     case group_has_spare:
> > +             /* Select group with most idle CPUs */
> > +             if (idlest_sgs->idle_cpus >= sgs->idle_cpus)
> > +                     return false;
> > +             break;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +/*
> > + * find_idlest_group finds and returns the least busy CPU group within the
> > + * domain.
> > + *
> > + * Assumes p is allowed on at least one CPU in sd.
> > + */
> > +static struct sched_group *
> > +find_idlest_group(struct sched_domain *sd, struct task_struct *p,
> > +               int this_cpu, int sd_flag)
> > +{
> > +     struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
> > +     struct sg_lb_stats local_sgs, tmp_sgs;
> > +     struct sg_lb_stats *sgs;
> > +     unsigned long imbalance;
> > +     struct sg_lb_stats idlest_sgs = {
> > +                     .avg_load = UINT_MAX,
> > +                     .group_type = group_overloaded,
> > +     };
> > +
> > +     imbalance = scale_load_down(NICE_0_LOAD) *
> > +                             (sd->imbalance_pct-100) / 100;
> > +
> > +     do {
> > +             int local_group;
> > +
> > +             /* Skip over this group if it has no CPUs allowed */
> > +             if (!cpumask_intersects(sched_group_span(group),
> > +                                     p->cpus_ptr))
> > +                     continue;
> > +
> > +             local_group = cpumask_test_cpu(this_cpu,
> > +                                            sched_group_span(group));
> > +
> > +             if (local_group) {
> > +                     sgs = &local_sgs;
> > +                     local = group;
> > +             } else {
> > +                     sgs = &tmp_sgs;
> > +             }
> > +
> > +             update_sg_wakeup_stats(sd, group, sgs, p);
> > +
> > +             if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs)) {
> > +                     idlest = group;
> > +                     idlest_sgs = *sgs;
> > +             }
> > +
> > +     } while (group = group->next, group != sd->groups);
> > +
> > +
> > +     /* There is no idlest group to push tasks to */
> > +     if (!idlest)
> > +             return NULL;
> > +
> > +     /*
> > +      * If the local group is idler than the selected idlest group
> > +      * don't try and push the task.
> > +      */
> > +     if (local_sgs.group_type < idlest_sgs.group_type)
> > +             return NULL;
> > +
> > +     /*
> > +      * If the local group is busier than the selected idlest group
> > +      * try and push the task.
> > +      */
> > +     if (local_sgs.group_type > idlest_sgs.group_type)
> > +             return idlest;
> > +
> > +     switch (local_sgs.group_type) {
> > +     case group_overloaded:
> > +     case group_fully_busy:
> > +             /*
> > +              * When comparing groups across NUMA domains, it's possible for
> > +              * the local domain to be very lightly loaded relative to the
> > +              * remote domains but "imbalance" skews the comparison making
> > +              * remote CPUs look much more favourable. When considering
> > +              * cross-domain, add imbalance to the load on the remote node
> > +              * and consider staying local.
> > +              */
> > +
> > +             if ((sd->flags & SD_NUMA) &&
> > +                 ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
> > +                     return NULL;
> > +
> > +             /*
> > +              * If the local group is less loaded than the selected
> > +              * idlest group don't try and push any tasks.
> > +              */
> > +             if (idlest_sgs.avg_load >= (local_sgs.avg_load + imbalance))
> > +                     return NULL;
> > +
> > +             if (100 * local_sgs.avg_load <= sd->imbalance_pct * idlest_sgs.avg_load)
> > +                     return NULL;
> > +             break;
> > +
> > +     case group_imbalanced:
> > +     case group_asym_packing:
> > +             /* Those type are not used in the slow wakeup path */
> > +             return NULL;
>
> I suppose group_asym_packing could be handled similarly to misfit, right?
> i.e. make the group type group_asym_packing if
>
>   !sched_asym_prefer(sg.asym_prefer_cpu, local.asym_prefer_cpu)

Unlike group_misfit_task that was somehow already taken into account
through the comparison of spare capacity, group_asym_packing was not
considered at all in find_idlest_group so I prefer to stay
conservative and wait for users of asym_packing to come with a need
before adding this new mechanism.

>
> > +
> > +     case group_misfit_task:
> > +             /* Select group with the highest max capacity */
> > +             if (local->sgc->max_capacity >= idlest->sgc->max_capacity)
> > +                     return NULL;
>
> Got confused a bit here due to the naming; in this case 'group_misfit_task'
> only means 'if placed on this group, the task will be misfit'. If the
> idlest group will cause us to remain misfit, but can give us some extra
> capacity, I think it makes sense to move.
>
> > +             break;
> > +
> > +     case group_has_spare:
> > +             if (sd->flags & SD_NUMA) {
> > +#ifdef CONFIG_NUMA_BALANCING
> > +                     int idlest_cpu;
> > +                     /*
> > +                      * If there is spare capacity at NUMA, try to select
> > +                      * the preferred node
> > +                      */
> > +                     if (cpu_to_node(this_cpu) == p->numa_preferred_nid)
> > +                             return NULL;
> > +
> > +                     idlest_cpu = cpumask_first(sched_group_span(idlest));
> > +                     if (cpu_to_node(idlest_cpu) == p->numa_preferred_nid)
> > +                             return idlest;
> > +#endif
> > +                     /*
> > +                      * Otherwise, keep the task on this node to stay close
> > +                      * its wakeup source and improve locality. If there is
> > +                      * a real need of migration, periodic load balance will
> > +                      * take care of it.
> > +                      */
> > +                     if (local_sgs.idle_cpus)
> > +                             return NULL;
> > +             }
> > +
> > +             /*
> > +              * Select group with highest number of idle cpus. We could also
> > +              * compare the utilization which is more stable but it can end
> > +              * up that the group has less spare capacity but finally more
> > +              * idle cpus which means more opportunity to run task.
> > +              */
> > +             if (local_sgs.idle_cpus >= idlest_sgs.idle_cpus)
> > +                     return NULL;
> > +             break;
> > +     }
> > +
> > +     return idlest;
> > +}
> > +
> >  /**
> >   * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
> >   * @env: The load balancing environment.
> >
