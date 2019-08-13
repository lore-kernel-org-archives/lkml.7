Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FCBC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3932C2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5Z+j7P3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfHMKz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:55:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41280 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfHMKz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:55:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id o101so17794810ota.8;
        Tue, 13 Aug 2019 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7GJCS2+nN7LzL0hVAu7+fXi7vAKyLZ5WbkP+JMkhsQ=;
        b=U5Z+j7P31wD8dPVO64/0OxRcrGzm1Nkuum4danFLl3rR5rwBxQtxqjmrpj67lws/HO
         WJ9Hk317T/VuwSRfhyIoxcGb6RY00LPS4R+KZaiXYRGwjfdta+MWJxRB+RRvHpLwJXkG
         lcvHfORPBd/RJerSrocc3YR8HzfWlOqUgrd6hIZJKWfnhn6kEc2qFoWkvaACdVRFgmjO
         3KnCytP9xLnYKB3PrxFDbNJxe6x18j3VYR0DIvWYYfPDiQV3po/9ciOt+p9YOIUu4YmL
         WenyOMs+d0EtSNkvFXXSzO14tWT5umMTH5QRQoutGEc+61NNwV+2Vy6OmZ64+6RyIpdW
         YCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7GJCS2+nN7LzL0hVAu7+fXi7vAKyLZ5WbkP+JMkhsQ=;
        b=IUurHdtHTVZTYHyBZUwmXZn1B9VznDbdBXZeKAYSWoUA+I9hAKfZyDe5SVY0ctWy+m
         1Lx3TVQNoQvXWnzu1XYBGEotvfcSfIKiAkDAAXlyIPoqCRiJUGJnXtC+CTFvM4FSYtOU
         AaBFhIIxq+WrDP5kaprs4TCgmosH+/fhwevcNWos88Jzvd1aYi2DbAeNbhxaWy2dMiXq
         LTuIWjB/WFcSs+JU36SrBRpu20tQvnQ0cNWIkcJ7TyLf1WeGT9n7A7M2Ww6xUazeipSs
         aUupUcNliqkV77uKfSfqBEYQ2q8z1WjB3OWslTp2GR9OStpXLZnDiRVkLx7SiPIsXA/w
         5m0w==
X-Gm-Message-State: APjAAAVQFeSEGDqBTagEdqsuXnv94zw9Y/LXkhtxe5bW220tKFmzwMZx
        jszu9DBUch/ATno/6O7f5NFKUmMh46wGlOb32cA=
X-Google-Smtp-Source: APXvYqxgbxmd+WfNqrdwdnfKbYW9LnWtCKNG0kC5nUYYQUHlfGbUvepYSqlRr3sYzlWQr+hJELeoLVFAZkOA0tTJ6mw=
X-Received: by 2002:a6b:6f06:: with SMTP id k6mr15215680ioc.232.1565693727255;
 Tue, 13 Aug 2019 03:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <1563873380-2003-1-git-send-email-gkulkarni@marvell.com>
 <1563873380-2003-3-git-send-email-gkulkarni@marvell.com> <20190812120125.GA50712@lakrids.cambridge.arm.com>
In-Reply-To: <20190812120125.GA50712@lakrids.cambridge.arm.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Tue, 13 Aug 2019 16:25:15 +0530
Message-ID: <CAKTKpr7juHd9Bgam28LESadihFadEAevRAhc-7w3PTMYY7HLNw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "will@kernel.org" <will@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        Jan Glauber <jglauber@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Aug 12, 2019 at 5:31 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Jul 23, 2019 at 09:16:28AM +0000, Ganapatrao Kulkarni wrote:
> > CCPI2 is a low-latency high-bandwidth serial interface for connecting
> > ThunderX2 processors. This patch adds support to capture CCPI2 perf events.
>
> It would be worth pointing out in the commit message how the CCPI2
> counters differ from the others. I realise you have that in the body of
> patch 1, but it's critical information when reviewing this patch...

Ok, I will add in next version.
>
> >
> > Signed-off-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>
> > ---
> >  drivers/perf/thunderx2_pmu.c | 248 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 214 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> > index 43d76c85da56..a4e1273eafa3 100644
> > --- a/drivers/perf/thunderx2_pmu.c
> > +++ b/drivers/perf/thunderx2_pmu.c
> > @@ -17,22 +17,31 @@
> >   */
> >
> >  #define TX2_PMU_MAX_COUNTERS         4
>
> Shouldn't this be 8 now?

It is kept unchanged to 4(as suggested by Will), which is same for
both L3 and DMC.
For CCPI2 this macro is not used.

>
> [...]
>
> >  /*
> > - * pmu on each socket has 2 uncore devices(dmc and l3c),
> > - * each device has 4 counters.
> > + * pmu on each socket has 3 uncore devices(dmc, l3ci and ccpi2),
> > + * dmc and l3c has 4 counters and ccpi2 8.
> >   */
>
> How about:
>
> /*
>  * Each socket has 3 uncore device associated with a PMU. The DMC and
>  * L3C have 4 32-bit counters, and the CCPI2 has 8 64-bit counters.
>  */

