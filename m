Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4BAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5819821841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6EIVoIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfCVTkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:40:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40143 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVTkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:40:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id u68so2172078lff.7;
        Fri, 22 Mar 2019 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P5odAoLP10UCb/YLd61hpF+ZwnCJ0GeG1BF1OcQI3dM=;
        b=K6EIVoIiklUPSPmjvVquEEF7XkINeNN7yogGEtcPDb5V/VL9hVIlxFneScultQ3tBX
         2ZIHZeU6rjkrVNSaRJxB9TVW9U655+VkAGA0jyfKAbBGfsiGV4Nwf/iLx6tqKgroloU2
         JXxfntaW8ZMFKWJBvJzEK6a5uRfmDsuT5XBZn4w7T89aC+er8oNdigTLI6JUh4F/0YRW
         NrmVZvD2cAq7i/kcp8ex26pkxjgg+rv8Ysq6mHDUaokaPzfY+mT1OuudDzggQiFDc360
         yX7iVJeB8Hh95sab6GNTxOSjK1Ig76nMfOXZfn3o2xMRerDeUw6aLEQYCi7gzzRTUjWX
         k2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P5odAoLP10UCb/YLd61hpF+ZwnCJ0GeG1BF1OcQI3dM=;
        b=N0xwdDEmzFiX7krky/SWhmjslqDUVDeAY+IdxgVf/scy9Gm/QSC2Oq4stt7qoZJ+Pl
         MoK5Y82wqxVCuv3/N/6qfw3SeCbnyQgLYKANEjPxxzcbNHvkLcB5VlBk4ec5WpAuy0ht
         0Bggm2y+tGAZZo7Em7nKDgxPEnNg2nBMkYJVd3wlX4kKyWS2wLOmtjD55JllUwhi9Tka
         RDUXBdKRHLZcLaStZ8Ls0bk3S9Pl0UIdzc7JMB9Rhz2JYAb2tt2cNhp4XeXQ582mcViB
         +cZ9V1b2UkCv++zAkm9CsoXGwFKz4AgmV8IE4G5cLeqcuAPC1RZXu25MCIlsBr/xvpCB
         hNXw==
X-Gm-Message-State: APjAAAXx2flgV/PHl+QstkPI+o6tOC6cXCjevrH54D+I/qlCVP6uTAiI
        ZxceBQly+MmcdnvtQ/izKrk=
X-Google-Smtp-Source: APXvYqwr01qRxhUFld20kQmR5zj3ibu+Yw30HTYAF5O5OuuDFTLbgyaPSXh7DJ39SYJ6MaNsmqP5sw==
X-Received: by 2002:a19:d144:: with SMTP id i65mr5455988lfg.52.1553283649036;
        Fri, 22 Mar 2019 12:40:49 -0700 (PDT)
Received: from [192.168.1.18] (bky140.neoplus.adsl.tpnet.pl. [83.28.192.140])
        by smtp.gmail.com with ESMTPSA id d5sm1877490lfi.95.2019.03.22.12.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 12:40:47 -0700 (PDT)
Subject: Re: [RESEND PATCH v6 09/11] leds: max77650: add LEDs support
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190318174228.18194-1-brgl@bgdev.pl>
 <20190318174228.18194-10-brgl@bgdev.pl> <20190322092124.GK27015@amd>
 <CAMRc=Mf1DxF1e63y+HsXtCFxZW8R0XWDLUXGy+4cp3zBS0_qhw@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <f2963c2e-b4d0-1fae-3c7f-28fcdb545ee2@gmail.com>
Date:   Fri, 22 Mar 2019 20:40:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mf1DxF1e63y+HsXtCFxZW8R0XWDLUXGy+4cp3zBS0_qhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 10:53 AM, Bartosz Golaszewski wrote:
> pt., 22 mar 2019 o 10:21 Pavel Machek <pavel@ucw.cz> napisał(a):
>>
>> On Mon 2019-03-18 18:42:26, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> This adds basic support for LEDs for the max77650 PMIC. The device has
>>> three current sinks for driving LEDs.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>
>> Acked-by: Pavel Machek <pavel@ucw.cz>
>>
>>> +             label = of_get_property(child, "label", NULL);
>>> +             if (!label) {
>>> +                     led->cdev.name = "max77650::";
>>> +             } else {
>>> +                     led->cdev.name = devm_kasprintf(dev, GFP_KERNEL,
>>> +                                                     "max77650:%s", label);
>>> +                     if (!led->cdev.name)
>>> +                             return -ENOMEM;
>>> +             }
>>
>> I'd rather not have the "max77650:" prefix in the LED name (as it is
>> useless).
>>
> 
> I was instructed to do so by the LED subsystem maintainer.

Yes, let's keep things consistent, we will convert it to use generic
support for LED naming once that support is merged.

-- 
Best regards,
Jacek Anaszewski
