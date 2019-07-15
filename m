Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207C5C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E005F216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfGOI34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:29:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38133 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726996AbfGOI3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:29:55 -0400
X-UUID: d54c6dae50ea4a50bbddc41a32716f0f-20190715
X-UUID: d54c6dae50ea4a50bbddc41a32716f0f-20190715
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 693575974; Mon, 15 Jul 2019 16:29:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 15 Jul 2019 16:29:49 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 15 Jul 2019 16:29:49 +0800
Message-ID: <1563179389.31375.2.camel@mtksdaap41>
Subject: Re: [PATCH v6 7/8] arm64: dts: mediatek: add mt6765 support
From:   CK Hu <ck.hu@mediatek.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Sean Wang" <sean.wang@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        "Owen Chen" <owen.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        CC Hwang <cc.hwang@mediatek.com>, <wsd_upstream@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Date:   Mon, 15 Jul 2019 16:29:49 +0800
In-Reply-To: <1562924653-10056-8-git-send-email-macpaul.lin@mediatek.com>
References: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
         <1562924653-10056-8-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Macpaul:

On Fri, 2019-07-12 at 17:43 +0800, Macpaul Lin wrote:
> From: Mars Cheng <mars.cheng@mediatek.com>
> 
> Add basic chip support for Mediatek 6765, include
> uart node with correct uart clocks, pwrap device
> 
> Add clock controller nodes, include topckgen, infracfg,
> apmixedsys and subsystem.
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |  33 +++
>  arch/arm64/boot/dts/mediatek/mt6765.dtsi    | 253 ++++++++++++++++++++
>  3 files changed, 287 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 458bbc422a94..22bdf1a99a62 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6765-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt6765-evb.dts b/arch/arm64/boot/dts/mediatek/mt6765-evb.dts
> new file mode 100644
> index 000000000000..36dddff2b7f8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6765-evb.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for Mediatek MT6765
> + *
> + * (C) Copyright 2018. Mediatek, Inc.
> + *
> + * Mars Cheng <mars.cheng@mediatek.com>
> + */
> +
> +/dts-v1/;
> +#include "mt6765.dtsi"
> +
> +/ {
> +	model = "MediaTek MT6765 EVB";
> +	compatible = "mediatek,mt6765-evb", "mediatek,mt6765";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x1e800000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt6765.dtsi b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
> new file mode 100644
> index 000000000000..2662470fe607
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for Mediatek MT6765
> + *
> + * (C) Copyright 2018. Mediatek, Inc.
> + *
> + * Mars Cheng <mars.cheng@mediatek.com>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/mt6765-clk.h>
> +
> +/ {
> +	compatible = "mediatek,mt6765";
> +	interrupt-parent = <&sysirq>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x000>;
> +		};
> +
> +		cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x001>;
> +		};
> +
> +		cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x002>;
> +		};
> +
> +		cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x003>;
> +		};
> +
> +		cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x100>;
> +		};
> +
> +		cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x101>;
> +		};
> +
> +		cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x102>;
> +		};
> +
> +		cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x103>;
> +		};
> +	};
> +
> +	clocks {
> +		clk26m: clk26m {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <26000000>;
> +		};
> +
> +		clk32k: clk32k {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32000>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x40000>,  /* GICD */
> +			      <0 0x0c100000 0 0x200000>, /* GICR */
> +			      <0 0x0c400000 0 0x2000>,   /* GICC */
> +			      <0 0x0c410000 0 0x2000>,   /* GICH */
> +			      <0 0x0c420000 0 0x20000>;  /* GICV */
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		topckgen: syscon@10000000 {
> +			compatible = "mediatek,mt6765-topckgen", "syscon";
> +			reg = <0 0x10000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		infracfg: syscon@10001000 {
> +			compatible = "mediatek,mt6765-infracfg", "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +			interrupts = <GIC_SPI 147 IRQ_TYPE_EDGE_RISING>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pericfg: pericfg@10003000 {
> +			compatible = "mediatek,mt6765-pericfg", "syscon";
> +			reg = <0 0x10003000 0 0x1000>;
> +		};
> +
> +		scpsys: scpsys@10006000 {
> +			compatible = "mediatek,mt6765-scpsys";
> +			reg =	<0 0x10006000 0 0x1000>; /* spm */
> +			#power-domain-cells = <1>;
> +			clocks = <&topckgen CLK_TOP_MFG_SEL>,
> +				 <&topckgen CLK_TOP_MM_SEL>,
> +				 <&mmsys_config CLK_MM_SMI_COMMON>,
> +				 <&mmsys_config CLK_MM_SMI_COMM0>,
> +				 <&mmsys_config CLK_MM_SMI_COMM1>,
> +				 <&mmsys_config CLK_MM_SMI_LARB0>,

I think you should remove subsys clock in scpsys device node. I've
discussed in [1].

[1] https://patchwork.kernel.org/patch/11005731/

Regards,
CK

> +				 <&imgsys CLK_IMG_LARB2>,
> +				 <&mmsys_config CLK_MM_SMI_IMG>,
> +				 <&camsys CLK_CAM_LARB3>,
> +				 <&camsys CLK_CAM_DFP_VAD>,
> +				 <&camsys CLK_CAM>,
> +				 <&camsys CLK_CAM_CCU>,
> +				 <&mmsys_config CLK_MM_SMI_CAM>;
> +			clock-names = "mfg", "mm",
> +				      "mm-0", "mm-1", "mm-2", "mm-3",
> +				      "isp-0", "isp-1", "cam-0", "cam-1",
> +				      "cam-2", "cam-3", "cam-4";
> +			infracfg = <&infracfg>;
> +			smi_comm = <&smi_common>;
> +		};
> +
> +		apmixed: syscon@1000c000 {
> +			compatible = "mediatek,mt6765-apmixedsys", "syscon";
> +			reg = <0 0x1000c000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		sysirq: interrupt-controller@10200a80 {
> +			compatible = "mediatek,mt6765-sysirq",
> +				     "mediatek,mt6577-sysirq";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			reg = <0 0x10200a80 0 0x50>;
> +		};
> +
> +		uart0: serial@11002000 {
> +			compatible = "mediatek,mt6765-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11002000 0 0x400>;
> +			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_IFR_UART0>,
> +				 <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@11003000 {
> +			compatible = "mediatek,mt6765-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11003000 0 0x400>;
> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_IFR_UART1>,
> +				 <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		audio: syscon@11220000 {
> +			compatible = "mediatek,mt6765-audsys", "syscon";
> +			reg = <0 0x11220000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		mipi_rx_ana_csi0a: syscon@11c10000 {
> +			compatible = "mediatek,mt6765-mipi0a",
> +				     "syscon";
> +			reg = <0 0x11c10000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		mmsys_config: syscon@14000000 {
> +			compatible = "mediatek,mt6765-mmsys", "syscon";
> +			reg = <0 0x14000000 0 0x1000>;
> +			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_LOW>;
> +			#clock-cells = <1>;
> +		};
> +
> +		smi_common: smi_common@14002000 {
> +			compatible = "mediatek,mt6765-smi-common", "syscon";
> +			reg = <0 0x14002000 0 0x1000>;
> +		};
> +
> +		imgsys: syscon@15020000 {
> +			compatible = "mediatek,mt6765-imgsys", "syscon";
> +			reg = <0 0x15020000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		venc_gcon: syscon@17000000 {
> +			compatible = "mediatek,mt6765-vcodecsys", "syscon";
> +			reg = <0 0x17000000 0 0x10000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys: syscon@1a000000  {
> +			compatible = "mediatek,mt6765-camsys", "syscon";
> +			reg = <0 0x1a000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +	}; /* end of soc */
> +};


