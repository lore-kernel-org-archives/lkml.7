Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76D9C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F44206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PONKABbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfJBIbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:31:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38901 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfJBIbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:31:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id b20so16193080ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 01:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42ZwQ2L8M5MJa5KRQ4XrIfZwc9ii86LEtw7sm/nefwc=;
        b=PONKABboRBdjEi9olZIKarJkaAgK8/WETMkf/TppdJPizomPdJl+798WY4nRHCvl6y
         OE8VdcrHVOXFXO3Yt/nzoJbPe1w7Axhyv7WVMWwYMc/nWEvihcFRwxLoNi4uGwCO3LCA
         n97pANBnISncCFOXH7JIIyuxVHxhl4+/VZUS+N75iN27wUUgR+ZE4FhGNYfNQGJ+FkQe
         On+PkEVe2Y/0heRMrEkFGHTUl3QgJqfM9yikCbYko1rScbo+iLOJurYFVp0jgtebLuDN
         ss+iQJ/c63K8QoZqzdpg7U3GQRbby4HCsuZWubF2KH/aNPQleC27in6mc1tPM9CLCNlx
         KKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42ZwQ2L8M5MJa5KRQ4XrIfZwc9ii86LEtw7sm/nefwc=;
        b=H9qaiblx2T9htmraKx2dkP2t3HYF7ofhwpmGWIdwchyDBGWgRIIMBfOtD+OH4nMhyU
         D/N/37RcB8XvCjF8rLn7rTBwK2MaIuftLOH9ApGArkAt9OWoLCZOjrg7JsUz8aMUbVXO
         AcFN2xABDLEmpxyY4/tYiutyC0oAZrWXL6Sa++VmZXBYIiOsEtG2Lh3vaKx2DwefyxvF
         z9MDlMbdga28w7u5OGpctVqMu78Apt3QLA3B5ZipVCnkh2X54S82kG/+o7E4RLb7m7ac
         85Miu28CxR3rghKZPejGbvYljJVUnjf3RN/qkPlo9bMvMAF/FSoWbHU2PsAuUkLnWzCO
         FfbA==
X-Gm-Message-State: APjAAAX/mnqTR+VzFKl7yWdG5Y7TLRSAJ57QjevLAAxLjhgIYCLYcwsH
        AQnw3BSmCScqGa7D0MSoR9WxQIvbdlkAbSwJqoHvhQ==
X-Google-Smtp-Source: APXvYqwiKl+ehZKsT7FTU/RCmw4iHTPZErwQL6q6n9MKHLvPvSzC8U9fDcwUWCyUrh1lEiDxtiyOgnVDUsoh9sLvArg=
X-Received: by 2002:a2e:42c9:: with SMTP id h70mr1538711ljf.88.1570005071461;
 Wed, 02 Oct 2019 01:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org> <c752dd1a-731e-aae3-6a2c-aecf88901ac0@arm.com>
In-Reply-To: <c752dd1a-731e-aae3-6a2c-aecf88901ac0@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 2 Oct 2019 10:30:59 +0200
Message-ID: <CAKfTPtBQNJfNmBqpuaefsLzsTrGxJ=2bTs+tRdbOAa9J3eKuVw@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 at 19:47, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 19/09/2019 08:33, Vincent Guittot wrote:
>
> [...]
>
> > @@ -8283,69 +8363,133 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >   */
> >  static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
> >  {
> > -     unsigned long max_pull, load_above_capacity = ~0UL;
> >       struct sg_lb_stats *local, *busiest;
> >
> >       local = &sds->local_stat;
> >       busiest = &sds->busiest_stat;
> >
> > -     if (busiest->group_asym_packing) {
> > +     if (busiest->group_type == group_misfit_task) {
> > +             /* Set imbalance to allow misfit task to be balanced. */
> > +             env->balance_type = migrate_misfit;
> > +             env->imbalance = busiest->group_misfit_task_load;
> > +             return;
> > +     }
> > +
> > +     if (busiest->group_type == group_asym_packing) {
> > +             /*
> > +              * In case of asym capacity, we will try to migrate all load to
> > +              * the preferred CPU.
> > +              */
> > +             env->balance_type = migrate_load;
> >               env->imbalance = busiest->group_load;
> >               return;
> >       }
> >
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
> > +
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
>
> Isn't that one somewhat risky?
>
> Say both groups are classified group_has_spare and we do prefer_sibling.
> We'd select busiest as the one with the maximum number of busy CPUs, but it
> could be so that busiest.sum_h_nr_running < local.sum_h_nr_running (because
> pinned tasks or wakeup failed to properly spread stuff).
>
> The thing should be unsigned so at least we save ourselves from right
> shifting a negative value, but we still end up with a gygornous imbalance
> (which we then store into env.imbalance which *is* signed... Urgh).

so it's not clear what happen with a right shift on negative signed
value and this seems to be compiler dependent so even
max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1) might be wrong

I'm going to update it


>
> [...]
