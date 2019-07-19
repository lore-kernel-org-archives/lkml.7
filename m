Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B242CC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8619E20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xg96+YfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfGSONv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 10:13:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33560 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfGSONv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:13:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id x3so21939095lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CPzb137jbBN8kUQrMU0xxiOnMb9J48iFwx8DzRI+ms=;
        b=xg96+YfKcXrgzX8Dj2Z2vJOfvF707j/Vr6GqOYNRe2JqL3B8HjZ2MJw0R63wzMH0ty
         qxZh+L6/4S21YrjtpvnRlYmv7Vvz8lWR0Z8AKTS/NvWwZAKwzcPtCaHYITlZZ966G8fp
         MdJkuw1N9hVQY9misdPMlhAtlceJFb3KTEDIQ/6p0JGpe/wbmB+FhhISmKe+6wbPzQK3
         C4Rvhnizme88QNvubuKQkzgZ83igQK7tBCzhazRuNhgXZH9+T1zAiBRW0f+HLujT11HJ
         Gk+uOsyOn9ut/hZ7k/2clkEIRnuVNttSZ4794BKKsY3Z3aqres7W/3rk2reWfRq4/pU7
         w93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CPzb137jbBN8kUQrMU0xxiOnMb9J48iFwx8DzRI+ms=;
        b=UeOPY0mT3HHGJeUH5qJicoqqzS7UJJzN7X9dn+gHUnPMmTs2+QReC8DEH8EPMpb659
         9Jt/tnNUJ5vSj6zQcn2WdQDQ27uWsVSywRaSq2jxkckCxKkVEvK1x8TacotYxxLVIyev
         74iiyHb1NoBj4tyq9AFnRKUiJeCTlfLuG9TOPDn5qreEvwK+ZwAx0yWhpoSeX7mel5p5
         d9I9TQYhjJFQC3fcRvuMG6zFfXOQxhCo7H2WUgJin1wh9Nzy9/3LD++rh1MwRdei50SO
         tKbx7ynSbo9HDWerd4jWOX5hzwKVvkDFlx8QmTs802kY49o+XtwE+WMoODM/0Lt/YFbF
         gnYw==
X-Gm-Message-State: APjAAAUUhN4v6rTMDyuaz9mCdT/mOu0i1OzvRk79P863FAllHF/Djgt/
        PF+AvBdwCaaFr8TqJH9ZFtpmh/MvrFfVWDUXfuN+vvqGULM=
X-Google-Smtp-Source: APXvYqx7EB6IEx23PT6ul03UtGFFgXNVwuuYt+FzoCItyGztduCZKRbBzSTFt0pLROzBo8DZ6MAQx00voCl6A/GTnK4=
X-Received: by 2002:a19:ec15:: with SMTP id b21mr26250593lfa.32.1563545628931;
 Fri, 19 Jul 2019 07:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org> <20190719131255.GL3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190719131255.GL3419@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 19 Jul 2019 16:13:38 +0200
Message-ID: <CAKfTPtAbA7aowCZOHAqaeHSH09osrq62zE+fEKcAZMw3fRiTMQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Phil Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2019 at 15:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 19, 2019 at 09:58:23AM +0200, Vincent Guittot wrote:
>
> > @@ -8029,17 +8063,24 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >               }
> >       }
> >
> > -     /* Adjust by relative CPU capacity of the group */
> > -     sgs->group_capacity = group->sgc->capacity;
> > -     sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
> > +     /* Check if dst cpu is idle and preferred to this group */
> > +     if (env->sd->flags & SD_ASYM_PACKING &&
> > +         env->idle != CPU_NOT_IDLE &&
> > +         sgs->sum_h_nr_running &&
> > +         sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
> > +             sgs->group_asym_capacity = 1;
> > +     }
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
>
> The comment seems to suggest you meant: ==

yes looks like you're right :-(

>
> > +             sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) /
> > +                             sgs->group_capacity;
> >  }
> >
> >  /**
> > @@ -8070,7 +8111,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >        */
> >       if (sgs->group_type == group_misfit_task &&
> >           (!group_smaller_max_cpu_capacity(sg, sds->local) ||
> > -          !group_has_capacity(env, &sds->local_stat)))
> > +          sds->local_stat.group_type != group_has_spare))
> >               return false;
> >
> >       if (sgs->group_type > busiest->group_type)
> > @@ -8079,11 +8120,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >       if (sgs->group_type < busiest->group_type)
> >               return false;
> >
> > -     if (sgs->avg_load <= busiest->avg_load)
> > +     /* Select the overloaded group with highest avg_load */
> > +     if (sgs->group_type == group_overloaded &&
> > +         sgs->avg_load <= busiest->avg_load)
>
> And this code does too; because with the above '!=', you're comparing
> uninitialized data here, no?

avg_load is always 0
and the load_balance was quite conservative when system was overloaded

>
> > +             return false;
> > +
> > +     /* Prefer to move from lowest priority CPU's work */
> > +     if (sgs->group_type == group_asym_capacity && sds->busiest &&
> > +         sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
> >               return false;
> >
> >       if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
> > -             goto asym_packing;
> > +             goto spare_capacity;
> >
> >       /*
> >        * Candidate sg has no more than one task per CPU and
