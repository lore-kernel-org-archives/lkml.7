Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E5AC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 15:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C644C2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 15:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAL1t8GE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfEKPeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 11:34:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41279 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbfEKPeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 11:34:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id d8so6138837lfb.8;
        Sat, 11 May 2019 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84JHqpvk8mL81D3Fb9jHkIhre7Vu+1G/dx+IuNvSfMg=;
        b=iAL1t8GEA+dk7GYcG1LU+54t8yl4w0wQKm76b3bbuyLJ5MrZcLPlsMtflOKmMTeUVA
         e5tH/wDZCKzRPhyeyPcIA2C2sANNCtBmvr4BWUF7hRZ/kQQFQlmy07LOJMacc7dCjNb8
         AxLyKSDCThgWiBsI8oBsxkw8xoFmHDYiBHFiIDv7Q09iSboBZ/g95pUuFgCOmVsodfdp
         oO3juzdqxxGYjyN4KlyCXoRuoPsBv9+FPCEij6O2ytwreXvb1O/QbTOp97yJA7X/wGnh
         qIx9/8dP7cCBZIatPcNoglrGyHKyqLSjPvNOyOx+lx6tixI90xRagGbIUFhwb9L+bhZg
         TElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84JHqpvk8mL81D3Fb9jHkIhre7Vu+1G/dx+IuNvSfMg=;
        b=fRDPbduvx2LJOho8Axqojzgps6FllX6UEfy+w4iCkSmp3hbyVMv/kYWfSumz0WO43H
         /fJBBJ3GFQEudT2ojSy8dA6u1FUJYkpnGBr50tMBafHCbi1dESPntLgtZfBWU8/y77jB
         BzVlR/IpzGcttjU04R2dWK0POnup2hLOsylnPye1i59td1FiFDUZJZoYDsKvwNlQGdL2
         OxJMXo7oS66665GoHFahgKDxLZjdfqVwDpH1QkiEGbsmp4XGrAM83TililOXOBnClHTG
         g9Q4WJ7w9CLh26oDbXjhOG6NCSZ91I8KrjjPrImGAAiw5iYdr1PbqXZLmpFpofgBNOnT
         F5fw==
X-Gm-Message-State: APjAAAUBWC4/Rzl5ggrHXLyx/zUGrvS6LfNBZngwt9Ya8JZ/fprw1SUh
        WIdbzf4usfdFdTOluIt/5Jm6//EbSoxDMdD6xxc=
X-Google-Smtp-Source: APXvYqyFSdB83+PvLvyVfaJGlXfF5Y+av+7oJkOt+vmG7S7sVxEQH18eoRtaGwY40fNCPNcELbQvjxou15T0CevLGDo=
X-Received: by 2002:ac2:5621:: with SMTP id b1mr9421588lff.27.1557588854794;
 Sat, 11 May 2019 08:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190501225719.3257-1-angus@akkea.ca> <20190501225719.3257-2-angus@akkea.ca>
In-Reply-To: <20190501225719.3257-2-angus@akkea.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 11 May 2019 12:34:08 -0300
Message-ID: <CAOMZO5APMf+iuJuqXCrMNX0Ud73iANXvEs+Y59iH+g6tuMX++Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] arm64: dts: fsl: librem5: Add a device tree for
 the Librem5 devkit
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angus,

This looks good. Only minor issues:

On Wed, May 1, 2019 at 7:57 PM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -0,0 +1,823 @@
> +/* SPDX-License-Identifier: GPL-2.0+

This should be
// SPDX-License-Identifier: GPL-2.0+

as pointed out by checkpatch.

> +       reg_1v8_p: regulator-1V8-P {

Maybe lowercase instead?

> +       wifi_pwr_en: wifi-en {
> +               compatible = "regulator-fixed";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_wifi_pwr_en>;
> +               regulator-name = "WIFI_EN";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpio = <&gpio3 5 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;

Do you really needs all these regulators to be 'regulator-always-on'?

> +&i2c1 {
> +       clock-frequency = <400000>;

Maybe you could use 100kHz instead in order to avoid the problem
described by the following i.MX8M erratum:

e7805: I2C: When the I2C clock speed is configured for 400 kHz, the
SCL low period violates the I2C spec of 1.3 uS min
https://www.nxp.com/docs/en/errata/IMX8MDQLQ_1N14W.pdf

> +&usdhc2 {
> +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 = <&pinctrl_usdhc2>;
> +       pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +       pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +       bus-width = <4>;
> +       vmmc-supply = <&reg_usdhc2_vmmc>;
> +       power-supply = <&wifi_pwr_en>;
> +

Unneeded blank line.
