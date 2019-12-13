Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BA9C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC599206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="gDh44XmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfLMAGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:06:21 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:54235 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbfLMAGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:06:21 -0500
Received: from [IPv6:2a02:810c:c200:2e91:786c:367:d9ef:ed17] (unknown [IPv6:2a02:810c:c200:2e91:786c:367:d9ef:ed17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CA77023066;
        Fri, 13 Dec 2019 01:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1576195577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AhZSlJyXrcA/f9Kc9fKwG7AScAYIXvFzLT9JK5eAq58=;
        b=gDh44XmNZ8NHwcZact/6eA2LBcKGwvCOKk2/JyK4eHyUZhWXhpHqDjxyirr46bJDWP6omU
        ejsYGTv915Da5BB/CRBhgkVp6ZRpkoiJou+dHFRlqqvpfmobpy73ykhh26zBm8kq+t44Ol
        3nPR7A+rU47D3FxUHeql1n0xY+MFTgo=
Date:   Fri, 13 Dec 2019 01:06:16 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20191212221817.B7FF1206DA@mail.kernel.org>
References: <20191205072653.34701-1-wen.he_1@nxp.com> <20191205072653.34701-2-wen.he_1@nxp.com> <20191212221817.B7FF1206DA@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [v11 2/2] clk: ls1028a: Add clock driver for Display output interface
To:     Stephen Boyd <sboyd@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Wen He <wen.he_1@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Michael Walle <michael@walle.cc>
Message-ID: <F2C21019-79F4-450F-A575-9621E5747C4E@walle.cc>
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: CA77023066
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         NEURAL_HAM(-0.00)[-0.323];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12=2E Dezember 2019 23:18:16 MEZ schrieb Stephen Boyd <sboyd@kernel=2Eor=
g>:
>Quoting Wen He (2019-12-04 23:26:53)
>> Add clock driver for QorIQ LS1028A Display output interfaces(LCD,
>DPHY),
>> as implemented in TSMC CLN28HPM PLL, this PLL supports the
>programmable
>> integer division and range of the display output pixel clock's
>27-594MHz=2E
>>=20
>> Signed-off-by: Wen He <wen=2Ehe_1@nxp=2Ecom>
>> Signed-off-by: Michael Walle <michael@walle=2Ecc>
>
>Is Michael the author? SoB chain is backwards here=2E

the original driver was from Wen=2E I've just supplied some code and
the vco frequency stuff=2E so its basically a sob of us both=2E=20

-michael=20

>
>> diff --git a/drivers/clk/clk-plldig=2Ec b/drivers/clk/clk-plldig=2Ec
>> new file mode 100644
>> index 000000000000=2E=2E1942686f0254
>> --- /dev/null
>> +++ b/drivers/clk/clk-plldig=2Ec
>> @@ -0,0 +1,297 @@
>> +// SPDX-License-Identifier: GPL-2=2E0
>> +/*
>> + * Copyright 2019 NXP
>> + *
>> + * Clock driver for LS1028A Display output interfaces(LCD, DPHY)=2E
>> + */
>> +
>> +#include <linux/clk-provider=2Eh>
>> +#include <linux/device=2Eh>
>> +#include <linux/module=2Eh>
>> +#include <linux/err=2Eh>
>> +#include <linux/io=2Eh>
>> +#include <linux/iopoll=2Eh>
>> +#include <linux/of=2Eh>
>> +#include <linux/of_address=2Eh>
>> +#include <linux/of_device=2Eh>
>> +#include <linux/platform_device=2Eh>
>> +#include <linux/slab=2Eh>
>> +#include <linux/bitfield=2Eh>
>> +
>> +/* PLLDIG register offsets and bit masks */
>> +#define PLLDIG_REG_PLLSR            0x24
>> +#define PLLDIG_LOCK_MASK            BIT(2)
>> +#define PLLDIG_REG_PLLDV            0x28
>> +#define PLLDIG_MFD_MASK             GENMASK(7, 0)
>> +#define PLLDIG_RFDPHI1_MASK         GENMASK(30, 25)
>> +#define PLLDIG_REG_PLLFM            0x2c
>> +#define PLLDIG_SSCGBYP_ENABLE       BIT(30)
>> +#define PLLDIG_REG_PLLFD            0x30
>> +#define PLLDIG_FDEN                 BIT(30)
>> +#define PLLDIG_FRAC_MASK            GENMASK(15, 0)
>> +#define PLLDIG_REG_PLLCAL1          0x38
>> +#define PLLDIG_REG_PLLCAL2          0x3c
>> +
>> +/* Range of the VCO frequencies, in Hz */
>> +#define PLLDIG_MIN_VCO_FREQ         650000000
>> +#define PLLDIG_MAX_VCO_FREQ         1300000000
>> +
>> +/* Range of the output frequencies, in Hz */
>> +#define PHI1_MIN_FREQ               27000000
>> +#define PHI1_MAX_FREQ               600000000
>> +
>> +/* Maximum value of the reduced frequency divider */
>> +#define MAX_RFDPHI1          63UL
>> +
>> +/* Best value of multiplication factor divider */
>> +#define PLLDIG_DEFAULT_MFD   44
>> +
>> +/*
>> + * Denominator part of the fractional part of the
>> + * loop multiplication factor=2E
>> + */
>> +#define MFDEN          20480
>> +
>> +static const struct clk_parent_data parent_data[] =3D {
>> +       {=2Eindex =3D 0},
>
>Nitpick: Add spaces after { and before }
>
>> +};
>> +
>> +struct clk_plldig {
>> +       struct clk_hw hw;
>> +       void __iomem *regs;
>> +       unsigned int vco_freq;
>> +};
>> +
>> +#define to_clk_plldig(_hw)     container_of(_hw, struct clk_plldig,
>hw)
>> +
>> +static int plldig_enable(struct clk_hw *hw)
>> +{
>> +       struct clk_plldig *data =3D to_clk_plldig(hw);
>> +       u32 val;
>> +
>> +       val =3D readl(data->regs + PLLDIG_REG_PLLFM);
>> +       /*
>> +        * Use Bypass mode with PLL off by default, the frequency
>overshoot
>> +        * detector output was disable=2E SSCG Bypass mode should be
>enable=2E
>> +        */
>> +       val |=3D PLLDIG_SSCGBYP_ENABLE;
>> +       writel(val, data->regs + PLLDIG_REG_PLLFM);
>> +
>> +       return 0;
>> +}
>> +
>> +static void plldig_disable(struct clk_hw *hw)
>> +{
>> +       struct clk_plldig *data =3D to_clk_plldig(hw);
>> +       u32 val;
>> +
>> +       val =3D readl(data->regs + PLLDIG_REG_PLLFM);
>> +
>> +       val &=3D ~PLLDIG_SSCGBYP_ENABLE;
>> +       val |=3D FIELD_PREP(PLLDIG_SSCGBYP_ENABLE, 0x0);
>> +
>> +       writel(val, data->regs + PLLDIG_REG_PLLFM);
>> +}
>> +
>> +static int plldig_is_enabled(struct clk_hw *hw)
>> +{
>> +       struct clk_plldig *data =3D to_clk_plldig(hw);
>> +
>> +       return (readl(data->regs + PLLDIG_REG_PLLFM) &
>
>Please drop useless parenthesis=2E
>
>> +                             PLLDIG_SSCGBYP_ENABLE);
>> +}
>> +
>> +static unsigned long plldig_recalc_rate(struct clk_hw *hw,
>> +                                       unsigned long parent_rate)
>> +{
>> +       struct clk_plldig *data =3D to_clk_plldig(hw);
>> +       u32 val, rfdphi1;
>> +
>> +       val =3D readl(data->regs + PLLDIG_REG_PLLDV);
>> +
>> +       /* Check if PLL is bypassed */
>> +       if (val & PLLDIG_SSCGBYP_ENABLE)
>> +               return parent_rate;
>> +
>> +       rfdphi1 =3D FIELD_GET(PLLDIG_RFDPHI1_MASK, val);
>> +
>> +       /*
>> +        * If RFDPHI1 has a value of 1 the VCO frequency is also
>divided by
>> +        * one=2E
>> +        */
>> +       if (!rfdphi1)
>> +               rfdphi1 =3D 1;
>> +
>> +       return DIV_ROUND_UP(data->vco_freq, rfdphi1);
>> +}
>> +
>> +static unsigned long plldig_calc_target_div(unsigned long vco_freq,
>> +                                           unsigned long
>target_rate)
>> +{
>> +       unsigned long div;
>> +
>> +       div =3D DIV_ROUND_CLOSEST(vco_freq, target_rate);
>> +       div =3D max(1UL, div);
>> +       div =3D min(div, MAX_RFDPHI1);
>
>Use clamp()=2E
>
>> +
>> +       return div;
>> +}
>> +
>> +static int plldig_determine_rate(struct clk_hw *hw,
>> +                                struct clk_rate_request *req)
>> +{
>> +       struct clk_plldig *data =3D to_clk_plldig(hw);
>> +       unsigned int div;
>> +
>> +       if (req->rate < PHI1_MIN_FREQ)
>> +               req->rate =3D PHI1_MIN_FREQ;
>> +       if (req->rate > PHI1_MAX_FREQ)
>> +               req->rate =3D PHI1_MAX_FREQ;
>
>Use clamp()
>
>> +
>> +       div =3D plldig_calc_target_div(data->vco_freq, req->rate);
>> +       req->rate =3D DIV_ROUND_UP(data->vco_freq, div);
>> +
>> +       return 0;
>> +}
>> +
>> +static int plldig_set_rate(struct clk_hw *hw, unsigned long rate,
>> +               unsigned long parent_rate)
>> +{
>> +       struct clk_plldig *data =3D to_clk_plldig(hw);
>> +       unsigned int val, cond;
>> +       unsigned int rfdphi1;
>> +
>> +       if (rate < PHI1_MIN_FREQ)
>> +               rate =3D PHI1_MIN_FREQ;
>> +       if (rate > PHI1_MAX_FREQ)
>> +               rate =3D PHI1_MAX_FREQ;
>
>Use clamp()
>
>> +
>> +       rfdphi1 =3D plldig_calc_target_div(data->vco_freq, rate);
>> +
>> +       /* update the divider value */
>> +       val =3D readl(data->regs + PLLDIG_REG_PLLDV);
>> +       val &=3D ~PLLDIG_RFDPHI1_MASK;
>> +       val |=3D FIELD_PREP(PLLDIG_RFDPHI1_MASK, rfdphi1);
>> +       writel(val, data->regs + PLLDIG_REG_PLLDV);
>> +
>> +       /* delay 200us make sure that old lock state is cleared */
>> +       udelay(200);
>
>Please remove 'delay 200us' from the comment=2E Just say that we're
>waiting
>for old lock state to clear=2E It's clear from the code how much time it
>is=2E
>
>> +
>> +       /* Wait until PLL is locked or timeout (maximum 1000 usecs)
>*/
>
>Drop the time=2E It's a millisecond=2E
>
>> +       return readl_poll_timeout_atomic(data->regs +
>PLLDIG_REG_PLLSR, cond,
>> +                                        cond & PLLDIG_LOCK_MASK, 0,
>> +                                        USEC_PER_MSEC);
>> +}
>> +
>> +static const struct clk_ops plldig_clk_ops =3D {
>> +       =2Eenable =3D plldig_enable,
>> +       =2Edisable =3D plldig_disable,
>> +       =2Eis_enabled =3D plldig_is_enabled,
>> +       =2Erecalc_rate =3D plldig_recalc_rate,
>> +       =2Edetermine_rate =3D plldig_determine_rate,
>> +       =2Eset_rate =3D plldig_set_rate,
>> +};
>> +
>> +static int plldig_init(struct clk_hw *hw)
>> +{
>> +       struct clk_plldig *data =3D to_clk_plldig(hw);
>> +       struct clk_hw *parent =3D clk_hw_get_parent(hw);
>> +       unsigned long parent_rate =3D clk_hw_get_rate(parent);
>> +       unsigned long val;
>> +       unsigned long long lltmp;
>> +       unsigned int mfd, fracdiv =3D 0;
>> +
>> +       if (!parent)
>> +               return -EINVAL;
>> +
>> +       if (data->vco_freq) {
>> +               mfd =3D data->vco_freq / parent_rate;
>> +               lltmp =3D data->vco_freq % parent_rate;
>> +               lltmp *=3D MFDEN;
>> +               do_div(lltmp, parent_rate);
>> +               fracdiv =3D lltmp;
>> +       } else {
>> +               mfd =3D PLLDIG_DEFAULT_MFD;
>> +               data->vco_freq =3D parent_rate * mfd;
>> +       }
>> +
>> +       val =3D FIELD_PREP(PLLDIG_MFD_MASK, mfd);
>> +       writel(val, data->regs + PLLDIG_REG_PLLDV);
>> +
>> +       if (fracdiv) {
>> +               val =3D FIELD_PREP(PLLDIG_FRAC_MASK, fracdiv);
>> +               /* Enable fractional divider */
>
>Remove useless comment please=2E Or move above the if condition=2E
>
>> +               val |=3D PLLDIG_FDEN;
>> +               writel(val, data->regs + PLLDIG_REG_PLLFD);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int plldig_clk_probe(struct platform_device *pdev)
>> +{
>> +       struct clk_plldig *data;
>> +       struct resource *mem;
>> +       struct device *dev =3D &pdev->dev;
>> +       int ret;
>> +
>> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +       if (!data)
>> +               return -ENOMEM;
>> +
>> +       mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       data->regs =3D devm_ioremap_resource(dev, mem);
>
>We have devm_platform_ioremap_resource() for this now=2E
>
>> +       if (IS_ERR(data->regs))
>> +               return PTR_ERR(data->regs);
>> +
>> +       data->hw=2Einit =3D CLK_HW_INIT_PARENTS_DATA("dpclk",
>> +                                                parent_data,
>> +                                                &plldig_clk_ops,
>> +                                                0);
>> +
>> +       ret =3D devm_clk_hw_register(dev, &data->hw);
>> +       if (ret) {
>> +               dev_err(dev, "failed to register %s clock\n",
>> +                                               dev->of_node->name);
>> +               return ret;
>> +       }
>> +
>> +       ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
>> +                                         &data->hw);
>> +       if (ret) {
>> +               dev_err(dev, "unable to add clk provider\n");
>> +               return ret;
>> +       }
>> +
>> +       /*
>> +        * The frequency of the VCO cannot be changed during runtime=2E
>> +        * Therefore, let the user specify a desired frequency=2E
>> +        */
>> +       if (!of_property_read_u32(dev->of_node, "fsl,vco-hz",
>> +                                 &data->vco_freq)) {
>> +               if (data->vco_freq < PLLDIG_MIN_VCO_FREQ ||
>> +                   data->vco_freq > PLLDIG_MAX_VCO_FREQ)
>> +                       return -EINVAL;
>> +       }
>> +
>> +       return plldig_init(&data->hw);
>> +}
>> +
>> +static const struct of_device_id plldig_clk_id[] =3D {
>> +       { =2Ecompatible =3D "fsl,ls1028a-plldig"},
>
>Nitpick: Add a space before }
>
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, plldig_clk_id);
>> +

