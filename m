Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB6DC2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 11:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26302072A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 11:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNuVa9ER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfLaL4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 06:56:05 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:37365 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfLaL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 06:56:05 -0500
Received: by mail-il1-f194.google.com with SMTP id t8so30065597iln.4;
        Tue, 31 Dec 2019 03:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRSoVG7cCI8RPd1O5aFFP++WrWKbrAcGftrzygloTqE=;
        b=gNuVa9ERTruOoBaJxIXpopQR+oQGk+HQhJoOydnBc4Nmwd6xzsOZD71zH7BibY/f4g
         fKmJ/wttxm4AZkmrTuZkrHUSB1K57WRgvBnB7Wvsz6pwdzHi/lwkOHsgykz99uj/WBiG
         qMza9bW0MNiYGk4kik5hSoKPveOaJymYPCerMPigFD3JpCkeKKBbntUme7xZW1deKmOb
         pDsSqUDR05o0ObUeJb7rYZjjusmDYdoY8v8l6z3+kMVdqnDbV6v1KJWD1C/Byaf152E0
         c+myf0Rf2GAux1BiBI4QcW0hRr10N3NzGyOQQr8APtdSB66SAwpYqmWEriepPnJcd6pU
         wSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRSoVG7cCI8RPd1O5aFFP++WrWKbrAcGftrzygloTqE=;
        b=fvzQB/mcdZ2HVjBTwFClGZyc3daRYZNH+yOC8i7ECqZCORFFFPU7YvNyNHB1Efcyp3
         6sh+BszLgRt+3EUoVFdhvT6x3ySbxqDUiHiLxzawMYKOPTmVakUoW1KjG6Yu15AFqx3y
         5+/rqDOdHPSZawo+BY3zmG7ztDvSuZwBvax451DjUoPS1X+UveIRcb/l1yU3rFOQO39w
         70U7aVCt/lYV//hRJzyiRmvpcI6JDdr9P2Xg8OG+Yv1zVfXDdBq0tZ30cc9RYvSAD4ZI
         8H5kZg+0uO22jOv17t8yww79AJFmk4m1LEzgXoq82JSNmk/KIM6G0sYwtoUsa6d5HFPX
         9JEg==
X-Gm-Message-State: APjAAAXHDKEWFiOgH4EC7YhN9TSETjU8A2uQ53hpU+YrrspFI7fFa4No
        Y2NMTCc+UBNXqkH+2xFnoI//zUKKVLZjlOE6efM=
X-Google-Smtp-Source: APXvYqxGi/VsO07u/hy1PTWndLoEFjaXkDuRfYk7YN5TKACSWIbuNO0OWp4ZUtPx1NAtNjv69g5PqA7CLzsYQs588A8=
X-Received: by 2002:a92:1547:: with SMTP id v68mr58685041ilk.58.1577793363751;
 Tue, 31 Dec 2019 03:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20191213160542.15757-1-aford173@gmail.com> <CAHCN7xKuVCGqgRpixa9UPkWq92Gg=dm4XxAczBKAZCoMzcBVJg@mail.gmail.com>
 <DB7PR04MB5178EA739587B2DB084570B9872F0@DB7PR04MB5178.eurprd04.prod.outlook.com>
 <CAHCN7xKa1+=_K_cYXvZW3vfT1gEoYDyK=_8ERBdxvOhB3gTvww@mail.gmail.com> <DB7PR04MB51785654798E176507F9531487260@DB7PR04MB5178.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB51785654798E176507F9531487260@DB7PR04MB5178.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 31 Dec 2019 05:55:50 -0600
Message-ID: <CAHCN7xJsv1HsmganvYOvNjrNvyU1+tfZU6gYVJT6pwt81BT3jA@mail.gmail.com>
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

