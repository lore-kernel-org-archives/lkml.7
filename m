Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D9FCA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60F7208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572363694;
	bh=zJ9d0oZSKvLH7iX1279EYwNb/W7MknlP636Z/bgwz8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ThGm0MZgZzGQXconpRF5qVhCWUtoqD+Wwe470mcMWPrfh6v3UwBpTPDVSoQn8apP+
	 n9FjQf3JipfcfRKKlDNZsWVAsDl84PRFW91b8YN9eIJicB2kolBXDwVdgVGmqkO4LO
	 HugKGv+NQQu8Kjkl21YKfzXOZvoKw04ZDAMC18+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390238AbfJ2Pld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:41:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32990 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389902AbfJ2Plc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:41:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id u13so10163377ote.0;
        Tue, 29 Oct 2019 08:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OHLvLlXrag/JA6RAkIqRYUSQXoFYYhUDny1cDZ8jNlQ=;
        b=G1IfkvfhpkvDxqqD5Ewn9O+zdMBwC9xHT4eB3BmGvotr0N4N0Tb9/leKW1d2GQpw98
         2bQ+lH1n7HqNj35isOCUsg7gaqu171rVDpR6P4QPyMd6xjtvpATIV4GN84mVrOVi42hK
         WXBCBd6jycNGaxvbdhLNWP+/0g+A/5nVSygHYuPsIsU0E+YJj1iWGZvIUmSBoKoaIElx
         Qr2NnAtvH0yR1s1JHxrDJF+ZeR6k8MTvIwq4SA6Zd8CnkoderqXdZDoXuaiDABKG+jYb
         p1S03nvYKm4XnWD63F2MEkFEVkYddbH0ELWvVpoUuxjricbBshmZS3UBRVbY1cPdkT4z
         Tj0A==
X-Gm-Message-State: APjAAAVakvDOyjIU87m5MW06Ckkz+xieEvz11suOhAsjwKmnCIF9fl8g
        V2ZkRGGLP4k8yEl5d1Phh4hyc0A=
X-Google-Smtp-Source: APXvYqy0HhJ0eXhiweKh9beQteHFwjrHTp2X8Dy89c2YQdesRt6wL8/hTZbSuT92uBRELtlQEAag3w==
X-Received: by 2002:a9d:538d:: with SMTP id w13mr18279045otg.184.1572363691096;
        Tue, 29 Oct 2019 08:41:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p184sm4096067oia.11.2019.10.29.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 08:41:29 -0700 (PDT)
Date:   Tue, 29 Oct 2019 10:41:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: Prepare Realtek RTD1195 and MeLE X1000
Message-ID: <20191029154129.GA24908@bogus>
References: <20191021021035.7032-1-afaerber@suse.de>
 <20191021021035.7032-4-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021021035.7032-4-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:10:35AM +0200, Andreas Färber wrote:
> Add Device Trees for Realtek RTD1195 SoC and MeLE X1000 TV box.
> 
> Reuse the existing RTD1295 watchdog compatible for now.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  arch/arm/boot/dts/Makefile               |   2 +
>  arch/arm/boot/dts/rtd1195-mele-x1000.dts |  30 ++++++++
>  arch/arm/boot/dts/rtd1195.dtsi           | 128 +++++++++++++++++++++++++++++++
>  3 files changed, 160 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rtd1195-mele-x1000.dts
>  create mode 100644 arch/arm/boot/dts/rtd1195.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 73d33611c372..89a951485da8 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -858,6 +858,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  dtb-$(CONFIG_ARCH_RDA) += \
>  	rda8810pl-orangepi-2g-iot.dtb \
>  	rda8810pl-orangepi-i96.dtb
> +dtb-$(CONFIG_ARCH_REALTEK) += \
> +	rtd1195-mele-x1000.dtb
>  dtb-$(CONFIG_ARCH_REALVIEW) += \
>  	arm-realview-pb1176.dtb \
>  	arm-realview-pb11mp.dtb \
> diff --git a/arch/arm/boot/dts/rtd1195-mele-x1000.dts b/arch/arm/boot/dts/rtd1195-mele-x1000.dts
> new file mode 100644
> index 000000000000..ce9a255950d3
> --- /dev/null
> +++ b/arch/arm/boot/dts/rtd1195-mele-x1000.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Copyright (c) 2017 Andreas Färber

2019?

> + */
> +
> +/dts-v1/;
> +
> +#include "rtd1195.dtsi"
> +
> +/ {
> +	compatible = "mele,x1000", "realtek,rtd1195";
> +	model = "MeLE X1000";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {

memory@0

> +		device_type = "memory";
> +		reg = <0x0 0x40000000>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
> new file mode 100644
> index 000000000000..475740c67d26
> --- /dev/null
> +++ b/arch/arm/boot/dts/rtd1195.dtsi
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Copyright (c) 2017 Andreas Färber
> + */
> +
> +/memreserve/ 0x00000000 0x0000c000; /* boot code */
> +/memreserve/ 0x0000c000 0x000f4000;
> +/memreserve/ 0x01b00000 0x00400000; /* audio */
> +/memreserve/ 0x01ffe000 0x00004000; /* rpc ringbuf */
> +/memreserve/ 0x10000000 0x00100000; /* secure */
> +/memreserve/ 0x17fff000 0x00001000;
> +/memreserve/ 0x18000000 0x00100000; /* rbus */
> +/memreserve/ 0x18100000 0x01000000; /* nor */

You shouldn't have the same entries here and in /reserved-memory. There 
was a time before /reserved-memory was fully supported, but we should be 
well past that now.

> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "realtek,rtd1195";
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
> +			compatible = "arm,cortex-a7";
> +			reg = <0x0>;
> +			clock-frequency = <1000000000>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x1>;
> +			clock-frequency = <1000000000>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		secure@10000000 {
> +			reg = <0x10000000 0x100000>;
> +			no-map;
> +		};
> +
> +		rbus@18000000 {
> +			reg = <0x18000000 0x100000>;
> +			no-map;

This doesn't look right as it overlaps the register space. 

> +		};
> +
> +		nor@18100000 {
> +			reg = <0x18100000 0x1000000>;
> +			no-map;
> +		};
> +	};
> +
> +	arm-pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupts = <GIC_PPI 13
> +			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14
> +			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11
> +			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10
> +			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <27000000>;
> +	};
> +
> +	osc27M: osc {
> +		compatible = "fixed-clock";
> +		clock-frequency = <27000000>;
> +		#clock-cells = <0>;
> +		clock-output-names = "osc27M";
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		wdt: watchdog@18007680 {
> +			compatible = "realtek,rtd1295-watchdog";
> +			reg = <0x18007680 0x100>;
> +			clocks = <&osc27M>;
> +		};
> +
> +		uart0: serial@18007800 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x18007800 0x400>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <27000000>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@1801b200 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x1801b200 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <27000000>;
> +			status = "disabled";
> +		};
> +
> +		gic: interrupt-controller@ff011000 {
> +			compatible = "arm,cortex-a7-gic";
> +			reg = <0xff011000 0x1000>,
> +			      <0xff012000 0x2000>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +		};
> +	};
> +};
> -- 
> 2.16.4
> 
