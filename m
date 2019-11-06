Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF58C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD462178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbfKFI2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:28:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:47568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729881AbfKFI2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:28:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0699AF19;
        Wed,  6 Nov 2019 08:28:31 +0000 (UTC)
Subject: Re: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
To:     James Tai <james.tai@realtek.com>
Cc:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
Date:   Wed, 6 Nov 2019 09:28:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thanks for your patch.

$subject: "RTD1619", "Mjolnir". (I can fix up such spelling nits myself
when applying, but there's more change requests below, so please do.)

In theory "Realtek RTD1619" is redundant with "realtek:". Compare recent
patches on linux-realtek-soc or
`git log --oneline -- arch/arm64/boot/dts/realtek/` on linux-next.git.
Not wrong obviously.

Am 05.11.19 um 09:00 schrieb James Tai:
> This patch adds a generic devicetree board file and a dtsi for
> Realtek rtd1619 SoC.

There is no such thing as a "generic devicetree board file"! It is
specific to that one board. If you create a second eval board or when
your ODM customers design their own boards they should only be reusing
the rtd1619.dtsi, as seen with the various rtd1295-*.dts files.

Also, once a patch gets applied to Git, it becomes a commit, so avoid
the term "patch" in the commit message. What about the following:

"Add Device Trees for Realtek RTD1619 SoC family, RTD1619 SoC and
Realtek's Mjolnir evaluation board." (or "This adds ...")

> 
> Signed-off-by: james tai <james.tai@realtek.com>

You've already fixed this from "james.tai", but can you please adjust
your config again to match the regular Western spelling of "James Tai"
in From? Thanks. (In theory UTF-8 would also allow you to add your
Chinese name, like you did in an earlier From, if you wanted to.)

> ---
>  arch/arm64/boot/dts/realtek/Makefile          |  3 +
>  .../boot/dts/realtek/rtd1619-mjolnir.dts      | 31 +++++++
>  arch/arm64/boot/dts/realtek/rtd1619.dtsi      | 91 +++++++++++++++++++
>  arch/arm64/boot/dts/realtek/rtd16xx.dtsi      | 66 ++++++++++++++
>  4 files changed, 191 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1619.dtsi
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd16xx.dtsi
> 
> diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
> index 555638ada721..a58353a1d99a 100644
> --- a/arch/arm64/boot/dts/realtek/Makefile
> +++ b/arch/arm64/boot/dts/realtek/Makefile
> @@ -7,3 +7,6 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-probox2-ava.dtb
>  dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
>  
>  dtb-$(CONFIG_ARCH_REALTEK) += rtd1296-ds418.dtb
> +
> +dtb-$(CONFIG_ARCH_REALTEK) += rtd1619-mjolnir.dtb
> +

Please don't add trailing newlines, here and elsewhere.

> diff --git a/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts b/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
> new file mode 100644
> index 000000000000..def5964c7715
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Copyright (c) 2019 Realtek Semiconductor Corp.
> + */
> +
> +/dts-v1/;
> +
> +#include "rtd1619.dtsi"
> +
> +/ {
> +	compatible = "realtek,rtd1619";

Please run ./scripts/checkpatch.pl before submitting:

You're not allowed to use compatible strings without defining them first
in a separate "dt-bindings: ..." patch, in this case against
Documentation/devicetree/bindings/arm/realtek.yaml.

Please also define a suitable compatible string specific to this board:
"realtek,mjolnir", "realtek,rtd1619"?

So v2 should be a two-patch series with a cover letter please.

> +	model= "Realtek Mjolnir EVB";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +

Trailing newline.

> diff --git a/arch/arm64/boot/dts/realtek/rtd1619.dtsi b/arch/arm64/boot/dts/realtek/rtd1619.dtsi
> new file mode 100644
> index 000000000000..ac5c737b04db
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd1619.dtsi
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Realtek RTD1619 SoC
> + *
> + * Copyright (c) 2019 Realtek Semiconductor Corp.
> + */
> +
> +#include "rtd16xx.dtsi"
> +
> +/ {
> +	compatible = "realtek,rtd1619";
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x000>;

Missing enable-method = "psci"?

> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x100>;

reg value and node unit address need to match, i.e., cpu@100 if that's
the correct value. The label can stay with the intuitive number (cpu1).

> +			enable-method = "psci";
> +			next-level-cache = <&l3>;
> +		};
> +
> +		cpu2: cpu@2 {

Ditto.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			next-level-cache = <&l3>;
> +		};
> +
> +		cpu3: cpu@3 {

Ditto.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			next-level-cache = <&l3>;
> +		};
> +
> +		cpu4: cpu@4 {

Ditto.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x400>;
> +			enable-method = "psci";
> +			next-level-cache = <&l3>;
> +		};
> +
> +		cpu5: cpu@5 {

Ditto.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x500>;
> +			enable-method = "psci";
> +			next-level-cache = <&l3>;
> +		};

Just to be sure: This is one cluster of 6 CPUs? Or is it some 4+2
big.LITTLE, DynamiQ or whatever multi-cluster configuration with
different frequencies, power domains or something?

> +
> +		l2: l2-cache {
> +			compatible = "cache";
> +			next-level-cache = <&l3>;
> +
> +		};
> +
> +		l3: l3-cache {
> +			compatible = "cache";
> +		};

Caches look weird - only cpu0 uses L2 and all others use L3 directly?

> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13
> +			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14
> +			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11
> +			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10
> +			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>;

Generic question also applying to my RTD1295/RTD1195 patches: Are you
sure about GIC_CPU_MASK_RAW(0xf) or could this be GIC_CPU_MASK_SIMPLE(6)
in this case? This here would seem equivalent of GIC_CPU_MASK_SIMPLE(8).

> +	};
> +};
> +
> +&arm_pmu {
> +	interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>,
> +		<&cpu3>, <&cpu4>, <&cpu5>;
> +};

