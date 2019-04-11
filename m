Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED701C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB4C20693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bRq/VLV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfDKP3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:29:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34502 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfDKP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:29:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3BFT9BY096808;
        Thu, 11 Apr 2019 10:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554996549;
        bh=/oWsUX/TQkDCHmCWM5p+MGYnMYDfH2HdHUX98BFV1MU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bRq/VLV7G5D3cit7ygSSzAxwCnjkjBwOWA6tZiclSpT7A//D9DP/JpSas8b6I/Aar
         cqrGAXdBQsX2pMNU9pStXvCmxAtJC+1JDB1gSQIWR9lBm2ytrmEbjpCsq7wKf/3D07
         BUBIJtyu4vT2ZFMH62sWK0Eu050TRqbbga8fl24o=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3BFT9ft103810
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Apr 2019 10:29:09 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Apr 2019 10:29:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Apr 2019 10:29:08 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3BFT8t6010458;
        Thu, 11 Apr 2019 10:29:08 -0500
Subject: Re: [PATCH v3 15/25] leds: lm3601x: Use generic support for composing
 LED names
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
 <20190331175501.23471-16-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e8f068fd-531d-aca5-960f-a64d6797d19d@ti.com>
Date:   Thu, 11 Apr 2019 10:29:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331175501.23471-16-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 3/31/19 12:54 PM, Jacek Anaszewski wrote:
> Switch to using generic LED support for composing LED class
> device name.
>
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/leds/leds-lm3601x.c | 38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/leds/leds-lm3601x.c b/drivers/leds/leds-lm3601x.c
> index 081aa71e43a3..d81884c406c3 100644
> --- a/drivers/leds/leds-lm3601x.c
> +++ b/drivers/leds/leds-lm3601x.c
> @@ -10,7 +10,6 @@
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> -#include <uapi/linux/uleds.h>
>  
>  #define LM3601X_LED_IR		0x0
>  #define LM3601X_LED_TORCH	0x1
> @@ -90,8 +89,6 @@ struct lm3601x_led {
>  	struct regmap *regmap;
>  	struct mutex lock;
>  
> -	char led_name[LED_MAX_NAME_SIZE];
> -
>  	unsigned int flash_timeout;
>  	unsigned int last_flag;
>  
> @@ -322,10 +319,12 @@ static const struct led_flash_ops flash_ops = {
>  	.fault_get		= lm3601x_flash_fault_get,
>  };
>  
> -static int lm3601x_register_leds(struct lm3601x_led *led)
> +static int lm3601x_register_leds(struct lm3601x_led *led,
> +				 struct fwnode_handle *fwnode)
>  {
>  	struct led_classdev *led_cdev;
>  	struct led_flash_setting *setting;
> +	struct led_init_data init_data;
>  
>  	led->fled_cdev.ops = &flash_ops;
>  
> @@ -342,20 +341,25 @@ static int lm3601x_register_leds(struct lm3601x_led *led)
>  	setting->val = led->flash_current_max;
>  
>  	led_cdev = &led->fled_cdev.led_cdev;
> -	led_cdev->name = led->led_name;
>  	led_cdev->brightness_set_blocking = lm3601x_brightness_set;
>  	led_cdev->max_brightness = DIV_ROUND_UP(led->torch_current_max,
>  						LM3601X_TORCH_REG_DIV);
>  	led_cdev->flags |= LED_DEV_CAP_FLASH;
>  
> -	return led_classdev_flash_register(&led->client->dev, &led->fled_cdev);
> +	init_data.fwnode = fwnode;
> +	init_data.led_hw_name = led->client->name;
> +	init_data.default_label = (led->led_mode == LM3601X_LED_TORCH) ?
> +					"torch" : "infrared";
> +
> +	return led_classdev_flash_register_ext(&led->client->dev,
> +						&led->fled_cdev, &init_data);
>  }
>  
> -static int lm3601x_parse_node(struct lm3601x_led *led)
> +static int lm3601x_parse_node(struct lm3601x_led *led,
> +			      struct fwnode_handle **fwnode)
>  {
>  	struct fwnode_handle *child = NULL;
>  	int ret = -ENODEV;
> -	const char *name;
>  
>  	child = device_get_next_child_node(&led->client->dev, child);
>  	if (!child) {
> @@ -376,17 +380,6 @@ static int lm3601x_parse_node(struct lm3601x_led *led)
>  		goto out_err;
>  	}
>  
> -	ret = fwnode_property_read_string(child, "label", &name);
> -	if (ret) {
> -		if (led->led_mode == LM3601X_LED_TORCH)
> -			name = "torch";
> -		else
> -			name = "infrared";
> -	}
> -
> -	snprintf(led->led_name, sizeof(led->led_name),
> -		"%s:%s", led->client->name, name);
> -
>  	ret = fwnode_property_read_u32(child, "led-max-microamp",
>  					&led->torch_current_max);
>  	if (ret) {
> @@ -411,6 +404,8 @@ static int lm3601x_parse_node(struct lm3601x_led *led)
>  		goto out_err;
>  	}
>  
> +	*fwnode = child;
> +
>  out_err:
>  	fwnode_handle_put(child);
>  	return ret;
> @@ -419,6 +414,7 @@ static int lm3601x_parse_node(struct lm3601x_led *led)
>  static int lm3601x_probe(struct i2c_client *client)
>  {
>  	struct lm3601x_led *led;
> +	struct fwnode_handle *fwnode;
>  	int ret;
>  
>  	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
> @@ -428,7 +424,7 @@ static int lm3601x_probe(struct i2c_client *client)
>  	led->client = client;
>  	i2c_set_clientdata(client, led);
>  
> -	ret = lm3601x_parse_node(led);
> +	ret = lm3601x_parse_node(led, &fwnode);
>  	if (ret)
>  		return -ENODEV;
>  
> @@ -442,7 +438,7 @@ static int lm3601x_probe(struct i2c_client *client)
>  
>  	mutex_init(&led->lock);
>  
> -	return lm3601x_register_leds(led);
> +	return lm3601x_register_leds(led, fwnode);
>  }
>  
>  static int lm3601x_remove(struct i2c_client *client)
Tested-by: Dan Murphy <dmurphy@ti.com>
