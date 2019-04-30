Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D036C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEED21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfD3NuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:50:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43651 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfD3NuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:50:17 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hLT94-0001F1-TV; Tue, 30 Apr 2019 15:50:06 +0200
Message-ID: <1556632204.2560.20.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add a node for irqsteer
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 30 Apr 2019 15:50:04 +0200
In-Reply-To: <a08a0a2fdd2090f4f42fe50d8ed70ee08b2fbcaf.1556631673.git.agx@sigxcpu.org>
References: <a08a0a2fdd2090f4f42fe50d8ed70ee08b2fbcaf.1556631673.git.agx@sigxcpu.org>
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

Am Dienstag, den 30.04.2019, 15:41 +0200 schrieb Guido Günther:
> Add a node for the irqsteer interrupt controller found on the iMX8MQ
> SoC.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 2cc939cfbd75..ce0e137ec8ee 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -798,6 +798,27 @@
>  			};
>  		};
>  
> +		bus@32c00000 { /* AIPS4 */
> +			compatible = "fsl,imx8mq-aips-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x32c00000 0x32c00000 0x400000>;
> +
> +			irqsteer: interrupt-controller@32e2d000 {
> +				compatible = "fsl,imx8m-irqsteer",
> +					     "fsl,imx-irqsteer";

This fits on a single line, right?

> +				reg = <0x32e2d000 0x1000>;
> +				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> +				clock-names = "ipg";
> +				fsl,channel = <0>;
> +				fsl,num-irqs = <64>;
> +				interrupt-controller;
> +				interrupt-parent = <&gic>;

This is wrong, the irqsteer upstream IRQ is routed through the GPC like
all the other peripheral interrupts. You can just drop this property.

With this fixed:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Regards,
Lucas

> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
>  		gpu: gpu@38000000 {
>  			compatible = "vivante,gc";
>  			reg = <0x38000000 0x40000>;
