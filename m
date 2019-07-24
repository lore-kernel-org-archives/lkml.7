Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F9AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01AF21850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9jbkWrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfGXWep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:34:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35615 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfGXWep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:34:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so48615636wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNUErNT3FtfIuEzg9UwQNkT4RYk8SKVBlzxrk6LOKI8=;
        b=e9jbkWrjmT5lDWGz2uQjCyfzn1y1vl//RsKZAdAT7yO8kPOxI37EPr47NFn5tUu37u
         NdlQHkkDKEHElzVPsRXEEdeuNOpeXqSRP6VP91Y1tnLPus/fOLAc6H0wJ86my+HrQmj+
         LwooRxHY+nVqzyQANEp3oZhd46E2rbjPzIVjm1I1I6sV7/2wCpP1iNWyg+vwYMyC5q3J
         Kulfk6Zn/BjUPw7DISFNmUyJNfHZKRsc2UlGNK1GoqkOj69T/la07WG1bCTqoNgZM1Tj
         UN69sTrhh0DCEH9PUPZsZqRQDwQcTsxyACmhXTWu2jCcn/ggQtate+9Ejte4cF5humM9
         MgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNUErNT3FtfIuEzg9UwQNkT4RYk8SKVBlzxrk6LOKI8=;
        b=MtludkA1orwyqbfSPbyuZwgAY5ZCHUOuOXuEo7yyXZ6cA0HXaz/75u814N0tIDDePM
         xkYC1lF4MRpNd6t2u1GhJ3vCHfvBc51jxwupvi9+fxqwSS0LAjd8bExa1vJ8syvGJ3Hu
         4Roig8sn2BPJuQ/h73zuyFJDW9XAOM4rz7u+5wFtKd1H9GKaT85BsQfqcvDcMnuM2hm5
         Cwt6uKhCuoiZ4sRzbd2Tu4iwgUDunQOjyqwA5eIL9o+/XEf2MMx0XzbKg/dgCizmKZIP
         xCSKKqD3iuXQ4CNSNT7S5UJHdbXJ50pElaYwV/RmloQtRaiQpZDUnKtg9jZHag6yEU9U
         U7rQ==
X-Gm-Message-State: APjAAAWfC80w38vrerxxfs2qJlN5sO5icZZcVvO31ZmC6JA96+JfbY1G
        /ZirNjH4HOrXJgIpMCxcKYQCxqBCLmv3kMArnzQjfa2PjkA=
X-Google-Smtp-Source: APXvYqznxvytiMFXhiTdrgBC0QxHpMfb+54HX8bmO8Ct7xD/AXnGiGHObWM6TapEScQTLVDVx6AxLdbpnq+tfkZPu8E=
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr86629397wrr.252.1564007682038;
 Wed, 24 Jul 2019 15:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com> <20190702065955.165738-3-irogers@google.com>
 <20190708161636.GE3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190708161636.GE3419@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 Jul 2019 15:34:29 -0700