On Mon, Dec 30, 2019 at 7:06 PM Jacky Bai <ping.bai@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Adam Ford <aford173@gmail.com>
> > Sent: Sunday, December 22, 2019 10:58 PM
> > To: Jacky Bai <ping.bai@nxp.com>
> > Cc: arm-soc <linux-arm-kernel@lists.infradead.org>; Peng Fan
> > <peng.fan@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> > <mark.rutland@arm.com>; Shawn Guo <shawnguo@kernel.org>; Sascha
> > Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > dl-linux-imx <linux-imx@nxp.com>; devicetree <devicetree@vger.kernel.org>;
> > Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Leonard Crestez
> > <leonard.crestez@nxp.com>
> > Subject: Re: [PATCH V2 0/7] soc: imx: Enable additional functionality of
> > i.MX8M Mini
> >
> > On Sun, Dec 22, 2019 at 2:33 AM Jacky Bai <ping.bai@nxp.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Adam Ford <aford173@gmail.com>
> > > > Sent: Saturday, December 21, 2019 11:07 PM
> > > > To: arm-soc <linux-arm-kernel@lists.infradead.org>
> > > > Cc: Peng Fan <peng.fan@nxp.com>; Jacky Bai <ping.bai@nxp.com>; Rob
> > > > Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > > > Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > > > dl-linux-imx <linux-imx@nxp.com>; devicetree
> > > > <devicetree@vger.kernel.org>; Linux Kernel Mailing List
> > > > <linux-kernel@vger.kernel.org>; Leonard Crestez
> > > > <leonard.crestez@nxp.com>
> > > > Subject: Re: [PATCH V2 0/7] soc: imx: Enable additional
> > > > functionality of i.MX8M Mini
> > > >
> > > > On Fri, Dec 13, 2019 at 10:05 AM Adam Ford <aford173@gmail.com>
> > wrote:
> > > > >
> > > > > The GPCv2 controller on the i.MX8M Mini is compatible with the
> > > > > driver used for the i.MX8MQ except for the register locations and
> > names.
> > > > > The GPCv2 controller is used to enable additional periperals
> > > > > currently unavailable on the i.MX8M Mini.  In order to make them
> > > > > function, the
> > > > > GPCv2 needs to be adapted so the drivers can associate their power
> > > > > domain to the GPCv2 to enable them.
> > > > >
> > > > > This series makes one include file slightly more generic, adds the
> > > > > iMX8M Mini entries, updates the bindings, adds them to the device
> > > > > tree, then associates the new power domain to both the OTG and
> > > > > PCIe controllers.
> > > > >
> > > > > Some peripherals may need additional power domain drivers in the
> > > > > future due to limitations of the GPC driver, but the drivers for
> > > > > VPU and others are not available yet.
> > > >
> > > > Before I do a V3 to address Rob's comments, I am thinking I'll drop
> > > > the items on the GPC that Jacky suggested would not work, and we
> > > > don't have drivers for those other peripherals (GPU, VPU, etc.)
> > > > anyway.  My main goal here was to try and get the USB OTG ports
> > > > working, so I'd like to enabled enough of the items on the GPC that
> > > > are similar to the i.MX8MQ and leave the more challenging items
> > > > until we have either a better driver available and/or actual
> > > > peripheral support coming.  I haven't seen LCDIF or DSI drivers pushed
> > upstream yet, so I doubt we'll see GPU or VPU yet until those are done.
> > > >
> > > > Does anyone from the NXP team have any other comments/concerns?
> > > >
> > >
> > > If you look into NXP's release code, you will find that it is not easy
> > > to handle the power domain more generically in GPCv2 driver for
> > > imx8mm. That's the reason why we use SIP service to handle all the
> > > power domain in TF-A. we tried to upstream the SIP version power
> > > domain that can be reused for all i.MX8M, but rejected by ARM guys.
> > > they think we need to use SCMI to implement it. as there is no SCMI over
> > SMC available, upstream is on the way, so the power domain for
> > i.MX8MM/MN is pending.
> > >
> >
> > Thank you for the background. I appreciate it.
> >
> > > Actually, I am confused why we can't use SIP service, even if the SCMI
> > > over SMC is ready in the future, It seems the SMCC function ID still need to
> > choose from SIP service function id bank.
> > >
> > > Another concern for adding power domain support in GPCv2 is that, each
> > > time a new SOC is added, we need to add hundred lines of code in GPCv2
> > > driver. it is not a best way to keep driver reuse. The GPCv2 driver is
> > > originally used for i.MX7D, then reused by i.MX8MQ, as i.MX8MQ has
> > > very simple power domain design as i.MX7D. But for i.MX8MM, it is not the
> > case.
> >
> > There are some entries on the 8MM which can be used the same way as the
> > 8MM.  I have been able to get USB OTG working using the 8MQ's GPC table.
> >
> > Until sometime better is available, would you entertain a limited use of the
> > 8MQ's GPC where the device tree nodes only contain a limited number of
> > entries (like USB OTG) where we can re-use the similar functions 8MQ
> > without expanding the driver functions?  I know its not ideal, but it would be
> > a temporary solution unless you think the upstream power domain support is
> > coming quickly.  I looked through the mailing list history and it looked like
> > there were some attempts about
> > 6 months ago, then it appeared to stop.
> >
> > Once the newer driver is available upstream, we could then remove GPC
> > references from the 8MM device tree and point it to the new driver.
> >
> > It would increase some limited functionality for the short term.  I know
> > Leonard has been working on the DDRC modifications and power reduction.
> > I have been trying to use them, but unsuccessful so far.
> > >
> > > There is another concern, we don't want to export GPC module to rich OS
> > side, it is not a must.
> >
> > What about doing it in the U-Boot stage if Linux isn't an option and ATF isn't
> > accepting them?
>
>
> I have enabled the USB/PCIE power domain by default early before, if using the community ATF,
> I think USB can work well.

Can you point me to which repo you're using?  When I use a stock
U-Boot from their repo with the ATF referenced from there, the board
hangs when USB is initialized.  Ideally, I'd like to get USB working
on the mainline Linux with mainline U-Boot.

adam
>
> BR
> Jacky Bai
>
> >
> > adam
> > >
> > > BR
> > > Jacky Bai
> > >
> > > > adam
> > > > >
> > >
> > > > > Adam Ford (7):
> > > > >   soc: imx: gpcv2: Rename imx8mq-power.h to imx8m-power.h
> > > > >   soc: imx: gpcv2: Update imx8m-power.h to include iMX8M Mini
> > > > >   soc: imx: gpcv2: add support for i.MX8M Mini SoC
> > > > >   dt-bindings: imx-gpcv2: Update bindings to support i.MX8M Mini
> > > > >   arm64: dts: imx8mm: add GPC power domains
> > > > >   ARM64: dts: imx8mm: Fix clocks and power domain for USB OTG
> > > > >   arm64: dts: imx8mm: Add PCIe support
> > > > >
> > > > >  .../bindings/power/fsl,imx-gpcv2.txt          |   6 +-
> > > > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 127 ++++++++-
> > > > >  arch/arm64/boot/dts/freescale/imx8mq.dtsi     |   2 +-
> > > > >  drivers/soc/imx/gpcv2.c                       | 246
> > > > +++++++++++++++++-
> > > > >  .../power/{imx8mq-power.h => imx8m-power.h}   |  14 +
> > > > >  5 files changed, 387 insertions(+), 8 deletions(-)  rename
> > > > > include/dt-bindings/power/{imx8mq-power.h => imx8m-power.h} (57%)
> > > > >
> > > > > --
> > > > > 2.20.1
> > > > >
