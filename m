Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE03C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC3820833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfLBIPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:15:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:53812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbfLBIPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:15:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3D59AE3C;
        Mon,  2 Dec 2019 08:15:43 +0000 (UTC)
Subject: Re: [PATCH 2/7] arm64: dts: realtek: rtd129x: Use reserved-memory for
 RPC regions
To:     linux-realtek-soc@lists.infradead.org,
        James Tai <james.tai@realtek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-3-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <1f25f2fc-5d31-1d74-b730-78ad7861ffce@suse.de>
Date:   Mon, 2 Dec 2019 09:15:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191111030434.29977-3-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James and Realtek colleagues,

Am 11.11.19 um 04:04 schrieb Andreas Färber:
> Move /reserved-memory node from RTD1295 to RTD129x DT.
> Convert RPC /memreserve/s into /reserved-memory nodes.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  arch/arm64/boot/dts/realtek/rtd1295.dtsi | 13 +------------
>  arch/arm64/boot/dts/realtek/rtd129x.dtsi | 23 ++++++++++++++++++++---
>  2 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
> index 34f6cc6f16fe..1402abe80ea1 100644
> --- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
> +++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
> @@ -2,7 +2,7 @@
>  /*
>   * Realtek RTD1295 SoC
>   *
> - * Copyright (c) 2016-2017 Andreas Färber
> + * Copyright (c) 2016-2019 Andreas Färber
>   */
>  
>  #include "rtd129x.dtsi"
> @@ -47,17 +47,6 @@
>  		};
>  	};
>  
> -	reserved-memory {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		tee@10100000 {
> -			reg = <0x10100000 0xf00000>;
> -			no-map;
> -		};
> -	};
> -
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <GIC_PPI 13
> diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
> index 4433114476f5..8d80cca945bc 100644
> --- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
> +++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
> @@ -2,14 +2,12 @@
>  /*
>   * Realtek RTD1293/RTD1295/RTD1296 SoC
>   *
> - * Copyright (c) 2016-2017 Andreas Färber
> + * Copyright (c) 2016-2019 Andreas Färber
>   */
>  
>  /memreserve/	0x0000000000000000 0x0000000000030000;
> -/memreserve/	0x000000000001f000 0x0000000000001000;
>  /memreserve/	0x0000000000030000 0x00000000000d0000;
>  /memreserve/	0x0000000001b00000 0x00000000004be000;
> -/memreserve/	0x0000000001ffe000 0x0000000000004000;
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/realtek,rtd1295.h>
> @@ -19,6 +17,25 @@
>  	#address-cells = <1>;
>  	#size-cells = <1>;
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		rpc_comm: rpc@1f000 {
> +			reg = <0x1f000 0x1000>;
> +		};
> +
> +		rpc_ringbuf: rpc@1ffe000 {
> +			reg = <0x1ffe000 0x4000>;
> +		};

Have you reviewed this patch to be correct? I.e., are the above two
regions reserved RAM (assumption above), or is this rather MMIO
shadowing RAM? (then we would need to update the /memory reg and /soc
ranges properties)

That also affects RTD1619, which currently has neither.

Thanks,
Andreas

> +
> +		tee: tee@10100000 {
> +			reg = <0x10100000 0xf00000>;
> +			no-map;
> +		};
> +	};
> +
>  	arm_pmu: arm-pmu {
>  		compatible = "arm,cortex-a53-pmu";
>  		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
