Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C913FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91883218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfCUOst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:48:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40173 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUOst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:48:49 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h6yzk-0002zw-DW; Thu, 21 Mar 2019 15:48:36 +0100
Message-ID: <1553179714.4806.39.camel@pengutronix.de>
Subject: Re: [PATCH v4] arm64: dts: fsl: imx8mq: enable the multi sensor TMU
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Mar 2019 15:48:34 +0100
In-Reply-To: <20190321125252.4498-1-angus@akkea.ca>
References: <20190311213124.29325-1-angus@akkea.ca>
         <20190321125252.4498-1-angus@akkea.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 21.03.2019, 05:52 -0700 schrieb Angus Ainslie (Purism):
> Add the imx8mq TMU (Thermal management unit) nodes for CPU,
> GPU, and VPU.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> 
> Changes since v3:
> 
> Moved the annotation.
> 
> Changes since v2:
> 
> Updated alert and critical temps for commercial parts.
> Fixed node names.
> 
> Changes since v1:
> 
> Removed references to multi sensor patch.
> 
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 118 ++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index b39c6c75c043..81d5ce1b1ec1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/power/imx8mq-power.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
>  #include "imx8mq-pinfunc.h"
>  
>  / {
> @@ -89,6 +90,7 @@
> >  			reg = <0x0>;
> >  			enable-method = "psci";
> >  			next-level-cache = <&A53_L2>;
> > +			#cooling-cells = <2>;
> >  		};
>  
> > >  		A53_1: cpu@1 {
> @@ -97,6 +99,7 @@
> >  			reg = <0x1>;
> >  			enable-method = "psci";
> >  			next-level-cache = <&A53_L2>;
> > +			#cooling-cells = <2>;
> >  		};
>  
> > >  		A53_2: cpu@2 {
> @@ -105,6 +108,7 @@
> >  			reg = <0x2>;
> >  			enable-method = "psci";
> >  			next-level-cache = <&A53_L2>;
> > +			#cooling-cells = <2>;
> >  		};
>  
> > >  		A53_3: cpu@3 {
> @@ -113,6 +117,7 @@
> >  			reg = <0x3>;
> >  			enable-method = "psci";
> >  			next-level-cache = <&A53_L2>;
> > +			#cooling-cells = <2>;
> >  		};
>  
> >  		A53_L2: l2-cache0 {
> @@ -210,6 +215,119 @@
> >  				#interrupt-cells = <2>;
> >  			};
>  
> > > +			tmu: tmu@30260000 {
> > +				compatible = "fsl,imx8mq-tmu";
> > +				reg = <0x30260000 0x10000>;
> > +				interrupt = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> > +				little-endian;
> > +				fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x70061>;
> > +				fsl,tmu-calibration = <0x00000000 0x00000023
> > +						       0x00000001 0x00000029
> > +						       0x00000002 0x0000002f
> > +						       0x00000003 0x00000035
> > +						       0x00000004 0x0000003d
> > +						       0x00000005 0x00000043
> > +						       0x00000006 0x0000004b
> > +						       0x00000007 0x00000051
> > +						       0x00000008 0x00000057
> > +						       0x00000009 0x0000005f
> > +						       0x0000000a 0x00000067
> > +						       0x0000000b 0x0000006f
> +
> > +						       0x00010000 0x0000001b
> > +						       0x00010001 0x00000023
> > +						       0x00010002 0x0000002b
> > +						       0x00010003 0x00000033
> > +						       0x00010004 0x0000003b
> > +						       0x00010005 0x00000043
> > +						       0x00010006 0x0000004b
> > +						       0x00010007 0x00000055
> > +						       0x00010008 0x0000005d
> > +						       0x00010009 0x00000067
> > +						       0x0001000a 0x00000070
> +
> > +						       0x00020000 0x00000017
> > +						       0x00020001 0x00000023
> > +						       0x00020002 0x0000002d
> > +						       0x00020003 0x00000037
> > +						       0x00020004 0x00000041
> > +						       0x00020005 0x0000004b
> > +						       0x00020006 0x00000057
> > +						       0x00020007 0x00000063
> > +						       0x00020008 0x0000006f
> +
> > +						       0x00030000 0x00000015
> > +						       0x00030001 0x00000021
> > +						       0x00030002 0x0000002d
> > +						       0x00030003 0x00000039
> > +						       0x00030004 0x00000045
> > +						       0x00030005 0x00000053
> > +						       0x00030006 0x0000005f
> > +						       0x00030007 0x00000071>;
> > +				#thermal-sensor-cells =  <1>;
> > +			};
> +
> > +			thermal-zones {
> > +				cpu-thermal {
> > +					polling-delay-passive = <250>;
> > +					polling-delay = <2000>;
> > +					thermal-sensors = <&tmu 0>;
> +
> > +					trips {
> > +						cpu_alert: cpu-alert {
> > +							temperature = <80000>;
> > +							hysteresis = <2000>;
> > +							type = "passive";
> > +						};
> +
> > +						cpu-crit {
> > +							temperature = <90000>;
> > +							hysteresis = <2000>;
> > +							type = "critical";
> > +						};
> > +					};
> +
> > +					cooling-maps {
> > +						map0 {
> > +							trip = <&cpu_alert>;
> > +							cooling-device =
> > +								<&A53_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +								<&A53_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +								<&A53_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +								<&A53_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +						};
> > +					};
> > +				};
> +
> > +				gpu-thermal {
> > +					polling-delay-passive = <250>;
> > +					polling-delay = <2000>;
> > +					thermal-sensors = <&tmu 1>;
> +
> > +					trips {
> > +						gpu-crit {
> > +							temperature = <90000>;
> > +							hysteresis = <2000>;
> > +							type = "critical";
> > +						};
> > +					};
> > +				};
> +
> > +				vpu-thermal {
> > +					polling-delay-passive = <250>;
> > +					polling-delay = <2000>;
> > +					thermal-sensors = <&tmu 2>;
> +
> > +					trips {
> > +						vpu-crit {
> > +							temperature = <90000>;
> > +							hysteresis = <2000>;
> > +							type = "critical";
> > +						};
> > +					};
> > +				};
> > +			};
> +
> > >  			wdog1: watchdog@30280000 {
> >  				compatible = "fsl,imx8mq-wdt", "fsl,imx21-wdt";
> >  				reg = <0x30280000 0x10000>;
