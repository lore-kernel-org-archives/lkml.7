Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8FCCA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B800B205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="udgCAere"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfJUTbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:31:43 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42131 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729869AbfJUTbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:31:43 -0400
Received: by mail-il1-f195.google.com with SMTP id o16so5054195ilq.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDsFciMfBsOLw/gb8ypekdMT3bU4wcz+6SRnbgFeGvM=;
        b=udgCAereY9DnrEwQiiU0e1UuO6gXEheU+q6aI9sR9IAcp787s9g2obd9zulwpL5kWa
         Sf1qJdoYN1FMy+SLp0qk+s7Qlb2cvwXFstYtafwAojAvYlN+O5PA5PtNDUkiAxu47fx5
         iIN1Y8fAcuSIxC6ftGD+bdh2D6dOpVWrTbMnwdi8bfyLPqo115Z9XIXwB+FrCLK19N2a
         qiF+cu3p9tJ4cSo8DPIxf1ZPSDSklrocyic2lqE7bjJ+T5MHjekhK4c9Ap845cY0oI8l
         AvPc+FWeNLDN7HpXZqxyP2b7lbBXJ6pNQAFtF4oG6GPWQaH6TCnFSFvVbO1CezOJG/7H
         uodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDsFciMfBsOLw/gb8ypekdMT3bU4wcz+6SRnbgFeGvM=;
        b=qqlJaS6uk9d8WNCeE12kvTqOe5vAlhere3R8u/LKumi4EuOwLxofB2/XHIt52yBG4J
         ImeZrb/kmEeGlvg1qepQhu/+NIU0nP1Tmegb0hqIy36KU8r93DeaDh0GvMb9/LArfvHI
         3zKlOnoVIoQcaspwhoaMPg0UI6WA0bOJJO5JZBSwix+kLRAEuLligrFreJ4L9xQJ4kt2
         U+DPfNfXDuZuhmuPCLrAiqcITtK4Fc74YsyuJDMv04U3RNSSN5WoUT+DvK5b8vIkby3k
         7osFEFqzA48fuXgfM6GlmlmK9YC2jefNK+sQVkbWQJ763VCril/8WuDhINhSqG9hwHlx
         zWhg==
X-Gm-Message-State: APjAAAV5uBCLqHgJVraJLlFPKoKZXhDhMBMvEdpg3bFHa+4TSH6Xz6ms
        4hpk/fK3tBNel2x29250JLqGwd8LFyTvjChV2q2Agw==
X-Google-Smtp-Source: APXvYqwpVjCm+96XudfU15BW3d+PZ8Ry9m5m0VIN1iJGNqbglYcN35ZlKkTbFE4TaPupWXjBuy45d9FZzFLxnEr0Ca8=
X-Received: by 2002:a92:c8cb:: with SMTP id c11mr26747744ilq.119.1571686301952;
 Mon, 21 Oct 2019 12:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191018232124.4126-1-rjones@gateworks.com> <20191021081945.o7knknxacm6uvd3c@pengutronix.de>
 <CALAE=UBqEShQ6REhqPEChpXX7-soi4w9vdEu8rO8QfqZqCBS8Q@mail.gmail.com>
In-Reply-To: <CALAE=UBqEShQ6REhqPEChpXX7-soi4w9vdEu8rO8QfqZqCBS8Q@mail.gmail.com>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Mon, 21 Oct 2019 12:31:31 -0700
Message-ID: <CALAE=UDFJH1Ch4ichFRjy5A2_-84k2MRcXqmU=1Ujv-Qqu2GQw@mail.gmail.com>
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

On Mon, Oct 21, 2019 at 11:30 AM Bobby Jones <rjones@gateworks.com> wrote:
>
> On Mon, Oct 21, 2019 at 1:19 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >
> > Hi Robert,
> >
> > same here, don't name it 'ARM: dt: ...' instead name it 'ARM: dts: imx:
> > ventana: ..' or 'ARM: dts: imx: imx6qdl-gw553x: ..'.
>
> Sorry about that, I'll follow that format from now on.
> >
> > On 19-10-18 16:21, Robert Jones wrote:
> > > Add one node for the accel/gyro i2c device and another for the separate
> > > magnetometer device in the lsm9ds1.
> > >
> > > Signed-off-by: Robert Jones <rjones@gateworks.com>
> > > ---
> > >  arch/arm/boot/dts/imx6qdl-gw553x.dtsi | 31 +++++++++++++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
> > > index a106689..55e6922 100644
> > > --- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
> > > +++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
> > > @@ -173,6 +173,25 @@
> > >       pinctrl-0 = <&pinctrl_i2c2>;
> > >       status = "okay";
> > >
> > > +     lsm9ds1_ag@6a {
> > > +             compatible = "st,lsm9ds1-imu";
> >
> > Didn't found this compatible string.
> So this is a compatible string for a driver that's being mainlined
> now. The devicetree bindings for which has already been reviewed-by
> Rob Herring as seen here:
> https://www.spinics.net/lists/linux-iio/msg47297.html. If possible I'd
> prefer to get this in the same kernel release so let me know if
> there's anything else I can do to make that happen.
>
I mixed up my replies here. That link points to the "nxp,fxos8700"
compatible string that you brought up in your other response. The
"st,lsm9ds1-imu" compatible string is described in
Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt which was an
August commit that made it into the imx/dt branch.
> >
> > > +             reg = <0x6a>;
> > > +             st,drdy-int-pin = <1>;
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&pinctrl_acc_gyro>;
> > > +             interrupt-parent = <&gpio7>;
> > > +             interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
> > > +     };
> > > +
> > > +     lsm9ds1_m@1c {
> > > +             compatible = "st,lsm9ds1-magn";
> > > +             reg = <0x1c>;
> >
> > Nodes are sorted according their i2c-addresses.
> >
> I'll resubmit with that change, thanks!
> - Bobby
>
> > Regards,
> >   Marco
> >
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&pinctrl_mag>;
> > > +             interrupt-parent = <&gpio1>;
> > > +             interrupts = <2 IRQ_TYPE_EDGE_RISING>;
> > > +     };
> > > +
> > >       ltc3676: pmic@3c {
> > >               compatible = "lltc,ltc3676";
> > >               reg = <0x3c>;
> > > @@ -462,6 +481,18 @@
> > >               >;
> > >       };
> > >
> > > +     pinctrl_acc_gyro: acc_gyrogrp {
> > > +             fsl,pins = <
> > > +                     MX6QDL_PAD_GPIO_18__GPIO7_IO13          0x1b0b0
> > > +             >;
> > > +     };
> > > +
> > > +     pinctrl_mag: maggrp {
> > > +             fsl,pins = <
> > > +                     MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x1b0b0
> > > +             >;
> > > +     };
> > > +
> > >       pinctrl_pps: ppsgrp {
> > >               fsl,pins = <
> > >                       MX6QDL_PAD_ENET_RXD1__GPIO1_IO26        0x1b0b1
> > > --
> > > 2.9.2
> > >
> > >
> > >
> >
> > --
> > Pengutronix e.K.                           |                             |
> > Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
