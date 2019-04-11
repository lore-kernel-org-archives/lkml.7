Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16BEC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9447C20818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfDKPFZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:05:25 -0400
Received: from mailoutvs41.siol.net ([185.57.226.232]:48971 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726106AbfDKPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:05:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 798025202F2;
        Thu, 11 Apr 2019 17:05:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id g84Ihv68lrZw; Thu, 11 Apr 2019 17:05:21 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 1BF20521A36;
        Thu, 11 Apr 2019 17:05:21 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 0E88E5202F2;
        Thu, 11 Apr 2019 17:05:20 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 4/8] arm64: dts: allwinner: Add ARM Mali GPU node for H6
Date:   Thu, 11 Apr 2019 17:05:19 +0200
Message-ID: <2957024.jOddxINRMN@jernej-laptop>
In-Reply-To: <20190411105720.32357-5-peron.clem@gmail.com>
References: <20190411105720.32357-1-peron.clem@gmail.com> <20190411105720.32357-5-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 11. april 2019 ob 12:57:16 CEST je Clément Péron napisal(a):
> Add the mali gpu node to the H6 device-tree.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi index
> e0dc4a05c1ba..196753110434 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -157,6 +157,20 @@
>  			allwinner,sram = <&ve_sram 1>;
>  		};
> 
> +		gpu: gpu@1800000 {
> +			compatible = "allwinner,sun50i-h6-mali",
> +				     "arm,mali-t720";
> +			reg = <0x01800000 0x4000>;
> +			interrupts = <GIC_SPI 84 
IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 85 
IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 83 
IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "job", "mmu", "gpu";
> +			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
> +			clock-names = "core", "bus";
> +			resets = <&ccu RST_BUS_GPU>;
> +			status = "disabled";

Usually self sufficient peripherals are enabled by default in DTSI.

> +		};
> +
>  		syscon: syscon@3000000 {
>  			compatible = "allwinner,sun50i-h6-system-
control",
>  				     "allwinner,sun50i-a64-
system-control";




