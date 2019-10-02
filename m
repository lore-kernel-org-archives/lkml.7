Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4A0C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 06:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BF22086A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 06:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IpD0RgpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfJBGpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 02:45:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46214 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfJBGpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 02:45:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so11775393lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 23:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OtR3naGyQowawH2mmeSJPtdsB+JfD14a91q4v8Mut4=;
        b=IpD0RgpS2LYBMiwwuaArS1K8KLVRgxh2aOR1/BVWcaChPYeEH+9Pi6QeMSMBJxvvOs
         Ig4HijHQBdguqN6pqnyX7gKPw3J7wstAC91uzwpyIeovejSFoKa+Oqj/xf1iDAB/4eQ5
         VD12F/NqsNRCfL++Or47hFHXaQiSPNAB3mBTIokNisapvqbt17sZ2SgonOXL9U1IS70w
         gHJPG/b9mcIUm2MfAO5BncQBs9obXFgyBaKt2AIhWMZqxtoIqTRs8H+D0q3lbATKzS0C
         GYlY9xopBgZ76AEhdtq8FsfeQbaGCcaUKff17mDLE0rd86QK4v9ljHu32iFui0zz7Ghe
         42+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OtR3naGyQowawH2mmeSJPtdsB+JfD14a91q4v8Mut4=;
        b=J5rnT6CqOFwn/MW4Z4ot2WmIHm6S4clzfn7K4w4/gHKElOZw1tAmNx0VOqii4mu6nq
         fgnf4Hnr0S2yjRWqh9oSrVFMlD9MLbXciNtXqrNkD/dSb0wElZMdWrrGSq3Wi6K1Fshu
         qQk4r0Bnf6gF9EuWe5i3iGrJccJdE1L/7HwTUT2SWaJ5kYUAHRtM+CbSkDgibTkS7hD1
         hRMsxXDDSdwnd05macYrs+xgA/RKV7e1funOx/+nY0d5TR7mqsDP1AuHrZR0COAxACnv
         8XVtMuwoUxgJ4QvcrJE3lzL32XltPdakNX0cbaGpQmbSLwE9btNAPHcoAJtsnanCo51v
         NLHw==
X-Gm-Message-State: APjAAAVWaRZZNvhxzy2MOe/D/90FCoh8ySxPxKRpy+EFwdOGbPFN/k30
        nuJiWYn0wdmiSg7jGI3y/ROQpcLqT92hiuiefizWCw==
X-Google-Smtp-Source: APXvYqy6+X60Gn6P6523Pf3kaDAobFeY8RK93haDpjiL9ay6p2ItI3ZFN1onVLq7yrB8DFqje/YLT5AD3C/7gptkR7c=
X-Received: by 2002:a05:6512:304:: with SMTP id t4mr1194019lfp.15.1569998702932;
 Tue, 01 Oct 2019 23:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <9bfb3252-c268-8c0c-9c72-65f872e9c8b2@arm.com> <CAKfTPtDUFMFnD+RZndx0+8A+V9HV9Hv0TN+p=mAge0VsqS6xmA@mail.gmail.com>
 <3dca46c5-c395-e2b3-a7e8-e9208ba741c8@arm.com>
