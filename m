Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B838C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CEB23404
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566523621;
	bh=6xxjLORt0xPkzoEPUFXYG1cXQ+Y1cImnoe/SmkS0e2A=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=gcVpsTF0jDxL4K0P0JDVMKCbFhKuC5dRRFu/56iKA6D0QaI3/K1QqBEY0udEAkW/y
	 YZkS1LHyMIFlWi9BzAyfHfFVkbToltpTKqr/Y9WSzN/HUxYX+XC+/9/4VbYDFYhGMP
	 H9t8Jf5BRMRoayC3EdJSaiTqeSzE7Yqv92WBxJms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbfHWB1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730588AbfHWB1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 21:27:00 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB213233A2;
        Fri, 23 Aug 2019 01:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566523619;
        bh=6xxjLORt0xPkzoEPUFXYG1cXQ+Y1cImnoe/SmkS0e2A=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=kGwYtQdqH395GM0HbKE8VsJCZOKTZu6zUM6VgRDNti0j1IHOT5wNQbxkVQBX2VQMu
         CzpWRYUaBk/Q7U69KJRuVqd46FlAt4Yc/wbZwzhr5dc0z3RHTFfIjzY0mOORirKR2V
         9O7EeNYx5LhgTygYHhat9voOELeEJtOTaV9RJMLs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190822020847.10159-2-wen.he_1@nxp.com>
References: <20190822020847.10159-1-wen.he_1@nxp.com> <20190822020847.10159-2-wen.he_1@nxp.com>
Cc:     leoyang.li@nxp.com, liviu.dudau@arm.com, Wen He <wen.he_1@nxp.com>
Subject: Re: [v3 2/2] clk: ls1028a: Add clock driver for Display output interface
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Wen He <wen.he_1@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-devel@linux.nxdi.nxp.com, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 22 Aug 2019 18:26:58 -0700
Message-Id: <20190823012658.DB213233A2@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-08-21 19:08:47)
> Add clock driver for QorIQ LS1028A Display output interfaces(LCD, DPHY),
> as implemented in TSMC CLN28HPM PLL, this PLL supports the programmable
> integer division and range of the display output pixel clock's 27-594MHz.
>=20
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---
> change in v3:
>         - remove the OF dependency
>         - use clk_parent_data instead of parent_name
>=20
>  drivers/clk/Kconfig      |  10 ++
>  drivers/clk/Makefile     |   1 +
>  drivers/clk/clk-plldig.c | 283 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 294 insertions(+)
>  create mode 100644 drivers/clk/clk-plldig.c
>=20
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
> index 000000000000..c5ce80a46fd4
> --- /dev/null
> +++ b/drivers/clk/clk-plldig.c
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright 2019 NXP

Please leave this as C style /* */ comment for the NXP part, but comply
with the SPDX comment style of // on the first line.

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

This can return an error instead? In fact, you may want to use
determine_rate clk op instead.

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
> +       u32 rfdphi1 =3D 0, val, mult =3D 0, cond =3D 0;
> +       int ret =3D -ETIMEDOUT;
> +
> +       valid =3D plldig_is_valid_range(rate, parent_rate, &mult,
> +                                       &rfdphi1, &round_rate);
> +       if (!valid) {
> +               pr_warn("%s: unable to support rate %lu, parent_rate: %lu=
\n",
> +                               clk_hw_get_name(hw), rate, parent_rate);

Shouldn't determine_rate or round_rate make this impossible to hit in
practice? I mean that those ops should prevent the rate from being
rounded to such a frequency that it becomes invalid.

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
> +}
> +
> +static const struct clk_ops plldig_clk_ops =3D {
> +       .enable =3D plldig_enable,
> +       .disable =3D plldig_disable,
> +       .is_enabled =3D plldig_is_enabled,
> +       .recalc_rate =3D plldig_recalc_rate,
> +       .round_rate =3D plldig_round_rate,
> +       .set_rate =3D plldig_set_rate,
> +};
[...]
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
> +}
> +
> +static int plldig_clk_remove(struct platform_device *pdev)
> +{
> +       of_clk_del_provider(pdev->dev.of_node);

This isn't required. devm already does it.

> +       return 0;
> +}
> +
> +static const struct of_device_id plldig_clk_id[] =3D {
> +       { .compatible =3D "fsl,ls1028a-plldig", .data =3D NULL},

You can leave out the data assignment.

