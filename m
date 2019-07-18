Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129E5C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6AA21783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMo3sNQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390041AbfGRKsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:48:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42994 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfGRKsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:48:51 -0400
Received: by mail-vs1-f66.google.com with SMTP id 190so18769874vsf.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 03:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NppfMkA9YSp2bcd8lowDgozs69+YWUjU8R8XC2mh2Ng=;
        b=EMo3sNQfR8AxwQbc/nsBmFB2MttmgcYpKR6+imTy+1EG/hxf2H1FX4coJIjBZs9MU4
         T5gfuRfY0RJvbYIUjVknrZr6Eg6Zw3N5HG7aed/9UdUeTX7a1AlUZLU0w2OsoUoEoMMt
         rNcp0hzFlDtjweQ0S7IYVyCrtnbDY7fv+TpkkRIQfdT9q0pWwfYCh9v0s/AYlWjWKojb
         Q+FcvGHicvaXo3IiVCcV9apv0MI03oWm1qSfSilrp9K00e6Am331V9AMy4viOYZqv9JI
         kKEBYgZiDcA6zHuKe3PNvCPdq/SzEDbDaWOug2ZuxcVj6N1EZ6a6yqkw7R+JUtFUrKoi
         rCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NppfMkA9YSp2bcd8lowDgozs69+YWUjU8R8XC2mh2Ng=;
        b=d50LJ2MJc67fU3Vf457mtpZS3kx2KmX8Hgv6JecJj8rYXjIZuOqLEezLyOpJOFwcsi
         4202xp+YO8TjoT7n2qNl/p8aHf5O8fVNTF6BJ4Yyv8ceoYyhu5SOdwm5LW/hLW9xH7cb
         1vH5LguZtEIXiVQ96QPYHCn50xcFIs1ElEKr9JOZihC9X6WYvQeR+s1mFlF1Mct9OBAu
         4ViamhKbybla/cz1IIE7sZ4NDtntDFEEXpvlBpIYz1Yx5cSPDiO+vZR8bPU4SupTSRkR
         LY5MxgyOdcl/dYf9YznnM94Jn8QATdQz5W0c/j24Ipzruxv8CLhl/C1G2Z/k5Rd6ka3v
         Lpwg==
X-Gm-Message-State: APjAAAXphlm3nUgyVuosoq5OHldooXXaPVR6+dEguDSapMVzs//qSDU/
        YxCJJE6iAehSD3Ylt/miRm6hnDaCzFQV2RByls6pPg==
X-Google-Smtp-Source: APXvYqztqpfIkQ19AlRQPrqfsqTvP4cIR4ExKB8fsNIFkHPM8GZNpANZzIhR9gX186T9JnVglUf6rgxAB2sJLtT7RWg=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr28577969vsp.191.1563446930654;
 Thu, 18 Jul 2019 03:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <20190513192300.653-19-ulf.hansson@linaro.org>
 <20190716144744.GB7250@e107155-lin>
In-Reply-To: <20190716144744.GB7250@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 18 Jul 2019 12:48:14 +0200
Message-ID: <CAPDyKFpc26yL6rOnfwawL=eL649NsgTMrF1WrMHZv7AVd=3PCA@mail.gmail.com>
Subject: Re: [PATCH 18/18] arm64: dts: hikey: Convert to the hierarchical CPU
 topology layout
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
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
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 at 16:47, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, May 13, 2019 at 09:23:00PM +0200, Ulf Hansson wrote:
> > To enable the OS to manage last-man standing activities for a CPU, while an
> > idle state for a group of CPUs is selected, let's convert the Hikey
> > platform into using the hierarchical CPU topology layout.
> >
> > Cc: Wei Xu <xuwei5@hisilicon.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes:
> >       - None.
> >
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 87 ++++++++++++++++++++---
> >  1 file changed, 76 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > index 108e2a4227f6..36ff460f428f 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> >       cpus {
>
> [...]
>
> > @@ -70,9 +128,8 @@
> >                       };
> >
> >                       CLUSTER_SLEEP: cluster-sleep {
> > -                             compatible = "arm,idle-state";
> > -                             local-timer-stop;
> > -                             arm,psci-suspend-param = <0x1010000>;
> > +                             compatible = "domain-idle-state";
> > +                             arm,psci-suspend-param = <0x1000000>;
> >                               entry-latency-us = <1000>;
> >                               exit-latency-us = <700>;
> >                               min-residency-us = <2700>;
>
> Again this must be original format and as per PSCI spec, your patch
> changes this cluster sleep state into cluster retention state which I
> think is not what you intended.

If the hierarchical topology is used, the parameter for cluster states
are ORed with the deepest idle state for the CPU.

CPU_SLEEP: 0x0010000
CLUSTER_SLEEP: 0x1000000

After the ORed operation
CLUSTER_SLEEP: 0x1010000

So, this indeed works as expected.

However, are you saying that ORing the state parameters like above has
other problems? I am reading your other replies...

Kind regards
Uffe
