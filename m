Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B79C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5FA2187F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0+Hv9BP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404185AbfHBI3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:29:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46660 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfHBI3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:29:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so72178297ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 01:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kdl2R0IBgfjJB4JZRxhZE0/T9CpAtSy8txxcK/4WOWY=;
        b=R0+Hv9BP1gyMA34D02T3e8AtBzW0JtD9RzB2q43wKYUEP3bKsJazHF0UrcXlQ202mc
         VYwvt0uAQAfweMCxq143kYfgnONAJMLO+RG33VrfgllSUaYFX8DOfxhw7Cz8EVMIHu50
         5HlTJTzfBkpQqEopir2qfuJhDvNjTNzjhaQrpgDyJsEN+jvjQw79bFcF0wmJn+k3IGWY
         BMYVzWHffvW5dtEA6TvY4fUHj0RQQ60VjxarRrC2CO7/q5akiWvQ24+3iK7xRKHonm0s
         GMGYgYKWr8E5Jz1JLnkOoAUzbLfAznisfWLknafaUqDIU1VNUxUQyDTLc3GWLdv6uSF7
         fgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdl2R0IBgfjJB4JZRxhZE0/T9CpAtSy8txxcK/4WOWY=;
        b=SWVctuqCR6E+WFGGEcgLaVEyn27DN+4EJAoWceQNSdwkN6oiIQr6+DgWkpmB+8wpXu
         2Zf5QDLlRuoBfvdnutvUkSIPqrB5D+cBO4sSsWdTfOhbQewlqHmpXrksmY9azb2lXMeA
         aYqwkMIbZ4h1Z4PKAasPmmIyIzWTUlLJgtnpzSHENM51cFX3eQB1lIt5cZGZ+Dsqws9k
         AoLcCT4oYbfmhdpTNiNZRVvjILLYleqxr+M4WE5miPpi2F8r3uZHdPbiHRWjqOxkaa1f
         2l6ho4fri//gkCO5FnFYYGf3hiGrlKvppYE0B3d3lLVgdLtF9xwqJKCZgQ9JmdTJT5uc
         KwEA==
X-Gm-Message-State: APjAAAXjWlBRKapaFGXJn5nnn1cR63j7v4s/T4CK7B+fHUVxdKZuN9LV
        komyqmHjIRgxK5f81SEFA7RgSuuR7pz/1Abc1SqaLg==
X-Google-Smtp-Source: APXvYqwJwTHbJ0uwk+/AZGi4Vi/6dIysgXs+VXFlRpPMTwNulKwsAxuix0dgX1GFcTwKw2oVO2pgpAu7bJsdNj1ev0g=
X-Received: by 2002:a2e:995a:: with SMTP id r26mr70660632ljj.107.1564734557634;
 Fri, 02 Aug 2019 01:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-9-git-send-email-vincent.guittot@linaro.org> <22ba6771-8bde-8c6e-65e0-4ab2ebc6e018@arm.com>
In-Reply-To: <22ba6771-8bde-8c6e-65e0-4ab2ebc6e018@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 2 Aug 2019 10:29:06 +0200
Message-ID: <CAKfTPtApKzWZvD83QKwd4ZKhfsCyFMZffkyAOB5oYNgck5jbPw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] sched/fair: use utilization to select misfit task
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

On Thu, 1 Aug 2019 at 18:27, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 01/08/2019 15:40, Vincent Guittot wrote:
> > @@ -8261,7 +8261,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >                * If we have more than one misfit sg go with the
> >                * biggest misfit.
> >                */
> > -             if (sgs->group_misfit_task_load < busiest->group_misfit_task_load)
> > +             if (sgs->group_misfit_task_util < busiest->group_misfit_task_util)
> >                       return false;
>
> I previously said this change would render the maximization useless, but I
> had forgotten one thing: with PELT time scaling, task utilization can go
> above its CPU's capacity.
>
> So if you have two LITTLE CPUs running a busy loop (misfit task) each, the
> one that's been running the longest would have the highest utilization
> (assuming they haven't reached 1024 yet). In other words "utilizations
> above the capacity_margin can't be compared" doesn't really stand.
>
> Still, maximizing load would lead us there. Furthermore, if we have to pick
> between two rqs with misfit tasks, I still believe we should pick the one
> with the highest load, not the highest utilization.
>
> We could keep load and fix the issue of detaching the wrong task with
> something like:
>
> -----8<-----
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 53e64a7b2ae0..bfc2b624ee98 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7489,12 +7489,8 @@ static int detach_tasks(struct lb_env *env)
>                 case migrate_misfit:
>                         load = task_h_load(p);
>
> -                       /*
> -                        * utilization of misfit task might decrease a bit
> -                        * since it has been recorded. Be conservative in the
> -                        * condition.
> -                        */
> -                       if (load < env->imbalance)
> +                       /* This is not a misfit task */
> +                       if (task_fits_capacity(p, capacity_of(env->src_cpu)))
>                                 goto next;

This could be a solution for make sure to pull only misfit task and
keep using load

>
>                         env->imbalance = 0;
> ----->8-----
>
> However what would be *even* better IMO would be:
>
> -----8<-----
> @@ -8853,6 +8853,7 @@ voluntary_active_balance(struct lb_env *env)
>                         return 1;
>         }
>
> +       /* XXX: make sure current is still a misfit task? */
>         if (env->balance_type == migrate_misfit)
>                 return 1;
>
> @@ -8966,6 +8967,20 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>         env.src_rq = busiest;
>
>         ld_moved = 0;
> +
> +       /*
> +        * Misfit tasks are only misfit if they are currently running, see
> +        * update_misfit_status().
> +        *
> +        * - If they're not running, we'll get an opportunity at wakeup to
> +        *   migrate them to a bigger CPU.
> +        * - If they're running, we need to active balance them to a bigger CPU.
> +        *
> +        * Do the smart thing and go straight for active balance.
> +        */
> +       if (env->balance_type == migrate_misfit)
> +               goto active_balance;
> +

This looks ugly and add a new bypass which this patchset tries to remove
This doesn't work if your misfit task has been preempted by another
one during the load balance and waiting for the runqueue


>         if (busiest->nr_running > 1) {
>                 /*
>                  * Attempt to move tasks. If find_busiest_group has found
> @@ -9074,7 +9089,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                         goto out_all_pinned;
>                 }
>         }
> -
> +active_balance:
>         if (!ld_moved) {
>                 schedstat_inc(sd->lb_failed[idle]);
>                 /*
> ----->8-----
