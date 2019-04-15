Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C80C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E34A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U2csxADD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfDOMLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:11:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47892 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfDOMLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:11:11 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3FCAvk1084317;
        Mon, 15 Apr 2019 07:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555330257;
        bh=KDLrUYHtuQEagvRbb6L0QAMpPzHCFXmx73so/mM6xTI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=U2csxADD0UmF/HLoLEjCiv8ovSmY2EAFYmQN4Zwxbpq3eYMLPjm9f/9opHSvVTSUI
         C9JxKHFVmy6iL4oOT10M+Vpj0rbVw0M4/S6MjwyLdEbRhe7xDX10HX3mJxoVr3YZAR
         msF1WVLJpELCsxPgTHkU4TfW0TIKenUjqVFUpPLQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3FCAvmA028121
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Apr 2019 07:10:57 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 15
 Apr 2019 07:10:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 15 Apr 2019 07:10:57 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3FCAu5j111985;
        Mon, 15 Apr 2019 07:10:56 -0500
Subject: Re: [PATCH v3 3/3] backlight: lm3630a: add firmware node support
To:     Brian Masney <masneyb@onstation.org>, <lee.jones@linaro.org>,
        <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>,
        <robh+dt@kernel.org>
CC:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <mark.rutland@arm.com>, <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <jonathan@marek.ca>
References: <20190415072905.2861-1-masneyb@onstation.org>
 <20190415072905.2861-4-masneyb@onstation.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <0e5e26ba-cf98-913e-8e76-e988a86dc0d1@ti.com>
