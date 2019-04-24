Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B3AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ED020685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm42g9zm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbfDXSOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:14:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34206 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733204AbfDXSOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:14:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id y16so6995781ljg.1;
        Wed, 24 Apr 2019 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BApSBrHWisHavDzlSaMeCHbqeb82OQxHyjXmv1jF2lg=;
        b=Rm42g9zm0D13PRG00EFQRBQT6gyD3Ljo2oUqSaW9XRRuTq9ESWxCnnoC006pn8cciI
         9Fariz5tEFi3T+pmSlqdlLWHmEHx+Nd05tVZa/IL9ab4BVVspIFQErKv/74Gz5njrXGJ
         I6ugZ4WL2LOQM8tdwtxKWWTJjfSyzihQaTYmxqH2pgMj5VJ2yIGY5ElXj+c04WUHPFRE
         +83omq9EQDkg3QArTR48RPGH6dGLpu/nmF6at4P7cBky6l+7/oTufl9pnxg71ouRPkuT
         P4ZR39mVRuccU8OJQrpGKvtipmUu5Xbmaij43PDrvPw9sqDR7G7XO1xzcQY2CwPXkNOr
         uZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BApSBrHWisHavDzlSaMeCHbqeb82OQxHyjXmv1jF2lg=;
        b=FcGX7CJ/V3ChoJkVZ2vsYLMH86UF0Vpo8tSDhiE3FDhoARLLXMHQSqG4ZWD/0iY03q
         PaF+yYJ7yjICSbFCr7/rnQplL+N3BFhiVz/b2TI3ugRTIY8majLWcLsdWZ88yCAKW32V
         cps0dEmLxz9hRLovYYMMKLZZFLldknsPHz/45U0JXndj8AIQgdTPzmaQbiWDMJOxdW6B
         zi5b/7xee9GJrvh5+a7aP4sclkELv3DdJmPuLm2zMp+GaPY39LJRy4Kjpha1FC3ZUxJ4
         KCy7O362aIZYHO6r971h0uwJ5iYwAIKWskv3RsiAugO/Z7R3SsNM7vKiy3pcUI1ZsNC1
         bLjw==
X-Gm-Message-State: APjAAAUW/4UaBFabaHbu5LyW4z15Xjg5Sh2ZY3F+JHpeCMM3LHY/hv+F
        rPxICSYEsf3abxjBqXZHucI=
X-Google-Smtp-Source: APXvYqwo3QsIfhrr96a7mWSCMCf0fwdTJVLsGref6OEanKjTLyQFY3ChU05e8OU2FD7K9gsGqvnfIw==
X-Received: by 2002:a2e:9993:: with SMTP id w19mr2950625lji.111.1556129684377;
        Wed, 24 Apr 2019 11:14:44 -0700 (PDT)
Received: from [192.168.1.19] (bkw231.neoplus.adsl.tpnet.pl. [83.28.190.231])
        by smtp.gmail.com with ESMTPSA id y23sm4347983lfy.31.2019.04.24.11.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 11:14:43 -0700 (PDT)
Subject: Re: [PATCH v4 04/26] dt-bindings: leds: Add LED_COLOR_ID definitions
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
 <20190417205439.17685-5-jacek.anaszewski@gmail.com>
 <20190424134915.GB14360@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <569cc402-f63a-c8e3-8af1-132a674c5da3@gmail.com>
Date:   Wed, 24 Apr 2019 20:14:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424134915.GB14360@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

On 4/24/19 3:49 PM, Pavel Machek wrote:
> On Wed 2019-04-17 22:54:17, Jacek Anaszewski wrote:
>> Add common LED color identifiers.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linaro.org>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Dan Murphy <dmurphy@ti.com>
>> Cc: Daniel Mack <daniel@zonque.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: Simon Shields <simon@lineageos.org>
>> ---
>>   include/dt-bindings/leds/common.h | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
>> index da0539490cea..d8c8c38700bd 100644
>> --- a/include/dt-bindings/leds/common.h
>> +++ b/include/dt-bindings/leds/common.h
>> @@ -56,4 +56,15 @@
>>   #define LED_FUNCTION_WLAN "wlan"
>>   #define LED_FUNCTION_WPS "wps"
>>   
>> +/* Standard LED colors */
>> +#define LED_COLOR_ID_WHITE	0
>> +#define LED_COLOR_ID_RED	1
>> +#define LED_COLOR_ID_GREEN	2
>> +#define LED_COLOR_ID_BLUE	3
>> +#define LED_COLOR_ID_AMBER	4
>> +#define LED_COLOR_ID_VIOLET	5
>> +#define LED_COLOR_ID_YELLOW	6
>> +#define LED_COLOR_ID_IR		7
>> +#define LED_COLOR_ID_COUNT	8
> 
> The "_COUNT" define confused me. I was trying to figure out what color
> it is. We sometimes have "_MAX" in that meaning. 

Ack.

> Probably can be merged with previous patch?

Ack.

-- 
Best regards,
Jacek Anaszewski
