Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2574EC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 08:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CF320665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 08:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfFVIeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 04:34:05 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36032 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfFVIeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 04:34:04 -0400
Received: from p508fd9dc.dip0.t-ipconnect.de ([80.143.217.220] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hebTB-0004tX-Q4; Sat, 22 Jun 2019 10:33:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: add ethernet phy node for tinker board
Date:   Sat, 22 Jun 2019 10:33:57 +0200
Message-ID: <1871177.hjLhdHVgcu@phil>
In-Reply-To: <20190621180017.29646-1-katsuhiro@katsuster.net>
References: <20190621180017.29646-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Freitag, 21. Juni 2019, 20:00:17 CEST schrieb Katsuhiro Suzuki:
> This patch adds missing mdio and ethernet PHY nodes for rk3328 ASUS
> tinker board.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

just for my understanding, which problem does this solve?
Normally the gmac can establish connections just fine on
the rk3288 by probing the phy in the automatic way.

And I also don't see any additional properties like phy
interrupt line below.


Thanks
Heiko

> ---
>  arch/arm/boot/dts/rk3288-tinker.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
> index 293576869546..3190817e8d5d 100644
> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> @@ -117,6 +117,7 @@
>  	assigned-clocks = <&cru SCLK_MAC>;
>  	assigned-clock-parents = <&ext_gmac>;
>  	clock_in_out = "input";
> +	phy-handle = <&phy0>;
>  	phy-mode = "rgmii";
>  	phy-supply = <&vcc33_lan>;
>  	pinctrl-names = "default";
> @@ -127,6 +128,17 @@
>  	tx_delay = <0x30>;
>  	rx_delay = <0x10>;
>  	status = "ok";
> +
> +	mdio0 {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +		};
> +	};
>  };
>  
>  &gpu {
> 




