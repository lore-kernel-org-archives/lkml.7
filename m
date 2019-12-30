Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD203C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B1C20409
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SrvjdYgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfL3TdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:33:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37164 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3TdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:33:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so18687682pfn.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 11:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=URa23zWwHmTgfra6HgtXnWWSzjV/YRx3GZJuoonIAgc=;
        b=SrvjdYgbEXeFWKgHXKfqVbv5owBd8rG60Vh+Q/fWe0GpgYzeP5zymf+qVHF7GLQtAC
         zMXa7Usrq2MqLq4g5WQ36+62NRZ8zipR2WE5MGPjoUXS0P31cSPobhY+1ksHGvSHdSJ+
         sG3OUsbHlngjJq4TG78el47rsFacUqfJSIft8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=URa23zWwHmTgfra6HgtXnWWSzjV/YRx3GZJuoonIAgc=;
        b=aCWyEBzxA/noPPGV8D+Vh72q3Y7JskmSQsWLS0VwNZUzyBtPpp3JyeOZBsFidAuz82
         Fzoje8ghZDFI/3As97Q1Gtn5iNZF/46a6jp99gtr/CDCVi1/fBZBa/gx2vgrWk5RiyYH
         zLRifvrfxgZN59uUv+BVVClniWOOdj04usUCdKplxHUmrMUP+jEbIfHdB83xOldb+JEF
         yiAvWA4wJKqMuUvHRVvdCWW/6kXllW67iIDMcM7QUgCzoyG43cV+Uo5KM1KfPtlA2AHB
         OMhfeoM6cHdC4Yhp9O0pjS8fWxVs/+fcR/hFLzGJPznP6VK9tTJ/icozidJCcsGN/IFf
         buMw==
X-Gm-Message-State: APjAAAWWoHm+FXdNUGZxN4DvbKG8mJJ+xb6NokAHqsSM8EduRRd/0Dbv
        QzcStXTIebtgfVr7tqEue7cjMA==
X-Google-Smtp-Source: APXvYqx20Eera11wSCGiMj06DTUkK5XgEr8triU7YEu0Fga/OqWolNx7du6Bb6kon6zBbeDmEJqOuQ==
X-Received: by 2002:a63:6d0e:: with SMTP id i14mr75705666pgc.12.1577734386912;
        Mon, 30 Dec 2019 11:33:06 -0800 (PST)
Received: from [10.67.50.49] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u7sm50502725pfh.128.2019.12.30.11.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 11:33:05 -0800 (PST)
Subject: Re: [PATCH] pwm: bcm2835: Allow building for ARCH_BRCMSTB
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
References: <20191209232503.7252-1-f.fainelli@gmail.com>
 <20191210065229.hopmnq5qlwtl7gzw@pengutronix.de>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; prefer-encrypt=mutual; keydata=
 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
 OXY+VnhOn2EcREN7qdAKw0j9Sw==
Message-ID: <73451521-a4d3-d945-2c86-cceef4cc6781@broadcom.com>
Date:   Mon, 30 Dec 2019 11:33:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210065229.hopmnq5qlwtl7gzw@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/19 10:52 PM, Uwe Kleine-König wrote:
> On Mon, Dec 09, 2019 at 03:25:03PM -0800, Florian Fainelli wrote:
>> BCM7211 is supported using ARCH_BRCMSTB and uses this PWM controller
>> driver, make it possible to build it.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/pwm/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index bd21655c37a6..0bb8a40c8d6c 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -100,7 +100,7 @@ config PWM_BCM_KONA
>>  
>>  config PWM_BCM2835
>>  	tristate "BCM2835 PWM support"
>> -	depends on ARCH_BCM2835
>> +	depends on ARCH_BCM2835 || ARCH_BRCMSTB
> 
> It would be nice to allow this driver to be compiled with COMPILE_TEST,
> too. But also without this:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Krysztof just submitted a patch doing that [1], which will conflict with
this one. Thierry would you be able to resolve that conflict while applying?

[1]:
https://lore.kernel.org/linux-arm-kernel/20191230172113.17222-2-krzk@kernel.org/
-- 
Florian
