Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B50CC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2056D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJ9nJH6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfEFKAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:00:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42607 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFKAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:00:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so6201317pgh.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hBDl7NnVQt4qmeDKNuZ2UFclnyvvaBtqOvFKPVP/fjY=;
        b=YJ9nJH6saLyMDqEiAIulG/3IBXgJ092UdbUeoaJQFuFFdkOn76AJN7PRI+eX0IpQ8i
         26wn84LyC5SDuKlrPFztni2Af3Vff9tt3u6VfEC0Kvfbh1k/cUxnsyWa7Z0Up7yBHRyt
         f2U83IgdSWcjE3mskkrSkxIPIB968EnlafTIMNPqkpUw1jqc81roPAG2FIfBHK5h8OC7
         hFVsMVW4WDSE5IvvS3PJvMTXkFVB+udYQXzdIHBDn/EVeTUzvncTqyimH9/08ye2fK9l
         w7hkkTWTUCxYf6NOGjw5CPSPaKmkKjjRHVn3U1S5Bbi1KFKfHQJMW/ZOk/mmrzH2i+C7
         7tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hBDl7NnVQt4qmeDKNuZ2UFclnyvvaBtqOvFKPVP/fjY=;
        b=qr0hjdQNW3xeKzedqhMPofEeqIcKc83e7qkbDN5hTJIj39t7ad4QEj6hBgtMfqBeSm
         DJh+aIIYlCqSjeOignejznNNB3M9v+p551Vg2nIgFKT+6RZ0j+iyR+PZJxOoaU3Ax3VA
         BKe2HzC4oUegpIPAjnWZrH5oXJGH5XyCaCuQt16elyWYrF91iI8JRSoUF2/POr1OU66C
         ECM5G3vzDTe7DwGEVzDspxs6zLQ3xH4sMpF4J2UazkW+6uIt+yl4j+ry8ASW8HkKqeZm
         m/MBDSwxEJcq0AjvkL/ecUPIouGie64zFjKu7efX6Pa4GfKL6GHDdEbm9z5Zm367SeP6
         j4ng==
X-Gm-Message-State: APjAAAUlz4UBZaoUlfh5LeFAxsE/bVd8tfED/bBjtBYPkfjF9fS0/fPw
        itzaNUGDyfzhDYtspOonVGxL
X-Google-Smtp-Source: APXvYqzkWRVd3FAN0KUEm94DFGc456oh9LhLqJPm8/VZmPuwHXy1G1V1anSL/PBxcV5ORadwymc3Zg==
X-Received: by 2002:a62:4281:: with SMTP id h1mr31998044pfd.162.1557136849576;
        Mon, 06 May 2019 03:00:49 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:611b:55a4:e119:3b84:2d86:5b07])
        by smtp.gmail.com with ESMTPSA id j5sm12467442pfe.15.2019.05.06.03.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 03:00:48 -0700 (PDT)
Date:   Mon, 6 May 2019 15:30:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     mcoquelin.stm32@gmail.com, robh+dt@kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com
Subject: Re: [PATCH 3/3] ARM: dts: Add Avenger96 devicetree support based on
 STM32MP157A
Message-ID: <20190506100042.GB23734@Mani-XPS-13-9360>
References: <20190503053123.6828-1-manivannan.sadhasivam@linaro.org>
 <20190503053123.6828-4-manivannan.sadhasivam@linaro.org>
 <7e693155-d1d4-b12d-74fd-0236d9d52257@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e693155-d1d4-b12d-74fd-0236d9d52257@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Fri, May 03, 2019 at 11:01:00AM +0200, Alexandre Torgue wrote:
