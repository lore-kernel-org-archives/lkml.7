Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6562DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE38233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcFXE6Fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbfHVNjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:39:05 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39164 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389173AbfHVNjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:39:03 -0400
Received: by mail-ua1-f66.google.com with SMTP id k7so1997967uao.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FeL+2QSM5K1YLKKF/js9TmuXZpGlOsVDG+4zs7enb+s=;
        b=vcFXE6FvKpiU/zrPeYmswemc9N4V2PgJ6+b3JrTcb/leP+MyngmDkrXMX6fNCC6dqn
         5U5DxhJ0+6trsoUFiL1UHaJoAtvD3avRnS5Jjn0hIWhxZH5BNh+UbEx7r03YoAl794Jw
         HR5w6Fc5AQ9DT3i4m4j2/UueQP7AxJY/ZOBZgowVNQz1pcUgPIDl6VPhzseEWNH2yhVL
         sFvrbBxAIf0ixOmb1AbOZTeD4bKcIaPo7/IS32eixFYAFFMtH0FSJExgG3ZVVpz5HtpK
         wpmlq/Au0mkNCg+tpVy6s1iBWLieOP1LhX0U0hAfS+Vy8qt+5L2lehHVNPiimzJsKJTU
         YaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FeL+2QSM5K1YLKKF/js9TmuXZpGlOsVDG+4zs7enb+s=;
        b=eswtkjh3VMOnH91ClKfIIFyUd8wauT7Zab3IKno74SOnmNi7sr6XXrkVVLj4E6HoPC
         S9Q1ILLuB5XOwlkqssG/zd9OzP+Y/VIVqw+R3SjoHZZ3Ewe3uGsmLebHEFbKx3KonEIX
         LW3pamcYGzlZwOKxCz0OXesjCB0w7NZodDhH/Z/yWZPhZbJTjUpJ9Yq6PkQzqw/sn+jC
         8iGHHtROP31Knp9f+RU6k+sm/KITx9clGHXLW/UBNWVjCDOvtRKRK6u3ZfaGkCJS9WOr
         l4iIgTzL+whdjY3/4djpT64mMBn91+F1Gi7gWTHxHXOUNkEHZvbK0HjTCM4P2bskMZW6
         9pdA==
X-Gm-Message-State: APjAAAVCM6fWAvIhZOcdenkoqkOYbJpxljFab2bIZFa3FatUJYfikbkb
        D2J1GsqKVLaG320eYqCEAC4vN9uZcS6420tJPqM1uA==
X-Google-Smtp-Source: APXvYqyNGgp4CW1Vx1Kr/v3sCAPsdONPj1D+yM9NJraECZoktBBfmsmh2N05UsLj8cJbC+xyyKQktBrLSJpWnqXuTU4=
X-Received: by 2002:ab0:15e9:: with SMTP id j38mr5992611uae.19.1566481142313;
 Thu, 22 Aug 2019 06:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <1561958991-21935-2-git-send-email-manish.narani@xilinx.com>
 <20190722215404.GA28292@bogus> <MN2PR02MB602907616249FF19C1A737D8C1C70@MN2PR02MB6029.namprd02.prod.outlook.com>
 <CAPDyKFostBKYipTkCsDbggsrux7w8BPqARx7fwRsL1XqEEX2NQ@mail.gmail.com> <MN2PR02MB60299EB8B83C4EA68A0F2B33C1A80@MN2PR02MB6029.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB60299EB8B83C4EA68A0F2B33C1A80@MN2PR02MB6029.namprd02.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 15:38:26 +0200
Message-ID: <CAPDyKFqdLE7d9uz_KcpO0CihM+QsFyKbNsoDMoNLT2Qy_TmNdw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update documentation
 for SD Card Clock
To:     Manish Narani <MNARANI@xilinx.com>
Cc:     Rob Herring <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Michal Simek <michals@xilinx.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "christoph.muellner@theobroma-systems.com" 
        <christoph.muellner@theobroma-systems.com>,
        "philipp.tomsich@theobroma-systems.com" 
        <philipp.tomsich@theobroma-systems.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "ayaka@soulik.info" <ayaka@soulik.info>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "tony.xie@rock-chips.com" <tony.xie@rock-chips.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > > > ---
> > > > >  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 15
> > ++++++++++-
> > > > ----
> > > > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > > index 1edbb04..15c6397 100644
> > > > > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > > @@ -23,6 +23,10 @@ Required Properties:
> > > > >    - reg: From mmc bindings: Register location and length.
> > > > >    - clocks: From clock bindings: Handles to clock inputs.
> > > > >    - clock-names: From clock bindings: Tuple including "clk_xin" and
> > "clk_ahb"
> > > > > +            Apart from these two there is one more optional clock which
> > > > > +            is "clk_sdcard". This clock represents output clock from
> > > > > +            controller and card. This must be specified when #clock-cells
> > > > > +            is specified.
> > > > >    - interrupts: Interrupt specifier
> > > > >
> > > > >  Required Properties for "arasan,sdhci-5.1":
> > > > > @@ -36,9 +40,10 @@ Optional Properties:
> > > > >    - clock-output-names: If specified, this will be the name of the card
> > clock
> > > > >      which will be exposed by this device.  Required if #clock-cells is
> > > > >      specified.
> > > > > -  - #clock-cells: If specified this should be the value <0>.  With this
> > property
> > > > > -    in place we will export a clock representing the Card Clock.  This clock
> > > > > -    is expected to be consumed by our PHY.  You must also specify
> > > > > +  - #clock-cells: If specified this should be the value <0>. With this
> > > > > +    property in place we will export one clock representing the Card
> > > > > +    Clock. This clock is expected to be consumed by our PHY. You must
> > also
> > > > > +    specify
> > > >
> > > > specify what?
> > > I think this line was already there, I missed to correct it, Will update in v3.
> > >
> > > >
> > > > The 3rd clock input I assume? This statement means any existing users
> > > > with 2 clock inputs and #clock-cells are in error now. Is that correct?
> > > Yes, this is correct. So far there was only one vendor using '#clock-cells'
> > which is Rockchip. I have sent DT patch (02/11) for that also.
> > > Here this is needed as earlier implementation isn't correct as suggested by
> > Uffe. (https://lkml.org/lkml/2019/6/20/486) .
> >
> > I am not sure how big of a problem the backwards compatible thingy
> > with DT is, in general we must not break it. What do you say Manish?
>
> Though I agree with Uffe on this, there is no other way from my understanding. Please suggest.
>
> >
> > As a workaround, would it be possible to use
> > of_clk_get_from_provider() somehow to address the compatibility issue?
>
> For this to be used we have to parse 'clkspec' from the DT node and pass the same as an argument to this function. In this case also the DT node needs to be updated, which is same as we have done in this series.

Alright. I guess breaking DTBs for Rockchip platforms isn't
acceptable, especially if those are already widely deployed, which I
have no idea of....

And having support for both options in the driver seems not a great
option either, so it looks like you need to convert back into the old
v1 approach. Huh, sorry.

Kind regards
Uffe
