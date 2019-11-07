Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996D6C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6434A214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p609bKDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbfKGOf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:35:57 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46510 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKGOf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:35:56 -0500
Received: by mail-yb1-f193.google.com with SMTP id g17so979540ybd.13;
        Thu, 07 Nov 2019 06:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCJqsx/ftlwibAsAJ5Vcy0JA49jWm4p8qE8hfVDsfVk=;
        b=p609bKDpHCoHQfbM/eGZgG96SmANx4wFD92aOiUSmPx5mI7JQb5iusZm7PMGjBE0Ur
         WeK+YljlXYEK2ZWCFagZr7d2o3eoov4TZUw9MXsXfrdJ6v98qDqmFyj1P3tTD931PPBa
         tCwaFuEHWd65r52ozGGDMdSNYgwZQBnCN9YimJFvUAYgJGkw8uWYTRICATCF1hko1yn0
         FmUGCcxP8CYFZeoJ1UvtOIfL0LkrGbRWZt2l9ck4MF/ahw7CWemncTIvCwwQXTi1EgII
         n11omcKJxXVfsYb6mLc4Hu78PO1RIZdLiQDcYi9wQot8m9nr+1rOmh9TW3UppuFlhjbQ
         JZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCJqsx/ftlwibAsAJ5Vcy0JA49jWm4p8qE8hfVDsfVk=;
        b=SpePYLVDVe3yK4trJNNJBgS/dZSbiztoU433ywbp4EurRxY/wGiloiCE4XmO10nmgu
         0mSrJ4jXAA5akzh9qymJN13YAqbqIFBNgOHf/sa2mjwMrc/OA5G7JOHLnIsgmVrRQfVK
         XLSKxHW7KBKwvJrUsRlyGe9aU837bnnNQPKIcnjx8UjFOpH91LmJfb1veWOdh1OTgOCq
         d8CHQPH7WLQ12qIcze0L1n4EeAxfxKwVXPF7nt2go1pWkqD1QvDiZN0eiGFZ1zZSev5P
         D6hvaByIdtj+jhKzEfMU68TwEnWC0+MXrngBbgOM6UrCgXLeye+4UXsWwyG3IWKEF2R7
         A+AQ==
X-Gm-Message-State: APjAAAV0X1zmcreIgDzyR9yrbxJWpaUsaj62f1hbx3BxgPeny+/5dClP
        8NjcngrASgS09BE54vnAqFnZEdZg9tHhrQWCzp4=
X-Google-Smtp-Source: APXvYqyMWpVj32FzQRayhpTWpWdlFXd3D4KTz3BmEyqk9mEJsRvKERSKWHPspwqvIWQCC2SxnvCjPuu22GSaPnAZcbM=
X-Received: by 2002:a25:c781:: with SMTP id w123mr3644320ybe.509.1573137355279;
 Thu, 07 Nov 2019 06:35:55 -0800 (PST)
MIME-Version: 1.0
References: <1573002091-9744-1-git-send-email-gkulkarni@marvell.com>
 <1573002091-9744-2-git-send-email-gkulkarni@marvell.com> <20191106112810.GA50610@lakrids.cambridge.arm.com>
 <CAKTKpr6U8gUp4C9muN2cL4wn33o2LAa5QnTO2MSmfnBz8oUc=Q@mail.gmail.com>
