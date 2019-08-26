Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BA4C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9CB22CED
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSFRgfjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfHZJbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:31:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34233 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfHZJbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:31:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id z21so3252117lfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lS4AobfI484DTN8qVCrQl9Suo3091Od7wYOEO5G5yKk=;
        b=bSFRgfjmNuPqgpcHdlnfJduwk8deLR/8PH2GmTJTYTgPOpq25cLWaKOnMub2H7ME0D
         EBH7KRBq3pTe9bn4Qq/nCiZBRFSaQ/7gaSzRxlua2SHG8nU4DZZxgPkDCudGBGVX7+Ww
         DI8h1ZvhXjWng+IeIisZwzjC9wNSP1XvGdYd2uNml/vue8s+vZmcB9h9lg9c8gftZxAe
         ld9ZlyjYRsEZonkoFnHeJgcHzkGv7DLVJYIh6dnDVeGjx99cFU/epmVHb+O9cOyjJ1uq
         xYwQOavSQEnTnFKsDjGJpEb9ekNXtJjG8R9cMjl3J31EY8Cmjis2dweK6CsIScRPiXnR
         y91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lS4AobfI484DTN8qVCrQl9Suo3091Od7wYOEO5G5yKk=;
        b=onI81FabAtQTPEoCPTk1jMog5S+ZXxGjlkG+TgNxLE6vSaTfA/nLn0C6MTYTRj6S13
         vFhvuepCvevpQddEi2FucXKsPuxPHYCGJnWZDA9vUknZp7CJe6b4Yfeeg+EGuCyKmFcW
         o27ajZJU751TO2owqMItZpuXr6D8gRYK4fon2PYQEFlqQLgmtQ4dvQSAmkIrfDCxS+ta
         2F2VsTC7MAI0leDVanRSU+2l/ibER8a2efB8lE17dP62yj9IOPSazcWQj0nT7zX4jV3E
         Wj1tno4R/6tVQhwPR2umd/Chx23S0xcuEwG7YgKhR8iSj8AXa3aNC7IUEgsG0MVRK+a8
         4vjQ==
X-Gm-Message-State: APjAAAVnqbPKocLOg9HdA7ZFJt+h+V+j7rY4ySxhNEZNoismSpSvyOlV
        wALxmgWMQI4rXfG3Ui+/KBWFwM9EWapE1J6dBebzuQ==
X-Google-Smtp-Source: APXvYqyWiu15674AtrnMYKoHn+q/x4yOCo0+s8TrtE1VpjV7mSsZS6Gv0ZsejSqK8NgjS8Ge9iPCnqSxLmPzGC7sEu0=
X-Received: by 2002:ac2:447c:: with SMTP id y28mr3768218lfl.177.1566811881920;
 Mon, 26 Aug 2019 02:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-5-git-send-email-vincent.guittot@linaro.org> <20190806155620.GV2332@hirez.programming.kicks-ass.net>
In-Reply-To: <20190806155620.GV2332@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 26 Aug 2019 11:31:10 +0200
Message-ID: <CAKfTPtAS2F8ewznprk3d7fR7sAFD9Duy0PEmzyfW9Mot9ZZH=Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] sched/fair: rework load_balance
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 at 17:56, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Aug 01, 2019 at 04:40:20PM +0200, Vincent Guittot wrote:
> > The load_balance algorithm contains some heuristics which have becomes
> > meaningless since the rework of metrics and the introduction of PELT.
> >
> > Furthermore, it's sometimes difficult to fix wrong scheduling decisions
> > because everything is based on load whereas some imbalances are not
> > related to the load. The current algorithm ends up to create virtual and
> > meaningless value like the avg_load_per_task or tweaks the state of a
> > group to make it overloaded whereas it's not, in order to try to migrate
> > tasks.
> >
> > load_balance should better qualify the imbalance of the group and define
> > cleary what has to be moved to fix this imbalance.
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
> > also some utilization, a number of task or a type of task:
> >       migrate_task
> >       migrate_util
> >       migrate_load
> >       migrate_misfit
> >
> > This new load_balance algorithm fixes several pending wrong tasks
> > placement:
> > - the 1 task per CPU case with asymetrics system
> > - the case of cfs task preempted by other class
> > - the case of tasks not evenly spread on groups with spare capacity
> >
> > The load balance decisions have been gathered in 3 functions:
> > - update_sd_pick_busiest() select the busiest sched_group.
> > - find_busiest_group() checks if there is an imabalance between local and
> >   busiest group.
> > - calculate_imbalance() decides what have to be moved.
>
> I like this lots, very good stuff.
>
> It is weird how misfit is still load, but istr later patches cure that.
>
> Here's a whole pile of nits, some overlap with what Valentin already
> noted. His suggestions for the changelog also make sense to me.

