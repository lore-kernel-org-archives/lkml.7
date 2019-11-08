Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42615FC6198
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A5620865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573251415;
	bh=UMLMfzeZ5d6ns0l8n8EZL9EegR7c0Zs1zYDFdZD51UQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=W2OW8EWj+AhYFZFtXTjgrYAuVl8IhXp1GFJmlquSH2JrJukKWhylAgf36qrvCd3po
	 +Txo1nC+EpcxQG9hWe6hiws027vAf3e75XosP6121xUZfFGv1W5qEynHASZ98PYv7C
	 N6g9OvPbRQVCwPVAQTl9av4hjBLWTdHwpWuIjyvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfKHWQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:16:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfKHWQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:16:53 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32FA2206C3;
        Fri,  8 Nov 2019 22:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573251412;
        bh=UMLMfzeZ5d6ns0l8n8EZL9EegR7c0Zs1zYDFdZD51UQ=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=CWhydIuLpiNkRC2e2o3hgvdyMWzOcF0tY4qbw/aO1IXhXo1X0X9QXzcckycwtajKz
         /K0jAR0/qbv8xYv8WsdeCIZV9+K8NwKZpEkndOJNA+TMu18fskDIvUHmE/shKvEnKO
         F1we+BDGjB7rjbvwOTHi9wTzB5ervodLflH6VfuE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191027162328.1177402-3-martin.blumenstingl@googlemail.com>
References: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com> <20191027162328.1177402-3-martin.blumenstingl@googlemail.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        jbrunet@baylibre.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/5] clk: meson: add a driver for the Meson8/8b/8m2 DDR clock controller
User-Agent: alot/0.8.1
Date:   Fri, 08 Nov 2019 14:16:51 -0800
Message-Id: <20191108221652.32FA2206C3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2019-10-27 09:23:25)
> diff --git a/drivers/clk/meson/meson8-ddr.c b/drivers/clk/meson/meson8-dd=
r.c
> new file mode 100644
> index 000000000000..4aefcc5bdaae
> --- /dev/null
> +++ b/drivers/clk/meson/meson8-ddr.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Amlogic Meson8 DDR clock controller
> + *
> + * Copyright (C) 2019 Martin Blumenstingl <martin.blumenstingl@googlemai=
l.com>
> + */
> +
> +#include <dt-bindings/clock/meson8-ddr-clkc.h>
> +
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <linux/slab.h>

Please include clk-provider.h as this is a clk provider driver.

