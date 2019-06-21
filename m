Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9451AC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6688F2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFiDyop6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfFUSBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:01:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37504 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUSBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:01:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so7433267wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KddSnqJk8N2HccW5lB3LKF7N+h2SRaXdd/fZu8Bc+Lk=;
        b=YFiDyop64/iXrObHdO/Sgrip+DwxTbflll8pn4Cep0G8Iv7W9rRpxgMdPS77jFhOby
         iabgmfZsVJ1MLI8DaFurSwQC17KTT8Se54I4TioiBVkhKw8WSCoGkq4N8ERK6Y9Ov/l9
         q9QTVbVkirEZsYwDXKZ6V8W051djxYse9oxxJVY3gJkS4Uu3dygzTGI0tVqRw+35JoyG
         +TcFIS3n2HH9KWx3KgWsaESaQR04QNHJPU0G6f/snPEDqmKaA9czthbG4Gso37ZtqR7B
         4C32o1gzAcPlRMuxgsJpZxuH6uDkwaHqcYTsIKX/R8kYUBOg713j6F/IvaJSo/9yTowY
         fbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KddSnqJk8N2HccW5lB3LKF7N+h2SRaXdd/fZu8Bc+Lk=;
        b=RBd2CSvoV384ag7nH5vUJnSm9BzOacz8zVsWJDIWrMzk//IQWf4A+EuivkkOlAtxPS
         O0bCoJ+csIfopfaigdPISVh9rXAgzN9yBISBF95UCp6Nl/cIN1e8mgZ+M5ED6VQYnGQG
         ph8p4kNz60JVYYjYZ+OQ4wfd+zLpG1hPxWOSeqM8kbv8onvrFslJhEOVrpLLR8C4hU3b
         /4vKPUKjKLh6qIrB8xvZGm4oNH5dTbk9sIAmNYoJJCrGh2nmDjq77LtCo2kuPp5gxZ8o
         JLp8WYRD84el4PrJRkFtXyR+so58I677k4FpmvyMetcR86qHMe9B9iW/HAzkTdjE/trV
         B9+w==
X-Gm-Message-State: APjAAAWGY6/k0kuyywg3RMBKD/bOnNI+1vhMo7w6KQU7cCwqrqMUXicx
        nls2hiOrLuaoGyr78gCbcmd38eG6mJAFQT2boFu12A==
X-Google-Smtp-Source: APXvYqwEMcu6B71QNn1AX9wEDwh+KSuCxo40a8d81EPKtgRDVo+AbDFvw/Mqx5KeHFCuV0XErdSyljwEf4xriGyxlJ0=
X-Received: by 2002:a5d:49c4:: with SMTP id t4mr40662447wrs.318.1561140101725;
 Fri, 21 Jun 2019 11:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190601082722.44543-1-irogers@google.com> <20190621082422.GH3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190621082422.GH3436@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 21 Jun 2019 11:01:29 -0700
Message-ID: <CAP-5=fW7sMjQEHm+1e=cdAi+ZyP53UyU7xhAbnouMApuxYqrhw@mail.gmail.com>
Subject: Re: [PATCH] perf cgroups: Don't rotate events for cgroups unnecessarily
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 1:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Jun 01, 2019 at 01:27:22AM -0700, Ian Rogers wrote:
> > @@ -3325,6 +3331,15 @@ static int flexible_sched_in(struct perf_event *event, void *data)
> >                       sid->can_add_hw = 0;
> >       }
> >
> > +     /*
> > +      * If the group wasn't scheduled then set that multiplexing is necessary
> > +      * for the context. Note, this won't be set if the event wasn't
> > +      * scheduled due to event_filter_match failing due to the earlier
> > +      * return.
> > +      */
> > +     if (event->state == PERF_EVENT_STATE_INACTIVE)
> > +             sid->ctx->rotate_necessary = 1;
> > +
> >       return 0;
> >  }
>
> That looked odd; which had me look harder at this function which
> resulted in the below. Should we not terminate the context interation
> the moment one flexible thingy fails to schedule?

If we knew all the events were hardware events then this would be
true, as there may be software events that always schedule then the
continued iteration is necessary.

Thanks,
Ian

> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2314,12 +2314,8 @@ group_sched_in(struct perf_event *group_
>                 return 0;
>
>         pmu->start_txn(pmu, PERF_PMU_TXN_ADD);
> -
> -       if (event_sched_in(group_event, cpuctx, ctx)) {
> -               pmu->cancel_txn(pmu);
> -               perf_mux_hrtimer_restart(cpuctx);
> -               return -EAGAIN;
> -       }
> +       if (event_sched_in(group_event, cpuctx, ctx))
> +               goto cancel;
>
>         /*
>          * Schedule in siblings as one group (if any):
> @@ -2348,10 +2344,9 @@ group_sched_in(struct perf_event *group_
>         }
>         event_sched_out(group_event, cpuctx, ctx);
>
> +cancel:
>         pmu->cancel_txn(pmu);
> -
>         perf_mux_hrtimer_restart(cpuctx);
> -
>         return -EAGAIN;
>  }
>
> @@ -3317,6 +3312,7 @@ static int pinned_sched_in(struct perf_e
>  static int flexible_sched_in(struct perf_event *event, void *data)
>  {
>         struct sched_in_data *sid = data;
> +       int ret;
>
>         if (event->state <= PERF_EVENT_STATE_OFF)
>                 return 0;
> @@ -3325,21 +3321,15 @@ static int flexible_sched_in(struct perf
>                 return 0;
>
>         if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
> -               if (!group_sched_in(event, sid->cpuctx, sid->ctx))
> -                       list_add_tail(&event->active_list, &sid->ctx->flexible_active);
> -               else
> +               ret = group_sched_in(event, sid->cpuctx, sid->ctx);
> +               if (ret) {
>                         sid->can_add_hw = 0;
> +                       sid->ctx->rotate_necessary = 1;
> +                       return ret;
> +               }
> +               list_add_tail(&event->active_list, &sid->ctx->flexible_active);
>         }
>
> -       /*
> -        * If the group wasn't scheduled then set that multiplexing is necessary
> -        * for the context. Note, this won't be set if the event wasn't
> -        * scheduled due to event_filter_match failing due to the earlier
> -        * return.
> -        */
> -       if (event->state == PERF_EVENT_STATE_INACTIVE)
> -               sid->ctx->rotate_necessary = 1;
> -
>         return 0;
>  }
>
