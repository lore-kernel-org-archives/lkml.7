Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8311C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA3920854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pYgJnenz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCSIrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:47:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42116 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSIrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:47:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so15931282wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yIVUpFT1lEydIfcMRWWjhrc92o9HQB+EYcR6hcq9WNM=;
        b=pYgJnenzPmy+7Yc9fuiLFIp4xDD8nVQjY07P5YOoaQQhuus0j8p8mpXK5mmhuGG+UB
         s2EtBwkSKyF+J5WVz8I4nXMnCCuVknB0R4BYqtGvUv0e3J4UASvaIXTblHVe0Wkdma3Y
         Rw2FcXOjBDDJSQw01ldrES4l0cT4za5+cwgOa9Ij3o0wYQCgoD4yb26S863RS2urdTNO
         xwxblGHJ3L6WdVO/NLYCcjQvwjVYAUQ6J/9JnPhdniIj+q1uYRh8uAhl2ytSKEsxBrzw
         dOMQ6xSEqCvxoSJUa7nReikzdI8xYQE7iysOX9t0ykvoDiRwiBFqHr2sENlYpY3mv6QD
         koFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yIVUpFT1lEydIfcMRWWjhrc92o9HQB+EYcR6hcq9WNM=;
        b=Jddrs3Av08KniWhAthdyfGhZP2JzdfMNUx1WVzMqkHlOYMFx/8wuSpvnLnOJ5PnwzQ
         xT5HLHWf6Uh+cz6Ax/nO74BLRmFh9qMdpobjISaiMTZquHE/Ooj8upxyEho4obUKG5um
         QBIi1OxxIeNT8x60fdCxBz96BUnfbU2Vuz2+v9aIVev6pEfYYbstb+M0bcUPPyqB8SYp
         oyla4RjYM5RKqhK6Vnc/V1mRBvh2Xe7ZKHzMqqQdihNgSsdunUMjpw8C/nFU4SzkvHVI
         +mISyxU6Vta7Wq6/N/jlOaHwo2UnOLgfVxKWKqKgCxTQwPk8s8YKL+sz+yVG/HfuZcfS
         GreA==
X-Gm-Message-State: APjAAAUij9Pqo+FPqB9vZFoYrywbRI+pBk2potOkI0uAtDDKI/60vrwF
        5oNjs4jHgA7vDE6wYEHjbxEJgQ==
X-Google-Smtp-Source: APXvYqyPYI1v+d9WVwT89cFV8+7on49m9D6GDfT5lZ28P/Q76YGIF8+gpmQAROwdE9g+ykL6rxOt+A==
X-Received: by 2002:a5d:6981:: with SMTP id g1mr13449738wru.326.1552985227844;
        Tue, 19 Mar 2019 01:47:07 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id c126sm2588228wma.0.2019.03.19.01.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 01:47:07 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] arm64: dts: meson: g12a: Add AO Clock + Reset
 Controller support
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190318095851.4062-1-narmstrong@baylibre.com>
 <20190318095851.4062-2-narmstrong@baylibre.com>
 <CAFBinCDfOEvmQcE7TgYvXmM1f=pywYbjhbAZWs4AYNXs8y6y7Q@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <7f391daf-db70-101a-18c7-04abf9c5a164@baylibre.com>
Date:   Tue, 19 Mar 2019 09:47:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCDfOEvmQcE7TgYvXmM1f=pywYbjhbAZWs4AYNXs8y6y7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2019 21:02, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Mon, Mar 18, 2019 at 10:59 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Add nodes and properties for the AO Clocks and Resets.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> index 31ddf9444b3e..5c0983edf837 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> @@ -4,6 +4,7 @@
>>   */
>>
>>  #include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/clock/g12a-clkc.h>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>
>> @@ -122,6 +123,23 @@
>>                         #size-cells = <2>;
>>                         ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
>>
>> +                       rti: sys-ctrl@0 {
>> +                               compatible = "amlogic,meson-gx-ao-sysctrl",
>> +                                            "simple-mfd", "syscon";
>> +                               reg = <0x0 0x0 0x0 0x100>;
>> +                               #address-cells = <2>;
>> +                               #size-cells = <2>;
>> +                               ranges = <0x0 0x0 0x0 0x0 0x0 0x100>;
> sorry for noticing this only very late: I missed the #address-cells,
> #size-cells and ranges property in my last review
> do you have any change queued which requires this?
> my understanding is that the drivers for all RTI children should use
> the register offsets relative to the RTI start address. In that case
> the child nodes neither have a unit-address nor a reg property, making
> the last three properties unnecessary.

We need the address-cells/size-cells and `ranges;` to satisfy the need
for the gpio subnode of the pinctrl node.

For GX, we didn't add the pinctrl in the sysctrl_AO subnode, but we should
overwise we have overlapping.

Neil

> 
> 
> Regards
> Martin
> 

