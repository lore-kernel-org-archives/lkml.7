Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D958FC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF9220B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407389AbfHIPZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:25:17 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:39444 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHIPZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:25:17 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B1527803BE;
        Fri,  9 Aug 2019 17:25:11 +0200 (CEST)
Date:   Fri, 9 Aug 2019 17:25:10 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bogdan Togorean <bogdan.togorean@analog.com>
Cc:     dri-devel@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org,
        allison@lohutok.net, tglx@linutronix.de, matt.redfearn@thinci.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm: bridge: adv7511: Add support for ADV7535
Message-ID: <20190809152510.GA23265@ravnborg.org>
References: <20190809141611.9927-1-bogdan.togorean@analog.com>
 <20190809141611.9927-3-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809141611.9927-3-bogdan.togorean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=mACkeoi2Hy_AJo-pb_YA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bogdan.

This patch triggered a few general comments.

> --- a/drivers/gpu/drm/bridge/adv7511/Makefile
> +++ b/drivers/gpu/drm/bridge/adv7511/Makefile
> @@ -2,5 +2,5 @@
>  adv7511-y := adv7511_drv.o
>  adv7511-$(CONFIG_DRM_I2C_ADV7511_AUDIO) += adv7511_audio.o
>  adv7511-$(CONFIG_DRM_I2C_ADV7511_CEC) += adv7511_cec.o
> -adv7511-$(CONFIG_DRM_I2C_ADV7533) += adv7533.o
> +adv7511-$(CONFIG_DRM_I2C_ADV753x) += adv7533.o
>  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511.o
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> index 52b2adfdc877..38288c3c3c53 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> @@ -91,6 +91,7 @@
>  #define ADV7511_REG_ARC_CTRL			0xdf
>  #define ADV7511_REG_CEC_I2C_ADDR		0xe1
>  #define ADV7511_REG_CEC_CTRL			0xe2
> +#define ADV7511_REG_SUPPLY_SELECT		0xe4
>  #define ADV7511_REG_CHIP_ID_HIGH		0xf5
>  #define ADV7511_REG_CHIP_ID_LOW			0xf6
>  
> @@ -320,6 +321,7 @@ struct adv7511_video_config {
>  enum adv7511_type {
>  	ADV7511,
>  	ADV7533,
> +	ADV7535,
>  };
>  
>  #define ADV7511_MAX_ADDRS 3
> @@ -393,7 +395,7 @@ static inline int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511)
>  }
>  #endif
>  
> -#ifdef CONFIG_DRM_I2C_ADV7533
> +#ifdef CONFIG_DRM_I2C_ADV753x
>  void adv7533_dsi_power_on(struct adv7511 *adv);
>  void adv7533_dsi_power_off(struct adv7511 *adv);
>  void adv7533_mode_set(struct adv7511 *adv, const struct drm_display_mode *mode);

The else part here define dummy functions.

> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index f6d2681f6927..b1501344df3e 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -367,7 +367,7 @@ static void adv7511_power_on(struct adv7511 *adv7511)
>  	 */
>  	regcache_sync(adv7511->regmap);
>  
> -	if (adv7511->type == ADV7533)
> +	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
>  		adv7533_dsi_power_on(adv7511);

In the driver we check for adv7511->type - and call
adv7533_dsi_power_on() only for the two types where we have this
function defined.
A simpler approach would be to always call adv7533_dsi_power_on(), and
let the existing logic pick up the right version.
The dummy version should then return 0 to say OK.

Same goes for several places below.


