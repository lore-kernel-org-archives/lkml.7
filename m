Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC49C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773E8206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iy9Z49oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfHZJ0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:26:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36539 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbfHZJ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:26:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id u15so14409432ljl.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rd24TjidNMGIReD2mLR4ZwBKrhjnmtPqQNBcTY21r0E=;
        b=Iy9Z49oak+mGzalsC+Dj9pFKzHcEV+22HtwS6SdiKnz4omOhYlW6yUo2QdnR/1hUbb
         lwothE3TaqEsAf6BtPv7nmhZ7m0orVvwDMPOqac7yvXWUKasHAzqmKxPLxFJDGDUx47v
         u7caQ+fdq+mtxUk7jT/+8NhRDtuRT9WQMuRZU1iowWy3FR4Bz8/zDeb+mD4UgEGBh9O7
         0MQoyLg8kHekICsOPZA+oSHfYOLavKLDvPx7qX3Jt/yfefU+s/mNkWJT0DNtYCYE3Iaz
         4UHMhmy9IlUrP1SJ3j2mdaPifcmgyN7AVePkPnauFsfjH0xUtty/n/7Sqtsev4n9WTVO
         tXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rd24TjidNMGIReD2mLR4ZwBKrhjnmtPqQNBcTY21r0E=;
        b=nNWPzsJMWgDqCTMCAbhQly7xcxGSHoIx8x+SO2HF6GQnEwW9UtEORQHi3zaklRtAdv
         1f6Ic9+W+d4ZOyRgp2DD6Ud+A/DF9lS13D84FcqufZoAd8DSCx3qhOD6s6zj6rXN6nEH
         oHVpCqfE+Zoe13bStDvDLcO7L1bd/YTAt9DJYbUmas4n3cgtNzK0TUvPqUL5hTPhCW1X
         dSEIXtCZR9+iPAXRVmXBVFWRGFruqyJBN4X340bLbyyzVHHR00X87T2vb1QRs/pmZ9ix
         xnqyqL/5QS0xeV5GaWEUnICZj7BHP2zCz2VXOAhBV8jBhoNJQpYFzVAFuWykxZ2z4xAH
         OJUg==
X-Gm-Message-State: APjAAAVzdanX6ETY5sra2pBlaheX3EHPeuOoqT71s8jXFOb6ylwsJdxB
        bBQWWC6E6+g+QEdm7YF6wcSONfoJuVAEq3ji19oDZQ==
X-Google-Smtp-Source: APXvYqxbXq/HtPvQ2CIVwcH/xXmaI+8rTi/Hof6F1OcmoTHxQECHBZVuSg4rR/dcUWedTvI+mkqxwJTfHnoPS4IeSAo=
X-Received: by 2002:a05:651c:1b8:: with SMTP id c24mr10084660ljn.2.1566811577973;
 Mon, 26 Aug 2019 02:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-5-git-send-email-vincent.guittot@linaro.org> <ee4ac9c8-ac70-e56a-2aa9-9cce2e5aa25b@arm.com>
In-Reply-To: <ee4ac9c8-ac70-e56a-2aa9-9cce2e5aa25b@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 26 Aug 2019 11:26:06 +0200
Message-ID: <CAKfTPtA1-8u2LCiq5o1go_M7FywBao-EDxCHMfsxEN8es4pXcw@mail.gmail.com>
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

On Mon, 5 Aug 2019 at 19:07, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi Vincent,
>
> Here's another batch of comments, still need to go through some more of it.
>
> On 01/08/2019 15:40, Vincent Guittot wrote:
> > The load_balance algorithm contains some heuristics which have becomes
>
> s/becomes/become/

yep for this one and other typo mistakes

>
> > meaningless since the rework of metrics and the introduction of PELT.
>                                ^^^^^^^^^^
> Which metrics? I suppose you mean the s*_lb_stats structs?
>
> >
> > Furthermore, it's sometimes difficult to fix wrong scheduling decisions
> > because everything is based on load whereas some imbalances are not
> > related to the load.
>
> Hmm, well, they don't start as wrong decisions, right? It's just that
> certain imbalance scenarios can't be solved by looking only at load.
>
> What about something along those lines?
>
> """
> Furthermore, load is an ill-suited metric for solving certain task
> placement imbalance scenarios. For instance, in the presence of idle CPUs,
> we should simply try to get at least one task per CPU, whereas the current
> load-based algorithm can actually leave idle CPUs alone simply because the
> load is somewhat balanced.
> """
>
> > The current algorithm ends up to create virtual and
>
> s/to create/creating/
>
> > meaningless value like the avg_load_per_task or tweaks the state of a
> > group to make it overloaded whereas it's not, in order to try to migrate
> > tasks.
> >
> > load_balance should better qualify the imbalance of the group and define
> > cleary what has to be moved to fix this imbalance.
>
> s/define cleary/clearly define/
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
> >
> > Based on the type of sched_group, load_balance now sets what it wants to
> > move in order to fix the imnbalance. It can be some load as before but
>
> s/imnbalance/imbalance/
>
> > also some utilization, a number of task or a type of task:
> >       migrate_task
> >       migrate_util
> >       migrate_load
> >       migrate_misfit
> >
> > This new load_balance algorithm fixes several pending wrong tasks
> > placement:
> > - the 1 task per CPU case with asymetrics system
>
> s/asymetrics/asymmetric/
>
> > - the case of cfs task preempted by other class
> > - the case of tasks not evenly spread on groups with spare capacity
> >
> > The load balance decisions have been gathered in 3 functions:
> > - update_sd_pick_busiest() select the busiest sched_group.
> > - find_busiest_group() checks if there is an imabalance between local and
>
> s/imabalance/imbalance/
>
> >   busiest group.
> > - calculate_imbalance() decides what have to be moved.
>
> That's nothing new, isn't it? I think what you mean there is that the

