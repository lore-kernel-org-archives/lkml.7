Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BITCOIN_SPAM_02,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE9BC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F300F2464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfLEK6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:58:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:50434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728735AbfLEK6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:58:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC6C0ADDF;
        Thu,  5 Dec 2019 10:58:27 +0000 (UTC)
Subject: Re: [PATCH 2/2] arm64: dts: realtek: Add RTD1319 SoC and Realtek
 PymParticle EVB
To:     James Tai <james.tai@realtek.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20191205082555.22633-1-james.tai@realtek.com>
 <20191205082555.22633-3-james.tai@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <4040ffcf-5c54-fb44-b0a8-ce0c8c21b93f@suse.de>
Date:   Thu, 5 Dec 2019 11:58:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191205082555.22633-3-james.tai@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

+ Robin for PMU
+ Lorenzo for PSCI

Am 05.12.19 um 09:25 schrieb James Tai:
> Add Device Trees for Realtek RTD1319 SoC family, RTD1319 SoC and
> Realtek PymParticle EVB.
> 
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
>  arch/arm64/boot/dts/realtek/Makefile          |   2 +
>  .../boot/dts/realtek/rtd1319-pymparticle.dts  |  43 ++++++
>  arch/arm64/boot/dts/realtek/rtd1319.dtsi      |  12 ++
>  arch/arm64/boot/dts/realtek/rtd13xx.dtsi      | 137 ++++++++++++++++++
>  4 files changed, 194 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1319.dtsi
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd13xx.dtsi
> 
> diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
> index fb5f05978ecc..ab00c272ea9e 100644
> --- a/arch/arm64/boot/dts/realtek/Makefile
> +++ b/arch/arm64/boot/dts/realtek/Makefile
> @@ -9,3 +9,5 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
>  dtb-$(CONFIG_ARCH_REALTEK) += rtd1296-ds418.dtb
>  
>  dtb-$(CONFIG_ARCH_REALTEK) += rtd1619-mjolnir.dtb
> +
> +dtb-$(CONFIG_ARCH_REALTEK) += rtd1319-pymparticle.dtb

This hunk is lacking rtd1395, so is not based on the latest patches I
posted. I expect you to be developing against linux-next.git tree, and
when there's relevant in-flight patches, you'll need to either apply my
patches via git-am to your tree, or for convenience you can use the
beginning of my (but better not the full experimental) rtd1295-next
branch (git-rebase -i, or (careful!) git-reset --hard). Yes, neither is
super-easy.

Same as with the binding, it would seem better to not add this at the
end, even if it's your newest family. Consider this: Someone finds an
RTD1036 in their household and wants to contribute a patch - where would
they add it? I don't want all newly added stuff to go into the bottom of
the file (then it'll be hard to find and potentially causes conflicts),
so we need a stable sort order where I don't need to do historical
research of whether 1036 is newer or older than 1195/1296 to determine
where to insert it in a file. Alphanumerical sort order seems simplest
to understand and is proven elsewhere to reduce merge conflicts.

> diff --git a/arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts b/arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts
> new file mode 100644
> index 000000000000..d8bfe2304b71
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Copyright (c) 2019 Realtek Semiconductor Corp.
> + */
> +
> +/dts-v1/;
> +
> +#include "rtd1319.dtsi"
> +
> +/ {
> +	compatible = "realtek,pymparticle", "realtek,rtd1319";

Thanks, correct order now.

> +	model = "Realtek PymParticle EVB";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000>;
> +	};

No! I understood RTD1319 has the same boot ROM size 184 KiB as RTD1619,
so please look at the patches I posted, including fix for RTD1619 [1],
and fix this yourself here. A comment for humans would also be nice.

In the public BPI-M4-bsp code I see one -pymparticle-1GB.CMAx2.dts file.
If this board is available with less than 2 GiB RAM then please use the
lower value to be safe - you can run a 2 GiB board with 1 GiB RAM used,
but using more RAM than available will break.

[1] https://patchwork.kernel.org/patch/11268969/

> +
> +	chosen {
> +		stdout-path = "serial0:460800n8";
> +	};
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +	};
> +};
> +
> +/* debug console (J1) */
> +&uart0 {
> +	status = "okay";
> +};
> +
> +/* M.2 slot (CON8) */
> +&uart1 {
> +	status = "disabled";
> +};
> +
> +/* GPIO connector (T1) */
> +&uart2 {
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/realtek/rtd1319.dtsi b/arch/arm64/boot/dts/realtek/rtd1319.dtsi
> new file mode 100644
> index 000000000000..1dcee00009cd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd1319.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Realtek RTD1319 SoC
> + *
> + * Copyright (c) 2019 Realtek Semiconductor Corp.
> + */
> +
> +#include "rtd13xx.dtsi"
> +
> +/ {
> +	compatible = "realtek,rtd1319";
> +};

What other contents are you expecting to add in this file?

> diff --git a/arch/arm64/boot/dts/realtek/rtd13xx.dtsi b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
> new file mode 100644
> index 000000000000..92bf962377f6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Realtek RTD13xx SoC family
> + *
> + * Copyright (c) 2019 Realtek Semiconductor Corp.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		l2: l2-cache {
> +			compatible = "cache";
> +		};

I note this seems a different cache topology than RTD1619?

> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	arm_pmu: pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>,
> +			<&cpu3>;
> +	};

