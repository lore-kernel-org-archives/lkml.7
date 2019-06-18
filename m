Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC57C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACE92085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mo7//ZZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfFRL4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:56:50 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42066 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfFRL4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:56:50 -0400
Received: by mail-ua1-f66.google.com with SMTP id a97so5572742uaa.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 04:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=piRTAebFx2FsROFm2zYcU51EDgaGKwKW/nF1spIt1sI=;
        b=mo7//ZZm5CR0ywBO0NeDMxPL71X9bJ2kFFt6G1IOlFmJ9ImsK53ikh7RHrkrW1cWy9
         16iNhl4WpSQJUkAAbTw5KSaMvEgibjhRAeDdK923fBEpZYNAE20PQW/MvuGIVYjvr3Ly
         PGlsFZh24pJnk4p97S+BlQxGQ5YXakodnK0IFr1Bs6JN3UMFSZC7746dzX1JbDjIEtFl
         5D7+lIshQcZUkRwA2eOa9jcmCy7QsLu2FCDfbDU8EzbL7pWXZADfQcDYZH0I6ds16AwR
         BbQa3geAipWWpwweByap68mRGunqBK9j3PxpS3+GHbGeM8wXH2f7fbKEAVQS0ldqg9eV
         IXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piRTAebFx2FsROFm2zYcU51EDgaGKwKW/nF1spIt1sI=;
        b=sdr5z37Rpq2872CjbRXa9kKEojBpIqmmrtSW/Ni8LRgQBjp5XIGcwmTXarWLv12AGr
         +bX3DEzygHHK/yvRQaVRNEMaCQwzw73jESW5tqyGWgvQ0aA2sBVJ6qdgeQitZ2zeQwli
         Y8PRnrXrIUb0WR9s/LD2kG/0XcFHulNu8QMR1gTMxbhfC4QVTjdYuLXKUtkxm8H/XSED
         kWyTysbWnSq8JP/pygftgdLsMgiFVg2GpMXsjd0dHLINj2scD1NuynXG95oKGGsdyLS7
         /yaV3xNLg0ZIh596FFvuc/D3n8PcE/rXtCw+97GIE9G3IWlMe/Lv2Q0JNTVZK1uoDY9r
         mUeQ==
X-Gm-Message-State: APjAAAWDKlZQkf8/Q64ktm7nVmlQ3JVrh2E2IRRqEBAgb9GGMR5kzVor
        XhIx1E0Uv1skNsIFd8T0aMrQsUS3IpPAHrTC3m2zbw==
X-Google-Smtp-Source: APXvYqxWE7NU+QUzDoR4u6I5eIyinKhKJ2E54DPFNLSdMDWyWFZV8l2G2R1evmkcZ1mRW3Z8CNDF2/bizF6JGRucbC8=
X-Received: by 2002:a67:3254:: with SMTP id y81mr24197966vsy.34.1560859009184;
 Tue, 18 Jun 2019 04:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <CAJZ5v0gbK3AFCVC1b9LyXeMOM8fKR1=ECXZwaeSYRSqcK0UgYA@mail.gmail.com>
 <CAPDyKFpU3u248Gi+FnrVdY-EWXJQuu14uNV9d3Xs0W-K-EMEhg@mail.gmail.com>
 <20190607154210.GJ15577@e107155-lin> <20190607193407.GB24059@builder>
 <20190610103225.GA26602@e107155-lin> <CAPDyKFr31SwmHHAREbR3dWMQ55LzzUyTc4M5FZvNsqWfX7SE8Q@mail.gmail.com>
 <20190610171557.GA4560@redmoon> <CAPDyKFqC8+Sv5WRhwOxqphAt8tb_PDisy13Miz5e-PajvwS1ew@mail.gmail.com>
In-Reply-To: <CAPDyKFqC8+Sv5WRhwOxqphAt8tb_PDisy13Miz5e-PajvwS1ew@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 18 Jun 2019 13:56:13 +0200
Message-ID: <CAPDyKFpo8pJroOq=YkkNkt6+xyOdu3tTovEbsEp2ry0OJUu7JQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] ARM/ARM64: Support hierarchical CPU arrangement for PSCI
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 at 20:57, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 10 Jun 2019 at 19:16, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Mon, Jun 10, 2019 at 05:54:39PM +0200, Ulf Hansson wrote:
> >
> > [...]
> >
> > > My summary from the earlier ones, is that because the PSCI spec
> > > includes support for OSI, we should also support it in the kernel (and
> > > ATF). In a discussion offlist, Lorenzo agreed that it's okay to add,
> > > without an apple to apple comparison. Maybe Lorenzo can fill in and
> > > state this publicly, to save us all some time?
> >
> > The comparison should have been made before even requesting PSCI OSI
> > mode changes to the specifications, so we have a chip on our shoulders
> > anyway.
> >
> > We will enable PSCI OSI but that's not where the problem lies, enabling
> > PSCI OSI from a firmware perspective should take 10 lines of code,
> > not:
>
> Thanks for confirming!
>
> >
> >  drivers/firmware/psci/Makefile                |   2 +-
> >  drivers/firmware/psci/psci.c                  | 219 ++++++++--
> >  drivers/firmware/psci/psci.h                  |  29 ++
> >  drivers/firmware/psci/psci_pm_domain.c        | 403 ++++++++++++++++++
> >
> > I have some concerns about these changes that I will state in the
> > relevant patches.
>
> Most of the above changes isn't for solely for OSI, but to support a
> hierarchical topology described in the PSCI DT layout. This is for
> example needed when other resources shares the same power rail as the
> CPU cluster.
>
> In other words, the series is orthogonal to whether OSI or PC mode is
> used for PSCI, just to make that clear. BTW, this is what you
> requested me to change into, a while ago.
>
> >
> > > My final point in regards to the OSI mode support, it's a minor part
> > > of the series. I don't see how that should hurt from a maintenance
> > > point of view, or perhaps I am wrong? In any case, I offer my help
> > > with review/maintenance in any form as you may see need/fit.
> >
> > I will go through the series but most of this code should move
> > to core PM code, it has nothing to do with PSCI.
>
> I am looking forward to your review - and for sure, I am open to suggestions!
>
> >
> > BTW, apologies for the delay, I was away.

Lorenzo, a gentle ping.

Kind regards
Uffe
