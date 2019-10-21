Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41791CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B2020882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="r104k429"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfJUSa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:30:29 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35457 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfJUSa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:30:28 -0400
Received: by mail-il1-f194.google.com with SMTP id p8so3256779ilp.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 11:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AR63DmWjyzGt6KRdOolpGSBjajplu7OlrmmkLDJcF1w=;
        b=r104k429d5kD4MhbpW7CsAzUCeS0MvNA2lwEo7M3+M+ZRmetRuneB8nvFRgLuP5tQ6
         J9AKWyyIKKMOX00v0Kdg61NH+qsyMxoXqdfAltdCnCFK4pEdyXQhccQsFXnzV3ALGMjF
         SGS27FyioGLGTnffmypWBvmKw8dC6yfr+isAhHG9DtvWsqLqu6xlyJDWEk4lKH/r40B7
         Wxerfq7p3FpMUFwQs8jVPnsL1bLo1Ve8L9+s4ZS17nQ0yiIO2u6g3DVw1MFsuFNNM+f7
         AugqoDYUUN0oVT99Q04VqQJ8YWw8013gmT4592iYFmLJkmSN+9FKG8UnkYOwGWeEvV9P
         czhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AR63DmWjyzGt6KRdOolpGSBjajplu7OlrmmkLDJcF1w=;
        b=mYVMq/S1/bstJkF07Ud6h/tQOCJ7pC4fyqoqMcxZjOipWTuSiHJGppYSrH4wrm14Bi
         1TQz7GwzHjChPpNPdIuQA+4hiXdvtnArK0iwKyP9RbUUTDNFasT+RUKakeN62w4+1Lo2
         uxfWtInwpR3buf2FzTgEk3YYp3nDN0XemZKUAGwgJ6kPEFy1Rpozwq646VEAJt3oCPj2
         UrpVnKMKFVRpM6jvLo0aJCGU7TJ2n0HOEj8Ldw2oHAOL2eBeqHaovLCblo8d1/SSgUSw
         VsEhlS9E240g7P7E8IH2+/oz/tcLHcgWUaubJ2pCjUYPkQ5130o33cMPFaojxIMf29vu
         8A4A==
X-Gm-Message-State: APjAAAXYC9J8cWUBwjPIiOlfBJNWSrB/TMOh4aHf4OGXsyxyvZ9Bwz2J
        bZOY3RvPU12mNu8VudjgFvqQ4F5QxfAUtNGVwYuNGg==
X-Google-Smtp-Source: APXvYqxDB3gB2L7gTQbzzkQP9wEvUweroIM30iMNvPJ5rKY/UAIM6U3j7QAfdmgJ+vmcQ6N1I2k2AlTFXOpvzMZTjxM=
X-Received: by 2002:a92:d24d:: with SMTP id v13mr28009523ilg.112.1571682627649;
 Mon, 21 Oct 2019 11:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191018232124.4126-1-rjones@gateworks.com> <20191021081945.o7knknxacm6uvd3c@pengutronix.de>
In-Reply-To: <20191021081945.o7knknxacm6uvd3c@pengutronix.de>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Mon, 21 Oct 2019 11:30:16 -0700
Message-ID: <CALAE=UBqEShQ6REhqPEChpXX7-soi4w9vdEu8rO8QfqZqCBS8Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dt: add lsm9ds1 iio imu/magn support to gw553x
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 1:19 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Robert,
>
> same here, don't name it 'ARM: dt: ...' instead name it 'ARM: dts: imx:
> ventana: ..' or 'ARM: dts: imx: imx6qdl-gw553x: ..'.

Sorry about that, I'll follow that format from now on.
>
> On 19-10-18 16:21, Robert Jones wrote:
> > Add one node for the accel/gyro i2c device and another for the separate
> > magnetometer device in the lsm9ds1.
> >
> > Signed-off-by: Robert Jones <rjones@gateworks.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl-gw553x.dtsi | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
> > index a106689..55e6922 100644
> > --- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
> > @@ -173,6 +173,25 @@
> >       pinctrl-0 = <&pinctrl_i2c2>;
> >       status = "okay";
> >
> > +     lsm9ds1_ag@6a {
> > +             compatible = "st,lsm9ds1-imu";
>
> Didn't found this compatible string.
So this is a compatible string for a driver that's being mainlined
now. The devicetree bindings for which has already been reviewed-by
Rob Herring as seen here:
https://www.spinics.net/lists/linux-iio/msg47297.html. If possible I'd
prefer to get this in the same kernel release so let me know if
there's anything else I can do to make that happen.

>
> > +             reg = <0x6a>;
> > +             st,drdy-int-pin = <1>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_acc_gyro>;
> > +             interrupt-parent = <&gpio7>;
> > +             interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > +     lsm9ds1_m@1c {
> > +             compatible = "st,lsm9ds1-magn";
> > +             reg = <0x1c>;
>
> Nodes are sorted according their i2c-addresses.
>
I'll resubmit with that change, thanks!
- Bobby

> Regards,
>   Marco
>
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_mag>;
> > +             interrupt-parent = <&gpio1>;
> > +             interrupts = <2 IRQ_TYPE_EDGE_RISING>;
> > +     };
> > +
> >       ltc3676: pmic@3c {
> >               compatible = "lltc,ltc3676";
> >               reg = <0x3c>;
> > @@ -462,6 +481,18 @@
> >               >;
> >       };
> >
> > +     pinctrl_acc_gyro: acc_gyrogrp {
> > +             fsl,pins = <
> > +                     MX6QDL_PAD_GPIO_18__GPIO7_IO13          0x1b0b0
> > +             >;
> > +     };
> > +
> > +     pinctrl_mag: maggrp {
> > +             fsl,pins = <
> > +                     MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x1b0b0
> > +             >;
> > +     };
> > +
> >       pinctrl_pps: ppsgrp {
> >               fsl,pins = <
> >                       MX6QDL_PAD_ENET_RXD1__GPIO1_IO26        0x1b0b1
> > --
> > 2.9.2
> >
> >
> >
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
