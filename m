Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5919C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B5E206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568665600;
	bh=zreUNsMVZQ9Z+Y9iDxyV3r5lfO8dkdMfVi7ZXmszvzU=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=17lXCo6neUhOYreoXoV6o3XtF6kBd6oF/OtcXZypyVy9Bnt+EV5uFtm/AL7Xxqv7S
	 WjsQT4ECfZj3tshd9YtQIBngBk5UotQUddw2sfd2kCuBOgxfJ7yBRcHk2QKtKKOFru
	 AIKZXEx3QpSeL8vehxKpBJ0KvM6oRTvkiicZgXjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403770AbfIPU0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbfIPU0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:26:39 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F542067B;
        Mon, 16 Sep 2019 20:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568665597;
        bh=zreUNsMVZQ9Z+Y9iDxyV3r5lfO8dkdMfVi7ZXmszvzU=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=hDxIi2WQarrZwVFyh/kk+4k8UzfK/NzG48QWdFdpkwGxXYa21irfXBHhCz0eAL3Hv
         yOmO3eDDHk5g/t/9hupfHqjSVE2CMkcThRtYRQDaxQeEUIIoPt4JRJkPnow6efhtyf
         PcQaR8L4Kt1pSTdAjFNtOVsfAbqj4x3xC2TY3vKQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190829105919.44363-2-wen.he_1@nxp.com>
References: <20190829105919.44363-1-wen.he_1@nxp.com> <20190829105919.44363-2-wen.he_1@nxp.com>
Cc:     leoyang.li@nxp.com, liviu.dudau@arm.com, Wen He <wen.he_1@nxp.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Wen He <wen.he_1@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-devel@linux.nxdi.nxp.com, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [v4 2/2] clk: ls1028a: Add clock driver for Display output interface
User-Agent: alot/0.8.1
Date:   Mon, 16 Sep 2019 13:26:36 -0700
Message-Id: <20190916202637.B5F542067B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-08-29 03:59:19)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 801fa1cd0321..ab05f342af04 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -223,6 +223,16 @@ config CLK_QORIQ
>           This adds the clock driver support for Freescale QorIQ platforms
>           using common clock framework.
> =20
> +config CLK_LS1028A_PLLDIG
> +        bool "Clock driver for LS1028A Display output"

Is this a tristate? The driver is made to be a module but it isn't
allowed to be compiled as such.

> +        depends on ARCH_LAYERSCAPE || COMPILE_TEST
> +        default ARCH_LAYERSCAPE
> +        help
> +          This driver support the Display output interfaces(LCD, DPHY) p=
ixel clocks
> +          of the QorIQ Layerscape LS1028A, as implemented TSMC CLN28HPM =
PLL. Not all
> +          features of the PLL are currently supported by the driver. By =
default,
> +          configured bypass mode with this PLL.
> +
>  config COMMON_CLK_XGENE
>         bool "Clock driver for APM XGene SoC"
>         default ARCH_XGENE
> diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c
> new file mode 100644
> index 000000000000..d3239bcf59de
> --- /dev/null
> +++ b/drivers/clk/clk-plldig.c
> @@ -0,0 +1,298 @@
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
> +
> +/* PLLDIG register offsets and bit masks */
> +#define PLLDIG_REG_PLLSR            0x24
> +#define PLLDIG_REG_PLLDV            0x28
> +#define PLLDIG_REG_PLLFM            0x2c
> +#define PLLDIG_REG_PLLFD            0x30
> +#define PLLDIG_REG_PLLCAL1          0x38
> +#define PLLDIG_REG_PLLCAL2          0x3c
> +#define PLLDIG_LOCK_MASK            BIT(2)
> +#define PLLDIG_SSCGBYP_ENABLE       BIT(30)
> +#define PLLDIG_FDEN                 BIT(30)
> +#define PLLDIG_DTHRCTL              (0x3 << 16)
> +
> +/* macro to get/set values into register */
> +#define PLLDIG_GET_MULT(x)          (((x) & ~(0xffffff00)) << 0)
> +#define PLLDIG_GET_RFDPHI1(x)       ((u32)(x) >> 25)
> +#define PLLDIG_SET_RFDPHI1(x)       ((u32)(x) << 25)

