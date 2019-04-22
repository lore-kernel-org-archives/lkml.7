Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41C7C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9369E2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nb42CB8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfDVI0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:26:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46320 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfDVI0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:26:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id o7so3238379pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 01:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QQRNPFXxjKB8OXNLUOTGr8LGJWFpMvdheR84SI5bJoM=;
        b=nb42CB8j5YBEbA+e0gVNGrjsryRJTN120CRCx4VpXMw0Af2L9Rtt961w0UGVYo6URI
         7bzISWKHWa88YUiofWJtGidg6nqDwMDZgZrwWg0b0/Tf19adoq0O3FM+JE/LLGRL9e35
         /GcazD84dxw2RR57X/RW5l0cm6zPZ2afKmQoHymQq23lXAm6Z2uriyAXRKq7grLWejdJ
         a+B04/A17HI5hPYmyCqLTCz54EDe22V+k6ClzMM8IwwJFTLaQMdmDA+IIK9WuoVLl7yL
         mBM8c95yI3kfG+5M1GYIlKzKDVCyER1UEM3yYFJmcSA8Nf1XCCNT8Jqu0LCzKeGoOVT8
         X4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QQRNPFXxjKB8OXNLUOTGr8LGJWFpMvdheR84SI5bJoM=;
        b=c7qHH30+RCwkrOHbXGkNjyVYJ3WIw9NJG5deRJT4LjTZ8vN1G3rVS7lbAirPJNb0/6
         UXDH7yB9uCr0jtTgNckWlbKgniONjzMIYqVEaPijCWntqHVt6ekMmbXLxBwG6iTMeLeZ
         VYaCyPLocTWYt52yFEDwQmeM1HMpJvQ+KprrckLq82ahT3XEryfS8hWS0yZa70WaUTBU
         yA8SfNKybbqZI5UZVh4bnEsgO/ttOKnm+21G8oQMwgZl4xKzmMuGgcvJfo1sTEiqN8Gc
         AwOSNHJXXKNqkklbFQJznkW0ASFmtDLsZCrGwbgrWzMwBeV0DuYo3+38l01zZ00CSmu5
         8R7Q==
X-Gm-Message-State: APjAAAUwy2S2MB4Rsd2G/5fcI1ur95joGRtyOlFviSTeGCyY9dFlgJUC
        6uL371ivPHwrYEi9qRnZbGar4w==
X-Google-Smtp-Source: APXvYqwSIsWTqye8eps654AdBa0TUY5CLql4YiGOIm+81F/c8an1Wvbwq89FiJuTh1Jbt8iiTY+14Q==
X-Received: by 2002:a17:902:9686:: with SMTP id n6mr19364373plp.282.1555921574378;
        Mon, 22 Apr 2019 01:26:14 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id f71sm20787980pfc.109.2019.04.22.01.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 01:26:13 -0700 (PDT)
Date:   Mon, 22 Apr 2019 13:56:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] dt-bindings: cpufreq: Document
 allwinner,sun50i-h6-operating-points
Message-ID: <20190422082611.2hkgpeyn3t6wjf56@vireshk-i7>
References: <20190418125538.25722-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418125538.25722-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-04-19, 08:55, Yangtao Li wrote:
> Allwinner Process Voltage Scaling Tables defines the voltage and
> frequency value based on the speedbin blown in the efuse combination.
> The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each
> OPP of operating-points-v2 table when it is parsed by the OPP framework.
> 
> The "allwinner,sun50i-h6-operating-points" DT extends the
> "operating-points-v2"
> with following parameters:
> - nvmem-cells (NVMEM area containig the speedbin information)
> - opp-microvolt-<name>: voltage in micro Volts.
>   At runtime, the platform can pick a <name> and matching
>   opp-microvolt-<name> property.
> 			HW:		<name>:
> 			sun50i-h6      speed0 speed1 speed2
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
> just fix a typo:
> sun50iw-h6 -> sun50i-h6
> 
> This patch is [2/2].
> for [1/2]:
> https://patchwork.kernel.org/patch/10903381/

You should have used "--in-reply-to" feature to avoid all confusion
here.

And again, I am waiting for Rob to Ack it.

