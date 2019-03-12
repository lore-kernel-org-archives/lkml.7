Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0699C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85841206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwFxJFF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfCLSrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:47:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41177 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCLSrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:47:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id p1so3866392wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tW+a+WQiO8aD0/GYX1+l5ilbDGCWc/RWd+z78VLylck=;
        b=kwFxJFF3UsgVLp55DexWgKD5wwcUMn9iXEcT5USa2+5ORnPmMjA2rAnchrXwwmmVGT
         ILbBwGeSXp/XwcCn512gNwt4sDrHkKcZF9ggqMggxG2ptkmo+3x7bleijMEUFjjQtAEp
         wUrXN7zWmhFP7SlAcbrvmhvXBMFzQZvOOF7FAn6zaYoJjgLQAUCQy4DqUiKNpbvW7DJ+
         KzPeB/yKN6RzrRySCWHpL0ZW6GXQI4fy5e9uWQjpyHtVtWoAtI0F8QufzTmrosZzp6a4
         NyeB9uvNDcfy3XWHJ4QQkeMexHvDz2RrBWGSJaG+AMepeKicbMwinJu/SYFwsyVdydLU
         Jh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tW+a+WQiO8aD0/GYX1+l5ilbDGCWc/RWd+z78VLylck=;
        b=IIJ8sVIQhaM3n3lSKrBvCarKUDUL48J7hNSsSeJ5Dyy5uJJlxmHSw96JMVOWLyADs1
         wtCGsFtxmFE9beq39MYcnZL4tUyB/Slq9hlolcWUXDhxLg7/8BCq4D6vNzFPKsiIxRLJ
         VX8kDaw7ah9Lb0T9dDQlbCZWbFq+MJOGkWK0crFJ1J6J1P4mPxUGQJHubd44CCYFtE+b
         AiNSLp2KI10Oq6mCX7DYDuQDNiflkeVLR1EjWABzAyHebPXPyR7yIxO1d2A9yKdxwxVv
         7r35jEdeOV8OIkQL91euPnCnN2geyGVI092CcAttLysba7eWtQWa49Vcp2QmhlvQv/KA
         GnNw==
X-Gm-Message-State: APjAAAVWMmg14RKH7ZkCd48waOu0seAIZ+VhEmqYc6VMG1LWO2byxnhH
        C0GYZbv7hnbziXq9yyNfkCoquFTL0ywGJf2GL0M=
X-Google-Smtp-Source: APXvYqxe18D7UYej2zAeYSRLS4ZW65R0gZpKcrRl33BbjYOhwzPV4RpCfQWgcbdvRZgtSyvcaMVEmfbKb5020IJCciY=
X-Received: by 2002:a5d:4110:: with SMTP id l16mr5276818wrp.129.1552416464456;
 Tue, 12 Mar 2019 11:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190311184928.25988-1-andrew.smirnov@gmail.com> <CAOMZO5DwA0jgfwOgvgWUq1j9qFQUTHz+SVcD3oPdUhkwAfG=GQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DwA0jgfwOgvgWUq1j9qFQUTHz+SVcD3oPdUhkwAfG=GQ@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 12 Mar 2019 11:47:33 -0700
Message-ID: <CAHQ1cqGhDVgjV+YBZg3OxVNtxried1_wx8K9WVj-8dVpDum8ZA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII SPB4 board
To:     Fabio Estevam <festevam@gmail.com>
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

On Tue, Mar 12, 2019 at 6:20 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Mon, Mar 11, 2019 at 3:49 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index f4f5aeaf3298..035ad9fc49f3 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -607,7 +607,8 @@ dtb-$(CONFIG_SOC_VF610) += \
> >         vf610-zii-dev-rev-c.dtb \
> >         vf610-zii-scu4-aib.dtb \
> >         vf610-zii-ssmb-dtu.dtb \
> > -       vf610-zii-ssmb-spu3.dtb
> > +       vf610-zii-ssmb-spu3.dtb \
> > +       vf610-zii-spb4.dtb
>
> Please keep it in alphabetical order.
>

OK, will do.

> > +       gpio-leds {
> > +               compatible = "gpio-leds";
> > +               pinctrl-0 = <&pinctrl_leds_debug>;
> > +               pinctrl-names = "default";
> > +
> > +               led-debug {
> > +                       label = "zii:green:debug1";
> > +                       gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
> > +                       linux,default-trigger = "heartbeat";
> > +                       max-brightness = <1>;
>
> This is an invalid property for gpio-leds. It is used for leds pwm
> only. Please remove it.
>

OK, will do.

> > +               };
> > +       };
> > +
> > +       reg_vcc_3v3_mcu: regulator {
>
> reg_vcc_3v3_mcu: regulator-vcc-3v3-mcu  {
>

Will do.

> > +&dspi1 {
> > +       bus-num = <1>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_dspi1>;
> > +       status = "okay";
> > +
> > +       m25p128@0 {
>
> Node names should be generic:
>
> spi-nor@0
>

OK, will do. Although, "flash" seem to be more popular in ZII files
(used by RDU1 and RDU2), so I am inclined to use that instead, if you
don't mind.

> > +&i2c0 {
> > +       clock-frequency = <100000>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_i2c0>;
> > +       status = "okay";
> > +
> > +       gpio6: pca9505@22 {
>
> io-expander@22
>

Will do.

> > +               compatible = "nxp,pca9554";
> > +               reg = <0x22>;
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +       };
> > +
> > +       at24c04@50 {
>
> eeprom@50
>

Will do.

> > +               compatible = "atmel,24c04";
> > +               reg = <0x50>;
> > +               label = "nameplate";
> > +       };
> > +
> > +       at24c04@52 {
>
> eeprom@52


Will do.

I am sure you've noticed that already, but just in case you didn't,
all of the non-generic names actually came from DTS for SPU3, so it
looks like we missed that when that file was upstreamed.

Thanks,
Andrey Smirnov
