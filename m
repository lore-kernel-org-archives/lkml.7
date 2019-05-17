Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FFCC04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C938220848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558060690;
	bh=Wr1yzMGgyj3VQSwkaM11AkyNfKyelc2CIBDIDuLoZj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B9j/b9RTTNNjEtAx24g+Om431DZzS09yl4ksnB+1i/4RPZXxxaLzg+OQD10W7P0eg
	 w4pXlkjF50eBjZ5DW8fzHslP8lo5g3IUcZsitpPzFryscNNu2DCeGthYJooEglnirP
	 ppnz9ZYkgQ82apNkHtCJrLBVz58jl2TbbuOMWeRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfEQCiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 22:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfEQCiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 22:38:09 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2CD205ED;
        Fri, 17 May 2019 02:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558060688;
        bh=Wr1yzMGgyj3VQSwkaM11AkyNfKyelc2CIBDIDuLoZj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HeqhCFWTsfpLdJRe6Ty5/qvEgvMjaLDNeCmAeRof2koYmWwR7ysORuJjUrVLv7KXN
         Gl0rEVVTR13BQpCX6raxMQpUsRzyOTkh+eASRBgUNhPgw10VJTo0nrtYJ+qPIjcnPk
         2927FfvMZULbBNyISkFVJRKKPiAoB4WFn8ZSe5r4=
Date:   Fri, 17 May 2019 10:37:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     leoyang.li@nxp.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Ying-22455 <ying.zhang22455@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix watchdog device node
Message-ID: <20190517023728.GA15856@dragon>
References: <20190509070657.18281-1-chuanhua.han@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509070657.18281-1-chuanhua.han@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 03:06:57PM +0800, Chuanhua Han wrote:
> ls1028a platform uses sp805 watchdog, and use 1/16 platform clock as
> timer clock, this patch fix device tree node.
> 
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index b04581249f0b..1510b1858246 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -285,13 +285,18 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> -		wdog0: watchdog@23c0000 {
> -			compatible = "fsl,ls1028a-wdt", "fsl,imx21-wdt";
> -			reg = <0x0 0x23c0000 0x0 0x10000>;
> -			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&clockgen 4 1>;
> -			big-endian;
> -			status = "disabled";
> +		cluster1_core0_watchdog: wdt@c000000 {

Keep 'watchdog' as the node name, and keep nodes sort in unit-address.

Shawn

> +			compatible = "arm,sp805", "arm,primecell";
> +			reg = <0x0 0xc000000 0x0 0x1000>;
> +			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
> +			clock-names = "apb_pclk", "wdog_clk";
> +		};
> +
> +		cluster1_core1_watchdog: wdt@c010000 {
> +			compatible = "arm,sp805", "arm,primecell";
> +			reg = <0x0 0xc010000 0x0 0x1000>;
> +			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
> +			clock-names = "apb_pclk", "wdog_clk";
>  		};
>  
>  		sata: sata@3200000 {
> -- 
> 2.17.1
> 
