Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B535C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CEB21851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/TRN1HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfGSOC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 10:02:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35810 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSOC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:02:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id p197so21808482lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6EWjwfzPupLhNJ5UOgN7tpI5oc+mAJ5lVVKDhUsK6fY=;
        b=a/TRN1HUuWzEPMUOSfGnAklAOgkYnpaUTyWpI2s26jaaLKZ41flYjTB4a0iM7z5LiI
         QYRrcpDd/nCvytcEt+q70saM9LRdGjnt86kveGIaZx/H8i+DJPoAsZVT+Gk2u/mpu0fW
         dxDkNvOF6I3wy9kzj+RrvxHoys4Z6Du53RLcbK9XYFpf0Y8/TCmsml+7zM4Gd/BvHuf/
         kYPkpo/VSTI5M8qYK+5llL+O7wH0Q3SAdt3xHYUU9OR10Ip4C7FQ+8fahqFlTDlEYoK2
         VY5Eh0PIkktnZzFOTU6syfloORugABIiRy7SURP8h4TBzj6yDvpSvRv1aJ3g2FTWVkOi
         lwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6EWjwfzPupLhNJ5UOgN7tpI5oc+mAJ5lVVKDhUsK6fY=;
        b=tOGCQi2H2okmP3MekLeuWRS+HZI6V2fl7L9TJJRJkFzQKOiLxUu/q76Hu106pTbbRl
         PL+aPOotyNAJCUAY4XDg3YVu+wt6yhyv0QvrrQixEmr4Bivf2E7X1K97/6EUw4hF3W9K
         8omtjSkRrc1ewYMEu0rJmenZBwZd4tvqz6LV1NaA3cWcs08b3m04dhU77YQvkoRuvy+g
         MUg85yFYWbTn3crVFiGAxElenec+9DgLG1NGIP8lV8nGM7t2xb+DopVJjhM/4g3cqe+6
         I6ZIgfWPSIM0fbALuK2LZCh0FYsd1JVJ+boeda7gJp7Wj5TXHWj458j+RD49mDQOaDLX
         HamQ==
X-Gm-Message-State: APjAAAVAv7woEvcWAkiQ4cSybKqtQ0OWI1B+AeV2gwqwaknciH+JE9t2
        5BVjGMcTvERiZmlNMZq+jjSSIAO6E4OrJOh2hpebTQ==
X-Google-Smtp-Source: APXvYqy3N/Q1XNv2LXoYGfvPXRCjHd2p5BFJX8BloUL5zkcFf6DHxUZes6CeGlqt3kKufqu175e/8dTBCWwmJemlGB8=
X-Received: by 2002:ac2:418f:: with SMTP id z15mr22943139lfh.177.1563544946467;
 Fri, 19 Jul 2019 07:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org> <20190719125443.GJ3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190719125443.GJ3419@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 19 Jul 2019 16:02:15 +0200
Message-ID: <CAKfTPtBrogvg8Km1O9QOh=hoLM8g5Oc8gUKRoMmHpM54nueijw@mail.gmail.com>
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

