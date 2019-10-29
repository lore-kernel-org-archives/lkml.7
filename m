Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DBCCA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FB52087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572381632;
	bh=+ErzTvkm89mf/Yo1sKBo6GnZ+47nBen0ZswGPxY1Rsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OIsIKwfbbY09//FdIvPR9nzIIlpzrK9GMA8kYZZ8RXgGmyd5TppGZC6a7qSClJ4L/
	 t7QyGl4FMkJNRg/psIX8Mcu+Gyy7guOKopTfozAqeVywqvb9Yd8VsAkLuxRC8Rqssy
	 xLerqq6j95oOUQrFHCRrIEV6KSY9UwnSNALq6Y9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfJ2Ukb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2Ukb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:40:31 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC20A208E3;
        Tue, 29 Oct 2019 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572381630;
        bh=+ErzTvkm89mf/Yo1sKBo6GnZ+47nBen0ZswGPxY1Rsc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uy+Xf+IqaUTwAbgRHSBRNXrCnp68ZxhUaVEeBdva8YPx8Notmy/Z0/NvpKnRgRifT
         k4YifzN9W3JY4PQADxbYxAMkAlbFs7bofoZo1O0LcwlsLzcg3pvVIrzBg2rez+ikG6
         cH3v0tyvYZ4nSCc+/EhZUE8AZJJqOJYntBdf0T9I=
Received: by mail-qt1-f181.google.com with SMTP id e14so97456qto.1;
        Tue, 29 Oct 2019 13:40:29 -0700 (PDT)
X-Gm-Message-State: APjAAAUOnYSoux58r8PV6NMfqGhAZ5Ga9gmSIObmgJWuqeC+eYcdHSfF
        drBBj7hwujE5et5ThuYV5yeRCxYPxkL/cExy1w==
X-Google-Smtp-Source: APXvYqzKsg6BCPZBJRd4aHnInc5va9mSx60VPljcfauLF6SwALX1RSm+GHMmxEHZY2HZFAeZj60MjIXsq/m86CpLA3w=
X-Received: by 2002:ac8:741a:: with SMTP id p26mr1190108qtq.143.1572381628943;
 Tue, 29 Oct 2019 13:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191021021035.7032-1-afaerber@suse.de> <20191021021035.7032-4-afaerber@suse.de>
 <20191029154129.GA24908@bogus> <6e6087af-6a62-f0ff-07af-48e4836c38e6@suse.de>
