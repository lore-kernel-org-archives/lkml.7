Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0007C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B63221841
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tF7OkyZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfDWNth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:49:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34844 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfDWNth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:49:37 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3NDnMMH053765;
        Tue, 23 Apr 2019 08:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556027362;
        bh=mYbPTBZdrLZhuQ/74oqpj8zFm2bgc2JI7RqmZeeHvAQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tF7OkyZXn83P2Ydf8EFtB5NY51gyW4qvekHkGIuNp5E65/9QttmsSK2VXi8cD/nDF
         U8JrF6qcvKsza5DD4haLsoC6p8Eq8d8gMSUZMw5rxM/R1/7f7yDQQSI4fBIFfOZS8R
         b0vrPctnZrJqmGkqjuwgKYiryiy5BpdIzTOMrWNA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3NDnL8C092983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 08:49:21 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Apr 2019 08:49:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Apr 2019 08:49:21 -0500
Received: from [10.250.90.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3NDnKgB052644;
        Tue, 23 Apr 2019 08:49:20 -0500
Subject: Re: [PATCH v5 3/3] backlight: lm3630a: add firmware node support
To:     Brian Masney <masneyb@onstation.org>, <lee.jones@linaro.org>,
        <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>,
        <robh+dt@kernel.org>
CC:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <mark.rutland@arm.com>, <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <jonathan@marek.ca>
References: <20190418151143.26068-1-masneyb@onstation.org>
 <20190418151143.26068-4-masneyb@onstation.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <dc20ab5d-8c44-78a8-3ebc-7fefe8aaf2d5@ti.com>
Date:   Tue, 23 Apr 2019 08:49:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418151143.26068-4-masneyb@onstation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 4/18/19 10:11 AM, Brian Masney wrote:
> Add fwnode support to the lm3630a driver and optionally allow
> configuring the label, default brightness level, and maximum brightness
> level. The two outputs can be controlled by bank A and B independently
> or bank A can control both outputs.
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
> Changes since v4
> - Added new function lm3630a_parse_bank()
> - Renamed seen variable to seen_led_sources
> - Use the bitmask returned from lm3630a_parse_led_sources() to compare
>   against the seen_led_sources rather than just the control bank. This
>   eliminated another if statement that was previously present that
>   checked to see if control bank A should control both sinks.
> - #define LM3630A_BANK_0, LM3630A_BANK_1, LM3630A_SINK_0,
>   LM3630A_SINK_1, and LM3630A_NUM_SINKS and use where appropriate.
> - Changed all occurances of
>   'if (bank == 0) { BANK_A_WORK } else { BANK_B_WORK }' to
>   'if (bank) { BANK_B_WORK } else { BANK_A_WORK }'
> - Dropped unnecessary 'ret = 0' from lm3630a_parse_led_sources().
> - Changed 'if (ret < 0)' to 'if (ret)' in lm3630a_parse_node().
> - Dropped kerneldoc from lm3630a_parse_led_sources().
> 
> Changes since v3
> - Add support for label
> - Changed lm3630a_parse_node() to return -ENODEV if no nodes were found
> - Remove LM3630A_LED{A,B}_DISABLE
> - Add two additional newlines for code readability
> - Remove extra newline
> 
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
>  drivers/video/backlight/lm3630a_bl.c     | 149 ++++++++++++++++++++++-
>  include/linux/platform_data/lm3630a_bl.h |   4 +
>  2 files changed, 148 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index ef2553f452ca..75d996490cf0 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -35,6 +35,14 @@
>  #define REG_MAX		0x50
>  
>  #define INT_DEBOUNCE_MSEC	10
> +
> +#define LM3630A_BANK_0		0
> +#define LM3630A_BANK_1		1
> +
> +#define LM3630A_NUM_SINKS	2
> +#define LM3630A_SINK_0		0
> +#define LM3630A_SINK_1		1
> +
>  struct lm3630a_chip {
>  	struct device *dev;
>  	struct delayed_work work;
> @@ -329,15 +337,17 @@ static const struct backlight_ops lm3630a_bank_b_ops = {
>  
>  static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
>  {
> -	struct backlight_properties props;
>  	struct lm3630a_platform_data *pdata = pchip->pdata;
> +	struct backlight_properties props;
> +	const char *label;
>  
>  	props.type = BACKLIGHT_RAW;
>  	if (pdata->leda_ctrl != LM3630A_LEDA_DISABLE) {
>  		props.brightness = pdata->leda_init_brt;
>  		props.max_brightness = pdata->leda_max_brt;
> +		label = pdata->leda_label ? pdata->leda_label : "lm3630a_leda";
>  		pchip->bleda =
> -		    devm_backlight_device_register(pchip->dev, "lm3630a_leda",
> +		    devm_backlight_device_register(pchip->dev, label,
>  						   pchip->dev, pchip,
>  						   &lm3630a_bank_a_ops, &props);
>  		if (IS_ERR(pchip->bleda))
> @@ -348,8 +358,9 @@ static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
>  	    (pdata->ledb_ctrl != LM3630A_LEDB_ON_A)) {
>  		props.brightness = pdata->ledb_init_brt;
>  		props.max_brightness = pdata->ledb_max_brt;
> +		label = pdata->ledb_label ? pdata->ledb_label : "lm3630a_ledb";
>  		pchip->bledb =
> -		    devm_backlight_device_register(pchip->dev, "lm3630a_ledb",
> +		    devm_backlight_device_register(pchip->dev, label,
>  						   pchip->dev, pchip,
>  						   &lm3630a_bank_b_ops, &props);
>  		if (IS_ERR(pchip->bledb))
> @@ -364,6 +375,123 @@ static const struct regmap_config lm3630a_regmap = {
>  	.max_register = REG_MAX,
>  };
>  
> +static int lm3630a_parse_led_sources(struct fwnode_handle *node,
> +				     int default_led_sources)
> +{
> +	u32 sources[LM3630A_NUM_SINKS];
> +	int ret, num_sources, i;
> +
> +	num_sources = fwnode_property_read_u32_array(node, "led-sources", NULL,
> +						     0);
> +	if (num_sources < 0)
> +		return default_led_sources;
> +	else if (num_sources > ARRAY_SIZE(sources))
> +		return -EINVAL;
> +
> +	ret = fwnode_property_read_u32_array(node, "led-sources", sources,
> +					     num_sources);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < num_sources; i++) {
> +		if (sources[i] < LM3630A_SINK_0 || sources[i] > LM3630A_SINK_1)
> +			return -EINVAL;
> +
> +		ret |= BIT(sources[i]);
> +	}
> +
> +	return ret;
> +}
> +
> +static int lm3630a_parse_bank(struct lm3630a_platform_data *pdata,
> +			      struct fwnode_handle *node, int *seen_led_sources)

Why is seen_led_sources passed in here?
It is initialized on the stack in lm3630a_parse_node but the variable is never referenced in that API.

Dan

> +{
> +	int led_sources, ret;
> +	const char *label;
> +	u32 bank, val;
> +	bool linear;
> +
> +	ret = fwnode_property_read_u32(node, "reg", &bank);
> +	if (ret)
> +		return ret;
> +
> +	if (bank < LM3630A_BANK_0 || bank > LM3630A_BANK_1)
> +		return -EINVAL;
> +
> +	led_sources = lm3630a_parse_led_sources(node, BIT(bank));
> +	if (led_sources < 0)
> +		return led_sources;
> +
> +	if (*seen_led_sources & led_sources)
> +		return -EINVAL;
> +
> +	*seen_led_sources |= led_sources;
> +
> +	linear = fwnode_property_read_bool(node,
> +					   "ti,linear-mapping-mode");
> +	if (bank) {
> +		if (led_sources & BIT(LM3630A_SINK_0) ||
> +		    !(led_sources & BIT(LM3630A_SINK_1)))
> +			return -EINVAL;
> +
> +		pdata->ledb_ctrl = linear ?
> +			LM3630A_LEDB_ENABLE_LINEAR :
> +			LM3630A_LEDB_ENABLE;
> +	} else {
> +		if (!(led_sources & BIT(LM3630A_SINK_0)))
> +			return -EINVAL;
> +
> +		pdata->leda_ctrl = linear ?
> +			LM3630A_LEDA_ENABLE_LINEAR :
> +			LM3630A_LEDA_ENABLE;
> +
> +		if (led_sources & BIT(LM3630A_SINK_1))
> +			pdata->ledb_ctrl = LM3630A_LEDB_ON_A;
> +	}
> +
> +	ret = fwnode_property_read_string(node, "label", &label);
> +	if (!ret) {
> +		if (bank)
> +			pdata->ledb_label = label;
> +		else
> +			pdata->leda_label = label;
> +	}
> +
> +	ret = fwnode_property_read_u32(node, "default-brightness",
> +				       &val);
> +	if (!ret) {
> +		if (bank)
> +			pdata->ledb_init_brt = val;
> +		else
> +			pdata->leda_init_brt = val;
> +	}
> +
> +	ret = fwnode_property_read_u32(node, "max-brightness", &val);
> +	if (!ret) {
> +		if (bank)
> +			pdata->ledb_max_brt = val;
> +		else
> +			pdata->leda_max_brt = val;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lm3630a_parse_node(struct lm3630a_chip *pchip,
> +			      struct lm3630a_platform_data *pdata)
> +{
> +	int ret = -ENODEV, seen_led_sources = 0;
> +	struct fwnode_handle *node;
> +
> +	device_for_each_child_node(pchip->dev, node) {
> +		ret = lm3630a_parse_bank(pdata, node, &seen_led_sources);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
>  static int lm3630a_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -396,13 +524,18 @@ static int lm3630a_probe(struct i2c_client *client,
>  				     GFP_KERNEL);
>  		if (pdata == NULL)
>  			return -ENOMEM;
> +
>  		/* default values */
> -		pdata->leda_ctrl = LM3630A_LEDA_ENABLE;
> -		pdata->ledb_ctrl = LM3630A_LEDB_ENABLE;
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
> @@ -470,11 +603,17 @@ static const struct i2c_device_id lm3630a_id[] = {
>  	{}
>  };
>  
> +static const struct of_device_id lm3630a_match_table[] = {
> +	{ .compatible = "ti,lm3630a", },
> +	{ },
> +};
> +
>  MODULE_DEVICE_TABLE(i2c, lm3630a_id);
>  
>  static struct i2c_driver lm3630a_i2c_driver = {
>  	.driver = {
>  		   .name = LM3630A_NAME,
> +		   .of_match_table = lm3630a_match_table,
>  		   },
>  	.probe = lm3630a_probe,
>  	.remove = lm3630a_remove,
> diff --git a/include/linux/platform_data/lm3630a_bl.h b/include/linux/platform_data/lm3630a_bl.h
> index 7538e38e270b..762e68956f31 100644
> --- a/include/linux/platform_data/lm3630a_bl.h
> +++ b/include/linux/platform_data/lm3630a_bl.h
> @@ -38,9 +38,11 @@ enum lm3630a_ledb_ctrl {
>  
>  #define LM3630A_MAX_BRIGHTNESS 255
>  /*
> + *@leda_label    : optional led a label.
>   *@leda_init_brt : led a init brightness. 4~255
>   *@leda_max_brt  : led a max brightness.  4~255
>   *@leda_ctrl     : led a disable, enable linear, enable exponential
> + *@ledb_label    : optional led b label.
>   *@ledb_init_brt : led b init brightness. 4~255
>   *@ledb_max_brt  : led b max brightness.  4~255
>   *@ledb_ctrl     : led b disable, enable linear, enable exponential
> @@ -50,10 +52,12 @@ enum lm3630a_ledb_ctrl {
>  struct lm3630a_platform_data {
>  
>  	/* led a config.  */
> +	const char *leda_label;
>  	int leda_init_brt;
>  	int leda_max_brt;
>  	enum lm3630a_leda_ctrl leda_ctrl;
>  	/* led b config. */
> +	const char *ledb_label;
>  	int ledb_init_brt;
>  	int ledb_max_brt;
>  	enum lm3630a_ledb_ctrl ledb_ctrl;
> 
