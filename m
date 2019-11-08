Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63359C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6942178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfKHQz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:55:59 -0500
Received: from muru.com ([72.249.23.125]:40894 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfKHQz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:55:58 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0355D80D4;
        Fri,  8 Nov 2019 16:56:33 +0000 (UTC)
Date:   Fri, 8 Nov 2019 08:55:54 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Benoit Parrot <bparrot@ti.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, Tero Kristo <t-kristo@ti.com>,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 3/5] ARM: dts: dra7: add vpe clkctrl node
Message-ID: <20191108165554.GF5610@atomide.com>
References: <20191104203841.3628-1-bparrot@ti.com>
 <20191104203841.3628-4-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104203841.3628-4-bparrot@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Benoit Parrot <bparrot@ti.com> [191104 20:39]:
> Add clkctrl nodes for VPE module.

Can you please add a comment describing that we currently need to
use custom node names here instead of the standard naming?

I can queue this and other dts change once I have an immutable clock
changes branch from Tero.

Or if Tero wants to also pick up the clock node dtsi patch I can ack it,
up to Tero.

Regards,

Tony


> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
>  arch/arm/boot/dts/dra7xx-clocks.dtsi | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> index 93e1eb83bed9..d1c2406ec71c 100644
> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> @@ -1591,10 +1591,10 @@
>  
>  	rtc_cm: rtc-cm@700 {
>  		compatible = "ti,omap4-cm";
> -		reg = <0x700 0x100>;
> +		reg = <0x700 0x60>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		ranges = <0 0x700 0x100>;
> +		ranges = <0 0x700 0x60>;
>  
>  		rtc_clkctrl: rtc-clkctrl@20 {
>  			compatible = "ti,clkctrl";
> @@ -1603,6 +1603,20 @@
>  		};
>  	};
>  
> +	vpe_cm: vpe-cm@760 {
> +		compatible = "ti,omap4-cm";
> +		reg = <0x760 0xc>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x760 0xc>;
> +
> +		vpe_clkctrl: vpe-clkctrl@0 {
> +			compatible = "ti,clkctrl";
> +			reg = <0x0 0xc>;
> +			#clock-cells = <2>;
> +		};
> +	};
> +
>  };
>  
>  &cm_core {
> -- 
> 2.17.1
> 
