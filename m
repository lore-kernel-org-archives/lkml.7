Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57B0C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B0D2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564232286;
	bh=yepKNS9lc4wwR7GUmmyuQ8RKSHODrEDrJwGeYZ1bvkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ABdIb91KyaC/8ZMw12OHOKcspCYWky3PkCSi2EgXSKE4xi+LyYzg7zcjzG9kvFH79
	 0XBUsiC+lCWInEk2mH/savg9Ziyb1/2ngqUCq6mukW6mDedBBisd+ye2pBA8HeOwIk
	 7wSaHZEdxeAEDdUQfI4SzOGr9UZPFZFkaCMeGFxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbfG0M6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 08:58:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34455 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbfG0M6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 08:58:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so39776635wmd.1;
        Sat, 27 Jul 2019 05:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yuT/hglJeQK1J4nRZbzbYMdV0GZGrTOn1crG/aogOjo=;
        b=KinBUzVk4Ol62qB6bOd3MLWEIg/sogi0VfBK0LpkXL+c56gVeTaQ1sd6fi0ULjpH+U
         Wl8siMbPHGiW+Ks2E4gLamP05rXHBdnYzPyWuCk8v59PFEz8xyoHO+nWs+AIRKamr2un
         Eej32QtFVa+8baONRmG2QyOsH7gBEn5WIeORWk622vz+CyVglV1pFv4Vqt7wW6myyIop
         smOLM3YLb3MvXVMWVjTNbyo0wDINYjCNWouIEfxJOK032A0E1McxNINjjxRhavOMT61V
         hRdi2CtFt7TDJXRCdYsakNuiGdZ2yr9DgW2ZTNv2JZ5q2nOgPQYx7uXnto6eHhePoQRV
         Qi6g==
X-Gm-Message-State: APjAAAWTuDuDcCSeJWJaGpTKSZMNafak1BIONAkfb2uQu65MJe1oFWnV
        i6Y7JqpcCSJH0qKUy4+SQ3o=
X-Google-Smtp-Source: APXvYqz38Nf2fk0FktWCXHAAwXHsasNBsHe0MvvFBhth9CAgwqVF0lpDciMlG1FTvAkbpg1pBL0fmQ==
X-Received: by 2002:a1c:a481:: with SMTP id n123mr84460454wme.123.1564232281278;
        Sat, 27 Jul 2019 05:58:01 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id t6sm61711574wmb.29.2019.07.27.05.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jul 2019 05:58:00 -0700 (PDT)
Date:   Sat, 27 Jul 2019 14:57:58 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v2 2/2] ARM: dts: imx6ul-kontron-n6310: Add Kontron
 i.MX6UL N6310 SoM and boards
Message-ID: <20190727125758.GA7674@kozik-lap>
References: <20190726061705.14764-1-krzk@kernel.org>
 <20190726061705.14764-2-krzk@kernel.org>
 <CAOMZO5BPT5Bj+gbgsq+bW5x_NToWqUtz8vmOOS9LyZg5J+CfHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOMZO5BPT5Bj+gbgsq+bW5x_NToWqUtz8vmOOS9LyZg5J+CfHQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 02:54:20PM -0300, Fabio Estevam wrote:
> Hi Krzysztof,
> 
> On Fri, Jul 26, 2019 at 3:17 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 7294ac36f4c0..afb61a55e26f 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -161,6 +161,10 @@ properties:
> >          items:
> >            - enum:
> >                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
> > +              - kontron,n6310-som         # Kontron N6310 SOM
> > +              - kontron,n6310-s           # Kontron N6310 S Board
> > +              - kontron,n6310-s-43        # Kontron N6310 S 43 Board
> > +              - kontron,n6310-s-50        # Kontron N6310 S 50 Board
> 
> These entries should be:
>        imx6ul-kontron-n6310-s.dtb
>        imx6ul-kontron-n6310-s-43.dtb
>        imx6ul-kontron-n6310-s-50.dtb

