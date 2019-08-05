Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C73C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70BF20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uemqmpa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfHEJln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:41:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33185 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfHEJln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:41:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so6260063wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zwVFHt+48HDHPxY5b54ZFa7xoeFEjvHa3khRmzD7FKU=;
        b=uemqmpa5kVFXiavwLe6yqYrDmEZZV7Fcfsv21+JFTYqvKAtB5dvFEWIr4grJOpmSRp
         denJH6xQUZDRMwrqyhoKWcKx0lvzboWIwlSDmy82BgpPOXrpCKAxdpqxVSKSRipCOh7s
         pqGeT1q/7andPM62LzouFLClYDxeAW+3CDCE5wWZakpPw1H0n1TCp398yGA/dFMJ2T0S
         I3uOcmxbIsoZudjPF9sJzz8l55xuAM7Wb6TgrxVG7WuwkXdtusMHMerDRBUXnVZpPVOA
         RCE8ecEsdXVrfBZech4vOgi8/sgNY60ua7JQ/cuqCB0kbeyI2qT2Z5HQrvdQndmit9Mq
         2diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zwVFHt+48HDHPxY5b54ZFa7xoeFEjvHa3khRmzD7FKU=;
        b=WdkverofzMpF0tLVDZq8ZO47A9M0ih/IY/G1XJm+hpzE4iCih1rrIF6E6RuGS7HjXw
         /gjcl9FNsbqh/dB4XoGWrY6efJbGzBfmub7XZgIib9a3cpL0CNLww6TLOTzwvliqaV64
         Qz0rcP0WvBYiz2wxjl4h2C9eDBew2SzCNYmUpjXHosgOZoys2QAdpEaZTwvSsiSWzv3s
         w10vdiQGZn7xxFgDnjiY161Q0tjSvzApYIGbr0R2N6j/2+sEiPZvpzo+tH888mQ5YyiY
         RfkTH+ZrF8wV7iPZ0N0V8VtjhK+aCwEsip0dgP4/FG/BNa3+B4jnLqXQzQTXR7xWcfR3
         i1bQ==
X-Gm-Message-State: APjAAAXAgO2hejYzFGvathXLl6yyEPTen2XxdAKl+zeAZ3jJHpu6rcmW
        hvv/VT6MwgnNb5CBM0eyO9kyFQ==
X-Google-Smtp-Source: APXvYqxUqLSyKoX3kBT5LqfmayHxL8IsZIurFOcWjSA/ZAELqlanwnjiTdxfqjeBVGrR1f0Qv4G6Aw==
X-Received: by 2002:a1c:1a87:: with SMTP id a129mr17580112wma.21.1564998101244;
        Mon, 05 Aug 2019 02:41:41 -0700 (PDT)
Received: from [10.1.4.98] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a81sm90371174wmh.3.2019.08.05.02.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 02:41:40 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] arm64: dts: amlogic: g12: add temperature sensor
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     daniel.lezcano@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20190731153529.30159-1-glaroque@baylibre.com>
 <20190731153529.30159-4-glaroque@baylibre.com>
 <CAFBinCBYPiLgmTNk+7Db3EPSPePwbnAshCbomYPXWdse8i0oJw@mail.gmail.com>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <d702eb8b-f0b7-0b3b-9a17-1d158d7c072f@baylibre.com>
Date:   Mon, 5 Aug 2019 11:41:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCBYPiLgmTNk+7Db3EPSPePwbnAshCbomYPXWdse8i0oJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Martin,


thanks for comments i will fix in v3.


guillaume

On 8/3/19 7:52 PM, Martin Blumenstingl wrote:
> Hi Guillaume,
>
> On Wed, Jul 31, 2019 at 5:36 PM Guillaume La Roque
> <glaroque@baylibre.com> wrote:
>> Add cpu and ddr temperature sensors for G12 Socs
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> with the nit-pick below addressed:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
>> ---
>>  .../boot/dts/amlogic/meson-g12-common.dtsi    | 22 +++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> index 06e186ca41e3..7f862a3490fb 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> @@ -1353,6 +1353,28 @@
>>                                 };
>>                         };
>>
>> +                       cpu_temp: temperature-sensor@34800 {
>> +                               compatible = "amlogic,g12-cpu-thermal",
>> +                                            "amlogic,g12-thermal";
>> +                               reg = <0x0 0x34800 0x0 0x50>;
>> +                               interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
>> +                               clocks = <&clkc CLKID_TS>;
>> +                               status = "okay";
> I believe nodes are enabled automatically if they don't have a status property
>
>> +                               #thermal-sensor-cells = <0>;
>> +                               amlogic,ao-secure = <&sec_AO>;
>> +                       };
>> +
>> +                       ddr_temp: temperature-sensor@34c00 {
>> +                               compatible = "amlogic,g12-ddr-thermal",
>> +                                            "amlogic,g12-thermal";
>> +                               reg = <0x0 0x34c00 0x0 0x50>;
>> +                               interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
>> +                               clocks = <&clkc CLKID_TS>;
>> +                               status = "okay";
> same here
>
>
> Martin
