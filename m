Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A5FC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845BC2071A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSRiRaYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgAFNzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:55:16 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37136 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgAFNzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:55:16 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so36437906lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 05:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9DP0rsPqWxy7MwVvf36OXzevNDNWTBmT6iqvtpNHwg=;
        b=kSRiRaYikPvNWVAc/GNvgxit4T/CDdwj2hFtnxLzv36qoT/k0QZ3J2ndkZD+3kPGHl
         WhtNn++/IS3xm6Wx3lzMwtb4s+RUxOjsFL6PxHbX0s/T4eoZcev4ORzvQKvK+T9MThCY
         2XBl2u7Jd9BF4Vq1h4/udACJZRBiwyLJuR3kExek1l2WULb0ojZgLjnNkNKhZoW6iLZJ
         OVyBGY7cpzZs7+vS95Am6Zh16Pd6WRdI+xQBnv3AfT7Ckey5ksoITYuRLfhiymjg8bbA
         Tg8rWMJ3u6UrBn3gsbyHkCZsVeE66heH/7uitT/rJTH7G8wGvf5e9zaofVexl38zK/bA
         Y18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9DP0rsPqWxy7MwVvf36OXzevNDNWTBmT6iqvtpNHwg=;
        b=tdGt+X4+4MbBGUXoW/+yGcnts1v28D53ZVJiF74uKMhTfPlr75IQfoHAqUPFUD94cQ
         LWozBkLfuvp5KJFqVRz4hREqePhgJgScwn1fz8GkJTqmcRssEgGsPIrs8/KIF4DHpP62
         sbi8fo3NySmuDan7nLhddU33QWP9yLjqoAoyW+mu/6N/aBNmMGjh1Qf8Ih1RzNYNcJMB
         GoX1xTZkXNYn5FhNEZBGK+vljnJfpKFQbs16dHk3dICzF7BqYQPcpIva2UMkPLVud+VP
         dlhk5LM1pJLYay7h/zDNed3YU0DsJLRxWb8rnUq7PFPw8XV67fuSqleOchTpDancKHqP
         tYaw==
X-Gm-Message-State: APjAAAVM9F4I/6TtVxoanFtXgEBqKWGJ7qW9+1WrwB4L7ABdBrHNo58/
        aAlxl6j8zzCVLJsauk3qQYAIs/JF3ceGQHH3F4cGIQ==
X-Google-Smtp-Source: APXvYqwvaqfdoMt0kpdtxjIZN2K1vlqB+WaxdYwwaZkex5VkZ9UUOOhIinjJAZf8TLkROeWJrn7AMqhz9q23f93tqKk=
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr56008367lfp.133.1578318912323;
 Mon, 06 Jan 2020 05:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20191220084252.GL3178@techsingularity.net> <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net>
In-Reply-To: <20200103143051.GA3027@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 6 Jan 2020 14:55:00 +0100
Message-ID: <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
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

On Fri, 3 Jan 2020 at 15:31, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Dec 23, 2019 at 02:31:40PM +0100, Vincent Guittot wrote:
> > > +               /* Consider allowing a small imbalance between NUMA groups */
> > > +               if (env->sd->flags & SD_NUMA) {
> > > +                       unsigned int imbalance_adj, imbalance_max;
> > > +
> > > +                       /*
> > > +                        * imbalance_adj is the allowable degree of imbalance
> > > +                        * to exist between two NUMA domains. It's calculated
> > > +                        * relative to imbalance_pct with a minimum of two
> > > +                        * tasks or idle CPUs. The choice of two is due to
> > > +                        * the most basic case of two communicating tasks
> > > +                        * that should remain on the same NUMA node after
> > > +                        * wakeup.
> > > +                        */
> > > +                       imbalance_adj = max(2U, (busiest->group_weight *
> > > +                               (env->sd->imbalance_pct - 100) / 100) >> 1);
> > > +
> > > +                       /*
> > > +                        * Ignore small imbalances unless the busiest sd has
> > > +                        * almost half as many busy CPUs as there are
> > > +                        * available CPUs in the busiest group. Note that
> > > +                        * it is not exactly half as imbalance_adj must be
> > > +                        * accounted for or the two domains do not converge
> > > +                        * as equally balanced if the number of busy tasks is
> > > +                        * roughly the size of one NUMA domain.
> > > +                        */
> > > +                       imbalance_max = (busiest->group_weight >> 1) + imbalance_adj;
> > > +                       if (env->imbalance <= imbalance_adj &&
> >
> > AFAICT, env->imbalance is undefined there. I have tried your patch
> > with the below instead
> >
>
> Even when fixed, other corner cases were hit for parallelised loads that
> benefit from spreading early. At the moment I'm testing a variant of the
> first approach except it adjust small balances at low utilisation and
> otherwise balances at normal. It appears to work for basic communicating
> tasks at relatively low utitisation that fits within a node without
> obviously impacting higher utilisation non-communicating workloads but
> more testing time will be needed to be sure.
>
> It's still based on sum_nr_running as a cut-off instead of idle_cpus as
> at low utilisation, there is not much of a material difference in the
> cut-offs given that either approach can be misleading depending on the
> load of the individual tasks, any cpu binding configurations and the
> degree the tasks are memory-bound.
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ba749f579714..58ba2f0c6363 100644
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
> @@ -8691,16 +8686,39 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
> +                       long imbalance_adj, imbalance_max;
> +
> +                       /*
> +                        * imbalance_adj is the allowable degree of imbalance
> +                        * to exist between two NUMA domains. imbalance_pct
> +                        * is used to estimate the number of active tasks
> +                        * needed before memory bandwidth may be as important
> +                        * as memory locality.
> +                        */
> +                       imbalance_adj = (100 / (env->sd->imbalance_pct - 100)) - 1;

This looks weird to me because you use imbalance_pct, which is
meaningful only compare a ratio, to define a number that will be then
compared to a number of tasks without taking into account the weight
of the node. So whatever the node size, 32 or 128 CPUs, the
imbalance_adj will be the same: 3 with the default imbalance_pct of
NUMA level which is 125 AFAICT

> +
> +                       /*
> +                        * Allow small imbalances when the busiest group has
> +                        * low utilisation.
> +                        */
> +                       imbalance_max = imbalance_adj << 1;

Why do you add this shift ?

So according to the above, imbalance_max = 6 whatever the size of the node


Regards,
Vincent

> +                       if (busiest->sum_nr_running < imbalance_max)
> +                               env->imbalance -= min(env->imbalance, imbalance_adj);
> +               }
> +
>                 return;
>         }
>
>
> --
> Mel Gorman
> SUSE Labs
