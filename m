Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88840C2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 22:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D03D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 22:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="WZFpyQFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLWWzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 17:55:31 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36365 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfLWWzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:55:31 -0500
Received: by mail-io1-f66.google.com with SMTP id r13so7527677ioa.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 14:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCY+BqVcdbrXD0gu/PsP/KokjQz+TuxHQGPsNwzwFVQ=;
        b=WZFpyQFoDNC2LiXKC+BdJ3QRHePv8zANl/ujX87H7RpEgPDnFOgTTy2J4n9hNG1hBV
         mWyZEhcepZUzOKTy8YnaIn7dOiqHt4kReiqM/8Td3CY5pNmFB4weota1r6/wjM4KD2tM
         MUSlhRW/SIvWKpWwQSRHW12ZGU9bnTAm7TUGVRnWEalKTe1ueGJb2SFxe7oRHDrcwqVJ
         Ii0nSylfyhHGA/qJKCQ6E2pqWjx+NRbwfixb4HayWnW9ewNIdkk1eg00nPxbBck/pEb4
         IccyTvyKy3pbYVH8PSO/vJdcK0HUZOU0E2JFYtp/z3rKhVYTcD9DEKiTDllJVwWRGCt4
         /3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCY+BqVcdbrXD0gu/PsP/KokjQz+TuxHQGPsNwzwFVQ=;
        b=FI83dcBNlTQ2EPXaauOnKS69ofSu0md/KhbKblfCqlrU82YUcw1gMaMB5koRZYSUjR
         AR6JYWLef0NAc5rFQ0CGp3miFrdpH+cfGih4Pe7S8SjSsAYKYEPrWVRMT2Rf/6uzbq0A
         5BjW8Pf8xXvNzfCSJA0KVGJ/5qJUC+V9lcz4GtfTE0EAAj55HcN7+DDi0esVm7uKRXur
         B6v2Sayxa8IHmBilaxkIdKxnvVFyHAdNLsXERhJ39A/U+bvrDAi+BnvNnBHVPCXOq5HV
         rChgwH/WzezEMdTnmqvtOeqylzTilZVsVmHVsi9u1d7MxiyXduzRchX1sHH0tDWh3Niz
         oeZg==
X-Gm-Message-State: APjAAAWPOKiJ47ZXhofpVF52fC2OMYn/re+HIrIicIyPR3KnZdhBqU1u
        LdagYwM6q5OEd5O5SZTcsx6isiBqYv/fUBntstiZ/A==
X-Google-Smtp-Source: APXvYqw5ermERDc5VenZlmctHWndmFEZr/NIjilASC/vSpdvgbvFnE3TMf4Vbb5vFX5lweWQMgDGMe/yNK7ZPHzI8zQ=
X-Received: by 2002:a6b:5917:: with SMTP id n23mr22528622iob.112.1577141730332;
 Mon, 23 Dec 2019 14:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20191223214412.12259-1-rjones@gateworks.com> <20191223214412.12259-2-rjones@gateworks.com>
 <CAOMZO5CLfyZjuz3c+Xr9v0D5h+r83PGgi8BrMnQZOOZSM-iGGw@mail.gmail.com>
In-Reply-To: <CAOMZO5CLfyZjuz3c+Xr9v0D5h+r83PGgi8BrMnQZOOZSM-iGGw@mail.gmail.com>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Mon, 23 Dec 2019 14:55:19 -0800
Message-ID: <CALAE=UAok8dazxPj16TAV7rQ_6EZvLBp3t5J2CjweMyECkZAHA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ARM: dts: imx: Add GW5907 board support
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 2:06 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Robert,
>
> On Mon, Dec 23, 2019 at 6:44 PM Robert Jones <rjones@gateworks.com> wrote:
> >
> > The Gateworks GW5907 is an IMX6 SoC based single board computer with:
> >  - IMX6Q or IMX6DL
> >  - 32bit DDR3 DRAM
> >  - FEC GbE Phy
> >  - bi-color front-panel LED
> >  - 256MB NAND boot device
> >  - Gateworks System Controller (hwmon, pushbutton controller, EEPROM)
> >  - Digital IO expander (pca9555)
> >  - Joystick 12bit adc (ads1015)
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > Signed-off-by: Robert Jones <rjones@gateworks.com>
>
> Not clear on the authorship on this patch.
>
> If the original author is Tim, then his name should appear in the From field.
>

Original author for all but the GW5910 patch was myself. It's probably
not clear here but Tim reviewed the patches prior to submission and
had me add him as a Signed-off-by.

Would it be better to just remove those lines from the patches in this case?

> > ---
> >  arch/arm/boot/dts/Makefile            |   2 +
> >  arch/arm/boot/dts/imx6dl-gw5907.dts   |  14 ++
> >  arch/arm/boot/dts/imx6q-gw5907.dts    |  14 ++
> >  arch/arm/boot/dts/imx6qdl-gw5907.dtsi | 399 ++++++++++++++++++++++++++++++++++
> >  4 files changed, 429 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx6dl-gw5907.dts
> >  create mode 100644 arch/arm/boot/dts/imx6q-gw5907.dts
> >  create mode 100644 arch/arm/boot/dts/imx6qdl-gw5907.dtsi
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 1e9e1af..9ee80e2 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -422,6 +422,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
> >         imx6dl-gw560x.dtb \
> >         imx6dl-gw5903.dtb \
> >         imx6dl-gw5904.dtb \
> > +       imx6dl-gw5907.dtb \
>
> You should add an additional patch that add these new boards in
> Documentation/devicetree/bindings/arm/fsl.yaml

So I was planning on just adding an enum line for "gw,ventana" under
the i.MX6DL and i.MX6Q based Boards sections. Would that be
sufficient?

We have a lot of individual custom boards and it doesn't seem correct
to add individual strings for every one in both sections.
