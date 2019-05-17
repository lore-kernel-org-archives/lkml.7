Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685EBC04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 01:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387342084A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 01:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558056815;
	bh=O9wozGMr07+YQDGYWozdnjJCI45Cd9hl7O38n5vxJAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MouTJxxuf7XswpG7t519wA5D6aF5ce7WAMCOoj/XjMUBELgvnj8JTzGVC1JkHycMC
	 ToRd82mK97UH1pJf7EXdkuLD2aG91sKfDZILCnwZE4z/RJzb5pYqcC16NQx6/6sjy9
	 smFgsbTHtq6IdnZivh7cOQxWB1uyhpd6QoaWq10g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfEQBde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 21:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfEQBde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 21:33:34 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C852082E;
        Fri, 17 May 2019 01:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558056813;
        bh=O9wozGMr07+YQDGYWozdnjJCI45Cd9hl7O38n5vxJAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bjgfPT1OPC6BXdfEPnRA/CwehJ3luuGfQMgu+pGQWUhR/qzb7vj0LRY0VPg+SBS32
         RgQBgEJfnoaukkB0dQYeHZanp16JKUynTyPqRFboQM9ND+X11fyBKZ0UOw7JbEfiER
         hs1tDcMS+pPF+EhbCRc4/Bn+EbRA968XpswC3AZg=
Date:   Fri, 17 May 2019 09:32:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ls1028a: Fix CPU idle fail.
Message-ID: <20190517013252.GV15856@dragon>
References: <20190507074454.41589-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507074454.41589-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 07:43:37AM +0000, Ran Wang wrote:
> PSCI spec define 1st parameter's bit 16 of function CPU_SUSPEND to
> indicate CPU State Type: 0 for standby, 1 for power down. In this
> case, we want to select standby for CPU idle feature. But current
> setting wrongly select power down and cause CPU SUSPEND fail every
> time. Need this fix.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Do we need a Fixes tag for this?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index b045812..bf7f845 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -28,7 +28,7 @@
>  			enable-method = "psci";
>  			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&l2>;
> -			cpu-idle-states = <&CPU_PH20>;
> +			cpu-idle-states = <&CPU_PW20>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -38,7 +38,7 @@
>  			enable-method = "psci";
>  			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&l2>;
> -			cpu-idle-states = <&CPU_PH20>;
> +			cpu-idle-states = <&CPU_PW20>;
>  		};
>  
>  		l2: l2-cache {
> @@ -53,13 +53,13 @@
>  		 */
>  		entry-method = "arm,psci";
>  
> -		CPU_PH20: cpu-ph20 {
> -			compatible = "arm,idle-state";
> -			idle-state-name = "PH20";
> -			arm,psci-suspend-param = <0x00010000>;
> -			entry-latency-us = <1000>;
> -			exit-latency-us = <1000>;
> -			min-residency-us = <3000>;
> +		CPU_PW20: cpu-pw20 {
> +			  compatible = "arm,idle-state";
> +			  idle-state-name = "PW20";
> +			  arm,psci-suspend-param = <0x0>;
> +			  entry-latency-us = <2000>;
> +			  exit-latency-us = <2000>;
> +			  min-residency-us = <6000>;
>  		};
>  	};
>  
> -- 
> 1.7.1
> 
