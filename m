Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCBEC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3612081C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge+rpflX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfD3QY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:24:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35522 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfD3QY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:24:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id z26so13407925ljj.2;
        Tue, 30 Apr 2019 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T12C8ZsnEAO+1u2qvY8HiXn5RKB3DNqdmhVjJCv7uAY=;
        b=ge+rpflX4QyQP0WB5MTXlg5cJM2dsK0O0QRkDpbuArj0l/NK8RzRLLgnql9QK9cMFG
         R3FYrL+jcmmmFD8onpCKhF8auOODos0kymTfQfUlw52MDOITu8TmlIjmLXUdan7C6LRb
         9zXt8UfM6xtzw1x9F+/TcLcFWtgQ5tVV7ydHk3gtUy7Zxpb4Hx3Y9M6U03+xI0RPLN79
         Cx7/oSoGzqFlFW5hmeFVYbPoxawNLIrT0jYvDD95jXRUx/lrnIYwux1IuVGV4rgTKs9u
         /euWKUI+miwQPjZtG81U8riXUMKgRhICUo4XK9tSHbXzlCLh2jsbxwzA558DmMn+NdcV
         dLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T12C8ZsnEAO+1u2qvY8HiXn5RKB3DNqdmhVjJCv7uAY=;
        b=CC1Y1rRetub2ggXx/pWeNjKr/EoMqkZGlkf6ZUDH0wmvxuQo35i1qiKp2LkekMp26z
         cjjmcGC3B5L7liVDPpUO0vATJomZoqgAkcUWPYilvs7JxaGNLEx4kKs9NjLZKWEkJ3U2
         JiGKJT4FF/pupWoxj33TudWjp8kEDPxmvFloe/4i1wPYcydXXE8G4vuNlOOF58WMbJgo
         XZbBMDYS3jWlYGFQ/OCRJj1C2SXzPr2zvTvUiieZFprRkzYTKtMb6BiPvLtnw5BoOm5X
         b6+8y5iT1HqDKwLREweiXg8VG+Jl3CvbaR3889J4kj2aBCGfr3VvmjGHvaNDarlpCwLH
         uTwQ==
X-Gm-Message-State: APjAAAVqBtbwBXOZkeU2SsEbf9udw9nAHJML+a8adINevSw8JtNkBjNF
        4kRi5RtBAGA5qI5WDbJr2SlNBp1iIK1Xz4qkDws=
X-Google-Smtp-Source: APXvYqzVoXGyn1uVc/WjKZkLjOBzqPleu6K+XY10NxzaKn++y6S+xC0yhjmHgAh9N3hq+diziQD7M2FQz9qMJlrz1Ys=
X-Received: by 2002:a2e:7318:: with SMTP id o24mr1644011ljc.138.1556641493748;
 Tue, 30 Apr 2019 09:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556633413.git.agx@sigxcpu.org> <b999b07673e59c676d2e43a786b635beb056e9bf.1556633413.git.agx@sigxcpu.org>
In-Reply-To: <b999b07673e59c676d2e43a786b635beb056e9bf.1556633413.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Apr 2019 13:24:45 -0300
Message-ID: <CAOMZO5BerzB94YvJgZoOVYaA3fCsHQiuC5FyVVVRV+ttEg92uQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] phy: Add driver for mixel mipi dphy found on NXP's
 i.MX8 SoCs
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Tue, Apr 30, 2019 at 11:40 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote=
:
>
> This adds support for the Mixel DPHY as found on i.MX8 CPUs but since
> this is an IP core it will likely be found on others in the future. So
> instead of adding this to the nwl host driver make it a generic PHY
> driver.
>
> The driver supports the i.MX8MQ. Support for i.MX8QM and i.MX8QXP can be
> added once the necessary system controller bits are in via
> mixel_dphy_devdata.
>
> Co-authored-by: Robert Chiras <robert.chiras@nxp.com>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

