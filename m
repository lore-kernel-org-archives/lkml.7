Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E545DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B779720828
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC/nlvb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfCKRYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:24:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44700 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbfCKRYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:24:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id u9so4040198lfe.11;
        Mon, 11 Mar 2019 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7GXD/VUObU/jv/dSzLE4cIfrt2tQK1gLzjdVwXBboXE=;
        b=aC/nlvb8QEKxDYl6vmfN3VTL+0P93mih0zi4ExCrKhAQdw961rQS8Fq9vbW0JG3BrI
         60I5Q15ng9FtJF9fZHDzhpyOJ4jzDBgIo+uvZ4dbmgynYfBAVKdNuP5anI/xL/ptfSjs
         1tBrpKdjaqFoOPAgYapg8hRntHBUEwY/PK0KBMzrCquZGAQTfSOKg7MzZzz18Sw5fm+a
         ReS2bdIKjfK4vfKizm2DcD6udhmQY0VGjHoHVMAYoswVodxwva2uLs21yXIdJO84hLE0
         c6a7APTz6ShjZh4ite9cremzmRak/hvseYy2JxcJN2hmWA64Pjr9A7phFHMuuasmqc1m
         cvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7GXD/VUObU/jv/dSzLE4cIfrt2tQK1gLzjdVwXBboXE=;
        b=gpnDxlLELX+S7WUT7wvsh9sxZ7xC6zheFnAlcCswR+gDuMDKGyAJhkFtOHeB/1Rue3
         dpWM6vd4E88d1f5xCiVdZU9Xm7v6NQIsdlB/UZqT6ZeKOMDL5xaeqmUBNu1oEwIT0ZOP
         1wOxKI7IegHDYQgOpiTO3u3MudusD+6phMQY44YPYTIw/bi5ZhJBrhovuRYodvckfPT4
         ifKafS4KPhB7wb4nfmnJ+sRnCcp3ouCxoj4VPesItXHXZlpxuaLJHISyrUdIfXY18h06
         ATIW8wKJg2tNPLkgs1NvS5lAEpzMcBfcGg+e6kc4Wu+leBiv1CXqjk6w4MB/dnad5Oes
         l2jg==
X-Gm-Message-State: APjAAAUiPgJHcZlhhjhV0r99w6cR9XTWcEsppT72JoxhYPO1Z7mD6AAb
        bsbjq62lRKoc1DCq0eO34CWFsuw6
X-Google-Smtp-Source: APXvYqwG6XC9ZMmB65OPDSXzYR6D67O5THmLTsvghmg22k3rdA6tiZJeEU2/CzSt+v7Ik6nv3lEhsg==
X-Received: by 2002:ac2:5228:: with SMTP id i8mr17891613lfl.162.1552325067622;
        Mon, 11 Mar 2019 10:24:27 -0700 (PDT)
Received: from [192.168.1.18] (cka136.neoplus.adsl.tpnet.pl. [83.31.76.136])
        by smtp.gmail.com with ESMTPSA id r11sm1028414ljb.29.2019.03.11.10.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 10:24:27 -0700 (PDT)
Subject: Re: [PATCH 11/25] leds: lp8860: Use led_compose_name()
To:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-12-jacek.anaszewski@gmail.com>
 <cf42384b-cdbc-3ad7-468f-c4036579652f@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <7242a6e9-ece7-22af-4d62-f2a6aa163579@gmail.com>