In-Reply-To: <6e6087af-6a62-f0ff-07af-48e4836c38e6@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Oct 2019 15:40:17 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+QgAyR7vUJRBRrO56uKJXi4=meW2qnPpZUCAqBBP7PMA@mail.gmail.com>
Message-ID: <CAL_Jsq+QgAyR7vUJRBRrO56uKJXi4=meW2qnPpZUCAqBBP7PMA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: Prepare Realtek RTD1195 and MeLE X1000
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 10:52 AM Andreas F=C3=A4rber <afaerber@suse.de> wro=
te:
>
> Am 29.10.19 um 16:41 schrieb Rob Herring:
> > On Mon, Oct 21, 2019 at 04:10:35AM +0200, Andreas F=C3=A4rber wrote:
> >> Add Device Trees for Realtek RTD1195 SoC and MeLE X1000 TV box.
> >>
> >> Reuse the existing RTD1295 watchdog compatible for now.
> >>
> >> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> >> ---
> >>  arch/arm/boot/dts/Makefile               |   2 +
> >>  arch/arm/boot/dts/rtd1195-mele-x1000.dts |  30 ++++++++
> >>  arch/arm/boot/dts/rtd1195.dtsi           | 128 ++++++++++++++++++++++=
+++++++++
> >>  3 files changed, 160 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/rtd1195-mele-x1000.dts
> >>  create mode 100644 arch/arm/boot/dts/rtd1195.dtsi
> >>
> >> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >> index 73d33611c372..89a951485da8 100644
> >> --- a/arch/arm/boot/dts/Makefile
> >> +++ b/arch/arm/boot/dts/Makefile
> >> @@ -858,6 +858,8 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D \
> >>  dtb-$(CONFIG_ARCH_RDA) +=3D \
> >>      rda8810pl-orangepi-2g-iot.dtb \
> >>      rda8810pl-orangepi-i96.dtb
> >> +dtb-$(CONFIG_ARCH_REALTEK) +=3D \
> >> +    rtd1195-mele-x1000.dtb
> >>  dtb-$(CONFIG_ARCH_REALVIEW) +=3D \
> >>      arm-realview-pb1176.dtb \
> >>      arm-realview-pb11mp.dtb \
> >> diff --git a/arch/arm/boot/dts/rtd1195-mele-x1000.dts b/arch/arm/boot/=
dts/rtd1195-mele-x1000.dts
> >> new file mode 100644
> >> index 000000000000..ce9a255950d3
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/rtd1195-mele-x1000.dts
> >> @@ -0,0 +1,30 @@
> >> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> >> +/*
> >> + * Copyright (c) 2017 Andreas F=C3=A4rber
> >
> > 2019?
>
> Nope, I am flushing out old queues, and updating SPDX line does not
> really warrant a copyright bump IMO. The changes below would though.
>
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "rtd1195.dtsi"
> >> +
> >> +/ {
> >> +    compatible =3D "mele,x1000", "realtek,rtd1195";
> >> +    model =3D "MeLE X1000";
> >> +
> >> +    aliases {
> >> +            serial0 =3D &uart0;
> >> +    };
> >> +
> >> +    chosen {
> >> +            stdout-path =3D "serial0:115200n8";
> >> +    };
> >> +
> >> +    memory {
> >
> > memory@0
>
> Will test.
>
> >
> >> +            device_type =3D "memory";
> >> +            reg =3D <0x0 0x40000000>;
> >> +    };
> >> +};
> >> +
> >> +&uart0 {
> >> +    status =3D "okay";
> >> +};
> >> diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd119=
5.dtsi
> >> new file mode 100644
> >> index 000000000000..475740c67d26
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/rtd1195.dtsi
> >> @@ -0,0 +1,128 @@
> >> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> >> +/*
> >> + * Copyright (c) 2017 Andreas F=C3=A4rber
> >> + */
> >> +
> >> +/memreserve/ 0x00000000 0x0000c000; /* boot code */
> >> +/memreserve/ 0x0000c000 0x000f4000;
> >> +/memreserve/ 0x01b00000 0x00400000; /* audio */
> >> +/memreserve/ 0x01ffe000 0x00004000; /* rpc ringbuf */
> >> +/memreserve/ 0x10000000 0x00100000; /* secure */
> >> +/memreserve/ 0x17fff000 0x00001000;
> >> +/memreserve/ 0x18000000 0x00100000; /* rbus */
> >> +/memreserve/ 0x18100000 0x01000000; /* nor */
> >
> > You shouldn't have the same entries here and in /reserved-memory. There
> > was a time before /reserved-memory was fully supported, but we should b=
e
> > well past that now.
>
> I am dealing with a v2012.07 based downstream U-Boot that I do not have
> sources for, so I wouldn't be so sure there... It will only respect
> memreserve I think, whereas reserved-memory below is for the kernel, no?

Sigh... Well, that may be too old. :(

I could be wrong too and no one ever added /reserved-memory support
for u-boot. The intent was never that one was for u-boot and the other
for the kernel. The kernel handles both. reserved-memory was to
overcome the limitations of memreserve.

> >> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +
> >> +/ {
> >> +    compatible =3D "realtek,rtd1195";
> >> +    interrupt-parent =3D <&gic>;
> >> +    #address-cells =3D <1>;
> >> +    #size-cells =3D <1>;
> >> +
> >> +    cpus {
> >> +            #address-cells =3D <1>;
> >> +            #size-cells =3D <0>;
> >> +
> >> +            cpu0: cpu@0 {
> >> +                    device_type =3D "cpu";
> >> +                    compatible =3D "arm,cortex-a7";
> >> +                    reg =3D <0x0>;
> >> +                    clock-frequency =3D <1000000000>;
> >> +            };
> >> +
> >> +            cpu1: cpu@1 {
> >> +                    device_type =3D "cpu";
> >> +                    compatible =3D "arm,cortex-a7";
> >> +                    reg =3D <0x1>;
> >> +                    clock-frequency =3D <1000000000>;
> >> +            };
> >> +    };
> >> +
> >> +    reserved-memory {
> >> +            #address-cells =3D <1>;
> >> +            #size-cells =3D <1>;
> >> +            ranges;
> >> +
> >> +            secure@10000000 {
> >> +                    reg =3D <0x10000000 0x100000>;
> >> +                    no-map;
> >> +            };
> >> +
> >> +            rbus@18000000 {
> >> +                    reg =3D <0x18000000 0x100000>;
> >> +                    no-map;
> >
> > This doesn't look right as it overlaps the register space.
>
> Will try dropping it. James?
>
> >> +            };
> >> +
> >> +            nor@18100000 {
> >> +                    reg =3D <0x18100000 0x1000000>;
> >> +                    no-map;
> >> +            };
>
> Same issue here, I guess?

Yes.

Rob