Maybe you can use the FIELD_GET() APIs and genmask from bitfield.h?

> +
> +/* Maximum of the divider */
> +#define MAX_RFDPHI1          63
> +
> +/* Best value of multiplication factor divider */
> +#define PLLDIG_DEFAULE_MULT         44
> +
> +/*
> + * Clock configuration relationship between the PHI1 frequency(fpll_phi)=
 and
> + * the output frequency of the PLL is determined by the PLLDV, according=
 to
> + * the following equation:
> + * fpll_phi =3D (pll_ref * mfd) / div_rfdphi1
> + */
> +struct plldig_phi1_param {
> +       unsigned long rate;
> +       unsigned int rfdphi1;
> +       unsigned int mfd;
> +};
> +
> +enum plldig_phi1_freq_range {
> +       PHI1_MIN        =3D 27000000U,
> +       PHI1_MAX        =3D 600000000U
> +};

Please just inline these values in the one place they're used.

> +
> +struct clk_plldig {
> +       struct clk_hw hw;
> +       void __iomem *regs;
> +       struct device *dev;

Please remove this, it is unused.

> +};
> +
> +#define to_clk_plldig(_hw)     container_of(_hw, struct clk_plldig, hw)
> +#define LOCK_TIMEOUT_US                USEC_PER_MSEC