@Robin, is this single PPI interrupt better than previous single SPI?

Is "arm,armv8-pmuv3" the correct one to use for Cortex-A55? There's no
"arm,cortex-a55-pmu" binding - is that still in the works?

> +
> +	psci {
> +		compatible = "arm,psci-1.0";

@Lorenzo: Same question as left unanswered for RTD1619:
Should this be "arm,psci-1.0", "arm-psci-0.2"?

The YAML schema allows both, without clearly documenting which one shall
be used in new DTs, and there's no psci-1.0 example either.

> +		method = "smc";
> +	};
> +
> +	osc27M: osc {
> +		compatible = "fixed-clock";
> +		clock-frequency = <27000000>;
> +		clock-output-names = "osc27M";

BTW I recall seeing "osc27m" in your clk patchset. We should decide on
one name and stick with it consistently, and I think it's best to have
this as a node here in .dtsi (or in .dts), in case OEMs ever choose to
have it generated by some other non-trivial IC.

> +		#clock-cells = <0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x98000000 0x98000000 0x68000000>;

No! Lacking a range for boot ROM. And your range is probably too large
due to high RAM. Please see [1] and fix for both. r-bus ranges below
would indicate that above soc range should be 0x00200000 long only, plus
extra ranges for whatever besides r-bus is shadowing RAM (e.g., GIC).

> +
> +		rbus: bus@98000000 {
> +			compatible = "simple-bus";
> +			reg = <0x98000000 0x200000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x98000000 0x200000>;

Thanks for incorporating r-bus right away.

> +
> +			uart0: serial0@7800 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x7800 0x400>;
> +				reg-shift = <2>;
> +				reg-io-width = <4>;
> +				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-frequency = <432000000>;
> +				status = "disabled";
> +			};
> +
> +			uart1: serial1@1b200 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x1b200 0x400>;
> +				reg-shift = <2>;
> +				reg-io-width = <4>;
> +				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-frequency = <432000000>;
> +				status = "disabled";
> +			};
> +
> +			uart2: serial2@1b400 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x1b400 0x400>;
> +				reg-shift = <2>;
> +				reg-io-width = <4>;
> +				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-frequency = <432000000>;
> +				status = "disabled";
> +			};

Here you appear to ignore my patches introducing syscon for ISO & MISC!

See https://patchwork.kernel.org/cover/11269453/

> +		};
> +
> +		gic: interrupt-controller@ff100000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0xff100000 0x10000>,
> +			      <0xff140000 0xc0000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +		};
> +	};
> +};

Please review patches that have been posted to the list, and incorporate
such fixes and refactorings into any new patches. If you disagree with
my patchsets, then you need to reply to them! If my numbers and naming
are correct on the other hand, you and your colleagues are encouraged to
respond to patches with an Acked-by, or Reviewed-by if you've reviewed
the full patch, and/or Tested-by if you've tested it on some board
(usually with comment on where/what you did). As long as no compatible
strings get introduced, it is within my discretion to apply DT patches
to linux-realtek.git if no review comments arrive asking for changes, so
you can safely assume that I'll apply my own non-RFC patches otherwise.
Not responding to patches and silently subverting them is not the way to
go. linux-realtek-soc is still fairly small in volume compared to LAKML,
so that I do expect contributors to at least skim patch subjects and
cover letters for any conflicting/relevant work before posting patches.
Don't expect maintainers to apply a v1 patch and to fix it up for you.

For Acked-by vs. Reviewed-by, compare this and the next section:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

If you want to post patches that you know are not yet ready for merging,
you can use --subject-prefix="RFC", like I did for the SoC info series.
The cover letter should explain the main discussion points then.

Thanks in advance,

Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
