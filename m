Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14401C43141
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 15:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E834C206CC
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 15:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfKQPlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 10:41:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:34108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbfKQPlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 10:41:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77297ACA5;
        Sun, 17 Nov 2019 15:41:00 +0000 (UTC)
Subject: Re: [PATCH v3 3/8] ARM: dts: Prepare Realtek RTD1195 and MeLE X1000
To:     Marc Zyngier <maz@misterjones.org>
Cc:     linux-realtek-soc@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        James Tai <james.tai@realtek.com>
References: <20191117072109.20402-1-afaerber@suse.de>
 <20191117072109.20402-4-afaerber@suse.de> <20191117104726.2b1fccb8@why>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <61bf74ad-b4a1-f443-bf99-be354b4d942b@suse.de>
Date:   Sun, 17 Nov 2019 16:40:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191117104726.2b1fccb8@why>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Am 17.11.19 um 11:47 schrieb Marc Zyngier:
> On Sun, 17 Nov 2019 08:21:04 +0100
> Andreas Färber <afaerber@suse.de> wrote:
>> Add Device Trees for Realtek RTD1195 SoC and MeLE X1000 TV box.
>>
>> Reuse the existing RTD1295 watchdog compatible for now.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> [AF: Fixed r-bus size, fixed GIC CPU mask, updated memreserve]
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>  v2 -> v3:
>>  * Fixed r-bus size in /soc ranges from 0x1000000 to 0x70000 (James)
>>  * Adjusted /memreserve/ to close gap from 0xa800 to 0xc000 for full 0x100000
>>  * Changed arch timer from GIC_CPU_MASK_RAW(0xf) to GIC_CPU_MASK_SIMPLE(2)
>>    squashed from RTD1395 v1 series
>>  
>>  v1 -> v2:
>>  * Dropped /memreserve/ and reserved-memory nodes for peripherals and NOR (Rob)
>>  * Carved them out from memory reg instead (Rob)
>>  * Converted some /memreserve/s to reserved-memory nodes
>>  
>>  arch/arm/boot/dts/Makefile               |   2 +
>>  arch/arm/boot/dts/rtd1195-mele-x1000.dts |  31 ++++++++
>>  arch/arm/boot/dts/rtd1195.dtsi           | 127 +++++++++++++++++++++++++++++++
>>  3 files changed, 160 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/rtd1195-mele-x1000.dts
>>  create mode 100644 arch/arm/boot/dts/rtd1195.dtsi
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 08011dc8c7a6..4853a13c8cf2 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -865,6 +865,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>>  dtb-$(CONFIG_ARCH_RDA) += \
>>  	rda8810pl-orangepi-2g-iot.dtb \
>>  	rda8810pl-orangepi-i96.dtb
>> +dtb-$(CONFIG_ARCH_REALTEK) += \
>> +	rtd1195-mele-x1000.dtb
>>  dtb-$(CONFIG_ARCH_REALVIEW) += \
>>  	arm-realview-pb1176.dtb \
>>  	arm-realview-pb11mp.dtb \
>> diff --git a/arch/arm/boot/dts/rtd1195-mele-x1000.dts b/arch/arm/boot/dts/rtd1195-mele-x1000.dts
>> new file mode 100644
>> index 000000000000..834b430e6250
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/rtd1195-mele-x1000.dts
>> @@ -0,0 +1,31 @@
>> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>> +/*
>> + * Copyright (c) 2017-2019 Andreas Färber
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "rtd1195.dtsi"
>> +
>> +/ {
>> +	compatible = "mele,x1000", "realtek,rtd1195";
>> +	model = "MeLE X1000";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	memory@0 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x18000000>,
>> +		      <0x19100000 0x26f00000>;
>> +	};
>> +};
>> +
>> +&uart0 {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
>> new file mode 100644
>> index 000000000000..4e3866fe8f6e
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/rtd1195.dtsi
>> @@ -0,0 +1,127 @@
>> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>> +/*
>> + * Copyright (c) 2017-2019 Andreas Färber
>> + */
>> +
>> +/memreserve/ 0x00000000 0x0000a800; /* boot code */
>> +/memreserve/ 0x0000a800 0x000f5800;
>> +/memreserve/ 0x17fff000 0x00001000;
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +	compatible = "realtek,rtd1195";
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		cpu0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg = <0x0>;
>> +			clock-frequency = <1000000000>;
>> +		};
>> +
>> +		cpu1: cpu@1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg = <0x1>;
>> +			clock-frequency = <1000000000>;
>> +		};
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +
>> +		rpc_comm: rpc@b000 {
>> +			reg = <0x0000b000 0x1000>;
>> +		};
>> +
>> +		audio@1b00000 {
>> +			reg = <0x01b00000 0x400000>;
>> +		};
>> +
>> +		rpc_ringbuf: rpc@1ffe000 {
>> +			reg = <0x01ffe000 0x4000>;
>> +		};
>> +
>> +		secure@10000000 {
>> +			reg = <0x10000000 0x100000>;
>> +			no-map;
>> +		};
>> +	};
>> +
>> +	arm-pmu {
>> +		compatible = "arm,cortex-a7-pmu";
>> +		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-affinity = <&cpu0>, <&cpu1>;
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv7-timer";
>> +		interrupts = <GIC_PPI 13
>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14
>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11
>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10
>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
>> +		clock-frequency = <27000000>;
> 
> This is 2019, and yet it feels like 2011. This should be setup in the
> bootloader, not in DT...

What exactly - the whole node, the GIC CPU mask, the clock-frequency?

Please compare previous submissions: It's a v2012.07 based downstream
U-Boot that I don't have GPL sources of. It doesn't even fill in the
/memory@0 node.

>> +	};
>> +
>> +	osc27M: osc {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <27000000>;
>> +		#clock-cells = <0>;
>> +		clock-output-names = "osc27M";
>> +	};
>> +
>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x18000000 0x18000000 0x00070000>,
>> +		         <0x18100000 0x18100000 0x01000000>,
>> +		         <0x40000000 0x40000000 0xc0000000>;
>> +
>> +		wdt: watchdog@18007680 {
>> +			compatible = "realtek,rtd1295-watchdog";
>> +			reg = <0x18007680 0x100>;
>> +			clocks = <&osc27M>;
>> +		};
>> +
>> +		uart0: serial@18007800 {
>> +			compatible = "snps,dw-apb-uart";
>> +			reg = <0x18007800 0x400>;
>> +			reg-shift = <2>;
>> +			reg-io-width = <4>;
>> +			clock-frequency = <27000000>;
>> +			status = "disabled";
>> +		};
>> +
>> +		uart1: serial@1801b200 {
>> +			compatible = "snps,dw-apb-uart";
>> +			reg = <0x1801b200 0x100>;
>> +			reg-shift = <2>;
>> +			reg-io-width = <4>;
>> +			clock-frequency = <27000000>;
>> +			status = "disabled";
>> +		};
>> +
>> +		gic: interrupt-controller@ff011000 {
>> +			compatible = "arm,cortex-a7-gic";
>> +			reg = <0xff011000 0x1000>,
>> +			      <0xff012000 0x2000>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
> 
> You know what I'm going to say: GICH and GI[C]V are missing, as well as
> the maintenance interrupt. This is all bog-standard HW (most probably a
> GIC400), so there is no reason for this information not to be present.

Yes, and if you look at my rtd1295-next branch referenced in the cover
letter, you will find that I do have follow-up patches adding GICH and
GICV, also a guess for the GICV interrupt, and in a different patch [1]
I have specifically reminded Realtek to review the v2 of this patch
please, which still hasn't happened yet...

I inquired for the RTD1619 patch, and James replied that for its GICv3
they supposedly do _not_ have the optional GICH and GICV [1].

Thus I am waiting on their input for whether they have it on RTD1195.
The U-Boot that I have on this device does not boot the kernel in HYP
mode, so I cannot test KVM myself. Same issue on the Horseradish EVB.

On the Buffalo LinkStation LS520 I still don't have a serial console
(probably my bad soldering skills), but I doubt it's any different.

Regards,
Andreas

[1] https://patchwork.kernel.org/patch/11227113/

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
