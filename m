Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0822C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFDE23405
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wVZ55Waw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389523AbfHVT7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:59:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45375 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388369AbfHVT7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:59:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so4273949pgp.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=AcjZhREukP3aBHVQXFfPG6Q2ywPCmP6+Qew3XzM2o+o=;
        b=wVZ55WawdDOCTkUmu4owRRdkz8MnTITewlCRS+ng278aKsUlHBFKiuPLP+5rv0d0cC
         7b076tHjPwD6gcK1g+MI60bROfKFBFpc5CzBqTz1opgbw3A42OfNlQ79WS9+YEZwK9kS
         SkfefD2uRa8kJTJQPKjxv0Gg7ju/eywmq8060njWxDLT+efEs82dO9jb7vJL8WcrpYB/
         kmsyXSgPcBerEKDJT3PRQW1y7+ERUbTT+32ugB+5UhDumswPuuj8ryYFDENa5e6QLwVI
         XO1k5/wB6Q2gbGlhLq3VekUOzEHNDNgHvKDA9yqnTZHzdmqzxY69FR3x1Hq61laysptJ
         9v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AcjZhREukP3aBHVQXFfPG6Q2ywPCmP6+Qew3XzM2o+o=;
        b=qKEtARPjDPtMMNCxfa7FcNiDfE24qGDX1HGG7tUijb0LlUWu+PVFyhVESahLgmmSJP
         M6paeUPQJaZOAIGeIRbFP3lDCihPAq033XpmLVjhveMXolzgWMc8I24CfzGabs36rqwG
         sfaD/NVPELTrO/v1erYAriZOhe5+jWs0kj5pAsaswahhX2ylSsKJAdzpfV3LbfOuwwGV
         u+j/RyIHfjejxUWrmXrOq7YuM4nJNgMWFR2VCtxeH8RdIkAMQwbGSsor1i1rFEWy9j4n
         r3YFDxa0/grsAzrXKk4Sy1vOrgO6XZkPFplELJwdD8IEdoaLrq3hVY+xJUCF8yunWvYb
         97PQ==
X-Gm-Message-State: APjAAAWw5hCycyWpMZ/TlKb2YhIbP8NbRGgedD8nwMU0rZQpEJzC9DCg
        Xi+JRmILZsuXh1ixQAy5QCuvNg==
X-Google-Smtp-Source: APXvYqw1E/wGG3LtU8CUVzGcqHyA8TH2cHZWKcT+YZLLaFP0R6xn+LzvU4WVp8sjGGmpUW2HvPMdkA==
X-Received: by 2002:a17:90a:24ed:: with SMTP id i100mr1426802pje.47.1566503974112;
        Thu, 22 Aug 2019 12:59:34 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:89d4:68d1:fc04:721])
        by smtp.gmail.com with ESMTPSA id k5sm139563pgo.45.2019.08.22.12.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 12:59:33 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/6] arm64: dts: meson: sei510: Add minimal thermal zone