In-Reply-To: <3dca46c5-c395-e2b3-a7e8-e9208ba741c8@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 2 Oct 2019 08:44:51 +0200
Message-ID: <CAKfTPtDGxX11=vgJsV-o-jOxgPmbr0VXWmR6LEVuD6WG=VRXyA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 at 18:53, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 01/10/2019 10:14, Vincent Guittot wrote:
> > On Mon, 30 Sep 2019 at 18:24, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> Hi Vincent,
> >>
> >> On 19/09/2019 09:33, Vincent Guittot wrote:
>
> [...]
>
> >>> @@ -7347,7 +7362,7 @@ static int detach_tasks(struct lb_env *env)
> >>>   {
> >>>         struct list_head *tasks = &env->src_rq->cfs_tasks;
> >>>         struct task_struct *p;
> >>> -     unsigned long load;
> >>> +     unsigned long util, load;
> >>
> >> Minor: Order by length or reduce scope to while loop ?
> >
> > I don't get your point here
>
> Nothing dramatic here! Just
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d0c3aa1dc290..a08f342ead89 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7333,8 +7333,8 @@ static const unsigned int sched_nr_migrate_break = 32;
>  static int detach_tasks(struct lb_env *env)
>  {
>         struct list_head *tasks = &env->src_rq->cfs_tasks;
> -       struct task_struct *p;
>         unsigned long load, util;
> +       struct task_struct *p;

hmm... I still don't get this.
We usually gather pointers instead of interleaving them with other varaiables

>         int detached = 0;
>
>         lockdep_assert_held(&env->src_rq->lock);
>
> or
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d0c3aa1dc290..4d1864d43ed7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7334,7 +7334,6 @@ static int detach_tasks(struct lb_env *env)
>  {
>         struct list_head *tasks = &env->src_rq->cfs_tasks;
>         struct task_struct *p;
> -       unsigned long load, util;
>         int detached = 0;
>
>         lockdep_assert_held(&env->src_rq->lock);
> @@ -7343,6 +7342,8 @@ static int detach_tasks(struct lb_env *env)
>                 return 0;
>
>         while (!list_empty(tasks)) {
> +               unsigned long load, util;
> +
>                 /*
>
> [...]
>
> >>> @@ -8042,14 +8104,24 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >>>                 }
> >>>         }
> >>>
> >>> -     /* Adjust by relative CPU capacity of the group */
> >>> +     /* Check if dst cpu is idle and preferred to this group */
> >>
> >> s/preferred to/preferred by ? or the preferred CPU of this group ?
> >
> > dst cpu doesn't belong to this group. We compare asym_prefer_cpu of
> > this group vs dst_cpu which belongs to another group
>
> Ah, in the sense of 'preferred over'. Got it now!
>
> [...]
>
> >>> +     if (busiest->group_type == group_imbalanced) {
> >>> +             /*
> >>> +              * In the group_imb case we cannot rely on group-wide averages
> >>> +              * to ensure CPU-load equilibrium, try to move any task to fix
> >>> +              * the imbalance. The next load balance will take care of
> >>> +              * balancing back the system.
> >>
> >> balancing back ?
> >
> > In case of imbalance, we don't try to balance the system but only try
> > to get rid of the pinned tasks problem. The system will still be
> > unbalanced after the migration and the next load balance will take
> > care of balancing the system
>
> OK.
>
> [...]
>
> >>>         /*
> >>> -      * Avg load of busiest sg can be less and avg load of local sg can
> >>> -      * be greater than avg load across all sgs of sd because avg load
> >>> -      * factors in sg capacity and sgs with smaller group_type are
> >>> -      * skipped when updating the busiest sg:
> >>> +      * Try to use spare capacity of local group without overloading it or
> >>> +      * emptying busiest
> >>>          */
> >>> -     if (busiest->group_type != group_misfit_task &&
> >>> -         (busiest->avg_load <= sds->avg_load ||
> >>> -          local->avg_load >= sds->avg_load)) {
> >>> -             env->imbalance = 0;
> >>> +     if (local->group_type == group_has_spare) {
> >>> +             if (busiest->group_type > group_fully_busy) {
> >>
> >> So this could be 'busiest->group_type == group_overloaded' here to match
> >> the comment below? Since you handle group_misfit_task,
> >> group_asym_packing, group_imbalanced above and return.
> >
> > This is just to be more robust in case some new states are added later
>
> OK, although I doubt that additional states can be added easily w/o
> carefully auditing the entire lb code ;-)
>
> [...]
>
> >>> +             if (busiest->group_weight == 1 || sds->prefer_sibling) {
> >>> +                     /*
> >>> +                      * When prefer sibling, evenly spread running tasks on
> >>> +                      * groups.
> >>> +                      */
> >>> +                     env->balance_type = migrate_task;
> >>> +                     env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
> >>> +                     return;
> >>> +             }
> >>> +
> >>> +             /*
> >>> +              * If there is no overload, we just want to even the number of
> >>> +              * idle cpus.
> >>> +              */
> >>> +             env->balance_type = migrate_task;
> >>> +             env->imbalance = max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1);
> >>
> >> Why do we need a max_t(long, 0, ...) here and not for the 'if
> >> (busiest->group_weight == 1 || sds->prefer_sibling)' case?
> >
> > For env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
> >
> > either we have sds->prefer_sibling && busiest->sum_nr_running >
> > local->sum_nr_running + 1
>
> I see, this corresponds to
>
> /* Try to move all excess tasks to child's sibling domain */
>        if (sds.prefer_sibling && local->group_type == group_has_spare &&
>            busiest->sum_h_nr_running > local->sum_h_nr_running + 1)
>                goto force_balance;
>
> in find_busiest_group, I assume.

yes, it is

>
> Haven't been able to recreate this yet on my arm64 platform since there
> is no prefer_sibling and in case local and busiest have

You probably have a b.L platform for which the flag is cleared because
the hikey (dual quad cores arm64) takes advantage of  prefer sibling
at DIE level to spread tasks

> group_type=group_has_spare they bailout in
>
>          if (busiest->group_type != group_overloaded &&
>               (env->idle == CPU_NOT_IDLE ||
>                local->idle_cpus <= (busiest->idle_cpus + 1)))
>                  goto out_balanced;
>
>
> [...]
>
> >>> -     if (busiest->group_type == group_overloaded &&
> >>> -         local->group_type   == group_overloaded) {
> >>> -             load_above_capacity = busiest->sum_h_nr_running * SCHED_CAPACITY_SCALE;
> >>> -             if (load_above_capacity > busiest->group_capacity) {
> >>> -                     load_above_capacity -= busiest->group_capacity;
> >>> -                     load_above_capacity *= scale_load_down(NICE_0_LOAD);
> >>> -                     load_above_capacity /= busiest->group_capacity;
> >>> -             } else
> >>> -                     load_above_capacity = ~0UL;
> >>> +     if (local->group_type < group_overloaded) {
> >>> +             /*
> >>> +              * Local will become overloaded so the avg_load metrics are
> >>> +              * finally needed.
> >>> +              */
> >>
> >> How does this relate to the decision_matrix[local, busiest] (dm[])? E.g.
> >> dm[overload, overload] == avg_load or dm[fully_busy, overload] == force.
> >> It would be nice to be able to match all allowed fields of dm to code sections.
> >
> > decision_matrix describes how it decides between balanced or unbalanced.
> > In case of dm[overload, overload], we use the avg_load to decide if it
> > is balanced or not
>
> OK, that's why you calculate sgs->avg_load in update_sg_lb_stats() only
> for 'sgs->group_type == group_overloaded'.
>
> > In case of dm[fully_busy, overload], the groups are unbalanced because
> > fully_busy < overload and we force the balance. Then
> > calculate_imbalance() uses the avg_load to decide how much will be
> > moved
>
> And in this case 'local->group_type < group_overloaded' in
> calculate_imbalance(), 'local->avg_load' and 'sds->avg_load' have to be
> calculated before using them in env->imbalance = min(...).
>
> OK, got it now.
>
> > dm[overload, overload]=force means that we force the balance and we
> > will compute later the imbalance. avg_load may be used to calculate
> > the imbalance
> > dm[overload, overload]=avg_load means that we compare the avg_load to
> > decide whether we need to balance load between groups
> > dm[overload, overload]=nr_idle means that we compare the number of
> > idle cpus to decide whether we need to balance.  In fact this is no
> > more true with patch 7 because we also take into account the number of
> > nr_h_running when weight =1
>
> This becomes clearer now ... slowly.
>
> [...]
