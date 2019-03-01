Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE111C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4732084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551447549;
	bh=gNQ+CS6P+04BRuMvOzP54uGMZhZUhsZgd+SWpqZ1bOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1eGg9rTJYXNKYXLII2FK6ghauzS6W3Fl/FEvQoRXg5/5kn1WmjKBJwuxpfLy8QgJ2
	 CfQ72YKS6U/jiwcHc3D3itkACoGX7b+jqfR2WWIZmdnJjfoMXvSlDVbWDmzQ+m5tdO
	 IGrYjvs6QM+qYhRUKR5RB9736F+MtImsw8W7Qdk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbfCANjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387890AbfCANjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:39:07 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E22E52084D;
        Fri,  1 Mar 2019 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551447546;
        bh=gNQ+CS6P+04BRuMvOzP54uGMZhZUhsZgd+SWpqZ1bOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNCmCP6V0GweJp4d+him7lT/bdyo19KlSRjD6iDWHpiwcMDDxi84WnPu2TfzvzoEN
         NLSzLfHqNDgYqnGVszBKFTxyu3yo+Gp6+USEVwkdhZsg7CBWa6EBwKMTRJ2I4XPAJD
         K+0BCrb2Hx6sPZxbqzMCcCtA3uCqRrr7ngVqTcCU=
Date:   Fri, 1 Mar 2019 21:38:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
Subject: Re: [PATCH] arm64: dts: ls1088a: add one more thermal zone node
Message-ID: <20190301133805.GQ26041@dragon>
References: <20190225030049.20401-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225030049.20401-1-andy.tang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 11:00:49AM +0800, Yuantian Tang wrote:
> Ls1088a has 2 thermal sensors. This patch adds the second node
> to dts to enable it.

Can you elaborate on these 2 thermal sensors/zones, ccu and plt?

Shawn

> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   43 +++++++++++++++++++++--
>  1 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 661137f..9f52bc9 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -129,19 +129,19 @@
>  	};
>  
>  	thermal-zones {
> -		cpu_thermal: cpu-thermal {
> +		ccu {
>  			polling-delay-passive = <1000>;
>  			polling-delay = <5000>;
>  			thermal-sensors = <&tmu 0>;
>  
>  			trips {
> -				cpu_alert: cpu-alert {
> +				ccu_alert: ccu-alert {
>  					temperature = <85000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit: cpu-crit {
> +				ccu_crit: ccu-crit {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "critical";
> @@ -150,7 +150,42 @@
>  
>  			cooling-maps {
>  				map0 {
> -					trip = <&cpu_alert>;
> +					trip = <&ccu_alert>;
> +					cooling-device =
> +						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		plt {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <5000>;
> +			thermal-sensors = <&tmu 1>;
> +
> +			trips {
> +				plt_alert: plt-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				plt_crit: plt-crit {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&plt_alert>;
>  					cooling-device =
>  						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>  						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -- 
> 1.7.1
> 