Just to be sure: You expect there to be later rtd16*.dtsi files that
would have a different number of CPUs than 6? Otherwise both the cpus
node and the interrupt-affinity should go into rtd16xx.dtsi and only
diverging things should go here. For RTD1295 this was refactored due to
dual-core RTD1293 vs. quad-core RTD1295/96, so just verifying that
you're not unintentionally copying its design pattern.

> diff --git a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
> new file mode 100644
> index 000000000000..ef56c6ed6663
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Realtek RTD1619 SoC

Hmm, my rtd129x.dtsi has the exact list of SoCs it applies to:
"Realtek RTD1293/RTD1295/RTD1296 SoC"
Copying that pattern here leads to identical description in rtd16xx.dtsi
and rtd1619.dtsi - make that "SoC family" maybe, for distinction?

> + *
> + * Copyright (c) 2019 Realtek Semiconductor Corp.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>

Please swap these for alphabetic ordering, so that the next contributor
can add further #includes in a well-defined place.

> +
> +/{
> +	compatible = "realtek,rtd1619";

Copy&paste? Suggest to drop it here. You still have it in rtd1619.dtsi.

> +	interrupt-parent = <&gic>;
> +	#address-cells = <0x2>;
> +	#size-cells = <0x2>;

Please always use decimal numbers for these two properties.

And double-check whether you actually need <2> - compare rtd129x.dtsi
using <1> because nothing went beyond 32-bit address space. It was a
review request back then. Can RTD1619 have more than 2 GiB RAM, with a
second RAM region in high mem, requiring two cells for memory nodes?

> +
> +	arm_pmu: pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;

Here you use GIC_CPU_MASK_SIMPLE(4) but rtd1619.dtsi with 6 CPUs does
not override it with 6 - are you sure about 4 here?

> +	};
> +
> +	osc27M: osc {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;

Order this property last please - it only affects references to this node.

> +		clock-frequency = <27000000>;
> +		clock-output-names = "osc27M";
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";

Lorenzo, should this be "arm,psci-1.0", "arm,psci-0.2"? The YAML schema
allows either, without documenting which one is preferred for new DTs.

> +		method = "smc";
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;

Please specify the ranges property in a safe way. Compare RTD1295 (which
you can probably copy from?) and my RTD1195 patches. One of the text
files in Documentation/devicetree/ defines the syntax for ranges.

In addition please use #address-cells and #size-cells of 1 here, if
there are no registers beyond 32-bit address space.

> +
> +		uart0: serial0@98007800 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x98007800 0x0 0x400>,
> +				<0x0 0x98007000 0x0 0x100>;

This looks wrong... What is the second reg entry for, have you run "make
dtbs_check"? My pending irqchip driver avoids the need to extend each
and every driver with the region for acknowledging their interrupts.

> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			interrupts = <0 68 4>;

Please use symbolic names for first and last cell.

Is the UART no longer behind an IRQ mux on RTD1619, or is the above the
IRQ mux interrupt as a workaround for lack of in-tree irqchip driver?

> +			clock-frequency = <27000000>;
> +			status = "disabled";
> +		};

My suggestion here would be to refactor as follows:

	rbus: r-bus@98000000 {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x98000000 0x0 rbussize>;

		uart0: serial@7800 {
			compatible = ...
			reg = <0x7800 0x400>;
			...
		};
	};

If we do the same for RTD1295 and RTD1195 as proposed earlier, we would
have neatly comparable register offsets independent of {98,18}000000.

> +
> +		gic: interrupt-controller@ff100000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			interrupt-controller;
> +			redistributor-stride = <0x0 0x20000>;
> +			#redistributor-regions = <1>;
> +			reg = <0x0 0xff100000 0x0 0x10000>,
> +				<0x0 0xff140000 0x0 0x200000>;
> +			interrupts = <GIC_PPI 9 4>;
> +		};

This is really hard to read, please clean up the property order:

reg goes immediately after compatible, so that we have it close to the
node's unit address.

There are no child nodes here or in derived .dts[i] - can we drop
#address-cells, #size-cells and ranges? Otherwise please place them last.

Also please place #interrupt-cells after interrupt-controller - compare
other GICv3 examples for whether they should go after or before
[#]redistributor-*. If we get more such pairs you might use a whiteline
for grouping to aid in reading.

Are you sure you don't have GICC, GICH, GICV and IRQ? No MBI support?

For RTD1295 I extended the GICv2 node during review, and KVM initialized
fine, although I'm not sure whether I've run an actual guest yet, given
how many drivers were missing still.

(I'd also appreciate Realtek to review my RTD1195 patch's GIC [1] for
whether we should have all four regions and some interrupt there - the
OEM's U-Boot doesn't boot in HYP mode, so I can't test myself.)

> +	};
> +};

Thanks,
Andreas

[1] https://patchwork.kernel.org/patch/11221609/

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
