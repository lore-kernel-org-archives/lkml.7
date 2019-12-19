Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CA3C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74902465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782193;
	bh=mdwGBnuNN09dK/4DaloFw1VxEjCxG3vqWGUfeK19Nqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OXnb+GuI4HsQpzY5ReVhCrKbRlr3Xzj6zoQcoVPm7DlK8bNb9KBiym5GEtWNmgRTu
	 p5zHqcKWg6zQJY5RS3pHKgRRrwY3ShmsQLqm3O+8bbu9qQPNFL0lw3wjdoOxKGmDln
	 2QbnUUOeZXPhRIupvjM7Xuh1QPmcN25ErxckSdpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfLSTDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:03:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46639 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbfLSTDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:03:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id c22so8403225otj.13;
        Thu, 19 Dec 2019 11:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MhQmAYSBCNgRDn1V2uwlp2WGL+e8qZb16as3kbVKN44=;
        b=QR3wHZ9MdPTw5A9uZZj2+5bP/lj7FUvMB9XD1wep28XBydyRCR2Mqi8WYB5ooY9PqI
         SizXSKBONRqWdXEUzEfOYZaPscRjkFBX8p46oh1JDPC0vpXKDfinh/RtLtwS3X5GwwS7
         mTDjUwBDD6eLXbL2BWDJ44/GYYnBWnxrMN3lP8LoXqb4Hh0HV+W2M7cEqixbSd7UFB7a
         pesBvv07MJ6z51t9uD+Da5giFiA7d0Q2CSgb2ZeyE92lYm25Un66IjLU1um0EbaMtYTV
         iAzpVCbkloD0chO0ZNbWRwj2+EIpCZ67pg55TL94M4Mo6sWORsV755ru5bQLgX2lA8qf
         mo5g==
X-Gm-Message-State: APjAAAWKJJyoSLGlA7h/tSbX94Lvhh0Qhq4JfFbv76gOEka7/TjPSw32
        cWJaOY+6xZTAX1OtwOwa6g==
X-Google-Smtp-Source: APXvYqzPRgRQaYkhYJ6vOfSj3XTQpQJ9Jab5kKoVr9tHwLwleDoN36tstYW5ESuaYRmCLneN4/unyw==
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr10578983otp.339.1576782188047;
        Thu, 19 Dec 2019 11:03:08 -0800 (PST)
