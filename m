Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013E4C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D498227B10
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfFCOo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:44:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34592 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbfFCOoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:44:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 5A81B28A185
Message-ID: <435028daafebcf23425dd5b9338dc3126fac8b89.camel@collabora.com>
Subject: Re: [PATCH] arm64: dts: rockchip: fix isp iommu clocks and power
 domain
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com, laurent.pinchart@ideasonboard.com,
        manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Vicente Bergas <vicencb@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Xie <tony.xie@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Mon, 03 Jun 2019 11:44:43 -0300
In-Reply-To: <20190603142214.24686-1-helen.koike@collabora.com>
References: <20190603142214.24686-1-helen.koike@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-03 at 11:22 -0300, Helen Koike wrote:
> isp iommu requires wrapper variants of the clocks.
> noc variants are always on and using the wrapper variants will activate
> {A,H}CLK_ISP{0,1} due to the hierarchy.
> 
> Also add the respective power domain.
> 
> Refer:
>  RK3399 TRM v1.4 Fig. 2-4 RK3399 Clock Architecture Diagram
>  RK3399 TRM v1.4 Fig. 8-1 RK3399 Power Domain Partition
> 
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> 
> ---
> Hello,
> 
> I tested this using the isp patch set (which is not upstream
> yet). Without this patch, streaming from the isp stalls.
> 
> I'm also enabling the power domain and removing the disable status,
> please let me know if this should be done in a separated patch.
> 

I think you might want to put the comments about enabling power domain
and removing disable status on the commit log. It's useful information :-)

Thanks,
Eze

> Thanks
> Helen
> 
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 196ac9b78076..89594a7276f4 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1706,11 +1706,11 @@
>  		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
>  		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
>  		interrupt-names = "isp0_mmu";
> -		clocks = <&cru ACLK_ISP0_NOC>, <&cru HCLK_ISP0_NOC>;
> +		clocks = <&cru ACLK_ISP0_WRAPPER>, <&cru HCLK_ISP0_WRAPPER>;
>  		clock-names = "aclk", "iface";
>  		#iommu-cells = <0>;
> +		power-domains = <&power RK3399_PD_ISP0>;
>  		rockchip,disable-mmu-reset;
> -		status = "disabled";
>  	};
>  
>  	isp1_mmu: iommu@ff924000 {
> @@ -1718,11 +1718,11 @@
>  		reg = <0x0 0xff924000 0x0 0x100>, <0x0 0xff925000 0x0 0x100>;
>  		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH 0>;
>  		interrupt-names = "isp1_mmu";
> -		clocks = <&cru ACLK_ISP1_NOC>, <&cru HCLK_ISP1_NOC>;
> +		clocks = <&cru ACLK_ISP1_WRAPPER>, <&cru HCLK_ISP1_WRAPPER>;
>  		clock-names = "aclk", "iface";
>  		#iommu-cells = <0>;
> +		power-domains = <&power RK3399_PD_ISP1>;
>  		rockchip,disable-mmu-reset;
> -		status = "disabled";
>  	};
>  
>  	hdmi_sound: hdmi-sound {