Message-ID: <CAP-5=fXP5Sptyh_qfmnRKw=DghWyW2ZapG5NChT-F4DiOXHXFg@mail.gmail.com>
Subject: Re: [PATCH 2/7] perf/cgroup: order events in RB tree by cgroup id
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 9:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 01, 2019 at 11:59:50PM -0700, Ian Rogers wrote:
> > +static int visit_groups_merge(struct perf_event_context *ctx,
> > +                           struct perf_cpu_context *cpuctx,
> > +                           struct perf_event_groups *groups,
> > +                           int (*func)(struct perf_event_context *,
> > +                                       struct perf_cpu_context *,
> > +                                       struct perf_event *,
> > +                                       int *),
> > +                           int *data)
>
> > -struct sched_in_data {
> > -     struct perf_event_context *ctx;
> > -     struct perf_cpu_context *cpuctx;
> > -     int can_add_hw;
> > -};
> > -
> > -static int pinned_sched_in(struct perf_event *event, void *data)
> > +static int pinned_sched_in(struct perf_event_context *ctx,
> > +                        struct perf_cpu_context *cpuctx,
> > +                        struct perf_event *event,
> > +                        int *unused)
> >  {
> > -     struct sched_in_data *sid = data;
> > -
> >       if (event->state <= PERF_EVENT_STATE_OFF)
> >               return 0;
> >
> >       if (!event_filter_match(event))
> >               return 0;
> >
> > -     if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
> > -             if (!group_sched_in(event, sid->cpuctx, sid->ctx))
> > -                     list_add_tail(&event->active_list, &sid->ctx->pinned_active);
> > +     if (group_can_go_on(event, cpuctx, 1)) {
> > +             if (!group_sched_in(event, cpuctx, ctx))
> > +                     list_add_tail(&event->active_list, &ctx->pinned_active);
> >       }
> >
> >       /*
> > @@ -3317,24 +3444,25 @@ static int pinned_sched_in(struct perf_event *event, void *data)
> >       return 0;
> >  }
> >
> > -static int flexible_sched_in(struct perf_event *event, void *data)
> > +static int flexible_sched_in(struct perf_event_context *ctx,
> > +                          struct perf_cpu_context *cpuctx,
> > +                          struct perf_event *event,
> > +                          int *can_add_hw)
> >  {
> > -     struct sched_in_data *sid = data;
> > -
> >       if (event->state <= PERF_EVENT_STATE_OFF)
> >               return 0;
> >
> >       if (!event_filter_match(event))
> >               return 0;
> >
> > -     if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
> > -             int ret = group_sched_in(event, sid->cpuctx, sid->ctx);
> > +     if (group_can_go_on(event, cpuctx, *can_add_hw)) {
> > +             int ret = group_sched_in(event, cpuctx, ctx);
> >               if (ret) {
> > -                     sid->can_add_hw = 0;
> > -                     sid->ctx->rotate_necessary = 1;
> > +                     *can_add_hw = 0;
> > +                     ctx->rotate_necessary = 1;
> >                       return 0;
> >               }
> > -             list_add_tail(&event->active_list, &sid->ctx->flexible_active);
> > +             list_add_tail(&event->active_list, &ctx->flexible_active);
> >       }
> >
> >       return 0;
> > @@ -3344,30 +3472,24 @@ static void
> >  ctx_pinned_sched_in(struct perf_event_context *ctx,
> >                   struct perf_cpu_context *cpuctx)
> >  {
> > -     struct sched_in_data sid = {
> > -             .ctx = ctx,
> > -             .cpuctx = cpuctx,
> > -             .can_add_hw = 1,
> > -     };
> > -
> > -     visit_groups_merge(&ctx->pinned_groups,
> > -                        smp_processor_id(),
> > -                        pinned_sched_in, &sid);
> > +     visit_groups_merge(ctx,
> > +                        cpuctx,
> > +                        &ctx->pinned_groups,
> > +                        pinned_sched_in,
> > +                        NULL);
> >  }
> >
> >  static void
> >  ctx_flexible_sched_in(struct perf_event_context *ctx,
> >                     struct perf_cpu_context *cpuctx)
> >  {
> > -     struct sched_in_data sid = {
> > -             .ctx = ctx,
> > -             .cpuctx = cpuctx,
> > -             .can_add_hw = 1,
> > -     };
> > +     int can_add_hw = 1;
> >
> > -     visit_groups_merge(&ctx->flexible_groups,
> > -                        smp_processor_id(),
> > -                        flexible_sched_in, &sid);
> > +     visit_groups_merge(ctx,
> > +                        cpuctx,
> > +                        &ctx->flexible_groups,
> > +                        flexible_sched_in,
> > +                        &can_add_hw);
> >  }
>
> It is not clear to me why you're doing away with that sched_in_data
> abstraction. AFAICT that has no material impact on this patch.

The change alters visit_groups_merge parameters to take ctx and cpuctx
in order to compute the number of iterators. ctx and cpuctx were taken
out of sched_in_data to avoid passing them twice. can_add_hw remains
but not wrapped inside of sched_in_data as it seemed unnecessary to
wrap a single boolean.

Thanks,
Ian
