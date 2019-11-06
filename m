Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090C5FC6195
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCFD20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUXKo99u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbfKFX27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:28:59 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33767 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfKFX27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:28:59 -0500
Received: by mail-yb1-f196.google.com with SMTP id i15so238336ybq.0;
        Wed, 06 Nov 2019 15:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wsGkky6yfeJ+ut8glQWS3HkTq744rNXXFxtFxOcqi6E=;
        b=JUXKo99uMkVxowlJ3qm1o6kw842BvWhmlNS5Z9hyRW0pcJphoXOcCtnUNtfx8IdPpR
         oySoQsb3lPIh+NM2b8zCSRhLOFT75guRcYd72Ts72gYIuaxUBsRjPqNCrElolRdmbi3E
         cTkFII1BHLz7OoDVHGOip9fuVLPcoQjm/Gi019NG/gIAXNd7Jy/L2kFziZmD22JV2Woe
         igAfYSWRe5lE2vascU6L0OmI4tkSH8zacRn77dFgUbztKeXyLUT/HwoKtl7OFODUxaEv
         MruH3USO7MVQaKrCNOxZNubsnMJhoYa+UfquEtgRfwjKRBuo3hJLYEnqthAnmXfvpdp0
         YEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wsGkky6yfeJ+ut8glQWS3HkTq744rNXXFxtFxOcqi6E=;
        b=pPEp3qheNX8lxj8zg6Pvamc+e3a060oCePxLSSIpPB56gZ9BNDLS3CXUtKwd6M0f4A
         rqGbOuUl2NoswjE6DZuNbb9ZmPzu6gBKelUaBiLDfcVWBNYt+dAJYoiL06Pk2okKaI/n
         GNwK+HjuTvQgFj07f6FYe7WZx0OYKPhZ2TZec7wmKle0sZmk2DsZDO32T4IbTY/qGnXS
         MewRE53R9f8fl3Idi1u/+fTBpwbMTUz3ZWLQzJCDqVbjVod+Op0m04SHQFuXz6Mc3doV
         cUsywFnYZhK3y2ud8a3IlhMnDxdG3S2wFWhXwjPoWtCwJ9N+TXXDiK3wOZyYJAKIkbj6
         Beow==
X-Gm-Message-State: APjAAAUf6uu77CZOev0db+NNItMyvFrdOnCVRzwIUBBc3QbzYTy5sFxq
        FtK1bQKjtGVQHJuf0RL0qBlTjVzu3BJglPtMWow=
X-Google-Smtp-Source: APXvYqxwSsU7QfnftZPBDmOxKeNz94oi9xpUFIFhUMbydvHrpAxIVz+AeNKsE7P/ockLy/g7TTo/2lk/DxpneCbwUcM=
X-Received: by 2002:a25:774b:: with SMTP id s72mr613338ybc.287.1573082937865;
 Wed, 06 Nov 2019 15:28:57 -0800 (PST)
MIME-Version: 1.0
References: <1573002091-9744-1-git-send-email-gkulkarni@marvell.com>
 <1573002091-9744-2-git-send-email-gkulkarni@marvell.com> <20191106112810.GA50610@lakrids.cambridge.arm.com>
In-Reply-To: <20191106112810.GA50610@lakrids.cambridge.arm.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Wed, 6 Nov 2019 15:28:46 -0800
Message-ID: <CAKTKpr6U8gUp4C9muN2cL4wn33o2LAa5QnTO2MSmfnBz8oUc=Q@mail.gmail.com>
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

Hi Peter, Mark,

On Wed, Nov 6, 2019 at 3:28 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Nov 06, 2019 at 01:01:40AM +0000, Ganapatrao Prabhakerrao Kulkarni wrote:
> > When PMUs are registered, perf core enables event multiplexing
> > support by default. There is no provision for PMUs to disable
> > event multiplexing, if PMUs want to disable due to unavoidable
> > circumstances like hardware errata etc.
> >
> > Adding PMU capability flag PERF_PMU_CAP_NO_MUX_EVENTS and support
> > to allow PMUs to explicitly disable event multiplexing.
>
> Even without multiplexing, this PMU activity can happen when switching
> tasks, or when creating/destroying events, so as-is I don't think this
> makes much sense.
>
> If there's an erratum whereby heavy access to the PMU can lockup the
> core, and it's possible to workaround that by minimzing accesses, that
> should be done in the back-end PMU driver.

As said in errata,  If there are heavy access to memory like stream
application running and along with that if PMU control registers are
also accessed frequently, then CPU lockup is seen.

I ran perf stat with 4 events of thuderx2 PMU as well as with 6 events
for stream application.
For 4 events run, there is no event multiplexing, where as for 6
events run the events are multiplexed.

For 4 event run:
No of times pmu->add is called: 10
No of times pmu->del is called: 10
No of times pmu->read is called: 310

For 6 events run:
No of times pmu->add is called: 5216
No of times pmu->del is called: 5216
No of times pmu->read is called: 5216

Issue happens when the add and del are called too many times as seen
with 6 event case.
The PMU hardware control registers are programmed when add and del
functions are called.
For pmu->read no issues since no h/w issue with the data path.

This is UNCORE driver, not sure context switch has any influence on this?
Please suggest me, how can we fix this in back-end PMU driver without
any perf core help?

>
> Either way, this minimzes the utility of the PMU.
>
> Thanks,
> Mark.
>
> >
> > Signed-off-by: Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
> > ---
> >  include/linux/perf_event.h | 1 +
> >  kernel/events/core.c       | 8 ++++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 61448c19a132..9e18d841daf7 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -247,6 +247,7 @@ struct perf_event;
> >  #define PERF_PMU_CAP_HETEROGENEOUS_CPUS              0x40
> >  #define PERF_PMU_CAP_NO_EXCLUDE                      0x80
> >  #define PERF_PMU_CAP_AUX_OUTPUT                      0x100
> > +#define PERF_PMU_CAP_NO_MUX_EVENTS           0x200
> >
> >  /**
> >   * struct pmu - generic performance monitoring unit
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 4655adbbae10..65452784f81c 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -1092,6 +1092,10 @@ static void __perf_mux_hrtimer_init(struct perf_cpu_context *cpuctx, int cpu)
> >       if (pmu->task_ctx_nr == perf_sw_context)
> >               return;
> >
> > +     /* No PMU support */
> > +     if (pmu->capabilities & PERF_PMU_CAP_NO_MUX_EVENTS)
> > +             return 0;
> > +
> >       /*
> >        * check default is sane, if not set then force to
> >        * default interval (1/tick)
> > @@ -1117,6 +1121,10 @@ static int perf_mux_hrtimer_restart(struct perf_cpu_context *cpuctx)
> >       if (pmu->task_ctx_nr == perf_sw_context)
> >               return 0;
> >
> > +     /* No PMU support */
> > +     if (pmu->capabilities & PERF_PMU_CAP_NO_MUX_EVENTS)
> > +             return 0;
> > +
> >       raw_spin_lock_irqsave(&cpuctx->hrtimer_lock, flags);
> >       if (!cpuctx->hrtimer_active) {
> >               cpuctx->hrtimer_active = 1;
> > --
> > 2.17.1
> >

Thanks,
Ganapat
