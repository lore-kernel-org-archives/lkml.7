Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8560EC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D280207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRbppRlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgAGLR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:17:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34945 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:17:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so46902927lja.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 03:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ra1FY4mZ9CXnNY3eDBohJo5ZazEaF4PWeNH2sgfSeSg=;
        b=WRbppRloB391UQkHqLj4ZZhn3hBElJYbzX7xyV+PJjhudApupCmrrrxBxJBYh6KNY8
         udzFrGf8r10e7z1y4NzHGVwoBh5cw6nISnHKWVoENJGrkmYhk74GPoNU6WSyR9dS9hnn
         zAv/bZjnne6j8EtoQOD9DF6LYwTBR626paR4x14dvAafrXbhOR6VDueEtW7PgB141cSE
         eVoofoJdJCdW0eMZ52lEq3yutxdQxywGVEoVxGRPznVgmitPUph64iAhZwxBrjJPvIjI
         m/RQfLi8z+h5a72jeRjNSqGCCjDbWGJvoXv+wTKaX9kaCL3eYmDNJkvYz7rkV7WRJ1Cm
         XIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ra1FY4mZ9CXnNY3eDBohJo5ZazEaF4PWeNH2sgfSeSg=;
        b=lHEQBJcOPaS6v44LYAtU8esYwyLt88WMSLzxTnWPPT+Kd/WhzSmWiGnOkqq3gqpga/
         ztxGditjgsjEzE8XGkSzRmCDVSpNJ+4VWkiyei8c+LxnFUHO7ixGRLjQB4WhjKE4rxLz
         bHY2AOk7ktGdDRrqF2paRvesbaGz1v9te9NbIcjtziXHK60LrioJuT0gE5LGd+AVCN4z
         9XkpI5FKxpxm9kFMn8/ERoXo9NhtRkSHLVpg+1mQxB1Cm+AP5KeDw3MDT2R4UGXVg1Zx
         RvqJPTitGVik9DMEJFmiwvZcfIVTt2VlEG/EuUn7qJKiaU4VR+O2A+biO2Gew7fHc5qT
         VOXg==
X-Gm-Message-State: APjAAAUIhYKDynbwRMAG7gl4vpewwoutmPWGRV0LqsjCLmZVeFrvUMEB
        QqeBCmGJ1aSrjhRbFHuUCOhtYQkrW29RN+OF6pBhbbOzK/ZVbA==
X-Google-Smtp-Source: APXvYqyvHmUcwd1rG9Ah1cOjj7p8GSM5hAzWmwyxCWLGIqC/XMxYB34G4n/uLYW6loZtfnFOcCFLal0DNdO3/kcYANM=
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr64355892ljn.48.1578395844595;
 Tue, 07 Jan 2020 03:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20191220084252.GL3178@techsingularity.net> <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net> <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
 <20200106145225.GB3466@techsingularity.net> <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
 <20200107095655.GF3466@techsingularity.net>
In-Reply-To: <20200107095655.GF3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Jan 2020 12:17:12 +0100
Message-ID: <CAKfTPtAtJSWGPC1t+0xj_Daid0fZaWnN+b53WQ_a1-Js5fJ6sg@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 at 10:56, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Jan 07, 2020 at 09:38:26AM +0100, Vincent Guittot wrote:
> > > > This looks weird to me because you use imbalance_pct, which is
> > > > meaningful only compare a ratio, to define a number that will be then
> > > > compared to a number of tasks without taking into account the weight
> > > > of the node. So whatever the node size, 32 or 128 CPUs, the
> > > > imbalance_adj will be the same: 3 with the default imbalance_pct of
> > > > NUMA level which is 125 AFAICT
> > > >
> > >
> > > The intent in this version was to only cover the low utilisation case
> > > regardless of the NUMA node size. There were too many corner cases
> > > where the tradeoff of local memory latency versus local memory bandwidth
> > > cannot be quantified. See Srikar's report as an example but it's a general
> > > problem. The use of imbalance_pct was simply to find the smallest number of
> > > running tasks were (imbalance_pct - 100) would be 1 running task and limit
> >
> > But using imbalance_pct alone doesn't mean anything.
>
> Other than figuring out "how many running tasks are required before
> imbalance_pct is roughly equivalent to one fully active CPU?". Even then,

sorry, I don't see how you deduct this from only using imbalance_pct
which is mainly there to say how much percent of difference is
significant

