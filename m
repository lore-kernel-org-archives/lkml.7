Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5E6CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0914A20640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfJUITu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:19:50 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58115 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfJUITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:19:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iMSuo-0001Aa-1T; Mon, 21 Oct 2019 10:19:46 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iMSun-0008Pf-Bn; Mon, 21 Oct 2019 10:19:45 +0200
Date:   Mon, 21 Oct 2019 10:19:45 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Robert Jones <rjones@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dt: add lsm9ds1 iio imu/magn support to gw553x
Message-ID: <20191021081945.o7knknxacm6uvd3c@pengutronix.de>
References: <20191018232124.4126-1-rjones@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018232124.4126-1-rjones@gateworks.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:16:17 up 156 days, 14:34, 97 users,  load average: 0.07, 0.08,
 0.08
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

same here, don't name it 'ARM: dt: ...' instead name it 'ARM: dts: imx:
ventana: ..' or 'ARM: dts: imx: imx6qdl-gw553x: ..'.

On 19-10-18 16:21, Robert Jones wrote:
> Add one node for the accel/gyro i2c device and another for the separate
> magnetometer device in the lsm9ds1.
> 
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  arch/arm/boot/dts/imx6qdl-gw553x.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
> index a106689..55e6922 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
> @@ -173,6 +173,25 @@
>  	pinctrl-0 = <&pinctrl_i2c2>;
>  	status = "okay";
>  
> +	lsm9ds1_ag@6a {
> +		compatible = "st,lsm9ds1-imu";

Didn't found this compatible string.

> +		reg = <0x6a>;
> +		st,drdy-int-pin = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_acc_gyro>;
> +		interrupt-parent = <&gpio7>;
> +		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	lsm9ds1_m@1c {
> +		compatible = "st,lsm9ds1-magn";
> +		reg = <0x1c>;

Nodes are sorted according their i2c-addresses.

Regards,
  Marco

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_mag>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
> +	};
> +
>  	ltc3676: pmic@3c {
>  		compatible = "lltc,ltc3676";
>  		reg = <0x3c>;
> @@ -462,6 +481,18 @@
>  		>;
>  	};
>  
> +	pinctrl_acc_gyro: acc_gyrogrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_mag: maggrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0
> +		>;
> +	};
> +
>  	pinctrl_pps: ppsgrp {
>  		fsl,pins = <
>  			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
> -- 
> 2.9.2
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
