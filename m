Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2E4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD103206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ldZNCz1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfCKMiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:38:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36392 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCKMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:38:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2BCcjp0076869;
        Mon, 11 Mar 2019 07:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552307925;
        bh=gxntPdR6PXBjduYZKf3svHhVFPEGWBWWwhKbq2JrRE0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ldZNCz1g5sILDCTGEE7mfZzzivp2ZfZIPIuTxHoI14xQPubj0RbvU2nEOPlZjSYlh
         GJ3GdzIfwTO6673qF3StwK2d0XaFjxTXXz3SvGbr+L/QNXI8m2r0oTj1Bc1K5D3vyT
         RMmbnXMAWt7vbR/jEyNe73wf4PqQrurM3VYTIlZk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2BCcjj9029280
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Mar 2019 07:38:45 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 11
 Mar 2019 07:38:44 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 11 Mar 2019 07:38:44 -0500
Received: from [172.22.80.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2BCciXh014105;
        Mon, 11 Mar 2019 07:38:44 -0500
Subject: Re: [PATCH 13/25] leds: lm3692x: Use led_compose_name()
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-14-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <6e439475-8d34-5d5c-4a12-5d1d864e9c22@ti.com>
Date:   Mon, 11 Mar 2019 07:38:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190310182836.20841-14-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/19 1:28 PM, Jacek Anaszewski wrote:
> Switch to using generic LED support for composing LED class
> device name.
> 
> Since the same device strings would be used in two places,
> then add macros LM36922_NAME and LM36922_NAME for use in
> lm3692x_probe_dt(() and lm3692x_id array.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Cc: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/leds/leds-lm3692x.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
> index 4f413a7c5f05..9dfc0f28a9c8 100644
> --- a/drivers/leds/leds-lm3692x.c
> +++ b/drivers/leds/leds-lm3692x.c
> @@ -13,7 +13,6 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> -#include <uapi/linux/uleds.h>
>  
>  #define LM36922_MODEL	0
>  #define LM36923_MODEL	1
> @@ -95,6 +94,9 @@
>  #define LM3692X_FAULT_FLAG_SHRT BIT(3)
>  #define LM3692X_FAULT_FLAG_OPEN BIT(4)
>  
> +#define LM36922_NAME "lm36922"
> +#define LM36923_NAME "lm36923"
> +
>  /**
>   * struct lm3692x_led -
>   * @lock - Lock for reading/writing the device
> @@ -103,7 +105,6 @@
>   * @regmap - Devices register map
>   * @enable_gpio - VDDIO/EN gpio to enable communication interface
>   * @regulator - LED supply regulator pointer
> - * @label - LED label
>   * @led_enable - LED sync to be enabled
>   * @model_id - Current device model ID enumerated
>   */
> @@ -114,7 +115,6 @@ struct lm3692x_led {
>  	struct regmap *regmap;
>  	struct gpio_desc *enable_gpio;
>  	struct regulator *regulator;
> -	char label[LED_MAX_NAME_SIZE];
>  	int led_enable;
>  	int model_id;
>  };
> @@ -325,7 +325,8 @@ static int lm3692x_init(struct lm3692x_led *led)
>  static int lm3692x_probe_dt(struct lm3692x_led *led)
>  {
>  	struct fwnode_handle *child = NULL;
> -	const char *name;
> +	struct led_init_data init_data;
> +	char *model_name;
>  	int ret;
>  
>  	led->enable_gpio = devm_gpiod_get_optional(&led->client->dev,
> @@ -346,17 +347,20 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
>  		dev_err(&led->client->dev, "No LED Child node\n");
>  		return -ENODEV;
>  	}
> +	init_data.fwnode = child;
>  
> -	fwnode_property_read_string(child, "linux,default-trigger",
> -				    &led->led_dev.default_trigger);
> +	if (led->model_id == LM36922_MODEL)
> +		model_name =  LM36922_NAME;
> +	else
> +		model_name =  LM36923_NAME;
>  


Why do we need this change?

led->client->name should suffice here and then we do not have to #define the name at all.


> -	ret = fwnode_property_read_string(child, "label", &name);
> +	ret = led_compose_name(child, model_name, ":backlight_cluster",
> +			       init_data.name);
>  	if (ret)
> -		snprintf(led->label, sizeof(led->label),
> -			"%s::", led->client->name);
> -	else
> -		snprintf(led->label, sizeof(led->label),
> -			 "%s:%s", led->client->name, name);
> +		return ret;
> +
> +	fwnode_property_read_string(child, "linux,default-trigger",
> +				    &led->led_dev.default_trigger);
>  
>  	ret = fwnode_property_read_u32(child, "reg", &led->led_enable);
>  	if (ret) {
> @@ -364,16 +368,13 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
>  		return ret;
>  	}
>  
> -	led->led_dev.name = led->label;
> -
> -	ret = devm_led_classdev_register(&led->client->dev, &led->led_dev);
> +	ret = devm_led_classdev_register_ext(&led->client->dev, &led->led_dev,
> +					     &init_data);
>  	if (ret) {
>  		dev_err(&led->client->dev, "led register err: %d\n", ret);
>  		return ret;
>  	}
>  
> -	led->led_dev.dev->of_node = to_of_node(child);
> -

Seems like an additional change here not documented.
If it is a bug fix or an enhancement probably need a separate patch.

I do know why this is removed just need tracability on the log.

Dan

>  	return 0;
>  }
>  
> @@ -439,8 +440,8 @@ static int lm3692x_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id lm3692x_id[] = {
> -	{ "lm36922", LM36922_MODEL },
> -	{ "lm36923", LM36923_MODEL },
> +	{ LM36922_NAME, LM36922_MODEL },
> +	{ LM36923_NAME, LM36923_MODEL },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, lm3692x_id);
> 


-- 
------------------
Dan Murphy