> ---
>  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> new file mode 100644
> index 000000000000..7deae57a587b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> @@ -0,0 +1,167 @@
> +Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
> +===================================
> +
> +For some SoCs, the CPU frequency subset and voltage value of each OPP
> +varies based on the silicon variant in use. Allwinner Process Voltage
> +Scaling Tables defines the voltage and frequency value based on the
> +speedbin blown in the efuse combination. The sun50i-cpufreq-nvmem driver
> +reads the efuse value from the SoC to provide the OPP framework with
> +required information.
> +
> +Required properties:
> +--------------------
> +In 'cpus' nodes:
> +- operating-points-v2: Phandle to the operating-points-v2 table to use.
> +
> +In 'operating-points-v2' table:
> +- compatible: Should be
> +	- 'allwinner,sun50i-h6-operating-points'.
> +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> +		efuse registers that has information about the speedbin
> +		that is used to select the right frequency/voltage value
> +		pair. Please refer the for nvmem-cells bindings
> +		Documentation/devicetree/bindings/nvmem/nvmem.txt and
> +		also examples below.
> +
> +In every OPP node:
> +- opp-microvolt-<name>: Voltage in micro Volts.
> +			At runtime, the platform can pick a <name> and
> +			matching opp-microvolt-<name> property.
> +			[See: opp.txt]
> +			HW:		<name>:
> +			sun50i-h6	speed0 speed1 speed2
> +
> +Example 1:
> +---------
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <0>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <1>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <2>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <3>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +		};
> +        };
> +
> +        cpu_opp_table: opp_table {
> +                compatible = "allwinner,sun50i-h6-operating-points";
> +                nvmem-cells = <&speedbin_efuse>;
> +                opp-shared;
> +
> +                opp@480000000 {
> +                        clock-latency-ns = <244144>; /* 8 32k periods */
> +                        opp-hz = /bits/ 64 <480000000>;
> +
> +                        opp-microvolt-speed0 = <880000>;
> +                        opp-microvolt-speed1 = <820000>;
> +                        opp-microvolt-speed2 = <800000>;
> +                };
> +
> +                opp@720000000 {
> +                        clock-latency-ns = <244144>; /* 8 32k periods */
> +                        opp-hz = /bits/ 64 <720000000>;
> +
> +                        opp-microvolt-speed0 = <880000>;
> +                        opp-microvolt-speed1 = <820000>;
> +                        opp-microvolt-speed2 = <800000>;
> +                };
> +
> +                opp@816000000 {
> +                        clock-latency-ns = <244144>; /* 8 32k periods */
> +                        opp-hz = /bits/ 64 <816000000>;
> +
> +                        opp-microvolt-speed0 = <880000>;
> +                        opp-microvolt-speed1 = <820000>;
> +                        opp-microvolt-speed2 = <800000>;
> +                };
> +
> +                opp@888000000 {
> +                        clock-latency-ns = <244144>; /* 8 32k periods */
> +                        opp-hz = /bits/ 64 <888000000>;
> +
> +                        opp-microvolt-speed0 = <940000>;
> +                        opp-microvolt-speed1 = <820000>;
> +                        opp-microvolt-speed2 = <800000>;
> +                };
> +
> +                opp@1080000000 {
> +                        clock-latency-ns = <244144>; /* 8 32k periods */
> +                        opp-hz = /bits/ 64 <1080000000>;
> +
> +                        opp-microvolt-speed0 = <1060000>;
> +                        opp-microvolt-speed1 = <880000>;
> +                        opp-microvolt-speed2 = <840000>;
> +                };
> +
> +                opp@1320000000 {
> +                        clock-latency-ns = <244144>; /* 8 32k periods */
> +                        opp-hz = /bits/ 64 <1320000000>;
> +
> +                        opp-microvolt-speed0 = <1160000>;
> +                        opp-microvolt-speed1 = <940000>;
> +                        opp-microvolt-speed2 = <900000>;
> +                };
> +
> +                opp@1488000000 {
> +                        clock-latency-ns = <244144>; /* 8 32k periods */
> +                        opp-hz = /bits/ 64 <1488000000>;
> +
> +                        opp-microvolt-speed0 = <1160000>;
> +                        opp-microvolt-speed1 = <1000000>;
> +                        opp-microvolt-speed2 = <960000>;
> +                };
> +        };
> +....
> +soc {
> +....
> +	sid: sid@3006000 {
> +		compatible = "allwinner,sun50i-h6-sid";
> +		reg = <0x03006000 0x400>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		....
> +		speedbin_efuse: speed@1c {
> +			reg = <0x1c 4>;
> +		};
> +        };
> +};
> -- 
> 2.17.0

-- 
viresh
