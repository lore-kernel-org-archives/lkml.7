Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3190FC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C4E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556229621;
	bh=mLSfOLHdA+9HCzwiSNTIsNhISiPs5vOjRPKB6VEpF2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DxWQVXc5nKb5dFavJ5yAYXi9sSfFJd0I3zg89ZzfLO11TNBTC0XFHT77mgfQ9OK68
	 C3eU+njTO0xqVwaYSDXEtZP/LnvTKPvIwmtcZKHK/WEPImFBn60cWC3sxaLcNEqIMN
	 ivCSGPJdn83j/pYxfxiCXJDDXjfAko5dN8grXxK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbfDYWAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:00:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34540 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbfDYWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 18:00:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id u17so952773otj.1;
        Thu, 25 Apr 2019 15:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=whXKt4Pab5nmF5Mk6pUKSZ8aWVNzgM6bKw4nLSkqCv0=;
        b=HdADnwkNIhj4VQL8S4m6xlF3AfrBdX8o4cWELIrtepPJMmRkq9tnWEGKRvQk99xEbk
         lrX9T6O5rCnPcp0nn9R8VO8FxetsRu2i5ZApHphsUE1d3n3ATOLXhI/gxbE80HULUlW7
         rqYY2ec8RCIhsgFIR+Ea5qQ7jw3r0JW5lfOB3ECARTKXgbM4/1h+eZlRjISG8dMQzutz
         xibox0XQkotDUQO7Qn97gvE56nBAUOdr9znuMilTKdouzJ3O9GIoURRQUHihKkaoUzUU
         TtSHrGxggRI2bPMJeyZGsriLTl40dop/zw2tRjWdGFgmYka8dYmVzNUe9Ygd/ufOSues
         tJyg==
X-Gm-Message-State: APjAAAUsROWnVJS7tri01YG24/Sxaq/dc+Vqbw/TUj3Vx89uLm9mNKR/
        h7oBd+cF/2GlLAq7NbRLEw==
X-Google-Smtp-Source: APXvYqyLRCB8Rg5MB86d3r5nWASw/Rrc8qjUWvL6B7NO5ZcIK/Q1TzNnddkNXY1mXN4RzsTF61kPlw==
X-Received: by 2002:a9d:7f0b:: with SMTP id j11mr15588589otq.132.1556229618103;
        Thu, 25 Apr 2019 15:00:18 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u198sm10173424oie.26.2019.04.25.15.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 15:00:17 -0700 (PDT)
Date:   Thu, 25 Apr 2019 17:00:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liuyu712@hisilicon.com, wanghu17@hisilicon.com,
        butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v6 13/13] dts: hi3660: Add support for usb on Hikey960
Message-ID: <20190425220016.GC32028@bogus>
References: <20190420064019.57522-1-chenyu56@huawei.com>
 <20190420064019.57522-14-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420064019.57522-14-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 02:40:19PM +0800, Yu Chen wrote:
