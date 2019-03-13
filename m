Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692BFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF322177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGJbmv96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfCMM0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:26:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38739 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfCMM0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:26:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id h58so1330461edb.5;
        Wed, 13 Mar 2019 05:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V0pW1bQXJ7cV/5R6TwmYu40+Kqay5PJZfxUr367aTt4=;
        b=fGJbmv96SHHKXDlv4fAnCq2dD4vdx4Tiu+rqJkj1iPt+glO2wUT5YjZ4PDHfj77436
         6SkSp4cVPj2NQpLoHJSH8BIJBcOOfml1TYT0fs87QtrbaXHXFkejXaBFWykwCErivoau
         ROK0CdpvCNfbVIXb7/248m18NyMhFSfXh11qpt2XE0L7b4bGaYRsHAllEQqs/RXFKfuw
         flfgKUCgsuyyqgO0dOV8UNVgIOhytGE+2ofGZZXALc2vrqXuJ+OMSdyZtpkJic+mN7x5
         3itwaGVNbwCntqBmGXCkV+Ltzcb47S8Dn7qgBtFbNrV0qRK1mfvvjAGdYLvzHmgoHIaG
         3eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=V0pW1bQXJ7cV/5R6TwmYu40+Kqay5PJZfxUr367aTt4=;
        b=swNMHEHr8YMNBwGBUmzsPuu/i+yzh2rT0xKQ06fxIiNwyxfdRcb+0u/b6CC1itdS+r
         c7wPGY+WePKleG+FfEFnUJsr/GgUZA78o2JlFjIkOIl5UfdvDpHo/g2WS5WaAw6aqANB
         l+2VPwi7+7sSoEYyHjGs/TgqNyNgStO/A1EP0TcYD54ZdG/GSL6TmZxKm+dteX4cvE7q
         jP0hafVj5cPC0+L3WinwHiUcNn/ChYrFInNO4Z/jituLJIkF/EU85Wsw8UOEzEXTc/Rt
         OWbm3gokdEsk5jZQooKpwnYpbb1pm9EM+eMvWXF4QkGZYVxFyCSMMb/kkTiuCvtODez2
         ch7A==
X-Gm-Message-State: APjAAAXBTfvm046ogFkip00iuJgWg8Q9dJ8F6403+Lm5wV5J2wPG0QbV
        jAJ1tyJhBlUaITGBcUwT/NM=
X-Google-Smtp-Source: APXvYqwn/0R1ZnpyD2j+cSMjOYTAtUlaZYzvqp//3qlSA5NemjevhqULNAKosNRX7GdmAI42yAiyhQ==
X-Received: by 2002:a17:906:c2d9:: with SMTP id ch25mr29552702ejb.180.1552479989019;
        Wed, 13 Mar 2019 05:26:29 -0700 (PDT)
Received: from ziggy.stardust ([37.223.147.22])
        by smtp.gmail.com with ESMTPSA id o42sm554747edc.49.2019.03.13.05.26.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 05:26:28 -0700 (PDT)
Subject: Re: [PATCH v1] arm: dts: mediatek: add basic support for MT7629 SoC
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     ryder.lee@kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Weijie Gao <weijie.gao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <a8ca0018ac8a4c5f61a7a1efc9dc5dccd768628b.1552449524.git.ryder.lee@mediatek.com>
 <644476e1-82be-87e2-f828-da4bfda8f9a5@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <11eda85c-f63b-3992-07ff-e8058759c21f@gmail.com>
