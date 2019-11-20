Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D583EC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD5920692
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DA3GASR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbfKTPvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:51:22 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:42222 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfKTPvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:51:22 -0500
Received: by mail-il1-f194.google.com with SMTP id n18so51618ilt.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 07:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V9ocHos4mEPx/cXUTF0dJh2q+Dfua495g56A4DiYMvM=;
        b=DA3GASR2Yz29peYkU/JxCycyhe0pntz2I8oB4TnZKHaznQQ/3dZagFl7mz/6uQHJW5
         GrRIPKUtWuu9jAaJ2X5b0MVGuDe5OcswfXx1wbPb8m7uCfMIJmc9IPC5IS0lBPUTGROo
         mDAdsl7e6tN7R+gpDhb9im2LWKYDM4jMwbQzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V9ocHos4mEPx/cXUTF0dJh2q+Dfua495g56A4DiYMvM=;
        b=mOE6sGmYgM1dyPvAVW+lYAdyjjirBA3+DME//2s8yL8v69bU0VvfBl54hLYrg4a5J/
         Iv9Gv4hhH8VAubq8gbE7g+tZccp/uI+Wx5EUHMvjxOpr2BoikVtZJWNtQ+YKzJCS7lqD
         GM+kTnIR1PEEDi9pkvY/+XTFZhrmsZhhaqcrw8tR8SPFQR6jbuEvZABVfYcIeNMT5S81
         /rk/fd9gQWPu5wfsLYkHdMYiaDfeZvBDVE6ug4cqHPsrVZym6Tf6tSS6GtcQ0T/IbTh/
         5OrnG4NBs/x9ALRT1aNEtLOs7SWTmaOo3sl3HiatzH1LQKRJzs7s39bMxURDDr4qkBvo
         RIYg==
X-Gm-Message-State: APjAAAX+8RXF8+sMYjdm4ApWm2+qvLZxXajOKHsKEE3CTtBt0tKFCME/
        wbRmZbQQjv+c7qoTrYgWdfwjMaGyUDaPnWIZc47+rg==
X-Google-Smtp-Source: APXvYqxEiRL48js6ZDjxRjcSKNXQCeEpejajn5en3dkyccGBO7qEMLPuZspPilOntqUDYF2mK0Y10om7k0o+Lm+FniU=
X-Received: by 2002:a92:5d8f:: with SMTP id e15mr4268209ilg.173.1574265079598;
 Wed, 20 Nov 2019 07:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20191120113923.11685-1-jagan@amarulasolutions.com>
 <20191120113923.11685-3-jagan@amarulasolutions.com> <1707486.7nrk6WTBgP@diego>
In-Reply-To: <1707486.7nrk6WTBgP@diego>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 20 Nov 2019 21:21:08 +0530
Message-ID: <CAMty3ZC2NzTWq8YPbePRyPdixxMO7mrPZrzagwjrTkhGHGRR=g@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: rockchip: Add VMARC RK3399Pro SOM initial support
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Wed, Nov 20, 2019 at 6:59 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Jagan,
>
> looks good in general, just some small things below:
>
> Am Mittwoch, 20. November 2019, 12:39:20 CET schrieb Jagan Teki:
> > VMARC RK3399Pro SOM is a standard SMARC SOM design with
> > Rockchip RK3399Pro SoC, which is designed by Vamrs.
> >
> > Specification:
> > - Rockchip RK3399Pro
> > - PMIC: RK809-3
> > - SD slot, 16GiB eMMC
> > - 2xUSB-2.0, 1xUSB3.0
> > - USB-C for power supply
> > - Ethernet, PCIe
> > - HDMI, MIPI-DSI/CSI, eDP
> >
> > Add initial support for VMARC RK3399Pro SOM, this would use
> > with associated carrier board.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 339 ++++++++++++++++++
> >  1 file changed, 339 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dt=
si
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/ar=
ch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> > new file mode 100644
> > index 000000000000..ddf6ebc9fbe3
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> > @@ -0,0 +1,339 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
> > + * Copyright (c) 2019 Vamrs Limited
> > + * Copyright (c) 2019 Amarula Solutions(India)
> > + */
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include <dt-bindings/pwm/pwm.h>
> > +
> > +/ {
> > +     compatible =3D "vamrs,rk3399pro-vmarc-som", "rockchip,rk3399pro";
> > +
> > +     clkin_gmac: external-gmac-clock {
> > +             compatible =3D "fixed-clock";
> > +             clock-frequency =3D <125000000>;
> > +             clock-output-names =3D "clkin_gmac";
> > +             #clock-cells =3D <0>;
> > +     };
> > +
> > +     vcc5v0_sys: vcc5v0-sys-regulator {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vcc5v0_sys";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
>
> Is vcc5v0_sys really the topmost regulator getting the outside
> power-supply?

Thanks for pointing this, I forgot to check the vin supply in carrier
board schematics, yes it is VCC12V_DCIN (with 5V to 24V range) like
rock-pi-4. Will update the same.

>
>
> > +     };
> > +
> > +     vcc_lan: vcc3v3-phy-regulator {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vcc_lan";
>
> vcc_lan / vcc_phy is mostly coming from the vendor bsp in some way
> and will be named differently in schematics ... also it should be connect=
ed
> to the regulator tree.

Infact bsp named this as vcc_phy, I got the vcc_lan from schematics[1]
page 16. Yes it is using VCCIO_3V3_S0 (SWOUT2 from regulator tree), I
will mark this regulator.

>
> [...]
>
> > +&tsadc {
> > +     status =3D "okay";
> > +
> > +     /* tshut mode 0:CRU 1:GPIO */
>
> I think we can live without the additional comments for properties :-)

True, I have reused it from rock-pi-4 thought that it would compatible
with old. will remove.

[1] https://dl.radxa.com/rockpin10/docs/hw/VMARC_RK3399Pro_sch_V1.1_2019061=
9.pdf

Jagan.
