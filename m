Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5D3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6D920685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcjsUmMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390171AbfDXSFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:05:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33462 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731658AbfDXSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:05:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so17806319ljc.0;
        Wed, 24 Apr 2019 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HI3T0IIQ3hYRgFT2kbrbmKI1w9gYSnhGHb68BtDunSk=;
        b=KcjsUmMlTVLE+nyyXAjoSt1Sg6lAi0j5b0McuCOR8YjvLtmphNQzyuBnV90Y6IZlPQ
         TsmQUtrps1CC6kBWxpo2fT6t7CYI3rWfDMsfgk2LapMSiM1/7fjdE7uWJ9BE6qfwA/0z
         gsjSR/zYzFYSGvkO4MJFUrDgcg8MEft14GpE0+Wh2vEadEpk49yL4teKImy/i9pZ7agM
         W5DIMZr38uoGt39+IQLw7OKFQoDAMia5uUv2QSAaQifwz0MQGkn3gD+wNhKqTRIUNuo3
         G3u/OuUygq0TyubZgs8ydUaEe178/dD9FyVl4GlG4Fg34awY+IIyX/5YBiwSovfPTyUs
         c88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HI3T0IIQ3hYRgFT2kbrbmKI1w9gYSnhGHb68BtDunSk=;
        b=joM/kMQC3CGXTkutkZYkc4O/lCansr72aNMSjH1Yrfxhs/MEVOAgQpHmvdRhVXb4sZ
         Bcpainlbwi/V4+C3tM4V52ZwdGbI5B6imaIFF5cyUBz1k8yIhlVgqFLdT1qoSvYo1zkF
         7Ym+uXdd1D4oTEP9E2IKxGPNrKGkxW4ysd3zUdVOpg+YfuDasSXgXhTHl5DxOs4PNlMz
         ZxfQqxCO7OHhYh09Wd18jgHQ6qBaO4+eCe6lDuEKHa1aNfC7/i86tT3e9Y0VB0kOPyk6
         lUkgUaYiYJgtzjCn1UIScz6af1Tfj6s8fFxkfuUGmqNu64bVp4lkUUCCiRh7RPShlm+A
         ugJg==
X-Gm-Message-State: APjAAAUFU0YN1uG5M6r/29NhtmXjxkRGcsQUr+7W89TTq7UAMcKKpBgM
        /ToUwgokev9s+VudGVU2VYU=
X-Google-Smtp-Source: APXvYqwC1qPhZixYx+9on+SCq91GsktdC1TqXpdTxfx6buG+oJjFIRd9pEnfRoxQUNOz/qKKGi3WlQ==
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr18700224lje.22.1556129101735;
        Wed, 24 Apr 2019 11:05:01 -0700 (PDT)
Received: from [192.168.1.19] (bkw231.neoplus.adsl.tpnet.pl. [83.28.190.231])
        by smtp.gmail.com with ESMTPSA id z13sm4011837ljk.41.2019.04.24.11.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 11:05:01 -0700 (PDT)
Subject: Re: [PATCH v4 02/26] leds: class: Improve LED and LED flash class
 registration API
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, dtor@google.com,
        linux@roeck-us.net, Baolin Wang <baolin.wang@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-3-jacek.anaszewski@gmail.com>
 <20190424134633.GA14360@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <5a738825-a8f9-f4ca-0a38-773fe145048f@gmail.com>
Date:   Wed, 24 Apr 2019 20:04:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424134633.GA14360@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thanks for the review.

On 4/24/19 3:46 PM, Pavel Machek wrote:
> Hi!
> 
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linaro.org>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
>> +/**
>> + * led_classdev_register_ext - register a new object of LED class with
>> + *			       init data
>> + * @parent: LED controller device this LED is driven by
>> + * @led_cdev: the led_classdev structure for this device
>> + * @init_data: the LED class device initialization data
>> + *
>> + * Returns: 0 on success or negative error value on failure
>> + */
>> +extern int led_classdev_register_ext(struct device *parent,
>> +				     struct led_classdev *led_cdev,
>> +				     struct led_init_data *init_data);
>> +#define led_classdev_register(parent, led_cdev)			\
>> +	led_classdev_register_ext(parent, led_cdev, NULL)
>> +extern int devm_led_classdev_register_ext(struct device *parent,
>> +					  struct led_classdev *led_cdev,
>> +					  struct led_init_data *init_data);
>> +#define devm_led_classdev_register(parent, led_cdev)		\
>> +	devm_led_classdev_register_ext(parent, led_cdev, NULL)
> 
> Static inline (instead of macro) might be preffered. More type safety
> and less confusing behaviour in case of errors...

This is kind of alias. You have type control in the function being
mapped. With inline we'd have to nest the function calls, i.e.
it will worsen performance by this one additional call level.

-- 
Best regards,
Jacek Anaszewski
