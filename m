Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC98C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B72C20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zQba8l1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfDKP3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:29:02 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48468 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfDKP3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:29:02 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3BFStA2130009;
        Thu, 11 Apr 2019 10:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554996535;
        bh=qqMaKGSPhmxv8H/I0FbgYy7OqIMZ1lOCyw+l6N2GXm0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zQba8l1YfdJ5Rh5/wg+tXct0YKmGdS/CfJnZc08/8guv/dKWB7hVYso5U8UCEyMjn
         6KpbvhZ0GRaFHW94KLJOCQb0XiPPu4zJUUbxp+H30B1rHgabi0UVE4hNAia02vJFy9
         3xBxGUvTI+tBDfKgPII6DoH9L17xBMo58YOA/pq0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3BFStYr044349
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Apr 2019 10:28:55 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Apr 2019 10:28:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Apr 2019 10:28:54 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3BFSsVB009640;
        Thu, 11 Apr 2019 10:28:54 -0500
Subject: Re: [PATCH v3 11/25] leds: lp8860: Use generic support for composing
 LED names
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
 <20190331175501.23471-12-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <4c454bbc-62b2-8607-893c-5e126cba31ad@ti.com>
Date:   Thu, 11 Apr 2019 10:28:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331175501.23471-12-jacek.anaszewski@gmail.com>
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
> While at it, avoid iterating through available child of nodes
> in favor of obtaining single expected child node using single
> call to of_get_next_available_child().
>
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/leds/leds-lp8860.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
> index 39c72a908f3b..10364068da53 100644
> --- a/drivers/leds/leds-lp8860.c
> +++ b/drivers/leds/leds-lp8860.c
> @@ -22,7 +22,6 @@
>  #include <linux/of_gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/slab.h>
> -#include <uapi/linux/uleds.h>
>  
>  #define LP8860_DISP_CL1_BRT_MSB		0x00
>  #define LP8860_DISP_CL1_BRT_LSB		0x01
> @@ -87,6 +86,8 @@
>  
>  #define LP8860_CLEAR_FAULTS		0x01
>  
> +#define LP8860_NAME			"lp8860"
> +
>  /**
>   * struct lp8860_led -
>   * @lock - Lock for reading/writing the device
> @@ -96,7 +97,6 @@
>   * @eeprom_regmap - EEPROM register map
>   * @enable_gpio - VDDIO/EN gpio to enable communication interface
>   * @regulator - LED supply regulator pointer
> - * @label - LED label
>   */
>  struct lp8860_led {
>  	struct mutex lock;
> @@ -106,7 +106,6 @@ struct lp8860_led {
>  	struct regmap *eeprom_regmap;
>  	struct gpio_desc *enable_gpio;
>  	struct regulator *regulator;
> -	char label[LED_MAX_NAME_SIZE];
>  };
>  
>  struct lp8860_eeprom_reg {
> @@ -387,25 +386,19 @@ static int lp8860_probe(struct i2c_client *client,
>  	struct lp8860_led *led;
>  	struct device_node *np = client->dev.of_node;
>  	struct device_node *child_node;
> -	const char *name;
> +	struct led_init_data init_data;
>  
>  	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
>  	if (!led)
>  		return -ENOMEM;
>  
> -	for_each_available_child_of_node(np, child_node) {
> -		led->led_dev.default_trigger = of_get_property(child_node,
> -						    "linux,default-trigger",
> -						    NULL);
> -
> -		ret = of_property_read_string(child_node, "label", &name);
> -		if (!ret)
> -			snprintf(led->label, sizeof(led->label), "%s:%s",
> -				 id->name, name);
> -		else
> -			snprintf(led->label, sizeof(led->label),
> -				"%s::display_cluster", id->name);
> -	}
> +	child_node = of_get_next_available_child(np, NULL);
> +	if (!child_node)
> +		return -EINVAL;
> +
> +	led->led_dev.default_trigger = of_get_property(child_node,
> +					    "linux,default-trigger",
> +					    NULL);
>  
>  	led->enable_gpio = devm_gpiod_get_optional(&client->dev,
>  						   "enable", GPIOD_OUT_LOW);
> @@ -420,7 +413,6 @@ static int lp8860_probe(struct i2c_client *client,
>  		led->regulator = NULL;
>  
>  	led->client = client;
> -	led->led_dev.name = led->label;
>  	led->led_dev.brightness_set_blocking = lp8860_brightness_set;
>  
>  	mutex_init(&led->lock);
> @@ -447,7 +439,12 @@ static int lp8860_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_led_classdev_register(&client->dev, &led->led_dev);
> +	init_data.fwnode = of_fwnode_handle(child_node);
> +	init_data.led_hw_name = LP8860_NAME;
> +	init_data.default_label = ":display_cluster";
> +
> +	ret = devm_led_classdev_register_ext(&client->dev, &led->led_dev,
> +					     &init_data);
>  	if (ret) {
>  		dev_err(&client->dev, "led register err: %d\n", ret);
>  		return ret;
Tested-by: Dan Murphy <dmurphy@ti.com>
