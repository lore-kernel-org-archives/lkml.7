Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C8DC742C2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B34208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfGLNzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 09:55:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52065 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfGLNzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:55:53 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1hlw1b-0005Pp-Co; Fri, 12 Jul 2019 15:55:47 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hlw1V-0008Q6-Mn; Fri, 12 Jul 2019 15:55:41 +0200
Date:   Fri, 12 Jul 2019 15:55:41 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        festevam@gmail.com, s.hauer@pengutronix.de, robh+dt@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH] arm: dts: imx6qdl: add gpio expander pca9535
Message-ID: <20190712135541.55fgchvyp33cl3uv@pengutronix.de>
References: <20190712124522.571-1-gilles.doffe@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712124522.571-1-gilles.doffe@savoirfairelinux.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:53:35 up 55 days, 20:11, 52 users,  load average: 0.12, 0.08,
 0.10
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-07-12 14:45, Gilles DOFFE wrote:
> The pca9535 gpio expander is present on the Rex baseboard, but missing
> from the dtsi.
> 
> Add the new gpio controller and the associated interrupt line
> MX6QDL_PAD_NANDF_CS3__GPIO6_IO16.
> 
> Signed-off-by: Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
> ---
>  arch/arm/boot/dts/imx6qdl-rex.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6qdl-rex.dtsi
> index 97f1659144ea..d5324c6761c1 100644
> --- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
> @@ -136,6 +136,19 @@
>  		compatible = "atmel,24c02";
>  		reg = <0x57>;
>  	};
> +
> +	gpio8: pca9535@27 {

Just a nitpick, I would change that to

	pca9535: gpio8@27 {

Regards,
  Marco

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
>  };
>  
>  &i2c3 {
> @@ -237,6 +250,12 @@
>  			>;
>  		};
>  
> +		pinctrl_pca9535: pca9535 {
> +			fsl,pins = <
> +				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x00017059
> +		   >;
> +		};
> +
>  		pinctrl_uart1: uart1grp {
>  			fsl,pins = <
>  				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
> -- 
> 2.19.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
