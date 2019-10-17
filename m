Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1C5CA9EC8
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 23:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B72621D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 23:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441795AbfJQXkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 19:40:10 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33554 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438560AbfJQXkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 19:40:09 -0400
Received: from remote.shanghaihotelholland.com ([46.44.148.63] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iLFNE-0004OT-M8; Fri, 18 Oct 2019 01:40:04 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     kever.yang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add basic dts for RK3308 EVB
Date:   Fri, 18 Oct 2019 01:39:58 +0200
Message-ID: <120878573.PH0Dm224ES@phil>
In-Reply-To: <20191017030520.32420-1-andy.yan@rock-chips.com>
References: <20191017030242.32219-1-andy.yan@rock-chips.com> <20191017030520.32420-1-andy.yan@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Am Donnerstag, 17. Oktober 2019, 05:05:20 CEST schrieb Andy Yan:
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index c82c5e57d44c..b680c4b8b2c9 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -447,6 +447,11 @@ properties:
>            - const: rockchip,r88
>            - const: rockchip,rk3368
>  
> +      - description: Rockchip RK3308 Evaluation board
> +        items:
> +          - const: rockchip,rk3308-evb
> +          - const: rockchip,rk3308
> +
>        - description: Rockchip RK3228 Evaluation board
>          items:
>            - const: rockchip,rk3228-evb

Rob likes the binding addition to be a separate patch.

> +	vdd_log: vdd_core: vdd-core {
> +		compatible = "pwm-regulator";
> +		pwms = <&pwm0 0 5000 1>;
> +		regulator-name = "vdd_core";
> +		regulator-min-microvolt = <827000>;
> +		regulator-max-microvolt = <1340000>;
> +		regulator-init-microvolt = <1015000>;
> +		regulator-early-min-microvolt = <1015000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-settling-time-up-us = <250>;
> +		status = "okay";

It's a board-regulator, so always "okay", no need for a status.

In general for regulators, please create an actual regulator tree, with
correctly modelled supply-chains following the naming according
to the board schematics. See for example rk3399-gru for a nice example.

> +	};
> +
> +	vdd_1v0: vdd-1v0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_1v0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1000000>;
> +		regulator-max-microvolt = <1000000>;

As noted above, missing vin-supply

> +	};
> +

> +	vccio_flash: vccio-flash {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vccio_flash";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	vcc_phy: vcc-phy-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_phy";
> +		regulator-always-on;
> +		regulator-boot-on;

This is the classic example of not following the schematics.
I.e. no Rockchip board I know has a regulator named "vcc_phy"
that is completely unconnected, yet all boards in the vendor tree
have this regulator ;-) ... so as I said, please follow the schematics.

> +	};
> +
> +	vbus_host: vbus-host-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_drv>;
> +		regulator-name = "vbus_host";
> +	};
> +};
> +


Thanks
Heiko