> This patch adds support for usb on Hikey960.
> 
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
> v2:
> * Remove device_type property.
> * Add property "usb-role-switch".
> v3:
> * Make node "usb_phy" a subnode of usb3_otg_bc register.
> * Remove property "typec-vbus-enable-val" of hisi_hikey_usb.
> v4:
> * Remove property "hisilicon,usb3-otg-bc-syscon" of usb-phy.
> ---
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 53 ++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 73 +++++++++++++++++++++++
>  2 files changed, 126 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index e035cf195b19..d4e11c56b250 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/usb/pd.h>
>  
>  / {
>  	model = "HiKey960";
> @@ -196,6 +197,26 @@
>  			method = "smc";
>  		};
>  	};
> +
> +	hisi_hikey_usb: hisi_hikey_usb {
> +		compatible = "hisilicon,hikey960_usb";
> +		typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
> +		otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
> +		hub-vdd33-en-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbhub5734_pmx_func>;
> +
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			hikey_usb_ep: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&dwc3_role_switch_notify>;
> +			};
> +		};
> +	};
> +
>  };
>  
>  /*
> @@ -526,6 +547,38 @@
>  &i2c1 {
>  	status = "okay";
>  
> +	rt1711h: rt1711h@4e {
> +		compatible = "richtek,rt1711h";

The binding doc for this should state it should have a 'connector' node.

> +		reg = <0x4e>;
> +		status = "ok";

Can drop this, it is the default.

> +		interrupt-parent = <&gpio27>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_cfg_func>;
> +
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			data-role = "dual";
> +			power-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
> +				PDO_VAR(5000, 5000, 1000)>;
> +			op-sink-microwatt = <10000000>;
> +		};
> +
> +		port {

The connector node should have a 'ports' child with 'port@0' being the 
HS connection.

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			rt1711h_ep: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&dwc3_role_switch>;
> +			};
> +		};
> +	};
> +
>  	adv7533: adv7533@39 {
>  		status = "ok";
>  		compatible = "adi,adv7533";
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 2f19e0e5b7cf..173467505ada 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -355,6 +355,12 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		pmctrl: pmctrl@fff31000 {
> +			compatible = "hisilicon,hi3660-pmctrl", "syscon";
> +			reg = <0x0 0xfff31000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		pmuctrl: crg_ctrl@fff34000 {
>  			compatible = "hisilicon,hi3660-pmuctrl", "syscon";
>  			reg = <0x0 0xfff34000 0x0 0x1000>;
> @@ -1134,5 +1140,72 @@
>  				};
>  			};
>  		};
> +
> +		usb3_otg_bc: usb3_otg_bc@ff200000 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x0 0xff200000 0x0 0x1000>;
> +
> +			usb_phy: usb-phy {
> +				compatible = "hisilicon,hi3660-usb-phy";
> +				#phy-cells = <0>;
> +				hisilicon,pericrg-syscon = <&crg_ctrl>;
> +				hisilicon,pctrl-syscon = <&pctrl>;
> +				hisilicon,eye-diagram-param = <0x22466e4>;
> +			};
> +		};
> +
> +		usb3: hisi_dwc3 {
> +			compatible = "hisilicon,hi3660-dwc3";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;

If there are not any wrapper registers, then get rid of the hisi_dwc3 
node. For just clocks and resets we just put everything in one node.

> +
> +			clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
> +				 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +			clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
> +
> +			assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +			assigned-clock-rates = <229000000>;
> +			resets = <&crg_rst 0x90 8>,
> +				 <&crg_rst 0x90 7>,
> +				 <&crg_rst 0x90 6>,
> +				 <&crg_rst 0x90 5>;
> +
> +			dwc3: dwc3@ff100000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0xff100000 0x0 0x100000>;
> +				interrupts = <0 159 4>, <0 161 4>;
> +				phys = <&usb_phy>;
> +				phy-names = "usb3-phy";
> +				dr_mode = "otg";
> +				maximum-speed = "super-speed";
> +				phy_type = "utmi";
> +				snps,dis-del-phy-power-chg-quirk;

> +				snps,lfps_filter_quirk;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_u3_susphy_quirk;
> +				snps,tx_de_emphasis_quirk;
> +				snps,tx_de_emphasis = <1>;
> +				snps,dis_enblslpm_quirk;

Pretty sure these aren't documented because we don't use '_' in property 
names.

> +				snps,gctl-reset-quirk;
> +				usb-role-switch;
> +				role-switch-default-host;
> +
> +				port {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					dwc3_role_switch: endpoint@0 {
> +						reg = <0>;
> +						remote-endpoint = <&rt1711h_ep>;
> +					};
> +
> +					dwc3_role_switch_notify: endpoint@1 {
> +						reg = <1>;
> +						remote-endpoint = <&hikey_usb_ep>;
> +					};
> +				};
> +			};
> +		};
>  	};
>  };
> -- 
> 2.15.0-rc2
> 
