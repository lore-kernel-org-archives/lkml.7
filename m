Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134E5C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FD421019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558601525;
	bh=GvIxnz2QDkzaDXhCwkyYIbh58BouSz387m9539g/2A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qKBbBgcrzEdyIEGK7kfHl6trBssq5OAioYK918PkxCH/cHEaZvu10UC98t/kgGfj4
	 0xXvD36lH3Al5cHg/PFV14JZ2NmhvkoJLtFGJrU29SSWti2/Iq+P2Gq7JLG7ASOy37
	 e2rrJp/fhQTgagSiMlDNN6vdOXiyqL9m6xH7Umug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfEWIwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfEWIwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:52:04 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9633220675;
        Thu, 23 May 2019 08:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558601523;
        bh=GvIxnz2QDkzaDXhCwkyYIbh58BouSz387m9539g/2A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGQ/xj15H4e7wzpcSW5LwgkL0k2fAuxUfKby8GOqJq7U+CObYxAh8WO4TLHsuSU42
         5OmnsByuClenpeucDd2R6GXBQ9Q2yBeqlfsJP9xf/abAQ4i3T1VngiNyi/Mf833qTw
         +QEBNS3NTcj3UbMAhjKZ/c3iC5Hv1hkYAHSrkH3c=
Date:   Thu, 23 May 2019 16:51:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: ls1028a: Fix CPU idle fail.
Message-ID: <20190523085104.GP9261@dragon>
References: <20190517045753.3709-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517045753.3709-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 12:57:53PM +0800, Ran Wang wrote:
> PSCI spec define 1st parameter's bit 16 of function CPU_SUSPEND to
> indicate CPU State Type: 0 for standby, 1 for power down. In this
> case, we want to select standby for CPU idle feature. But current
> setting wrongly select power down and cause CPU SUSPEND fail every
> time. Need this fix.
> 
> Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Leo, Bhaskar,

Do you guys agree with it?

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
