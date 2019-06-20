Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC18C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A742082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBHLvdfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfFTXId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 19:08:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55999 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfFTXId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 19:08:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so4587416wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 16:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LOO+fOTiWxxrcl9IAX3uOVZS6CrJaEVfcKl/F7DKC8=;
        b=hBHLvdfJp6e2vDiZpbVwFjswDQFA9EB0H5EST0nBX0ezy0UnPiJOc0XeNnGN/CjQT0
         cMQ/DV7b34rLqctax5VcoUKbCHo+GrEqiagsdcsz6vPOltSfUryoF1TFvPMMeILGjJfS
         KKoMEIUv4aujsJpxlwcoJrCvGjQBUonLl8vJ3bZ689OXTUzw8iOf7QY1YRROWPLjjzdB
         mWK1liLd3KbBQqopdNfpe01arcRmv2X4KG4KDShTGUiURMGdqMGtek4YoB++30oslm/v
         A/mmy1PRKsIBhN8iKUSp/4mR1/H+vfjw6KY7D0TKcfAIqb1cdf7DYk4p4nXx8Zhw6A1f
         zwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LOO+fOTiWxxrcl9IAX3uOVZS6CrJaEVfcKl/F7DKC8=;
        b=VyUvjL3/Cp0EMxspeuNb8VuausTvX6ehlbSGkQ1tfKu/ZL4JIqlXALxAeFS5ikclNU
         +7vVbJZEecEI+VNgdNNd6Ryggn7ILym8p9DR1AuLXE86F7/whWnI/IqGxxrZiiKcXddX
         3ptxsXXeS0F8RSmEVjbhQCnXJ6O2Rds9lZbaGsGkYLYdAe4k9lo7ZgspEFEFsBrqOxoB
         vqLmpBXu6YzDWjS2vvkqL6l67jnbpbP1QFtbKhF96qW2BItmDyYW3kHtPSQdJ5dPk3JV
         1pMk8CpP0HaYTfDEokSZoF84SXcgivEfTlNv7NRd7Z+Zt3zq7PPCa2Z8AtzzOH63XPEV
         /ioQ==
X-Gm-Message-State: APjAAAXuBazVSJ9aU8JkZgv+GCL1IsVlFChW5zuQmQp083Uv5adgWuVP
        4NNiTF4d63rcIK5e5nCW2MP8K0Xzdx3LEy8UwgFfjL4JybY=
X-Google-Smtp-Source: APXvYqwuHQPgO80FUTNECTux5u8OAGnkIjCF3i2PdN2mBUJKKoNxdgmkdRaDmKZ5nVIAe09QaQd93fFRHzLo2s/ym7I=
X-Received: by 2002:a7b:c774:: with SMTP id x20mr1182576wmk.30.1561072109784;
 Thu, 20 Jun 2019 16:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190601082722.44543-1-irogers@google.com> <5084acfa-59a4-996f-bb1d-69fbbac01b87@linux.intel.com>
 <CABPqkBRDzZnofavMC0gYoRQ3iawe19qqGwufdRQJVyjr4E7xrg@mail.gmail.com> <a6dd0755-dd17-c2d0-5228-6cc4ef8a40ed@linux.intel.com>
