Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5920FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371B920856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfJ3I11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:27:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53817 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfJ3I10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:27:26 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iPjK5-0003re-9e; Wed, 30 Oct 2019 09:27:21 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iPjK2-00007C-A9; Wed, 30 Oct 2019 09:27:18 +0100
Date:   Wed, 30 Oct 2019 09:27:18 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Joris Offouga <offougajoris@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V3] ARM: dts: imx7d-pico: Add LCD support
Message-ID: <20191030082718.oj4nq5li6mohf4tg@pengutronix.de>
References: <20191029101742.9100-1-offougajoris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029101742.9100-1-offougajoris@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:20:03 up 165 days, 14:38, 98 users,  load average: 0.09, 0.06,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joris,

On 19-10-29 11:17, Joris Offouga wrote:
> From: Fabio Estevam <festevam@gmail.com>
> 
> Add support for the VXT VL050-8048NT-C01 panel connected through
> the 24 bit parallel LCDIF interface.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> Signed-off-by: Joris Offouga <offougajoris@gmail.com>
> ---
>  Changes v2 -> v3 
> 	rename pintcrl_backlight to pinctrl_pwm4
> 	sort the nodes alphabetical
> 
>  Changes v1 -> v2
>  	change "From:" Joris Offouga to Fabio Estevam
> 	set Joris Offouga signed-off to the last one
> 
>  arch/arm/boot/dts/imx7d-pico.dtsi | 82 +++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
> index 6f50ebf31a0a..9c7c2c45e6aa 100644
> --- a/arch/arm/boot/dts/imx7d-pico.dtsi
> +++ b/arch/arm/boot/dts/imx7d-pico.dtsi
> @@ -7,12 +7,40 @@
>  #include "imx7d.dtsi"
>  
>  / {
> +        backlight: backlight {
> +                compatible = "pwm-backlight";
> +                pwms = <&pwm4 0 50000 0>;
                                         ^
                                   still not needed

> +                brightness-levels = <0 36 72 108 144 180 216 255>;
> +                default-brightness-level = <6>;
> +        };
> +
>  	/* Will be filled by the bootloader */
>  	memory@80000000 {
>  		device_type = "memory";
>  		reg = <0x80000000 0>;
>  	};
>  
> +        panel {
> +                compatible = "vxt,vl050-8048nt-c01";
> +                backlight = <&backlight>;
> +                power-supply = <&reg_lcd_3v3>;
> +
> +                port {
> +                        panel_in: endpoint {
> +                                remote-endpoint = <&display_out>;
> +                        };
> +                };
> +        };
> +
> +	reg_lcd_3v3: regulator-lcd-3v3 {
> +                compatible = "regulator-fixed";
> +                regulator-name = "lcd-3v3";
> +                regulator-min-microvolt = <3300000>;
> +                regulator-max-microvolt = <3300000>;
> +                gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;

Where happens the muxing for this gpio?

> +                enable-active-high;
> +        };
> +
>  	reg_wlreg_on: regulator-wlreg_on {
>  		compatible = "regulator-fixed";
>  		pinctrl-names = "default";
> @@ -230,6 +258,18 @@
>  	};
>  };
>  
> +&lcdif {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lcdif>;
> +	status = "okay";
> +
> +	port {
> +		display_out: endpoint {
> +			remote-endpoint = <&panel_in>;
> +		};
> +	};
> +};
> +
>  &sai1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sai1>;
> @@ -260,6 +300,8 @@
>  };
>  
>  &pwm4 { /* Backlight */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm4>;
>  	status = "okay";
>  };
>  
> @@ -413,6 +455,40 @@
>  		>;
>  	};
>  
> +	pinctrl_lcdif: lcdifgrp {
> +		fsl,pins = <
> +			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
> +			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
> +			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
> +			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
> +			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
> +			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
> +			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
> +			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
> +			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
> +			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
> +			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
> +			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
> +			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
> +			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
> +			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
> +			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
> +			MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
> +			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
> +			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
> +			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
> +			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
> +			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
> +			MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
> +			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
> +			MX7D_PAD_LCD_CLK__LCD_CLK		0x79
> +			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x78
> +			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x78
> +			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x78
> +			MX7D_PAD_LCD_RESET__GPIO3_IO4		0x14
> +		>;
> +	};
> +
>  	pinctrl_pwm1: pwm1 {
>  		fsl,pins = <
>  			MX7D_PAD_GPIO1_IO08__PWM1_OUT   0x7f
> @@ -431,6 +507,12 @@
>  		>;
>  	};
>  
> +	pinctrl_pwm4: pwm4grp{
> +		fsl,pins = <
> +			MX7D_PAD_GPIO1_IO11__PWM4_OUT	0x0
                                                         ^
                                         Is this muxing value valid?

Regards,
  Marco

> +		>;
> +	};
> +
>  	pinctrl_reg_wlreg_on: regregongrp {
>  		fsl,pins = <
>  			MX7D_PAD_ECSPI1_SCLK__GPIO4_IO16	0x59
> -- 
> 2.17.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