> it's a bit weak as imbalance_pct makes hard-coded assumptions on what
> the tradeoff of cross-domain migration is without considering the hardware.
>
> > Using similar to the below
> >
> >     busiest->group_weight * (env->sd->imbalance_pct - 100) / 100
> >
> > would be more meaningful
> >
>
> It's meaningful to some sense from a conceptual point of view but
> setting the low utilisation cutoff depending on the number of CPUs on
> the node does not account for any local memory latency vs bandwidth.
> i.e. on a small or mid-range machine the cutoff will make sense. On
> larger machines, the cutoff could be at the point where memory bandwidth
> is saturated leading to a scenario whereby upgrading to a larger
> machine performs worse than the smaller machine.
>
> Much more importantly, doing what you suggest allows an imbalance
> of more CPUs than are backed by a single LLC. On high-end AMD EPYC 2
> machines, busiest->group_weight scaled by imbalance_pct spans multiple L3
> caches. That is going to have side-effects. While I also do not account
> for the LLC group_weight, it's unlikely the cut-off I used would be
> smaller than an LLC cache on a large machine as the cache.
>
> These two points are why I didn't take the group weight into account.
>
> Now if you want, I can do what you suggest anyway as long as you are happy
> that the child domain weight is also taken into account and to bound the

Taking into account child domain makes sense to me, but shouldn't we
take into account the number of child group instead ? This should
reflect the number of different LLC caches.
IIUC your reasoning, we want to make sure that tasks will not start to
fight for using same resources which is the connection between LLC
cache and memory in this case

> largest possible allowed imbalance to deal with the case of a node having
> multiple small LLC caches. That means that some machines will be using the
> size of the node and some machines will use the size of an LLC. It's less
> predictable overall as some machines will be "special" relative to others
> making it harder to reproduce certain problems locally but it would take
> imbalance_pct into account in a way that you're happy with.
>
> Also bear in mind that whether LLC is accounted for or not, the final
> result should be halved similar to the other imbalance calculations to
> avoid over or under load balancing.
>
> > Or you could use the util_avg so you will take into account if the
> > tasks are short running ones or long running ones
> >
>
> util_avg can be skewed if there are big outliers. Even then, it's not
> a great metric for the low utilisation cutoff. Large numbers of mostly
> idle but running tasks would be treated similarly to small numbers of
> fully active tasks. It's less predictable and harder to reason about how

Yes but this also have the advantage of reflecting more accurately how
the system is used.
with nr_running, we consider that mostly idle and fully active tasks
will have the exact same impact on the memory

> load balancing behaves across a variety of workloads.
>
> Based on what you suggest, the result looks like this (build tested
> only)

I'm going to make a try of this patch

>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ba749f579714..1b2c7bed2db5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8648,10 +8648,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>         /*
>          * Try to use spare capacity of local group without overloading it or
>          * emptying busiest.
> -        * XXX Spreading tasks across NUMA nodes is not always the best policy
> -        * and special care should be taken for SD_NUMA domain level before
> -        * spreading the tasks. For now, load_balance() fully relies on
> -        * NUMA_BALANCING and fbq_classify_group/rq to override the decision.
>          */
>         if (local->group_type == group_has_spare) {
>                 if (busiest->group_type > group_fully_busy) {
> @@ -8691,16 +8687,41 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>                         env->migration_type = migrate_task;
>                         lsub_positive(&nr_diff, local->sum_nr_running);
>                         env->imbalance = nr_diff >> 1;
> -                       return;
> -               }
> +               } else {
>
> -               /*
> -                * If there is no overload, we just want to even the number of
> -                * idle cpus.
> -                */
> -               env->migration_type = migrate_task;
> -               env->imbalance = max_t(long, 0, (local->idle_cpus -
> +                       /*
> +                        * If there is no overload, we just want to even the number of
> +                        * idle cpus.
> +                        */
> +                       env->migration_type = migrate_task;
> +                       env->imbalance = max_t(long, 0, (local->idle_cpus -
>                                                  busiest->idle_cpus) >> 1);
> +               }
> +
> +               /* Consider allowing a small imbalance between NUMA groups */
> +               if (env->sd->flags & SD_NUMA) {
> +                       struct sched_domain *child = env->sd->child;
> +                       unsigned int imbalance_adj;
> +
> +                       /*
> +                        * Calculate an acceptable degree of imbalance based
> +                        * on imbalance_adj. However, do not allow a greater
> +                        * imbalance than the child domains weight to avoid
> +                        * a case where the allowed imbalance spans multiple
> +                        * LLCs.
> +                        */
> +                       imbalance_adj = busiest->group_weight * (env->sd->imbalance_pct - 100) / 100;
> +                       imbalance_adj = min(imbalance_adj, child->span_weight);
> +                       imbalance_adj >>= 1;
> +
> +                       /*
> +                        * Ignore small imbalances when the busiest group has
> +                        * low utilisation.
> +                        */
> +                       if (busiest->sum_nr_running < imbalance_adj)
> +                               env->imbalance = 0;
> +               }
> +
>                 return;
>         }
>
