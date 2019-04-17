Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4A3C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B683217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I8p1T7Pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbfDQQlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:41:32 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40614 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbfDQQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:41:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3HGfDpa020246;
        Wed, 17 Apr 2019 11:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555519273;
        bh=SbKLBgonrgbeQRScPLBMMyYLobaxtZC1iGAqRwElC8g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=I8p1T7PrLFv5UcxWbIYLz68Ouqv/aBwHjdTb0hNxb8MOqbFRsPWMWnv3/Tij386Nd
         lfKduQ6dQXP+Ppq12iNpJ6rAB+ASIvXFrd3Wh+LZJq5lAOdAcHr6/WcIjquhfR83ER
         +eDmvMWl0LnGPu32kFtfw8FKIHYjCVa7mhjGLAJw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3HGfDKA019494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Apr 2019 11:41:13 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 17
 Apr 2019 11:41:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 17 Apr 2019 11:41:13 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3HGfCj7097055;
        Wed, 17 Apr 2019 11:41:13 -0500
Subject: Re: [PATCH v4 3/3] backlight: lm3630a: add firmware node support
To:     Brian Masney <masneyb@onstation.org>, <lee.jones@linaro.org>,
        <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>,
        <robh+dt@kernel.org>
CC:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <mark.rutland@arm.com>, <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <jonathan@marek.ca>
References: <20190416235350.13742-1-masneyb@onstation.org>
 <20190416235350.13742-4-masneyb@onstation.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <4dcd4b39-e7f8-f1c7-92df-6f09e98cf1be@ti.com>
Date:   Wed, 17 Apr 2019 11:41:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416235350.13742-4-masneyb@onstation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian

On 4/16/19 6:53 PM, Brian Masney wrote:
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
>  drivers/video/backlight/lm3630a_bl.c     | 147 ++++++++++++++++++++++-
>  include/linux/platform_data/lm3630a_bl.h |   4 +
>  2 files changed, 146 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index ef2553f452ca..6d3c54bfbb10 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -329,15 +329,17 @@ static const struct backlight_ops lm3630a_bank_b_ops = {
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
> @@ -348,8 +350,9 @@ static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
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
> @@ -364,6 +367,129 @@ static const struct regmap_config lm3630a_regmap = {
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

Not sure if this was intentional but you documented this interface you added but the others
you did not.  If you need to explain what this is doing then the code may not be clear or the DT
doc is not explicit enough.

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

This is unneeded since fwnode should return 0 on success if it gets here

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
> +	int led_sources, ret = -ENODEV, seen = 0;
> +	struct fwnode_handle *node;
> +	const char *label;
> +	u32 bank, val;
> +	bool linear;
> +
> +	device_for_each_child_node(pchip->dev, node) {
> +		ret = fwnode_property_read_u32(node, "reg", &bank);
> +		if (ret < 0)

if (ret) should be fine here.

> +			return ret;
> +
> +		if (bank < 0 || bank > 1)

maybe define the banks 

#define LM3630A_BANK_0	0
#define LM3630A_BANK_1	1

So it is clear in the code what are the limits to the condition.

if (bank < LM3630A_BANK_0 || bank > LM3630A_BANK_1)

> +			return -EINVAL;
> +
> +		if (seen & BIT(bank))
> +			return -EINVAL;
> +
> +		seen |= BIT(bank);
> +
> +		led_sources = lm3630a_parse_led_sources(node, BIT(bank));
> +		if (led_sources < 0)
> +			return led_sources;
> +
> +		linear = fwnode_property_read_bool(node,
> +						   "ti,linear-mapping-mode");
> +		if (bank == 0) {

This may be nitpicky but what if you flip the if..else and do
You have already validated bank to be within range.

if(bank)
	ledb work
else
	leda work

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
> +
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
> +		ret = fwnode_property_read_string(node, "label", &label);
> +		if (!ret) {
> +			if (bank == 0)
> +				pdata->leda_label = label;
> +			else
> +				pdata->ledb_label = label;
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
> +
> +		ret = 0;

Maybe this could be

if (ret)
	ret = 0;
else
	do bank work.

Dan

<snip>
