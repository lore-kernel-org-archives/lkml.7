Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7DBC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1FB2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gZ7SVayZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKRMGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:06:38 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:32868 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfKRMGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:06:38 -0500
Received: by mail-io1-f66.google.com with SMTP id j13so18485322ioe.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 04:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8TLisz4aQCnpH1nQJckHE/4DqGlnITwdG2aeA9BzSJs=;
        b=gZ7SVayZrKBCeOGp38XT5sNAwqCBviXOxTOd4JvGIo36QGAl4SONzk+keg76DEGQFt
         rbGlW82SbUAq1Mp4/Q6GjBUEymoRL81VYGYZsBSIWgtZozyZkiTTsZRVGG5bBPfkZjYS
         MrCrtrDvPjIAgo4JLd4xgbBiXx5dcTN2hgJpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8TLisz4aQCnpH1nQJckHE/4DqGlnITwdG2aeA9BzSJs=;
        b=K0bmHpUw3oHENOdMXuQOq/RMtSNDOMEzgm1taNl0XfiPU6LcsSo+xEZpc6/XBBYo2O
         4WuquQFEYp8kx0Z9AXXGboXrSVAsjYQsqdCCF+x7PrP/hMoGNQ2XQsUwWxjzks3RB70l
         mQUnP2b4s3eBuK+8KY5RSPfHSrJHTDA40J/hhpFudzweKKP6hu+ezIX0aLktoZ/E/xRg
         2/wlKYeMCXOwb8hrIavCaq6igntchjHXC9FEuVzxRsINz6ZnxlNI0ezi75F9jFNLU0Gc
         RRgUGMX/7bHIhz1PzmZo/p+Kvkn9waa+xp+tjaAh5sAua79M88zJF5++VHocaNS2ad5o
         RGAA==
X-Gm-Message-State: APjAAAUYIq1RiPpbqbjwadIkQ/XkJco12WpliSBTa/7sTamvJIykNizI
        mGd8MUVUrSY9nzcRqkM6yOMBFZEDN4DJb7DCcaM42w==
X-Google-Smtp-Source: APXvYqys4JE1pYdi2/ZW/BnxTIzLZlCdlEMM0lASAVLbjlfYoUW0ZPNQFziLMGhFaxY6+CfD1ejsl+lTHAIrxXQaklk=
X-Received: by 2002:a6b:7111:: with SMTP id q17mr13055339iog.28.1574078797070;
 Mon, 18 Nov 2019 04:06:37 -0800 (PST)
MIME-Version: 1.0
References: <075b3fa6-dab7-5fec-df68-b53f32bf061b@fivetechno.de>
 <CAMty3ZDwjv4ShpbAyQPWk9ewboFOK3nZO0s_QNty_m0hJKR76w@mail.gmail.com>
 <62bfaad5-cbd6-efbd-426b-3da681fcd160@fivetechno.de> <17111474.kvkBZtc6MS@diego>
In-Reply-To: <17111474.kvkBZtc6MS@diego>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 18 Nov 2019 17:36:26 +0530
Message-ID: <CAMty3ZAaOd2GVGqqw0pASbcaScH7QPWXN5rxkqUshdRAq6Oz5Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Split rk3399-roc-pc for with and
 without mezzanine board.
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
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

On Mon, Nov 18, 2019 at 5:31 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Montag, 18. November 2019, 12:57:16 CET schrieb Markus Reichl:
> > Hi Jagan,
> >
> > Am 18.11.19 um 12:44 schrieb Jagan Teki:
> > > On Mon, Nov 4, 2019 at 5:42 PM Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> > >>
> > >> Hi Markus,
> > >>
> > >> Am Freitag, 1. November 2019, 17:54:23 CET schrieb Markus Reichl:
> > >> > For rk3399-roc-pc is a mezzanine board available that carries M.2 =
and
> > >> > POE interfaces. Use it with a separate dts.
> > >> >
> > >> > Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> > >> > ---
> > >> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> > >> >  .../boot/dts/rockchip/rk3399-roc-pc-mezz.dts  |  52 ++
> > >> >  .../arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 757 +------------=
----
> > >> >  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 767 +++++++++++++=
+++++
> > >> >  4 files changed, 821 insertions(+), 756 deletions(-)
> > >> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mez=
z.dts
> > >> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts=
i
> > >> >
> > >> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/bo=
ot/dts/rockchip/Makefile
> > >> > index a959434ad46e..80ee9f1fc5f5 100644
> > >> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > >> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > >> > @@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-nanopi-n=
eo4.dtb
> > >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-orangepi.dtb
> > >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-puma-haikou.dtb
> > >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-roc-pc.dtb
> > >> > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-roc-pc-mezz.dtb
> > >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-rock-pi-4.dtb
> > >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-rock960.dtb
> > >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-rockpro64.dtb
> > >> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezz.dts b=
/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezz.dts
> > >> > new file mode 100644
> > >> > index 000000000000..ee77677d2cf2
> > >> > --- /dev/null
> > >> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezz.dts
> > >> > @@ -0,0 +1,52 @@
> > >> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > >> > +/*
> > >> > + * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
> > >> > + * Copyright (c) 2019 Markus Reichl <m.reichl@fivetechno.de>
> > >> > + */
> > >> > +
> > >> > +/dts-v1/;
> > >> > +#include "rk3399-roc-pc.dtsi"
> > >> > +
> > >> > +/ {
> > >> > +     model =3D "Firefly ROC-RK3399-PC Mezzanine Board";
> > >> > +     compatible =3D "firefly,roc-rk3399-pc", "rockchip,rk3399";
> > >>
> > >> different board with same compatible isn't possible, so
> > >> you'll need a new compatible for it and add a new line to
> > >> the roc-pc entry in
> > >>         Documentation/devicetree/bindings/arm/rockchip.yaml
> > >>
> > >> Either you see it as
> > >> - a board + hat, using dt overlay and same compatible
> > >> - a completely separate board, which needs a separate
> > >>   compatible as well
> > >>
> > >> And as discussed in the previous thread
> > >> http://lists.infradead.org/pipermail/linux-rockchip/2019-November/02=
7592.html
> > >> but also in Jagan's response that really is somehow a grey area
> > >> for something relatively static as the M.2 extension.
> > >
> > > Sorry for late response on this. I still think that the "overlay woul=
d
> > > be a better suite" than having separate dts, since it is HAT which is
> > > optional to insert and have possibility of having another HAT if it
> > > really fit into it.
> > >
> > > Comments?
> > Presently no other extension board does exist, I don't expect one.
> >
> > I use it with rootfs on NVME on the mezzanine board.
> > It is convenient to have the NVME up before going to user space.
>
> And that is exactly the reason while I think it's sane to have this
> as a separate board. For more common hats with random
> extended functionality this might be different.
>
> But people attaching the nvme-"hat" will in most all cases do so quite
> permanently as well ;-) .

I did understand this completely and I do agree this point and use-case.

But what if we have overlay, and give tendency to use it at bootloader
level for nvme-"hat" so it can satisfy both common and random HAT
functionalities.
