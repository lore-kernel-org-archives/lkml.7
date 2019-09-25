Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48DFC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91672217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NW7iTN9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442606AbfIYHcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:32:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42638 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436992AbfIYHcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:32:00 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so11189319iod.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OcISGISiLAwgqYS/Qro6kvOcbr1R12318G5x86CCKOc=;
        b=NW7iTN9h3sJIBBg/73UdpHAIZdxIC19ITbnfT0jXVx3eC/9ieCqAWL+3xghFJ33fp8
         VQCVOaKIqKARzsdS4JKBe3FNvlbmHz9g2FLE7lyW1ugvEGAzavCrZPoMi4+wo6Gd794q
         7CN8zlcX973em5jtopMwP3YHdzAhT0eLCoO6gU0p8xr0L+ckextCm7VcCDDgVRJceLUe
         s70oRTFWRZPrAK6GyIXC3UtDDiK56ULG8qiq2HKI/9HQtf35JErvyzXBnHGcWivdohG6
         ppbZoGaaYucx5+w4IIVz/786VW/vpIoPIAK25qvEBJdULlCpBsuqj6VQUNucsuIozJFA
         LyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OcISGISiLAwgqYS/Qro6kvOcbr1R12318G5x86CCKOc=;
        b=RvWH4tAWEa9AcuymMamTP4r0HewKylxXJqolWFVrGzLMOQZoQjF/KZrzzY/GwGzNIE
         QzB4nukbwmxe2ZTCzQ3FS2EDnz7vtGgDFb35l7mMaL6/s6NgTtfUdw3ZT0WZG9hqSYyO
         9oxiX9vuFd/HQpIaEBL4km1+PwDAwK6mByEVaguFw32ymufqzXDsfjfZPczc1a8Dxn3m
         aBKG5Ajg87M6Azu0Hd/9Ukm/Y5pSSB9qzTFyOolSlkeF0sgnb2umpaThMt+qfTl9ayl2
         eLuO6GpfAyGheaFVrKytVTgdBg6I2XNeUZHebmt4qiwpbB2N9CRXM0zDXymmmN3C3sNx
         I8Cg==
X-Gm-Message-State: APjAAAWAI90xfjpBxrMgggXoBl7DQ4CC3IA4vZuid5FRDKEnEoK30vqr
        pyk6qzYvp+qFm4YRv14tmqDJkxUh5wpizOhfPk6m7g==
X-Google-Smtp-Source: APXvYqxj9HCfBAYV5R2sWO3zhuIX4JIqSjWFPOrQ6/gSnAqJNbRo8iYb4UNAehnrQEIOB6sDcuCKeLiOWPzar3Bxg3U=
X-Received: by 2002:a6b:fc04:: with SMTP id r4mr8301437ioh.189.1569396717609;
 Wed, 25 Sep 2019 00:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <1569352021-6383-1-git-send-email-hongweiz@ami.com>
In-Reply-To: <1569352021-6383-1-git-send-email-hongweiz@ami.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 25 Sep 2019 09:31:46 +0200
Message-ID: <CAMRc=MecTmtpauqTsdEmZipeDOHoCMAXx6X6Z4zjszr9_W-aeA@mail.gmail.com>
Subject: Re: [v1, 1/1] gpio: dts: aspeed: Add SGPIO driver
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 24 wrz 2019 o 21:07 Hongwei Zhang <hongweiz@ami.com> napisa=C5=82(a):
>
> Add SGPIO driver support for Aspeed AST2500 SoC.
>
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> ---
>  arch/arm/Kconfig                 |  2 ++
>  arch/arm/boot/dts/aspeed-g5.dtsi | 16 +++++++++++++++-
>  drivers/gpio/Kconfig             |  8 ++++++++
>  drivers/gpio/Makefile            |  1 +
>  4 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2436021..c9f08ab 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1460,6 +1460,8 @@ config ARCH_NR_GPIO
>         default 416 if ARCH_SUNXI
>         default 392 if ARCH_U8500
>         default 352 if ARCH_VT8500
> +       default 312 if MACH_ASPEED_G5
> +       default 304 if MACH_ASPEED_G4
>         default 288 if ARCH_ROCKCHIP
>         default 264 if MACH_H4700
>         default 0
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-=
g5.dtsi
> index 00f05bd..85da7ea 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -311,7 +311,7 @@
>                                 #gpio-cells =3D <2>;
>                                 gpio-controller;
>                                 compatible =3D "aspeed,ast2500-gpio";
> -                               reg =3D <0x1e780000 0x1000>;
> +                               reg =3D <0x1e780000 0x200>;
>                                 interrupts =3D <20>;
>                                 gpio-ranges =3D <&pinctrl 0 0 232>;
>                                 clocks =3D <&syscon ASPEED_CLK_APB>;
> @@ -319,6 +319,20 @@
>                                 #interrupt-cells =3D <2>;
>                         };
>
> +                       sgpio: sgpio@1e780200 {
> +                               #gpio-cells =3D <2>;
> +                               compatible =3D "aspeed,ast2500-sgpio";
> +                               gpio-controller;
> +                               interrupts =3D <40>;
> +                               reg =3D <0x1e780200 0x0100>;
> +                               clocks =3D <&syscon ASPEED_CLK_APB>;
> +                               interrupt-controller;
> +                               ngpios =3D <8>;
> +                               bus-frequency =3D <12000000>;
> +                               pinctrl-names =3D "default";
> +                               pinctrl-0 =3D <&pinctrl_sgpm_default>;
> +                       };
> +
>                         rtc: rtc@1e781000 {
>                                 compatible =3D "aspeed,ast2500-rtc";
>                                 reg =3D <0x1e781000 0x18>;
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index bb13c26..e94f903 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -120,6 +120,14 @@ config GPIO_ASPEED
>         help
>           Say Y here to support Aspeed AST2400 and AST2500 GPIO controlle=
rs.
>
> +config SGPIO_ASPEED
> +       bool "Aspeed SGPIO support"
> +       depends on (ARCH_ASPEED || COMPILE_TEST) && OF_GPIO
> +       select GPIO_GENERIC
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Say Y here to support Aspeed AST2500 SGPIO functionality.
> +
>  config GPIO_ATH79
>         tristate "Atheros AR71XX/AR724X/AR913X GPIO support"
>         default y if ATH79
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index a4e9117..bebbd82 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_GPIO_AMD_FCH)            +=3D gpio-amd-fch=
.o
>  obj-$(CONFIG_GPIO_AMDPT)               +=3D gpio-amdpt.o
>  obj-$(CONFIG_GPIO_ARIZONA)             +=3D gpio-arizona.o
>  obj-$(CONFIG_GPIO_ASPEED)              +=3D gpio-aspeed.o
> +obj-$(CONFIG_SGPIO_ASPEED)             +=3D sgpio-aspeed.o
>  obj-$(CONFIG_GPIO_ATH79)               +=3D gpio-ath79.o
>  obj-$(CONFIG_GPIO_BCM_KONA)            +=3D gpio-bcm-kona.o
>  obj-$(CONFIG_GPIO_BD70528)             +=3D gpio-bd70528.o
> --
> 2.7.4
>

This should be split into separate patches with one extending the
binding document and one adding actual support.

Bart
