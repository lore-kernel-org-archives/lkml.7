Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDAFC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B0021835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfJHMzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:55:16 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:44795 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfJHMzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:55:16 -0400
X-Originating-IP: 2.139.156.91
Received: from localhost (91.red-2-139-156.staticip.rima-tde.net [2.139.156.91])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 7121B1BF210;
        Tue,  8 Oct 2019 12:55:10 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Konstantin Porotchkin <kostap@marvell.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: marvell: add ESPRESSObin variants
In-Reply-To: <20190603155354.3902-1-tmn505@gmail.com>
References: <20190603155354.3902-1-tmn505@gmail.com>
Date:   Tue, 08 Oct 2019 14:55:09 +0200
Message-ID: <87a7abtn0y.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz Maciej Nowak,

> This commit adds dts for different variants of ESPRESSObin board:
>
> ESPRESSObin with soldered eMMC,
>
> ESPRESSObin V7, compared to prior versions some passive elements changed
> and ethernet ports labels positions have been reversed,
>
> ESPRESSObin V7 with soldered eMMC.
>
> Since most of elements are the same, one common dtsi is created and
> referenced in each dts of particular variant.
>
> Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>


Applied on mvebu/dt

Sorry for the delay.

Thanks,

Gregory

> ---
> v1 -> v2 rebase on top of:
> mvebu/dt64 + "arm64: dts: armada-3720-espressobin: correct spi node"
>
>  .../marvell/armada-3720-espressobin-emmc.dts  |  42 ++++
>  .../armada-3720-espressobin-v7-emmc.dts       |  59 ++++++
>  .../marvell/armada-3720-espressobin-v7.dts    |  36 ++++
>  .../dts/marvell/armada-3720-espressobin.dts   | 184 +-----------------
>  .../dts/marvell/armada-3720-espressobin.dtsi  | 177 +++++++++++++++++
>  5 files changed, 315 insertions(+), 183 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> new file mode 100644
> index 000000000000..bd9ed9dc9c3e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree file for Globalscale Marvell ESPRESSOBin Board with eMMC
> + * Copyright (C) 2018 Marvell
> + *
> + * Romain Perier <romain.perier@free-electrons.com>
> + * Konstantin Porotchkin <kostap@marvell.com>
> + *
> + */
> +/*
> + * Schematic available at http://espressobin.net/wp-content/uploads/2017/08/ESPRESSObin_V5_Schematics.pdf
> + */
> +
> +#include "armada-3720-espressobin.dtsi"
> +
> +/ {
> +	model = "Globalscale Marvell ESPRESSOBin Board (eMMC)";
> +	compatible = "globalscale,espressobin-emmc", "globalscale,espressobin",
> +		     "marvell,armada3720", "marvell,armada3710";
> +};
> +
> +/* U11 */
> +&sdhci0 {
> +	non-removable;
> +	bus-width = <8>;
> +	mmc-ddr-1_8v;
> +	mmc-hs400-1_8v;
> +	marvell,xenon-emmc;
> +	marvell,xenon-tun-count = <9>;
> +	marvell,pad-type = "fixed-1-8v";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc_pins>;
> +	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	mmccard: mmccard@0 {
> +		compatible = "mmc-card";
> +		reg = <0>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> new file mode 100644
> index 000000000000..6e876a6d9532
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree file for Globalscale Marvell ESPRESSOBin Board V7 with eMMC
> + * Copyright (C) 2018 Marvell
> + *
> + * Romain Perier <romain.perier@free-electrons.com>
> + * Konstantin Porotchkin <kostap@marvell.com>
> + *
> + */
> +/*
> + * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
> + */
> +
> +#include "armada-3720-espressobin.dtsi"
> +
> +/ {
> +	model = "Globalscale Marvell ESPRESSOBin Board V7 (eMMC)";
> +	compatible = "globalscale,espressobin-v7-emmc", "globalscale,espressobin-v7",
> +		     "globalscale,espressobin", "marvell,armada3720",
> +		     "marvell,armada3710";
> +};
> +
> +&switch0 {
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			label = "lan1";
> +			phy-handle = <&switch0phy0>;
> +		};
> +
> +		port@3 {
> +			reg = <3>;
> +			label = "wan";
> +			phy-handle = <&switch0phy2>;
> +		};
> +	};
> +};
> +
> +/* U11 */
> +&sdhci0 {
> +	non-removable;
> +	bus-width = <8>;
> +	mmc-ddr-1_8v;
> +	mmc-hs400-1_8v;
> +	marvell,xenon-emmc;
> +	marvell,xenon-tun-count = <9>;
> +	marvell,pad-type = "fixed-1-8v";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc_pins>;
> +	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	mmccard: mmccard@0 {
> +		compatible = "mmc-card";
> +		reg = <0>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> new file mode 100644
> index 000000000000..0f8405d085fd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree file for Globalscale Marvell ESPRESSOBin Board V7
> + * Copyright (C) 2018 Marvell
> + *
> + * Romain Perier <romain.perier@free-electrons.com>
> + * Konstantin Porotchkin <kostap@marvell.com>
> + *
> + */
> +/*
> + * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
> + */
> +
> +#include "armada-3720-espressobin.dtsi"
> +
> +/ {
> +	model = "Globalscale Marvell ESPRESSOBin Board V7";
> +	compatible = "globalscale,espressobin-v7", "globalscale,espressobin",
> +		     "marvell,armada3720", "marvell,armada3710";
> +};
> +
> +&switch0 {
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			label = "lan1";
> +			phy-handle = <&switch0phy0>;
> +		};
> +
> +		port@3 {
> +			reg = <3>;
> +			label = "wan";
> +			phy-handle = <&switch0phy2>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index fbcf03f86c96..1542d836c090 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -12,191 +12,9 @@
>  
>  /dts-v1/;
>  
> -#include <dt-bindings/gpio/gpio.h>
> -#include "armada-372x.dtsi"
> +#include "armada-3720-espressobin.dtsi"
>  
>  / {
>  	model = "Globalscale Marvell ESPRESSOBin Board";
>  	compatible = "globalscale,espressobin", "marvell,armada3720", "marvell,armada3710";
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -
> -	memory@0 {
> -		device_type = "memory";
> -		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
> -	};
> -
> -	vcc_sd_reg1: regulator {
> -		compatible = "regulator-gpio";
> -		regulator-name = "vcc_sd1";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <3300000>;
> -		regulator-boot-on;
> -
> -		gpios = <&gpionb 4 GPIO_ACTIVE_HIGH>;
> -		gpios-states = <0>;
> -		states = <1800000 0x1
> -			  3300000 0x0>;
> -		enable-active-high;
> -	};
> -};
> -
> -/* J9 */
> -&pcie0 {
> -	status = "okay";
> -	phys = <&comphy1 0>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
> -};
> -
> -/* J6 */
> -&sata {
> -	status = "okay";
> -	phys = <&comphy2 0>;
> -	phy-names = "sata-phy";
> -};
> -
> -/* J1 */
> -&sdhci1 {
> -	wp-inverted;
> -	bus-width = <4>;
> -	cd-gpios = <&gpionb 3 GPIO_ACTIVE_LOW>;
> -	marvell,pad-type = "sd";
> -	vqmmc-supply = <&vcc_sd_reg1>;
> -
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio_pins>;
> -	status = "okay";
> -};
> -
> -/* U11 */
> -&sdhci0 {
> -	non-removable;
> -	bus-width = <8>;
> -	mmc-ddr-1_8v;
> -	mmc-hs400-1_8v;
> -	marvell,xenon-emmc;
> -	marvell,xenon-tun-count = <9>;
> -	marvell,pad-type = "fixed-1-8v";
> -
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc_pins>;
> -/*
> - * This eMMC is not populated on all boards, so disable it by
> - * default and let the bootloader enable it, if it is present
> - */
> -	status = "disabled";
> -};
> -
> -&spi0 {
> -	status = "okay";
> -
> -	flash@0 {
> -		reg = <0>;
> -		compatible = "jedec,spi-nor";
> -		spi-max-frequency = <104000000>;
> -		m25p,fast-read;
> -	};
> -};
> -
> -/* Exported on the micro USB connector J5 through an FTDI */
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart1_pins>;
> -	status = "okay";
> -};
> -
> -/*
> - * Connector J17 and J18 expose a number of different features. Some pins are
> - * multiplexed. This is the case for instance for the following features:
> - * - UART1 (pin 24 = RX, pin 26 = TX). See armada-3720-db.dts for an example of
> - *   how to enable it. Beware that the signals are 1.8V TTL.
> - * - I2C
> - * - SPI
> - * - MMC
> - */
> -
> -/* J7 */
> -&usb3 {
> -	status = "okay";
> -};
> -
> -/* J8 */
> -&usb2 {
> -	status = "okay";
> -};
> -
> -&mdio {
> -	switch0: switch0@1 {
> -		compatible = "marvell,mv88e6085";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		reg = <1>;
> -
> -		dsa,member = <0 0>;
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> -				label = "cpu";
> -				ethernet = <&eth0>;
> -				phy-mode = "rgmii-id";
> -				fixed-link {
> -					speed = <1000>;
> -					full-duplex;
> -				};
> -			};
> -
> -			port@1 {
> -				reg = <1>;
> -				label = "wan";
> -				phy-handle = <&switch0phy0>;
> -			};
> -
> -			port@2 {
> -				reg = <2>;
> -				label = "lan0";
> -				phy-handle = <&switch0phy1>;
> -			};
> -
> -			port@3 {
> -				reg = <3>;
> -				label = "lan1";
> -				phy-handle = <&switch0phy2>;
> -			};
> -
> -		};
> -
> -		mdio {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			switch0phy0: switch0phy0@11 {
> -				reg = <0x11>;
> -			};
> -			switch0phy1: switch0phy1@12 {
> -				reg = <0x12>;
> -			};
> -			switch0phy2: switch0phy2@13 {
> -				reg = <0x13>;
> -			};
> -		};
> -	};
> -};
> -
> -&eth0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>, <&smi_pins>;
> -	phy-mode = "rgmii-id";
> -	status = "okay";
> -
> -	fixed-link {
> -		speed = <1000>;
> -		full-duplex;
> -	};
>  };
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> new file mode 100644
> index 000000000000..53b8ac55a7f3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree file for Globalscale Marvell ESPRESSOBin Board
> + * Copyright (C) 2016 Marvell
> + *
> + * Romain Perier <romain.perier@free-electrons.com>
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "armada-372x.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
> +	};
> +
> +	vcc_sd_reg1: regulator {
> +		compatible = "regulator-gpio";
> +		regulator-name = "vcc_sd1";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +
> +		gpios = <&gpionb 4 GPIO_ACTIVE_HIGH>;
> +		gpios-states = <0>;
> +		states = <1800000 0x1
> +			  3300000 0x0>;
> +		enable-active-high;
> +	};
> +};
> +
> +/* J9 */
> +&pcie0 {
> +	status = "okay";
> +	phys = <&comphy1 0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
> +};
> +
> +/* J6 */
> +&sata {
> +	status = "okay";
> +	phys = <&comphy2 0>;
> +	phy-names = "sata-phy";
> +};
> +
> +/* J1 */
> +&sdhci1 {
> +	wp-inverted;
> +	bus-width = <4>;
> +	cd-gpios = <&gpionb 3 GPIO_ACTIVE_LOW>;
> +	marvell,pad-type = "sd";
> +	vqmmc-supply = <&vcc_sd_reg1>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio_pins>;
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +
> +	flash@0 {
> +		reg = <0>;
> +		compatible = "jedec,spi-nor";
> +		spi-max-frequency = <104000000>;
> +		m25p,fast-read;
> +	};
> +};
> +
> +/* Exported on the micro USB connector J5 through an FTDI */
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>;
> +	status = "okay";
> +};
> +
> +/*
> + * Connector J17 and J18 expose a number of different features. Some pins are
> + * multiplexed. This is the case for instance for the following features:
> + * - UART1 (pin 24 = RX, pin 26 = TX). See armada-3720-db.dts for an example of
> + *   how to enable it. Beware that the signals are 1.8V TTL.
> + * - I2C
> + * - SPI
> + * - MMC
> + */
> +
> +/* J7 */
> +&usb3 {
> +	status = "okay";
> +};
> +
> +/* J8 */
> +&usb2 {
> +	status = "okay";
> +};
> +
> +&mdio {
> +	switch0: switch0@1 {
> +		compatible = "marvell,mv88e6085";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <1>;
> +
> +		dsa,member = <0 0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				label = "cpu";
> +				ethernet = <&eth0>;
> +				phy-mode = "rgmii-id";
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				label = "wan";
> +				phy-handle = <&switch0phy0>;
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +				label = "lan0";
> +				phy-handle = <&switch0phy1>;
> +			};
> +
> +			port@3 {
> +				reg = <3>;
> +				label = "lan1";
> +				phy-handle = <&switch0phy2>;
> +			};
> +
> +		};
> +
> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			switch0phy0: switch0phy0@11 {
> +				reg = <0x11>;
> +			};
> +			switch0phy1: switch0phy1@12 {
> +				reg = <0x12>;
> +			};
> +			switch0phy2: switch0phy2@13 {
> +				reg = <0x13>;
> +			};
> +		};
> +	};
> +};
> +
> +&eth0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_pins>, <&smi_pins>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +
> +	fixed-link {
> +		speed = <1000>;
> +		full-duplex;
> +	};
> +};
> -- 
> 2.21.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
