Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58116CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FD421D7F
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572097395;
	bh=MgueLOzk4O1/lxLZq3IymJWKFL5VawUHYQ3qLQlgLHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rjD1jFr1P/Y4LdW17qn67NY49uv0HQAzcVzvgDR4kYVr8RF5PGrn/YboQDUY6ixah
	 WnMpVMcT8iuK27jrWanMjL3Kn0NRu6kKGIJsP4wq3EDk/rT/pM3+FOQGr1UEk1kOC5
	 nZknyMsXM9y8FIm5LU++WzLzNQZFddpR/B0NEvSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfJZNnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfJZNnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:43:10 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F1D720867;
        Sat, 26 Oct 2019 13:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572097389;
        bh=MgueLOzk4O1/lxLZq3IymJWKFL5VawUHYQ3qLQlgLHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnHW0pSoT8+Zn7M8REC6SGCFLOideIS0medhl9AZz5hH/cF7g1leZ5J/n9uKTxKXW
         c6wqJov0kwY0K+zpLxiRDCSEicZiYzri3jG6+WmVDomOUGozldlo1Ykmwu67uIYP0l
         JIudsG03+oi70SteTexGVNJR4ulojO1VWYARnEDg=
Date:   Sat, 26 Oct 2019 21:42:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, leoyang.li@nxp.com, jslaby@suse.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>,
        Dan Nica <dan.nica@nxp.com>,
        Larisa Grigore <Larisa.Grigore@nxp.com>
Subject: Re: [PATCH v7 4/5] arm64: dts: fsl: Add device tree for S32V234-EVB
Message-ID: <20191026134243.GP14401@dragon>
References: <1571230107-8493-1-git-send-email-stefan-gabriel.mirea@nxp.com>
 <1571230107-8493-5-git-send-email-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571230107-8493-5-git-send-email-stefan-gabriel.mirea@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:48:26PM +0300, Stefan-Gabriel Mirea wrote:
> From: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> 
> Add initial version of device tree for S32V234-EVB, including nodes for the
> 4 Cortex-A53 cores, AIPS bus with UART modules, ARM architected timer and
> Generic Interrupt Controller (GIC).
> 
> Keep SoC level separate from board level to let future boards with this SoC
> share common properties, while the dts files will keep board-dependent
> properties.
> 
> Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
> Signed-off-by: Dan Nica <dan.nica@nxp.com>
> Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
> Signed-off-by: Phu Luu An <phu.luuan@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   2 +
>  arch/arm64/boot/dts/freescale/s32v234-evb.dts |  25 ++++
>  arch/arm64/boot/dts/freescale/s32v234.dtsi    | 139 ++++++++++++++++++
>  3 files changed, 166 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/s32v234-evb.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/s32v234.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 93fce8f0c66d..730209adb2bc 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -32,3 +32,5 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
> +
> +dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/s32v234-evb.dts b/arch/arm64/boot/dts/freescale/s32v234-evb.dts
> new file mode 100644
> index 000000000000..4b802518cefc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32v234-evb.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> + * Copyright 2016-2017 NXP
> + */
> +
> +/dts-v1/;
> +#include "s32v234.dtsi"
> +
> +/ {
> +	model = "NXP S32V234-EVB2 Board";
> +	compatible = "fsl,s32v234-evb", "fsl,s32v234";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/s32v234.dtsi b/arch/arm64/boot/dts/freescale/s32v234.dtsi
> new file mode 100644
> index 000000000000..37225191ccbf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32v234.dtsi
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> + * Copyright 2016-2018 NXP
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/memreserve/ 0x80000000 0x00010000;
> +
> +/ {
> +	compatible = "fsl,s32v234";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x0>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x80000000>;
> +			next-level-cache = <&cluster0_l2_cache>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x1>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x80000000>;
> +			next-level-cache = <&cluster0_l2_cache>;
> +		};
> +
> +		cpu2: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x100>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x80000000>;
> +			next-level-cache = <&cluster1_l2_cache>;
> +		};
> +
> +		cpu3: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x101>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x80000000>;
> +			next-level-cache = <&cluster1_l2_cache>;
> +		};
> +
> +		cluster0_l2_cache: l2-cache0 {
> +			compatible = "cache";
> +		};
> +
> +		cluster1_l2_cache: l2-cache1 {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>;
> +		/* clock-frequency might be modified by u-boot, depending on the
> +		 * chip version.
> +		 */
> +		clock-frequency = <10000000>;
> +	};
> +
> +	gic: interrupt-controller@7d001000 {
> +		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> +		#interrupt-cells = <3>;
> +		#address-cells = <0>;
> +		interrupt-controller;
> +		reg = <0 0x7d001000 0 0x1000>,
> +		      <0 0x7d002000 0 0x2000>,
> +		      <0 0x7d004000 0 0x2000>,
> +		      <0 0x7d006000 0 0x2000>;
> +		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
> +					 IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&gic>;
> +		ranges;
> +
> +		aips0: aips-bus@40000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupt-parent = <&gic>;
> +			reg = <0x0 0x40000000 0x0 0x7D000>;

We should consistently use lowercase for hex values in device tree.

I fixed it up during applying.

Shawn

> +			ranges;
> +
> +			uart0: serial@40053000 {
> +				compatible = "fsl,s32v234-linflexuart";
> +				reg = <0x0 0x40053000 0x0 0x1000>;
> +				interrupts = <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		aips1: aips-bus@40080000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupt-parent = <&gic>;
> +			reg = <0x0 0x40080000 0x0 0x70000>;
> +			ranges;
> +
> +			uart1: serial@400bc000 {
> +				compatible = "fsl,s32v234-linflexuart";
> +				reg = <0x0 0x400bc000 0x0 0x1000>;
> +				interrupts = <GIC_SPI 60 IRQ_TYPE_EDGE_RISING>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +};
> -- 
> 2.22.0
> 
