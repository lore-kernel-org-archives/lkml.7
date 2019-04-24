Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FF2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DC7206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGiL76ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbfDXTCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:02:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43539 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388764AbfDXTCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:02:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id k2so3677079lje.10;
        Wed, 24 Apr 2019 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JPrwuJhkdYeHAqLyFpVkfWP1Dx55YA7CrC/VCy+lwu8=;
        b=iGiL76ru6oOl0hC2SJO7IvLTv/46ZWrtfd3jYmq6x6BD/2AyMboYVV2EZ5ZbiVhkv6
         8vdNW8Z212zrV70gUh4J5EHDzy0fKuk13EbFrcnKV3Q4t4bbYob5YtYgBrBFiMcbwyTd
         rIw8XMIW5Leq9Tb2XPMUhCq4ijEnRgQuiiaQEmxgvF2Yodh1BIX4BB5qiWlforQ3F3hF
         odiaAV0YcAY2FUicF8H+dGPvYfXSlNowJX2ICCNUsfCVXo5FpE6dobA5r1d74je5ycqI
         vuOjiGFwO2918KTUyVWXTWz+fAlP9AdL9hvINyaI1pqD5veZxMmEGSoZF0eEaC08s7jx
         U8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JPrwuJhkdYeHAqLyFpVkfWP1Dx55YA7CrC/VCy+lwu8=;
        b=DW6wktM01sS6I3QB/2DN2Ssx6rTW8g5HRiqmL/optNzgbGw+CK2wsAA5Jgkxzej0nr
         SWymKrt/DWiZiYHpEfYQhGQXVMWwIzC9VKwuH6JxFO64ABIuW0IuNFWSsYB5EoQXZ6wx
         bpUDQOLpwLYNS8xoE1rtx4fcm2cp/E0oEQThdJ3oC8S/4S1J5lnh19ci8Qv61sNFbn4v
         hVluVdKTo51o80Y+X7AgMZU1o4TEOjdNRElImb7S7hAufOWu7r+7hv2DDx/IzQVKQBjU
         pbb1vsvha1rkpkjH8/jEC82hQaPJ2v2kt7Hbg9mifz3DrRSMek+8GnVdiAZ4uf/i8J3E
         JRqA==
X-Gm-Message-State: APjAAAUKgFCMViAkaPp4vTjViVl0a9/Jg0K4CbdAq/+QKAmecGB0zoBS
        B2eNg3pWhTl2Zv+RQWSfD/8=
X-Google-Smtp-Source: APXvYqxyLMnc0SyNpc79RyGS2EqZaY8qkB86xLIu5A7thLc7vZjtGw/0Xb+70KBrUa6VoQHhwf+vVg==
X-Received: by 2002:a2e:390c:: with SMTP id g12mr19595763lja.174.1556132541092;
        Wed, 24 Apr 2019 12:02:21 -0700 (PDT)
Received: from [192.168.1.19] (bkw231.neoplus.adsl.tpnet.pl. [83.28.190.231])
        by smtp.gmail.com with ESMTPSA id k73sm660402ljb.6.2019.04.24.12.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:02:20 -0700 (PDT)
Subject: Re: [PATCH v4 24/26] leds: gpio: Use generic support for composing
 LED names
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, dtor@google.com,
        linux@roeck-us.net, Linus Walleij <linus.walleij@linaro.org>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-25-jacek.anaszewski@gmail.com>
 <20190424140417.GE14360@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <100da86d-44ff-a39c-0d7c-715a286083f6@gmail.com>
Date:   Wed, 24 Apr 2019 21:02:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424140417.GE14360@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

Thanks for the review.

On 4/24/19 4:04 PM, Pavel Machek wrote:
> On Wed 2019-04-17 22:54:37, Jacek Anaszewski wrote:
>> Switch to using generic LED support for composing LED class
>> device name.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>   drivers/leds/leds-gpio.c | 23 ++++++++++-------------
>>   1 file changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
>> index b26cf78993d1..60fb3c85cf05 100644
>> --- a/drivers/leds/leds-gpio.c
>> +++ b/drivers/leds/leds-gpio.c
>> @@ -77,11 +77,11 @@ static int gpio_blink_set(struct led_classdev *led_cdev,
>>   
>>   static int create_gpio_led(const struct gpio_led *template,
>>   	struct gpio_led_data *led_dat, struct device *parent,
>> -	struct device_node *np, gpio_blink_set_t blink_set)
>> +	struct fwnode_handle *fwnode, gpio_blink_set_t blink_set)
>>   {
>> +	struct led_init_data init_data = {};
>>   	int ret, state;
>>   
>> -	led_dat->cdev.name = template->name;
>>   	led_dat->cdev.default_trigger = template->default_trigger;
>>   	led_dat->can_sleep = gpiod_cansleep(led_dat->gpiod);
>>   	if (!led_dat->can_sleep)
>> @@ -112,7 +112,13 @@ static int create_gpio_led(const struct gpio_led *template,
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	return devm_led_classdev_register(parent, &led_dat->cdev);
>> +	if (template->name)
>> +		led_dat->cdev.name = template->name;
>> +	else
>> +		init_data.fwnode = fwnode;
>> +
>> +	return devm_led_classdev_register_ext(parent, &led_dat->cdev,
>> +					      &init_data);
> 
> Won't register_ext() overwrite template->name?

Ah, right. I will need to tweak led_classdev_register_ext() to properly
handle the case when init_data is not NULL, but struct led_classdev's
"name" property is initialized.

-- 
Best regards,
Jacek Anaszewski
