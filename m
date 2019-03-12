Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0853C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED0C214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDLEU3/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCLNUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:20:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37600 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfCLNUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:20:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id u2so2038165lfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtWYEbJXLsy87UXYgvMArLDzIm1avZVAPNT8waxy3kk=;
        b=hDLEU3/6cZOPJEXO9O4NzeCCoSsUsUtcGtaUOfjUa7Nnptu0M32QYtKBQUy3hnW3eb
         A+smyrdkT1zo7C3HQjMfYJV+oRp0tKMrYZ4v39J5OoC/VG7LCw0O2Zd8PwoCKwzZOuvS
         Hl3G6vG0Rn6gL0Gp2YrHKbSQBujY5DNpOkj+wlvQBYjff00GS5BV4/ieIbhhcFlTBK4n
         +IV6+bzZW6DNF1r3+KDlYrIXKxBxFjmIVjNLo7bRkigBObdV48kIfwreM+NVFxmj0qj6
         sQdLlvelWXVNbjYXTfD3V78bVhKMQBTl5lX24wl6J1O9ghTMvuEdK8JhJLYoUSePQLcP
         UqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtWYEbJXLsy87UXYgvMArLDzIm1avZVAPNT8waxy3kk=;
        b=j0LmWzehGZF2wxCxcuwJR4DIrHqdhw9quvq1jgtXMTe5/d0pYnlK4oT0TJkFE16EwU
         IvSg+i+v8dSbB+ORKsUQoXExVhTU2efPBeMVI4oUtvUzhUdzzEDOPVGEVegX0H6SWPs5
         DrYray21VADh2YpG034XbVQly1SWdNJ3+yquPEGjnK12Pq909UioEzwfzXxCh/fkBLG1
         LBEj3m1mg6R0fCkeo+Vyht5/NG2DGf2WbQG0iYE3mBByxHAELo9HF4ElzLXUKk4oZwh4
         s2tNuAUtxxcsWs116TMPSsWSQSZTOID8DZ35bsCAVT2ssEzGeUyRgFrVeT3fS/dZ+lGK
         e2ag==
X-Gm-Message-State: APjAAAViehFPd0c2haiLnVCOrjpfuQ5UjK46NNc9NJ5afmoSe9j0X8Bj
        QGJ79jT5VOQfOzfdh+Va7GBaBY2wAVMqH8/tGYs=
X-Google-Smtp-Source: APXvYqxm1hOjJ1mSyv7V6Osu1B7XlMkYN7WTosH8sOccAftZfirbpvwcIb9D8/IemNSVg+FiRuaAzITlOdbRtHvLC+E=
X-Received: by 2002:ac2:4219:: with SMTP id y25mr15250023lfh.130.1552396799267;
 Tue, 12 Mar 2019 06:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190311184928.25988-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190311184928.25988-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 12 Mar 2019 10:20:10 -0300
Message-ID: <CAOMZO5DwA0jgfwOgvgWUq1j9qFQUTHz+SVcD3oPdUhkwAfG=GQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII SPB4 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Mon, Mar 11, 2019 at 3:49 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f4f5aeaf3298..035ad9fc49f3 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -607,7 +607,8 @@ dtb-$(CONFIG_SOC_VF610) += \
>         vf610-zii-dev-rev-c.dtb \
>         vf610-zii-scu4-aib.dtb \
>         vf610-zii-ssmb-dtu.dtb \
> -       vf610-zii-ssmb-spu3.dtb
> +       vf610-zii-ssmb-spu3.dtb \
> +       vf610-zii-spb4.dtb

Please keep it in alphabetical order.

> +       gpio-leds {
> +               compatible = "gpio-leds";
> +               pinctrl-0 = <&pinctrl_leds_debug>;
> +               pinctrl-names = "default";
> +
> +               led-debug {
> +                       label = "zii:green:debug1";
> +                       gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "heartbeat";
> +                       max-brightness = <1>;

This is an invalid property for gpio-leds. It is used for leds pwm
only. Please remove it.

> +               };
> +       };
> +
> +       reg_vcc_3v3_mcu: regulator {

reg_vcc_3v3_mcu: regulator-vcc-3v3-mcu  {

> +&dspi1 {
> +       bus-num = <1>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_dspi1>;
> +       status = "okay";
> +
> +       m25p128@0 {

Node names should be generic:

spi-nor@0

> +&i2c0 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c0>;
> +       status = "okay";
> +
> +       gpio6: pca9505@22 {

io-expander@22

> +               compatible = "nxp,pca9554";
> +               reg = <0x22>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +
> +       at24c04@50 {

eeprom@50

> +               compatible = "atmel,24c04";
> +               reg = <0x50>;
> +               label = "nameplate";
> +       };
> +
> +       at24c04@52 {

eeprom@52