In-Reply-To: <a6881ab8-21b0-ecd6-f7d9-cfe081455c24@baylibre.com>
References: <20190821222421.30242-1-glaroque@baylibre.com> <20190821222421.30242-5-glaroque@baylibre.com> <7hsgpu5c7j.fsf@baylibre.com> <a6881ab8-21b0-ecd6-f7d9-cfe081455c24@baylibre.com>
Date:   Thu, 22 Aug 2019 12:59:32 -0700
Message-ID: <7h8srl55uj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 22/08/2019 01:29, Kevin Hilman wrote:
>> Guillaume La Roque <glaroque@baylibre.com> writes:
>> 
>>> Add minimal thermal zone for two temperature sensor
>>> One is located close to the DDR and the other one is
>>> located close to the PLLs (between the CPU and GPU)
>>>
>>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>>> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> ---
>>>  .../boot/dts/amlogic/meson-g12a-sei510.dts    | 70 +++++++++++++++++++
>>>  1 file changed, 70 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
>>> index c9fa23a56562..35d2ebbd6d4e 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
>>> @@ -10,6 +10,7 @@
>>>  #include <dt-bindings/input/input.h>
>>>  #include <dt-bindings/gpio/meson-g12a-gpio.h>
>>>  #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>>> +#include <dt-bindings/thermal/thermal.h>
>>>  
>>>  / {
>>>  	compatible = "seirobotics,sei510", "amlogic,g12a";
>>> @@ -33,6 +34,67 @@
>>>  		ethernet0 = &ethmac;
>>>  	};
>>>  
>>> +	thermal-zones {
>>> +		cpu-thermal {
>>> +			polling-delay = <1000>;
>>> +			polling-delay-passive = <100>;
>>> +			thermal-sensors = <&cpu_temp>;
>>> +
>>> +			trips {
>>> +				cpu_hot: cpu-hot {
>>> +					temperature = <85000>; /* millicelsius */
>>> +					hysteresis = <2000>; /* millicelsius */
>>> +					type = "hot";
>>> +				};
>>> +
>>> +				cpu_critical: cpu-critical {
>>> +					temperature = <110000>; /* millicelsius */
>>> +					hysteresis = <2000>; /* millicelsius */
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +
>>> +			cooling-maps {
>>> +				map0 {
>>> +					trip = <&cpu_hot>;
>>> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>> +				};
>>> +
>>> +				map1 {
>>> +					trip = <&cpu_critical>;
>>> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		ddr-thermal {
>>> +			polling-delay = <1000>;
>>> +			polling-delay-passive = <100>;
>>> +			thermal-sensors = <&ddr_temp>;
>>> +
>>> +			trips {
>>> +				ddr_critical: ddr-critical {
>>> +					temperature = <110000>; /* millicelsius */
>>> +					hysteresis = <2000>; /* millicelsius */
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +
>>> +			cooling-maps {
>>> +				map {
>>> +					trip = <&ddr_critical>;
>>> +					cooling-device = <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>> +
>>>  	mono_dac: audio-codec-0 {
>>>  		compatible = "maxim,max98357a";
>>>  		#sound-dai-cells = <0>;
>>> @@ -321,6 +383,7 @@
>>>  	operating-points-v2 = <&cpu_opp_table>;
>>>  	clocks = <&clkc CLKID_CPU_CLK>;
>>>  	clock-latency = <50000>;
>>> +	#cooling-cells = <2>;
>>>  };
>>>  
>>>  &cpu1 {
>>> @@ -328,6 +391,7 @@
>>>  	operating-points-v2 = <&cpu_opp_table>;
>>>  	clocks = <&clkc CLKID_CPU_CLK>;
>>>  	clock-latency = <50000>;
>>> +	#cooling-cells = <2>;
>>>  };
>>>  
>>>  &cpu2 {
>>> @@ -335,6 +399,7 @@
>>>  	operating-points-v2 = <&cpu_opp_table>;
>>>  	clocks = <&clkc CLKID_CPU_CLK>;
>>>  	clock-latency = <50000>;
>>> +	#cooling-cells = <2>;
>>>  };
>>>  
>>>  &cpu3 {
>>> @@ -342,6 +407,7 @@
>>>  	operating-points-v2 = <&cpu_opp_table>;
>>>  	clocks = <&clkc CLKID_CPU_CLK>;
>>>  	clock-latency = <50000>;
>>> +	#cooling-cells = <2>;
>>>  };
>>>  
>>>  &cvbs_vdac_port {
>>> @@ -368,6 +434,10 @@
>>>  	status = "okay";
>>>  };
>>>  
>>> +&mali {
>>> +	#cooling-cells = <2>;
>>> +};
>>> +
>> 
>> Is there a reason these #cooling-cells properties belong in the SoC
>> .dtsi and not the board .dts.  Seems like you'll have to repeat this in
>> every board .dts which doesn't seem necessary.
>
> I asked him to keep the cooling-cells in the boards until we add the thermal
> in all the remaining boards.
>
> Seemed to be safer way at the time...

I assumed that #cooling-cells alone would be harmless.

If there are no thermal-zones with trips/maps defined, what can
#cooling-cells by itself do?

Kevin

