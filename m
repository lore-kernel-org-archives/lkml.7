Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC50CC3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F092086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565977586;
	bh=XQ+PV3RjXvZRzWzb8M+xJs54kNluh0/uCr182cW9Oww=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=WpwXk0UQqsFT0Z6ChGayM7TfUqkkAHac9PiIfK54xMedqjE/Yz6gNbX9ItdQP7RjZ
	 2gYTk6QKtJrDrzERfn0QAF1E7Bpolxajbkja6l8PRtkP4DARh/+TH/TSWmg4JiI3OJ
	 3UfmhPBZTK5tUtSzLfbBkU4vON59dJO41qHVnmVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfHPRq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbfHPRqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:46:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 115FC205F4;
        Fri, 16 Aug 2019 17:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565977584;
        bh=XQ+PV3RjXvZRzWzb8M+xJs54kNluh0/uCr182cW9Oww=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jWC7Dc1D5MlswkZAkhXFKRli6c2y5kauMYwhq2wkavIwOom8FNUm1ZBh03fmd2+AU
         2Ac1gHekyKItPbDX4/0FrkBcYUT5L5/MJFQOFCBTCfG3p6DQLF6Ob1VcJgi5inbC9j
         MWREQ38OFcQ+ggs7KRAqHrVw5QiGr3B6+TeBCOTE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815101613.22872-2-wen.he_1@nxp.com>
References: <20190815101613.22872-1-wen.he_1@nxp.com> <20190815101613.22872-2-wen.he_1@nxp.com>
Subject: Re: [v2 2/3] clk: ls1028a: Add clock driver for Display output interface
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     leoyang.li@nxp.com, liviu.dudau@arm.com, Wen He <wen.he_1@nxp.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Wen He <wen.he_1@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-devel@linux.nxdi.nxp.com, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:46:23 -0700
Message-Id: <20190816174624.115FC205F4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-08-15 03:16:12)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 801fa1cd0321..3c95d8ec31d4 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -223,6 +223,16 @@ config CLK_QORIQ
>           This adds the clock driver support for Freescale QorIQ platforms
>           using common clock framework.
> =20
> +config CLK_LS1028A_PLLDIG
> +        bool "Clock driver for LS1028A Display output"
> +       depends on (ARCH_LAYERSCAPE || COMPILE_TEST) && OF

Where is the OF dependency to build anything? Doesn't this still compile
without CONFIG_OF set?

> +       default ARCH_LAYERSCAPE
> +        help
> +          This driver support the Display output interfaces(LCD, DPHY) p=
ixel clocks
> +          of the QorIQ Layerscape LS1028A, as implemented TSMC CLN28HPM =
PLL. Not all
> +          features of the PLL are currently supported by the driver. By =
default,
> +          configured bypass mode with this PLL.

These lines look sort of long. Are they under 80 columns?

> +
>  config COMMON_CLK_XGENE
>         bool "Clock driver for APM XGene SoC"
>         default ARCH_XGENE
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 0cad76021297..c8e22a764c4d 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_COMMON_CLK_OXNAS)                +=3D clk-=
oxnas.o
>  obj-$(CONFIG_COMMON_CLK_PALMAS)                +=3D clk-palmas.o
>  obj-$(CONFIG_COMMON_CLK_PWM)           +=3D clk-pwm.o
>  obj-$(CONFIG_CLK_QORIQ)                        +=3D clk-qoriq.o
> +obj-$(CONFIG_CLK_LS1028A_PLLDIG)       +=3D clk-plldig.o
>  obj-$(CONFIG_COMMON_CLK_RK808)         +=3D clk-rk808.o
>  obj-$(CONFIG_COMMON_CLK_HI655X)                +=3D clk-hi655x.o
>  obj-$(CONFIG_COMMON_CLK_S2MPS11)       +=3D clk-s2mps11.o
> diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c
> new file mode 100644
> index 000000000000..60988b0ea20a
> --- /dev/null
> +++ b/drivers/clk/clk-plldig.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright 2019 NXP
> +
> +/*
> + * Clock driver for LS1028A Display output interfaces(LCD, DPHY).
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/of.h>
[...]
> +
> +static int plldig_clk_probe(struct platform_device *pdev)
> +{
> +       struct clk_plldig *data;
> +       struct resource *mem;
> +       const char *parent_name;
> +       struct clk_init_data init =3D {};
> +       struct device *dev =3D &pdev->dev;
> +       int ret;
> +
> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       data->regs =3D devm_ioremap_resource(dev, mem);
> +       if (IS_ERR(data->regs))
> +               return PTR_ERR(data->regs);
> +
> +       init.name =3D dev->of_node->name;
> +       init.ops =3D &plldig_clk_ops;
> +       parent_name =3D of_clk_get_parent_name(dev->of_node, 0);
> +       init.parent_names =3D &parent_name;

Can you use the new way of specifying clk parents with the parent_data
member of clk_init?

> +       init.num_parents =3D 1;
> +
> +       data->hw.init =3D &init;
> +       data->dev =3D dev;
> +
> +       ret =3D devm_clk_hw_register(dev, &data->hw);
> +       if (ret) {
> +               dev_err(dev, "failed to register %s clock\n", init.name);
> +               return ret;
> +       }
> +
> +       return of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get,

Use devm? So that driver remove frees this.

> +                       &data->hw);
> +}
> +
> +static int plldig_clk_remove(struct platform_device *pdev)
> +{
> +       of_clk_del_provider(pdev->dev.of_node);
> +       return 0;
> +}
> +
> +static const struct of_device_id plldig_clk_id[] =3D {
> +       { .compatible =3D "fsl,ls1028a-plldig", .data =3D NULL},
> +       { }
> +};

Add a MODULE_DEVICE_TABLE(of, plldig_clk_id) here.

> +
> +static struct platform_driver plldig_clk_driver =3D {
> +       .driver =3D {
> +               .name =3D "plldig-clock",
> +               .of_match_table =3D plldig_clk_id,
> +       },
> +       .probe =3D plldig_clk_probe,
> +       .remove =3D plldig_clk_remove,
> +};
> +module_platform_driver(plldig_clk_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Wen He <wen.he_1@nxp.com>");
> +MODULE_DESCRIPTION("LS1028A Display output interface pixel clock driver"=
);
> +MODULE_ALIAS("platform:ls1028a-plldig");

Drop MODULE_ALIAS, it's not useful.

