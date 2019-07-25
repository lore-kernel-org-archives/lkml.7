Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEECAC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00A222C7E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfGYWTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:19:41 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40234 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbfGYWTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:19:40 -0400
Received: from d57e23da.static.ziggozakelijk.nl ([213.126.35.218] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hqm5F-0002LK-D0; Fri, 26 Jul 2019 00:19:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: add device tree for Mecer Xtreme Mini S6
Date:   Fri, 26 Jul 2019 00:19:32 +0200
Message-ID: <1618985.EOrKlNyPW4@phil>
In-Reply-To: <20190616204746.21001-1-justin.swartz@risingedge.co.za>
References: <20190616204746.21001-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

Am Sonntag, 16. Juni 2019, 22:47:45 CEST schrieb Justin Swartz:
> The Mecer Xtreme Mini S6 features a Rockchip RK3229 SoC,
> 1GB DDR3 RAM, 8GB eMMC, MicroSD port, 10/100Mbps Ethernet,
> Realtek 8723BS WLAN module, 2 x USB 2.0 ports, HDMI output,
> and S/PDIF output.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---

please add an entry to Documentation/devicetree/bindings/arm/rockchip.yaml
for your board and if necessary also a vendor-prefix to
Documentation/devicetree/bindings/vendor-prefixes.(yaml?)

See below.

>  arch/arm/boot/dts/Makefile        |   1 +
>  arch/arm/boot/dts/rk3229-xms6.dts | 286 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 287 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3229-xms6.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index dab2914fa293..6fbd7c304f62 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -902,6 +902,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>  	rk3188-radxarock.dtb \
>  	rk3228-evb.dtb \
>  	rk3229-evb.dtb \
> +	rk3229-xms6.dtb \
>  	rk3288-evb-act8846.dtb \
>  	rk3288-evb-rk808.dtb \
>  	rk3288-fennec.dtb \
> diff --git a/arch/arm/boot/dts/rk3229-xms6.dts b/arch/arm/boot/dts/rk3229-xms6.dts
> new file mode 100644
> index 000000000000..9b666fa66292
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3229-xms6.dts
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include "rk3229.dtsi"
> +
> +/ {
> +	model = "Rockchip RK3229 (Mecer Xtreme Mini S6)";
> +	compatible = "rockchip,rk3229-xms6", "rockchip,rk3229";

mode = "Mecer Xtreme Mini S6";
compatible = "mecer,xms6", "rockchip,rk3229";

(and as written above, add a vendor-prefix for mecer)

...

> +&cpu0 {
> +	clock-frequency = <1464000000>;

not sure I understand the reasoning here.
There seems to be a regulator defined, so the cpu cores should
have operating points defined to allow them to switch between
different frequencies as needed.

> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu1 {
> +	clock-frequency = <1464000000>;
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu2 {
> +	clock-frequency = <1464000000>;
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu3 {
> +	clock-frequency = <1464000000>;
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&vop {

please sort the &node-references alphabetically.


Heiko