> Hi Mani
> 
> On 5/3/19 7:31 AM, Manivannan Sadhasivam wrote:
> > Add devicetree support for Avenger96 board based on STM32MP157A MPU
> > from ST Micro. This board is one of the 96Boards Consumer Edition board
> > from Arrow Electronics and has the following features:
> > 
> > SoC: STM32MP157AAC
> > PMIC: STPMIC1A
> > RAM: 1024 Mbyte @ 533MHz
> > Storage: eMMC v4.51: 8 Gbyte
> >           microSD Socket: UHS-1 v3.01
> > Ethernet Port: 10/100/1000 Mbit/s, IEEE 802.3 Compliant
> > Wireless: WiFi 5 GHz & 2.4GHz IEEE 802.11a/b/g/n/ac
> >            Bluetooth®v4.2 (BR/EDR/BLE)
> > USB: 2x Type A (USB 2.0) Host and 1x Micro B (USB 2.0) OTG
> > Display: HDMI: WXGA (1366x768)@ 60 fps, HDMI 1.4
> > LED: 4x User LED, 1x WiFi LED, 1x BT LED
> > 
> > More information about this board can be found in 96Boards website:
> > https://www.96boards.org/product/avenger96/
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   arch/arm/boot/dts/Makefile                  |   1 +
> >   arch/arm/boot/dts/stm32mp157a-avenger96.dts | 320 ++++++++++++++++++++
> >   2 files changed, 321 insertions(+)
> >   create mode 100644 arch/arm/boot/dts/stm32mp157a-avenger96.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 8a1d0b3f55dd..f1d2f0bfa7c2 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -965,6 +965,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
> >   	stm32h743i-eval.dtb \
> >   	stm32h743i-disco.dtb \
> >   	stm32mp157a-dk1.dtb \
> > +	stm32mp157a-avenger96.dtb \
> 
> follow alphabetic order please.
>

Ack

