Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CF1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B24208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5fBiCt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbfDXS4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:56:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40768 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfDXS4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:56:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so6582034wmi.5;
        Wed, 24 Apr 2019 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BqWIx6U3ZiXsOq/arALUp97TyaWCAucZsgnNUouARM4=;
        b=H5fBiCt7oHfrGT2ujLpcMJbZAvUsAGu1+uBmmI9qWwbairoZurVGnMS32wm2jVpuzn
         xhWluTvRD7dSm2ZQokA+4rhUpwW4BbtfFpkre8ZXCZ/Sk5LEopC40urd8Y6IaGuKcUAs
         Kpp1RcvKLUdnctq7BdE0KXAMSE33cPngJfICqDvOOC666xJRHIqtyFtRqi9ZanXxEm5N
         yDfgVPj3AVgDf8n7teguOJOrQzT20kHlEeLdV6B9oNDqQs1BkTu9LquqTdRGwPf1hxK8
         8WVbETdRD5cxFJdVcIb6NkLpIjAV1SwKsmk6MKrLHNaB4B6NDsF01iFOV+2RQpXY1WtP
         MllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BqWIx6U3ZiXsOq/arALUp97TyaWCAucZsgnNUouARM4=;
        b=tbrUn1mTYwYflyDC9m6S2lSfrL7m91g16/nXwR9ColMM2vZ7GYya4ZiUgcsH0UQ70B
         znGps+s3c55osncsLEWn8iSobbKxTWdQGXSIbNSRO+/CEjgupIeSttfhy6FR1sQMdHVR
         Ypcsozy6IV/YxX/w98PsV/s2NMTMc9INdMRNet+L24GGGMKL/CWW2+qQhGCpwL3oMg1k
         o67fWlZaUTXUSeLjWgbAC/zvfjTUvYQvN6HdrP69jXLF/566kR5JnbyXU8EPhRYTDUkM
         9+ZU4xW4q3v8ST7oW5aetUgpMEfQrZgI2wgH4LuC3JTh1JgLtu2nSN0gq4JI9L8yqOfb
         +x0Q==
X-Gm-Message-State: APjAAAWk2sD7jSBrBvX8doRVYDewd52BBtQLgfjA2uLnrx02AuujMKc1
        9M99doWMgnWIJBtTDThVYVY=
X-Google-Smtp-Source: APXvYqyC3resNF/xJZme0Ljm+zLFmTSmR57oea8yJ5Kw2OlvUDH5HQyABeETFfmHps+0ZX8pdJL8/w==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr444242wmq.102.1556132172703;
        Wed, 24 Apr 2019 11:56:12 -0700 (PDT)
Received: from [192.168.1.19] (bkw231.neoplus.adsl.tpnet.pl. [83.28.190.231])
        by smtp.gmail.com with ESMTPSA id p2sm8139970wru.73.2019.04.24.11.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 11:56:11 -0700 (PDT)
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
 <20190424134633.GA14360@amd> <5a738825-a8f9-f4ca-0a38-773fe145048f@gmail.com>
 <20190424182522.GA31600@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <17af15f5-9b0b-f2cd-adbe-3f7b00028224@gmail.com>
Date:   Wed, 24 Apr 2019 20:56:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424182522.GA31600@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 8:25 PM, Pavel Machek wrote:
> Hi!
> 
>>>> +/**
>>>> + * led_classdev_register_ext - register a new object of LED class with
>>>> + *			       init data
>>>> + * @parent: LED controller device this LED is driven by
>>>> + * @led_cdev: the led_classdev structure for this device
>>>> + * @init_data: the LED class device initialization data
>>>> + *
>>>> + * Returns: 0 on success or negative error value on failure
>>>> + */
>>>> +extern int led_classdev_register_ext(struct device *parent,
>>>> +				     struct led_classdev *led_cdev,
>>>> +				     struct led_init_data *init_data);
>>>> +#define led_classdev_register(parent, led_cdev)			\
>>>> +	led_classdev_register_ext(parent, led_cdev, NULL)
>>>> +extern int devm_led_classdev_register_ext(struct device *parent,
>>>> +					  struct led_classdev *led_cdev,
>>>> +					  struct led_init_data *init_data);
>>>> +#define devm_led_classdev_register(parent, led_cdev)		\
>>>> +	devm_led_classdev_register_ext(parent, led_cdev, NULL)
>>>
>>> Static inline (instead of macro) might be preffered. More type safety
>>> and less confusing behaviour in case of errors...
>>
>> This is kind of alias. You have type control in the function being
>> mapped. With inline we'd have to nest the function calls, i.e.
>> it will worsen performance by this one additional call level.
> 
> It is not a big issue; but no, performance will be exactly the
> same. "static inline" says .. well, inline this into caller, so there
> will be one function call, not two.

Yes, I realized that right after sending the message.

-- 
Best regards,
Jacek Anaszewski