In-Reply-To: <a6dd0755-dd17-c2d0-5228-6cc4ef8a40ed@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Jun 2019 16:08:18 -0700
Message-ID: <CAP-5=fXvK5iKnKQer9KVME8jw94MYMBdvdV=AWkceV6z0Eta7Q@mail.gmail.com>
Subject: Re: [PATCH] perf cgroups: Don't rotate events for cgroups unnecessarily
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 2:43 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 6/14/2019 3:10 PM, Stephane Eranian wrote:
> > On Thu, Jun 13, 2019 at 9:13 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 6/1/2019 4:27 AM, Ian Rogers wrote:
> >>> Currently perf_rotate_context assumes that if the context's nr_events !=
> >>> nr_active a rotation is necessary for perf event multiplexing. With
> >>> cgroups, nr_events is the total count of events for all cgroups and
> >>> nr_active will not include events in a cgroup other than the current
> >>> task's. This makes rotation appear necessary for cgroups when it is not.
> >>>
> >>> Add a perf_event_context flag that is set when rotation is necessary.
> >>> Clear the flag during sched_out and set it when a flexible sched_in
> >>> fails due to resources.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>    include/linux/perf_event.h |  5 +++++
> >>>    kernel/events/core.c       | 42 +++++++++++++++++++++++---------------
> >>>    2 files changed, 30 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> >>> index 15a82ff0aefe..7ab6c251aa3d 100644
> >>> --- a/include/linux/perf_event.h
> >>> +++ b/include/linux/perf_event.h
> >>> @@ -747,6 +747,11 @@ struct perf_event_context {
> >>>        int                             nr_stat;
> >>>        int                             nr_freq;
> >>>        int                             rotate_disable;
> >>> +     /*
> >>> +      * Set when nr_events != nr_active, except tolerant to events not
> >>> +      * needing to be active due to scheduling constraints, such as cgroups.
> >>> +      */
> >>> +     int                             rotate_necessary;
> >>
> >> It looks like the rotate_necessary is only useful for cgroup and cpuctx.
> >> Why not move it to struct perf_cpu_context and under #ifdef
> >> CONFIG_CGROUP_PERF?
> >> And rename it cgrp_rotate_necessary?
> >>
> > I am not sure I see the point here. What I'd like to see is a uniform
> > signal for rotation needed in per-task, per-cpu or per-cgroup modes > Ian's patch does that. It does make it a lot more efficient in cgroup
> > mode, by avoiding unnecessary rotations, and does not alter/improve
> > on any of the other two modes.
>
> I just thought if it is only used by cgroup, it may be better to move it
> under #ifdef CONFIG_CGROUP_PERF. For users who don't care about cgroup,
> it may save some space.
> But if it's designed as a uniform signal, this is OK.
>
> Thanks,
> Kan

Thanks Kan,
I think you have a wider valid point that by specializing to the CPU
or task context the code could avoid work. Similarly, adding the state
to perf_event_context is limited overhead for non-cgroup builds that
could be optimized away by going back to "nr_active == nr_events". I
agree with Stephane that we should try to keep the code uniform for
the task and CPU case for consistency - and this is the state in the
patch.

Are there any blockers to getting this merged?

Thanks,
Ian


> >
> >> Thanks,
> >> Kan
> >>
> >>>        refcount_t                      refcount;
> >>>        struct task_struct              *task;
> >>>
> >>> diff --git a/kernel/events/core.c b/kernel/events/core.c
> >>> index abbd4b3b96c2..41ae424b9f1d 100644
> >>> --- a/kernel/events/core.c
> >>> +++ b/kernel/events/core.c
> >>> @@ -2952,6 +2952,12 @@ static void ctx_sched_out(struct perf_event_context *ctx,
> >>>        if (!ctx->nr_active || !(is_active & EVENT_ALL))
> >>>                return;
> >>>
> >>> +     /*
> >>> +      * If we had been multiplexing, no rotations are necessary now no events
> >>> +      * are active.
> >>> +      */
> >>> +     ctx->rotate_necessary = 0;
> >>> +
> >>>        perf_pmu_disable(ctx->pmu);
> >>>        if (is_active & EVENT_PINNED) {
> >>>                list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
> >>> @@ -3325,6 +3331,15 @@ static int flexible_sched_in(struct perf_event *event, void *data)
> >>>                        sid->can_add_hw = 0;
> >>>        }
> >>>
> >>> +     /*
> >>> +      * If the group wasn't scheduled then set that multiplexing is necessary
> >>> +      * for the context. Note, this won't be set if the event wasn't
> >>> +      * scheduled due to event_filter_match failing due to the earlier
> >>> +      * return.
> >>> +      */
> >>> +     if (event->state == PERF_EVENT_STATE_INACTIVE)
> >>> +             sid->ctx->rotate_necessary = 1;
> >>> +
> >>>        return 0;
> >>>    }
> >>>
> >>> @@ -3690,24 +3705,17 @@ ctx_first_active(struct perf_event_context *ctx)
> >>>    static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
> >>>    {
> >>>        struct perf_event *cpu_event = NULL, *task_event = NULL;
> >>> -     bool cpu_rotate = false, task_rotate = false;
> >>> -     struct perf_event_context *ctx = NULL;
> >>> +     struct perf_event_context *task_ctx = NULL;
> >>> +     int cpu_rotate, task_rotate;
> >>>
> >>>        /*
> >>>         * Since we run this from IRQ context, nobody can install new
> >>>         * events, thus the event count values are stable.
> >>>         */
> >>>
> >>> -     if (cpuctx->ctx.nr_events) {
> >>> -             if (cpuctx->ctx.nr_events != cpuctx->ctx.nr_active)
> >>> -                     cpu_rotate = true;
> >>> -     }
> >>> -
> >>> -     ctx = cpuctx->task_ctx;
> >>> -     if (ctx && ctx->nr_events) {
> >>> -             if (ctx->nr_events != ctx->nr_active)
> >>> -                     task_rotate = true;
> >>> -     }
> >>> +     cpu_rotate = cpuctx->ctx.rotate_necessary;
> >>> +     task_ctx = cpuctx->task_ctx;
> >>> +     task_rotate = task_ctx ? task_ctx->rotate_necessary : 0;
> >>>
> >>>        if (!(cpu_rotate || task_rotate))
> >>>                return false;
> >>> @@ -3716,7 +3724,7 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
> >>>        perf_pmu_disable(cpuctx->ctx.pmu);
> >>>
> >>>        if (task_rotate)
> >>> -             task_event = ctx_first_active(ctx);
> >>> +             task_event = ctx_first_active(task_ctx);
> >>>        if (cpu_rotate)
> >>>                cpu_event = ctx_first_active(&cpuctx->ctx);
> >>>
> >>> @@ -3724,17 +3732,17 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
> >>>         * As per the order given at ctx_resched() first 'pop' task flexible
> >>>         * and then, if needed CPU flexible.
> >>>         */
> >>> -     if (task_event || (ctx && cpu_event))
> >>> -             ctx_sched_out(ctx, cpuctx, EVENT_FLEXIBLE);
> >>> +     if (task_event || (task_ctx && cpu_event))
> >>> +             ctx_sched_out(task_ctx, cpuctx, EVENT_FLEXIBLE);
> >>>        if (cpu_event)
> >>>                cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
> >>>
> >>>        if (task_event)
> >>> -             rotate_ctx(ctx, task_event);
> >>> +             rotate_ctx(task_ctx, task_event);
> >>>        if (cpu_event)
> >>>                rotate_ctx(&cpuctx->ctx, cpu_event);
> >>>
> >>> -     perf_event_sched_in(cpuctx, ctx, current);
> >>> +     perf_event_sched_in(cpuctx, task_ctx, current);
> >>>
> >>>        perf_pmu_enable(cpuctx->ctx.pmu);
> >>>        perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> >>>
