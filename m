Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCE4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3232067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YTxTXBF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfGaJO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:14:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46934 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGaJO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:14:27 -0400
Received: from pendragon.ideasonboard.com (unknown [38.98.37.141])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A9703CC;
        Wed, 31 Jul 2019 11:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1564564464;
        bh=hRrkR023UPopxPeIkoDVvaoyGxj+ou48XOPLvw7WrsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YTxTXBF7jicbTzvZVZ1+6t7xlvKf5ZPwWy/7Kg6geVgJx5Dd2H0yncXNlj8xVVuD9
         4EUkGiRkMM3JkA0/3/QP2BORQvEQ7Qn8X7SViTQydaIAI5SJ5CmKymWwnneJHCXyoY
         vWXGL5Bs9eRov68UCyvk3iM2rjy0wIyfcS2MKvUg=
Date:   Wed, 31 Jul 2019 12:14:10 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bogdan Togorean <bogdan.togorean@analog.com>
Cc:     dri-devel@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, a.hajda@samsung.com, sam@ravnborg.org,
        gregkh@linuxfoundation.org, allison@lohutok.net,
        tglx@linutronix.de, matt.redfearn@thinci.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm: bridge: adv7511: Add support for ADV7535
Message-ID: <20190731091410.GC5080@pendragon.ideasonboard.com>
References: <20190730131736.30187-1-bogdan.togorean@analog.com>
 <20190730131736.30187-3-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730131736.30187-3-bogdan.togorean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bogdan,

Thank you for the patch.

On Tue, Jul 30, 2019 at 04:17:36PM +0300, Bogdan Togorean wrote:
> ADV7535 is a DSI to HDMI bridge chip like ADV7533 but it allows
> 1080p@60Hz. v1p2 is fixed to 1.8V on ADV7535 but on ADV7533 can be 1.2V
> or 1.8V and is configurable in a register.
> 
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511.h     |  2 ++
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 31 +++++++++++++++-----
>  2 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> index 52b2adfdc877..702432615ec8 100644
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
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index f6d2681f6927..941072decb73 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -367,7 +367,7 @@ static void adv7511_power_on(struct adv7511 *adv7511)
>  	 */
>  	regcache_sync(adv7511->regmap);
>  
> -	if (adv7511->type == ADV7533)
> +	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
>  		adv7533_dsi_power_on(adv7511);
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
> @@ -952,7 +952,7 @@ static bool adv7511_cec_register_volatile(struct device *dev, unsigned int reg)
>  	struct i2c_client *i2c = to_i2c_client(dev);
>  	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
>  
> -	if (adv7511->type == ADV7533)
> +	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
>  		reg -= ADV7533_REG_CEC_OFFSET;
>  
>  	switch (reg) {
> @@ -994,7 +994,7 @@ static int adv7511_init_cec_regmap(struct adv7511 *adv)
>  		goto err;
>  	}
>  
> -	if (adv->type == ADV7533) {
> +	if (adv->type == ADV7533 || adv->type == ADV7535) {
>  		ret = adv7533_patch_cec_registers(adv);
>  		if (ret)
>  			goto err;
> @@ -1094,8 +1094,9 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
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
> @@ -1163,6 +1164,18 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>  	if (ret)
>  		goto uninit_regulators;
>  
> +	if (adv7511->type == ADV7533) {
> +		ret = match_string(adv7533_supply_names, adv7511->num_supplies,

Although they're equivalent, I would use
ARRAY_SIZE(adv7533_supply_names) instead of adv7511->num_supplies to
make the code easier to read (otherwise one has to check where
num_supplies is set to validate this function call).

> +									"v1p2");

You should align "v1p2" left, with adv7533_supply_names.

I wonder if you couldn't simply hardcode the index, with a comment above
the adv7533_supply_names array to mention that the order of the entries
shall not be modified without updating the locations that hardcode
indices.

> +		reg_v1p2 = adv7511->supplies[ret].consumer;
> +		reg_v1p2_uV = regulator_get_voltage(reg_v1p2);
> +
> +		if (reg_v1p2_uV == 1200000) {
> +			regmap_update_bits(adv7511->regmap,
> +				ADV7511_REG_SUPPLY_SELECT, 0x80, 0x80);
> +		}

Shouldn't you explicitly clear bit 7 when reg_v1p2_uV is not 1200000 ?
Or is there a guarantee it gets reset after a reboot ?

> +	}
> +
>  	adv7511_packet_disable(adv7511, 0xffff);
>  
>  	adv7511->i2c_edid = i2c_new_secondary_device(i2c, "edid",
> @@ -1242,7 +1255,7 @@ static int adv7511_remove(struct i2c_client *i2c)
>  {
>  	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
>  
> -	if (adv7511->type == ADV7533)
> +	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
>  		adv7533_detach_dsi(adv7511);
>  	i2c_unregister_device(adv7511->i2c_cec);
>  	if (adv7511->cec_clk)
> @@ -1268,6 +1281,7 @@ static const struct i2c_device_id adv7511_i2c_ids[] = {
>  	{ "adv7513", ADV7511 },
>  #ifdef CONFIG_DRM_I2C_ADV7533

As noted by Neil, I think this config option should be renamed (possibly
to CONFIG_DRM_I2C_ADV753X) and its description updated.

>  	{ "adv7533", ADV7533 },
> +	{ "adv7535", ADV7535 },
>  #endif
>  	{ }
>  };
> @@ -1279,6 +1293,7 @@ static const struct of_device_id adv7511_of_ids[] = {
>  	{ .compatible = "adi,adv7513", .data = (void *)ADV7511 },
>  #ifdef CONFIG_DRM_I2C_ADV7533
>  	{ .compatible = "adi,adv7533", .data = (void *)ADV7533 },
> +	{ .compatible = "adi,adv7535", .data = (void *)ADV7535 },
>  #endif
>  	{ }
>  };

-- 
Regards,

Laurent Pinchart
