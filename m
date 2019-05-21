Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671A9C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCED216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IfEy8V57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfEUIbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:31:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56300 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfEUIbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:31:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id x64so1970578wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rLMkeC7ZDWiCEDicTHIFFXWJRw7Y+FUp1ZFBHZUECXU=;
        b=IfEy8V578LipWbHiK+656YA9HrusDOf2tatzFFberJxM8l9wvNnqZOv8T26LJznUwy
         mpiBYnlHFiKRuAIqeN51CAsBCBlvpKxVzlnjX9sQt5zXkbPtNlVcVoAf1/TJm2ys8c9H
         /gB0RI8aaDUGg2Tu5DSIa2STuICM60Fa9gds8f8HHaIMLvOWq9JG3a2Sh/ScQzzPT0le
         vjx/xO4q5UFLWuVsrdfjJAXoGTSFm9YXpkOxF/yqeXEGe0p7vyOPdaA6BhtrtIz50VWw
         +GpZJQsAhVlPSZSvHBv0jr7EerIbSnWgEW3T9rQaNq1rZo8nrFyW+kINsVgj/DAna8jT
         32XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rLMkeC7ZDWiCEDicTHIFFXWJRw7Y+FUp1ZFBHZUECXU=;
        b=C7404QS077WdiTu6544Ixii9+7VUFBKMM9BLRQykNgTkON13NsG4+fdRJBkgIZurgy
         SGfKHLacSiqdtQp75rbn4vyV2olLlXB1gSFfBdBknbkBvljWhc/7X6PM3sqdg44PAp40
         sRamYiAvMJ8R/pK20JPfdo6YA6tIcYDbPX8jKEF6MSGmL0t0d6ONlZ8Uxt6cxEr44bUy
         OfCzEufRbtz6BoPZ5VIGHzHHj2WE31AfPswBjEGrgOffcPxlF2CfUdDQzdoB8IaZkyL3
         iODdDM1xZyF3sdd/mmO0YjqgnoUWFkB+AZ1LUpLJUoK+AHIPSwaXem56tvHN77NFwk0+
         pZMA==
X-Gm-Message-State: APjAAAXaDGsJJyKmSH+awcalm4DuN8tSP+Y5a0LmhKkJ+8hyzmxPGg28
        CLFknQ8EQPoJeEsCe08FAezw1w==
X-Google-Smtp-Source: APXvYqzW/vxXveXXp97Sm//lu9OId1XXCD+8TbOi05FaHmAfbUrFEIWSXyfqRMy9HLFH2Vma+HKO5A==
X-Received: by 2002:a1c:7a0d:: with SMTP id v13mr2654747wmc.44.1558427478814;
        Tue, 21 May 2019 01:31:18 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d9sm25075013wro.26.2019.05.21.01.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:31:18 -0700 (PDT)
Subject: Re: [PATCH 3/3] arm64: dts: meson: g12a: Add hwrng node
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190520134817.25435-1-narmstrong@baylibre.com>
 <20190520134817.25435-4-narmstrong@baylibre.com>
 <CAFBinCD6wJnYd3-E=kS6WCZLFebV9JYk-GybBxoMA8qQqGfSHw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <f4a1f115-d886-ddf3-c4fc-ea995f10a434@baylibre.com>
Date:   Tue, 21 May 2019 10:31:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCD6wJnYd3-E=kS6WCZLFebV9JYk-GybBxoMA8qQqGfSHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2019 19:45, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Mon, May 20, 2019 at 3:49 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The Amlogic G12A has the hwrng module in an unknown "EFUSE" bus.
>>
>> The hwrng is not enabled on the vendor G12A DTs, but is enabled on
>> next generation SM1 SoC family sharing the exact same memory mapping.
>>
>> Let's add the "EFUSE" bus and the hwrng node.
>>
>> This hwrng has been checked with the rng-tools rngtest FIPS tool :
>> rngtest: starting FIPS tests...
>> rngtest: bits received from input: 1630240032
>> rngtest: FIPS 140-2 successes: 81436
>> rngtest: FIPS 140-2 failures: 76
>> rngtest: FIPS 140-2(2001-10-10) Monobit: 10
>> rngtest: FIPS 140-2(2001-10-10) Poker: 6
>> rngtest: FIPS 140-2(2001-10-10) Runs: 26
>> rngtest: FIPS 140-2(2001-10-10) Long run: 34
>> rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
>> rngtest: input channel speed: (min=3.784; avg=5687.521; max=19073.486)Mibits/s
>> rngtest: FIPS tests speed: (min=47.684; avg=52.348; max=52.835)Mibits/s
>> rngtest: Program run time: 30000987 microseconds
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> index 8fcdd12f684a..19ef6a467d63 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> @@ -197,6 +197,19 @@
>>                                 };
>>                         };
>>
>> +                       apb_efuse: bus@30000 {
>> +                               compatible = "simple-bus";
>> +                               reg = <0x0 0x30000 0x0 0x1000>;
> the public S922X datasheet lists the range as FF630000 - FF631FFF
> that translates to a size of 0x2000, which the vendor kernel
> (kernel/aml-4.9/arch/arm64/boot/dts/amlogic/mesong12a.dtsi from
> buildroot-openlinux-A113-201901) seems to use as well:
>   io_efuse_base{
>     reg = <0x0 0xff630000 0x0 0x2000>;
>   };
> 
> where did you take the size from?

Another typo, it's 0x2000.

> 
>> +                               #address-cells = <2>;
>> +                               #size-cells = <2>;
>> +                               ranges = <0x0 0x0 0x0 0x30000 0x0 0x1000>;
> (see reg property above)
> 
>> +
>> +                               hwrng: rng {
> this should be rng@218

Exact.

> 
> 
> Martin
> 

Neil
