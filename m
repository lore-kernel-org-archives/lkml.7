Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B5EC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEC721D80
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439149AbfIYQAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:00:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42579 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbfIYQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:00:04 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iD9hu-0004J7-Op; Wed, 25 Sep 2019 17:59:58 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iD9ht-0007QO-TZ; Wed, 25 Sep 2019 17:59:57 +0200
Date:   Wed, 25 Sep 2019 17:59:57 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] regulator: da9062: add voltage selection gpio support
Message-ID: <20190925155957.de6odahy2ebhzx5c@pengutronix.de>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-4-m.felsch@pengutronix.de>
 <AM5PR1001MB099431ECB45A103A22646CB680840@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB099431ECB45A103A22646CB680840@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:51:58 up 130 days, 22:10, 84 users,  load average: 0.10, 0.04,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 19-09-24 09:48, Adam Thomson wrote:
> On 17 September 2019 13:43, Marco Felsch wrote:
> 
> > The DA9062/1 devices can switch their regulator voltages between
> > voltage-A (active) and voltage-B (suspend) settings. Switching the
> > voltages can be controlled by ther internal state-machine or by a gpio
> > input signal and can be configured for each individual regulator. This
> > commit adds the gpio-based voltage switching support.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/regulator/da9062-regulator.c | 149 +++++++++++++++++++++++++++
> >  1 file changed, 149 insertions(+)
> > 
> > diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-
> > regulator.c
> > index 9b2ca472f70c..9d6eb7625948 100644
> > --- a/drivers/regulator/da9062-regulator.c
> > +++ b/drivers/regulator/da9062-regulator.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/err.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/slab.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> > @@ -15,6 +16,7 @@
> >  #include <linux/regulator/machine.h>
> >  #include <linux/regulator/of_regulator.h>
> >  #include <linux/mfd/da9062/core.h>
> > +#include <linux/mfd/da9062/gpio.h>
> >  #include <linux/mfd/da9062/registers.h>
> > 
> >  /* Regulator IDs */
> > @@ -50,6 +52,7 @@ struct da9062_regulator_info {
> >  	struct reg_field sleep;
> >  	struct reg_field suspend_sleep;
> >  	unsigned int suspend_vsel_reg;
> > +	struct reg_field vsel_gpi;
> >  	/* Event detection bit */
> >  	struct reg_field oc_event;
> >  };
> > @@ -65,6 +68,7 @@ struct da9062_regulator {
> >  	struct regmap_field			*suspend;
> >  	struct regmap_field			*sleep;
> >  	struct regmap_field			*suspend_sleep;
> > +	struct regmap_field			*vsel_gpi;
> >  };
> > 
> >  /* Encapsulates all information for the regulators driver */
> > @@ -351,6 +355,65 @@ static const struct regulator_ops da9062_ldo_ops = {
> >  	.set_suspend_mode	= da9062_ldo_set_suspend_mode,
> >  };
> > 
> > +static int da9062_config_gpi(struct device_node *np,
> > +			     const struct regulator_desc *desc,
> > +			     struct regulator_config *cfg, const char *gpi_id)
> > +{
> > +	struct da9062_regulator *regl = cfg->driver_data;
> > +	struct gpio_desc *gpi;
> > +	unsigned int nr;
> > +	int ret;
> > +	char *prop, *label;
> > +
> > +	prop = kasprintf(GFP_KERNEL, "dlg,%s-sense-gpios", gpi_id);
> > +	if (!prop)
> > +		return -ENOMEM;
> > +	label = kasprintf(GFP_KERNEL, "%s-%s-gpi", desc->name, gpi_id);
> > +	if (!label) {
> > +		ret = -ENOMEM;
> > +		goto free;
> 
> If we use the generic bindings names then the above will change I guess.

Yes.

> > +	}
> > +
> > +	/*
> > +	 * We only must ensure that the gpio device is probed before the
> > +	 * regulator driver so no need to store the reference global. Luckily
> > +	 * devm_* releases the gpio upon a unbound action.
> > +	 */
> > +	gpi = devm_gpiod_get_from_of_node(cfg->dev, np, prop, 0, GPIOD_IN |
> > +					  GPIOD_FLAGS_BIT_NONEXCLUSIVE,
> > label);
> > +	if (IS_ERR(gpi)) {
> > +		ret = PTR_ERR(gpi);
> > +		goto free;
> > +	}
> > +
> > +	if (!gpi) {
> > +		ret = 0;
> > +		goto free;
> > +	}
> > +
> > +	/* We need the local number */
> > +	nr = da9062_gpio_get_hwgpio(gpi);
> > +	if (nr < 1 || nr > 3) {
> > +		ret = -EINVAL;
> > +		goto free;
> > +	}
> > +
> > +	ret = regmap_field_write(regl->vsel_gpi, nr);
> 
> Actually thinking about this some more, should we really be setting alternate
> functions of the GPIO here? Would this not be done through GPIO/Pinmux
> frameworks? That way the GPIO would be blocked off from other's requesting it.
> This seems a little unsafe, unless I'm mistaken.

The GPIO is used as input, see the flags I passed to
devm_gpiod_get_from_of_node(). What I did here is to tell the regulator
to listen to the gpio input instead of the sequencer. But as I said the
gpio is still configured as input which is absolutly correct. Please
check [1] chapter 7.7.1

[1] https://www.dialog-semiconductor.com/sites/default/files/da9062-a_datasheet_2v3.pdf

Regards,
  Marco

> > +
> > +free:
> > +	kfree(prop);
> > +	kfree(label);
> > +
> > +	return ret;
> > +}
> > +
> > +static int da9062_parse_dt(struct device_node *np,
> > +			   const struct regulator_desc *desc,
> > +			   struct regulator_config *cfg)
> > +{
> > +	return da9062_config_gpi(np, desc, cfg, "vsel");
> > +}
> > +
> >  /* DA9061 Regulator information */
> >  static const struct da9062_regulator_info local_da9061_regulator_info[] = {
> >  	{
> > @@ -358,6 +421,7 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  		.desc.name = "DA9061 BUCK1",
> >  		.desc.of_match = of_match_ptr("buck1"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_buck_ops,
> >  		.desc.min_uV = (300) * 1000,
> >  		.desc.uV_step = (10) * 1000,
> > @@ -388,12 +452,17 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_BUCK1_CONT,
> > +			__builtin_ffs((int)DA9062AA_VBUCK1_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VBUCK1_GPI_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9061_ID_BUCK2,
> >  		.desc.name = "DA9061 BUCK2",
> >  		.desc.of_match = of_match_ptr("buck2"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_buck_ops,
> >  		.desc.min_uV = (800) * 1000,
> >  		.desc.uV_step = (20) * 1000,
> > @@ -424,12 +493,17 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_BUCK3_CONT,
> > +			__builtin_ffs((int)DA9062AA_VBUCK3_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VBUCK3_GPI_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9061_ID_BUCK3,
> >  		.desc.name = "DA9061 BUCK3",
> >  		.desc.of_match = of_match_ptr("buck3"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_buck_ops,
> >  		.desc.min_uV = (530) * 1000,
> >  		.desc.uV_step = (10) * 1000,
> > @@ -460,12 +534,17 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_BUCK4_CONT,
> > +			__builtin_ffs((int)DA9062AA_VBUCK4_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VBUCK4_GPI_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9061_ID_LDO1,
> >  		.desc.name = "DA9061 LDO1",
> >  		.desc.of_match = of_match_ptr("ldo1"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_ldo_ops,
> >  		.desc.min_uV = (900) * 1000,
> >  		.desc.uV_step = (50) * 1000,
> > @@ -489,6 +568,10 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_LDO1_CONT,
> > +			__builtin_ffs((int)DA9062AA_VLDO1_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VLDO1_GPI_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -499,6 +582,7 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  		.desc.name = "DA9061 LDO2",
> >  		.desc.of_match = of_match_ptr("ldo2"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_ldo_ops,
> >  		.desc.min_uV = (900) * 1000,
> >  		.desc.uV_step = (50) * 1000,
> > @@ -522,6 +606,10 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_LDO2_CONT,
> > +			__builtin_ffs((int)DA9062AA_VLDO2_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VLDO2_GPI_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -532,6 +620,7 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  		.desc.name = "DA9061 LDO3",
> >  		.desc.of_match = of_match_ptr("ldo3"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_ldo_ops,
> >  		.desc.min_uV = (900) * 1000,
> >  		.desc.uV_step = (50) * 1000,
> > @@ -555,6 +644,10 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_LDO3_CONT,
> > +			__builtin_ffs((int)DA9062AA_VLDO3_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VLDO3_GPI_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -565,6 +658,7 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  		.desc.name = "DA9061 LDO4",
> >  		.desc.of_match = of_match_ptr("ldo4"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_ldo_ops,
> >  		.desc.min_uV = (900) * 1000,
> >  		.desc.uV_step = (50) * 1000,
> > @@ -588,6 +682,10 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_LDO4_CONT,
> > +			__builtin_ffs((int)DA9062AA_VLDO4_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VLDO4_GPI_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -602,6 +700,7 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  		.desc.name = "DA9062 BUCK1",
> >  		.desc.of_match = of_match_ptr("buck1"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_buck_ops,
> >  		.desc.min_uV = (300) * 1000,
> >  		.desc.uV_step = (10) * 1000,
> > @@ -632,12 +731,17 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_BUCK1_CONT,
> > +			__builtin_ffs((int)DA9062AA_VBUCK1_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VBUCK1_GPI_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9062_ID_BUCK2,
> >  		.desc.name = "DA9062 BUCK2",
> >  		.desc.of_match = of_match_ptr("buck2"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_buck_ops,
> >  		.desc.min_uV = (300) * 1000,
> >  		.desc.uV_step = (10) * 1000,
> > @@ -668,12 +772,17 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK2_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_BUCK2_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_BUCK2_CONT,
> > +			__builtin_ffs((int)DA9062AA_VBUCK2_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VBUCK2_GPI_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9062_ID_BUCK3,
> >  		.desc.name = "DA9062 BUCK3",
> >  		.desc.of_match = of_match_ptr("buck3"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_buck_ops,
> >  		.desc.min_uV = (800) * 1000,
> >  		.desc.uV_step = (20) * 1000,
> > @@ -704,12 +813,17 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_BUCK3_CONT,
> > +			__builtin_ffs((int)DA9062AA_VBUCK3_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VBUCK3_GPI_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9062_ID_BUCK4,
> >  		.desc.name = "DA9062 BUCK4",
> >  		.desc.of_match = of_match_ptr("buck4"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_buck_ops,
> >  		.desc.min_uV = (530) * 1000,
> >  		.desc.uV_step = (10) * 1000,
> > @@ -740,12 +854,17 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_BUCK4_CONT,
> > +			__builtin_ffs((int)DA9062AA_VBUCK4_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VBUCK4_GPI_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9062_ID_LDO1,
> >  		.desc.name = "DA9062 LDO1",
> >  		.desc.of_match = of_match_ptr("ldo1"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_ldo_ops,
> >  		.desc.min_uV = (900) * 1000,
> >  		.desc.uV_step = (50) * 1000,
> > @@ -769,6 +888,10 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_LDO1_CONT,
> > +			__builtin_ffs((int)DA9062AA_VLDO1_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VLDO1_GPI_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -779,6 +902,7 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  		.desc.name = "DA9062 LDO2",
> >  		.desc.of_match = of_match_ptr("ldo2"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_ldo_ops,
> >  		.desc.min_uV = (900) * 1000,
> >  		.desc.uV_step = (50) * 1000,
> > @@ -802,6 +926,10 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_LDO2_CONT,
> > +			__builtin_ffs((int)DA9062AA_VLDO2_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VLDO2_GPI_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -812,6 +940,7 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  		.desc.name = "DA9062 LDO3",
> >  		.desc.of_match = of_match_ptr("ldo3"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_ldo_ops,
> >  		.desc.min_uV = (900) * 1000,
> >  		.desc.uV_step = (50) * 1000,
> > @@ -835,6 +964,10 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_LDO3_CONT,
> > +			__builtin_ffs((int)DA9062AA_VLDO3_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VLDO3_GPI_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -845,6 +978,7 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  		.desc.name = "DA9062 LDO4",
> >  		.desc.of_match = of_match_ptr("ldo4"),
> >  		.desc.regulators_node = of_match_ptr("regulators"),
> > +		.desc.of_parse_cb = da9062_parse_dt,
> >  		.desc.ops = &da9062_ldo_ops,
> >  		.desc.min_uV = (900) * 1000,
> >  		.desc.uV_step = (50) * 1000,
> > @@ -868,6 +1002,10 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
> > +		.vsel_gpi = REG_FIELD(DA9062AA_LDO4_CONT,
> > +			__builtin_ffs((int)DA9062AA_VLDO4_GPI_MASK) - 1,
> > +			sizeof(unsigned int) * 8 -
> > +			__builtin_clz(DA9062AA_VLDO4_GPI_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -988,6 +1126,15 @@ static int da9062_regulator_probe(struct
> > platform_device *pdev)
> >  				return PTR_ERR(regl->suspend_sleep);
> >  		}
> > 
> > +		if (regl->info->vsel_gpi.reg) {
> > +			regl->vsel_gpi = devm_regmap_field_alloc(
> > +					&pdev->dev,
> > +					chip->regmap,
> > +					regl->info->vsel_gpi);
> > +			if (IS_ERR(regl->vsel_gpi))
> > +				return PTR_ERR(regl->vsel_gpi);
> > +		}
> > +
> >  		/* Register regulator */
> >  		memset(&config, 0, sizeof(config));
> >  		config.dev = chip->dev;
> > @@ -997,6 +1144,8 @@ static int da9062_regulator_probe(struct
> > platform_device *pdev)
> >  		regl->rdev = devm_regulator_register(&pdev->dev, &regl->desc,
> >  						     &config);
> >  		if (IS_ERR(regl->rdev)) {
> > +			if (PTR_ERR(regl->rdev) == -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> >  			dev_err(&pdev->dev,
> >  				"Failed to register %s regulator\n",
> >  				regl->desc.name);
> > --
> > 2.20.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
