Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585A8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EF0214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h74JehWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfGaHmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:42:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55514 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfGaHmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:42:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so59647858wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=epVtIS/ZzbTkPNKTv+F3YRjrxSFR3bNGXf9hCtqpytM=;
        b=h74JehWV5p9/6i9tLjnjnWAXq98ZhEEqTRxpAl41/017R/eM60NIs3b+olUIHnoRQj
         LjglzBLLyV3OnkDwTsz9VUYm+volwi/KRgm5LSq1VIc4FtnSJ0Mp6dn0lJk4djot7+Wb
         VS4G3zMwcAVCsNkKK0OppzzycQpFZmdAdB9sMRkRoq+Wp2WMvvP/zJ/0O3SbE8osxkiz
         10Qx8y9hWpUWoLS/baxKu4Wxbgp0sHjO/TJ5MuAk8m3lv13AcbMV+37tXuuy8s/5FwLZ
         yRFLuxcVA9BoJX3RJIsWjmhEvDaC+TUKxNuHLRSv3W+cOQpTkZID9Gg9FUH2BmibBTQi
         7mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=epVtIS/ZzbTkPNKTv+F3YRjrxSFR3bNGXf9hCtqpytM=;
        b=aK9ojzxe0xiFHwSFnNeiwB3tBwzCK4Lg4EjX625ZTVslvsgkD2VdEm1DGqr1fjM/Yb
         Q99azR/RwFIxiARb7DfS0LORHlBlX9cvEPxyUxTifOcF7mQw85bDSOc341GHixiNz/CR
         nKKBnxAEHKdHYyYWn5JVU55hN4FX1CM4c8pYli8spbIprF6Z/KvknBVFWM0UVUfUFzIE
         +NSSnvfQWBiswdn/hnLB2ien3K3ZcsiRodwmpcX0HDYqaK6zm3DPUs3NtNIlmVXrC4WX
         ZUwiMJZpw/9nPJf2BRWxz2tCkzn1/1dNXkVQ6bteNamDCwICTVLbfWntK8cGgNntbZqW
         gbaA==
X-Gm-Message-State: APjAAAXXBxmHQBU+qwMIvP2vWQUwa6BRlgJ4uQNv9IVi9S9WddPa8pzK
        EBWXh1zdbYRMra9cfKxKlyCw7A==
X-Google-Smtp-Source: APXvYqwDKvdFJHvZJcdvS5Iw0WZPfmIZcmNZBo80agBGmz3pGpdSs4uBsD1FuUrwcBofJFm9kNauwQ==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr9370618wmm.96.1564558934995;
        Wed, 31 Jul 2019 00:42:14 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w67sm87301587wma.24.2019.07.31.00.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 00:42:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm: bridge: adv7511: Add support for ADV7535
To:     Bogdan Togorean <bogdan.togorean@analog.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Laurent.pinchart@ideasonboard.com, tglx@linutronix.de,
        sam@ravnborg.org, matt.redfearn@thinci.com, allison@lohutok.net
References: <20190730131736.30187-1-bogdan.togorean@analog.com>
 <20190730131736.30187-3-bogdan.togorean@analog.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <797f1c00-b76d-fef8-93d2-a2b52d266065@baylibre.com>
Date:   Wed, 31 Jul 2019 09:42:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730131736.30187-3-bogdan.togorean@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bogdan,

On 30/07/2019 15:17, Bogdan Togorean wrote:
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
> +									"v1p2");
> +		reg_v1p2 = adv7511->supplies[ret].consumer;
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
>  	{ "adv7533", ADV7533 },
> +	{ "adv7535", ADV7535 },

Maybe you should add a new CONFIG_DRM_I2C_ADV7535 or update the current CONFIG_DRM_I2C_ADV7533 description.

>  #endif
>  	{ }
>  };
> @@ -1279,6 +1293,7 @@ static const struct of_device_id adv7511_of_ids[] = {
>  	{ .compatible = "adi,adv7513", .data = (void *)ADV7511 },
>  #ifdef CONFIG_DRM_I2C_ADV7533
>  	{ .compatible = "adi,adv7533", .data = (void *)ADV7533 },
> +	{ .compatible = "adi,adv7535", .data = (void *)ADV7535 },

Ditto

I'm not a adv75xx expert but it looks sane.

Neil

>  #endif
>  	{ }
>  };
> 

