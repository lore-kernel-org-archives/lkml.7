Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D52BC2D0D4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B40D20665
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 14:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dsq6D07h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLVO6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 09:58:37 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42288 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 09:58:36 -0500
Received: by mail-io1-f68.google.com with SMTP id n11so7214425iom.9;
        Sun, 22 Dec 2019 06:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e46uQFQTWmPxySVGOnVDnMR0Vq/breujBptRTHkRtEo=;
        b=Dsq6D07hwAfWRqT+mst18Y6cyq6FdUxNdpkwpkJIP0tcuj2QR2/IfItcBqXITPHDQj
         yskKG7ykem1MW+85i27wBUULgefjjH0t/UgG137z4Zi0C7YHJ9zBtHhdXW1OIzyBQcDw
         YQlCoTUCQaEHwxrDG7y211gxClhfrgBV80PXie+Y5Bb591HN5QqSK50445+We2ZSsDL6
         Y1TBB04O3T5l2iG4bjXjVclYL659VnwSYlAe0bmItEzTnKOSYMpFayesD9WVSERCB2Nw
         1qufae1STYXwX63cZY9B8wmCbi/E655mVNWUwAXPRyZSxYDuCkg4OE/tb5cv6A8BpN4Q
         0sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e46uQFQTWmPxySVGOnVDnMR0Vq/breujBptRTHkRtEo=;
        b=EzOHFi9+JD3lEN6QKfjmargHnk0mzQKFIBEWyNPpGbTI0N0bIcpdcLU5YuLaDqnmZz
         Rcs+xXjq6Vd6j9D9tpcL67jYfXjZCM1mZop5ZmfYxCDfXvXdKX5Ak4MX6tevL80LgDZ8
         wGVBS/WCepyK0YmCWsmG5KMHKCfUmcNYwO2rPXU2HMeGXdOpkjMhTtPur60BSAbT3tbB
         Wy67oO6m4LUPM88fLFzMpHJgJ01n2n/xjw0y9RgyX5diXeAIREoxYQH7JosHUAMnwjNr
         xqZ7IEi1nc2IlebUDfHsj81P/1Kv8UiqLTG7BzBCg0HDlr39vKhgb4FZLbNe0S7bjlBT
         DuBw==
X-Gm-Message-State: APjAAAUjtF8ps10lyu7E7mp9NcI2/DRvEv4c3wQdC0/vAm0XgdfXsERP
        orkG3pPUUjbsb7iALQVY3Y/KrZSO+QmLTEfaNWo=
X-Google-Smtp-Source: APXvYqzEZ4N1k3wco5tAG7OfTqaUYpIinWmS9sijseBxbpCF6TmbB3laZ71W4Lov8h4mdE4ETTqg/ObVe5ScUZhjayM=
X-Received: by 2002:a05:6638:76c:: with SMTP id y12mr20529558jad.95.1577026715317;
 Sun, 22 Dec 2019 06:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20191213160542.15757-1-aford173@gmail.com> <CAHCN7xKuVCGqgRpixa9UPkWq92Gg=dm4XxAczBKAZCoMzcBVJg@mail.gmail.com>
 <DB7PR04MB5178EA739587B2DB084570B9872F0@DB7PR04MB5178.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB5178EA739587B2DB084570B9872F0@DB7PR04MB5178.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 22 Dec 2019 08:58:23 -0600
Message-ID: <CAHCN7xKa1+=_K_cYXvZW3vfT1gEoYDyK=_8ERBdxvOhB3gTvww@mail.gmail.com>
Subject: Re: [PATCH V2 0/7] soc: imx: Enable additional functionality of
 i.MX8M Mini