Date:   Mon, 15 Apr 2019 07:10:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415072905.2861-4-masneyb@onstation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/19 2:29 AM, Brian Masney wrote:
> Add fwnode support to the lm3630a driver and allow configuring
> the initial and maximum LED brightness on both LED banks independently.
> The two outputs can be controlled by bank A and B independently or
> bank A can control both outputs.
> 
> If the platform data was not configured, then the driver defaults to
> enabling both banks. This patch changes the default value to disable
> both banks before parsing the firmware node so that just a single bank
> can be enabled if desired. There are no in-tree users of this driver.
> 
> Driver was tested on a LG Nexus 5 (hammerhead) phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v2
> - Separated out control banks and outputs via the reg and led-sources
>   properties.
> - Use fwnode instead of of API
> - Disable both banks by default before calling lm3630a_parse_node()
> - Add lots of error handling
> - Check for duplicate source / bank definitions
> - Remove extra ;
> - Make probe() method fail if fwnode parsing fails.
> 
>  drivers/video/backlight/lm3630a_bl.c | 128 ++++++++++++++++++++++++++-
>  1 file changed, 126 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index ef2553f452ca..15922da9c05a 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -364,6 +364,116 @@ static const struct regmap_config lm3630a_regmap = {
>  	.max_register = REG_MAX,
>  };
>  
> +/**
> + * lm3630a_parse_led_sources - Parse the optional led-sources fwnode property.
> + * @node: firmware node
> + * @default_bitmask: bitmask to return if the led-sources property was not
> + *                   specified
> + *
> + * Parses the optional led-sources firmware node and returns a bitmask that
> + * contains the outputs that are associated with the control bank. If the
> + * property is missing, then the value of of @default_bitmask will be returned.
> + */
> +static int lm3630a_parse_led_sources(struct fwnode_handle *node,
> +				     int default_bitmask)
> +{
> +	int ret, num_sources, i;
> +	u32 sources[2];
> +
> +	num_sources = fwnode_property_read_u32_array(node, "led-sources", NULL,
> +						     0);
> +	if (num_sources < 0)
> +		return default_bitmask;
> +	else if (num_sources > ARRAY_SIZE(sources))
> +		return -EINVAL;
> +
> +	ret = fwnode_property_read_u32_array(node, "led-sources", sources,
> +					     num_sources);
> +	if (ret)
> +		return ret;
> +
> +	ret = 0;
> +	for (i = 0; i < num_sources; i++) {
> +		if (sources[i] < 0 || sources[i] > 1)
> +			return -EINVAL;
> +
> +		ret |= BIT(sources[i]);
> +	}
> +
> +	return ret;
> +}
> +
> +static int lm3630a_parse_node(struct lm3630a_chip *pchip,
> +			      struct lm3630a_platform_data *pdata)
> +{
> +	int seen = 0, led_sources, ret;
> +	struct fwnode_handle *node;
> +	u32 bank, val;
> +	bool linear;
> +
> +	device_for_each_child_node(pchip->dev, node) {
> +		ret = fwnode_property_read_u32(node, "reg", &bank);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (bank < 0 || bank > 1)
> +			return -EINVAL;
> +
> +		if (seen & BIT(bank))
> +			return -EINVAL;

Need line break for clarity.

> +		seen |= BIT(bank);
> +
> +		led_sources = lm3630a_parse_led_sources(node, BIT(bank));
> +		if (led_sources < 0)
> +			return led_sources;
> +
> +		linear = fwnode_property_read_bool(node,
> +						   "ti,linear-mapping-mode");
> +		if (bank == 0) {
> +			if (!(led_sources & BIT(0)))
> +				return -EINVAL;
> +
> +			pdata->leda_ctrl = linear ?
> +				LM3630A_LEDA_ENABLE_LINEAR :
> +				LM3630A_LEDA_ENABLE;
> +
> +			if (led_sources & BIT(1)) {
> +				if (seen & BIT(1))
> +					return -EINVAL;

Need line break for clarity.

> +				seen |= BIT(1);
> +
> +				pdata->ledb_ctrl = LM3630A_LEDB_ON_A;
> +			}
> +		} else {
> +			if (led_sources & BIT(0) || !(led_sources & BIT(1)))
> +				return -EINVAL;
> +
> +			pdata->ledb_ctrl = linear ?
> +				LM3630A_LEDB_ENABLE_LINEAR :
> +				LM3630A_LEDB_ENABLE;
> +		}
> +
> +		ret = fwnode_property_read_u32(node, "default-brightness",
> +					       &val);
> +		if (!ret) {
> +			if (bank == 0)
> +				pdata->leda_init_brt = val;
> +			else
> +				pdata->ledb_init_brt = val;
> +		}
> +
> +		ret = fwnode_property_read_u32(node, "max-brightness", &val);
> +		if (!ret) {
> +			if (bank == 0)
> +				pdata->leda_max_brt = val;
> +			else
> +				pdata->ledb_max_brt = val;
> +		}
> +	}
> +
> +	return 0;

Shouldn't we return ret here and set ret to -ENODEV?
If device_for_each does not find a node if falls through and returns a success but really is should fail.

> +}
> +
>  static int lm3630a_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -396,13 +506,20 @@ static int lm3630a_probe(struct i2c_client *client,
>  				     GFP_KERNEL);
>  		if (pdata == NULL)
>  			return -ENOMEM;
> +
>  		/* default values */
> -		pdata->leda_ctrl = LM3630A_LEDA_ENABLE;
> -		pdata->ledb_ctrl = LM3630A_LEDB_ENABLE;
> +		pdata->leda_ctrl = LM3630A_LEDA_DISABLE;
> +		pdata->ledb_ctrl = LM3630A_LEDB_DISABLE;

This is not needed since default is disabled and kzalloc will set these to 0

>  		pdata->leda_max_brt = LM3630A_MAX_BRIGHTNESS;
>  		pdata->ledb_max_brt = LM3630A_MAX_BRIGHTNESS;
>  		pdata->leda_init_brt = LM3630A_MAX_BRIGHTNESS;
>  		pdata->ledb_init_brt = LM3630A_MAX_BRIGHTNESS;
> +
> +		rval = lm3630a_parse_node(pchip, pdata);
> +		if (rval) {
> +			dev_err(&client->dev, "fail : parse node\n");
> +			return rval;
> +		}
>  	}
>  	pchip->pdata = pdata;
>  
> @@ -470,11 +587,18 @@ static const struct i2c_device_id lm3630a_id[] = {
>  	{}
>  };
>  
> +static const struct of_device_id lm3630a_match_table[] = {
> +	{ .compatible = "ti,lm3630a", },
> +	{ },
> +};
> +
> +

Extra new line here.

>  MODULE_DEVICE_TABLE(i2c, lm3630a_id);
>  
>  static struct i2c_driver lm3630a_i2c_driver = {
>  	.driver = {
>  		   .name = LM3630A_NAME,
> +		   .of_match_table = lm3630a_match_table,
>  		   },
>  	.probe = lm3630a_probe,
>  	.remove = lm3630a_remove,
> 