Date:   Mon, 11 Mar 2019 18:24:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <cf42384b-cdbc-3ad7-468f-c4036579652f@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 3/11/19 1:28 PM, Dan Murphy wrote:
> On 3/10/19 1:28 PM, Jacek Anaszewski wrote:
>> Switch to using generic LED support for composing LED class
>> device name.
>>
>> While at it, avoid iterating through available child of nodes
>> in favor of obtaining single expected child node using single
>> call to of_get_next_available_child().
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Dan Murphy <dmurphy@ti.com>
>> ---
>>   drivers/leds/leds-lp8860.c | 38 +++++++++++++++++++-------------------
>>   1 file changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
>> index 39c72a908f3b..7c12ccdc1f2f 100644
>> --- a/drivers/leds/leds-lp8860.c
>> +++ b/drivers/leds/leds-lp8860.c
>> @@ -22,7 +22,6 @@
>>   #include <linux/of_gpio.h>
>>   #include <linux/gpio/consumer.h>
>>   #include <linux/slab.h>
>> -#include <uapi/linux/uleds.h>
>>   
>>   #define LP8860_DISP_CL1_BRT_MSB		0x00
>>   #define LP8860_DISP_CL1_BRT_LSB		0x01
>> @@ -87,6 +86,8 @@
>>   
>>   #define LP8860_CLEAR_FAULTS		0x01
>>   
>> +#define LP8860_NAME			"lp8860"
>> +
>>   /**
>>    * struct lp8860_led -
>>    * @lock - Lock for reading/writing the device
>> @@ -96,7 +97,6 @@
>>    * @eeprom_regmap - EEPROM register map
>>    * @enable_gpio - VDDIO/EN gpio to enable communication interface
>>    * @regulator - LED supply regulator pointer
>> - * @label - LED label
>>    */
>>   struct lp8860_led {
>>   	struct mutex lock;
>> @@ -106,7 +106,6 @@ struct lp8860_led {
>>   	struct regmap *eeprom_regmap;
>>   	struct gpio_desc *enable_gpio;
>>   	struct regulator *regulator;
>> -	char label[LED_MAX_NAME_SIZE];
>>   };
>>   
>>   struct lp8860_eeprom_reg {
>> @@ -387,25 +386,26 @@ static int lp8860_probe(struct i2c_client *client,
>>   	struct lp8860_led *led;
>>   	struct device_node *np = client->dev.of_node;
>>   	struct device_node *child_node;
>> -	const char *name;
>> +	struct led_init_data init_data;
>>   
>>   	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
>>   	if (!led)
>>   		return -ENOMEM;
>>   
>> -	for_each_available_child_of_node(np, child_node) {
>> -		led->led_dev.default_trigger = of_get_property(child_node,
>> -						    "linux,default-trigger",
>> -						    NULL);
>> -
>> -		ret = of_property_read_string(child_node, "label", &name);
>> -		if (!ret)
>> -			snprintf(led->label, sizeof(led->label), "%s:%s",
>> -				 id->name, name);
>> -		else
>> -			snprintf(led->label, sizeof(led->label),
>> -				"%s::display_cluster", id->name);
>> -	}
>> +	child_node = of_get_next_available_child(np, NULL);
> 
> Again this device has multiple outputs that can be banked or separated.
> 
> I would prefer to leave the iteration and just change the name generation.

In [0] you agreed on removing that. This code is simply broken since
there is only one instance of struct lp8860_led allocated.

>> +	if (!child_node)
>> +		return -EINVAL;
>> +
>> +	init_data.fwnode = of_fwnode_handle(child_node),
>> +
>> +	led->led_dev.default_trigger = of_get_property(child_node,
>> +					    "linux,default-trigger",
>> +					    NULL);
>> +
>> +	ret = led_compose_name(init_data.fwnode, LP8860_NAME,
>> +			       ":display_cluster", init_data.name);
>> +	if (ret)
>> +		return ret;
>>   
>>   	led->enable_gpio = devm_gpiod_get_optional(&client->dev,
>>   						   "enable", GPIOD_OUT_LOW);
>> @@ -420,7 +420,6 @@ static int lp8860_probe(struct i2c_client *client,
>>   		led->regulator = NULL;
>>   
>>   	led->client = client;
>> -	led->led_dev.name = led->label;
>>   	led->led_dev.brightness_set_blocking = lp8860_brightness_set;
>>   
>>   	mutex_init(&led->lock);
>> @@ -447,7 +446,8 @@ static int lp8860_probe(struct i2c_client *client,
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = devm_led_classdev_register(&client->dev, &led->led_dev);
>> +	ret = devm_led_classdev_register_ext(&client->dev, &led->led_dev,
>> +					     &init_data);
>>   	if (ret) {
>>   		dev_err(&client->dev, "led register err: %d\n", ret);
>>   		return ret;
>>
> 
> 

[0] https://lkml.org/lkml/2018/11/12/2231

-- 
Best regards,
Jacek Anaszewski
