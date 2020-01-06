Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24751C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BE32081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgAFOVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:21:44 -0500
Received: from gloria.sntech.de ([185.11.138.130]:51568 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgAFOVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:21:43 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ioTFp-0005Md-9V; Mon, 06 Jan 2020 15:21:13 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Akash Gajjar <akash@openedev.com>
Cc:     jagan@openedev.com, tom@radxa.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vivek Unune <npcomplete13@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nick Xie <nick@khadas.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3, 1/1] arm64: dts: rockchip: add ROCK Pi S DTS support
Date:   Mon, 06 Jan 2020 15:21:12 +0100
Message-ID: <14039094.HKn2KS7fIZ@diego>
In-Reply-To: <20191230145008.5899-1-akash@openedev.com>
References: <20191230145008.5899-1-akash@openedev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akash,

Am Montag, 30. Dezember 2019, 15:49:32 CET schrieb Akash Gajjar:
> ROCK Pi S is RK3308 based SBC from radxa.com. ROCK Pi S has a,
> - 256MB/512MB DDR3 RAM
> - SD, NAND flash (optional on board 1/2/4/8Gb)
> - 100MB ethernet, PoE (optional)
> - Onboard 802.11 b/g/n wifi + Bluetooth 4.0 Module
> - USB2.0 Type-A HOST x1
> - USB3.0 Type-C OTG x1
> - 26-pin expansion header
> - USB Type-C DC 5V Power Supply
> 
> This patch enables
> - Console
> - NAND Flash
> - SD Card
> 
> Signed-off-by: Akash Gajjar <akash@openedev.com>

> +&emmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	supports-sd;

supports-sd is not a property

> +	disable-wp;
> +	non-removable;
> +	num-slots = <1>;

nums-slots was removed very long ago

> +	vin-supply = <&vcc_io>;

please provide actual vmmc and vqmmc supplies
vin is not a valid supply for emmcs

> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	max-frequeency = <150000000>;
> +	supports-sd;

supports-sd is not a valid property

> +	disable-wp;
> +	num-slots = <1>;

again, obsolete num-slots

> +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_det &sdmmc_bus4>;
> +	card-detect-delay = <800>;
> +	status = "okay";
> +};
> +
> +&spi2 {
> +	status = "okay";
> +	max-freq = <10000000>;
> +};
> +
> +&pinctrl {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rtc_32k>;
> +
> +	leds {
> +		green_led_gio: green-led-gpio {
> +			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		heartbeat_led_gpio: heartbeat-led-gpio {
> +			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb {
> +		otg_vbus_drv: otg-vbus-drv {
> +			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	sdio-pwrseq {
> +		wifi_enable_h: wifi-enable-h {
> +			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		wifi_host_wake: wifi-host-wake {
> +			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +};
> +
> +&pwm0 {
> +	status = "okay";
> +	pinctrl-0 = <&pwm0_pin_pull_down>;
> +};
> +
> +&saradc {
> +	vref-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdio {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	bus-width = <4>;
> +	max-frequency = <1000000>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	supports-sdio;

not a valid property

> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	sd-uhs-sdr104;
> +	status = "okay";
> +};

Heiko