Received: from localhost ([2607:fb90:bdf:98e:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id w12sm2396543otk.75.2019.12.19.11.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 11:03:07 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:03:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     mark.rutland@arm.com, tsahee@annapurnalabs.com,
        antoine.tenart@bootlin.com, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, tglx@linutronix.de,
        khilman@baylibre.com, chanho.min@lge.com, heiko@sntech.de,
        nm@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        barakw@amazon.com
Subject: Re: [PATCH v2 6/6] arm64: dts: amazon: add Amazon's Annapurna Labs
 Alpine v3 support
Message-ID: <20191219190304.GA4786@bogus>
References: <20191209161341.29607-1-hhhawa@amazon.com>
 <20191209161341.29607-7-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209161341.29607-7-hhhawa@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 04:13:41PM +0000, Hanna Hawa wrote:
> From: Ronen Krupnik <ronenk@amazon.com>
> 
> This patch adds the initial support for the Amazon's Annapurna Labs
> Alpine v3 Soc and Evaluation Platform (EVP).
> 
> Signed-off-by: Ronen Krupnik <ronenk@amazon.com>
> ---
>  arch/arm64/boot/dts/amazon/Makefile          |   1 +
>  arch/arm64/boot/dts/amazon/alpine-v3-evp.dts |  23 ++
>  arch/arm64/boot/dts/amazon/alpine-v3.dtsi    | 371 +++++++++++++++++++
>  3 files changed, 395 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3-evp.dts
>  create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amazon/Makefile b/arch/arm64/boot/dts/amazon/Makefile
> index d79822dc30cd..ba9e11544905 100644
> --- a/arch/arm64/boot/dts/amazon/Makefile
> +++ b/arch/arm64/boot/dts/amazon/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  dtb-$(CONFIG_ARCH_ALPINE)	+= alpine-v2-evp.dtb
> +dtb-$(CONFIG_ARCH_ALPINE)	+= alpine-v3-evp.dtb
> diff --git a/arch/arm64/boot/dts/amazon/alpine-v3-evp.dts b/arch/arm64/boot/dts/amazon/alpine-v3-evp.dts
> new file mode 100644
> index 000000000000..8c1e11cf5855
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amazon/alpine-v3-evp.dts
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + */
> +
> +#include "alpine-v3.dtsi"
> +
> +/ {
> +	model = "Amazon's Annapurna Labs Alpine v3 Evaluation Platform (EVP)";
> +	compatible = "amazon,al-alpine-v3-evp", "amazon,al-alpine-v3";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
> new file mode 100644
> index 000000000000..4945087f59e6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019, Amazon.com, Inc. or its affiliates. All Rights Reserved
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	model = "Amazon's Annapurna Labs Alpine v3";
> +	compatible = "amazon,al-alpine-v3";
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;

We only define cache attributes if not discoverable or the cache ID 
registers are wrong and you need to override what's discoverable.

> +			next-level-cache = <&cluster0_l2>;
> +		};
> +
> +		cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster0_l2>;
> +		};
> +
> +		cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x2>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster0_l2>;
> +		};
> +
> +		cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x3>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster0_l2>;
> +		};
> +
> +		cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster1_l2>;
> +		};
> +
> +		cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x101>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster1_l2>;
> +		};
> +
> +		cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x102>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster1_l2>;
> +		};
> +
> +		cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x103>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster1_l2>;
> +		};
> +
> +		cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster2_l2>;
> +		};
> +
> +		cpu@201 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x201>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster2_l2>;
> +		};
> +
> +		cpu@202 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x202>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster2_l2>;
> +		};
> +
> +		cpu@203 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x203>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster2_l2>;
> +		};
> +
> +		cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster3_l2>;
> +		};
> +
> +		cpu@301 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x301>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster3_l2>;
> +		};
> +
> +		cpu@302 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x302>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster3_l2>;
> +		};
> +
> +		cpu@303 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x303>;
> +			enable-method = "psci";
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&cluster3_l2>;
> +		};
> +
> +		cluster0_l2: cache@0 {
> +			compatible = "cache";
> +			cache-size = <0x200000>;
> +			cache-line-size = <64>;
> +			cache-sets = <2048>;
> +			cache-level = <2>;
> +		};
> +
> +		cluster1_l2: cache@100 {
> +			compatible = "cache";
> +			cache-size = <0x200000>;
> +			cache-line-size = <64>;
> +			cache-sets = <2048>;
> +			cache-level = <2>;
> +		};
> +
> +		cluster2_l2: cache@200 {
> +			compatible = "cache";
> +			cache-size = <0x200000>;
> +			cache-line-size = <64>;
> +			cache-sets = <2048>;
> +			cache-level = <2>;
> +		};
> +
> +		cluster3_l2: cache@300 {
> +			compatible = "cache";
> +			cache-size = <0x200000>;
> +			cache-line-size = <64>;
> +			cache-sets = <2048>;
> +			cache-level = <2>;
> +		};
> +
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secmon@0 {
> +			reg = <0x0 0x0 0x0 0x100000>;
> +			no-map;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		interrupt-parent = <&gic>;
> +		ranges;
> +
> +		arch-timer {

Move up a level. There's no mmio regs.

> +			compatible = "arm,armv8-timer";
> +			interrupts = <GIC_PPI 0xd IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_PPI 0xe IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_PPI 0xb IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_PPI 0xa IRQ_TYPE_LEVEL_LOW>;
> +		};
> +
> +		gic: interrupt-controller@f0000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x0 0xf0800000 0 0x10000>,
> +			      <0x0 0xf0a00000 0 0x200000>,
> +			      <0x0 0xf0000000 0 0x2000>,
> +			      <0x0 0xf0010000 0 0x1000>,
> +			      <0x0 0xf0020000 0 0x2000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		msix: msix@fbe00000 {
> +			compatible = "al,alpine-msix";
> +			reg = <0x0 0xfbe00000 0x0 0x100000>;
> +			interrupt-controller;
> +			msi-controller;
> +			al,msi-base-spi = <160>;
> +			al,msi-num-spis = <800>;
> +			interrupt-parent = <&gic>;
> +		};
> +
> +		pmu {
> +			compatible = "arm,cortex-a72-pmu";
> +			interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		uart0: serial@fd883000 {
> +			compatible = "ns16550a";
> +			device_type = "serial";

Drop device_type.

> +			reg = <0x0 0xfd883000 0x0 0x1000>;
> +			clock-frequency = <0>;
> +			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +		};
> +
> +		pci@fbd00000 {

pcie@...

> +			compatible = "pci-host-ecam-generic";
> +			device_type = "pci";
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			#interrupt-cells = <1>;
> +			reg = <0x0 0xfbd00000 0x0 0x100000>;
> +			interrupt-map-mask = <0xf800 0 0 7>;
> +			/* 8 x legacy interrupts for SATA only */
> +			interrupt-map = <0x4000 0 0 1 &gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x4800 0 0 1 &gic 0 58 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x5000 0 0 1 &gic 0 59 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x5800 0 0 1 &gic 0 60 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x6000 0 0 1 &gic 0 61 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x6800 0 0 1 &gic 0 62 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x7000 0 0 1 &gic 0 63 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x7800 0 0 1 &gic 0 64 IRQ_TYPE_LEVEL_HIGH>;
> +			ranges = <0x02000000 0x0 0xfe000000 0x0 0xfe000000 0x0 0x1000000>;
> +			bus-range = <0x00 0x00>;
> +			msi-parent = <&msix>;
> +		};
> +	};
> +};
> -- 
> 2.17.1
> 
