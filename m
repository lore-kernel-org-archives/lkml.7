Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30A8C32753
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F9320665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565720723;
	bh=Ie6mnm3VS3AB7zBMzK2ZlH+k5xAOHrd7oRaYd0fQuVA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=wbXToRZdXKEanmc1DGj8q0piaUP84hfCYA9QKAMkeChXYoMt/kqo06ht1OOzaKTXm
	 MDjTcIRHiLhy75Bs6kVCUrlOUgBzYWR2Nmm5k28UplG+H7a1uz2ZQne0PkusCXwBRt
	 uBr6COSx8MUTlZbXYynN7uKiqz7PSvwhCUbGGF4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfHMSZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 14:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbfHMSZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:25:21 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2914520665;
        Tue, 13 Aug 2019 18:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565720720;
        bh=Ie6mnm3VS3AB7zBMzK2ZlH+k5xAOHrd7oRaYd0fQuVA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eQuKq1LwBhejRxWOGpFRz4GC+ydilZkoM/1DsKJ8YRuMkTccf/XmG8MgjopyZJixq
         5gcKbvTDDUBfrW98KK4WZXtal0KKbgRjIVdqLTbI0rZNFHw6ZLZPem3gNFV6+q3t/0
         r7mYqgyckrZ1lk6tEos4sWIh5pu1B8hO8DtwDRJQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190812100103.34393-1-wen.he_1@nxp.com>
References: <20190812100103.34393-1-wen.he_1@nxp.com>
Subject: Re: [v1 1/3] clk: ls1028a: Add clock driver for Display output interface
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Wen He <wen.he_1@nxp.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Wen He <wen.he_1@nxp.com>, leoyang.li@nxp.com,
        linux-clk@vger.kernel.org, linux-devel@linux.nxdi.nxp.com,
        linux-kernel@vger.kernel.org, liviu.dudau@arm.com
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 11:25:19 -0700
Message-Id: <20190813182520.2914520665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-08-12 03:01:03)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 801fa1cd0321..0e6c7027d637 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -223,6 +223,15 @@ config CLK_QORIQ
>           This adds the clock driver support for Freescale QorIQ platforms
>           using common clock framework.
> =20
> +config CLK_PLLDIG
> +        bool "Clock driver for LS1028A Display output"
> +        depends on ARCH_LAYERSCAPE && OF

