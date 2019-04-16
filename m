Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC6DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10394206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nb9r/ObQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfDPIJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:09:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35383 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbfDPIJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:09:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so12186568wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 01:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QULGWttfcYVMWXLo/sdQLVGyglVz6xrWAgoO0aZe4xE=;
        b=Nb9r/ObQV8eZAS1Eje/jUKTuUK5BUX4ZBpRuqs3NdqXic/y0zlpuxUcuUqjFjb3//y
         T6+g8nU6ICz9ppi68TPOw72G7aCS4vxMsKudKOd2tJZkDYQOtc//7JQa0o0qsqW4b45b
         6JRW/WDVERtNpQVUfZQ95pBtSBIZPVFwjmgXAzTX5vxzIkGGzAJ4RuLTCV/ASCzYzy0R
         FBrxpJyKSuDAJXLpJpUEDPvS2F/7ZszESwR8iYMzDWthp9rzIvOAd7wl+iKUvGwSHIB6
         WH65EtdDy4R9WI3Rf7d727pQvherGBPRl6SvxzPWq6N22re8bRIZ/F57g6a9WyH+Oc2v
         MM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QULGWttfcYVMWXLo/sdQLVGyglVz6xrWAgoO0aZe4xE=;
        b=GiQPyrEL/y5Q3VcDwx/4VbUTYttRVlXpetWmyX8ovPqQGhSyWHKEZdcDcb7IumtUQO
         Jv65hBsjuNqInLWjE7sUDu1Aae+bQDP0N2NlFORqhHUS6w8n4RYVpqSKlTBsDSjVmcPC
         9rwBpO5ut+3NGr/kGfmYXlmOOmyAkwh5HJC6+vqnrzQtfBNdc+lirkQpvpdz3cMrDYet
         wrfZDq5pPIxye8diPoiPZDam88BcBbKvRzj2fboc3f4/isFW4uX38GxMYTbg9FwEYWUk
         WWShyaBcfErwxvzxP9+waE5BIAiGNKOarGXq12fQqVHVcrPKIJvflcolNvpPGfXX34Pc
         6qEQ==
X-Gm-Message-State: APjAAAV3Ih71SfY3jC87hQmDqXnWj9b2J949iDkIWI6H5LMXe9EQnMay
        c1+hoF8RllmFD6Sr8pt7YnUW8w==
X-Google-Smtp-Source: APXvYqyd/mMCIxOgtxk+5cUT8P7w6HRcUSsmFkOOk3Qt88R0HHow9yP9Ebnz2E9kBRw4V8VQepmPBA==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr24749123wmf.107.1555402190784;
        Tue, 16 Apr 2019 01:09:50 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id s18sm20983941wmc.41.2019.04.16.01.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 01:09:50 -0700 (PDT)
Subject: Re: [PATCH 18/24] dt-bindings: timer: mtk-timer: add support for
 MT8516
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-19-fparent@baylibre.com>
 <182f1ae5-9f4f-8ef4-695f-353bbd1966c6@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e4895191-c267-7b0b-6203-8e4ff44927e0@linaro.org>
Date:   Tue, 16 Apr 2019 10:09:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <182f1ae5-9f4f-8ef4-695f-353bbd1966c6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2019 09:54, Matthias Brugger wrote:
> 
> 
> On 23/03/2019 22:16, Fabien Parent wrote:
>> Add binding documentation of mtk-timer for MT8516 SoC.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>>  1 file changed, 1 insertion(+)
> 
> applied to v5.1-next/dts64
> 
> Daniel let me know if you want to take it through your tree and I drop the patch.

It is ok.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> index ff7c567a7972..74c3eadad844 100644
>> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> @@ -17,6 +17,7 @@ Required properties:
>>  	* "mediatek,mt8127-timer" for MT8127 compatible timers (GPT)
>>  	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
>>  	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
>> +	* "mediatek,mt8516-timer" for MT8516 compatible timers (GPT)
>>  	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
>>  
>>  	For those SoCs that use SYST
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

