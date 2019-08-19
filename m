Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9EFC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD572086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfHSLmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:42:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19357 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727162AbfHSLmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:42:43 -0400
X-UUID: 78854bbad6e24d41ab462ed88e4bbb24-20190819
X-UUID: 78854bbad6e24d41ab462ed88e4bbb24-20190819
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 685104548; Mon, 19 Aug 2019 19:42:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 19 Aug 2019 19:42:36 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 19 Aug 2019 19:42:30 +0800
Message-ID: <1566214950.17081.3.camel@mtkswgap22>
Subject: Re: [PATCH v2 11/11] arm64: dts: add dts nodes for MT6779
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, CC Hwang <cc.hwang@mediatek.com>,
        <wsd_upstream@mediatek.com>, Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        mtk01761 <wendell.lin@mediatek.com>, <linux-clk@vger.kernel.org>
Date:   Mon, 19 Aug 2019 19:42:30 +0800
In-Reply-To: <adec38bf-735b-9131-2b9d-1e427d47f88d@kernel.org>
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com>
         <1566206502-4347-12-git-send-email-mars.cheng@mediatek.com>
         <adec38bf-735b-9131-2b9d-1e427d47f88d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

On Mon, 2019-08-19 at 10:40 +0100, Marc Zyngier wrote:
> On 19/08/2019 10:21, Mars Cheng wrote:
> > this adds initial MT6779 dts settings fo board support,
> > including cpu, gic, timer, ccf, pinctrl, uart...etc.
> > 
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/Makefile        |    1 +
> >  arch/arm64/boot/dts/mediatek/mt6779-evb.dtsi |   31 ++++
> >  arch/arm64/boot/dts/mediatek/mt6779.dts      |  229 ++++++++++++++++++++++++++
> >  3 files changed, 261 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt6779-evb.dtsi
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt6779.dts
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> > index 458bbc4..53f1c61 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6779-evb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
> > diff --git a/arch/arm64/boot/dts/mediatek/mt6779-evb.dtsi b/arch/arm64/boot/dts/mediatek/mt6779-evb.dtsi
> > new file mode 100644
> > index 0000000..164f5cb
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt6779-evb.dtsi
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2019 MediaTek Inc.
> > + * Author: Mars.C <mars.cheng@mediatek.com>
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +#include "mt6779.dtsi"
> > +
> > +/ {
> > +	model = "MediaTek MT6779 EVB";
> > +	compatible = "mediatek,mt6779-evb", "mediatek,mt6779";
> > +
> > +	aliases {
> > +		serial0 = &uart0;
> > +	};
> > +
> > +	memory@40000000 {
> > +		device_type = "memory";
> > +		reg = <0 0x40000000 0 0x1e800000>;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:921600n8";
> > +	};
> > +};
> > +
> > +&uart0 {
> > +	status = "okay";
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dts b/arch/arm64/boot/dts/mediatek/mt6779.dts
> > new file mode 100644
> > index 0000000..daa25b7
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt6779.dts
> > @@ -0,0 +1,229 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2019 MediaTek Inc.
> > + * Author: Mars.C <mars.cheng@mediatek.com>
> > + *
> > + */
> > +
> > +#include <dt-bindings/clock/mt6779-clk.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +	compatible = "mediatek,mt6779";
> > +	interrupt-parent = <&sysirq>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	psci {
> > +		compatible = "arm,psci-0.2";
> > +		method = "smc";
> > +	};
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu0: cpu@0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a55";
> > +			enable-method = "psci";
> > +			reg = <0x000>;
> > +		};
> > +
> > +		cpu1: cpu@1 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a55";
> > +			enable-method = "psci";
> > +			reg = <0x100>;
> > +		};
> > +
> > +		cpu2: cpu@2 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a55";
> > +			enable-method = "psci";
> > +			reg = <0x200>;
> > +		};
> > +
> > +		cpu3: cpu@3 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a55";
> > +			enable-method = "psci";
> > +			reg = <0x300>;
> > +		};
> > +
> > +		cpu4: cpu@4 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a55";
> > +			enable-method = "psci";
> > +			reg = <0x400>;
> > +		};
> > +
> > +		cpu5: cpu@5 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a55";
> > +			enable-method = "psci";
> > +			reg = <0x500>;
> > +		};
> > +
> > +		cpu6: cpu@6 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a75";
> > +			enable-method = "psci";
> > +			reg = <0x600>;
> > +		};
> > +
> > +		cpu7: cpu@7 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a75";
> > +			enable-method = "psci";
> > +			reg = <0x700>;
> > +		};
> > +	};
> > +
> > +	clk26m: oscillator@0 {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <26000000>;
> > +		clock-output-names = "clk26m";
> > +	};
> > +
> > +	clk32k: oscillator@1 {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <32768>;
> > +		clock-output-names = "clk32k";
> > +	};
> > +
> > +	uart_clk: dummy26m {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <26000000>;
> > +		#clock-cells = <0>;
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +
> > +	soc {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		compatible = "simple-bus";
> > +		ranges;
> > +
> > +		gic: interrupt-controller@0c000000 {
> > +			compatible = "arm,gic-v3";
> > +			#interrupt-cells = <3>;
> 
> You also haven't described the CPU PMUs. Depending on how they are wired
> (SPIs or PPIs), you may have to change the interrupt-cells property to
> include a cell for the PPI partitioning.
> 

pmu nodes would be:

        pmu {
                compatible = "arm,armv8-pmuv3";
                interrupt-parent = <&gic>;
                interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
        };

        dsu-pmu-0 {
                compatible = "arm,dsu-pmu";
                interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
                cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
                        <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
        };

so I think interrupt-cells could be <3>, will add pmu nodes in v3.

> 
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			#redistributor-regions = <1>;
> 
> This is the default, so this can be omitted.
> 

Got it, will remove it in v3.

> > +			interrupt-parent = <&gic>;
> > +			interrupt-controller;
> > +			reg = <0 0x0c000000 0 0x40000>,  /* GICD */
> > +			      <0 0x0c040000 0 0x200000>, /* GICR */
> > +			      <0 0x0c400000 0 0x2000>,   /* GICC */
> > +			      <0 0x0c410000 0 0x1000>,   /* GICH */
> > +			      <0 0x0c420000 0 0x2000>;   /* GICV */
> 
> Where do the last 3 ranges come from? Neither Cortex-A55 nor A75 have
> the memory-mapped CPU interface. It looks like a copy/paste from another
> SoC...
> 

My bad, should remove the last 3 interfaces. will do in v3.

> > +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +		};
> 
> And no ITS?
> 

No, we don't have ITS support in HW.

Thanks.

> 	M.


