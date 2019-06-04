Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387B5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3DA2488E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfFDOIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:08:25 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48058 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfFDOIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:08:24 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hYA6v-0001Xj-6y; Tue, 04 Jun 2019 16:08:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     xieqinick@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, nick@khadas.com
Subject: Re: [PATCH] arm64: dts: rockchip: Add support for Khadas Edge/Edge-V/Captain boards
Date:   Tue, 04 Jun 2019 16:08:20 +0200
Message-ID: <2074921.iWOsiWxYGh@phil>
In-Reply-To: <1559035267-1884-1-git-send-email-xieqinick@gmail.com>
References: <1559035267-1884-1-git-send-email-xieqinick@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

devicetrees look mostly good, with a bit of "bookkeeping" issues and
some small nits below.

Am Dienstag, 28. Mai 2019, 11:21:07 CEST schrieb xieqinick@gmail.com:
> From: Nick <nick@khadas.com>

Can you provide a full name (first-+surename) for patch from and Signed-off
lines please?


> Add devicetree support for Khadas Edge/Edge-V/Captain boards.
> Khadas Edge is an expandable Rockchip RK3399 board with goldfinger.
> Khadas Captain is the carrier board for Khadas Edge.
> Khadas Edge-V is a Khadas VIM form factor Rockchip RK3399 board.
> 
> Signed-off-by: Nick <nick@khadas.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile              |   3 +
>  .../boot/dts/rockchip/rk3399-khadas-captain.dts    |  27 +
>  .../boot/dts/rockchip/rk3399-khadas-edge-v.dts     |  28 +

when adding boards, please also make sure to add entries to
	Documentation/devicetree/bindings/arm/rockchip.yaml

Take a look at the "FriendlyElec NanoPi4 series boards" for an
example on how to add a family of boards like your Edge/Captain.


> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-captain.dts b/arch/arm64/boot/dts/rockchip/rk3399-khadas-captain.dts
> new file mode 100644
> index 0000000..85eb51c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-captain.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Shenzhen Wesion Technology Co., Ltd.
> + * (https://www.khadas.com)
> + */
> +
> +/dts-v1/;
> +#include "rk3399-khadas-edge.dtsi"
> +
> +/ {
> +	model = "Khadas Captain";
> +	compatible = "khadas,captain", "rockchip,rk3399";
> +};
> +
> +&gmac {
> +	status = "okay";
> +};
> +
> +&pcie_phy {
> +	status = "okay";
> +};
> +
> +&pcie0 {
> +	ep-gpios = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
> +	num-lanes = <4>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dts b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dts
> new file mode 100644
> index 0000000..396b7f4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dts
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Shenzhen Wesion Technology Co., Ltd.
> + * (https://www.khadas.com)
> + */
> +
> +/dts-v1/;
> +#include "rk3399-khadas-edge.dtsi"
> +
> +/ {
> +	model = "Khadas Edge-V";
> +	compatible = "khadas,edge-v", "rockchip,rk3399";
> +};
> +
> +&gmac {
> +	status = "okay";
> +};
> +
> +&pcie_phy {
> +	status = "okay";
> +};
> +
> +&pcie0 {
> +	ep-gpios = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
> +	num-lanes = <4>;
> +	status = "okay";
> +};
> +

Both Captain and Edge-V seem to be identical from a component point
of view, so should likely share the same dts, or is there some major
difference coming later?

For the time being you can represent the individual boards like:

	model = "Khadas Edge-V/Captain";
	compatible = "khadas,edge-v", "khadas,edge-captain", "rockchip,rk3399";

Also to show that it's Edge+Captain baseboard, maybe you want to
change the name like shown above (see rk3399-puma-haikou for a similar
setup).


> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dts b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dts
> new file mode 100644
> index 0000000..f0d5bae
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dts
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Shenzhen Wesion Technology Co., Ltd.
> + * (https://www.khadas.com)
> + */
> +
> +/dts-v1/;
> +#include "rk3399-khadas-edge.dtsi"
> +
> +/ {
> +	model = "Khadas Edge";
> +	compatible = "khadas,edge", "rockchip,rk3399";
> +};
> +
> +&gmac {
> +	status = "disabled";

the Edge-V/Captain boards do enable the gmac, so you shouldn't need
a special disable here. Just keep it disabled in the edge.dtsi
[aka it comes in the disabled state from rk3399.dtsi already].

> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> new file mode 100644
> index 0000000..872b535
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> @@ -0,0 +1,795 @@

[...]

> +&gmac {
> +	assigned-clocks = <&cru SCLK_RMII_SRC>;
> +	assigned-clock-parents = <&clkin_gmac>;
> +	clock_in_out = "input";
> +	phy-supply = <&vcc_lan>;
> +	phy-mode = "rgmii";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_pins>;
> +	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 10000 50000>;
> +	tx_delay = <0x28>;
> +	rx_delay = <0x11>;
> +	status = "disabled";

status is disabled coming from rk3399.dtsi, so there is no need
to "re-disable" it here.

> +};
> +

[...]

> +&sdio0 {
> +	/* WiFi & BT combo module Ampak AP6356S */
> +	bus-width = <4>;
> +	cap-sdio-irq;
> +	cap-sd-highspeed;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	num-slots = <1>;

num-slots is not needed anymore

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> +	sd-uhs-sdr104;
> +
> +	/* Power supply */

drop that comment and blank line please. Properties called
*-supply already tell you that they are power supplies :-) .


Heiko


