Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB60C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8947F21655
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556304363;
	bh=vbUBuq8Ke3WEk3Qq565Mdwux2WtCV8ZE+bNrPCIj5GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jKEsjphLYidX7I0/nkU0bk2LL9zyDkFdUnRcsKjg9E19UXyb+HvUIaqKmjDXc/rre
	 bPm+KxAKs7YoBpJKOVysoCHxT/+fuB6beTlhBE/p+sVqdyNV3Gk9WlhKUHJGUj01xu
	 +BhFEJQLk128z+PKtz5sEPDClQrMeDw6qyNx4+ZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfDZSqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:46:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33672 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDZSqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:46:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id j10so3547190otq.0;
        Fri, 26 Apr 2019 11:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pEPusRheoqG6L8hFDZ+UpNai2za15r7H5JF7WhwGE5Y=;
        b=e89yjqxLOaqEo5TAss3psn8IL/mYzV5RUDgjJ3BLRpLQc3HUJykv/2PKANhm870dP/
         nPIffEA/n6a/qUfkxb3ZLsNz10QHzHf0ZwZxG1Rfc3DfNU3Tq6hl6iIvGYNBTN+ROXGe
         frfh2QFYDhoZ8/rXkN0eaZYqGUOzFRnx9y8IWO6kk6usN8UQkS9oDhpCkf4J0AlU0vE/
         d1q39aC3ZnssN6MmofJ8Nj8+3CdtS2W+A/5QSVQoX+CyAvAc3XM2+1ak6D42eJEcqLJf
         X1U2sPsOeECnOQ8TpqTpXtrQnzg01ug1po9IS2ZD+G+mkmfOiLFrEVXn4sEAouoIh19f
         wLuA==
X-Gm-Message-State: APjAAAVX5PBkiaPh7oNJhij9PDPSHkh04d959rAw26hoAXqHN5ejGWJe
        n8ASDys44SNMI1+WBtpxyQ==
X-Google-Smtp-Source: APXvYqzzyZ6deOywfEMtSX0sji3SN3TApLJhNC2zk1n2ENmAnHUeVNtTigzhvxrFey+mOYmGQ+PuEw==
X-Received: by 2002:a05:6830:2090:: with SMTP id y16mr13359330otq.97.1556304360935;
        Fri, 26 Apr 2019 11:46:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o66sm11050999oig.11.2019.04.26.11.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 11:45:59 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:45:59 -0500
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
Subject: Re: [PATCH v4 5/5] arm64: dts: rockchip: Enable dmc and dfi nodes on
 gru.
