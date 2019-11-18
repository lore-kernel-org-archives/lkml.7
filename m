Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4311FC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1124D2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KZ/4KNMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKRMDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:03:39 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40185 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfKRMDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:03:39 -0500
Received: by mail-io1-f67.google.com with SMTP id p6so18423174iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 04:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mRS08DORIjerAzyI9KXWLJu2WpkCsOfpHMjNq/h7yb0=;
        b=KZ/4KNMjHoqrOJoYORlKqshRhtUEhUDtoW0GcVTwYNGXOYrD8OZsAmwMJnvle0dPpd
         5MOGRDtogu1TV/CTHG/Vtw1jc3PGk7nUeAWJMNn03e3kFpwC74S+VHCuOW85bOKa8zV8
         yhWvQjoi0ib8sRJgbZxnjcoEyyhH8LydmLp2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mRS08DORIjerAzyI9KXWLJu2WpkCsOfpHMjNq/h7yb0=;
        b=ZirmpAWFBFsmP/t0Hdv9meEUFgj6bpvoX8V7KJBHRtW3MiZZpA/3KR3WwSwLNLnfbl
         Basax9YbUYfufC9l5WQifclrfZty88SWrLufuUozlmSHT7GKvUBqHDG6Z5wlcuhrR2G8
         XU5/OPytCfSE3uqX4xCODWMKfyZTvUaDe6Lq3b/HOBOBAKJk48eoCTn//gq0YnLruqPO
         INKGcb8/3FPuCJpVQ73pewTvVxNUNelIl1WrwHTloG8lZQz19Z64Ja8TlmxBFSQKHjhD
         4Gd1rdOpkK0q8AFAHLnG+VhxyEnO8p1xRXLIiyM1Y9hEQJuIwh33OvSVIqOtxQ0EX5yK
         qkLw==
X-Gm-Message-State: APjAAAUyd30zeyALp/YsEUh9PZc44H5qjABq0E/4usRxfwazPW/rZOAn
        8Z+S+VUAkXIXCLh4dv+jjHudpzsF7vvMfc5gU8VuiA==
X-Google-Smtp-Source: APXvYqwH64WRV7lIHLiErNMdjQtH/35SCJ2iv0n5EnLC/pLDtMs+QtJuJ5rGqsy36+7r4px+8YXcEd4mFXmCZwqanh8=
X-Received: by 2002:a6b:ba87:: with SMTP id k129mr9134547iof.173.1574078616817;
 Mon, 18 Nov 2019 04:03:36 -0800 (PST)
MIME-Version: 1.0
References: <075b3fa6-dab7-5fec-df68-b53f32bf061b@fivetechno.de>
 <2226540.xovL9aYQn6@diego> <CAMty3ZDwjv4ShpbAyQPWk9ewboFOK3nZO0s_QNty_m0hJKR76w@mail.gmail.com>
 <62bfaad5-cbd6-efbd-426b-3da681fcd160@fivetechno.de>
In-Reply-To: <62bfaad5-cbd6-efbd-426b-3da681fcd160@fivetechno.de>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 18 Nov 2019 17:33:25 +0530
Message-ID: <CAMty3ZBuPRA3d=oMyCgYpA-i_FPOVJd3FeSnNBYE49o-h=Vq7w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Split rk3399-roc-pc for with and
 without mezzanine board.
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On Mon, Nov 18, 2019 at 5:27 PM Markus Reichl <m.reichl@fivetechno.de> wrot=
e:
>
> Hi Jagan,
>
> Am 18.11.19 um 12:44 schrieb Jagan Teki:
> > On Mon, Nov 4, 2019 at 5:42 PM Heiko St=C3=BCbner <heiko@sntech.de> wro=
te:
> >>
> >> Hi Markus,
> >>
> >> Am Freitag, 1. November 2019, 17:54:23 CET schrieb Markus Reichl:
> >> > For rk3399-roc-pc is a mezzanine board available that carries M.2 an=
d
> >> > POE interfaces. Use it with a separate dts.
> >> >
> >> > Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> >> > ---
> >> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >> >  .../boot/dts/rockchip/rk3399-roc-pc-mezz.dts  |  52 ++
> >> >  .../arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 757 +--------------=
--
> >> >  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 767 +++++++++++++++=
+++
> >> >  4 files changed, 821 insertions(+), 756 deletions(-)
> >> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezz.=
dts
> >> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> >> >
> >> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot=
/dts/rockchip/Makefile
> >> > index a959434ad46e..80ee9f1fc5f5 100644
> >> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> >> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> >> > @@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-nanopi-neo=
4.dtb
> >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-orangepi.dtb
> >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-puma-haikou.dtb
> >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-roc-pc.dtb
> >> > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-roc-pc-mezz.dtb
> >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-rock-pi-4.dtb
> >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-rock960.dtb
> >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-rockpro64.dtb
> >> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezz.dts b/a=
rch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezz.dts
> >> > new file mode 100644
> >> > index 000000000000..ee77677d2cf2
> >> > --- /dev/null
> >> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezz.dts
> >> > @@ -0,0 +1,52 @@
> >> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> > +/*
> >> > + * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
> >> > + * Copyright (c) 2019 Markus Reichl <m.reichl@fivetechno.de>
> >> > + */
> >> > +
> >> > +/dts-v1/;
> >> > +#include "rk3399-roc-pc.dtsi"
> >> > +
> >> > +/ {
> >> > +     model =3D "Firefly ROC-RK3399-PC Mezzanine Board";
> >> > +     compatible =3D "firefly,roc-rk3399-pc", "rockchip,rk3399";
> >>
> >> different board with same compatible isn't possible, so
> >> you'll need a new compatible for it and add a new line to
> >> the roc-pc entry in
> >>         Documentation/devicetree/bindings/arm/rockchip.yaml
> >>
> >> Either you see it as
> >> - a board + hat, using dt overlay and same compatible
> >> - a completely separate board, which needs a separate
> >>   compatible as well
> >>
> >> And as discussed in the previous thread
> >> http://lists.infradead.org/pipermail/linux-rockchip/2019-November/0275=
92.html
> >> but also in Jagan's response that really is somehow a grey area
> >> for something relatively static as the M.2 extension.
> >
> > Sorry for late response on this. I still think that the "overlay would
> > be a better suite" than having separate dts, since it is HAT which is
> > optional to insert and have possibility of having another HAT if it
> > really fit into it.
> >
> > Comments?
> Presently no other extension board does exist, I don't expect one.
>
> I use it with rootfs on NVME on the mezzanine board.
> It is convenient to have the NVME up before going to user space.
>
> The board has SPI-NOR MTD storage to host U-Boot.
> In future U-Boot could boot from NVME directly without needing
> an SD or MMC to host the boot kernel.

This is purely a use-case scenario, I can still use SPI-NOR alone with
final boot via initramfs and use on board storage peripherals for
distributions separately. What I'm saying we can have overlay for
those are optional based on the user instead of making it for
constant.
