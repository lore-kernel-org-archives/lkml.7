Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3672C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C1B20881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CcGeR7lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfENK3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:29:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36799 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENK3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:29:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id s17so2111166wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 03:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zx18v+pt5qpFKWZn4kjcD7LGGT6wQN2CufNatm+c9iM=;
        b=CcGeR7lcefXCrbxNad2WXV3L3Hy4IRqV9YbVNLIJWDMe6ih+wkswr0C02urPKoWci4
         T7praIeAr7UvdW8cSfMfn1xTp5XCQ9APVEZcYm9dfvbJDkmg+JKbyKCn+J8Qe58WJqlH
         UwUlTwzp/bREiZx4mAW7p6Ts8hqF6rc4dBJTY5DHMboSQ5qHGa1TzLQ7ZaBF+997wI2j
         pDoBzDCfZshScfLYgh71YmcEBNLi5LOQWvkW3ZbkB7VYMbrKiVUpa/qgcHmCtSh+nJiF
         D60h1Kd5NXH9WjNlY3FaFi7S5nmLdsgtDgbfi6WGUdnXKmlvmBB1BYYwyTShhZSjbzWV
         wRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zx18v+pt5qpFKWZn4kjcD7LGGT6wQN2CufNatm+c9iM=;
        b=cX6Wf8aw6zRCGWY7BBnY6LNRrXE6o+XC3IzD/G2geBdAKuYH6S5wGuUDrLZD8Argt3
         38WOrAYWEsD/1NK6+3gpZFlilEnWeo71RpNRtFr3JV9RL3mTfL+WZ55rTeqTI8gxMEIe
         xOIhbUE36XosMwZNM4pmn7uvOnKycg3VybHF3kVHpRxmMVR+sKwYXWOVLtlf1rfSIrGQ
         xiJ10Jo4erqAT/RAKxixWchY61m2KrP8S0Neb41+NiqBDAnVymp3H75b/Wkd+BKEBRzw
         6MjOXlcxeXo/wDt3m/2viYCSVAi+F+X6DFmIvzEjET5/b1khycAykwJCYoxrJrGRess9
         29dw==
X-Gm-Message-State: APjAAAU9P5PjO3zn1EU7zuUezV6iZEZSRQbiVIbF/ZDt6GQ9IppGuPLq
        qL5ICf6Q2SUvhPScZGXRFbyqhg==
X-Google-Smtp-Source: APXvYqxPXMnsuqdgIhu95mY5T47oJBUtljTX+OwiJkwLm4JKIF8EZ4gbi4r9/RvR7z7zcT99Xl130Q==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr21686965wrv.52.1557829756032;
        Tue, 14 May 2019 03:29:16 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id q26sm1922915wmq.25.2019.05.14.03.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 03:29:15 -0700 (PDT)
Subject: Re: [PATCH v4 0/8] Allwinner H6 Mali GPU support
To:     peron.clem@gmail.com, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
References: <20190512174608.10083-1-peron.clem@gmail.com>
 <20190513151405.GW17751@phenom.ffwll.local>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <de50a9da-669f-ab25-2ef2-5ffb90f8ee03@baylibre.com>
Date:   Tue, 14 May 2019 12:29:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513151405.GW17751@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/05/2019 17:14, Daniel Vetter wrote:
> On Sun, May 12, 2019 at 07:46:00PM +0200, peron.clem@gmail.com wrote:
>> From: Clément Péron <peron.clem@gmail.com>
>>
>> Hi,
>>
>> The Allwinner H6 has a Mali-T720 MP2. The drivers are
>> out-of-tree so this series only introduce the dt-bindings.
> 
> We do have an in-tree midgard driver now (since 5.2). Does this stuff work
> together with your dt changes here?

No, but it should be easy to add.

Clément, no need to resend the first patch, it's now on
linus master.

Could you also add support for the bus clock in panfrost
in the same patchset since it's also on master now ?

Neil

> -Daniel
> 
>> The first patch is from Neil Amstrong and has been already
>> merged in linux-amlogic. It is required for this series.
>>
>> The second patch is from Icenowy Zheng where I changed the
>> order has required by Rob Herring.
>> See: https://patchwork.kernel.org/patch/10699829/
>>
>> Thanks,
>> Clément
>>
>> Changes in v4:
>>  - Add Rob Herring reviewed-by tag
>>  - Resent with correct Maintainers
>>
>> Changes in v3 (Thanks to Maxime Ripard):
>>  - Reauthor Icenowy for her patch
>>
>> Changes in v2 (Thanks to Maxime Ripard):
>>  - Drop GPU OPP Table
>>  - Add clocks and clock-names in required
>>
>> Clément Péron (6):
>>   dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
>>   arm64: dts: allwinner: Add ARM Mali GPU node for H6
>>   arm64: dts: allwinner: Add mali GPU supply for Pine H64
>>   arm64: dts: allwinner: Add mali GPU supply for Beelink GS1
>>   arm64: dts: allwinner: Add mali GPU supply for OrangePi Boards
>>   arm64: dts: allwinner: Add mali GPU supply for OrangePi 3
>>
>> Icenowy Zheng (1):
>>   dt-bindings: gpu: add bus clock for Mali Midgard GPUs
>>
>> Neil Armstrong (1):
>>   dt-bindings: gpu: mali-midgard: Add resets property
>>
>>  .../bindings/gpu/arm,mali-midgard.txt         | 27 +++++++++++++++++++
>>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  5 ++++
>>  .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  5 ++++
>>  .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  5 ++++
>>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  5 ++++
>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 14 ++++++++++
>>  6 files changed, 61 insertions(+)
>>
>> -- 
>> 2.17.1
>>
> 