ok.
Thanks

>
> ---
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8205,10 +8205,10 @@ static bool update_sd_pick_busiest(struc
>  {
>         struct sg_lb_stats *busiest = &sds->busiest_stat;
>
> -
>         /* Make sure that there is at least one task to pull */
>         if (!sgs->sum_h_nr_running)
>                 return false;
> +
>         /*
>          * Don't try to pull misfit tasks we can't help.
>          * We can use max_capacity here as reduction in capacity on some
> @@ -8239,11 +8239,11 @@ static bool update_sd_pick_busiest(struc
>                 break;
>
>         case group_imbalanced:
> -               /* Select the 1st imbalanced group as we don't have
> -                * any way to choose one more than another
> +               /*
> +                * Select the 1st imbalanced group as we don't have any way to
> +                * choose one more than another
>                  */
>                 return false;
> -               break;
>
>         case group_asym_capacity:
>                 /* Prefer to move from lowest priority CPU's work */
> @@ -8253,8 +8253,8 @@ static bool update_sd_pick_busiest(struc
>
>         case group_misfit_task:
>                 /*
> -                * If we have more than one misfit sg go with the
> -                * biggest misfit.
> +                * If we have more than one misfit sg go with the biggest
> +                * misfit.
>                  */
>                 if (sgs->group_misfit_task_load < busiest->group_misfit_task_load)
>                         return false;
> @@ -8262,14 +8262,14 @@ static bool update_sd_pick_busiest(struc
>
>         case group_fully_busy:
>                 /*
> -                * Select the fully busy group with highest avg_load.
> -                * In theory, there is no need to pull task from such
> -                * kind of group because tasks have all compute
> -                * capacity that they need but we can still improve the
> -                * overall throughput by reducing contention when
> -                * accessing shared HW resources.
> -                * XXX for now avg_load is not computed and always 0 so
> -                * we select the 1st one.
> +                * Select the fully busy group with highest avg_load.  In
> +                * theory, there is no need to pull task from such kind of
> +                * group because tasks have all compute capacity that they need
> +                * but we can still improve the overall throughput by reducing
> +                * contention when accessing shared HW resources.
> +                *
> +                * XXX for now avg_load is not computed and always 0 so we
> +                * select the 1st one.
>                  */
>                 if (sgs->avg_load <= busiest->avg_load)
>                         return false;
> @@ -8277,11 +8277,11 @@ static bool update_sd_pick_busiest(struc
>
>         case group_has_spare:
>                 /*
> -                * Select not overloaded group with lowest number of
> -                * idle cpus. We could also compare the spare capacity
> -                * which is more stable but it can end up that the
> -                * group has less spare capacity but finally more idle
> -                * cpus which means less opportunity to pull tasks.
> +                * Select not overloaded group with lowest number of idle cpus.
> +                * We could also compare the spare capacity which is more
> +                * stable but it can end up that the group has less spare
> +                * capacity but finally more idle cpus which means less
> +                * opportunity to pull tasks.
>                  */
>                 if (sgs->idle_cpus >= busiest->idle_cpus)
>                         return false;
> @@ -8289,10 +8289,10 @@ static bool update_sd_pick_busiest(struc
>         }
>
>         /*
> -        * Candidate sg has no more than one task per CPU and
> -        * has higher per-CPU capacity. Migrating tasks to less
> -        * capable CPUs may harm throughput. Maximize throughput,
> -        * power/energy consequences are not considered.
> +        * Candidate sg has no more than one task per CPU and has higher
> +        * per-CPU capacity. Migrating tasks to less capable CPUs may harm
> +        * throughput. Maximize throughput, power/energy consequences are not
> +        * considered.
>          */
>         if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
>             (sgs->group_type <= group_fully_busy) &&
> @@ -8428,6 +8428,7 @@ static inline void calculate_imbalance(s
>
>         local = &sds->local_stat;
>         busiest = &sds->busiest_stat;
> +
>         if (busiest->group_type == group_imbalanced) {
>                 /*
>                  * In the group_imb case we cannot rely on group-wide averages
> @@ -8442,8 +8443,8 @@ static inline void calculate_imbalance(s
>
>         if (busiest->group_type == group_asym_capacity) {
>                 /*
> -                * In case of asym capacity, we will try to migrate all load
> -                * to the preferred CPU
> +                * In case of asym capacity, we will try to migrate all load to
> +                * the preferred CPU
>                  */
>                 env->balance_type = migrate_load;
>                 env->imbalance = busiest->group_load;
> @@ -8483,7 +8484,8 @@ static inline void calculate_imbalance(s
>                          * groups.
>                          */
>                         env->balance_type = migrate_task;
> -                       env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
> +                       env->imbalance = (busiest->sum_h_nr_running -
> +                                         local->sum_h_nr_running) >> 1;
>                         return;
>                 }
>
> @@ -8502,7 +8504,7 @@ static inline void calculate_imbalance(s
>          */
>         if (local->group_type < group_overloaded) {
>                 /*
> -                * Local will become overvloaded so the avg_load metrics are
> +                * Local will become overloaded so the avg_load metrics are
>                  * finally needed
>                  */
>
> @@ -8514,12 +8516,12 @@ static inline void calculate_imbalance(s
>         }
>
>         /*
> -        * Both group are or will become overloaded and we're trying to get
> -        * all the CPUs to the average_load, so we don't want to push
> -        * ourselves above the average load, nor do we wish to reduce the
> -        * max loaded CPU below the average load. At the same time, we also
> -        * don't want to reduce the group load below the group capacity.
> -        * Thus we look for the minimum possible imbalance.
> +        * Both group are or will become overloaded and we're trying to get all
> +        * the CPUs to the average_load, so we don't want to push ourselves
> +        * above the average load, nor do we wish to reduce the max loaded CPU
> +        * below the average load. At the same time, we also don't want to
> +        * reduce the group load below the group capacity.  Thus we look for
> +        * the minimum possible imbalance.
>          */
>         env->balance_type = migrate_load;
>         env->imbalance = min(
> @@ -8641,7 +8643,6 @@ static struct sched_group *find_busiest_
>                 if (100 * busiest->avg_load <=
>                                 env->sd->imbalance_pct * local->avg_load)
>                         goto out_balanced;
> -
>         }
>
>         /* Try to move all excess tasks to child's sibling domain */
> @@ -8651,7 +8652,7 @@ static struct sched_group *find_busiest_
>
>         if (busiest->group_type != group_overloaded &&
>              (env->idle == CPU_NOT_IDLE ||
> -             local->idle_cpus <= (busiest->idle_cpus + 1)))
> +             local->idle_cpus <= (busiest->idle_cpus + 1))) {
>                 /*
>                  * If the busiest group is not overloaded
>                  * and there is no imbalance between this and busiest group
> @@ -8661,15 +8662,14 @@ static struct sched_group *find_busiest_
>                  * group.
>                  */
>                 goto out_balanced;
> +       }
>
>  force_balance:
>         /* Looks like there is an imbalance. Compute it */
>         calculate_imbalance(env, &sds);
> -
>         return env->imbalance ? sds.busiest : NULL;
>
>  out_balanced:
> -
>         env->imbalance = 0;
>         return NULL;
>  }