On Fri, 19 Jul 2019 at 14:54, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 19, 2019 at 09:58:23AM +0200, Vincent Guittot wrote:
>
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 67f0acd..472959df 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5376,18 +5376,6 @@ static unsigned long capacity_of(int cpu)
> >       return cpu_rq(cpu)->cpu_capacity;
> >  }
> >
> > -static unsigned long cpu_avg_load_per_task(int cpu)
> > -{
> > -     struct rq *rq = cpu_rq(cpu);
> > -     unsigned long nr_running = READ_ONCE(rq->cfs.h_nr_running);
> > -     unsigned long load_avg = cpu_runnable_load(rq);
> > -
> > -     if (nr_running)
> > -             return load_avg / nr_running;
> > -
> > -     return 0;
> > -}
> > -
> >  static void record_wakee(struct task_struct *p)
> >  {
> >       /*
>
> > @@ -7646,7 +7669,6 @@ static unsigned long task_h_load(struct task_struct *p)
> >  struct sg_lb_stats {
> >       unsigned long avg_load; /*Avg load across the CPUs of the group */
> >       unsigned long group_load; /* Total load over the CPUs of the group */
> > -     unsigned long load_per_task;
> >       unsigned long group_capacity;
> >       unsigned long group_util; /* Total utilization of the group */
> >       unsigned int sum_nr_running; /* Nr tasks running in the group */
>
>
> > @@ -8266,76 +8293,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  }
> >
> >  /**
> > - * fix_small_imbalance - Calculate the minor imbalance that exists
> > - *                   amongst the groups of a sched_domain, during
> > - *                   load balancing.
> > - * @env: The load balancing environment.
> > - * @sds: Statistics of the sched_domain whose imbalance is to be calculated.
> > - */
> > -static inline
> > -void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
> > -{
> > -     unsigned long tmp, capa_now = 0, capa_move = 0;
> > -     unsigned int imbn = 2;
> > -     unsigned long scaled_busy_load_per_task;
> > -     struct sg_lb_stats *local, *busiest;
> > -
> > -     local = &sds->local_stat;
> > -     busiest = &sds->busiest_stat;
> > -
> > -     if (!local->sum_h_nr_running)
> > -             local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
> > -     else if (busiest->load_per_task > local->load_per_task)
> > -             imbn = 1;
> > -
> > -     scaled_busy_load_per_task =
> > -             (busiest->load_per_task * SCHED_CAPACITY_SCALE) /
> > -             busiest->group_capacity;
> > -
> > -     if (busiest->avg_load + scaled_busy_load_per_task >=
> > -         local->avg_load + (scaled_busy_load_per_task * imbn)) {
> > -             env->imbalance = busiest->load_per_task;
> > -             return;
> > -     }
> > -
> > -     /*
> > -      * OK, we don't have enough imbalance to justify moving tasks,
> > -      * however we may be able to increase total CPU capacity used by
> > -      * moving them.
> > -      */
> > -
> > -     capa_now += busiest->group_capacity *
> > -                     min(busiest->load_per_task, busiest->avg_load);
> > -     capa_now += local->group_capacity *
> > -                     min(local->load_per_task, local->avg_load);
> > -     capa_now /= SCHED_CAPACITY_SCALE;
> > -
> > -     /* Amount of load we'd subtract */
> > -     if (busiest->avg_load > scaled_busy_load_per_task) {
> > -             capa_move += busiest->group_capacity *
> > -                         min(busiest->load_per_task,
> > -                             busiest->avg_load - scaled_busy_load_per_task);
> > -     }
> > -
> > -     /* Amount of load we'd add */
> > -     if (busiest->avg_load * busiest->group_capacity <
> > -         busiest->load_per_task * SCHED_CAPACITY_SCALE) {
> > -             tmp = (busiest->avg_load * busiest->group_capacity) /
> > -                   local->group_capacity;
> > -     } else {
> > -             tmp = (busiest->load_per_task * SCHED_CAPACITY_SCALE) /
> > -                   local->group_capacity;
> > -     }
> > -     capa_move += local->group_capacity *
> > -                 min(local->load_per_task, local->avg_load + tmp);
> > -     capa_move /= SCHED_CAPACITY_SCALE;
> > -
> > -     /* Move if we gain throughput */
> > -     if (capa_move > capa_now)
> > -             env->imbalance = busiest->load_per_task;
> > -}
> > -
> > -/**
> >   * calculate_imbalance - Calculate the amount of imbalance present within the
> >   *                    groups of a given sched_domain during load balance.
> >   * @env: load balance environment
>
> Maybe strip this out first, in a separate patch. It's all magic doo-doo.

If I remove that 1st, we will have commit in the branch that might
regress some performance temporarily and bisect might spot it while
looking for a culprit, isn't it ?
