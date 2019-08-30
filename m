Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB71C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DC221874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSSx1i5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfH3I3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:29:42 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40133 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfH3I3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:29:42 -0400
Received: by mail-vs1-f65.google.com with SMTP id i128so4252393vsc.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 01:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBe6XaZnp1DnbEiSR3tbPdbSTWUBiMGkZ5MQKY+Y/KY=;
        b=HSSx1i5MvIQIppnHZp5fqcZbrHRsEuE5YKsm/+pYHehWrBMRK+Fd6yYLM9RPceYWJd
         2KN6Ql6owRNffruGbdNcZSAqSso17tFIIcpLbRp0zC8kl60dO1JXkxCOZvRcyu1dIufG
         1hvgSKaVKD1JOa1eugdmJFPrx3JHFGraiG6Yc+aNazmxxyKhIeW0A1MPoue8sWBjkHg1
         2U/LjQQvHxtbyHKyKIvRHUSrnvL/0y4viuiAdHl86m6N5FXBwrgxRMsJfPfOTkX2P/xF
         bddVRikttGaleYOjqpQag/5g5JIML0+a/1FaVIA8U+xTCk8rUGlWv6r2EV2vQ8hSxIyC
         SbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBe6XaZnp1DnbEiSR3tbPdbSTWUBiMGkZ5MQKY+Y/KY=;
        b=DKyEUQBFVdBAh7YvFfxQ/X1R3QKvYfc2xJ8Pel2gQd7pIzubiJBkvkZiPCGLsGF6C9
         LiJ620NR53WFBgLTda3IgnUdBjPi/kDA7QD/kGRZOvNb0q412Xo29inYXoZ5r/owPFwb
         OhmiVDEoCfBBISf7ZJV3n09Q+06Zbgl2anGPdz0I9UUvSv7D6mqOpWXbG0TU/4PVq77K
         8IUe3sRpaJEUOQ0EfmGFEWOX9lE6zWf9O/cELMLVbFsjLk7ojmk2HX7KQI3UAqN7adwA
         rCPrpCKX4Ni2dfmSYpl6rPnKhbi02ezEYMN5wd1pl5GGej7PpcmbROmugsr6euLS3I5y
         QE4Q==
X-Gm-Message-State: APjAAAU9/BhLgiWsEM9vjtN+frDk3n1hgBzqwUw+V8jD+iDjP1fU+dX2
        diNfmMmmw2itgR1gQm5LwZ9088wUXm9SKxdSanEEQw==
X-Google-Smtp-Source: APXvYqwT1/od4MWptrO2+eo5tENQaNYQ7XxIzCOrNHxyh49sPnVWPm0JNv85t1DAPIYt12rpwJzChBk7AwrIozo1u18=
X-Received: by 2002:a67:e287:: with SMTP id g7mr7906924vsf.200.1567153781210;
 Fri, 30 Aug 2019 01:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190830074644.10936-1-andrew@aj.id.au> <20190830074644.10936-2-andrew@aj.id.au>
 <CAPDyKFrKXfB1F2dh63KrkCiKGbmbBWaAM16vJqtQncnF4YctQw@mail.gmail.com> <6feca359-34ce-445e-87bf-62fa063d785f@www.fastmail.com>
In-Reply-To: <6feca359-34ce-445e-87bf-62fa063d785f@www.fastmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Aug 2019 10:29:04 +0200
Message-ID: <CAPDyKFpiftO194L2pf-_Yxu_BbizP6ss46YUZNO9ZxceeeWw4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-aspeed: Uphold clocks-on post-condition
 of set_clock()
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        openbmc@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 at 10:07, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Fri, 30 Aug 2019, at 17:31, Ulf Hansson wrote:
> > On Fri, 30 Aug 2019 at 09:46, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > The early-exit didn't seem to matter on the AST2500, but on the AST2600
> > > the SD clock genuinely may not be running on entry to
> > > aspeed_sdhci_set_clock(). Remove the early exit to ensure we always run
> > > sdhci_enable_clk().
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  drivers/mmc/host/sdhci-of-aspeed.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > > index d5acb5afc50f..a9175ca85696 100644
> > > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > > @@ -55,9 +55,6 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> > >         int div;
> > >         u16 clk;
> > >
> > > -       if (clock == host->clock)
> > > -               return;
> > > -
> > >         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > >
> > >         if (clock == 0)
> > > --
> > > 2.20.1
> > >
> >
> > Further down in aspeed_sdhci_set_clock() you should probably also
> > remove the assignment of host->clock = clock, as that is already
> > managed by sdhci_set_ios().
>
> Ah, I'll fix that in a v2 once I have your thoughts on patch 2/2.

I leave this one to Adrian to comment on, as he knows this better than me.

[...]

Kind regards
Uffe
