Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2374C2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVeWjvja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfCLAKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:10:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44680 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfCLAKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:10:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id u9so632156lfe.11;
        Mon, 11 Mar 2019 17:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcpJvllf+R5JJWl9FE7e3xQysTpV1QtPZEXxE6XsZ0E=;
        b=VVeWjvjaLH6G85U8lpr34YjUoigcyZ+Zvc4Z9FtEPLcnFMmqyBSs4xkPIa3S/L1Blf
         khwEbj2Lza93/q5ovQx7ZbfT5qCBj4ZE8j01KKgCaLj8UEF1Pr84bznG6IUIHXF5rM/h
         kvOxFOy6R1tzAnEDew487l0iEShZhLE2zkecIEun82z67KudIqnkWMfVr+BZO4hkbYqI
         JV6bZn8LGpbkOFN4wA9/q4EBbi9GZjEYupdZRXCTfmVhm8zYoeziMHYMvnCSe5W0dF3H
         dk/y+rRgPsEymh6UByV2jGbxxi+leTI29+fCnfVvMYre0Ypcv5A8u237TGU3Y1ocmr6K
         aiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcpJvllf+R5JJWl9FE7e3xQysTpV1QtPZEXxE6XsZ0E=;
        b=anPw/cSB4ag85wacOUpNixnKiOClhOlqKXutplj1KLXiGHzGW9GX96wHMSZ+BC7p40
         TFvIgMwOgqPHn3Lq7GyT50uEVyfK7682l502AU1ugXBM0Zt4u/Rxahn/FxrC429M/VTq
         JQsqGRCPEQngeCu8oMDCJAxQbt57gXHptRWFOu525dY2lfc47f5fOHqvBOxrPBPt3HJN
         eE57JJKCxwVG7pfQ5AZuhhhBFSbfxrN9GvJOyvU7wEyS8MWJ3FFIKZwsEglrUmv0KG8w
         sd8L8B7OCpDdnK7jeQKIE9lGryWYExOHj6Bphv3cmAvokkpTfnxQ9+trNAcJW3P4GLO3
         Fd5A==
X-Gm-Message-State: APjAAAX/TGej/laZQZ7mzQBfmlWgycOQjjaI8Pec81FwCBuj+UOkItIw
        Qk94QKyt3WS8Pws1z15QKBCOzvaj6FcyRRAhWmfCTLp3
X-Google-Smtp-Source: APXvYqy7RSn75qtuvXY8lP1K8xux6N5VDGF3mEgdbOL9C7D6+MAkWXYajrOgQ97/hUt6O+kkeyxlLU/q2KocrA0Hd30=
X-Received: by 2002:ac2:5506:: with SMTP id j6mr18874238lfk.95.1552349397652;
 Mon, 11 Mar 2019 17:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190311234655.30357-1-angus@akkea.ca> <20190311234655.30357-2-angus@akkea.ca>
In-Reply-To: <20190311234655.30357-2-angus@akkea.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 11 Mar 2019 21:10:07 -0300
Message-ID: <CAOMZO5Do+GF-sLO5wHEMR0daUbf4pnrwQby9dtvLXF+4fVC+Xw@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: fsl: librem5: Add a device tree for the
 Librem5 devkit
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 8:47 PM Angus Ainslie (Purism) <angus@akkea.ca> wrote:

