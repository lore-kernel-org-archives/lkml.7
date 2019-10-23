Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8F6CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE7D2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTJb5FGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389720AbfJWHG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:06:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42602 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfJWHGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:06:55 -0400
Received: by mail-io1-f67.google.com with SMTP id i26so14335458iog.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 00:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g1wQAe767Y4VUVJWpMXfE/VsEIlm/q5MKCauSB9UuzY=;
        b=UTJb5FGqH263nZGavmQfOYJ2XcF5KTSGaZ3asYunGoDt4B9v+rZMfxBQAs0S4eEALL
         BJ9t+DK1yYH4rrZcY6gpESYVW21aK8QMm0ngfNoO2+9dwnFsFGDgeguiOTM2nVT2gYlD
         uNGUGCNfWNQyUnYe+KH7tijcQy1l/WssgURBxx+f7FUVCy9rzShe6cR+TxrZfmC/MjzY
         obJZNM+Syoti3iQFyAZq8QLfbLceKb7UBeRcb/nDAk7l2KqSsNOuR9a/vISya9p1pxrs
         BIZ+CcpCktFh3qeQapMVmp7s2jM33CRqEDBRSLRtOXTxqsKXqEyP/ghWFT2eBjpH3MDC
         iNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1wQAe767Y4VUVJWpMXfE/VsEIlm/q5MKCauSB9UuzY=;
        b=sEtxMz8ucxsYDHi2js0efNEpZmgs9J86eX3Z7vw/Wy0YqeLjHkaQodTbEw7p973nS/
         2bV/22iZoH5KUkDRvCNhjy7zRx2OOlYekl8U7onoxGO6IcSnywDLaIkye1bDMskGrxHq
         UOrs9HnZNSheEOfFSZ/kB/h1+znGUjlbpoBftLLlvKI8LrefbEG6QEG4HVIPStL5wPSQ
         LGbrnQStcKPkDGmjb0XiBY769XBX3A2/hUj+ACZ4jTbiEZtBuGG5bEXCzcFrMYuFM7W2
         0/CYFRfpKIE8bfqm8X8vbp3WpNgaQqPBTAjwRDWSPjILOWyFOTaxv4TKkliC8ymCmSWi
         iqaw==
X-Gm-Message-State: APjAAAUWw23zucuCHMQBlqLG/nDJ00jEeewlehdNh36e+IjG7+vkkRRf
        OF27bSf4fkasbMy+ym2ud/Wz4s0Lf7y6LXVKFOkG/g==
X-Google-Smtp-Source: APXvYqypAihmuSCwOrDES43KJ+4pie6svxySnuB0TYqX/qTVuCwmGpjzPe3BmcL9+pIDX+kk2fw7vgZjcUnCGBaH1E0=
X-Received: by 2002:a6b:ee18:: with SMTP id i24mr1780121ioh.163.1571814414260;
 Wed, 23 Oct 2019 00:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191018002746.149200-1-eranian@google.com> <20191021100558.GC1800@hirez.programming.kicks-ass.net>