Is this used?

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
> +       val =3D readl(data->regs + PLLDIG_REG_PLLFD);
> +       /* Disable dither and Sigma delta modulation in bypass mode */
> +       val |=3D (PLLDIG_FDEN | PLLDIG_DTHRCTL);
> +       writel(val, data->regs + PLLDIG_REG_PLLFD);
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
> +       writel(val, data->regs + PLLDIG_REG_PLLFM);
> +}
> +
> +static int plldig_is_enabled(struct clk_hw *hw)
> +{
> +       struct clk_plldig *data =3D to_clk_plldig(hw);
> +
> +       return (readl(data->regs + PLLDIG_REG_PLLFM) & PLLDIG_SSCGBYP_ENA=
BLE);
> +}
> +
> +static unsigned long plldig_recalc_rate(struct clk_hw *hw,
> +               unsigned long parent_rate)
> +{
> +       struct clk_plldig *data =3D to_clk_plldig(hw);
> +       u32 mult, div, val;
> +
> +       val =3D readl(data->regs + PLLDIG_REG_PLLDV);
> +
> +       /* Check if PLL is bypassed */
> +       if (val & PLLDIG_SSCGBYP_ENABLE)
> +               return parent_rate;
> +
> +       /* Checkout multiplication factor divider value */
> +       mult =3D val;
> +       mult =3D PLLDIG_GET_MULT(mult);
> +
> +       /* Checkout divider value of the output frequency */
> +       div =3D val;
> +       div =3D PLLDIG_GET_RFDPHI1(div);
> +
> +       return (parent_rate * mult) / div;
> +}
> +
> +static int plldig_calc_target_rate(unsigned long target_rate,
> +                                  unsigned long parent_rate,
> +                                  struct plldig_phi1_param *phi1_out)
> +{
> +       unsigned int div, mfd, ret;
> +       unsigned long round_rate;
> +
> +       /*
> +        * Firstly, check the target rate whether is divisible
> +        * by the best VCO frequency.
> +        */
> +       mfd =3D PLLDIG_DEFAULE_MULT;
> +       round_rate =3D parent_rate * mfd;
> +       div =3D round_rate / target_rate;
> +       if (!div || div > MAX_RFDPHI1)
> +               return -EINVAL;
> +
> +       ret =3D round_rate % target_rate;
> +       if (!ret)
> +               goto out;

Please get rid of ret and do the test here directly and then put the
below code into the if statement to remove the goto.


	if (round_rate % target_rate) {
	       /*
	        * Otherwise, try a rounding algorithm to driven the target rate,
	        * this algorithm allows tolerances between the target rate and
	        * real rate, it based on the best VCO output frequency.
	        */
	       mfd =3D PLLDIG_DEFAULE_MULT;
	       round_rate =3D parent_rate * mfd;
=09
	       /*
	        * Add half of the target rate so the result will be
	        * rounded to cloeset instead of rounded down.
	        */
	       round_rate +=3D (target_rate / 2);
	       div =3D round_rate / target_rate;
	       if (!div || div > MAX_RFDPHI1)
	               return -EINVAL;
=09
	}

> +       phi1_out->rfdphi1 =3D PLLDIG_SET_RFDPHI1(div);
> +       phi1_out->mfd =3D mfd;
> +       phi1_out->rate =3D target_rate;
> +
> +       return 0;
> +}
> +
> +static int plldig_determine_rate(struct clk_hw *hw,
> +                                struct clk_rate_request *req)
> +{
> +       int ret;
> +       struct clk_hw *parent;
> +       struct plldig_phi1_param phi1_param;
> +       unsigned long parent_rate;
> +
> +       if (req->rate =3D=3D 0 || req->rate < PHI1_MIN || req->rate > PHI=
1_MAX)
> +               return -EINVAL;

Preferably you clamp the requested rate to min/max instead of just
returning a failure. That way the clk_set_rate() API "works" by trying
to achieve some frequency that is there. You'll have to look at the
request that is passed into this function to make sure that the min/max
of the request is within the range this clk supports, but it will be
better than just blindly returning a failure because this function
should try to round the rate to something that is supported.

> +
> +       parent =3D clk_hw_get_parent(hw);
> +       parent_rate =3D clk_hw_get_rate(parent);
> +
> +       ret =3D plldig_calc_target_rate(req->rate, parent_rate, &phi1_par=
am);
> +       if (ret)
> +               return ret;
> +
> +       req->rate =3D phi1_param.rate;
> +
> +       return 0;
> +}
> +
> +static int plldig_set_rate(struct clk_hw *hw, unsigned long rate,
> +               unsigned long parent_rate)
> +{
> +       struct clk_plldig *data =3D to_clk_plldig(hw);
> +       struct plldig_phi1_param phi1_param;
> +       unsigned int rfdphi1, val, cond;
> +       int ret =3D -ETIMEDOUT;

Drop this initial assignment please.

> +
> +       ret =3D plldig_calc_target_rate(rate, parent_rate, &phi1_param);
> +       if (ret)
> +               return ret;

Because it's overwritten immediately.

> +
> +       val =3D readl(data->regs + PLLDIG_REG_PLLDV);
> +       val =3D phi1_param.mfd;
> +       rfdphi1 =3D phi1_param.rfdphi1;
> +       val |=3D rfdphi1;
> +
> +       writel(val, data->regs + PLLDIG_REG_PLLDV);
> +
> +       /* delay 200us make sure that old lock state is cleared */
> +       udelay(200);
> +
> +       /* Wait until PLL is locked or timeout (maximum 1000 usecs) */
> +       ret =3D readl_poll_timeout_atomic(data->regs + PLLDIG_REG_PLLSR, =
cond,
> +                                       cond & PLLDIG_LOCK_MASK, 0,
> +                                       USEC_PER_MSEC);
> +
> +       return ret;

Just return readl_poll_timeout_atomic(...) here.

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
> +static int plldig_clk_probe(struct platform_device *pdev)
> +{
> +       struct clk_plldig *data;
> +       struct resource *mem;
> +       struct clk_init_data init =3D {};
> +       struct device *dev =3D &pdev->dev;
> +       struct clk_parent_data parent_data;

Set this to =3D { .index =3D 0 }

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
> +       parent_data.name =3D of_clk_get_parent_name(dev->of_node, 0);
> +       parent_data.index =3D 0;

And don't assign these.

> +
> +       init.name =3D dev->of_node->name;
> +       init.ops =3D &plldig_clk_ops;
> +       init.parent_data =3D &parent_data;
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
> +       ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &d=
ata->hw);
> +       if (ret)
> +               dev_err(dev, "failed adding the clock provider\n");
> +
> +       return ret;

I'd prefer to just see return devm_of_clk_add_hw_provider(), but not a
big deal.

