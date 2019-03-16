Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A674C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A4A218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ii2n3G+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfCPOmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:42:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43105 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfCPOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:42:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so12445343wre.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=WzUIHQxCNMlTcr2lcRulVSigdhGj2YLRtdawsHFTcCI=;
        b=ii2n3G+4PZ7Vl2XnPhHc7ZpUyAC+6b/ORlw6ipUGXinOBebxSLu4xwMl4MQCYwngcK
         LWVhJg8z8U7/JwFpDHfawWEMlcHepqneuYmvY2u2uHi2FpD5rJRaBXm34/rCZayarwT9
         ANN3b1peQxhzQk0nZI+BljWKHUrY4OVeddn/eXzO6tkPd4CiMJYlNhiferZ+B2i6dHlt
         +pLOxArXXF2c5/8koQtDf+snTMNghIYzN9MKR3NRUEG2IJTGO/9BU3FGnYaRA2zQy9ZX
         ju1Mg0Q3GuI3KgXgFe9fNsXg5TtncTgLGJkID2VRWUrprbVmUHnozb/W1JGXkCOl5JUp
         shSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=WzUIHQxCNMlTcr2lcRulVSigdhGj2YLRtdawsHFTcCI=;
        b=bq4MV3y+fYm3MWsrmgOcrcx+6oMKK2j1t1YTnvphujN+fslpfQFAXl7jxqzGSynRpo
         8Sj5OKUJZujgn0bafFP+rSTIjOmHNI12EHc11hiDpdln1OxpAhxhKealJIVwXPohFNA7
         PrHRI+1p48/REWJX0QZILpjxP4+fDfy8FzJhiXgzUcOIrobctg14n9WSZEYkeakmLWPq
         YMDnahF8n3wdt9yeWUH+s9/IQ19OIsUCOJHKPQ9HpIru97I+6/gqSkf1aNUTsseuYDOJ
         YBWlFjR0K4fWhNaD6iyHjBVj4yY+JTz2o409xyAKv+W2BxRjlfjOnLPbEUUFTQGGsBHN
         UdKA==
X-Gm-Message-State: APjAAAWO4ZfHbbku/QHBpnMFXi0bndKCSGjOr54uX0scsOXaGTh+W20f
        pQmha/CKU4UHhl3th/Zbz6z0oQ==
X-Google-Smtp-Source: APXvYqw5fPmMuJtK2qtAhgGy38HgStocKMVEgmfcER/zf/cKTGGKHt1YbPoLZ11A3Fa1dWR0/rjY0g==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr2354381wrw.167.1552747319381;
        Sat, 16 Mar 2019 07:41:59 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id s187sm6676833wms.7.2019.03.16.07.41.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Mar 2019 07:41:58 -0700 (PDT)
Message-ID: <5C8D0B35.9080704@baylibre.com>
Date:   Sat, 16 Mar 2019 15:41:57 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Guillaume La Roque <glaroque@baylibre.com>
CC:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/11] arm64: dts: meson-g12a-x96-max: add regulators
References: <20190311095613.11371-1-narmstrong@baylibre.com> <20190311095613.11371-7-narmstrong@baylibre.com> <CAFBinCBEeCAKuzOztT5wU1t9UvY=ocVVrdHB6PNG7pp+gXq1=A@mail.gmail.com>
In-Reply-To: <CAFBinCBEeCAKuzOztT5wU1t9UvY=ocVVrdHB6PNG7pp+gXq1=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/03/2019 23:05, Martin Blumenstingl a écrit :
> Hi Neil and Guillaume,
> 
> On Mon, Mar 11, 2019 at 11:04 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> From: Guillaume La Roque <glaroque@baylibre.com>
>>
>> Add system regulators for the X96 Max Set-Top-Box.
> the hint from the "meson-g12a-sei510: add regulators" patch would be
> great here as well:
>   Still missing
>   * VDD_EE (0.8V - PWM controlled)
>   * VDD_CPU(PWM controlled)
>   * VDDQ1_5
> 
> I'm not sure whether this board also has VDDQ1_5 though, but VDD_EE
> and VDD_CPU should be very similar (or even identical)
> 
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 65 +++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
>> index 0edbd00b358f..21e5de48613e 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
>> @@ -21,6 +21,71 @@
>>                 device_type = "memory";
>>                 reg = <0x0 0x0 0x0 0x40000000>;
>>         };
>> +
>> +       flash_1v8: regulator-flash_1v8 {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "FLASH_1V8";
>> +               regulator-min-microvolt = <1800000>;
>> +               regulator-max-microvolt = <1800000>;
>> +               vin-supply = <&vcc_3v3>;
>> +               regulator-always-on;
>> +       };
>> +
>> +       main_12v: regulator-main_12v {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "12V";
>> +               regulator-min-microvolt = <12000000>;
>> +               regulator-max-microvolt = <12000000>;
>> +               regulator-always-on;
>> +       };
> mine has a 5V DC in. can you please check this on your board?

Indeed it's a bad copy/paste from SEI510

> 
> 
> Regards
> Martin
> 