To:     Jacky Bai <ping.bai@nxp.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2019 at 2:33 AM Jacky Bai <ping.bai@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Adam Ford <aford173@gmail.com>
> > Sent: Saturday, December 21, 2019 11:07 PM
> > To: arm-soc <linux-arm-kernel@lists.infradead.org>
> > Cc: Peng Fan <peng.fan@nxp.com>; Jacky Bai <ping.bai@nxp.com>; Rob
> > Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > dl-linux-imx <linux-imx@nxp.com>; devicetree <devicetree@vger.kernel.org>;
> > Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Leonard Crestez
> > <leonard.crestez@nxp.com>
> > Subject: Re: [PATCH V2 0/7] soc: imx: Enable additional functionality of
> > i.MX8M Mini
> >
> > On Fri, Dec 13, 2019 at 10:05 AM Adam Ford <aford173@gmail.com> wrote:
> > >
> > > The GPCv2 controller on the i.MX8M Mini is compatible with the driver
> > > used for the i.MX8MQ except for the register locations and names.
> > > The GPCv2 controller is used to enable additional periperals currently
> > > unavailable on the i.MX8M Mini.  In order to make them function, the
> > > GPCv2 needs to be adapted so the drivers can associate their power
> > > domain to the GPCv2 to enable them.
> > >
> > > This series makes one include file slightly more generic, adds the
> > > iMX8M Mini entries, updates the bindings, adds them to the device
> > > tree, then associates the new power domain to both the OTG and PCIe
> > > controllers.
> > >
> > > Some peripherals may need additional power domain drivers in the
> > > future due to limitations of the GPC driver, but the drivers for VPU
> > > and others are not available yet.
> >
> > Before I do a V3 to address Rob's comments, I am thinking I'll drop the items
> > on the GPC that Jacky suggested would not work, and we don't have drivers
> > for those other peripherals (GPU, VPU, etc.) anyway.  My main goal here was
> > to try and get the USB OTG ports working, so I'd like to enabled enough of the
> > items on the GPC that are similar to the i.MX8MQ and leave the more
> > challenging items until we have either a better driver available and/or actual
> > peripheral support coming.  I haven't seen LCDIF or DSI drivers pushed
> > upstream yet, so I doubt we'll see GPU or VPU yet until those are done.
> >
> > Does anyone from the NXP team have any other comments/concerns?
> >
>
> If you look into NXP's release code, you will find that it is not easy to handle the
> power domain more generically in GPCv2 driver for imx8mm. That's the reason why we use
> SIP service to handle all the power domain in TF-A. we tried to upstream the SIP version
> power domain that can be reused for all i.MX8M, but rejected by ARM guys. they think
> we need to use SCMI to implement it. as there is no SCMI over SMC available, upstream is
> on the way, so the power domain for i.MX8MM/MN is pending.
>

Thank you for the background. I appreciate it.

> Actually, I am confused why we can't use SIP service, even if the SCMI over SMC is ready in
> the future, It seems the SMCC function ID still need to choose from SIP service function id bank.
>
> Another concern for adding power domain support in GPCv2 is that, each time a new
> SOC is added, we need to add hundred lines of code in GPCv2 driver. it is not a best way
> to keep driver reuse. The GPCv2 driver is originally used for i.MX7D, then reused by i.MX8MQ,
> as i.MX8MQ has very simple power domain design as i.MX7D. But for i.MX8MM, it is not the
> case.

There are some entries on the 8MM which can be used the same way as
the 8MM.  I have been able to get USB OTG working using the 8MQ's GPC
table.

Until sometime better is available, would you entertain a limited use
of the 8MQ's GPC where the device tree nodes only contain a limited
number of entries (like USB OTG) where we can re-use the similar
functions 8MQ without expanding the driver functions?  I know its not
ideal, but it would be a temporary solution unless you think the
upstream power domain support is coming quickly.  I looked through the
mailing list history and it looked like there were some attempts about
6 months ago, then it appeared to stop.

Once the newer driver is available upstream, we could then remove GPC
references from the 8MM device tree and point it to the new driver.

It would increase some limited functionality for the short term.  I
know Leonard has been working on the DDRC modifications and power
reduction.  I have been trying to use them, but unsuccessful so far.
>
> There is another concern, we don't want to export GPC module to rich OS side, it is not a must.

What about doing it in the U-Boot stage if Linux isn't an option and
ATF isn't accepting them?

adam
>
> BR
> Jacky Bai
>
> > adam
> > >
>
> > > Adam Ford (7):
> > >   soc: imx: gpcv2: Rename imx8mq-power.h to imx8m-power.h
> > >   soc: imx: gpcv2: Update imx8m-power.h to include iMX8M Mini
> > >   soc: imx: gpcv2: add support for i.MX8M Mini SoC
> > >   dt-bindings: imx-gpcv2: Update bindings to support i.MX8M Mini
> > >   arm64: dts: imx8mm: add GPC power domains
> > >   ARM64: dts: imx8mm: Fix clocks and power domain for USB OTG
> > >   arm64: dts: imx8mm: Add PCIe support
> > >
> > >  .../bindings/power/fsl,imx-gpcv2.txt          |   6 +-
> > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 127 ++++++++-
> > >  arch/arm64/boot/dts/freescale/imx8mq.dtsi     |   2 +-
> > >  drivers/soc/imx/gpcv2.c                       | 246
> > +++++++++++++++++-
> > >  .../power/{imx8mq-power.h => imx8m-power.h}   |  14 +
> > >  5 files changed, 387 insertions(+), 8 deletions(-)  rename
> > > include/dt-bindings/power/{imx8mq-power.h => imx8m-power.h} (57%)
> > >
> > > --
> > > 2.20.1
> > >