In-Reply-To: <CAKTKpr6U8gUp4C9muN2cL4wn33o2LAa5QnTO2MSmfnBz8oUc=Q@mail.gmail.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Thu, 7 Nov 2019 06:35:44 -0800
Message-ID: <CAKTKpr7za2-s0Ayf2AAW5CJ9WQk9smtTAbsjpiFgEg4+wevK7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/core: Adding capability to disable PMUs event multiplexing
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Nov 6, 2019 at 3:28 PM Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
>
> Hi Peter, Mark,
>
> On Wed, Nov 6, 2019 at 3:28 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Wed, Nov 06, 2019 at 01:01:40AM +0000, Ganapatrao Prabhakerrao Kulkarni wrote:
> > > When PMUs are registered, perf core enables event multiplexing
> > > support by default. There is no provision for PMUs to disable
> > > event multiplexing, if PMUs want to disable due to unavoidable
> > > circumstances like hardware errata etc.
> > >
> > > Adding PMU capability flag PERF_PMU_CAP_NO_MUX_EVENTS and support
> > > to allow PMUs to explicitly disable event multiplexing.
> >
> > Even without multiplexing, this PMU activity can happen when switching
> > tasks, or when creating/destroying events, so as-is I don't think this
> > makes much sense.
> >
> > If there's an erratum whereby heavy access to the PMU can lockup the
> > core, and it's possible to workaround that by minimzing accesses, that
> > should be done in the back-end PMU driver.
>
> As said in errata,  If there are heavy access to memory like stream
> application running and along with that if PMU control registers are
> also accessed frequently, then CPU lockup is seen.
>
> I ran perf stat with 4 events of thuderx2 PMU as well as with 6 events
> for stream application.
> For 4 events run, there is no event multiplexing, where as for 6
> events run the events are multiplexed.
>
> For 4 event run:
> No of times pmu->add is called: 10
> No of times pmu->del is called: 10
> No of times pmu->read is called: 310
>
> For 6 events run:
> No of times pmu->add is called: 5216
> No of times pmu->del is called: 5216
> No of times pmu->read is called: 5216
>
> Issue happens when the add and del are called too many times as seen
> with 6 event case.
> The PMU hardware control registers are programmed when add and del
> functions are called.
> For pmu->read no issues since no h/w issue with the data path.
>
> This is UNCORE driver, not sure context switch has any influence on this?
> Please suggest me, how can we fix this in back-end PMU driver without
> any perf core help?
>
> >
> > Either way, this minimzes the utility of the PMU.
> >
> > Thanks,
> > Mark.
> >
> > >
> > > Signed-off-by: Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
> > > ---
> > >  include/linux/perf_event.h | 1 +
> > >  kernel/events/core.c       | 8 ++++++++
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > > index 61448c19a132..9e18d841daf7 100644
> > > --- a/include/linux/perf_event.h
> > > +++ b/include/linux/perf_event.h
> > > @@ -247,6 +247,7 @@ struct perf_event;
> > >  #define PERF_PMU_CAP_HETEROGENEOUS_CPUS              0x40
> > >  #define PERF_PMU_CAP_NO_EXCLUDE                      0x80
> > >  #define PERF_PMU_CAP_AUX_OUTPUT                      0x100
> > > +#define PERF_PMU_CAP_NO_MUX_EVENTS           0x200
> > >
> > >  /**
> > >   * struct pmu - generic performance monitoring unit
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 4655adbbae10..65452784f81c 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -1092,6 +1092,10 @@ static void __perf_mux_hrtimer_init(struct perf_cpu_context *cpuctx, int cpu)
> > >       if (pmu->task_ctx_nr == perf_sw_context)
> > >               return;
> > >
> > > +     /* No PMU support */
> > > +     if (pmu->capabilities & PERF_PMU_CAP_NO_MUX_EVENTS)
> > > +             return 0;
> > > +
> > >       /*
> > >        * check default is sane, if not set then force to
> > >        * default interval (1/tick)
> > > @@ -1117,6 +1121,10 @@ static int perf_mux_hrtimer_restart(struct perf_cpu_context *cpuctx)
> > >       if (pmu->task_ctx_nr == perf_sw_context)
> > >               return 0;
> > >
> > > +     /* No PMU support */
> > > +     if (pmu->capabilities & PERF_PMU_CAP_NO_MUX_EVENTS)
> > > +             return 0;
> > > +
> > >       raw_spin_lock_irqsave(&cpuctx->hrtimer_lock, flags);
> > >       if (!cpuctx->hrtimer_active) {
> > >               cpuctx->hrtimer_active = 1;
> > > --
> > > 2.17.1
> > >
>
> Thanks,
> Ganapat

Below diff does workaround without support of perf core.
Please review and let me know your thoughts?

root@SBR-26>perf>> git diff
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 43d76c85da56..d5c90a93e96b 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -69,6 +69,7 @@ struct tx2_uncore_pmu {
        int node;
        int cpu;
        u32 max_counters;
+       bool events_mux_disable;
        u32 prorate_factor;
        u32 max_events;
        u64 hrtimer_interval;
@@ -442,6 +443,8 @@ static int tx2_uncore_event_init(struct perf_event *event)
        if (!tx2_uncore_validate_event_group(event))
                return -EINVAL;

+       /* reset flag */
+       tx2_pmu->events_mux_disable = false;
        return 0;
 }

@@ -490,10 +493,19 @@ static int tx2_uncore_event_add(struct
perf_event *event, int flags)

        tx2_pmu = pmu_to_tx2_pmu(event->pmu);

+       /* Erratum ThunderX2 erratum 221.
+        * Disable support for events multiplexing.
+        * Limiting the number of events to available hardware counters.
+        */
+       if (tx2_pmu->events_mux_disable)
+               return -EOPNOTSUPP;
+
        /* Allocate a free counter */
        hwc->idx  = alloc_counter(tx2_pmu);
-       if (hwc->idx < 0)
+       if (hwc->idx < 0) {
+               tx2_pmu->events_mux_disable = true;
                return -EAGAIN;
+       }

        tx2_pmu->events[hwc->idx] = event;
        /* set counter control and data registers base address */
@@ -648,6 +660,7 @@ static struct tx2_uncore_pmu
*tx2_uncore_pmu_init_dev(struct device *dev,
        tx2_pmu->dev = dev;
        tx2_pmu->type = type;
        tx2_pmu->base = base;
+       tx2_pmu->events_mux_disable = false;
        tx2_pmu->node = dev_to_node(dev);
        INIT_LIST_HEAD(&tx2_pmu->entry);
