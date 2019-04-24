Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10443C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11E120685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlHyh99j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733249AbfDXSSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:18:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43377 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733163AbfDXSSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:18:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id i68so15426071lfi.10;
        Wed, 24 Apr 2019 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BH/hnxfh/10Bg7IPT2muPqlO7cJy/jbY2turZVfwqow=;
        b=nlHyh99jQvg4By9q8zfVMWoa+dpeJ+/3PorljQN5DdtnHkshOGFyVU8TtJR8tDh8yl
         f+PrIrUN8IvOWsRpsWyc3fUki12GcdmVXZ5oLrlNUlGks2njQdYpJV0BJ+GDipeJJvfT
         Y7FkYML5hrwB01L/8oOWq4KdjtVqj2iSjYsp76UqJD0TsdahznsRUiHplNcEe3X7HMg1
         7R0RtwddLI2kp2hZXVWS4rSrwKm0TKE6UELVQUhjubJlXGocP8bd4RHIvvwD4O/F0/L3
         ran1dvXEuIItrshnYtSAudguYC+4cX994Uh3Y+Zgrc9FSvjKOoc1anet1V8Nyxc0L7V8
         T9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BH/hnxfh/10Bg7IPT2muPqlO7cJy/jbY2turZVfwqow=;
        b=fHopC5T0zQrsPtQJe4Os2bnZOAuxUbID/YzOvmVHqKZ63Ei/8jLR2exVINkKoDN4tt
         72vRS1OGeIi8MTTVvqPxKjTEbl+kwH5O5bymCbizGK8/T3i8URHsTEPHOtH4YF66/Cj8
         MlcL/RYhkne4801uJu7hLwchNUZS3Njpc1gGOvVhv/2aqZutnNH4DYsZamlpzjKOZE0Q
         rp/61pQnC4Qzsg4UXix4UNnly6AIFw7te2IF3XMHoB16bEUc23JY9MbyhamUNQh4dB0i
         FYQmJ7RPMizIWIPLrj7/8b2hYrcUFSU+nJbwbhs/gHuCfk+IVYMaCUjZTvtigTXTlI5u
         x1cA==
X-Gm-Message-State: APjAAAUyMJZs98OwNmI9FQlNwcts0gUlCHtRNeblkHd6Dxz/gSidH5ww
        7otnRzYoPPmrbse2uRR4XU8=
X-Google-Smtp-Source: APXvYqwirLQ3GlBgh+7yHYOBoxgISjSYf9rQmemhuDSmzMoedTRt3EKuGt73vIHguBK8MjNevsWhUA==
X-Received: by 2002:ac2:4833:: with SMTP id 19mr18164418lft.87.1556129888927;
        Wed, 24 Apr 2019 11:18:08 -0700 (PDT)
Received: from [192.168.1.19] (bkw231.neoplus.adsl.tpnet.pl. [83.28.190.231])
        by smtp.gmail.com with ESMTPSA id h21sm34631ljf.16.2019.04.24.11.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 11:18:08 -0700 (PDT)
Subject: Re: [PATCH v4 22/26] leds: as3645a: Use generic support for composing
 LED names
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, dtor@google.com,
        linux@roeck-us.net, Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-23-jacek.anaszewski@gmail.com>
 <20190424140128.GD14360@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <52b9725f-ac30-0b09-af6e-879396c37819@gmail.com>
Date:   Wed, 24 Apr 2019 20:18:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424140128.GD14360@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

On 4/24/19 4:01 PM, Pavel Machek wrote:
> Hi!
> 
>> Switch to using generic LED support for composing LED class
>> device name.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
>> +static int as3645a_led_class_setup(struct as3645a *flash)
>>   {
>>   	struct led_classdev *fled_cdev = &flash->fled.led_cdev;
>>   	struct led_classdev *iled_cdev = &flash->iled_cdev;
>> +	struct led_init_data init_data;
> 
> Not initialized.
> 
>>   	struct led_flash_setting *cfg;
>>   	int rval;
>>   
>> -	iled_cdev->name = names->indicator;
>>   	iled_cdev->brightness_set_blocking = as3645a_set_indicator_brightness;
>>   	iled_cdev->max_brightness =
>>   		flash->cfg.indicator_max_ua / AS_INDICATOR_INTENSITY_STEP;
>>   	iled_cdev->flags = LED_CORE_SUSPENDRESUME;
>>   
>> -	rval = led_classdev_register(&flash->client->dev, iled_cdev);
>> +	init_data.fwnode = flash->indicator_node;
>> +	init_data.devicename = AS_NAME;
>> +	init_data.default_label = "indicator";
> 
> And struct has one more field:
> 
> 	 +       /*
> 	 +        * indicates if LED name should always comprise
>           devicename section;
> 	 +        * only LEDs exposed by drivers of hot-pluggable
>           devices should
> 	 +        * set it to true
> 	 +        */
> 	 +       bool devname_mandatory;
> 	  };
> 
> I believe it would be cleaner to always initialize struct with zeros;
> that way you can also expand it in future.

Good point. Will fix that in v5.

-- 
Best regards,
Jacek Anaszewski
