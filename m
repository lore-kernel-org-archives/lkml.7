Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0593C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 04:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95D221871
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 04:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567828941;
	bh=1gMSka+4QLoCiltsiYLD1GUn97RGYkVSkdGt0rGcA2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AZ9846TZYCeANOtIe115F0E0sgJEdnQQ3nJUP8d6Z/LmrAXR5IqLoJohmekkhkrQw
	 +JlPhbkJ3lcbiQg8bjjZbuRdEW99OqHWai8dlcVuJyw4oUlbvOx+w9Rv1jMukWvd7P
	 8vYoQdlbKAwFVX3odJTbogAikWLvYAwywxdhSdSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391410AbfIGECV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 00:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfIGECU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 00:02:20 -0400
Received: from localhost (unknown [194.251.198.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF582070C;
        Sat,  7 Sep 2019 04:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567828940;
        bh=1gMSka+4QLoCiltsiYLD1GUn97RGYkVSkdGt0rGcA2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlXSdikJ6wry65JzxmjpGos/mSjfnW4y1NMoK94yvlxnIwO7WTtmxm6p9Jymo6jbT
         +o/OLvhnwpZIbYAUtN+7AzK9LZRCqdnGD55vKwMVNphf+AHr+MiBuVJHO90gmJy42i
         IQUDyu+rLiMyt2M0LOszN9fTGXOuYU0RcbBmxJeU=
Date:   Sat, 7 Sep 2019 07:02:17 +0300
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux@armlinux.org.uk, mark.rutland@arm.com, robh+dt@kernel.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 4/9] ARM: dts: sun8i: r40: add crypto engine node
Message-ID: <20190907040217.kzvq7gfxz67pluhz@flea>
References: <20190906184551.17858-1-clabbe.montjoie@gmail.com>
 <20190906184551.17858-5-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906184551.17858-5-clabbe.montjoie@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 08:45:46PM +0200, Corentin Labbe wrote:
> The Crypto Engine is a hardware cryptographic offloader that supports
> many algorithms.
> It could be found on most Allwinner SoCs.
>
> This patch enables the Crypto Engine on the Allwinner R40 SoC Device-tree.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index bde068111b85..7eb649cea163 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -266,6 +266,17 @@
>  			#phy-cells = <1>;
>  		};
>
> +		crypto: crypto-engine@1c15000 {
> +			compatible = "allwinner,sun8i-r40-crypto";
> +			reg = <0x01c15000 0x1000>;
> +			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>;
> +			clock-names = "ahb", "mod";
> +			resets = <&ccu RST_BUS_CE>;
> +			reset-names = "ahb";
> +			status = "okay";

The driver will probe if status is not declared, so if you want it
always enabled you should simply remove status

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