I wish I could test it on a imx8m-evk , but there are some other
pieces needed such as Northwest Logic driver, mxsfb changes for
supporting mx8m, OLED panel driver, etc

Anyway, it looks good to me and I have only a few minor comments:

> ---
>  drivers/phy/freescale/Kconfig                 |  11 +
>  drivers/phy/freescale/Makefile                |   1 +
>  .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    | 506 ++++++++++++++++++
>  3 files changed, 518 insertions(+)
>  create mode 100644 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
>
> diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfi=
g
> index 832670b4952b..a111b130f9d2 100644
> --- a/drivers/phy/freescale/Kconfig
> +++ b/drivers/phy/freescale/Kconfig
> @@ -3,3 +3,14 @@ config PHY_FSL_IMX8MQ_USB
>         depends on OF && HAS_IOMEM
>         select GENERIC_PHY
>         default ARCH_MXC && ARM64
> +
> +config PHY_MIXEL_MIPI_DPHY
> +       tristate "Mixel MIPI DSI PHY support"
> +       depends on OF && HAS_IOMEM
> +       select GENERIC_PHY
> +       select GENERIC_PHY_MIPI_DPHY
> +       select REGMAP_MMIO
> +       default ARCH_MXC && ARM64

I don't think that this default is a good idea.

There are imx8m systems that do not have display, so in this case it
does not make sense to always force the build of this driver.

> +       help
> +         Enable this to add support for the Mixel DSI PHY as found
> +         on NXP's i.MX8 family of SOCs.
> diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makef=
ile
> index dc2b3f1f2f80..07491c926a2c 100644
> --- a/drivers/phy/freescale/Makefile
> +++ b/drivers/phy/freescale/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)       +=3D phy-fsl-imx8mq-usb.o
> +obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)      +=3D phy-fsl-imx8-mipi-dphy.o
> diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy=
/freescale/phy-fsl-imx8-mipi-dphy.c
> new file mode 100644
> index 000000000000..d6b5af0b3380
> --- /dev/null
> +++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> @@ -0,0 +1,506 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2017,2018 NXP
> + * Copyright 2019 Purism SPC
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/phy/phy.h>

Please keep the headers sorted.

> +#include <linux/platform_device.h>


> +static int mixel_dphy_validate(struct phy *phy, enum phy_mode mode, int =
submode,
> +                              union phy_configure_opts *opts)
> +{
> +       struct mixel_dphy_cfg cfg =3D { 0 };
> +
> +       if (mode !=3D PHY_MODE_MIPI_DPHY)
> +               return -EINVAL;
> +
> +       return mixel_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
> +}
> +
> +

A single blank line is enough.

> +static int mixel_dphy_init(struct phy *phy)
> +{
> +       phy_write(phy, PWR_OFF, DPHY_PD_PLL);
> +       phy_write(phy, PWR_OFF, DPHY_PD_DPHY);
> +
> +       return 0;
> +}
> +
> +

Ditto.

> +static int mixel_dphy_exit(struct phy *phy)
> +{
> +       phy_write(phy, 0, DPHY_CM);
> +       phy_write(phy, 0, DPHY_CN);
> +       phy_write(phy, 0, DPHY_CO);
> +
> +       return 0;
> +}
> +
> +

Ditto.

> +static int mixel_dphy_power_off(struct phy *phy)
> +{
> +       struct mixel_dphy_priv *priv =3D phy_get_drvdata(phy);
> +
> +       phy_write(phy, PWR_OFF, DPHY_PD_PLL);
> +       phy_write(phy, PWR_OFF, DPHY_PD_DPHY);
> +
> +       clk_disable_unprepare(priv->phy_ref_clk);
> +
> +       return 0;
> +}
> +
> +

Ditto.

> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       regs =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(regs)) {
> +               dev_err(dev, "Couldn't map the DPHY registers\n");

You can skip this error message, because the core already complains on
ioremap failures.