Thanks.
>
> >  struct tx2_uncore_pmu {
> >       struct hlist_node hpnode;
> > @@ -69,12 +86,14 @@ struct tx2_uncore_pmu {
> >       int node;
> >       int cpu;
> >       u32 max_counters;
> > +     u32 counters_mask;
> >       u32 prorate_factor;
> >       u32 max_events;
> > +     u32 events_mask;
> >       u64 hrtimer_interval;
> >       void __iomem *base;
> >       DECLARE_BITMAP(active_counters, TX2_PMU_MAX_COUNTERS);
>
> This bitmap isn't big enough for the 4 new counters.
>
> > -     struct perf_event *events[TX2_PMU_MAX_COUNTERS];
> > +     struct perf_event **events;
>
> As above, can't we bump TX2_PMU_MAX_COUNTERS to 8 rather than making
> this a dynamic allocation?

events is only relevant for L3 and DMC since they use timer callbacks.
This is done as per previous review comments.

>
> [...]
>
> >  static inline u32 reg_readl(unsigned long addr)
> >  {
> >       return readl((void __iomem *)addr);
> >  }
> >
> > +static inline u32 reg_readq(unsigned long addr)
> > +{
> > +     return readq((void __iomem *)addr);
> > +}
>
> Presumably reg_readq() should return a u64.

Yes,  My bad.

>
> [...]
>
> > +static void uncore_start_event_ccpi2(struct perf_event *event, int flags)
> > +{
> > +     u32 emask;
> > +     struct hw_perf_event *hwc = &event->hw;
> > +     struct tx2_uncore_pmu *tx2_pmu;
> > +
> > +     tx2_pmu = pmu_to_tx2_pmu(event->pmu);
> > +     emask = tx2_pmu->events_mask;
> > +
> > +     /* Bit [09:00] to set event id, set level and type to 1 */
> > +     reg_writel((3 << 10) |
>
> Do you mean that bits [11:10] are level and type?

Yes, i will change the comment.
>
> What exactly are 'level' and 'type'?

They are for other settings which are not relevant for software/kernel.
>
> Can we give those bits mnemonics?
>
> > +                     GET_EVENTID(event, emask), hwc->config_base);
> > +     /* reset[4], enable[0] and start[1] counters */
>
> Rather than using magic numbers everywhere, please give these mnemonics,
> e.g.
>
> #define CCPI2_PERF_CTL_ENABLE   BIT(0)
> #define CCPI2_PERF_CTL_START    BIT(1)
> #define CCPI2_PERF_CTL_RESET    BIT(4)

not used everywhere, only in this function.
I can add these macros.

>
> > +     reg_writel(0x13, hwc->event_base + CCPI2_PERF_CTL);
>
> ... and then you can OR them in here:

OK
>
>         ctl = CCPI2_PERF_CTL_ENABLE |
>               CCPI2_PERF_CTL_START |
>               CCPI2_PERF_CTL_RESET;
>         reg_writel(ctl, hwc->event_base + CCPI2_PERF_CTL);
>
> [...]
>
> > @@ -456,8 +603,9 @@ static void tx2_uncore_event_start(struct perf_event *event, int flags)
> >       tx2_pmu->start_event(event, flags);
> >       perf_event_update_userpage(event);
> >
> > -     /* Start timer for first event */
> > -     if (bitmap_weight(tx2_pmu->active_counters,
> > +     /* Start timer for first non ccpi2 event */
> > +     if (tx2_pmu->type != PMU_TYPE_CCPI2 &&
> > +                     bitmap_weight(tx2_pmu->active_counters,
> >                               tx2_pmu->max_counters) == 1) {
> >               hrtimer_start(&tx2_pmu->hrtimer,
> >                       ns_to_ktime(tx2_pmu->hrtimer_interval),
>
> This would be easier to read as two statements:
>
>         /* No hrtimer needed with 64-bit counters */
>         if (tx2_pmu->type == PMU_TYPE_CCPI2)
>                 return;
>
>         /* Start timer for first event */
>         if (bitmap_weight(tx2_pmu->active_counters,
>             tx2_pmu->max_counters) != 1) {
>                 ...
>         }
>

OK, makes sense.

> > @@ -495,7 +643,8 @@ static int tx2_uncore_event_add(struct perf_event *event, int flags)
> >       if (hwc->idx < 0)
> >               return -EAGAIN;
> >
> > -     tx2_pmu->events[hwc->idx] = event;
> > +     if (tx2_pmu->events)
> > +             tx2_pmu->events[hwc->idx] = event;
>
> So this is NULL for CCPI2?

Yes.
>
> I guess we don't strictly need the if we don't have a hrtimer to update
> event counts, but this makes the code more complicated than it needs to
> be.

Yes I am using tx2_pmu->events to differentiate the type, it is NULL for CCPI2.
I can extend same to tx2_uncore_event_start().
>
> [...]
>
> > @@ -580,8 +732,12 @@ static int tx2_uncore_pmu_add_dev(struct tx2_uncore_pmu *tx2_pmu)
> >                       cpu_online_mask);
> >
> >       tx2_pmu->cpu = cpu;
> > -     hrtimer_init(&tx2_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > -     tx2_pmu->hrtimer.function = tx2_hrtimer_callback;
> > +     /* CCPI2 counters are 64 bit counters, no overflow  */
> > +     if (tx2_pmu->type != PMU_TYPE_CCPI2) {
> > +             hrtimer_init(&tx2_pmu->hrtimer,
> > +                             CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +             tx2_pmu->hrtimer.function = tx2_hrtimer_callback;
> > +     }
>
> Hmmm... this means that tx2_pmu->hrtimer.function is NULL for the CCPI2
> PMU. I think it would be best to check that when (re)programming the
> counters rather than the PMU type. For example, in
> tx2_uncore_event_start() we could have:
>
>         if (!tx2_pmu->hrtimer.function)
>                 return;
>         if (bitmap_weight(tx2_pmu->active_counters,
>             tx2_pmu->max_counters) != 1) {
>                 ...
>         }
>

Yes it is NULL for CCPI2.
Ok, I can use tx2_pmu->events instead(like other places).

> Thanks,
> Mark.

Thanks,
Ganapat
