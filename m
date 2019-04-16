Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8B0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C594320868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ew0MxsSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfDPQS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:18:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34121 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfDPQS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:18:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so27937432wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8UltktXs7ZW5cQZka4amrzfMkG4ueUrIVKpXN3M6WlA=;
        b=ew0MxsSxY6aPHsfvVDMw0iZN2jkZwMlYgWKSyDdf605S54MPjC5SvxoGQbaqxI0dQC
         iELv5HyDZcc8O5GSiapxRZJnNq5QXhXWOCOGd+xet9g6Yy6ZvWk8VDdAicRXv8iHu2Vh
         wtSv0+oLGqCXfOAPQUgdxSJ/SSMv4zPtFwasoljj8z2mq83Km1rTPHXRzG55UCLLi7Fh
         qvfO3D/u6mjKUsj5nLoX/einajr47vl6YqXPdSCO1psVUGly/DCR4pafjCWLS1fAG7T9
         MAulfWqjG5NZOB5qjgZgaLiKSWWyIF/fhWFXSJOX6KFQ5eO+G8m1hDB4ltop+t3PktXl
         lUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8UltktXs7ZW5cQZka4amrzfMkG4ueUrIVKpXN3M6WlA=;
        b=TiaYTTlVzHc/oHX0Zmr9cEFZTHjbcaFYK+dFZO/XN8RsMy/nN3U42GHP+FbHMzCDgc
         +FSFlEiTCsHD37LI97DmW7kOJh0icQ6EzODVNXKj4poOCwyMH5xr8GeCl4s7EZ+tFMEo
         b2+iJOaZx/yyfenZNNt1k9zUoqBAyIT8jH9950zgEtWlt4EE+IUL+TSuE7I6lJgdZyjj
         ehagXbEeDK0JWysSfq5mO6W2hfStvNBOqkp/QDqg5Wcxc5PAeK65nV6VsyDV8Yh0kD9g
         DunLN0/wUIsqRA8iPv6b5YN3nGdmOnmMFcRgDvNfsvpyTO7uGoMXFEmFdtt5et0buiwW
         JvVw==
X-Gm-Message-State: APjAAAVBFbMHZzlJUjQMMw57GL+un9UTMyOqTTwXLcVGoDPjJy2fKZhm
        qpWeY6VW5VdVoO7irOgQbKAXRA==
X-Google-Smtp-Source: APXvYqwALk90AVMKgO5DQXj9qQ5QA9SWeRpmLsLGO3w47rnh4Ekkb8YwFZv1fgFEOTkNnvk0pC6rMA==
X-Received: by 2002:a05:6000:1111:: with SMTP id z17mr52816705wrw.103.1555431536047;
        Tue, 16 Apr 2019 09:18:56 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id r16sm42403658wrx.37.2019.04.16.09.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:18:55 -0700 (PDT)
Subject: Re: [PATCH V12 5/5] arm64: dts: imx: add i.MX8QXP thermal support
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
 <1555384609-7030-5-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8f1c7e2b-2fd2-766c-7a75-8464361f7d1d@linaro.org>
Date:   Tue, 16 Apr 2019 18:18:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555384609-7030-5-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2019 05:22, Anson Huang wrote:
> Add i.MX8QXP CPU thermal zone support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> Changes since V11:
> 	- add cooling device for all secondary CPUs.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 37 ++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 0683ee2..5eeaddc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -149,6 +150,11 @@
>  		rtc: rtc {
>  			compatible = "fsl,imx8qxp-sc-rtc";
>  		};
> +
> +		tsens: thermal-sensor {
> +			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> +			#thermal-sensor-cells = <1>;
> +		};
>  	};
>  
>  	timer {
> @@ -522,4 +528,35 @@
>  		compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
>  		timeout-sec = <60>;
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		cpu-thermal0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +			thermal-sensors = <&tsens IMX_SC_R_SYSTEM>;
> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <107000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu_crit0: trip1 {
> +					temperature = <127000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert0>;
> +					cooling-device =
> +						<&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A35_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A35_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +
> +				};
> +			};
> +		};
> +	};
>  };
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

