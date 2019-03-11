Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79792C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C26A2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N27nd80L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfCKRXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:23:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44102 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKRXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:23:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id w2so6036543wrt.11;
        Mon, 11 Mar 2019 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tFmfxaq3EnQ8Od/jdQOYUsdpO+6bAUe2v8Xw1DfErDk=;
        b=N27nd80LOW62mrNtDeFSpGJKTQ4wrqbfH/q9Hd+M5sQM3LUxah6bkuwxxToLxeCnxf
         5A48AUJBFLYTiI4skUU8XofYAHnYL7R7Q+x+/Jym24C1XJx4CtGBvRjRGhgkEVA+/i0W
         tDqGhiAld4vnQFxq8iT5SnUp3zAybjPCkjlosJVtBlXCse3Jxs3kCQ40b0949ADJ+3/y
         a5vmFH0lbzxmczCMOFiWHv6fMJOVxf7QL6QmcdSNemxHWcIr4fw/7SBQBubMq6R2CASm
         KmgPDffGiShwcml4qs2CcWRHxZgbt6LZnr2hNcQv6EULB8uGJce6Be0Y04dvvnCKKPBq
         tezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tFmfxaq3EnQ8Od/jdQOYUsdpO+6bAUe2v8Xw1DfErDk=;
        b=LL3Q6oEqS1FxNU3LoxlFQqtr4DO2GuG/THrFAZOrjpCnX961BsjwPBiEVzvkAqbBRU
         0eopqG+FNeGtShFPIiJtJixkRV9zkpilEk4h6p2AbYdR2jWw2Bqz413862yEQMRJB+zZ
         GB30vHU9HmRbzpxHI004LB4dTRmXylMLY/QXDaeJDFB66/TchalFQ6PkokEy07OVrP3h
         yV4ns7f/dqPok1ZMa6eKTTq28gXNt/NhdBfur7EYE5zFr8qsyy5YcuBfgLvyAZ1ji5jL
         kg7ahx7ATqjf9fa9G6fLWMq+iFefDFm5oD11A32tOIJcHRQD5h3m4uETvpm4ZFPY7kfr
         uX4A==
X-Gm-Message-State: APjAAAVW28CrstEakj/c8RXJ1S/Cok5fPare3lnDDswH5k761aBjYmT+
        PbEkMZLCFu9Ewu7vnUUg3rA=
X-Google-Smtp-Source: APXvYqw3IB7tZH6ZcyiwQaht1uKsXUSXtdGXVjFFBeAXqedUWghEE736b+Wnn2fdYuKE5qooLHEotA==
X-Received: by 2002:adf:f30a:: with SMTP id i10mr3993609wro.300.1552324986220;
        Mon, 11 Mar 2019 10:23:06 -0700 (PDT)
Received: from [192.168.1.18] (cka136.neoplus.adsl.tpnet.pl. [83.31.76.136])
        by smtp.gmail.com with ESMTPSA id z6sm14132593wml.40.2019.03.11.10.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 10:23:05 -0700 (PDT)
Subject: Re: [PATCH 04/25] dt-bindings: leds: Add LED_COLOR_NAME definitions
To:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-5-jacek.anaszewski@gmail.com>
 <4b4b5109-2da3-a74f-7e77-c4ab4d34ecbc@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <7151f59e-4413-8e27-4120-c5acfcf9b919@gmail.com>
Date:   Mon, 11 Mar 2019 18:23:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <4b4b5109-2da3-a74f-7e77-c4ab4d34ecbc@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 3/11/19 1:23 PM, Dan Murphy wrote:
> Jacek
> 
> On 3/10/19 1:28 PM, Jacek Anaszewski wrote:
>> Add common LED color name definitions for use in Device Tree.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linaro.org>
>> Cc: Daniel Mack <daniel@zonque.org>
>> Cc: Dan Murphy <dmurphy@ti.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: Simon Shields <simon@lineageos.org>
>> ---
>>   include/dt-bindings/leds/common.h | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
>> index ffcd46317307..0e986bb59391 100644
>> --- a/include/dt-bindings/leds/common.h
>> +++ b/include/dt-bindings/leds/common.h
>> @@ -57,4 +57,13 @@
>>   #define LED_FUNCTION_WLAN "wlan"
>>   #define LED_FUNCTION_WPS "wps"
>>   
>> +/* Standard LED colors */
>> +#define LED_COLOR_NAME_WHITE    "white"
>> +#define LED_COLOR_NAME_RED      "red"
>> +#define LED_COLOR_NAME_GREEN    "green"
>> +#define LED_COLOR_NAME_BLUE     "blue"
>> +#define LED_COLOR_NAME_AMBER    "amber"
>> +#define LED_COLOR_NAME_VIOLET   "violet"
>> +#define LED_COLOR_NAME_YELLOW   "yellow"
>> +
> 
> #define LED_COLOR_NAME_INFRARED	"ir"

Ack.

> Dan
> 
>>   #endif /* __DT_BINDINGS_LEDS_H */
>>
> 
> 

-- 
Best regards,
Jacek Anaszewski
