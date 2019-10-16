Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF193C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F09621928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UDSYSJtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391863AbfJPJAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:00:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44819 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389871AbfJPJAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:00:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so27050396wrl.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FWwSZ7wVHB66iuc6hwPySPcSnpuZXmN+p1/bCDDEZAo=;
        b=UDSYSJtEKugyDuq3KMpdtgOOFzhbwAnFU4ZHVk/+xe+ABJ96+ug84qKCiMiV2jqyQa
         Njv7sRzHFCpauHdKZFWwRP0m+5MVLn4AhaVYieFt49Ho2dYnBY0vn7k5Ug+Nl/Ghq+o6
         nveOswF2JtJ4xceyVyyooCOCmvd8HTws5+h5VU6uUQThGLvMa+oqwNKyS+7Twodw3CjA
         48R3xyCTlsZ47z46SHSH/GQ8WYVK6Xlejnmg/w+peYethFa0qHtGR+77fN48BWDtdUO0
         srnSh4tnrIuhDEiNUJc01vM7ctZtyAV1kuVzeIJ37ajYYxFRR/T1MHZm8DsbfAfdWTrX
         9SfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FWwSZ7wVHB66iuc6hwPySPcSnpuZXmN+p1/bCDDEZAo=;
        b=uk/MzmI0sWWKErC6TwHyAjSU8UoXdtPQ9UFeS0+EXW/MkFIxLlKHpgu5abqQUgpHW3
         H3MxxNwsZlgONPe6p4qaF7bm8Z5xJS+UzD/UXq0HBZnu+VKXB8awsrEGLBd24O0FYimd
         cEJ1JMtE2+FOYNzrxUxmMMxV7xfkQcg6TtS/qgLU09CL1R2VjFHO9INNCgIwULZ11ka+
         2FjieB4ud91iP/7+iNtitG2QwKvvENDHvokJq1TGu5ioUz6qUqDEZdvWD3xAqY+hdTCE
         P7eoW107NEareUJfrL7qGeYIhT4IzE17Y2u8MjAghTLn5ymkOOWhegagFwXwRgDqPnry
         9ptA==
X-Gm-Message-State: APjAAAXHu1c2Ar9UOyQmIZzPWs6r0dvuD22tyUGAbVgE5tE3Mhagffbn
        s1Fv7iP8LVnRp3JeF8GMnEtWwg==
X-Google-Smtp-Source: APXvYqy8jmTWK22einYBZkkJUT3gZQaCWv3cRPLnG6y72qAhJWTSUhHTPba7TgOkJn0GB6oggXGTqA==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr1616456wrx.197.1571216414621;
        Wed, 16 Oct 2019 02:00:14 -0700 (PDT)
Received: from [10.1.4.98] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p85sm2026845wme.23.2019.10.16.02.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 02:00:13 -0700 (PDT)
Subject: Re: [PATCH v7 4/7] arm64: dts: meson: g12: Add minimal thermal zone
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
References: <20191004090114.30694-1-glaroque@baylibre.com>
 <20191004090114.30694-5-glaroque@baylibre.com>
 <CAHLCerOzZ6kc0nrGL+XMi37WuBKUv6E0yzE26wUZ5XoRMS8q6w@mail.gmail.com>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <347c0fe0-62de-8ef5-c1ca-8958fef81820@baylibre.com>
Date:   Wed, 16 Oct 2019 11:00:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHLCerOzZ6kc0nrGL+XMi37WuBKUv6E0yzE26wUZ5XoRMS8q6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/16/19 1:20 AM, Amit Kucheria wrote:
> On Fri, Oct 4, 2019 at 2:31 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
>> Add minimal thermal zone for two temperature sensor
>> One is located close to the DDR and the other one is
>> located close to the PLLs (between the CPU and GPU)
>>
>> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>> Tested-by: Kevin Hilman <khilman@baylibre.com>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>  .../boot/dts/amlogic/meson-g12-common.dtsi    | 57 +++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> index 0660d9ef6a86..a98c16e163c2 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> @@ -12,6 +12,7 @@
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
>>  #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
>> +#include <dt-bindings/thermal/thermal.h>
>>
>>  / {
>>         interrupt-parent = <&gic>;
>> @@ -94,6 +95,61 @@
>>                 #size-cells = <2>;
>>                 ranges;
>>
>> +               thermal-zones {
>> +                       cpu_thermal: cpu-thermal {
>> +                               polling-delay = <1000>;
>> +                               polling-delay-passive = <100>;
> Ordinarily, you would need to set these delays to 0 in interrupt mode
> to prevent polling overhead. I've just submitted a patch to of-thermal
> that should fix this requirement. Could you check if it works for you?

it's working for me.

thanks for your review.

>> +                               thermal-sensors = <&cpu_temp>;
>> +
>> +                               trips {
>> +                                       cpu_passive: cpu-passive {
>> +                                               temperature = <85000>; /* millicelsius */
>> +                                               hysteresis = <2000>; /* millicelsius */
>> +                                               type = "passive";
>> +                                       };
>> +
>> +                                       cpu_hot: cpu-hot {
>> +                                               temperature = <95000>; /* millicelsius */
>> +                                               hysteresis = <2000>; /* millicelsius */
>> +                                               type = "hot";
>> +                                       };
>> +
>> +                                       cpu_critical: cpu-critical {
>> +                                               temperature = <110000>; /* millicelsius */
>> +                                               hysteresis = <2000>; /* millicelsius */
>> +                                               type = "critical";
>> +                                       };
>> +                               };
>> +                       };
>> +
>> +                       ddr_thermal: ddr-thermal {
>> +                               polling-delay = <1000>;
>> +                               polling-delay-passive = <100>;
>> +                               thermal-sensors = <&ddr_temp>;
>> +
>> +                               trips {
>> +                                       ddr_passive: ddr-passive {
>> +                                               temperature = <85000>; /* millicelsius */
>> +                                               hysteresis = <2000>; /* millicelsius */
>> +                                               type = "passive";
>> +                                       };
>> +
>> +                                       ddr_critical: ddr-critical {
>> +                                               temperature = <110000>; /* millicelsius */
>> +                                               hysteresis = <2000>; /* millicelsius */
>> +                                               type = "critical";
>> +                                       };
>> +                               };
>> +
>> +                               cooling-maps {
>> +                                       map {
>> +                                               trip = <&ddr_passive>;
>> +                                               cooling-device = <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +                                       };
>> +                               };
>> +                       };
>> +               };
>> +
>>                 ethmac: ethernet@ff3f0000 {
>>                         compatible = "amlogic,meson-axg-dwmac",
>>                                      "snps,dwmac-3.70a",
>> @@ -2412,6 +2468,7 @@
>>                         assigned-clock-rates = <0>, /* Do Nothing */
>>                                                <800000000>,
>>                                                <0>; /* Do Nothing */
>> +                       #cooling-cells = <2>;
>>                 };
>>         };
>>
>> --
>> 2.17.1
>>