Date:   Wed, 13 Mar 2019 13:26:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <644476e1-82be-87e2-f828-da4bfda8f9a5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/03/2019 13:04, Matthias Brugger wrote:
> 
> 
> On 13/03/2019 09:42, ryder.lee@kernel.org wrote:
>> From: Ryder Lee <ryder.lee@mediatek.com>
>>
>> This adds basic support for MT7629 reference board.
>>
>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>> ---
>> Changes since v1:
>> -Fix unit-address warnings.
>> -Put all the mmio peripherals under a simple-bus node.
>> -Drop all the 'partitions' nodes in flash node.
>> ---
>>  arch/arm/boot/dts/Makefile                |   1 +
>>  arch/arm/boot/dts/mt7629-rfb.dts          | 203 ++++++++++++++++
>>  arch/arm/boot/dts/mt7629.dtsi             | 370 ++++++++++++++++++++++++++++++
>>  include/dt-bindings/reset/mt7629-resets.h |  71 ++++++
>>  4 files changed, 645 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/mt7629-rfb.dts
>>  create mode 100644 arch/arm/boot/dts/mt7629.dtsi
>>  create mode 100644 include/dt-bindings/reset/mt7629-resets.h
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index bd40148..a5a6d9f 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -1231,6 +1231,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>>  	mt7623a-rfb-nand.dtb \
>>  	mt7623n-rfb-emmc.dtb \
>>  	mt7623n-bananapi-bpi-r2.dtb \
>> +	mt7629-rfb.dtb \
>>  	mt8127-moose.dtb \
>>  	mt8135-evbp1.dtb
>>  dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
>> diff --git a/arch/arm/boot/dts/mt7629-rfb.dts b/arch/arm/boot/dts/mt7629-rfb.dts
>> new file mode 100644
>> index 0000000..a47dd7e
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/mt7629-rfb.dts
>> @@ -0,0 +1,203 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019 MediaTek Inc.
>> + * Author: Ryder Lee <ryder.lee@mediatek.com>
>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/input/input.h>
>> +#include "mt7629.dtsi"
>> +
>> +/ {
>> +	model = "MediaTek MT7629 reference board";
>> +	compatible = "mediatek,mt7629-rfb", "mediatek,mt7629";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		reset {
>> +			label = "factory";
>> +			linux,code = <KEY_RESTART>;
>> +			gpios = <&pio 60 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		wps {
>> +			label = "wps";
>> +			linux,code = <KEY_WPS_BUTTON>;
>> +			gpios = <&pio 58 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +
>> +	memory@40000000 {
>> +		device_type = "memory";
>> +		reg = <0 0x40000000 0 0x10000000>;
>> +	};
>> +
>> +	reg_3p3v: regulator-3p3v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "fixed-3.3V";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
>> +
>> +	reg_5v: regulator-5v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "fixed-5V";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
>> +};
>> +
>> +&i2c {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c_pins>;
>> +	status = "okay";
>> +};
>> +
>> +&qspi {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&qspi_pins>;
>> +	status = "okay";
>> +
>> +	flash@0 {
>> +		compatible = "jedec,spi-nor";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +	};
>> +};
>> +
>> +&pio {
>> +	eth_pins: eth-pins {
>> +		mux {
>> +			function = "eth";
>> +			groups = "mdc_mdio";
>> +		};
>> +	};
>> +
>> +	ephy_leds_pins: ephy-leds-pins {
>> +		mux {
>> +			function = "led";
>> +			groups = "gphy_leds_0", "ephy_leds";
>> +		};
>> +	};
>> +
>> +	i2c_pins: i2c-pins {
>> +		mux {
>> +			function = "i2c";
>> +			groups =  "i2c_0";
>> +		};
>> +
>> +		conf {
>> +			pins = "I2C_SDA", "I2C_SCL";
>> +			drive-strength = <4>;
>> +			bias-disable;
>> +		};
>> +	};
>> +
>> +	pcie_pins: pcie-pins {
>> +		mux {
>> +			function = "pcie";
>> +			groups = "pcie_clkreq",
>> +				 "pcie_pereset",
>> +				 "pcie_wake";
>> +		};
>> +	};
>> +
>> +	pwm_pins: pwm-pins {
>> +		mux {
>> +			function = "pwm";
>> +			groups = "pwm_0";
>> +		};
>> +	};
>> +
>> +	/* Serial NAND is shared pin with SPI-NOR */
>> +	serial_nand_pins: serial-nand-pins {
>> +		mux {
>> +			function = "flash";
>> +			groups = "snfi";
>> +		};
>> +	};
>> +
>> +	spi_pins: spi-pins {
>> +		mux {
>> +			function = "spi";
>> +			groups = "spi_0";
>> +		};
>> +	};
>> +
>> +	/* SPI-NOR is shared pin with serial NAND */
>> +	qspi_pins: qspi-pins {
>> +		mux {
>> +			function = "flash";
>> +			groups = "spi_nor";
>> +		};
>> +	};
>> +
>> +	uart0_pins: uart0-pins {
>> +		mux {
>> +			function = "uart";
>> +			groups = "uart0_txd_rxd" ;
>> +		};
>> +	};
>> +
>> +	uart1_pins: uart1-pins {
>> +		mux {
>> +			function = "uart";
>> +			groups = "uart1_0_tx_rx" ;
>> +		};
>> +	};
>> +
>> +	uart2_pins: uart2-pins {
>> +		mux {
>> +			function = "uart";
>> +			groups = "uart2_0_txd_rxd" ;
>> +		};
>> +	};
>> +
>> +	watchdog_pins: watchdog-pins {
>> +		mux {
>> +			function = "watchdog";
>> +			groups = "watchdog";
>> +		};
>> +	};
>> +};
>> +
>> +&spi {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&spi_pins>;
>> +	status = "okay";
>> +};
>> +
>> +&uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart0_pins>;
>> +	status = "okay";
>> +};
>> +
>> +&ssusb {
>> +	vusb33-supply = <&reg_3p3v>;
>> +	vbus-supply = <&reg_5v>;
>> +	status = "okay";
>> +};
>> +
>> +&u3phy1 {
>> +	status = "okay";
>> +};
>> +
>> +&watchdog {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&watchdog_pins>;
>> +	status = "okay";
>> +};
>> \ No newline at end of file
>> diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
>> new file mode 100644
>> index 0000000..0197660
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/mt7629.dtsi
>> @@ -0,0 +1,370 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019 MediaTek Inc.
>> + *
>> + * Author: Ryder Lee <ryder.lee@mediatek.com>
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/mt7629-clk.h>
>> +#include <dt-bindings/power/mt7622-power.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/phy/phy.h>
>> +#include <dt-bindings/reset/mt7629-resets.h>
>> +
>> +/ {
>> +	compatible = "mediatek,mt7629";
>> +	interrupt-parent = <&sysirq>;
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		enable-method = "mediatek,mt6589-smp";
>> +
>> +		cpu0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg = <0x0>;
>> +			clock-frequency = <1250000000>;
>> +			cci-control-port = <&cci_control2>;
>> +		};
>> +
>> +		cpu1: cpu@1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg = <0x1>;
>> +			clock-frequency = <1250000000>;
>> +			cci-control-port = <&cci_control2>;
>> +		};
>> +	};
>> +
>> +	pmu {
>> +		compatible = "arm,cortex-a7-pmu";
>> +		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 9 IRQ_TYPE_LEVEL_LOW>;
>> +		interrupt-affinity = <&cpu0>, <&cpu1>;
>> +	};
>> +
>> +	clk20m: oscillator-0 {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <20000000>;
>> +		clock-output-names = "clk20m";
>> +	};
>> +
>> +	clk40m: oscillator-1 {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <40000000>;
>> +		clock-output-names = "clkxtal";
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv7-timer";
>> +		interrupt-parent = <&gic>;
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> +		clock-frequency = <20000000>;
>> +		arm,cpu-registers-not-fw-configured;
>> +	};
>> +
>> +	soc {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		compatible = "simple-bus";
>> +		ranges;
>> +
>> +		infracfg: syscon@10000000 {
>> +			compatible = "mediatek,mt7629-infracfg", "syscon";
>> +			reg = <0 0x10000000 0 0x1000>;
>> +			#clock-cells = <1>;
>> +		};
>> +
>> +		pericfg: syscon@10002000 {
>> +			compatible = "mediatek,mt7629-pericfg", "syscon";
>> +			reg = <0 0x10002000 0 0x1000>;
>> +			#clock-cells = <1>;
>> +		};
>> +
>> +		scpsys: scpsys@10006000 {
>> +			compatible = "mediatek,mt7629-scpsys",
>> +				     "mediatek,mt7622-scpsys";
> 
> Binding description is missing.
> 
>> +			#power-domain-cells = <1>;
>> +			reg = <0 0x10006000 0 0x1000>;
>> +			clocks = <&topckgen CLK_TOP_HIF_SEL>;
>> +			clock-names = "hif_sel";
>> +			assigned-clocks = <&topckgen CLK_TOP_HIF_SEL>;
>> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>;
>> +			infracfg = <&infracfg>;
>> +		};
>> +
>> +		timer: timer@10009000 {
>> +			compatible = "mediatek,mt7629-timer",
>> +				     "mediatek,mt6765-timer";
>> +			reg = <0 0x10009000 0 0x60>;
>> +			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clk20m>;
>> +			clock-names = "clk20m";
>> +		};
>> +
>> +		sysirq: interrupt-controller@10200a80 {
>> +			compatible = "mediatek,mt7629-sysirq",
>> +				     "mediatek,mt6577-sysirq";
> 
> Same here.
> 
>> +			reg = <0 0x10200a80 0 0x20>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +			interrupt-parent = <&gic>;
>> +		};
>> +
>> +		apmixedsys: syscon@10209000 {
>> +			compatible = "mediatek,mt7629-apmixedsys", "syscon";
>> +			reg = <0 0x10209000 0 0x1000>;
>> +			#clock-cells = <1>;
>> +		};
>> +
>> +		rng: rng@1020f000 {
>> +			compatible = "mediatek,mt7629-rng",
>> +				     "mediatek,mt7623-rng";
>> +			reg = <0 0x1020f000 0 0x100>;
>> +			clocks = <&infracfg CLK_INFRA_TRNG_PD>;
>> +			clock-names = "rng";
>> +		};
>> +
>> +		topckgen: syscon@10210000 {
>> +			compatible = "mediatek,mt7629-topckgen", "syscon";
>> +			reg = <0 0x10210000 0 0x1000>;
>> +			#clock-cells = <1>;
>> +		};
>> +
>> +		watchdog: watchdog@10212000 {
>> +			compatible = "mediatek,mt7629-wdt",
>> +				     "mediatek,mt6589-wdt";
>> +			reg = <0 0x10212000 0 0x100>;
>> +		};
>> +
>> +		pio: pinctrl@10217000 {
>> +			compatible = "mediatek,mt7629-pinctrl";
>> +			reg = <0 0x10217000 0 0x8000>,
>> +			      <0 0x10005000 0 0x1000>;
>> +			reg-names = "base", "eint";
>> +			gpio-controller;
>> +			gpio-ranges = <&pio 0 0 79>;
>> +			#gpio-cells = <2>;
>> +			#interrupt-cells = <2>;
>> +			interrupt-controller;
>> +			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-parent = <&gic>;
>> +		};
>> +
>> +		gic: interrupt-controller@10300000 {
>> +			compatible = "arm,gic-400";
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +			interrupt-parent = <&gic>;
>> +			reg = <0 0x10310000 0 0x1000>,
>> +			      <0 0x10320000 0 0x1000>,
>> +			      <0 0x10340000 0 0x2000>,
>> +			      <0 0x10360000 0 0x2000>;
>> +		};
>> +
>> +		cci: cci@10390000 {
>> +			compatible = "arm,cci-400";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			reg = <0 0x10390000 0 0x1000>;
>> +			ranges = <0 0 0x10390000 0x10000>;
>> +
>> +			cci_control0: slave-if@1000 {
>> +				compatible = "arm,cci-400-ctrl-if";
>> +				interface-type = "ace-lite";
>> +				reg = <0x1000 0x1000>;
>> +			};
>> +
>> +			cci_control1: slave-if@4000 {
>> +				compatible = "arm,cci-400-ctrl-if";
>> +				interface-type = "ace";
>> +				reg = <0x4000 0x1000>;
>> +			};
>> +
>> +			cci_control2: slave-if@5000 {
>> +				compatible = "arm,cci-400-ctrl-if";
>> +				interface-type = "ace";
>> +				reg = <0x5000 0x1000>;
>> +			};
>> +
>> +			pmu@9000 {
>> +				compatible = "arm,cci-400-pmu,r1";
>> +				reg = <0x9000 0x5000>;
>> +				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +		};
>> +
>> +		uart0: serial@11002000 {
>> +			compatible = "mediatek,mt7629-uart",
>> +				     "mediatek,mt6577-uart";
> 
> Same here.
> 
> Please provide the corresponding patches (one for each component) in v2.
> Other then that, patch looks good to me.
> 

submitted here:
https://patchwork.kernel.org/patch/10817049/

I'll take both of them. Sorry for the confusion.

Matthias

> Regards,
> Matthias
> 
>> +			reg = <0 0x11002000 0 0x400>;
>> +			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
>> +			clocks = <&topckgen CLK_TOP_UART_SEL>,
>> +				 <&pericfg CLK_PERI_UART0_PD>;
>> +			clock-names = "baud", "bus";
>> +			status = "disabled";
>> +		};
>> +
>> +		uart1: serial@11003000 {
>> +			compatible = "mediatek,mt7629-uart",
>> +				     "mediatek,mt6577-uart";
>> +			reg = <0 0x11003000 0 0x400>;
>> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
>> +			clocks = <&topckgen CLK_TOP_UART_SEL>,
>> +				 <&pericfg CLK_PERI_UART1_PD>;
>> +			clock-names = "baud", "bus";
>> +			status = "disabled";
>> +		};
>> +
>> +		uart2: serial@11004000 {
>> +			compatible = "mediatek,mt7629-uart",
>> +				     "mediatek,mt6577-uart";
>> +			reg = <0 0x11004000 0 0x400>;
>> +			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
>> +			clocks = <&topckgen CLK_TOP_UART_SEL>,
>> +				 <&pericfg CLK_PERI_UART2_PD>;
>> +			clock-names = "baud", "bus";
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c: i2c@11007000 {
>> +			compatible = "mediatek,mt7629-i2c",
>> +				     "mediatek,mt2712-i2c";
>> +			reg = <0 0x11007000 0 0x90>,
>> +				  <0 0x11000100 0 0x80>;
>> +			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
>> +			clock-div = <4>;
>> +			clocks = <&pericfg CLK_PERI_I2C0_PD>,
>> +				 <&pericfg CLK_PERI_AP_DMA_PD>;
>> +			clock-names = "main", "dma";
>> +			assigned-clocks = <&topckgen CLK_TOP_AXI_SEL>;
>> +			assigned-clock-parents = <&topckgen CLK_TOP_SYSPLL1_D2>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		spi: spi@1100a000 {
>> +			compatible = "mediatek,mt7629-spi",
>> +				     "mediatek,mt7622-spi";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0 0x1100a000 0 0x100>;
>> +			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_LOW>;
>> +			clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
>> +				 <&topckgen CLK_TOP_SPI0_SEL>,
>> +				 <&pericfg CLK_PERI_SPI0_PD>;
>> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
>> +			status = "disabled";
>> +		};
>> +
>> +		qspi: spi@11014000 {
>> +			compatible = "mediatek,mt7629-nor",
>> +				     "mediatek,mt8173-nor";
>> +			reg = <0 0x11014000 0 0xe0>;
>> +			clocks = <&pericfg CLK_PERI_FLASH_PD>,
>> +				 <&topckgen CLK_TOP_FLASH_SEL>;
>> +			clock-names = "spi", "sf";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		ssusbsys: syscon@1a000000 {
>> +			compatible = "mediatek,mt7629-ssusbsys", "syscon";
>> +			reg = <0 0x1a000000 0 0x1000>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>> +		ssusb: usb@1a0c0000 {
>> +			compatible = "mediatek,mt7629-xhci",
>> +				     "mediatek,mtk-xhci";
>> +			reg = <0 0x1a0c0000 0 0x01000>,
>> +			      <0 0x1a0c3e00 0 0x0100>;
>> +			reg-names = "mac", "ippc";
>> +			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_LOW>;
>> +			clocks = <&ssusbsys CLK_SSUSB_SYS_EN>,
>> +				 <&ssusbsys CLK_SSUSB_REF_EN>,
>> +				 <&ssusbsys CLK_SSUSB_MCU_EN>,
>> +				 <&ssusbsys CLK_SSUSB_DMA_EN>;
>> +			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
>> +			assigned-clocks = <&topckgen CLK_TOP_AXI_SEL>,
>> +					  <&topckgen CLK_TOP_SATA_SEL>,
>> +					  <&topckgen CLK_TOP_HIF_SEL>;
>> +			assigned-clock-parents = <&topckgen CLK_TOP_SYSPLL1_D2>,
>> +						 <&topckgen CLK_TOP_UNIVPLL2_D4>,
>> +						 <&topckgen CLK_TOP_UNIVPLL1_D2>;
>> +			power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF1>;
>> +			phys = <&u2port0 PHY_TYPE_USB2>,
>> +			       <&u3port0 PHY_TYPE_USB3>;
>> +			status = "disabled";
>> +		};
>> +
>> +		u3phy1: usb-phy@1a0c4000 {
>> +			compatible = "mediatek,generic-tphy-v1";
>> +			reg = <0 0x1a0c4000 0 0x300>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +			status = "disabled";
>> +
>> +			u2port0: usb-phy@1a0c4300 {
>> +				reg = <0 0x1a0c4300 0 0x100>;
>> +				clocks = <&ssusbsys CLK_SSUSB_U2_PHY_EN>;
>> +				clock-names = "ref";
>> +				#phy-cells = <1>;
>> +				status = "okay";
>> +			};
>> +
>> +			u3port0: usb-phy@1a1c4900 {
>> +				reg = <0 0x1a1c4900 0 0x700>;
>> +				clocks = <&clk20m>;
>> +				clock-names = "ref";
>> +				#phy-cells = <1>;
>> +				status = "okay";
>> +			};
>> +		};
>> +
>> +		pciesys: syscon@1a100800 {
>> +			compatible = "mediatek,mt7629-pciesys", "syscon";
>> +			reg = <0 0x1a100800 0 0x1000>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>> +		ethsys: syscon@1b000000 {
>> +			compatible = "mediatek,mt7629-ethsys", "syscon";
>> +			reg = <0 0x1b000000 0 0x1000>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>> +		sgmiisys0: syscon@1b128000 {
>> +			compatible = "mediatek,mt7629-sgmiisys", "syscon";
>> +			reg = <0 0x1b128000 0 0x1000>;
>> +			#clock-cells = <1>;
>> +		};
>> +
>> +		sgmiisys1: syscon@1b130000 {
>> +			compatible = "mediatek,mt7629-sgmiisys", "syscon";
>> +			reg = <0 0x1b130000 0 0x1000>;
>> +			#clock-cells = <1>;
>> +		};
>> +	};
>> +};
>> diff --git a/include/dt-bindings/reset/mt7629-resets.h b/include/dt-bindings/reset/mt7629-resets.h
>> new file mode 100644
>> index 0000000..6bb8573
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/mt7629-resets.h
>> @@ -0,0 +1,71 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2019 MediaTek Inc.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT7629
>> +#define _DT_BINDINGS_RESET_CONTROLLER_MT7629
>> +
>> +/* INFRACFG resets */
>> +#define MT7629_INFRA_EMI_MPU_RST		0
>> +#define MT7629_INFRA_UART5_RST			2
>> +#define MT7629_INFRA_CIRQ_EINT_RST		3
>> +#define MT7629_INFRA_APXGPT_RST			4
>> +#define MT7629_INFRA_SCPSYS_RST			5
>> +#define MT7629_INFRA_KP_RST			6
>> +#define MT7629_INFRA_SPI1_RST			7
>> +#define MT7629_INFRA_SPI4_RST			8
>> +#define MT7629_INFRA_SYSTIMER_RST		9
>> +#define MT7629_INFRA_IRRX_RST			10
>> +#define MT7629_INFRA_AO_BUS_RST			16
>> +#define MT7629_INFRA_EMI_RST			32
>> +#define MT7629_INFRA_APMIXED_RST		35
>> +#define MT7629_INFRA_MIPI_RST			36
>> +#define MT7629_INFRA_TRNG_RST			37
>> +#define MT7629_INFRA_SYSCIRQ_RST		38
>> +#define MT7629_INFRA_MIPI_CSI_RST		39
>> +#define MT7629_INFRA_GCE_FAXI_RST		40
>> +#define MT7629_INFRA_I2C_SRAM_RST		41
>> +#define MT7629_INFRA_IOMMU_RST			47
>> +
>> +/* PERICFG resets */
>> +#define MT7629_PERI_UART0_SW_RST		0
>> +#define MT7629_PERI_UART1_SW_RST		1
>> +#define MT7629_PERI_UART2_SW_RST		2
>> +#define MT7629_PERI_BTIF_SW_RST			6
>> +#define MT7629_PERI_PWN_SW_RST			8
>> +#define MT7629_PERI_DMA_SW_RST			11
>> +#define MT7629_PERI_NFI_SW_RST			14
>> +#define MT7629_PERI_I2C0_SW_RST			22
>> +#define MT7629_PERI_SPI0_SW_RST			33
>> +#define MT7629_PERI_SPI1_SW_RST			34
>> +#define MT7629_PERI_FLASHIF_SW_RST		36
>> +
>> +/* PCIe Subsystem resets */
>> +#define MT7629_PCIE1_CORE_RST			19
>> +#define MT7629_PCIE1_MMIO_RST			20
>> +#define MT7629_PCIE1_HRST			21
>> +#define MT7629_PCIE1_USER_RST			22
>> +#define MT7629_PCIE1_PIPE_RST			23
>> +#define MT7629_PCIE0_CORE_RST			27
>> +#define MT7629_PCIE0_MMIO_RST			28
>> +#define MT7629_PCIE0_HRST			29
>> +#define MT7629_PCIE0_USER_RST			30
>> +#define MT7629_PCIE0_PIPE_RST			31
>> +
>> +/* SSUSB Subsystem resets */
>> +#define MT7629_SSUSB_PHY_PWR_RST		3
>> +#define MT7629_SSUSB_MAC_PWR_RST		4
>> +
>> +/* ETH Subsystem resets */
>> +#define MT7629_ETHSYS_SYS_RST			0
>> +#define MT7629_ETHSYS_MCM_RST			2
>> +#define MT7629_ETHSYS_HSDMA_RST			5
>> +#define MT7629_ETHSYS_FE_RST			6
>> +#define MT7629_ETHSYS_ESW_RST			16
>> +#define MT7629_ETHSYS_GMAC_RST			23
>> +#define MT7629_ETHSYS_EPHY_RST			24
>> +#define MT7629_ETHSYS_CRYPTO_RST		29
>> +#define MT7629_ETHSYS_PPE_RST			31
>> +
>> +#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT7629 */
>>