Does it actually depend on either of these to build? Probabl not, so
maybe just default ARCH_LAYERSCAPE && OF? Also, can your Kconfig
variable be named something more specific like CLK_LS1028A_PLLDIG?

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
> index 000000000000..15c9bb623a70
> --- /dev/null
> +++ b/drivers/clk/clk-plldig.c
> @@ -0,0 +1,277 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright 2019 NXP
> +
> +/*
> + * Clock driver for LS1028A Display output interfaces(LCD, DPHY).
> + *
> + * Author: Wen He <wen.he_1@nxp.com>
> + *
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

PLease remove this unused include.

> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>

Only makes sense to include this if it's a platform device driver.

> +#include <linux/slab.h>
> +
[...]
> +
> +static inline int plldig_wait_lock(struct clk_plldig *plldig)
> +{
> +       u32 csr;
> +       /*
> +       * Indicates whether PLL has acquired lock, if operating in bypass
> +       * mode, the LOCK bit will still assert when the PLL acquires lock
> +       * or negate when it loses lock.
> +       */
> +       return readl_poll_timeout(plldig->regs + PLLDIG_REG_PLLSR, csr,
> +                               csr & PLLDIG_LOCK_STATUS, 0, LOCK_TIMEOUT=
_US);
> +}
> +
> +static int plldig_enable(struct clk_hw *hw)
> +{
> +       struct clk_plldig *data =3D to_clk_plldig(hw);
> +       u32 val;
> +
> +       val =3D readl(data->regs + PLLDIG_REG_PLLFM);
> +       /*
> +        * Use Bypass mode with PLL off by default,the frequency overshoot

Please add a space after comma,

> +        * detector output was disable. SSCG Bypass mode should be enable.
> +        */
> +       val |=3D PLLDIG_SSCGBYP_ENABLE;
> +       writel(val, data->regs + PLLDIG_REG_PLLFM);
> +
[...]
> +
> +static int plldig_is_enabled(struct clk_hw *hw)
> +{
> +       struct clk_plldig *data =3D to_clk_plldig(hw);
> +
> +       return (readl(data->regs + PLLDIG_REG_PLLFM) & PLLDIG_SSCGBYP_ENA=
BLE);

Please remove extraneous parenthesis.

> +}
> +
> +/*
> + * Clock configuration relationship between the PHI1 frequency(fpll_phi)=
 and
> + * the output frequency of the PLL is determined by the PLLDV, according=
 to
> + * the following equation:
> + * pxclk =3D fpll_phi / RFDPHI1 =3D (pll_ref x PLLDV[MFD]) / PLLDV[RFDPH=
I1].
> + */
> +static bool plldig_is_valid_range(unsigned long rate, unsigned long pare=
nt_rate,
> +               unsigned int *mult, unsigned int *rfdphi1,
> +               unsigned long *round_rate_base)
> +{
> +       u32 div, div_temp, mfd =3D PLLDIG_DEFAULE_MULT;
> +       unsigned long round_rate;
> +
> +       round_rate =3D parent_rate * mfd;
> +
> +       /* Range of the diliver for driving the PHI1 output clock */

divider? Not diliver, right?

> +       for (div =3D 1; div <=3D 63; div++) {
> +               /* Checking match with default mult number at first */
> +               if (round_rate / div =3D=3D rate) {
> +                       *rfdphi1 =3D div;
> +                       *round_rate_base =3D round_rate;
> +                       *mult =3D mfd;
> +                       return true;
> +               }
> +       }
> +
> +       for (div =3D 1; div <=3D 63; div++) {
> +               mfd =3D (div * rate) / parent_rate;
> +               /* Range of the muliplicationthe factor applied to the

/*
 * Please make multi line comments look like this
 */

> +                * output reference frequency
> +                */
> +               if ((mfd >=3D 10) && (mfd <=3D 150)) {
> +                       div_temp =3D (parent_rate * mfd) / rate;
> +                       if ((div_temp * rate) =3D=3D (mfd * parent_rate))=
 {
> +                               *rfdphi1 =3D div_temp;
> +                               *mult =3D mfd;
> +                               *round_rate_base =3D mfd * parent_rate;
> +                               return true;
> +                       }
> +               }
> +       }
> +
> +       return false;
> +}
> +
> +static unsigned long plldig_recalc_rate(struct clk_hw *hw,
> +               unsigned long parent_rate)
> +{
> +       struct clk_plldig *plldig =3D to_clk_plldig(hw);
> +       u32 mult, div, val;
> +
> +       val =3D readl(plldig->regs + PLLDIG_REG_PLLDV);
> +       pr_info("%s: current configuration: 0x%x\n", clk_hw_get_name(hw),=
 val);

Remove debug prints please.

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
> +static long plldig_round_rate(struct clk_hw *hw, unsigned long rate,
> +               unsigned long *parent)
> +{
> +       unsigned long parent_rate =3D *parent;
> +       unsigned long round_rate;
> +       u32 mult =3D 0, rfdphi1 =3D 0;
> +       bool found =3D false;
> +
> +       found =3D plldig_is_valid_range(rate, parent_rate, &mult,
> +                                       &rfdphi1, &round_rate);
> +       if (!found) {
> +               pr_warn("%s: unable to round rate %lu, parent rate :%lu\n=
",
> +                               clk_hw_get_name(hw), rate, parent_rate);
> +               return 0;
> +       }
> +
> +       return round_rate / rfdphi1;
> +}
> +
> +static int plldig_set_rate(struct clk_hw *hw, unsigned long rate,
> +               unsigned long parent_rate)
> +{
> +       struct clk_plldig *data =3D to_clk_plldig(hw);
> +       bool valid =3D false;
> +       unsigned long round_rate =3D 0;
> +       u32 rfdphi1 =3D 0, val, mult =3D 0;
> +
> +       valid =3D plldig_is_valid_range(rate, parent_rate, &mult,
> +                                       &rfdphi1, &round_rate);
> +       if (!valid) {
> +               pr_warn("%s: unable to support rate %lu, parent_rate: %lu=
\n",
> +                               clk_hw_get_name(hw), rate, parent_rate);
> +               return -EINVAL;
> +       }
> +
> +       val =3D readl(data->regs + PLLDIG_REG_PLLDV);
> +       val =3D mult;
> +       rfdphi1 =3D PLLDIG_SET_RFDPHI1(rfdphi1);
> +       val |=3D rfdphi1;
> +
> +       writel(val, data->regs + PLLDIG_REG_PLLDV);
> +
> +       return plldig_wait_lock(data);
> +}
> +
[...]
> +
> +struct clk_hw *_plldig_clk_init(const char *name, const char *parent_nam=
e,
> +                               void __iomem *regs)
> +{
> +       struct clk_plldig *plldig;
> +       struct clk_hw *hw;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       plldig =3D kzalloc(sizeof(*plldig), GFP_KERNEL);
> +       if (!plldig)
> +               return ERR_PTR(-ENOMEM);
> +
> +       plldig->regs =3D regs;
> +
> +       init.name =3D name;
> +       init.ops =3D &plldig_clk_ops;
> +       init.parent_names =3D &parent_name;
> +       init.num_parents =3D 1;
> +       init.flags =3D CLK_SET_RATE_GATE;
> +
> +       plldig->hw.init =3D &init;
> +
> +       hw =3D &plldig->hw;
> +       ret =3D clk_hw_register(NULL, hw);
> +       if (ret) {
> +               kfree(plldig);
> +               hw =3D ERR_PTR(ret);
> +       }
> +
> +       return hw;
> +}
> +
> +static void __init plldig_clk_init(struct device_node *node)
> +{
> +       struct clk_hw_onecell_data *clk_data;
> +       struct clk_hw **clks;
> +       void __iomem *base;
> +
> +       clk_data =3D kzalloc(struct_size(clk_data, hws, 1),
> +                       GFP_KERNEL);
> +       if (!clk_data)
> +               return;
> +
> +       clk_data->num =3D 1;
> +       clks =3D clk_data->hws;
> +
> +       base =3D of_iomap(node, 0);
> +       WARN_ON(!base);
> +
> +       clks[0] =3D _plldig_clk_init("pixel-clk",
> +                       of_clk_get_parent_name(node, 0), base);

Can you use the new way of specifying clk parents instead of calling
of_clk_get-parent_name() here? It would be simpler to just indicate
which index it is (I guess 0) or what the name is going to be in
"clock-names" in this DT node.

> +
> +       of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);

Why is this a #clock-cells =3D <1> device? It provides one clk, so
presumably it can be #clock-cells =3D <0> and then this can use
of_clk_hw_simple_get() instead.

> +}
> +
> +CLK_OF_DECLARE(plldig_clockgen, "fsl,ls1028a-plldig", plldig_clk_init);

IS there a reason why this can't be a platform driver? It would be nice
to use platform device APIs.

