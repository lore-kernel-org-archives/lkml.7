Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA10C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF7E20644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfHPMZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:25:47 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60144 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfHPMYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:24:42 -0400
Received: from [88.128.80.55] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hybHM-0000UE-Ke; Fri, 16 Aug 2019 14:24:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Kever Yang <kever.yang@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomohiro Mayama <parly-gh@iris.mystia.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm: dts: rockchip: fix vcc_host_5v regulator for usb3 host
Date:   Fri, 16 Aug 2019 14:24:06 +0200
Message-ID: <2932927.UJgUFA1Pmh@phil>
In-Reply-To: <20190815081252.27405-1-kever.yang@rock-chips.com>
References: <20190815081252.27405-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kever, TL,

[added TL Lim for clarification]

Am Donnerstag, 15. August 2019, 10:12:52 CEST schrieb Kever Yang:
> According to rock64 schemetic V2 and V3, the VCC_HOST_5V output is
> controlled by USB_20_HOST_DRV, which is the same as VCC_HOST1_5V.

The v1 schematics I have do reference the GPIO0_A0 as controlling this
supply, so the big question would be how to handle the different versions.

Because adding this would probably break v1 boards in this function.

@TL: where v1 boards also sold or were they only used during development?
If this were the case, we could just apply the patch, not caring about
v1 boards, but if v1 boards were also sold to customers there would be
more of a problem.

Thanks
Heiko


> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v2:
> - remove enable-active-high property
> 
>  arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> index 7cfd5ca6cc85..62936b432f9a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> @@ -34,10 +34,9 @@
>  
>  	vcc_host_5v: vcc-host-5v-regulator {
>  		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
> +		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
>  		pinctrl-names = "default";
> -		pinctrl-0 = <&usb30_host_drv>;
> +		pinctrl-0 = <&usb20_host_drv>;
>  		regulator-name = "vcc_host_5v";
>  		regulator-always-on;
>  		regulator-boot-on;
> @@ -320,12 +319,6 @@
>  			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  	};
> -
> -	usb3 {
> -		usb30_host_drv: usb30-host-drv {
> -			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
>  };
>  
>  &sdmmc {
> 




