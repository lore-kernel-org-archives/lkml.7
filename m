Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF1AC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED8F2251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfKTNZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:25:26 -0500
Received: from gloria.sntech.de ([185.11.138.130]:39126 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfKTNZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:25:26 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iXPyf-0003PK-3b; Wed, 20 Nov 2019 14:25:01 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 4/5] ARM: dts: rockchip: Add Radxa Carrier board
Date:   Wed, 20 Nov 2019 14:25:00 +0100
Message-ID: <5644395.EDGZVd1YuU@diego>
In-Reply-To: <20191120113923.11685-5-jagan@amarulasolutions.com>
References: <20191120113923.11685-1-jagan@amarulasolutions.com> <20191120113923.11685-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

Am Mittwoch, 20. November 2019, 12:39:22 CET schrieb Jagan Teki:
> Carrier board often referred as baseboard. For making
> complete SBC, the associated SOM will mount on top of
> this carrier board.
> 
> Radxa has a carrier board which supports on board
> peripherals, ports like USB-2.0, USB-3.0, HDMI, MIPI DSI/CSI,
> eDP, Ethernet, PCIe, USB-C, 40-Pin GPIO header and etc.
> 
> Currently this carrier board can be used together with
> VMARC RK3399Por SOM for making Rock PI N10 SBC.
> 
> So add this carrier board dtsi as a separate file in
> ARM directory, so-that the same can reuse it in both
> arm32 and arm64 variants of Rockchip SOMs.

Do you really think someone will create an arm32 soc using that
carrier board?

Similarly so far I don't think we haven't even seen a lot of reuse
of existing carrier boards at all, other than their initial combination.

So maybe just having the content of your
	rockchip-radxa-carrierboard.dtsi
in
	rockchip/rk3399pro-rock-pi-n10.dts
from patch 5 might be a better start - at least until there is any
further usage - if at all?

Also rockchip-radxa-carrierboard might even be overly generic
as there may be multiple carrierboards from Radxa later on.

Heiko


> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../boot/dts/rockchip-radxa-carrierboard.dtsi | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rockchip-radxa-carrierboard.dtsi
> 
> diff --git a/arch/arm/boot/dts/rockchip-radxa-carrierboard.dtsi b/arch/arm/boot/dts/rockchip-radxa-carrierboard.dtsi
> new file mode 100644
> index 000000000000..df3712aedf8a
> --- /dev/null
> +++ b/arch/arm/boot/dts/rockchip-radxa-carrierboard.dtsi
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
> + * Copyright (c) 2019 Radxa Limited
> + * Copyright (c) 2019 Amarula Solutions(India)
> + */
> +
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +};
> +
> +&gmac {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	i2c-scl-rising-time-ns = <140>;
> +	i2c-scl-falling-time-ns = <30>;
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	hym8563: hym8563@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "hym8563";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hym8563_int>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&pwm0 {
> +	status = "okay";
> +};
> +
> +&pwm2 {
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	vqmmc-supply = <&vccio_sd>;
> +	max-frequency = <150000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_xfer &uart0_cts>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	hym8563 {
> +		hym8563_int: hym8563-int {
> +			rockchip,pins =
> +				<4 RK_PD6 0 &pcfg_pull_up>;
> +		};
> +	};
> +};
> 




