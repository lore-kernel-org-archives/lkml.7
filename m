Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4104EC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E29020870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ly3Kf0Vw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfHXV3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 17:29:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46599 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbfHXV3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 17:29:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id z17so11862492otk.13;
        Sat, 24 Aug 2019 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeHDDT5xeUM288NKVamfGsJVmVu1XwAAe3AxKH60utQ=;
        b=Ly3Kf0VwR9LsyZVVa+EOsomX2wAFjqIU390PXXa0DK62nLZ7VpXD9zwowzBPiCUpsU
         7vOQLVMMyyTzHyZrdA/epH1UICSqFzTgv6nLgchp/hjQceNFxDd5l4ctmjrFmwEIrWAq
         5PO2uzSBkIyWPsTzqgmxQKtOaWSasqLiHv4jOIKop84uYrOd/9JSIjQjFCYwiOsFu7eQ
         GG8eqns023jFpz+s1KEungiE53ci+4RT9Ze94r7A3fsaO2lIXr1ev1hUaYLzO30do51e
         vg3UcQc/KEZttKjF53nZpt+yHC5s0sSctlG3CTsj0J3WP1S4++a5z36kxS2aEM8hOOak
         ASNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeHDDT5xeUM288NKVamfGsJVmVu1XwAAe3AxKH60utQ=;
        b=RD5U0WyDc59HdaByi8GjYa1sFTAZfuKOpf4MrAIrdESLwXz81tpCN0SeY9fr6Gg0Fh
         jrvDIb4SXeSM+2pLWrV50yDx0MrrnQmeoF3mU0Mvfib9olchOxN3zNzMAwHag46AKkKQ
         pE44NqpnJwzDsanjuCRoHibJdyrUQr7exTaAW87jk/PgGj0Isu/nEWEikXvs4uXGOx2S
         ckP5oP7S6ej2dBtudbI1mCDT+hFTsQ1w7DeiRYAWhS3OevPnd3rFamqfIREhCotplPdY
         UO0rWDRs8+HESIRG/3YHMvEv52tIzWtFEWk1NMRW+l6b5Z9zh3CG6kUI+1zKr+k/YaTk
         HlDg==
X-Gm-Message-State: APjAAAWcbspCaVHC7UVi2aQGEB/cEPyRfiYOvej67oxm+6OriZUgT7IL
        HGZPEzxaGcbwbA903S+Mw3k9zy1QkxaEyUUQuV42J21I
X-Google-Smtp-Source: APXvYqwZ4LtTbx1t2uEJ3OH/npfUf1S1SQtV0TTY+uuc+2k/bBVJu0K2vv4Zrs3bIWzAMsVuhirsdW09fdbogEOTKAg=
X-Received: by 2002:a9d:1d5:: with SMTP id e79mr9347623ote.98.1566682156724;
 Sat, 24 Aug 2019 14:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <1566633850-9421-1-git-send-email-christianshewitt@gmail.com> <1566633850-9421-4-git-send-email-christianshewitt@gmail.com>
In-Reply-To: <1566633850-9421-4-git-send-email-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 24 Aug 2019 23:29:05 +0200
Message-ID: <CAFBinCC-ncHtni9-Ve1_eQROTrJg0WPkA_rOi1We7T-uSOyYHg@mail.gmail.com>
Subject: Re: [PATCH v2, 3/3] arm64: dts: meson-g12b-ugoos-am6: add initial device-tree
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleg Ivanov <balbes-150@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Sat, Aug 24, 2019 at 10:06 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> The Ugoos AM6 is based on the Amlogic W400 (G12B) reference design using the
> S922X chipset. Hardware specifications:
>
> - 2GB LPDDR4 RAM
> - 16GB eMMC storage
> - 10/100/1000 Base-T Ethernet using External RGMII PHY
> - 802.11 a/b/g/b/ac + BT 5.0 sdio wireless (Ampak 6398S)
> - HDMI 2.0 (4k@60p) video
> - Composite video + 2-channel audio output on 3.5mm jack
> - S/PDIF audio output
> - Aux input
> - 1x USB 3.0
> - 3x USB 2.0
> - 1x micro SD card slot
>
> The device-tree is laregly based on meson-g12b-odroid-n2 but with audio
typo -> largely

[...]
> +       tflash_vdd: regulator-tflash_vdd {
> +               compatible = "regulator-fixed";
> +
> +               regulator-name = "TFLASH_VDD";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               gpio = <&gpio_ao GPIOAO_8 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
do we need regulator-always-on here as well, see [0]?

[...]
> +       usb_pwr_en: regulator-usb_pwr_en {
> +               compatible = "regulator-fixed";
> +               regulator-name = "USB_PWR_EN";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               vin-supply = <&vcc_5v>;
> +
> +               /* Connected to the microUSB port power enable */
> +               gpio = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
the photos I found don't show a micro USB port (but 3x USB A 2.0 and
1x USB A 3.0 - just like you mentioned in the patch description)
does this regulator exist?

[...]
> +&ethmac {
> +       pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +       phy-mode = "rgmii";
> +       phy-handle = <&external_phy>;
> +       amlogic,tx-delay-ns = <2>;
> +};
is the PHY reset GPIO not wired to GPIOZ_15 like on Odroid-N2 and X96 Max?


Martin


[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts?id=dc7f2cb218b5ef65ab3d455a0e62d27e44075203