OK

(I'll apply all your suggestions without and just reply here where there
is some discussion)

> 
> > +       panel {
> > +               compatible = "admatec,t043c004800272t2a";
> 
> I do not find this binding documented.

Because they are not... I mentioned it in commit msg - there are no
driver and bindings for them. I put them for completness of HW
description.

> 
> > +&i2c4 {
> > +       gt911@5d {
> 
> Node names should be generic according to the devicetree spec, so:
> 
> touchscreen@5d
> 
> > +               compatible = "goodix,gt928";
> > +               reg = <0x5d>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_cap_touch>;
> > +               interrupt-parent = <&gpio5>;
> > +               interrupts = <6 8>;
> 
> It would be better to use a laber to indicate the irq type:
> 
> interrupts = <6 IRQ_TYPE_LEVEL_LOW>;

Indeed.

> 
> > +               reset-gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
> > +               irq-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
> 
> Active high?
> 
> Above you use "interrupts = <6 8>;" which means IRQ_TYPE_LEVEL_LOW.

Yes, it is confusing but it looks correct. The driver does not use the
GPIO flag so ACTIVE_HIGH or any other setting does not have effect.
Driver uses this pin (as active high) after disabling the interrupts as
an additional reset pin during resume. After this additional reset, it
serves back as interrupt pin.

> 
> > +       };
> > +};
> > +
> > +&iomuxc {
> 
> We tend to prefer putting iomuxc as the last node.
> 
> > +       pinctrl_lcdif_dat: lcdifdatgrp {
> > +               fsl,pins = <
> > +                       MX6UL_PAD_LCD_DATA00__LCDIF_DATA00      0x79
> > +                       MX6UL_PAD_LCD_DATA01__LCDIF_DATA01      0x79
> > +                       MX6UL_PAD_LCD_DATA02__LCDIF_DATA02      0x79
> > +                       MX6UL_PAD_LCD_DATA03__LCDIF_DATA03      0x79
> > +                       MX6UL_PAD_LCD_DATA04__LCDIF_DATA04      0x79
> > +                       MX6UL_PAD_LCD_DATA05__LCDIF_DATA05      0x79
> > +                       MX6UL_PAD_LCD_DATA06__LCDIF_DATA06      0x79
> > +                       MX6UL_PAD_LCD_DATA07__LCDIF_DATA07      0x79
> > +                       MX6UL_PAD_LCD_DATA08__LCDIF_DATA08      0x79
> > +                       MX6UL_PAD_LCD_DATA09__LCDIF_DATA09      0x79
> > +                       MX6UL_PAD_LCD_DATA10__LCDIF_DATA10      0x79
> > +                       MX6UL_PAD_LCD_DATA11__LCDIF_DATA11      0x79
> > +                       MX6UL_PAD_LCD_DATA12__LCDIF_DATA12      0x79
> > +                       MX6UL_PAD_LCD_DATA13__LCDIF_DATA13      0x79
> > +                       MX6UL_PAD_LCD_DATA14__LCDIF_DATA14      0x79
> > +                       MX6UL_PAD_LCD_DATA15__LCDIF_DATA15      0x79
> > +                       MX6UL_PAD_LCD_DATA16__LCDIF_DATA16      0x79
> > +                       MX6UL_PAD_LCD_DATA17__LCDIF_DATA17      0x79
> > +                       MX6UL_PAD_LCD_DATA18__LCDIF_DATA18      0x79
> > +                       MX6UL_PAD_LCD_DATA19__LCDIF_DATA19      0x79
> > +                       MX6UL_PAD_LCD_DATA20__LCDIF_DATA20      0x79
> > +                       MX6UL_PAD_LCD_DATA21__LCDIF_DATA21      0x79
> > +                       MX6UL_PAD_LCD_DATA22__LCDIF_DATA22      0x79
> > +                       MX6UL_PAD_LCD_DATA23__LCDIF_DATA23      0x79
> > +               >;
> > +       };
> > +
> > +       pinctrl_lcdif_ctrl: lcdifctrlgrp {
> > +               fsl,pins = <
> > +                       MX6UL_PAD_LCD_CLK__LCDIF_CLK            0x79
> > +                       MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE      0x79
> > +                       MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC        0x79
> > +                       MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC        0x79
> > +                       MX6UL_PAD_LCD_RESET__LCDIF_RESET        0x79
> > +               >;
> > +       };
> > +
> > +       pinctrl_cap_touch: captouchgrp {
> > +               fsl,pins = <
> > +                       MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06      0x1b0b0 /* Touch Interrupt */
> > +                       MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07      0x1b0b0 /* Touch Reset */
> > +                       MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08      0x1b0b0 /* Touch Wake */
> > +               >;
> > +       };
> > +
> > +       pinctrl_pwm7: pwm7grp {
> > +               fsl,pins = <
> > +                       MX6UL_PAD_CSI_VSYNC__PWM7_OUT           0x110b0
> > +               >;
> > +       };
> > +};
> > +
> > +&lcdif {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_lcdif_dat
> > +                    &pinctrl_lcdif_ctrl>;
> 
> Could fit into a single line.
> 
> > +       panel {
> > +               compatible = "admatec,t070p133t0s301";
> 
> Same here. Undocumented binding.
> 
> > +               backlight = <&backlight>;
> > +
> > +               port {
> > +                       panel_in: endpoint {
> > +                               remote-endpoint = <&display_out>;
> > +                       };
> > +               };
> > +       };
> > +};
> > +
> > +&i2c4 {
> > +       gt911@5d {
> 
> Same comments as previously apply.
> 
> > +
> > +       regulators {
> 
> No need to have this regulators indent level.
> 
> > +               reg_3v3: regulator1 {
> 
> You can place this one directly. The preferred format is:
> 
> reg_3v3: regulator-reg-3v3 {
> 
> > +&ecspi1 {
> > +       fsl,spi-num-chipselects = <1>;
> 
> This property is obsoleted. Please remove it.
> 
> > +       cs-gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_ecspi1>;
> > +       status = "okay";
> > +
> > +       fram@0 {
> 
> Generic name please. eeprom@0
> 
> > +               compatible = "atmel,at25";
> 
> Please use the recommended compatible scheme as per
> Documentation/devicetree/bindings/eeprom/at25.txt.
> 
> > +               reg = <0>;
> > +               spi-max-frequency = <20000000>;
> > +               spi-cpha;
> > +               spi-cpol;
> > +               pagesize = <1>;
> > +               size = <8192>;
> > +               address-width = <16>;
> > +       };
> > +};
> 
> 
> > +&usbotg1 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_usbotg1>;
> > +       dr_mode = "otg";
> > +       status = "okay";
> 
> We prefer to put the 'status' property as the last one.
> 
> > +       srp-disable;
> > +       hnp-disable;
> > +       adp-disable;
> > +       vbus-supply = <&reg_usb_otg1_vbus>;
> > +};
> 
> > +/ {
> > +       model = "Kontron N6310 SOM";
> > +       compatible = "kontron,n6310-som", "fsl,imx6ul";
> > +
> > +       memory@80000000 {
> 
> device_type = "memory"; is missing here.
> 
> > +               reg = <0x80000000 0x10000000>;
> > +       };
> > +};
> > +
> > +&cpu0 {
> > +       clock-frequency = <528000000>;
> 
> Is this one really needed?

I'll check.

> 
> > +&ecspi2 {
> > +       cs-gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_ecspi2>;
> > +       status = "okay";
> > +
> > +       flash: mx25v80@0 {
> 
> spi-flash@0
> 
> > +&qspi {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_qspi>;
> > +       status = "okay";
> > +
> > +       flash0: w25m02gv@0 {
> 
> generic name, please.

Thanks for review!

Best regards,
Krzysztof

