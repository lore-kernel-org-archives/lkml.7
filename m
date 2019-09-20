Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534FCC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A5E20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUxS8rzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfITUMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 16:12:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46256 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfITUMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 16:12:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so10052076qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1DVA3vKOlm/AZ8L4zulEE1hMXuljgOJAsGAyVpUvUI=;
        b=YUxS8rzK+f0gbi1Cu0GWV0MhZV0YpDvHEnfJ4R8mcMrXdyvN91fGs0GZgDxvaGqP/m
         KpoMUYs+uf0bq4QbaK9tVHYnq16V1te91foBq4Qnk6EdJi9dXmaVjil+q5LdeIdWgppR
         UujYQE/f8DTiORI37BMmMNemWvW1tl3Vf5qTRc/feiWdPr1yMbJkG8AwT+fjyt4M67jL
         7btY37HOE/cfp8/BA1Rjf11cLr9Yv1P76R2jUQNTph0AdSUCDPBvn+Ncs33PCrsiqGEf
         Zdm0/Ik8AUEMg9tShfWSUnr6VwNcKH3rC/IuxqZ9okbs7uRHiOAzAMrjb5HDyAekYvOl
         SmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1DVA3vKOlm/AZ8L4zulEE1hMXuljgOJAsGAyVpUvUI=;
        b=QoZn45abjglGzAfHqZzVoH8jiJX3gQ3ieKEmwUUuDqDmAe0ByUYg9Ef+eJ8jgogjnB
         AVH93YKtmq0hytyOTcRtRz3ZHmhk6MgC1F80EgHcPSqbjx8O1AKE8Wtu3OMlsDfM/643
         Ea2dmi9136FOmD/SbbmpO7S/mExCZI1tk59uYLsCY9iGnO9+EUPvdeUF8mMYN5NnPGal
         2Q0OkIriUNLGogMlLTQo+139yq3xbvmBqzZqBHsJnN2gnfB89SwttPwfl0CapIVZHPyH
         u2R0DtSlInrkavTUBs8aytWHCfZsxPXZst7/RkPD8rXPPStow69qIAYfqUCA1SO7lyz+
         n0Rw==
X-Gm-Message-State: APjAAAUTXAMCcFkNgclSomiba9epnbnDn9X9THfrOQfw9zcKs1dGjxQJ
        4J3yS9hZF3XQ8UMCtOiEPgmbR1KSrgYZyrE5N+PMVQ==
X-Google-Smtp-Source: APXvYqz/pNz6cRXqH8bTMfzVNZ+nlOMnGpp+f52AX7IwmjRsndWr0wWX0fLW2Hnxw2cuDZB95eiTwEgdZSrpMiawh30=
X-Received: by 2002:ad4:44e2:: with SMTP id p2mr14478831qvt.126.1569010340743;
 Fri, 20 Sep 2019 13:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568239378.git.amit.kucheria@linaro.org>
 <8f539b28c25d22b8f515c131cd6b24c309f7ca90.1568239378.git.amit.kucheria@linaro.org>
 <20190913101239.GB2559@bogus>
In-Reply-To: <20190913101239.GB2559@bogus>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 20 Sep 2019 13:12:09 -0700
Message-ID: <CAP245DUykhQ0OCs=BvM6nYD63NoBndn=vGUFEJ=DK7tEXp_=KQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: Kconfig: Fix VEXPRESS driver dependencies
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lists LAKML <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 3:12 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Sep 12, 2019 at 03:48:47AM +0530, Amit Kucheria wrote:
> > Push various VEXPRESS drivers behind ARCH_VEXPRESS dependency so that it
> > doesn't get enabled by default on other platforms.
> >
>
> I couldn't understand the motivation for these changes from the cover letter.

Yes, the cover letter for this series needs to be a lot better. Sorry.
In summary, I found a bunch of drivers in defconfig that were getting
called in early_initcall and core_initcall even when the platform or
COMPILE_TEST was not enabled. So I was just trying to ring fence some
of those drivers as a proof of concept to see if these changes were
acceptable upstream.

Let me try again with a better cover letter and using the pattern Arnd
suggested elsewhere.

> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/bus/Kconfig           | 2 +-
> >  drivers/clk/versatile/Kconfig | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> > index d80e8d70bf10..b2b1beee9953 100644
> > --- a/drivers/bus/Kconfig
> > +++ b/drivers/bus/Kconfig
> > @@ -166,7 +166,7 @@ config UNIPHIER_SYSTEM_BUS
> >
> >  config VEXPRESS_CONFIG
> >       bool "Versatile Express configuration bus"
> > -     default y if ARCH_VEXPRESS
> > +     depends on ARCH_VEXPRESS
> >       depends on ARM || ARM64
> >       depends on OF
> >       select REGMAP
> > diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
> > index ac766855ba16..826750292c1e 100644
> > --- a/drivers/clk/versatile/Kconfig
> > +++ b/drivers/clk/versatile/Kconfig
> > @@ -5,8 +5,8 @@ config ICST
> >  config COMMON_CLK_VERSATILE
> >       bool "Clock driver for ARM Reference designs"
> >       depends on ARCH_INTEGRATOR || ARCH_REALVIEW || \
> > -             ARCH_VERSATILE || ARCH_VEXPRESS || ARM64 || \
> > -             COMPILE_TEST
> > +             ARCH_VERSATILE || ARCH_VEXPRESS || COMPILE_TEST
> > +     depends on ARM64
>
> This will break 32-bit platforms.
>
> --
> Regards,
> Sudeep
