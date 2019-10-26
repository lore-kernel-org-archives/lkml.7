Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F0CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B67205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572092817;
	bh=Tl/yYfCwTv1OF2qFO6c8Wx02cTYUgWo+y/EvJ8uVR2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LhHwUWtvBTgSs0Rwi3isRqm2bWyKOyFaix8b1TrVVG/QJAiEnrYv9ys6vqdM6dEnS
	 rUDSvqIBJOSsbRLxWiJQ8XX4v5gzs1jYe5TaOPqKFl0GsPYS36FUIKZWrZ/SeJO6tQ
	 gjTGrIoOuwibD+dvJtVP0Uw6Je1aj1IjOaIeHjwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfJZM0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 08:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:32824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfJZM0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 08:26:49 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D368720578;
        Sat, 26 Oct 2019 12:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572092808;
        bh=Tl/yYfCwTv1OF2qFO6c8Wx02cTYUgWo+y/EvJ8uVR2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRBaZ7RxMMILSI/1tSzGhKjYreclSed8AELjJoTAcydP7ULUXQBxJ4a3GdbLwRG9G
         zOJpD/YYw6T/R1dAypSwHOAz48Mx8sk1am3T5s6LRC/oOdbgmax92KSuNx1rL/Zh23
         ZLToZMGahADs5BuA8ruf9j6b9ocddioNH2ondgms=
Date:   Sat, 26 Oct 2019 20:26:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
Cc:     devicetree@vger.kernel.org, jerome.oufella@savoirfairelinux.com,
        rennes@savoirfairelinux.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ARM: dts: imx6qdl-rex: add gpio expander pca9535
Message-ID: <20191026122630.GM14401@dragon>
References: <20191016092255.19223-1-gilles.doffe@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016092255.19223-1-gilles.doffe@savoirfairelinux.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:22:55AM +0200, Gilles DOFFE wrote:
> The pca9535 gpio expander is present on the Rex baseboard, but missing
> from the dtsi.
> The pca9535 is on i2c2 bus which is common to the three SOM
> variants (Basic/Pro/Ultra), thus it is activated by default.
> 
> Add also the new gpio controller and the associated interrupt line
> MX6QDL_PAD_NANDF_CS3__GPIO6_IO16.
> 
> Signed-off-by: Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
> ---
>  arch/arm/boot/dts/imx6qdl-rex.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6qdl-rex.dtsi
> index 97f1659144ea..305b57fadc60 100644
> --- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
> @@ -132,6 +132,19 @@
>  	pinctrl-0 = <&pinctrl_i2c2>;
>  	status = "okay";
>  
> +	pca9535: gpio-expander@27 {
> +		compatible = "nxp,pca9535";
> +		reg = <0x27>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pca9535>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
>  	eeprom@57 {
>  		compatible = "atmel,24c02";
>  		reg = <0x57>;
> @@ -237,6 +250,12 @@
>  			>;
>  		};
>  
> +		pinctrl_pca9535: pca9535 {

For sake of consistency, the node name should be prefixed with 'grp',
which tells this is a pinctrl group node.

I fixed it up and applied the patch.

Shawn

> +			fsl,pins = <
> +				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x17059
> +		   >;
> +		};
> +
>  		pinctrl_uart1: uart1grp {
>  			fsl,pins = <
>  				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
> -- 
> 2.20.1
> 
