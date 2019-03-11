Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CDD20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKywfgtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfCKRYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:24:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35870 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbfCKRYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:24:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id v10so4830881lji.3;
        Mon, 11 Mar 2019 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4gBDFDsDBuiOoTQiFzS5olmoAYRlzLldl+FtvNq985Y=;
        b=XKywfgtWKPsv1l27HRLlCSj3xLvVevbwinDWU6c9r9/5g99i6L8Bi6OCUzuhyuopfI
         EeGijCN1zLmXccYVDcmw+9wnqrHwiA0NbluMfJYHjLen2FSA30SZPaftFkY2VDnRDdFZ
         5yw853OaMSqVMw0FNMgjvKxw+GOlZAlexNAP4HDAVVpevnSRQxc12WjCbgqkV5dQz4ln
         PPxLcXmUxi4xh7pX4lmnr7M1AWpcxVWX/+QUgw3oFYvs5u7DeiaEWGMevIuYdBp+ZgyN
         G112OBzgqxVXvFcVkAegvbhkNj6hcJkc74/rrjPHA6oK4cH0m+rB9TFmacOrgo4GJRyF
         0Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4gBDFDsDBuiOoTQiFzS5olmoAYRlzLldl+FtvNq985Y=;
        b=VUI9hp5Yae+mhj3oV3mqItM7KeGz4KmcDZAIll9iATgSdQzrRUU2cyAPmeI/Rq59Pn
         cCwifSf/U92ryTpMowDTqSAk0WlwnKjKS/FrDOFOSNfHPb4MeQZZAf9NtcKZ7ZfiiG7k
         70mqEnqdo9anOLRwFUqqDibA3cpiTh4EnhmWiKlirNgOP82p83m3vs/OLNhbNJtPqaEr
         MZBHvVQOv8iuT3DBzoZN1Ihhk44P+/8Vf9bl077eqMe45jc4Uj1IpDkLAwUSCugmRx2t
         viZ7toZU9wacBdGe+7FwrWBtwsNb1Yjk4j2eELlnyKpOipoMUEYW9hugMvB4aMRaxhGT
         SMyw==
X-Gm-Message-State: APjAAAWSI6azrSn71ORLPtcRSbvhvxkiOfskpfX/omDN7EyEXd25hpwf
        m5/jqzP/NbYA4awGRXu/7Vo=
X-Google-Smtp-Source: APXvYqx/YEMQ3HkNlaMCVSznhu4glq3EthmtE3s3l/ER0+919Pwe9o3jCFJb/MfMOQANkSdKshVUTA==
X-Received: by 2002:a2e:80cd:: with SMTP id r13mr17110688ljg.34.1552325088288;
        Mon, 11 Mar 2019 10:24:48 -0700 (PDT)
Received: from [192.168.1.18] (cka136.neoplus.adsl.tpnet.pl. [83.31.76.136])
        by smtp.gmail.com with ESMTPSA id x87sm1023949ljb.91.2019.03.11.10.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 10:24:47 -0700 (PDT)
Subject: Re: [PATCH 13/25] leds: lm3692x: Use led_compose_name()
To:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-14-jacek.anaszewski@gmail.com>
 <6e439475-8d34-5d5c-4a12-5d1d864e9c22@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <5ae3df58-7379-c584-9d00-ef1c35d8689d@gmail.com>