> +/ {
> +       model = "Purism Librem 5 devkit 1.0";
> +       compatible = "fsl,librem5-devkit", "fsl,imx8mq";

This board is not manufactured by FSL/NXP, so it should be
"purism,librem5-devkit", "fsl,imx8mq" instead.

You should also add an entry for the purism vendor entry in
Documentation/devicetree/bindings/vendor-prefixes.txt in a separate
patch.

> +
> +       chosen {
> +               stdout-path = &uart1;
> +       };
> +
> +       reg_usdhc2_vmmc: regulator-vsd-3v3 {

The usual format would be:

reg_usdhc2_vmmc: regulator-usdhc2-vmmc {


> +               compatible = "regulator-fixed";
> +               regulator-name = "VSD_3V3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;

Always on? It would be better to pass this regulator inside the mmc node.

> +       };
> +
> +       reg_pwr_en: pwr_en {

reg_pwr_en: regulator-pwr-en {

> +               compatible = "regulator-fixed";
> +               regulator-name = "PWR_EN";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;

Same here. No need for "regulator-always-on" as it is controlled by
the gyroscope.

> +&fec1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_fec1>;
> +       phy-mode = "rgmii-id";
> +       phy-handle = <&ethphy0>;
> +       fsl,magic-packet;
> +       status = "okay";
> +       phy-supply = <&reg_pwr_en>;
> +
> +       mdio {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               ethphy0: ethernet-phy@0 {
> +                       compatible = "ethernet-phy-ieee802.3-c22";
> +                       reg = <1>;

You pass @0 and use reg = <1>, which is a mismatch. Building it with
W=1 would have warned you about this mismatch.

> +                       at803x,led-act-blind-workaround;
> +                       at803x,eee-disabled;
> +                       power-supply = <&reg_pwr_en>;
> +               };
> +       };
> +};
> +
> +&iomuxc {
> +       imx8m-som {

No need for this imx8m-som level.


> +               pinctrl_nc: ncgrp {

Not a very descriptive naming.

> +                       fsl,pins = <
> +                       MX8MQ_IOMUXC_SAI1_MCLK_SAI1_MCLK        0x00
> +                       MX8MQ_IOMUXC_I2C4_SCL_I2C4_SCL          0x4000007f
> +                       MX8MQ_IOMUXC_I2C4_SDA_I2C4_SDA          0x4000007f
> +                       >;
> +               };
> +
> +               pinctrl_up: upgrp {

Same here. Also, this is not used. Please remove it.

> +                       fsl,pins = <
> +                       MX8MQ_IOMUXC_SAI1_TXD2_SAI1_TX_DATA2            0x00
> +                       >;
> +               };
> +
> +               pinctrl_csi1: csi1grp {

This is not used at the moment. Please remove it and re-add it when
CSI gets supported.

> +                       fsl,pins = <
> +                       /* CSI_nRST */
> +                       MX8MQ_IOMUXC_GPIO1_IO06_GPIO1_IO6               0x11
> +                       /* CSI_PWDN */
> +                       MX8MQ_IOMUXC_GPIO1_IO07_GPIO1_IO7               0x19
> +                       /* CLK01 */
> +                       MX8MQ_IOMUXC_GPIO1_IO14_CCMSRCGPCMIX_CLKO1      0x19
> +                       >;
> +               };
> +
> +               pinctrl_pwr_en: pwr_engrp {
> +                       fsl,pins = <
> +                       MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8               0x06
> +                       >;
> +               };
> +
> +               pinctrl_wwan: wwan_grp {

Not used. Please remove this one and all unused pinctrl nodes.

> +&i2c1 {
> +       clock-frequency = <400000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       status = "okay";
> +
> +       pmic: bd71837@4b {

Node names should be generic: pmic@4b

> +       typec_ptn5100: ptn5110@52 {

Same here.

> +       charger: charger@6b { /* bq25896 */
> +               compatible = "ti,bq25890";
> +               reg = <0x6b>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_charger>;
> +               interrupt-parent = <&gpio3>;
> +               interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +               ti,battery-regulation-voltage = <4192000>; // 4.192V
> +               ti,charge-current = <1600000>; // 1.6 A
> +               ti,termination-current = <66000>;  // 66mA
> +               ti,precharge-current = <1300000>; // 1.3A
> +               ti,minimum-sys-voltage = <2750000>; // 2.75V
> +               ti,boost-voltage = <5000000>; // 5V
> +               ti,boost-max-current = <50000>; // 50mA

No // style comments, please/

> +&i2c3 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c3>, <&pinctrl_imu>;
> +       status = "okay";
> +
> +       lsm9d: lsm9d@6a {
> +               compatible = "st,lsm9ds1-gyro";

I don't find this binding.

> +               reg = <0x6a>;
> +               interrupt-parent = <&gpio3>;
> +               interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> +               power-supply = <&reg_pwr_en>;
> +       };
> +};

> +&uart4 { /* BT */
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart4>, <&pinctrl_bt>;
> +       fsl,uart-has-rtscts;

uart-has-rtscts is preferred.

> +       /* resets = <&modem_reset>; */

Please remove this line instead of commenting it out.
