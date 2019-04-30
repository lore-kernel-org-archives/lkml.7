Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF280C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEDB2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfD3UbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:31:24 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:56229 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfD3UbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:31:24 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 1589620047;
        Tue, 30 Apr 2019 22:31:10 +0200 (CEST)
Date:   Tue, 30 Apr 2019 22:31:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v9 2/2] phy: Add driver for mixel mipi dphy found on
 NXP's i.MX8 SoCs
Message-ID: <20190430203108.GA20545@ravnborg.org>
References: <cover.1556633413.git.agx@sigxcpu.org>
 <b999b07673e59c676d2e43a786b635beb056e9bf.1556633413.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b999b07673e59c676d2e43a786b635beb056e9bf.1556633413.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10
        a=PLGMnwU6pitjcMjhYOwA:9 a=QEXdDO2ut3YA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

Took a look at this, but feedback is trivial as
I have no experience with PHYs so use only
the feedback you consider relevant.

	Sam

> diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
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
> +
> +/* DPHY registers */
> +#define DPHY_PD_DPHY			0x00
> +#define DPHY_M_PRG_HS_PREPARE		0x04
> +#define DPHY_MC_PRG_HS_PREPARE		0x08
> +#define DPHY_M_PRG_HS_ZERO		0x0c
> +#define DPHY_MC_PRG_HS_ZERO		0x10
> +#define DPHY_M_PRG_HS_TRAIL		0x14
> +#define DPHY_MC_PRG_HS_TRAIL		0x18
> +#define DPHY_PD_PLL			0x1c
> +#define DPHY_TST			0x20
> +#define DPHY_CN				0x24
> +#define DPHY_CM				0x28
> +#define DPHY_CO				0x2c
> +#define DPHY_LOCK			0x30
> +#define DPHY_LOCK_BYP			0x34
> +#define DPHY_REG_BYPASS_PLL		0x4C
> +
> +#define MBPS(x) ((x) * 1000000)
> +
> +#define DATA_RATE_MAX_SPEED MBPS(1500)
> +#define DATA_RATE_MIN_SPEED MBPS(80)
> +
> +#define PLL_LOCK_SLEEP 10
> +#define PLL_LOCK_TIMEOUT 1000
> +
> +#define CN_BUF	0xcb7a89c0
> +#define CO_BUF	0x63
> +#define CM(x)	(				\
> +		((x) <	32)?0xe0|((x)-16) :	\
> +		((x) <	64)?0xc0|((x)-32) :	\
> +		((x) < 128)?0x80|((x)-64) :	\
> +		((x) - 128))
> +#define CN(x)	(((x) == 1)?0x1f : (((CN_BUF)>>((x)-1))&0x1f))
> +#define CO(x)	((CO_BUF)>>(8-(x))&0x3)
> +
> +/* PHY power on is active low */
> +#define PWR_ON	0
> +#define PWR_OFF	1
> +
> +enum mixel_dphy_devtype {
> +	MIXEL_IMX8MQ,
> +};
> +
> +struct mixel_dphy_devdata {
> +	u8 reg_tx_rcal;
> +	u8 reg_auto_pd_en;
> +	u8 reg_rxlprp;
> +	u8 reg_rxcdrp;
> +	u8 reg_rxhs_settle;
> +};
> +
> +static const struct mixel_dphy_devdata mixel_dphy_devdata[] = {
> +	[MIXEL_IMX8MQ] = {
> +		.reg_tx_rcal = 0x38,
> +		.reg_auto_pd_en = 0x3c,
> +		.reg_rxlprp = 0x40,
> +		.reg_rxcdrp = 0x44,
> +		.reg_rxhs_settle = 0x48,
> +	},
> +};
> +
> +struct mixel_dphy_cfg {
> +	/* DPHY PLL parameters */
> +	u32 cm;
> +	u32 cn;
> +	u32 co;
> +	/* DPHY register values */
> +	u8 mc_prg_hs_prepare;
> +	u8 m_prg_hs_prepare;
> +	u8 mc_prg_hs_zero;
> +	u8 m_prg_hs_zero;
> +	u8 mc_prg_hs_trail;
> +	u8 m_prg_hs_trail;
> +	u8 rxhs_settle;
> +};
> +
> +struct mixel_dphy_priv {
> +	struct mixel_dphy_cfg cfg;
> +	struct regmap *regs;
It is a little confusing that the regmap is named regs.
As regs in many other cases is used as name for the variable
with pointer to registers.
See for example call to devm_regmap_init_mmio()

> +	struct clk *phy_ref_clk;
> +	const struct mixel_dphy_devdata *devdata;
> +};
> +
> +static const struct regmap_config mixel_dphy_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = DPHY_REG_BYPASS_PLL,
> +	.name = "mipi-dphy",
> +};
> +
> +static int phy_write(struct phy *phy, u32 value, unsigned int reg)
> +{
> +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = regmap_write(priv->regs, reg, value);
> +	if (ret < 0)
> +		dev_err(&phy->dev, "Failed to write DPHY reg %d: %d", reg, ret);
> +	return ret;
> +}
> +
> +/*
> + * Find a ratio close to the desired one using continued fraction
> + * approximation ending either at exact match or maximum allowed
> + * nominator, denominator.
> + */
> +static void get_best_ratio(u32 *pnum, u32 *pdenom, unsigned int max_n,
> +			   unsigned int max_d)
> +{
Maybe use u32 for all parameters?
That would also match usage below.

> +	u32 a = *pnum;
> +	u32 b = *pdenom;
> +	u32 c;
> +	u32 n[] = {0, 1};
> +	u32 d[] = {1, 0};
> +	u32 whole;
> +	unsigned int i = 1;
> +
> +	while (b) {
> +		i ^= 1;
> +		whole = a / b;
> +		n[i] += (n[i ^ 1] * whole);
> +		d[i] += (d[i ^ 1] * whole);
> +		if ((n[i] > max_n) || (d[i] > max_d)) {
> +			i ^= 1;
> +			break;
> +		}
> +		c = a - (b * whole);
> +		a = b;
> +		b = c;
> +	}
> +	*pnum = n[i];
> +	*pdenom = d[i];
> +}
> +
> +static int mixel_dphy_config_from_opts(struct phy *phy,
> +	       struct phy_configure_opts_mipi_dphy *dphy_opts,
> +	       struct mixel_dphy_cfg *cfg)
> +{
> +	struct mixel_dphy_priv *priv = dev_get_drvdata(phy->dev.parent);
> +	unsigned long ref_clk = clk_get_rate(priv->phy_ref_clk);
> +	u32 lp_t, numerator, denominator;
> +	unsigned long long tmp;
> +	u32 n;
> +	int i;
> +
> +	if (dphy_opts->hs_clk_rate > DATA_RATE_MAX_SPEED ||
> +	    dphy_opts->hs_clk_rate < DATA_RATE_MIN_SPEED)
> +		return -EINVAL;
> +
> +	numerator = dphy_opts->hs_clk_rate;
> +	denominator = ref_clk;
> +	get_best_ratio(&numerator, &denominator, 255, 256);
> +	if (!numerator || !denominator) {
> +		dev_err(&phy->dev, "Invalid %d/%d for %ld/%ld\n",
> +			numerator, denominator,
> +			dphy_opts->hs_clk_rate, ref_clk);
> +		return -EINVAL;
> +	}
> +
> +	while ((numerator < 16) && (denominator <= 128)) {
> +		numerator <<= 1;
> +		denominator <<= 1;
> +	}
> +	/*
> +	 * CM ranges between 16 and 255
> +	 * CN ranges between 1 and 32
> +	 * CO is power of 2: 1, 2, 4, 8
> +	 */
> +	i = __ffs(denominator);
> +	if (i > 3)
> +		i = 3;
> +	cfg->cn = denominator >> i;
> +	cfg->co = 1 << i;
> +	cfg->cm = numerator;
> +
> +	if (cfg->cm < 16 || cfg->cm > 255 ||
> +	    cfg->cn < 1 || cfg->cn > 32 ||
> +	    cfg->co < 1 || cfg->co > 8) {
> +		dev_err(&phy->dev, "Invalid CM/CN/CO values: %u/%u/%u\n",
> +			cfg->cm, cfg->cn, cfg->co);
> +		dev_err(&phy->dev, "for hs_clk/ref_clk=%ld/%ld ⩰ %d/%d\n",
Hmm, my mutt does not like this symbol?  ⩰ 

> +
> +	phy_write(phy, PWR_ON, DPHY_PD_PLL);
> +	ret = regmap_read_poll_timeout(priv->regs, DPHY_LOCK, locked,
> +				       locked, PLL_LOCK_SLEEP,
> +				       PLL_LOCK_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(&phy->dev, "Could not get DPHY lock (%d)!\n", ret);
> +		goto clock_disable;
> +	}
> +	phy_write(phy, PWR_ON, DPHY_PD_DPHY);

Are then no other timing constrains than the poll of DPHY_LOCK?
Some panel (I know this is not a panel, but amyway) have some
ridgid timing constrains around power ON/OFF.

> +
> +MODULE_AUTHOR("NXP Semiconductor");
> +MODULE_DESCRIPTION("Mixel MIPI-DSI PHY driver");

> +MODULE_LICENSE("GPL v2");
Does this match the SPDX tag?

"
> +// SPDX-License-Identifier: GPL-2.0+
"
