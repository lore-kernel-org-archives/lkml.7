Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCC7C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7502070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="laVgbQDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfDOUO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:14:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52005 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbfDOUO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:14:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so22241503wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Zz8Pw0IywdVZmLzpySUK8y6rx1aYgJaetDtTdtCR2A=;
        b=laVgbQDmn6rBRABo2BVuka1E8Rt00qmmM6nVwd7nll+IwZjktgdwjUqveKRB222SVk
         JcQe1HH5L51ykMuTExgq8UUt9VVpWpBIY2neOHvN7NpRSeDnOHMyoKfTmISXTad1Ll5a
         CAmMmdrU00jaIr89AE5Nisw3DbtawIXvd1bV9hmoGx8JDCJF+j+TZO4YHJxUAIagv6WY
         rDGmh96DgqOeAq8xUe57ClYPsIwxYuk0OA8sq8hSt2DyvCACtz2YkUsTswExi7/mW/Bb
         R+TkkoSk3Yp1fYoHX8f8yeALHB1OcjAAC5iqTebvXqzj8Vf6CB7bnkjALcz8qzToQgO9
         MpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Zz8Pw0IywdVZmLzpySUK8y6rx1aYgJaetDtTdtCR2A=;
        b=WRPxpDkJKo9O9luy3X93XoZJbn1I/dzoai5R2BYJxjnGIxFSZBOVSPCZCzztMol1d3
         dn4tdajnnpIUAJqtucbvcN5nQgjUavoX5Yby6+0wWmaheTXB5wdsQNpSfCKj3e88ZKUj
         sP6RrDcHcC/cvw4Aa7YOXcz8eloKTmozJ+Rolk42Zf5jIaWv2VxBViIa52GkximkGSmk
         FeSW/hQMMIUTKH+pbHFDDWXlDVE4i08gUcmMB9DWeywCbGyxCpk4IIkO++2zPcrsxywt
         CJWI3siJ9PQqM/69LE8MMVQyK/JkQRdoo6eofa4jqCFwu8Nc4gwL8V7iJB5O8iT8FWdT
         FliA==
X-Gm-Message-State: APjAAAWCi7AoB2igaIruX5WYrIxWqrig1NXDIZeDwfpRlaLK6jxq8x7G
        KtmtWK1o4DqVkxKuPul6bZAQUg==
X-Google-Smtp-Source: APXvYqyQEzln6XOWM2ynJw+YQDlBCHdojlOjEpDDncEpFUsCoZksmuMhNCEow97MqpcvRWyoI8mYdQ==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr23776423wmi.1.1555359263779;
        Mon, 15 Apr 2019 13:14:23 -0700 (PDT)
Received: from [192.168.0.41] (4.112.130.77.rev.sfr.net. [77.130.112.4])
        by smtp.googlemail.com with ESMTPSA id e1sm84213999wrw.66.2019.04.15.13.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 13:14:23 -0700 (PDT)
Subject: Re: [PATCH RESEND V11 4/4] arm64: dts: imx: add i.MX8QXP thermal
 support
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
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Gross <andy.gross@linaro.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554881866-26333-1-git-send-email-Anson.Huang@nxp.com>
 <1554881866-26333-4-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <13bc5836-cc0e-82f7-60ef-3ef544aa8ec2@linaro.org>
Date:   Mon, 15 Apr 2019 22:14:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554881866-26333-4-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2019 09:43, Anson Huang wrote:
> Add i.MX8QXP CPU thermal zone support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V10:
> 	- remove property "imx,sensor-resource-id" and put HW resource ID inside each
> 	  thermal-sensors' phandle argument.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 33 ++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 70ef3db..cc1d877 100644
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
> @@ -484,4 +490,31 @@
>  			power-domains = <&pd IMX_SC_R_GPIO_7>;
>  		};
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
> +						<&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;

	<&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
	<&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
	<&A35_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
	<&A35_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;


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

