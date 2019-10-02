Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09542C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BFC21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s98jtjqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfJBIXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:23:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38570 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfJBIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:23:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id u28so12036032lfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 01:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wxn26f7esoBnXGAUeDxZNvmoii+91yOfIb6hiRrAjvc=;
        b=s98jtjqmZwOQzkT8s+OYqj1z/yNACHb9TzVhHMDOxLtgc2+5rXIdQHwUH6VHzW9yAr
         u1w/QHSMLNeEPwyVCQG+KchVrG5OCTPMAU7aD2XgUP/fABs7YSmVQu+2TIJxZdkSTRB5
         d5gPOmubutulTOWqio61D0GFPltEhV3kR4sUB1aR/PSTcv78TfArlVTFIh5n36VNQvnb
         U9HAj/hgLiZyHXU6jHEUDzWY0D+gh1t9b3mmHGRHoGdrtqGZ5N03lR7a5JTwDDUPiRO4
         RanjcK4FMU+dNa7EcKKreGIA2OicrFu2Ekt2K8oNNSOyxxR9xLPrZglWcaWlxnKDhJBz
         Wwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wxn26f7esoBnXGAUeDxZNvmoii+91yOfIb6hiRrAjvc=;
        b=sF9LYiwmVeoepuwbeMCOeF8HV3whWD5nAlju8Jst7GHqrL4N7bJol0z3MhJioDBfHn
         JICMZVGAeLKTOshFUnBcG2o0vfcCMl9CNPEgGl4xzLlHQttzcYQDeb3CuqM3G+PahbfN
         cfp4O9ImppP6cWoG43X46ZrnJGDjFS1VTfjViLj6D2fiR8ks3mCc//1aMVqrTNXRaM7X
         fqJLl7OjkMa+ahG9tVtoqt25Td7YmJVOkuhROO+06qrSO3ljUY6f4OwsBxilhGrpes/r
         alN1f8XaEB7yDFDJeL5YrdAwS+NuQR5aCyWlKxbORI870h27/3oUU+IoeHTT4YvaITbu
         7wyg==
X-Gm-Message-State: APjAAAUbwJIM5onmK6Cqdq5BQOr+0YnGTbRBxe5x5PFBqF1onGQ75x9I
        7UHtOB1YCrsOmcVAexPcKRBAju8mMEd53P5jQ+dIkA==
X-Google-Smtp-Source: APXvYqxZbVY55mwRNtros8oHqX+pqf8Ghklt8+ValqUk7fX7KpxCUjHGkQwGtVY+cgG0B1VGcebuCM7peY2JSoBXHp4=
X-Received: by 2002:a05:6512:304:: with SMTP id t4mr1501062lfp.15.1570004608224;
 Wed, 02 Oct 2019 01:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <9bfb3252-c268-8c0c-9c72-65f872e9c8b2@arm.com> <CAKfTPtDUFMFnD+RZndx0+8A+V9HV9Hv0TN+p=mAge0VsqS6xmA@mail.gmail.com>
 <3dca46c5-c395-e2b3-a7e8-e9208ba741c8@arm.com>
In-Reply-To: <3dca46c5-c395-e2b3-a7e8-e9208ba741c8@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 2 Oct 2019 10:23:16 +0200
Message-ID: <CAKfTPtAOErKG3XJDbLQEGgqs485ad4R7xc3k1UA9h5092GnkqQ@mail.gmail.com>
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
[...]

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

yes. But it seems that I missed a case:

prefer_sibling is set
busiest->sum_h_nr_running <= local->sum_h_nr_running + 1 so we skip
goto force_balance above
But env->idle != CPU_NOT_IDLE  and local->idle_cpus >
(busiest->idle_cpus + 1) so we also skip goto out_balance and finally
call calculate_imbalance()

in calculate_imbalance with prefer_sibling set, imbalance =
(busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;

so we probably want something similar to max_t(long, 0,
(busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1)

>
> Haven't been able to recreate this yet on my arm64 platform since there
> is no prefer_sibling and in case local and busiest have
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
