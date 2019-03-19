Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9558FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7A1213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfCSLqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:46:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42063 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfCSLqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:46:14 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h6DBz-0006Zr-Bv; Tue, 19 Mar 2019 12:46:03 +0100
Message-ID: <1552995960.4806.5.camel@pengutronix.de>
Subject: Re: [PATCH v2] arm64: dts: fsl: imx8mq: enable the multi sensor TMU
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>, andrew.smirnov@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 12:46:00 +0100
In-Reply-To: <20190318184643.24025-1-angus@akkea.ca>
References: <20190311213124.29325-1-angus@akkea.ca>
         <20190318184643.24025-1-angus@akkea.ca>
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

Hi Angus,

Am Montag, den 18.03.2019, 11:46 -0700 schrieb Angus Ainslie (Purism):
> Add the imx8mq TMU (Thermal mannagement unit) nodes for CPU,
> GPU, and VPU.
> 
> Changes since v1:
> 
> Removed references to multi sensor patch.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 118 ++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 9155bd4784eb..885395e74452 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi

[...]

> +			thermal-zones {
> +				cpu-thermal {
> +					polling-delay-passive = <250>;
> +					polling-delay = <2000>;
> +					thermal-sensors = <&tmu 0>;
> +
> +					trips {
> +						cpu_alert: cpu-alert {
> +							temperature = <85000>;
> +							hysteresis = <2000>;
> +							type = "passive";
> +						};
> +
> +						cpu_crit {
> +							temperature = <95000>;

All the critical trip points seem to be too high. The consumer parts
have a maximum junction temperature of 95°C, so the common DT
configuration used by all boards should have a crit trip point at least
a few degrees below this value. Boards that only use the industrial
parts can always overwrite the trip points if the designer wishes to do
so.

> +							hysteresis = <2000>;
> +							type = "critical";
> +						};
> +					};
> +
> +					cooling-maps {
> +						map0 {
> +							trip = <&cpu_alert>;
> +							cooling-device =
> +								<&A53_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								<&A53_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								<&A53_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								<&A53_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +						};
> +					};
> +				};
> +
> +				gpu-thermal {
> +					polling-delay-passive = <250>;
> +					polling-delay = <2000>;
> +					thermal-sensors = <&tmu 1>;
> +
> +					trips {
> +						cpu-crit {

Should be gpu-crit.

> +							temperature = <95000>;
> +							hysteresis = <2000>;
> +							type = "critical";
> +						};
> +					};
> +				};
> +
> +				vpu-thermal {
> +					polling-delay-passive = <250>;
> +					polling-delay = <2000>;
> +					thermal-sensors = <&tmu 2>;
> +
> +					trips {
> +						cpu-crit {

Should be vpu-crit.

Regards,
Lucas