Message-ID: <20190426184559.GA29242@bogus>
References: <20190415212948.7736-1-gael.portay@collabora.com>
 <20190415212948.7736-6-gael.portay@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190415212948.7736-6-gael.portay@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:29:48PM -0400, Gaël PORTAY wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> Enable the DMC (Dynamic Memory Controller) and the DFI (DDR PHY
> Interface) nodes on gru boards so we can support DDR DVFS.
> 
> The patch also introduces a new file with default DRAM settings.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> ---
> 
> Changes in v4:
> - [PATCH v3 5/5] Add board related DDR settings (moved from 4/5).
> 
> Changes in v3:
> - [PATCH v2 5/5] Remove display_subsystem nodes.
> 
> Changes in v2:
> - [PATCH 8/8] Move center-supply attribute of dmc node in file
>               rk3399-gru-chromebook.dtsi (where ppvar_centerlogic is
> 	      defined).
> 
> Changes in v1: None
> 
>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  4 +
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 46 ++++++++++++
>  .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 29 ++++++++
>  include/dt-bindings/power/rk3399-dram.h       | 73 +++++++++++++++++++
>  4 files changed, 152 insertions(+)
>  create mode 100644 include/dt-bindings/power/rk3399-dram.h
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> index 931640e9aed4..cfb81356c61e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> @@ -400,3 +400,7 @@ ap_i2c_tp: &i2c5 {
>  		rockchip,pins = <0 8 RK_FUNC_GPIO &pcfg_pull_none>;
>  	};
>  };
> +
> +&dmc {
> +	center-supply = <&ppvar_centerlogic>;
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> index da03fa9c5662..40e78186560b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/power/rk3399-dram.h>
>  #include "rk3399.dtsi"
>  #include "rk3399-op1-opp.dtsi"
>  
> @@ -289,6 +290,12 @@
>  	status = "okay";
>  };
>  
> +&dmc_opp_table {
> +	opp04 {
> +		opp-suspend;
> +	};
> +};
> +
>  /*
>   * Set some suspend operating points to avoid OVP in suspend
>   *
> @@ -489,6 +496,45 @@ ap_i2c_audio: &i2c8 {
>  	status = "okay";
>  };
>  
> +&dfi {
> +	status = "okay";
> +};
> +
> +&dmc {
> +	status = "okay";
> +	upthreshold = <25>;
> +	downdifferential = <15>;
> +	rockchip,ddr3_speed_bin = <21>;
> +	rockchip,pd_idle = <0x40>;
> +	rockchip,sr_idle = <0x2>;
> +	rockchip,sr_mc_gate_idle = <0x3>;
> +	rockchip,srpd_lite_idle	= <0x4>;
> +	rockchip,standby_idle = <0x2000>;
> +	rockchip,dram_dll_dis_freq = <300000000>;
> +	rockchip,phy_dll_dis_freq = <125000000>;
> +	rockchip,auto_pd_dis_freq = <666000000>;
> +	rockchip,ddr3_odt_dis_freq = <333000000>;
> +	rockchip,ddr3_drv = <DDR3_DS_40ohm>;
> +	rockchip,ddr3_odt = <DDR3_ODT_120ohm>;
> +	rockchip,phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
> +	rockchip,phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
> +	rockchip,phy_ddr3_odt = <PHY_DRV_ODT_240>;
> +	rockchip,lpddr3_odt_dis_freq = <333000000>;
> +	rockchip,lpddr3_drv = <LP3_DS_34ohm>;
> +	rockchip,lpddr3_odt = <LP3_ODT_240ohm>;
> +	rockchip,phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
> +	rockchip,phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
> +	rockchip,phy_lpddr3_odt = <PHY_DRV_ODT_240>;
> +	rockchip,lpddr4_odt_dis_freq = <333000000>;
> +	rockchip,lpddr4_drv = <LP4_PDDS_60ohm>;
> +	rockchip,lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
> +	rockchip,lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
> +	rockchip,phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
> +	rockchip,phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
> +	rockchip,phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
> +	rockchip,phy_lpddr4_odt = <PHY_DRV_ODT_60>;
> +};
> +
>  &sdhci {
>  	/*
>  	 * Signal integrity isn't great at 200 MHz and 150 MHz (DDR) gives the
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
> diff --git a/include/dt-bindings/power/rk3399-dram.h b/include/dt-bindings/power/rk3399-dram.h
> new file mode 100644
> index 000000000000..4b3d4a79923b
> --- /dev/null
> +++ b/include/dt-bindings/power/rk3399-dram.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR X11) */
> +/*
> + * Copyright (c) 2016-2018, Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * Author: Lin Huang <hl@rock-chips.com>
> + */
> +
> +#ifndef _DTS_DRAM_ROCKCHIP_RK3399_H
> +#define _DTS_DRAM_ROCKCHIP_RK3399_H
> +
> +#define DDR3_DS_34ohm		34
> +#define DDR3_DS_40ohm		40
> +
> +#define DDR3_ODT_DIS		0
> +#define DDR3_ODT_40ohm		40
> +#define DDR3_ODT_60ohm		60
> +#define DDR3_ODT_120ohm		120

I don't think these defines add much value given the value is in the 
define itself.

Do these get used by the driver? If not, then the header can go with the 
dts file. But I'd just get rid of the header.

Rob
