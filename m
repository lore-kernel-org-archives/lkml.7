Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEEDC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D574208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfFNJPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:15:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37664 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfFNJPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:15:40 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbiJ0-00040c-GM; Fri, 14 Jun 2019 11:15:30 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: add display nodes for rk322x
Date:   Fri, 14 Jun 2019 11:15:29 +0200
Message-ID: <1854794.0zkvb3x0FP@phil>
In-Reply-To: <20190613101305.30491-1-justin.swartz@risingedge.co.za>
References: <20190613101305.30491-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

Am Donnerstag, 13. Juni 2019, 12:13:04 CEST schrieb Justin Swartz:
> Add display_subsystem, hdmi_phy, vop, and hdmi device nodes plus
> a few hdmi pinctrl entries to allow for HDMI output.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Overall looks good, but in combination with the clock-patch you posted,
I'd really prefer if we could try a slightly different approach.

Hard register-level settings in the clock driver look bad and tend to
cause problems later on, so I've adapted things a bit in [0] (untested)
and would be glad if you could give it a try on actual hardware.

The hdmiphy itself is a clock-provider for its pll and therefore the
assigned-clock* properties into the hdmi controller, as the phy needs
to probe before trying to set clocks.
But in theory this should achieve the same result of reparenting the
system's hdmiphy clock to the actual output of the phy-pll.

I've also moved the iommu-cells fix to a separate commit.

Please test, thanks
Heiko


[0] https://github.com/mmind/linux-rockchip/commits/wip/rk3229-hdmi

> ---
>  arch/arm/boot/dts/rk322x.dtsi | 83 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
> index da102fff96a2..7eb883eec126 100644
> --- a/arch/arm/boot/dts/rk322x.dtsi
> +++ b/arch/arm/boot/dts/rk322x.dtsi
> @@ -143,6 +143,11 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	display_subsystem: display-subsystem {
> +		compatible = "rockchip,display-subsystem";
> +		ports = <&vop_out>;
> +	};
> +
>  	i2s1: i2s1@100b0000 {
>  		compatible = "rockchip,rk3228-i2s", "rockchip,rk3066-i2s";
>  		reg = <0x100b0000 0x4000>;
> @@ -529,6 +534,17 @@
>  		status = "disabled";
>  	};
>  
> +	hdmi_phy: hdmi-phy@12030000 {
> +		compatible = "rockchip,rk3228-hdmi-phy";
> +		reg = <0x12030000 0x10000>;
> +		clocks = <&cru PCLK_HDMI_PHY>, <&xin24m>, <&cru DCLK_HDMI_PHY>;
> +		clock-names = "sysclk", "refoclk", "refpclk";
> +		#clock-cells = <0>;
> +		clock-output-names = "hdmiphy_phy";
> +		#phy-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	gpu: gpu@20000000 {
>  		compatible = "rockchip,rk3228-mali", "arm,mali-400";
>  		reg = <0x20000000 0x10000>;
> @@ -572,6 +588,28 @@
>  		status = "disabled";
>  	};
>  
> +	vop: vop@20050000 {
> +		compatible = "rockchip,rk3228-vop";
> +		reg = <0x20050000 0x1ffc>;
> +		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru ACLK_VOP>, <&cru DCLK_VOP>, <&cru HCLK_VOP>;
> +		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
> +		resets = <&cru SRST_VOP_A>, <&cru SRST_VOP_H>, <&cru SRST_VOP_D>;
> +		reset-names = "axi", "ahb", "dclk";
> +		iommus = <&vop_mmu>;
> +		status = "disabled";
> +
> +		vop_out: port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			vop_out_hdmi: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&hdmi_in_vop>;
> +			};
> +		};
> +	};
> +
>  	vop_mmu: iommu@20053f00 {
>  		compatible = "rockchip,iommu";
>  		reg = <0x20053f00 0x100>;
> @@ -579,7 +617,7 @@
>  		interrupt-names = "vop_mmu";
>  		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
>  		clock-names = "aclk", "iface";
> -		iommu-cells = <0>;
> +		#iommu-cells = <0>;
>  		status = "disabled";
>  	};
>  
> @@ -594,6 +632,34 @@
>  		status = "disabled";
>  	};
>  
> +	hdmi: hdmi@200a0000 {
> +		compatible = "rockchip,rk3228-dw-hdmi";
> +		reg = <0x200a0000 0x20000>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_HDMI_HDCP>, <&cru PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_CEC>;
> +		clock-names = "isfr", "iahb", "cec";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hdmii2c_xfer &hdmi_hpd &hdmi_cec>;
> +		resets = <&cru SRST_HDMI_P>;
> +		reset-names = "hdmi";
> +		phys = <&hdmi_phy>;
> +		phy-names = "hdmi";
> +		rockchip,grf = <&grf>;
> +		status = "disabled";
> +
> +		ports {
> +			hdmi_in: port {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				hdmi_in_vop: endpoint@0 {
> +					reg = <0>;
> +					remote-endpoint = <&vop_out_hdmi>;
> +				};
> +			};
> +		};
> +	};
> +
>  	sdmmc: dwmmc@30000000 {
>  		compatible = "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc";
>  		reg = <0x30000000 0x4000>;
> @@ -922,6 +988,21 @@
>  			};
>  		};
>  
> +		hdmi {
> +			hdmi_hpd: hdmi-hpd {
> +				rockchip,pins = <0 RK_PB7 1 &pcfg_pull_down>;
> +			};
> +
> +			hdmii2c_xfer: hdmii2c-xfer {
> +				rockchip,pins = <0 RK_PA6 2 &pcfg_pull_none>,
> +						<0 RK_PA7 2 &pcfg_pull_none>;
> +			};
> +
> +			hdmi_cec: hdmi-cec {
> +				rockchip,pins = <0 RK_PC4 1 &pcfg_pull_none>;
> +			};
> +		};
> +
>  		i2c0 {
>  			i2c0_xfer: i2c0-xfer {
>  				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_none>,
> 




