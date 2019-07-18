Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5604C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C82208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0bRe+v4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391429AbfGRVtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:49:49 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33164 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfGRVts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:49:48 -0400
Received: by mail-vs1-f68.google.com with SMTP id m8so20263004vsj.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVaakzPBBxcCnU1uQoatmOIcAq9lkWIyC/ZitRYoNgg=;
        b=X0bRe+v4iwS6jdXfFpHS/B1EX7o/Ag7+xrNChOx3rwtQf1rriCNbBBc2AORVmlG9gC
         KVxWBeK9NBQ8gBXi8w3Av9R1Yh8r3h7xlJoRYPAOSzyytZUVC4+ejy9Cn3PMuHz9YpW/
         IxLuV6N64nVRcqJGyugTEStIUQQsmFjSjI3Fy/4XjJOaWPe1Tv10djjEfP5VnAyre9Oz
         +v6sV/2I3P9kSX69DLaBAK+GbpCi9bKxUIteMutCxdGAkTLk6xGcGP1HExLaCbrye+OE
         8gxLRO/Twcav0vXVKqTdUtgl/TBIEzaP0a1edGLGuHPegpLd/TMcEm8b/qDG4Ok3mPbw
         W7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVaakzPBBxcCnU1uQoatmOIcAq9lkWIyC/ZitRYoNgg=;
        b=Ks9fb1p582+/P9XYKp7Rxa9m2Ez1JzKV/cIGEI43YjdZNTZ2XRxdlzHfXlWoxdRZwf
         QiL/hoGoH+sykAXn2WYQzzvImlZtNQ8q8Vt0UOEn2xN+oxhZNMVoR/RI7Fi1C0lNw0dl
         fPKgdmUQ9pCWHljCpp6Qc3ZCPe82jFx3g7sK7zHN/gPxSbkvfPA+gWGgH9Hzp3ApSNlH
         cbVK1n8GXNZLv5l3HYlNh8h4XBsU2bfEcu09CCpc7BBjdLkeXc20obW2VFm0p6siMBGY
         RywqQWds0ajebuYpDkgB2kvbVSKg36FjsoUVhraPGeoLc1wyL0CNCgOJ00flA1+/Cdgm
         OikA==
X-Gm-Message-State: APjAAAXOKi9ZJMaXG0rNnZE53gGUD4x05b8NVV+79KnZWTUCoMmqyE4j
        v1iANkiGpFTvVcBtACWtQtwwt/0W4GSIO/6vRCLgRA==
X-Google-Smtp-Source: APXvYqx6w0adJ6xepr9OilXJBz3+Zq+jx9/hhhjOwrMjwd3XZB1LUnFpt9Xc9uk4rPa7wYkP1TAGbNJcQe6BKGLWrJs=
X-Received: by 2002:a67:e454:: with SMTP id n20mr31593172vsm.34.1563486587134;
 Thu, 18 Jul 2019 14:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <20190513192300.653-15-ulf.hansson@linaro.org>
 <20190716155317.GB32490@e121166-lin.cambridge.arm.com> <CAPDyKFrJ75mo+s6GuUCTQ-nVv7C+9YJyTVmwuBZ2RKFOvOi3Nw@mail.gmail.com>
 <20190718133053.GA27222@e121166-lin.cambridge.arm.com> <CAPDyKFr4NmichQk4uf+Wgbanh=5idKYY=37WCb6U_hNFDVYg=w@mail.gmail.com>
 <20190718174116.GD25567@codeaurora.org>
In-Reply-To: <20190718174116.GD25567@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 18 Jul 2019 23:49:11 +0200
Message-ID: <CAPDyKFrxBdZfskyp2HOb5YykkAqkBzRfW4-LLbcj1DAaL65XpA@mail.gmail.com>
Subject: Re: [PATCH 14/18] drivers: firmware: psci: Manage runtime PM in the
 idle path for CPUs
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
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

On Thu, 18 Jul 2019 at 19:41, Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Thu, Jul 18 2019 at 10:55 -0600, Ulf Hansson wrote:
> >On Thu, 18 Jul 2019 at 15:31, Lorenzo Pieralisi
> ><lorenzo.pieralisi@arm.com> wrote:
> >>
> >> On Thu, Jul 18, 2019 at 12:35:07PM +0200, Ulf Hansson wrote:
> >> > On Tue, 16 Jul 2019 at 17:53, Lorenzo Pieralisi
> >> > <lorenzo.pieralisi@arm.com> wrote:
> >> > >
> >> > > On Mon, May 13, 2019 at 09:22:56PM +0200, Ulf Hansson wrote:
> >> > > > When the hierarchical CPU topology layout is used in DT, let's allow the
> >> > > > CPU to be power managed through its PM domain, via deploying runtime PM
> >> > > > support.
> >> > > >
> >> > > > To know for which idle states runtime PM reference counting is needed,
> >> > > > let's store the index of deepest idle state for the CPU, in a per CPU
> >> > > > variable. This allows psci_cpu_suspend_enter() to compare this index with
> >> > > > the requested idle state index and then act accordingly.
> >> > >
> >> > > I do not see why a system with two CPU CPUidle states, say CPU retention
> >> > > and CPU shutdown, should not be calling runtime PM on CPU retention
> >> > > entry.
> >> >
> >> > If the CPU idle governor did select the CPU retention for the CPU, it
> >> > was probably because the target residency for the CPU shutdown state
> >> > could not be met.
> >>
> >> The kernel does not know what those cpu states represent, so, this is an
> >> assumption you are making and it must be made clear that this code works
> >> as long as your assumption is valid.
> >>
> >> If eg a "cluster" retention state has lower target_residency than
> >> the deepest CPU idle state this assumption is wrong.
> >
> >Good point, you are right. I try to find a place to document this assumption.
> >
> >>
> >> And CPUidle and genPD governor decisions are not synced anyway so,
> >> again, this is an assumption, not a certainty.
> >>
> >> > In this case, there is no point in allowing any other deeper idle
> >> > states for cluster/package/system, since those have even greater
> >> > residencies, hence calling runtime PM doesn't make sense.
> >>
> >> On the systems you are testing on.
> >
> >So what you are saying typically means, that if all CPUs in the same
> >cluster have entered the CPU retention state, on some system the
> >cluster may also put into a cluster retention state (assuming the
> >target residency is met)?
> >
> >Do you know of any systems that has these characteristics?
> >
> Many QCOM SoCs can do that. But with the hardware improving, the
> power-performance benefits skew the results in favor of powering off
> the cluster than keeping the CPU and cluster in retention.
>
> Kevin H and I thought of this problem earlier on. But that is a second
> level problem to solve and definitely to be thought of after we have the
> support for the deepest states in the kernel. We left that out for a
> later date. The idea would have been to setup the allowable state(s) in
> the DT for CPU and cluster state definitions and have the genpd take
> that into consideration when deciding the idle state for the domain.

Thanks for confirming.

This more or less means we need to improve the hierarchical support in
genpd to support more levels, such that it makes sense to have a genpd
governor assigned at more than one level. This doesn't work well
today. As I also have stated, this is on my todo list for genpd.

However, I also agree with your standpoint, that let's start simple to
enable the deepest state as a start with, then we can improve things
on top.

Kind regards
Uffe
