Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0E0C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8DB2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BCftgX9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgAINN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:13:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46009 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbgAINN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:13:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so7282790wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/rBG0TQpboOYHQ3dtsZ2LO09lSi5DlQHgDK1Z1Ip0gU=;
        b=BCftgX9EKTr00X5H7I/K7vBUiQorQS3fXvQVNfIZE7Z6WJ3Y+U4C9AA0MFcXkMM7uF
         qiubw+mjHA/9fB9cHwlCHLc4/svNqgftQC9XbBb/wq7sYV0Hie1T9QHrWQ3vQUNS77bd
         jDcmLRBkgD6fICBLnJdx1wcr1WE6c/TOY42irLjAZPQoZgm2b8+45ZQMNCJbIORF5fIL
         cIe4GYsFjeE8JYJxiV+hx9+h72c5ie4YUtOl+U2lku4oUzIJKc9TtZB8S7jQEd4MODSm
         vYMHyDVaH2DUUyGEgMo/Rfo8Jxdz63REA/ekA+P53DqTz3pYngAXWwyqNaDySvqdDv2V
         BtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/rBG0TQpboOYHQ3dtsZ2LO09lSi5DlQHgDK1Z1Ip0gU=;
        b=iHUqOZqY58fyotii/whn9+E0SrVDaZ5zUlIwoTP8fKq/WaYxPBRw8fjfaNM4PlEZaq
         iJmNL4HO+E3+AY0gCeDx9Yc2ReG2apkg8Ea1H4c7OTRWYVBobyJmQb+VcqvKlqsIUUNI
         NAlYuV8jJl5dp2nRzymWdCURQovBu0CwAyhZqP+dT8dz9RAR+rYMKm12Q9DJgigrBk20
         urw70/fhaS4ABeSUoB2jLOhOlqxO/6MrLaFmPEyMR+ZM0f0vp6m3TLMiE8KrPAkeIfTC
         H3UTuhh/gW+4EVy3AmocgnPzxhIUXAlGQffzXOF2BrB0aBhcbfznTwUOQ+YEs4Dll3hl
         P8IA==
X-Gm-Message-State: APjAAAUgaxXrqzJQ3JTPs0dlhRF8sf0/OJ6sJkTU7ozPLtipsJPjlJl7
        Ue6GUSLJ0wEBvsraCqfQLQdHhw==
X-Google-Smtp-Source: APXvYqw5xl2LtfiT4yZTxV5PMSEStk6+USro+b+cq5P49/waQtNeQlu36EPIthHWXsqYJeJlJWTwvA==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr10525600wrr.252.1578575604924;
        Thu, 09 Jan 2020 05:13:24 -0800 (PST)
Received: from [10.1.4.98] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q19sm2726293wmc.12.2020.01.09.05.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 05:13:24 -0800 (PST)
Subject: Re: [PATCH v6 1/2] dt-bindings: net: bluetooth: add interrupts
 properties
To:     Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        khilman@baylibre.com
References: <20200109104257.6942-1-glaroque@baylibre.com>
 <20200109104257.6942-2-glaroque@baylibre.com>
 <20200109105305.GL30908@localhost>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <a33f9c30-03a8-ea12-e9d3-5e050e41318e@baylibre.com>
Date:   Thu, 9 Jan 2020 14:13:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109105305.GL30908@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/20 11:53 AM, Johan Hovold wrote:
> On Thu, Jan 09, 2020 at 11:42:56AM +0100, Guillaume La Roque wrote:
>> add interrupts and interrupt-names as optional properties
>> to support host-wakeup by interrupt properties instead of
>> host-wakeup-gpios.
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>> index c44a30dbe43d..d33bbc998687 100644
>> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>> @@ -37,7 +37,9 @@ Optional properties:
>>      - pcm-frame-type: short, long
>>      - pcm-sync-mode: slave, master
>>      - pcm-clock-mode: slave, master
>> -
>> + - interrupts: must be one, used to wakeup the host processor if
>> +   gpiod_to_irq function not supported
>> + - interrupt-names: must be "host-wakeup"
> Looks like you forgot to address Rob's comment. If I understood him
> correctly you either need to stick with "host-wakeup-gpios" (and fix
> your platform) or deprecate it in favour of "interrupts":
>
> 	https://lkml.kernel.org/r/20191218203818.GA8009@bogus

not forgot marcel ask me a v6

for rob comment ok but it's not possible to support gpiod_to_irq on my platform.

if i deprecated it i need to update all DT with good interrupt number right?



> Johan

Regards

Guillaume

