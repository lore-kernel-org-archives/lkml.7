Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC32C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833EE21835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578089348;
	bh=TOyIDYV7gDgyPy15o1GYCUub6s2L1wCSP5e7vSfqo/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KKvlIMgmCcKHpY8lf7QLI7pmdcilEkizJDOsclMsrBc/Y1+fUDFURPusO4Fod6x3X
	 5GiqBcc7gZSYEIlRJtmaLVLp4q1qpINShv83cJrLCmvDG65ckDGE8AHAO5679792y5
	 awEjsIFLqYLZZ9qiaUs7dWm8kZ6wxVYti81KFuQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgACWJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:09:07 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38596 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgACWJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:09:07 -0500
Received: by mail-io1-f65.google.com with SMTP id v3so42863928ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 14:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jaq5PZV0113fH8a1/ccNdlJ+K9H3T4ORM/dajcDMbeI=;
        b=lyCzLgMCiJjS1pzu4iEiv87ibNFWnlL0N6uwVMJ/kCk2Ibv4D1VEUiFiVOwSzGHI+C
         TT5EU8x/fxC6bD9XHDOQxZ+gMk4cE4klHDykGP/6OvO7Mzjaq2/GkRLYiYtHEmyv8MtH
         PTJdKchixjAgxULJuLcvO7G0/4/pocw4a7Qo450n2nvjaADvizELg61lUG4c04bLFEDJ
         ZCvGWV0QJ+4yaV9CBBldCuwSUqWOQapybJOyV3WV8hoYwv/cL1k0+8tCuB5TfcztDYdI
         dCrEDnQ8j8ZW9jgDjeMlqEl+zZN0LrEdmBes/XIJ6Jc2jNws/vzHvgDoCNB58ryV3fsZ
         PN3g==
X-Gm-Message-State: APjAAAV/3xW/hVJCHoJFJiqu3UQFEurqhyVmJYVT3ZTlWGEPXeEVvvaS
        gzzH6d17/SYVB40FSKuuEgLbSdA=
X-Google-Smtp-Source: APXvYqzq9mGNmrvHAEqiZtok6mhIbDsdgkdRI/Y+QRJrYbhDqJcLO9kBkdu14pthPY0gVUGOiM5TCg==
X-Received: by 2002:a6b:f913:: with SMTP id j19mr56242605iog.124.1578089346054;
        Fri, 03 Jan 2020 14:09:06 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id r7sm15256759ioo.7.2020.01.03.14.09.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 14:09:05 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 15:09:03 -0700
Date:   Fri, 3 Jan 2020 15:09:03 -0700
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        mark.rutland@arm.com
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: add dtsi for MT8516
Message-ID: <20200103220903.GA14332@bogus>
References: <20200103162234.103094-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103162234.103094-1-fparent@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 05:22:33PM +0100, Fabien Parent wrote:
> The MT8516 SoC provides the following peripherals: GPIO, UART, USB2,
> SPI, eMMC, SDIO, NAND, Flash, ADC, I2C, PWM, Timers, IR, Ethernet, and
> Audio (I2S, SPDIF, TDM).
> 
> This commit is adding the basic dtsi file with the support of the
> following IPs: Clock, Pinctrl, WDT, GPIO, UART, SPI, eMMC, I2C, Timers,
> MMC, RNG PWM.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> 
> V2:
> 	* Remove unused clock for CPU nodes
> 	* Fix formatting / spacing
> 	* Fix compatible for SPI node: s/mediatek,mt2701-spi/mediatek,mt2712-spi/
> 	* Rename "sdio" node label into "mmc"
> 	* Add "rng" and "pwm" nodes.
> 
> ---
>  arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h | 663 ++++++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt8516.dtsi      | 426 +++++++++++
>  2 files changed, 1089 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8516.dtsi


> diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> new file mode 100644
> index 000000000000..39ce244f1e40
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> @@ -0,0 +1,426 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Fabien Parent <fparent@baylibre.com>
> + */
> +
> +#include <dt-bindings/clock/mt8516-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +#include "mt8516-pinfunc.h"
> +
> +/ {
> +	compatible = "mediatek,mt8516";
> +	interrupt-parent = <&sysirq>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cluster0_opp: opp_table0 {

opp-table-0

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +		opp-598000000 {
> +			opp-hz = /bits/ 64 <598000000>;
> +			opp-microvolt = <1150000>;
> +		};
> +		opp-747500000 {
> +			opp-hz = /bits/ 64 <747500000>;
> +			opp-microvolt = <1150000>;
> +		};
> +		opp-1040000000 {
> +			opp-hz = /bits/ 64 <1040000000>;
> +			opp-microvolt = <1200000>;
> +		};
> +		opp-1196000000 {
> +			opp-hz = /bits/ 64 <1196000000>;
> +			opp-microvolt = <1250000>;
> +		};
> +		opp-1300000000 {
> +			opp-hz = /bits/ 64 <1300000000>;
> +			opp-microvolt = <1300000>;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CLUSTER_SLEEP_0 &CLUSTER_SLEEP_0>,
> +				<&CPU_SLEEP_0_0 &CPU_SLEEP_0_0 &CPU_SLEEP_0_0>;
> +			clocks = <&infracfg CLK_IFR_MUX1_SEL>,
> +				 <&topckgen CLK_TOP_MAINPLL_D2>;
> +			clock-names = "cpu", "intermediate";
> +			operating-points-v2 = <&cluster0_opp>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CLUSTER_SLEEP_0 &CLUSTER_SLEEP_0>,
> +				<&CPU_SLEEP_0_0 &CPU_SLEEP_0_0 &CPU_SLEEP_0_0>;
> +			clocks = <&infracfg CLK_IFR_MUX1_SEL>,
> +				 <&topckgen CLK_TOP_MAINPLL_D2>;
> +			clock-names = "cpu", "intermediate";
> +			operating-points-v2 = <&cluster0_opp>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x2>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CLUSTER_SLEEP_0 &CLUSTER_SLEEP_0>,
> +				<&CPU_SLEEP_0_0 &CPU_SLEEP_0_0 &CPU_SLEEP_0_0>;
> +			clocks = <&infracfg CLK_IFR_MUX1_SEL>,
> +				 <&topckgen CLK_TOP_MAINPLL_D2>;
> +			clock-names = "cpu", "intermediate";
> +			operating-points-v2 = <&cluster0_opp>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x3>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CLUSTER_SLEEP_0 &CLUSTER_SLEEP_0>,
> +				<&CPU_SLEEP_0_0 &CPU_SLEEP_0_0 &CPU_SLEEP_0_0>;
> +			clocks = <&infracfg CLK_IFR_MUX1_SEL>,
> +				 <&topckgen CLK_TOP_MAINPLL_D2>;
> +			clock-names = "cpu", "intermediate", "armpll";
> +			operating-points-v2 = <&cluster0_opp>;
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			CPU_SLEEP_0_0: cpu-sleep-0-0 {
> +				compatible = "arm,idle-state";
> +				entry-latency-us = <600>;
> +				exit-latency-us = <600>;
> +				min-residency-us = <1200>;
> +				arm,psci-suspend-param = <0x0010000>;
> +			};
> +
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible = "arm,idle-state";
> +				entry-latency-us = <800>;
> +				exit-latency-us = <1000>;
> +				min-residency-us = <2000>;
> +				arm,psci-suspend-param = <0x2010000>;
> +			};
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0", "arm,psci-0.2", "arm,psci";

Not a valid combination of compatibles. Running 'make dtbs_check' will 
tell you this.

> +		method = "smc";
> +	};
> +
> +	clk26m: clk26m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "clk26m";
> +	};
> +
> +	clk32k: clk32k {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32000>;
> +		clock-output-names = "clk32k";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 128 KiB reserved for ARM Trusted Firmware (BL31) */
> +		bl31_secmon_reserved: secmon@43000000 {
> +			no-map;
> +			reg = <0 0x43000000 0 0x20000>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13
> +			     (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14
> +			     (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11
> +			     (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10
> +			     (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 5 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 6 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 7 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		topckgen: topckgen@10000000 {
> +			compatible = "mediatek,mt8516-topckgen", "syscon";
> +			reg = <0 0x10000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		infracfg: infracfg@10001000 {
> +			compatible = "mediatek,mt8516-infracfg", "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		apmixedsys: apmixedsys@10018000 {
> +			compatible = "mediatek,mt8516-apmixedsys", "syscon";
> +			reg = <0 0x10018000 0 0x710>;
> +			#clock-cells = <1>;
> +		};
> +
> +		toprgu: toprgu@10007000 {
> +			compatible = "mediatek,mt8516-wdt",
> +				     "mediatek,mt6589-wdt";
> +			reg = <0 0x10007000 0 0x1000>;
> +			interrupts = <GIC_SPI 198 IRQ_TYPE_EDGE_FALLING>;
> +			#reset-cells = <1>;
> +		};
> +
> +		timer: timer@10008000 {
> +			compatible = "mediatek,mt8516-timer",
> +				     "mediatek,mt6577-timer";
> +			reg = <0 0x10008000 0 0x1000>;
> +			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_CLK26M_D2>,
> +				 <&clk32k>,
> +				 <&topckgen CLK_TOP_APXGPT>;
> +			clock-names = "clk13m", "clk32k", "bus";
> +		};
> +
> +		syscfg_pctl_a: syscfg_pctl_a@10005000 {

Don't use '_' in node names.

> +			compatible = "mediatek,mt8516-pctl-a-syscfg", "syscon";
> +			reg = <0 0x10005000 0 0x1000>;
> +		};
> +
> +		pio: pinctrl@10005000 {
> +			compatible = "mediatek,mt8516-pinctrl";
> +			reg = <0 0x1000b000 0 0x1000>;
> +			mediatek,pctl-regmap = <&syscfg_pctl_a>;
> +			pins-are-numbered;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pwrap: pwrap@1000f000 {
> +			compatible = "mediatek,mt8516-pwrap";
> +			reg = <0 0x1000f000 0 0x1000>;
> +			reg-names = "pwrap";
> +			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_PMICWRAP_26M>,
> +				 <&topckgen CLK_TOP_PMICWRAP_AP>;
> +			clock-names = "spi", "wrap";
> +		};
> +
> +		sysirq: intpol-controller@10200620 {

interrupt-controller@...

> +			compatible = "mediatek,mt8516-sysirq",
> +				     "mediatek,mt6577-sysirq";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			reg = <0 0x10200620 0 0x20>;
> +		};
> +
> +		gic: interrupt-controller@10310000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x10310000 0 0x1000>,
> +			      <0 0x10320000 0 0x1000>,
> +			      <0 0x10340000 0 0x2000>,
> +			      <0 0x10360000 0 0x2000>;
> +			interrupts = <GIC_PPI 9
> +				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +
> +		uart0: serial@11005000 {
> +			compatible = "mediatek,mt8516-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11005000 0 0x1000>;
> +			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_UART0_SEL>,
> +				 <&topckgen CLK_TOP_UART0>;
> +			clock-names = "baud","bus";

space                                        ^

> +			status = "disabled";
> +		};
> +
> +		uart1: serial@11006000 {
> +			compatible = "mediatek,mt8516-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11006000 0 0x1000>;
> +			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_UART1_SEL>,
> +				 <&topckgen CLK_TOP_UART1>;
> +			clock-names = "baud","bus";

space

> +			status = "disabled";
> +		};
> +
> +		uart2: serial@11007000 {
> +			compatible = "mediatek,mt8516-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11007000 0 0x1000>;
> +			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_UART2_SEL>,
> +				 <&topckgen CLK_TOP_UART2>;
> +			clock-names = "baud","bus";

space

> +			status = "disabled";
> +		};
> +
> +		i2c0: i2c@11009000 {
> +			compatible = "mediatek,mt8516-i2c",
> +				     "mediatek,mt2712-i2c";
> +			reg = <0 0x11009000 0 0x90>,
> +			      <0 0x11000180 0 0x80>;
> +			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_AHB_INFRA_D2>,
> +				 <&infracfg CLK_IFR_I2C0_SEL>,
> +				 <&topckgen CLK_TOP_I2C0>,
> +				 <&topckgen CLK_TOP_APDMA>;
> +			clock-names = "main-source",
> +				      "main-sel",
> +				      "main",
> +				      "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@1100a000 {
> +			compatible = "mediatek,mt8516-i2c",
> +				     "mediatek,mt2712-i2c";
> +			reg = <0 0x1100a000 0 0x90>,
> +			      <0 0x11000200 0 0x80>;
> +			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_AHB_INFRA_D2>,
> +				 <&infracfg CLK_IFR_I2C1_SEL>,
> +				 <&topckgen CLK_TOP_I2C1>,
> +				 <&topckgen CLK_TOP_APDMA>;
> +			clock-names = "main-source",
> +				      "main-sel",
> +				      "main",
> +				      "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@1100b000 {
> +			compatible = "mediatek,mt8516-i2c",
> +				     "mediatek,mt2712-i2c";
> +			reg = <0 0x1100b000 0 0x90>, <0 0x11000280 0 0x80>;
> +			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_AHB_INFRA_D2>,
> +				 <&infracfg CLK_IFR_I2C2_SEL>,
> +				 <&topckgen CLK_TOP_I2C2>,
> +				 <&topckgen CLK_TOP_APDMA>;
> +			clock-names = "main-source",
> +				      "main-sel",
> +				      "main",
> +				      "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		spi: spi@1100c000 {
> +			compatible = "mediatek,mt8516-spi",
> +				     "mediatek,mt2712-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x1100c000 0 0x1000>;
> +			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_UNIVPLL_D12>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&topckgen CLK_TOP_SPI>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		mmc0: mmc@11120000 {
> +			compatible = "mediatek,mt8516-mmc";
> +			reg = <0 0x11120000 0 0x1000>;
> +			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_MSDC0>,
> +				 <&topckgen CLK_TOP_AHB_INFRA_SEL>,
> +				 <&topckgen CLK_TOP_MSDC0_INFRA>;
> +			clock-names = "source", "hclk", "source_cg";
> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@11130000 {
> +			compatible = "mediatek,mt8516-mmc";
> +			reg = <0 0x11130000 0 0x1000>;
> +			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_MSDC1>,
> +				 <&topckgen CLK_TOP_AHB_INFRA_SEL>,
> +				 <&topckgen CLK_TOP_MSDC1_INFRA>;
> +			clock-names = "source", "hclk", "source_cg";
> +			status = "disabled";
> +		};
> +
> +		mmc2: mmc@11170000 {
> +			compatible = "mediatek,mt8516-mmc";
> +			reg = <0 0x11170000 0 0x1000>;
> +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_MSDC2>,
> +				 <&topckgen CLK_TOP_RG_MSDC2>,
> +				 <&topckgen CLK_TOP_MSDC2_INFRA>;
> +			clock-names = "source", "hclk", "source_cg";
> +			status = "disabled";
> +		};
> +
> +		rng: rng@1020c000 {
> +			compatible = "mediatek,mt8516-rng",
> +				     "mediatek,mt7623-rng";
> +			reg = <0 0x1020c000 0 0x100>;
> +			clocks = <&topckgen CLK_TOP_TRNG>;
> +			clock-names = "rng";
> +		};
> +
> +		pwm: pwm@11008000 {
> +			compatible = "mediatek,mt8516-pwm";
> +			reg = <0 0x11008000 0 0x1000>;
> +			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_PWM>,
> +				 <&topckgen CLK_TOP_PWM_B>,
> +				 <&topckgen CLK_TOP_PWM1_FB>,
> +				 <&topckgen CLK_TOP_PWM2_FB>,
> +				 <&topckgen CLK_TOP_PWM3_FB>,
> +				 <&topckgen CLK_TOP_PWM4_FB>,
> +				 <&topckgen CLK_TOP_PWM5_FB>;
> +			clock-names = "top", "main", "pwm1", "pwm2", "pwm3",
> +				      "pwm4", "pwm5";
> +		};
> +	};
> +};
> -- 
> 2.25.0.rc0
> 
