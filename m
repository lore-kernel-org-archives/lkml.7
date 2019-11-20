Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59CBC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966F8224CD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfKTN3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:29:01 -0500
Received: from gloria.sntech.de ([185.11.138.130]:39182 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729530AbfKTN3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:29:01 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iXQ2M-0003QS-LP; Wed, 20 Nov 2019 14:28:50 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 2/5] arm64: dts: rockchip: Add VMARC RK3399Pro SOM initial support
Date:   Wed, 20 Nov 2019 14:28:50 +0100
Message-ID: <1707486.7nrk6WTBgP@diego>
In-Reply-To: <20191120113923.11685-3-jagan@amarulasolutions.com>
References: <20191120113923.11685-1-jagan@amarulasolutions.com> <20191120113923.11685-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

looks good in general, just some small things below:

Am Mittwoch, 20. November 2019, 12:39:20 CET schrieb Jagan Teki:
> VMARC RK3399Pro SOM is a standard SMARC SOM design with
> Rockchip RK3399Pro SoC, which is designed by Vamrs.
> 
> Specification:
> - Rockchip RK3399Pro
> - PMIC: RK809-3
> - SD slot, 16GiB eMMC
> - 2xUSB-2.0, 1xUSB3.0
> - USB-C for power supply
> - Ethernet, PCIe
> - HDMI, MIPI-DSI/CSI, eDP
> 
> Add initial support for VMARC RK3399Pro SOM, this would use
> with associated carrier board.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 339 ++++++++++++++++++
>  1 file changed, 339 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> new file mode 100644
> index 000000000000..ddf6ebc9fbe3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> @@ -0,0 +1,339 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
> + * Copyright (c) 2019 Vamrs Limited
> + * Copyright (c) 2019 Amarula Solutions(India)
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	compatible = "vamrs,rk3399pro-vmarc-som", "rockchip,rk3399pro";
> +
> +	clkin_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clkin_gmac";
> +		#clock-cells = <0>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;

Is vcc5v0_sys really the topmost regulator getting the outside
power-supply?


> +	};
> +
> +	vcc_lan: vcc3v3-phy-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_lan";

vcc_lan / vcc_phy is mostly coming from the vendor bsp in some way
and will be named differently in schematics ... also it should be connected
to the regulator tree.

[...]

> +&tsadc {
> +	status = "okay";
> +
> +	/* tshut mode 0:CRU 1:GPIO */

I think we can live without the additional comments for properties :-)

> +	rockchip,hw-tshut-mode = <1>;
> +	/* tshut polarity 0:LOW 1:HIGH */
> +	rockchip,hw-tshut-polarity = <1>;
> +};

Heiko



