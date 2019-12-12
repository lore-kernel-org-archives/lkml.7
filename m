Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EF7C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A472173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576189101;
	bh=oe6Yp4g352vu1xp6IWNIh7iJAfEzPglzyvwwZlxIE4Q=;
	h=In-Reply-To:References:From:Cc:To:Subject:Date:List-ID:From;
	b=frvle5BytTd1wKTiZYxmECn5Fazieu1HYee/3DE8L/wObUVD6LkCjlu9T2vTPjs6h
	 POushsX5tiH20CydYZRxYV0pzf6wtWLKUHeLSCin2PEDsOyo9tMpsWx2I4EQrPP1he
	 UB9uZLO/3Xeb4bnxZ3F5CNckvdv4p2DP58N/3mFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbfLLWSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:18:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730896AbfLLWST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:18:19 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7FF1206DA;
        Thu, 12 Dec 2019 22:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576189097;
        bh=oe6Yp4g352vu1xp6IWNIh7iJAfEzPglzyvwwZlxIE4Q=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=vbhgzLqYSVQfwaF3qnIV8bC36/wQTXHrJ2H/2hzKe1W2enC//2Td3Ur1br4xPri99
         LToooulyWpOWwAu8OGdKqBBmiC4C1DQ2/yNpftLHoyJGsXm3PSWfZs6RVCqJuzfaPt
         xxkX1g27/oDc8tOifR2SfsgUeDYlEOcddI1Vmv7U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191205072653.34701-2-wen.he_1@nxp.com>
References: <20191205072653.34701-1-wen.he_1@nxp.com> <20191205072653.34701-2-wen.he_1@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Wen He <wen.he_1@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>, Wen He <wen.he_1@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v11 2/2] clk: ls1028a: Add clock driver for Display output interface
User-Agent: alot/0.8.1
Date:   Thu, 12 Dec 2019 14:18:16 -0800
Message-Id: <20191212221817.B7FF1206DA@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-12-04 23:26:53)
> Add clock driver for QorIQ LS1028A Display output interfaces(LCD, DPHY),
> as implemented in TSMC CLN28HPM PLL, this PLL supports the programmable
> integer division and range of the display output pixel clock's 27-594MHz.
>=20
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>

Is Michael the author? SoB chain is backwards here.

> diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c
> new file mode 100644
> index 000000000000..1942686f0254
> --- /dev/null
> +++ b/drivers/clk/clk-plldig.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 NXP
> + *
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
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/bitfield.h>
> +
> +/* PLLDIG register offsets and bit masks */
> +#define PLLDIG_REG_PLLSR            0x24
> +#define PLLDIG_LOCK_MASK            BIT(2)
> +#define PLLDIG_REG_PLLDV            0x28
> +#define PLLDIG_MFD_MASK             GENMASK(7, 0)
> +#define PLLDIG_RFDPHI1_MASK         GENMASK(30, 25)
> +#define PLLDIG_REG_PLLFM            0x2c
> +#define PLLDIG_SSCGBYP_ENABLE       BIT(30)
> +#define PLLDIG_REG_PLLFD            0x30
> +#define PLLDIG_FDEN                 BIT(30)
> +#define PLLDIG_FRAC_MASK            GENMASK(15, 0)
> +#define PLLDIG_REG_PLLCAL1          0x38
> +#define PLLDIG_REG_PLLCAL2          0x3c
> +
> +/* Range of the VCO frequencies, in Hz */
> +#define PLLDIG_MIN_VCO_FREQ         650000000
> +#define PLLDIG_MAX_VCO_FREQ         1300000000
> +
> +/* Range of the output frequencies, in Hz */
> +#define PHI1_MIN_FREQ               27000000
> +#define PHI1_MAX_FREQ               600000000
> +
> +/* Maximum value of the reduced frequency divider */
> +#define MAX_RFDPHI1          63UL
> +
> +/* Best value of multiplication factor divider */
> +#define PLLDIG_DEFAULT_MFD   44
> +
> +/*
> + * Denominator part of the fractional part of the
> + * loop multiplication factor.
> + */
> +#define MFDEN          20480
> +
> +static const struct clk_parent_data parent_data[] =3D {
> +       {.index =3D 0},

Nitpick: Add spaces after { and before }

> +};
> +
> +struct clk_plldig {
> +       struct clk_hw hw;
> +       void __iomem *regs;
> +       unsigned int vco_freq;
> +};
> +
> +#define to_clk_plldig(_hw)     container_of(_hw, struct clk_plldig, hw)
> +
> +static int plldig_enable(struct clk_hw *hw)
> +{
> +       struct clk_plldig *data =3D to_clk_plldig(hw);
> +       u32 val;
> +
> +       val =3D readl(data->regs + PLLDIG_REG_PLLFM);
> +       /*
> +        * Use Bypass mode with PLL off by default, the frequency oversho=
ot
> +        * detector output was disable. SSCG Bypass mode should be enable.
> +        */
> +       val |=3D PLLDIG_SSCGBYP_ENABLE;
> +       writel(val, data->regs + PLLDIG_REG_PLLFM);
> +
> +       return 0;
> +}
> +
> +static void plldig_disable(struct clk_hw *hw)
> +{
> +       struct clk_plldig *data =3D to_clk_plldig(hw);
> +       u32 val;
> +
> +       val =3D readl(data->regs + PLLDIG_REG_PLLFM);
> +
> +       val &=3D ~PLLDIG_SSCGBYP_ENABLE;
> +       val |=3D FIELD_PREP(PLLDIG_SSCGBYP_ENABLE, 0x0);
> +
> +       writel(val, data->regs + PLLDIG_REG_PLLFM);
> +}
> +
> +static int plldig_is_enabled(struct clk_hw *hw)
> +{
> +       struct clk_plldig *data =3D to_clk_plldig(hw);
> +
> +       return (readl(data->regs + PLLDIG_REG_PLLFM) &

Please drop useless parenthesis.

> +                             PLLDIG_SSCGBYP_ENABLE);
> +}
> +
> +static unsigned long plldig_recalc_rate(struct clk_hw *hw,
> +                                       unsigned long parent_rate)
> +{
> +       struct clk_plldig *data =3D to_clk_plldig(hw);
> +       u32 val, rfdphi1;
> +
> +       val =3D readl(data->regs + PLLDIG_REG_PLLDV);
> +
> +       /* Check if PLL is bypassed */
> +       if (val & PLLDIG_SSCGBYP_ENABLE)
> +               return parent_rate;
> +
> +       rfdphi1 =3D FIELD_GET(PLLDIG_RFDPHI1_MASK, val);
> +
> +       /*
> +        * If RFDPHI1 has a value of 1 the VCO frequency is also divided =
by
> +        * one.
> +        */
> +       if (!rfdphi1)
> +               rfdphi1 =3D 1;
> +
> +       return DIV_ROUND_UP(data->vco_freq, rfdphi1);
> +}
> +
> +static unsigned long plldig_calc_target_div(unsigned long vco_freq,
> +                                           unsigned long target_rate)
> +{
> +       unsigned long div;
> +
> +       div =3D DIV_ROUND_CLOSEST(vco_freq, target_rate);
> +       div =3D max(1UL, div);
> +       div =3D min(div, MAX_RFDPHI1);

Use clamp().

> +
> +       return div;
> +}
> +
> +static int plldig_determine_rate(struct clk_hw *hw,
> +                                struct clk_rate_request *req)
> +{
> +       struct clk_plldig *data =3D to_clk_plldig(hw);
> +       unsigned int div;
> +
> +       if (req->rate < PHI1_MIN_FREQ)
> +               req->rate =3D PHI1_MIN_FREQ;
> +       if (req->rate > PHI1_MAX_FREQ)
> +               req->rate =3D PHI1_MAX_FREQ;

Use clamp()

> +
> +       div =3D plldig_calc_target_div(data->vco_freq, req->rate);
> +       req->rate =3D DIV_ROUND_UP(data->vco_freq, div);
> +
> +       return 0;
> +}
> +
> +static int plldig_set_rate(struct clk_hw *hw, unsigned long rate,
> +               unsigned long parent_rate)
> +{
> +       struct clk_plldig *data =3D to_clk_plldig(hw);
> +       unsigned int val, cond;
> +       unsigned int rfdphi1;
> +
> +       if (rate < PHI1_MIN_FREQ)
> +               rate =3D PHI1_MIN_FREQ;
> +       if (rate > PHI1_MAX_FREQ)
> +               rate =3D PHI1_MAX_FREQ;

Use clamp()

> +
> +       rfdphi1 =3D plldig_calc_target_div(data->vco_freq, rate);
> +
> +       /* update the divider value */
> +       val =3D readl(data->regs + PLLDIG_REG_PLLDV);
> +       val &=3D ~PLLDIG_RFDPHI1_MASK;
> +       val |=3D FIELD_PREP(PLLDIG_RFDPHI1_MASK, rfdphi1);
> +       writel(val, data->regs + PLLDIG_REG_PLLDV);
> +
> +       /* delay 200us make sure that old lock state is cleared */
> +       udelay(200);

Please remove 'delay 200us' from the comment. Just say that we're waiting
for old lock state to clear. It's clear from the code how much time it
is.

> +
> +       /* Wait until PLL is locked or timeout (maximum 1000 usecs) */

Drop the time. It's a millisecond.

> +       return readl_poll_timeout_atomic(data->regs + PLLDIG_REG_PLLSR, c=
ond,
> +                                        cond & PLLDIG_LOCK_MASK, 0,
> +                                        USEC_PER_MSEC);
> +}
> +
> +static const struct clk_ops plldig_clk_ops =3D {
> +       .enable =3D plldig_enable,
> +       .disable =3D plldig_disable,
> +       .is_enabled =3D plldig_is_enabled,
> +       .recalc_rate =3D plldig_recalc_rate,
> +       .determine_rate =3D plldig_determine_rate,
> +       .set_rate =3D plldig_set_rate,
> +};
> +
> +static int plldig_init(struct clk_hw *hw)
> +{
> +       struct clk_plldig *data =3D to_clk_plldig(hw);
> +       struct clk_hw *parent =3D clk_hw_get_parent(hw);
> +       unsigned long parent_rate =3D clk_hw_get_rate(parent);
> +       unsigned long val;
> +       unsigned long long lltmp;
> +       unsigned int mfd, fracdiv =3D 0;
> +
> +       if (!parent)
> +               return -EINVAL;
> +
> +       if (data->vco_freq) {
> +               mfd =3D data->vco_freq / parent_rate;
> +               lltmp =3D data->vco_freq % parent_rate;
> +               lltmp *=3D MFDEN;
> +               do_div(lltmp, parent_rate);
> +               fracdiv =3D lltmp;
> +       } else {
> +               mfd =3D PLLDIG_DEFAULT_MFD;
> +               data->vco_freq =3D parent_rate * mfd;
> +       }
> +
> +       val =3D FIELD_PREP(PLLDIG_MFD_MASK, mfd);
> +       writel(val, data->regs + PLLDIG_REG_PLLDV);
> +
> +       if (fracdiv) {
> +               val =3D FIELD_PREP(PLLDIG_FRAC_MASK, fracdiv);
> +               /* Enable fractional divider */

Remove useless comment please. Or move above the if condition.

> +               val |=3D PLLDIG_FDEN;
> +               writel(val, data->regs + PLLDIG_REG_PLLFD);
> +       }
> +
> +       return 0;
> +}
> +
> +static int plldig_clk_probe(struct platform_device *pdev)
> +{
> +       struct clk_plldig *data;
> +       struct resource *mem;
> +       struct device *dev =3D &pdev->dev;
> +       int ret;
> +
> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       data->regs =3D devm_ioremap_resource(dev, mem);

We have devm_platform_ioremap_resource() for this now.

> +       if (IS_ERR(data->regs))
> +               return PTR_ERR(data->regs);
> +
> +       data->hw.init =3D CLK_HW_INIT_PARENTS_DATA("dpclk",
> +                                                parent_data,
> +                                                &plldig_clk_ops,
> +                                                0);
> +
> +       ret =3D devm_clk_hw_register(dev, &data->hw);
> +       if (ret) {
> +               dev_err(dev, "failed to register %s clock\n",
> +                                               dev->of_node->name);
> +               return ret;
> +       }
> +
> +       ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +                                         &data->hw);
> +       if (ret) {
> +               dev_err(dev, "unable to add clk provider\n");
> +               return ret;
> +       }
> +
> +       /*
> +        * The frequency of the VCO cannot be changed during runtime.
> +        * Therefore, let the user specify a desired frequency.
> +        */
> +       if (!of_property_read_u32(dev->of_node, "fsl,vco-hz",
> +                                 &data->vco_freq)) {
> +               if (data->vco_freq < PLLDIG_MIN_VCO_FREQ ||
> +                   data->vco_freq > PLLDIG_MAX_VCO_FREQ)
> +                       return -EINVAL;
> +       }
> +
> +       return plldig_init(&data->hw);
> +}
> +
> +static const struct of_device_id plldig_clk_id[] =3D {
> +       { .compatible =3D "fsl,ls1028a-plldig"},

Nitpick: Add a space before }

> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, plldig_clk_id);
> +
