Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3751BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A2323A51
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lR82yWXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfFCOsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:48:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39992 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbfFCOsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:48:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id g69so7083424plb.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q+sHhqSxZbf8keZOMlJSAWpHXVIafP73qkF/eQ1kaEg=;
        b=lR82yWXUpVnRwrloRqpoNOP0h28pmhl9RZJEKQG+xRMq6tXSFYRiAwRkNwerYbaYyT
         mCi4aJWaTlcYDT14orBv5IHGGmzerqXKyNMQDvzQh39isZbQ6oJ36LC8BqeT7yuWXG7f
         8fyALfgl4w1zSntEm7DRrtKCXvWYtPCRFqSaTSkKeosOkigvtxwR+TDZi1YKPZXgzHsh
         RVsXsNR+bFFsTarRQfzzr2fbY4nHoHS8WlZfhuvLyQbEWhiscP0/0NcM1yQBh+W/xEdT
         abcq/hXaFiugkbBaSCcBFR11OfjpYAF4OGmksbpcxHMyqtCA9vbtDRDVQp6zr9w3Y1Fu
         jWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+sHhqSxZbf8keZOMlJSAWpHXVIafP73qkF/eQ1kaEg=;
        b=Nihy634E8k5RhoJYVnPPO8GuHSgSIJHkrhPjmTx2cY0uEtFGpGm88z9KEzBlqiyY5c
         VYg7TANUi92L7iIziaojbenb1ZeN8Lb3BsPIAJnrxq4Kd+lzoO6bPuvA/dLnG684Y4Pn
         oxTK2ys1DPZ0j5pWiC5vnKKrc17CbfnxjJXx2Bz+CVrQ1QeOZroK9VF8GdE25sAFBJya
         UeNOWHXsGf4TOc3gOFBd768tgCzZBu7kKAuPE3uit5IWYxN9D8XsnjbGADaQmxCzfNAC
         PbAPZ9+kawqDW6A+95Ie8FOgMZlpkSxLGjtapqJGBHUJ25fjYsD+73OYfHA+sPNiYDsb
         X9JA==
X-Gm-Message-State: APjAAAXZ8MKZtWbkwOB+mhZm8oLkWtIpxQB9JfChAlMVBAUyp7ldQpHD
        DA+qNtF9yvYLneaSwJ+K782fDizXcg==
X-Google-Smtp-Source: APXvYqzDCE7HSjzkN8v18+gy/2oC+6Z+r7kTihM1KnbA2Ry1zX6rsvrfzvO37yYwBVRz4RQQxawIEA==
X-Received: by 2002:a17:902:a982:: with SMTP id bh2mr29907129plb.224.1559573329403;
        Mon, 03 Jun 2019 07:48:49 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id z125sm18266392pfb.75.2019.06.03.07.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 07:48:48 -0700 (PDT)
Date:   Mon, 3 Jun 2019 20:18:38 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, kernel@collabora.com,
        ezequiel@collabora.com, laurent.pinchart@ideasonboard.com,
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
Subject: Re: [PATCH] arm64: dts: rockchip: fix isp iommu clocks and power
 domain
Message-ID: <20190603144838.GA27534@mani>
References: <20190603142214.24686-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603142214.24686-1-helen.koike@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 11:22:15AM -0300, Helen Koike wrote:
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

Tested on Rock960 with ISP patches.

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

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
> -- 
> 2.20.1
> 