> >   	stm32mp157c-dk2.dtb \
> >   	stm32mp157c-ed1.dtb \
> >   	stm32mp157c-ev1.dtb
> > diff --git a/arch/arm/boot/dts/stm32mp157a-avenger96.dts b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
> > new file mode 100644
> > index 000000000000..a3b8af82ac70
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
> > @@ -0,0 +1,320 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +/*
> > + * Copyright (C) Linaro Ltd 2019 - All Rights Reserved
> > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "stm32mp157c.dtsi"
> > +#include "stm32mp157-pinctrl.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/mfd/st,stpmic1.h>
> > +
> > +/ {
> > +	model = "Arrow Electronics STM32MP157A Avenger96 board";
> > +	compatible = "arrow,stm32mp157a-avenger96", "st,stm32mp157";
> > +
> > +	aliases {
> > +		ethernet0 = &ethernet0;
> > +		mmc0 = &sdmmc1;
> > +		serial0 = &uart4;
> > +		serial1 = &uart7;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +
> > +	memory@c0000000 {
> > +		reg = <0xc0000000 0x40000000>;
> 
> you could add device_type = "memory";
>

Ack.

Thanks,
Mani
 
> > +	};
> > +
> > +	led {
> > +		compatible = "gpio-leds";
> > +		led1 {
> > +			label = "green:user1";
> > +			gpios = <&gpioz 7 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "heartbeat";
> > +			default-state = "off";
> > +		};
> > +
> > +		led2 {
> > +			label = "green:user2";
> > +			gpios = <&gpiof 3 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "mmc0";
> > +			default-state = "off";
> > +		};
> > +
> > +		led3 {
> > +			label = "green:user3";
> > +			gpios = <&gpiog 0 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "mmc1";
> > +			default-state = "off";
> > +		};
> > +
> > +		led4 {
> > +			label = "green:user3";
> > +			gpios = <&gpiog 1 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "none";
> > +			default-state = "off";
> > +			panic-indicator;
> > +		};
> > +
> > +		led5 {
> > +			label = "yellow:wifi";
> > +			gpios = <&gpioz 3 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "phy0tx";
> > +			default-state = "off";
> > +		};
> > +
> > +		led6 {
> > +			label = "blue:bt";
> > +			gpios = <&gpioz 6 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "bluetooth-power";
> > +			default-state = "off";
> > +		};
> > +	};
> > +};
> > +
> > +&ethernet0 {
> > +	status = "okay";
> > +	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
> > +	pinctrl-1 = <&ethernet0_rgmii_pins_sleep_a>;
> > +	pinctrl-names = "default", "sleep";
> > +	phy-mode = "rgmii";
> > +	max-speed = <1000>;
> > +	phy-handle = <&phy0>;
> > +
> > +	mdio0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		compatible = "snps,dwmac-mdio";
> > +		phy0: ethernet-phy@7 {
> > +			reg = <7>;
> > +		};
> > +	};
> > +};
> > +
> > +&i2c1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c1_pins_b>;
> > +	i2c-scl-rising-time-ns = <185>;
> > +	i2c-scl-falling-time-ns = <20>;
> > +	status = "okay";
> > +	/delete-property/dmas;
> > +	/delete-property/dma-names;
> > +};
> > +
> > +&i2c2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c2_pins_b>;
> > +	i2c-scl-rising-time-ns = <185>;
> > +	i2c-scl-falling-time-ns = <20>;
> > +	status = "okay";
> > +	/delete-property/dmas;
> > +	/delete-property/dma-names;
> > +};
> > +
> > +&i2c4 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c4_pins_a>;
> > +	i2c-scl-rising-time-ns = <185>;
> > +	i2c-scl-falling-time-ns = <20>;
> > +	status = "okay";
> > +	/delete-property/dmas;
> > +	/delete-property/dma-names;
> > +
> > +	pmic: stpmic@33 {
> > +		compatible = "st,stpmic1";
> > +		reg = <0x33>;
> > +		interrupts-extended = <&exti 55 IRQ_TYPE_EDGE_FALLING>;
> > +		interrupt-controller;
> > +		#interrupt-cells = <2>;
> > +		status = "okay";
> > +
> > +		st,main-control-register = <0x04>;
> > +		st,vin-control-register = <0xc0>;
> > +		st,usb-control-register = <0x30>;
> > +
> > +		regulators {
> > +			compatible = "st,stpmic1-regulators";
> > +
> > +			ldo1-supply = <&v3v3>;
> > +			ldo2-supply = <&v3v3>;
> > +			ldo3-supply = <&vdd_ddr>;
> > +			ldo5-supply = <&v3v3>;
> > +			ldo6-supply = <&v3v3>;
> > +			pwr_sw1-supply = <&bst_out>;
> > +			pwr_sw2-supply = <&bst_out>;
> > +
> > +			vddcore: buck1 {
> > +				regulator-name = "vddcore";
> > +				regulator-min-microvolt = <1200000>;
> > +				regulator-max-microvolt = <1350000>;
> > +				regulator-always-on;
> > +				regulator-initial-mode = <0>;
> > +				regulator-over-current-protection;
> > +			};
> > +
> > +			vdd_ddr: buck2 {
> > +				regulator-name = "vdd_ddr";
> > +				regulator-min-microvolt = <1350000>;
> > +				regulator-max-microvolt = <1350000>;
> > +				regulator-always-on;
> > +				regulator-initial-mode = <0>;
> > +				regulator-over-current-protection;
> > +			};
> > +
> > +			vdd: buck3 {
> > +				regulator-name = "vdd";
> > +				regulator-min-microvolt = <3300000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-always-on;
> > +				st,mask_reset;
> > +				regulator-initial-mode = <0>;
> > +				regulator-over-current-protection;
> > +			};
> > +
> > +			v3v3: buck4 {
> > +				regulator-name = "v3v3";
> > +				regulator-min-microvolt = <3300000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-always-on;
> > +				regulator-over-current-protection;
> > +				regulator-initial-mode = <0>;
> > +			};
> > +
> > +			vdda: ldo1 {
> > +				regulator-name = "vdda";
> > +				regulator-min-microvolt = <2900000>;
> > +				regulator-max-microvolt = <2900000>;
> > +				interrupts = <IT_CURLIM_LDO1 0>;
> > +				interrupt-parent = <&pmic>;
> > +			};
> > +
> > +			v2v8: ldo2 {
> > +				regulator-name = "v2v8";
> > +				regulator-min-microvolt = <2800000>;
> > +				regulator-max-microvolt = <2800000>;
> > +				interrupts = <IT_CURLIM_LDO2 0>;
> > +				interrupt-parent = <&pmic>;
> > +			};
> > +
> > +			vtt_ddr: ldo3 {
> > +				regulator-name = "vtt_ddr";
> > +				regulator-min-microvolt = <500000>;
> > +				regulator-max-microvolt = <750000>;
> > +				regulator-always-on;
> > +				regulator-over-current-protection;
> > +			};
> > +
> > +			vdd_usb: ldo4 {
> > +				regulator-name = "vdd_usb";
> > +				regulator-min-microvolt = <3300000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				interrupts = <IT_CURLIM_LDO4 0>;
> > +				interrupt-parent = <&pmic>;
> > +			};
> > +
> > +			vdd_sd: ldo5 {
> > +				regulator-name = "vdd_sd";
> > +				regulator-min-microvolt = <2900000>;
> > +				regulator-max-microvolt = <2900000>;
> > +				interrupts = <IT_CURLIM_LDO5 0>;
> > +				interrupt-parent = <&pmic>;
> > +				regulator-boot-on;
> > +			};
> > +
> > +			v1v8: ldo6 {
> > +				regulator-name = "v1v8";
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				interrupts = <IT_CURLIM_LDO6 0>;
> > +				interrupt-parent = <&pmic>;
> > +				regulator-enable-ramp-delay = <300000>;
> > +			};
> > +
> > +			vref_ddr: vref_ddr {
> > +				regulator-name = "vref_ddr";
> > +				regulator-always-on;
> > +				regulator-over-current-protection;
> > +			};
> > +
> > +			bst_out: boost {
> > +				regulator-name = "bst_out";
> > +				interrupts = <IT_OCP_BOOST 0>;
> > +				interrupt-parent = <&pmic>;
> > +			};
> > +
> > +			vbus_otg: pwr_sw1 {
> > +				regulator-name = "vbus_otg";
> > +				interrupts = <IT_OCP_OTG 0>;
> > +				interrupt-parent = <&pmic>;
> > +				regulator-active-discharge;
> > +			};
> > +
> > +			vbus_sw: pwr_sw2 {
> > +				regulator-name = "vbus_sw";
> > +				interrupts = <IT_OCP_SWOUT 0>;
> > +				interrupt-parent = <&pmic>;
> > +				regulator-active-discharge;
> > +			};
> > +		};
> > +
> > +		onkey {
> > +			compatible = "st,stpmic1-onkey";
> > +			interrupts = <IT_PONKEY_F 0>, <IT_PONKEY_R 1>;
> > +			interrupt-names = "onkey-falling", "onkey-rising";
> > +			status = "okay";
> > +		};
> > +
> > +		watchdog {
> > +			compatible = "st,stpmic1-wdt";
> > +			status = "disabled";
> > +		};
> > +	};
> > +};
> > +
> > +&iwdg2 {
> > +	timeout-sec = <32>;
> > +	status = "okay";
> > +};
> > +
> > +&rng1 {
> > +	status = "okay";
> > +};
> > +
> > +&rtc {
> > +	status = "okay";
> > +};
> > +
> > +&sdmmc1 {
> > +	pinctrl-names = "default", "opendrain", "sleep";
> > +	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_dir_pins_a>;
> > +	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
> > +	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
> > +	broken-cd;
> > +	st,sig-dir;
> > +	st,neg-edge;
> > +	st,use-ckin;
> > +	bus-width = <4>;
> > +	vmmc-supply = <&vdd_sd>;
> > +	status = "okay";
> > +};
> > +
> > +&uart4 {
> > +	/* On Low speed expansion header */
> > +	label = "LS-UART1";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart4_pins_b>;
> > +	status = "okay";
> > +};
> > +
> > +&uart7 {
> > +	/* On Low speed expansion header */
> > +	label = "LS-UART0";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart7_pins_a>;
> > +	status = "okay";
> > +};
> > 