> +
> +#include "clk-regmap.h"
> +#include "clk-pll.h"
> +
> +#define AM_DDR_PLL_CNTL                        0x00
> +#define AM_DDR_PLL_CNTL1               0x04
> +#define AM_DDR_PLL_CNTL2               0x08
> +#define AM_DDR_PLL_CNTL3               0x0c
> +#define AM_DDR_PLL_CNTL4               0x10
> +#define AM_DDR_PLL_STS                 0x14
> +#define DDR_CLK_CNTL                   0x18
> +#define DDR_CLK_STS                    0x1c
> +
> +static struct clk_regmap meson8_ddr_pll_dco =3D {
> +       .data =3D &(struct meson_clk_pll_data){
> +               .en =3D {
> +                       .reg_off =3D AM_DDR_PLL_CNTL,
> +                       .shift   =3D 30,
> +                       .width   =3D 1,
> +               },
> +               .m =3D {
> +                       .reg_off =3D AM_DDR_PLL_CNTL,
> +                       .shift   =3D 0,
> +                       .width   =3D 9,
> +               },
> +               .n =3D {
> +                       .reg_off =3D AM_DDR_PLL_CNTL,
> +                       .shift   =3D 9,
> +                       .width   =3D 5,
> +               },
> +               .l =3D {
> +                       .reg_off =3D AM_DDR_PLL_CNTL,
> +                       .shift   =3D 31,
> +                       .width   =3D 1,
> +               },
> +               .rst =3D {
> +                       .reg_off =3D AM_DDR_PLL_CNTL,
> +                       .shift   =3D 29,
> +                       .width   =3D 1,
> +               },
> +       },
> +       .hw.init =3D &(struct clk_init_data){
> +               .name =3D "ddr_pll_dco",
> +               .ops =3D &meson_clk_pll_ro_ops,
> +               .parent_data =3D &(const struct clk_parent_data) {
> +                       .fw_name =3D "xtal",
> +               },
> +               .num_parents =3D 1,
> +       },
> +};
> +
> +static struct clk_regmap meson8_ddr_pll =3D {
> +       .data =3D &(struct clk_regmap_div_data){
> +               .offset =3D AM_DDR_PLL_CNTL,
> +               .shift =3D 16,
> +               .width =3D 2,
> +               .flags =3D CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init =3D &(struct clk_init_data){
> +               .name =3D "ddr_pll",
> +               .ops =3D &clk_regmap_divider_ro_ops,
> +               .parent_hws =3D (const struct clk_hw *[]) {
> +                       &meson8_ddr_pll_dco.hw
> +               },
> +               .num_parents =3D 1,
> +       },
> +};
> +
> +static struct clk_hw_onecell_data meson8_ddr_clk_hw_onecell_data =3D {
> +       .hws =3D {
> +               [DDR_CLKID_DDR_PLL_DCO]         =3D &meson8_ddr_pll_dco.h=
w,
> +               [DDR_CLKID_DDR_PLL]             =3D &meson8_ddr_pll.hw,
> +       },
> +       .num =3D 2,
> +};
> +
> +static struct clk_regmap *const meson8_ddr_clk_regmaps[] =3D {
> +       &meson8_ddr_pll_dco,
> +       &meson8_ddr_pll,
> +};
> +
> +static const struct regmap_config meson8_ddr_clkc_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .max_register =3D DDR_CLK_STS,
> +};
> +
> +static int meson8_ddr_clkc_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +       struct resource *res;
> +       void __iomem *base;
> +       struct clk_hw *hw;
> +       int ret, i;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap_resource(&pdev->dev, res);

We have a new function to combine the above two lines. Please use it so
the janitors avoid this file.

> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       regmap =3D devm_regmap_init_mmio(&pdev->dev, base,
> +                                      &meson8_ddr_clkc_regmap_config);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       /* Populate regmap */
> +       for (i =3D 0; i < ARRAY_SIZE(meson8_ddr_clk_regmaps); i++)
> +               meson8_ddr_clk_regmaps[i]->map =3D regmap;
> +
> +       /* Register all clks */
> +       for (i =3D 0; i < meson8_ddr_clk_hw_onecell_data.num; i++) {
> +               hw =3D meson8_ddr_clk_hw_onecell_data.hws[i];
> +
> +               ret =3D devm_clk_hw_register(&pdev->dev, hw);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Clock registration failed\n"=
);
> +                       return ret;
> +               }
> +       }
> +
> +       return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_=
get,
> +                                          &meson8_ddr_clk_hw_onecell_dat=
a);
> +}
> +
> +static const struct of_device_id meson8_ddr_clkc_match_table[] =3D {
> +       { .compatible =3D "amlogic,meson8-ddr-clkc" },
> +       { .compatible =3D "amlogic,meson8b-ddr-clkc" },
> +       { /* sentinel */ },

Super nitpick, drop the comma above so that nothing can follow this.

> +};
> +
> +static struct platform_driver meson8_ddr_clkc_driver =3D {
> +       .probe          =3D meson8_ddr_clkc_probe,
> +       .driver         =3D {
> +               .name   =3D "meson8-ddr-clkc",
> +               .of_match_table =3D meson8_ddr_clkc_match_table,
> +       },
> +};
> +
> +builtin_platform_driver(meson8_ddr_clkc_driver);
> --=20
> 2.23.0
>=20