>  	adv7511->powered = true;
>  }
> @@ -387,7 +387,7 @@ static void __adv7511_power_off(struct adv7511 *adv7511)
>  static void adv7511_power_off(struct adv7511 *adv7511)
>  {
>  	__adv7511_power_off(adv7511);
> -	if (adv7511->type == ADV7533)
> +	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
>  		adv7533_dsi_power_off(adv7511);
>  	adv7511->powered = false;
>  }
> @@ -761,7 +761,7 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
>  	regmap_update_bits(adv7511->regmap, 0x17,
>  		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
>  
> -	if (adv7511->type == ADV7533)
> +	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
>  		adv7533_mode_set(adv7511, adj_mode);
>  
>  	drm_mode_copy(&adv7511->curr_mode, adj_mode);
> @@ -874,7 +874,7 @@ static int adv7511_bridge_attach(struct drm_bridge *bridge)
>  				 &adv7511_connector_helper_funcs);
>  	drm_connector_attach_encoder(&adv->connector, bridge->encoder);
>  
> -	if (adv->type == ADV7533)
> +	if (adv->type == ADV7533 || adv->type == ADV7535)
>  		ret = adv7533_attach_dsi(adv);
>  
>  	if (adv->i2c_main->irq)
> @@ -903,6 +903,7 @@ static const char * const adv7511_supply_names[] = {
>  	"dvdd-3v",
>  };
>  
> +/* The order of entries is important. If changed update hardcoded indices */
>  static const char * const adv7533_supply_names[] = {
>  	"avdd",
>  	"dvdd",
> @@ -952,7 +953,7 @@ static bool adv7511_cec_register_volatile(struct device *dev, unsigned int reg)
>  	struct i2c_client *i2c = to_i2c_client(dev);
>  	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
>  
> -	if (adv7511->type == ADV7533)
> +	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
>  		reg -= ADV7533_REG_CEC_OFFSET;
>  
>  	switch (reg) {
> @@ -994,7 +995,7 @@ static int adv7511_init_cec_regmap(struct adv7511 *adv)
>  		goto err;
>  	}
>  
> -	if (adv->type == ADV7533) {
> +	if (adv->type == ADV7533 || adv->type == ADV7535) {
>  		ret = adv7533_patch_cec_registers(adv);
>  		if (ret)
>  			goto err;
> @@ -1094,8 +1095,9 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>  	struct adv7511_link_config link_config;
>  	struct adv7511 *adv7511;
>  	struct device *dev = &i2c->dev;
> +	struct regulator *reg_v1p2;
>  	unsigned int val;
> -	int ret;
> +	int ret, reg_v1p2_uV;
>  
>  	if (!dev->of_node)
>  		return -EINVAL;
> @@ -1163,6 +1165,16 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>  	if (ret)
>  		goto uninit_regulators;
>  
> +	if (adv7511->type == ADV7533) {
> +		reg_v1p2 = adv7511->supplies[5].consumer;
> +		reg_v1p2_uV = regulator_get_voltage(reg_v1p2);
> +
> +		if (reg_v1p2_uV == 1200000) {
> +			regmap_update_bits(adv7511->regmap,
> +				ADV7511_REG_SUPPLY_SELECT, 0x80, 0x80);
> +		}
> +	}
> +
>  	adv7511_packet_disable(adv7511, 0xffff);
>  
>  	adv7511->i2c_edid = i2c_new_secondary_device(i2c, "edid",
> @@ -1242,7 +1254,7 @@ static int adv7511_remove(struct i2c_client *i2c)
>  {
>  	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
>  
> -	if (adv7511->type == ADV7533)
> +	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
>  		adv7533_detach_dsi(adv7511);
>  	i2c_unregister_device(adv7511->i2c_cec);
>  	if (adv7511->cec_clk)
> @@ -1266,8 +1278,9 @@ static const struct i2c_device_id adv7511_i2c_ids[] = {
>  	{ "adv7511", ADV7511 },
>  	{ "adv7511w", ADV7511 },
>  	{ "adv7513", ADV7511 },
> -#ifdef CONFIG_DRM_I2C_ADV7533
> +#ifdef CONFIG_DRM_I2C_ADV753x
>  	{ "adv7533", ADV7533 },
> +	{ "adv7535", ADV7535 },
>  #endif

This ifdef may not be needed??
If we did not get this type we will not look it up.

>  	{ }
>  };
> @@ -1277,8 +1290,9 @@ static const struct of_device_id adv7511_of_ids[] = {
>  	{ .compatible = "adi,adv7511", .data = (void *)ADV7511 },
>  	{ .compatible = "adi,adv7511w", .data = (void *)ADV7511 },
>  	{ .compatible = "adi,adv7513", .data = (void *)ADV7511 },
> -#ifdef CONFIG_DRM_I2C_ADV7533
> +#ifdef CONFIG_DRM_I2C_ADV753x
>  	{ .compatible = "adi,adv7533", .data = (void *)ADV7533 },
> +	{ .compatible = "adi,adv7535", .data = (void *)ADV7535 },
>  #endif
>  	{ }
>  };

	Sam
