Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC536C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950C420651
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553795996;
	bh=6NhbgDeyZNF5Jh7OXiUinn8gnFfirZwcpEcpgxjwAnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w4WDWLxhrOD/hssYZfM3wYnKLQHztgOFbB7gHpUYTVJ00sh6FKsQj/r42PshPkdOt
	 K2hEniSkTbD+yMv+Ss4ZeFUoXif9DKKUm/XSUpL7D3QRJq1X2jWL6V0TjVWB9HwJ8g
	 ydGjUaQcpM77qSOIim2GzXiVcIgnoT93LqGdEnP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfC1R7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:59:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34686 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfC1R7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:59:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id k21so17835763otf.1;
        Thu, 28 Mar 2019 10:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xQNxxs+ysHE81A+umKaN1DTeFmXockFMUA8sFOkGQXk=;
        b=EmM1Gpjnh/CnI3BA+RtcaYWBYjjBUYtReVXt9FGWTmFvT4qyhKJY4Zfke6e2MgLsuB
         cHUNoH3F35hailkwmG4UYgwB406GX47t44GOn9loTIWbtPR+ZSPL9jc04elpDRq956lH
         xhxzzB3lyhL6O3ZFcO4pyKJv/YNEr7/pAHs5af4GrQzNiwaOAtqKHbz75TKGtbFr3VlE
         yUHHYD2FTO1uNxFV0nS/UXRfvn5WCB1Z7zbUaghc0yFz5+PVpo6lg+hG5omHYa0w7QQT
         FfuAKiJ59ewoD7Oym+WTk5nR3AVnrRyfLvxDtUYYE19L+rEXNRWA3jgFm+v62YS8pw66
         H4Dw==
X-Gm-Message-State: APjAAAXTKkMbK4IA0XiGGrHV0eIutLlckzk7DHQ/daoTCbSHv333GXy9
        tRfsPNVG+zakjpvVFqRdXg==
X-Google-Smtp-Source: APXvYqyNENE2uY0GfQsNQEmHQC1ktS+ZgeKveDp6C9wUadQjf1gOsBXctsR4zYau+o+lSa+TPEDvPA==
X-Received: by 2002:a9d:6393:: with SMTP id w19mr27941797otk.257.1553795993863;
        Thu, 28 Mar 2019 10:59:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r67sm10236656oib.18.2019.03.28.10.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:59:52 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:59:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Ga=EBl?= PORTAY <gael.portay@collabora.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Derek Basehore <dbasehore@chromium.org>,
        Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 4/5] arm64: dts: rk3399: Add dfi and dmc nodes.
Message-ID: <20190328175952.GA21288@bogus>
References: <20190321231440.19031-1-gael.portay@collabora.com>
 <20190321231440.19031-5-gael.portay@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190321231440.19031-5-gael.portay@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 07:14:39PM -0400, Gaël PORTAY wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> These are required to support DDR DVFS on rk3399 platform. The patch also
> introduces a new file with default DRAM settings.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> ---
> 
> Changes in v3: None
> 
> Changes in v2:
> - [PATCH 7/8] Reword the commit message to reflect the removal of
>               rk3390-dram-default-timing.dts in v1.
> 
> Changes in v1:
> - [RFC 8/10] Move rk3399-dram.h to dt-includes.
> - [RFC 8/10] Put sdram default values under the dmc node.
> - [RFC 8/10] Removed rk3399-dram-default-timing.dts
> 
>  .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 29 ++++++++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 49 +++++++++++++
>  include/dt-bindings/power/rk3399-dram.h       | 73 +++++++++++++++++++
>  3 files changed, 151 insertions(+)
>  create mode 100644 include/dt-bindings/power/rk3399-dram.h
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> index 69cc9b05baa5..c9e7032b01a8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> @@ -110,6 +110,31 @@
>  			opp-microvolt = <1075000>;
>  		};
>  	};
> +
> +	dmc_opp_table: dmc_opp_table {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <666000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <928000000>;
> +			opp-microvolt = <900000>;
> +		};
> +	};
>  };
>  
>  &cpu_l0 {
> @@ -139,3 +164,7 @@
>  &gpu {
>  	operating-points-v2 = <&gpu_opp_table>;
>  };
> +
> +&dmc {
> +	operating-points-v2 = <&dmc_opp_table>;
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index db9d948c0b03..8fe86a3e7658 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/power/rk3399-dram.h>
>  #include <dt-bindings/power/rk3399-power.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
> @@ -1885,6 +1886,54 @@
>  		status = "disabled";
>  	};
>  
> +	dfi: dfi@ff630000 {
> +		reg = <0x00 0xff630000 0x00 0x4000>;
> +		compatible = "rockchip,rk3399-dfi";
> +		rockchip,pmu = <&pmugrf>;
> +		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru PCLK_DDR_MON>;
> +		clock-names = "pclk_ddr_mon";
> +		status = "disabled";
> +	};
> +
> +	dmc: dmc {
> +		compatible = "rockchip,rk3399-dmc";
> +		rockchip,pmu = <&pmugrf>;
> +		devfreq-events = <&dfi>;
> +		clocks = <&cru SCLK_DDRC>;
> +		clock-names = "dmc_clk";
> +		status = "disabled";
> +		rockchip,ddr3_speed_bin = <21>;
> +		rockchip,pd_idle = <0x40>;
> +		rockchip,sr_idle = <0x2>;
> +		rockchip,sr_mc_gate_idle = <0x3>;
> +		rockchip,srpd_lite_idle	= <0x4>;
> +		rockchip,standby_idle = <0x2000>;
> +		rockchip,dram_dll_dis_freq = <300000000>;
> +		rockchip,phy_dll_dis_freq = <125000000>;
> +		rockchip,auto_pd_dis_freq = <666000000>;
> +		rockchip,ddr3_odt_dis_freq = <333000000>;
> +		rockchip,ddr3_drv = <DDR3_DS_40ohm>;
> +		rockchip,ddr3_odt = <DDR3_ODT_120ohm>;
> +		rockchip,phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_ddr3_odt = <PHY_DRV_ODT_240>;
> +		rockchip,lpddr3_odt_dis_freq = <333000000>;
> +		rockchip,lpddr3_drv = <LP3_DS_34ohm>;
> +		rockchip,lpddr3_odt = <LP3_ODT_240ohm>;
> +		rockchip,phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_lpddr3_odt = <PHY_DRV_ODT_240>;
> +		rockchip,lpddr4_odt_dis_freq = <333000000>;
> +		rockchip,lpddr4_drv = <LP4_PDDS_60ohm>;
> +		rockchip,lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
> +		rockchip,lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
> +		rockchip,phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
> +		rockchip,phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
> +		rockchip,phy_lpddr4_odt = <PHY_DRV_ODT_60>;

These settings aren't board specific?

Rob