Date:   Mon, 11 Mar 2019 18:24:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6e439475-8d34-5d5c-4a12-5d1d864e9c22@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 3/11/19 1:38 PM, Dan Murphy wrote:
> On 3/10/19 1:28 PM, Jacek Anaszewski wrote:
>> Switch to using generic LED support for composing LED class
>> device name.
>>
>> Since the same device strings would be used in two places,
>> then add macros LM36922_NAME and LM36922_NAME for use in
>> lm3692x_probe_dt(() and lm3692x_id array.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Acked-by: Pavel Machek <pavel@ucw.cz>
>> Cc: Dan Murphy <dmurphy@ti.com>
>> ---
>>   drivers/leds/leds-lm3692x.c | 39 ++++++++++++++++++++-------------------
>>   1 file changed, 20 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
>> index 4f413a7c5f05..9dfc0f28a9c8 100644
>> --- a/drivers/leds/leds-lm3692x.c
>> +++ b/drivers/leds/leds-lm3692x.c
>> @@ -13,7 +13,6 @@
>>   #include <linux/regmap.h>
>>   #include <linux/regulator/consumer.h>
>>   #include <linux/slab.h>
>> -#include <uapi/linux/uleds.h>
>>   
>>   #define LM36922_MODEL	0
>>   #define LM36923_MODEL	1
>> @@ -95,6 +94,9 @@
>>   #define LM3692X_FAULT_FLAG_SHRT BIT(3)
>>   #define LM3692X_FAULT_FLAG_OPEN BIT(4)
>>   
>> +#define LM36922_NAME "lm36922"
>> +#define LM36923_NAME "lm36923"
>> +
>>   /**
>>    * struct lm3692x_led -
>>    * @lock - Lock for reading/writing the device
>> @@ -103,7 +105,6 @@
>>    * @regmap - Devices register map
>>    * @enable_gpio - VDDIO/EN gpio to enable communication interface
>>    * @regulator - LED supply regulator pointer
>> - * @label - LED label
>>    * @led_enable - LED sync to be enabled
>>    * @model_id - Current device model ID enumerated
>>    */
>> @@ -114,7 +115,6 @@ struct lm3692x_led {
>>   	struct regmap *regmap;
>>   	struct gpio_desc *enable_gpio;
>>   	struct regulator *regulator;
>> -	char label[LED_MAX_NAME_SIZE];
>>   	int led_enable;
>>   	int model_id;
>>   };
>> @@ -325,7 +325,8 @@ static int lm3692x_init(struct lm3692x_led *led)
>>   static int lm3692x_probe_dt(struct lm3692x_led *led)
>>   {
>>   	struct fwnode_handle *child = NULL;
>> -	const char *name;
>> +	struct led_init_data init_data;
>> +	char *model_name;
>>   	int ret;
>>   
>>   	led->enable_gpio = devm_gpiod_get_optional(&led->client->dev,
>> @@ -346,17 +347,20 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
>>   		dev_err(&led->client->dev, "No LED Child node\n");
>>   		return -ENODEV;
>>   	}
>> +	init_data.fwnode = child;
>>   
>> -	fwnode_property_read_string(child, "linux,default-trigger",
>> -				    &led->led_dev.default_trigger);
>> +	if (led->model_id == LM36922_MODEL)
>> +		model_name =  LM36922_NAME;
>> +	else
>> +		model_name =  LM36923_NAME;
>>   
> 
> 
> Why do we need this change?
> 
> led->client->name should suffice here and then we do not have to #define the name at all.

Indeed, at that time I was not aware that I2C subsystem creates client
name using product name from DT compatible property.

> 
>> -	ret = fwnode_property_read_string(child, "label", &name);
>> +	ret = led_compose_name(child, model_name, ":backlight_cluster",
>> +			       init_data.name);
>>   	if (ret)
>> -		snprintf(led->label, sizeof(led->label),
>> -			"%s::", led->client->name);
>> -	else
>> -		snprintf(led->label, sizeof(led->label),
>> -			 "%s:%s", led->client->name, name);
>> +		return ret;
>> +
>> +	fwnode_property_read_string(child, "linux,default-trigger",
>> +				    &led->led_dev.default_trigger);
>>   
>>   	ret = fwnode_property_read_u32(child, "reg", &led->led_enable);
>>   	if (ret) {
>> @@ -364,16 +368,13 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
>>   		return ret;
>>   	}
>>   
>> -	led->led_dev.name = led->label;
>> -
>> -	ret = devm_led_classdev_register(&led->client->dev, &led->led_dev);
>> +	ret = devm_led_classdev_register_ext(&led->client->dev, &led->led_dev,
>> +					     &init_data);
>>   	if (ret) {
>>   		dev_err(&led->client->dev, "led register err: %d\n", ret);
>>   		return ret;
>>   	}
>>   
>> -	led->led_dev.dev->of_node = to_of_node(child);
>> -
> 
> Seems like an additional change here not documented.
> If it is a bug fix or an enhancement probably need a separate patch.
> 
> I do know why this is removed just need tracability on the log.

OK, I will add the comment.

>>   	return 0;
>>   }
>>   
>> @@ -439,8 +440,8 @@ static int lm3692x_remove(struct i2c_client *client)
>>   }
>>   
>>   static const struct i2c_device_id lm3692x_id[] = {
>> -	{ "lm36922", LM36922_MODEL },
>> -	{ "lm36923", LM36923_MODEL },
>> +	{ LM36922_NAME, LM36922_MODEL },
>> +	{ LM36923_NAME, LM36923_MODEL },
>>   	{ }
>>   };
>>   MODULE_DEVICE_TABLE(i2c, lm3692x_id);
>>
> 
> 

-- 
Best regards,
Jacek Anaszewski
