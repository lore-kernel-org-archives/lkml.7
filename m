Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B247C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0AC2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bINZf2OL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDKP3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:29:42 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59668 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfDKP3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:29:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3BFTakX049666;
        Thu, 11 Apr 2019 10:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554996576;
        bh=TnlGzGLnCxdf7jn7TBu5+gMh6gHDmVfjG1wFvBi/xbg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bINZf2OLQrJ8qntVp8T2fOFv5fuGbQjCMcVSEXaRmqBzfxsajHOxW0xc4wJArQwk4
         Td1Py7wTF4ZvtPHllDoN/6cDYvYGnKCzLsn/thMN9RqT5TwLKjWSm35jVETnA+mWjZ
         rHfmVung2BscpoGSvAanHRp9fj7ccerhxIXWOJDc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3BFTa23104574
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Apr 2019 10:29:36 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Apr 2019 10:29:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Apr 2019 10:29:36 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3BFTZo1099327;
        Thu, 11 Apr 2019 10:29:35 -0500
Subject: Re: [PATCH v3 13/25] leds: lm3692x: Use generic support for composing
 LED names
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
 <20190331175501.23471-14-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <68d3f78d-7362-7707-450b-1d40deeeeaaa@ti.com>
Date:   Thu, 11 Apr 2019 10:29:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331175501.23471-14-jacek.anaszewski@gmail.com>
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
> At this occassion remove initialization of struct led_classdev's
> dev->of_node property in the driver, since now it will be taken from
> fwnode assigned to struct led_init_data and passed to the new
> devm_led_classdev_register_ext() API.
>
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/leds/leds-lm3692x.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
> index 4f413a7c5f05..d2b30074d87a 100644
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
> @@ -103,7 +102,6 @@
>   * @regmap - Devices register map
>   * @enable_gpio - VDDIO/EN gpio to enable communication interface
>   * @regulator - LED supply regulator pointer
> - * @label - LED label
>   * @led_enable - LED sync to be enabled
>   * @model_id - Current device model ID enumerated
>   */
> @@ -114,7 +112,6 @@ struct lm3692x_led {
>  	struct regmap *regmap;
>  	struct gpio_desc *enable_gpio;
>  	struct regulator *regulator;
> -	char label[LED_MAX_NAME_SIZE];
>  	int led_enable;
>  	int model_id;
>  };
> @@ -325,7 +322,7 @@ static int lm3692x_init(struct lm3692x_led *led)
>  static int lm3692x_probe_dt(struct lm3692x_led *led)
>  {
>  	struct fwnode_handle *child = NULL;
> -	const char *name;
> +	struct led_init_data init_data;
>  	int ret;
>  
>  	led->enable_gpio = devm_gpiod_get_optional(&led->client->dev,
> @@ -350,30 +347,23 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
>  	fwnode_property_read_string(child, "linux,default-trigger",
>  				    &led->led_dev.default_trigger);
>  
> -	ret = fwnode_property_read_string(child, "label", &name);
> -	if (ret)
> -		snprintf(led->label, sizeof(led->label),
> -			"%s::", led->client->name);
> -	else
> -		snprintf(led->label, sizeof(led->label),
> -			 "%s:%s", led->client->name, name);
> -
>  	ret = fwnode_property_read_u32(child, "reg", &led->led_enable);
>  	if (ret) {
>  		dev_err(&led->client->dev, "reg DT property missing\n");
>  		return ret;
>  	}
>  
> -	led->led_dev.name = led->label;
> +	init_data.fwnode = child;
> +	init_data.led_hw_name = led->client->name;
> +	init_data.default_label = ":";
>  
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
>  	return 0;
>  }
>  

Tested-by: Dan Murphy <dmurphy@ti.com>