There is 2 things:
-part of the algorithm is new and fixes wrong task placement
-everything has been consolidated in the 3 functions above whereas
there were some bypasses and hack in the current code

> decisions have been consolidated in those areas, rather than being spread

I would not say that the code was spread all over the place because
90% was already correctly placed but there were few cases that have
been added outside these functions

> all over the place.
>
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 581 ++++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 379 insertions(+), 202 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d7f4a7e..a8681c3 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7136,13 +7136,28 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
> >
> >  enum fbq_type { regular, remote, all };
> >
> > +/*
> > + * group_type describes the group of CPUs at the moment of the load balance.
> > + * The enum is ordered by pulling priority, with the group with lowest priority
> > + * first so the groupe_type can be simply compared when selecting the busiest
> > + * group. see update_sd_pick_busiest().
> > + */
> >  enum group_type {
> > -     group_other = 0,
> > +     group_has_spare = 0,
> > +     group_fully_busy,
> >       group_misfit_task,
> > +     group_asym_capacity,
>
> That one got me confused - it's about asym packing, not asym capacity, and
> the name should reflect that. I'd vote for group_asym_packing to stay in
> line with what Quentin did for the sd shortcut pointers in

yep asym_packing is probably better

>
>   011b27bb5d31 ("sched/topology: Add lowest CPU asymmetry sched_domain level pointer")
>
> >       group_imbalanced,
> >       group_overloaded,
> >  };
> >
> > +enum migration_type {
> > +     migrate_task = 0,
> > +     migrate_util,
> > +     migrate_load,
> > +     migrate_misfit,
>
> nitpicking here: AFAICT the ordering of this doesn't really matter,
> could we place migrate_misfit next to migrate_task? As you call out in the
> header, we can migrate a number of tasks or a type of task, so these should
> be somewhat together.

misfit has been added last because it's specific whereas others are
somehow generic and I want to keep generic first and specific last

>
> If we're afraid that we'll add other types of tasks later on and that this
> won't result in a neat append-to-the-end, we could reverse the order like
> so:
>
> migrate_load
> migrate_util
> migrate_task
> migrate_misfit

I can put in this order

>
> [...]
> > @@ -7745,10 +7793,10 @@ struct sg_lb_stats {
> >  struct sd_lb_stats {
> >       struct sched_group *busiest;    /* Busiest group in this sd */
> >       struct sched_group *local;      /* Local group in this sd */
> > -     unsigned long total_running;
>
> Could be worth calling out in the log that this gets snipped out. Or it
> could go into its own small cleanup patch, since it's just an unused field.

I can mention it more specifically in the log but that's part of those
meaningless metrics which is no more used
>
> [...]> @@ -8147,11 +8223,67 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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
>
> You already have an unconditional return above.

good point

>
> >
> > -     if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
> > -             goto asym_packing;
> > +     case group_asym_capacity:
> > +             /* Prefer to move from lowest priority CPU's work */
> > +             if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
> > +                      return false;
>                         ^
>                 Stray whitespace
>
> [...]
> > @@ -8438,17 +8581,17 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> >       local = &sds.local_stat;
> >       busiest = &sds.busiest_stat;
> >
> > -     /* ASYM feature bypasses nice load balance check */
> > -     if (busiest->group_asym_capacity)
> > -             goto force_balance;
> > -
> >       /* There is no busy sibling group to pull tasks from */
> >       if (!sds.busiest || busiest->sum_h_nr_running == 0)
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> That can go, since you now filter this in update_sd_pick_busiest()

yes

>
> [...]
> > @@ -8459,59 +8602,71 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> >               goto force_balance;
> >
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
>
> Stray newline?
>
> >       return env->imbalance ? sds.busiest : NULL;
> >
> >  out_balanced:
> > +
>
> Ditto?
>
> >       env->imbalance = 0;
> >       return NULL;
> >  }
> [...]