In-Reply-To: <20191021100558.GC1800@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 23 Oct 2019 00:06:43 -0700
Message-ID: <CABPqkBRgBegcdNHtXUqkdfJUASjuUYnSkh_cNeqfoO4wF7tnFQ@mail.gmail.com>
Subject: Re: [PATCH] perf/core: fix multiplexing event scheduling issue
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 3:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 17, 2019 at 05:27:46PM -0700, Stephane Eranian wrote:
> > @@ -2153,6 +2157,7 @@ __perf_remove_from_context(struct perf_event *event,
> >                          void *info)
> >  {
> >       unsigned long flags = (unsigned long)info;
> > +     int was_necessary = ctx->rotate_necessary;
> >
> >       if (ctx->is_active & EVENT_TIME) {
> >               update_context_time(ctx);
> > @@ -2171,6 +2176,37 @@ __perf_remove_from_context(struct perf_event *event,
> >                       cpuctx->task_ctx = NULL;
> >               }
> >       }
> > +
> > +     /*
> > +      * sanity check that event_sched_out() does not and will not
> > +      * change the state of ctx->rotate_necessary
> > +      */
> > +     WARN_ON(was_necessary != event->ctx->rotate_necessary);
>
> It doesn't... why is this important to check?
>
I can remove that. It is leftover from debugging. It is okay to look
at the situation
after event_sched_out(). Today, it does not change rotate_necessary.

> > +     /*
> > +      * if we remove an event AND we were multiplexing then, that means
> > +      * we had more events than we have counters for, and thus, at least,
> > +      * one event was in INACTIVE state. Now, that we removed an event,
> > +      * we need to resched to give a chance to all events to get scheduled,
> > +      * otherwise some may get stuck.
> > +      *
> > +      * By the time this function is called the event is usually in the OFF
> > +      * state.
> > +      * Note that this is not a duplicate of the same code in _perf_event_disable()
> > +      * because the call path are different. Some events may be simply disabled
>
> It is the exact same code twice though; IIRC this C language has a
> feature to help with that.

Sure! I will make a function to check on the condition.

>
> > +      * others removed. There is a way to get removed and not be disabled first.
> > +      */
> > +     if (ctx->rotate_necessary && ctx->nr_events) {
> > +             int type = get_event_type(event);
> > +             /*
> > +              * In case we removed a pinned event, then we need to
> > +              * resched for both pinned and flexible events. The
> > +              * opposite is not true. A pinned event can never be
> > +              * inactive due to multiplexing.
> > +              */
> > +             if (type & EVENT_PINNED)
> > +                     type |= EVENT_FLEXIBLE;
> > +             ctx_resched(cpuctx, cpuctx->task_ctx, type);
> > +     }
>
> What you're relying on is that ->rotate_necessary implies ->is_active
> and there's pending events. And if we tighten ->rotate_necessary you can
> remove the && ->nr_events.
>
Imagine I have 6 events and 4 counters and I do delete them all before
the timer expires.
Then, I can be in a situation where rotate_necessary is still true and
yet have no more events
in the context. That is because only ctx_sched_out() clears
rotate_necessary, IIRC. So that
is why there is the && nr_events. Now, calling ctx_resched() with no
events wouldn't probably
cause any harm, just wasted work.  So if by tightening, I am guessing
you mean clearing
rotate_necessary earlier. But that would be tricky because the only
reliable way of clearing
it is when you know you are about the reschedule everything. Removing
an event by itself
may not be enough to eliminate multiplexing.


> > @@ -2232,6 +2270,35 @@ static void __perf_event_disable(struct perf_event *event,
> >               event_sched_out(event, cpuctx, ctx);
> >
> >       perf_event_set_state(event, PERF_EVENT_STATE_OFF);
> > +     /*
> > +      * sanity check that event_sched_out() does not and will not
> > +      * change the state of ctx->rotate_necessary
> > +      */
> > +     WARN_ON_ONCE(was_necessary != event->ctx->rotate_necessary);
> > +
> > +     /*
> > +      * if we disable an event AND we were multiplexing then, that means
> > +      * we had more events than we have counters for, and thus, at least,
> > +      * one event was in INACTIVE state. Now, that we disabled an event,
> > +      * we need to resched to give a chance to all events to be scheduled,
> > +      * otherwise some may get stuck.
> > +      *
> > +      * Note that this is not a duplicate of the same code in
> > +      * __perf_remove_from_context()
> > +      * because events can be disabled without being removed.
>
> It _IS_ a duplicate, it is the _exact_ same code twice. What you're
> trying to say is that we need it in both places, but that's something
> else entirely.
>

Will refactor.

> > +      */
> > +     if (ctx->rotate_necessary && ctx->nr_events) {
> > +             int type = get_event_type(event);
> > +             /*
> > +              * In case we removed a pinned event, then we need to
> > +              * resched for both pinned and flexible events. The
> > +              * opposite is not true. A pinned event can never be
> > +              * inactive due to multiplexing.
> > +              */
> > +             if (type & EVENT_PINNED)
> > +                     type |= EVENT_FLEXIBLE;
> > +             ctx_resched(cpuctx, cpuctx->task_ctx, type);
> > +     }
> >  }
>
>
