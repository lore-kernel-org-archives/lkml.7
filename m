Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F41C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C16218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553136269;
	bh=WZs8qVXwRHAAqs9TdPfjj9VRDNhqr9mY87VN79g4CKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HaLaTVfugsio/7ZCzqHhdLT5Epnz75r8xsredlMVDq9N5SUFKVKfBBxEi5cxFHAYv
	 8FV4DdPr727yK4xeiogy4SxQYiwLCP4cJ5KiuSFybLZfSHkkMqp7bAEWF/HdQ9icpc
	 /KNIkShkcTjWpcLQCe5gM7+9y0RFwImy0fUOgNOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfCUCo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbfCUCo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:44:28 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44BEA206B7;
        Thu, 21 Mar 2019 02:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553136266;
        bh=WZs8qVXwRHAAqs9TdPfjj9VRDNhqr9mY87VN79g4CKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U65BVbMO3s6JHlt8uUHeA8rMekfyD4xUgHbEZM1//c+nBce5/lgPhJ26fEpsKidZL
         k743GJPYHCqaFs9Vq9vig4kNkIOSe3e5b03LtgOq+xqOsYDP1UXjaQCQXIu/EDKEbv
         0K9KCvljgGKXow4XTuJjoSOA1SGp2AG5mlEEdoP4=
Date:   Thu, 21 Mar 2019 10:44:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
Subject: Re: [PATCH v3] arm64: dts: ls1088a: add one more thermal zone node
Message-ID: <20190321024359.GA12513@dragon>
References: <20190304075050.33432-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304075050.33432-1-andy.tang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 03:50:50PM +0800, Yuantian Tang wrote:
> Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core cluster
> sensor is used to monitor the temperature of core and SoC platform is for
> platform. The current dts only support the first sensor.
> This patch adds the second sensor node to dts to enable it.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
> v3:
> 	- use more descriptive name for each zone
> v2:
> 	- Add more information about sensors to description
> PS: In order to keep consistency to the first thermal-zone node, there will
> be "WARNING: line over 80 characters" warnings.
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   43 +++++++++++++++++++++--
>  1 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 661137f..54f973b 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -129,19 +129,19 @@
>  	};
>  
>  	thermal-zones {
> -		cpu_thermal: cpu-thermal {
> +		core_cluster_thermal {

We prefer to use hyphen instead of underscore in node name.

Shawn

>  			polling-delay-passive = <1000>;
>  			polling-delay = <5000>;
>  			thermal-sensors = <&tmu 0>;
>  
>  			trips {
> -				cpu_alert: cpu-alert {
> +				core_cluster_alert: core_cluster-alert {
>  					temperature = <85000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit: cpu-crit {
> +				core_cluster_crit: core_cluster-crit {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "critical";
> @@ -150,7 +150,42 @@
>  
>  			cooling-maps {
>  				map0 {
> -					trip = <&cpu_alert>;
> +					trip = <&core_cluster_alert>;
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
> +		platform-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <5000>;
> +			thermal-sensors = <&tmu 1>;
> +
> +			trips {
> +				platform_alert: platform-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				platform_crit: platform-crit {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&platform_alert>;
>  					cooling-device =
>  						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>  						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -- 
> 1.7.1
> 
