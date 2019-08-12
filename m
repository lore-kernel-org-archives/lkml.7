Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6E6C32756
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892A72070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="moxPWwI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfHLHKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:10:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40920 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfHLHKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:10:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id c34so15333165otb.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BbBNOuxm0GlTjEqeeVl/lvmyNQSZaDpFdxwK3irfmzQ=;
        b=moxPWwI3A6jUYH/PrBqOntD8Bmxn0e3Oco4tFsc55qjv0AyFAJ1tfeufPN0H+uSZPT
         LzYEpdamSmI78Cqkt7kyEOCyfL44ErmNiKNOQNlv0Vf1mn+0r7qhqVXihHLX10GUUrHQ
         EMPtN72DHOch7S96g6Nzhc9hIF4kq6jTamShYSkue+Ux4tibjL6++UiLbr6QIKJ16jL/
         x3MaLml/q9A+hT/IgzZa13xAcTnV5Jf4/W2PPwMifIk9d/DL6G9UPM0xGQHR/qEX6hHI
         Ix40CYpnGfzVygBd7Gmy8mfbcMz8B8PIVQmG47NMZe8iZY2AzaOzwJkY2MEOfqsmZM6L
         jAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BbBNOuxm0GlTjEqeeVl/lvmyNQSZaDpFdxwK3irfmzQ=;
        b=jcx2KoQ6Ty6wWXokMPVLOW3E4+izhggmgVBgOscjKSdeYR64RISDRLNDDAF1hSI0mJ
         xJZke1w/1SIAXbmMoZygQ7Vl62EO4J5uS0SqIFEPUy6YPUVArE6GbS5K4jZyib7NWz8a
         La7OSFcfDK/4+WdWPchIm8zjU44rorLvtBzmieKIPTO67/HN2fWWHYFtqPtzhDgutP/x
         ENdCeTAGxMM/nORShqecjpF1EVI1NysjFEw/FB+bes4IsRv5VN+JAOcBQqvjaFB1S/vj
         dJsa58NdZhrmQvxJsSwnDaUEr6lqP5YKRT+2PbKKmJB6WuCm0pyl6XPj8H/8AK6r2yyB
         M2cA==
X-Gm-Message-State: APjAAAW9SZUjGnwraNQsGHJZ+IdYe10m8ncIjyLdta3xV3UKb2qIOL0p
        zr3SAwZjiIyXKQZbiLiEVR1MWEmwUYb9pAAtlBAXhw==
X-Google-Smtp-Source: APXvYqxDY92kWbEMPW6FL/c2DrwPTOfjP15cg1Ew1dErImjaHvI3+i6H0erQDf8168aYZkY+ePW+vOgODEbBTb2pizI=
X-Received: by 2002:a05:6830:1291:: with SMTP id z17mr29428568otp.194.1565593806632;
 Mon, 12 Aug 2019 00:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190809144043.476786-1-arnd@arndb.de> <20190809144043.476786-6-arnd@arndb.de>
In-Reply-To: <20190809144043.476786-6-arnd@arndb.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 12 Aug 2019 09:09:55 +0200
Message-ID: <CAMpxmJVwsUHmr-89iR8gQG=WN2-z6JxbP1Pxbbcb1DR+zE=98g@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] gpio: lpc32xx: allow building on non-lpc32xx targets
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 9 sie 2019 o 16:43 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
>
> The driver uses hardwire MMIO addresses instead of the data
> that is passed in device tree. Change it over to only
> hardcode the register offset values and allow compile-testing.
>
> Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Tested-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/configs/lpc32xx_defconfig |   1 +
>  drivers/gpio/Kconfig               |   7 ++
>  drivers/gpio/Makefile              |   2 +-
>  drivers/gpio/gpio-lpc32xx.c        | 118 +++++++++++++++++------------
>  4 files changed, 77 insertions(+), 51 deletions(-)
>
> diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32x=
x_defconfig
> index 0cdc6c7974b3..3772d5a8975a 100644
> --- a/arch/arm/configs/lpc32xx_defconfig
> +++ b/arch/arm/configs/lpc32xx_defconfig
> @@ -93,6 +93,7 @@ CONFIG_SERIAL_HS_LPC32XX_CONSOLE=3Dy
>  # CONFIG_HW_RANDOM is not set
>  CONFIG_I2C_CHARDEV=3Dy
>  CONFIG_I2C_PNX=3Dy
> +CONFIG_GPIO_LPC32XX=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_SPI_PL022=3Dy
>  CONFIG_GPIO_SYSFS=3Dy
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index bb13c266c329..8b40a578963c 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -311,6 +311,13 @@ config GPIO_LPC18XX
>           Select this option to enable GPIO driver for
>           NXP LPC18XX/43XX devices.
>
> +config GPIO_LPC32XX
> +       tristate "NXP LPC32XX GPIO support"
> +       depends on OF_GPIO && (ARCH_LPC32XX || COMPILE_TEST)
> +       help
> +         Select this option to enable GPIO driver for
> +         NXP LPC32XX devices.
> +
>  config GPIO_LYNXPOINT
>         tristate "Intel Lynxpoint GPIO support"
>         depends on ACPI && X86
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index a4e91175c708..87d659ae95eb 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -74,7 +74,7 @@ obj-$(CONFIG_GPIO_LP3943)             +=3D gpio-lp3943.=
o
>  obj-$(CONFIG_GPIO_LP873X)              +=3D gpio-lp873x.o
>  obj-$(CONFIG_GPIO_LP87565)             +=3D gpio-lp87565.o
>  obj-$(CONFIG_GPIO_LPC18XX)             +=3D gpio-lpc18xx.o
> -obj-$(CONFIG_ARCH_LPC32XX)             +=3D gpio-lpc32xx.o
> +obj-$(CONFIG_GPIO_LPC32XX)             +=3D gpio-lpc32xx.o
>  obj-$(CONFIG_GPIO_LYNXPOINT)           +=3D gpio-lynxpoint.o
>  obj-$(CONFIG_GPIO_MADERA)              +=3D gpio-madera.o
>  obj-$(CONFIG_GPIO_MAX3191X)            +=3D gpio-max3191x.o
> diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
> index 24885b3db3d5..4e626c4235c2 100644
> --- a/drivers/gpio/gpio-lpc32xx.c
> +++ b/drivers/gpio/gpio-lpc32xx.c
> @@ -16,36 +16,33 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>
> -#include <mach/hardware.h>
> -#include <mach/platform.h>
> -
> -#define LPC32XX_GPIO_P3_INP_STATE              _GPREG(0x000)
> -#define LPC32XX_GPIO_P3_OUTP_SET               _GPREG(0x004)
> -#define LPC32XX_GPIO_P3_OUTP_CLR               _GPREG(0x008)
> -#define LPC32XX_GPIO_P3_OUTP_STATE             _GPREG(0x00C)
> -#define LPC32XX_GPIO_P2_DIR_SET                        _GPREG(0x010)
> -#define LPC32XX_GPIO_P2_DIR_CLR                        _GPREG(0x014)
> -#define LPC32XX_GPIO_P2_DIR_STATE              _GPREG(0x018)
> -#define LPC32XX_GPIO_P2_INP_STATE              _GPREG(0x01C)
> -#define LPC32XX_GPIO_P2_OUTP_SET               _GPREG(0x020)
> -#define LPC32XX_GPIO_P2_OUTP_CLR               _GPREG(0x024)
> -#define LPC32XX_GPIO_P2_MUX_SET                        _GPREG(0x028)
> -#define LPC32XX_GPIO_P2_MUX_CLR                        _GPREG(0x02C)
> -#define LPC32XX_GPIO_P2_MUX_STATE              _GPREG(0x030)
> -#define LPC32XX_GPIO_P0_INP_STATE              _GPREG(0x040)
> -#define LPC32XX_GPIO_P0_OUTP_SET               _GPREG(0x044)
> -#define LPC32XX_GPIO_P0_OUTP_CLR               _GPREG(0x048)
> -#define LPC32XX_GPIO_P0_OUTP_STATE             _GPREG(0x04C)
> -#define LPC32XX_GPIO_P0_DIR_SET                        _GPREG(0x050)
> -#define LPC32XX_GPIO_P0_DIR_CLR                        _GPREG(0x054)
> -#define LPC32XX_GPIO_P0_DIR_STATE              _GPREG(0x058)
> -#define LPC32XX_GPIO_P1_INP_STATE              _GPREG(0x060)
> -#define LPC32XX_GPIO_P1_OUTP_SET               _GPREG(0x064)
> -#define LPC32XX_GPIO_P1_OUTP_CLR               _GPREG(0x068)
> -#define LPC32XX_GPIO_P1_OUTP_STATE             _GPREG(0x06C)
> -#define LPC32XX_GPIO_P1_DIR_SET                        _GPREG(0x070)
> -#define LPC32XX_GPIO_P1_DIR_CLR                        _GPREG(0x074)
> -#define LPC32XX_GPIO_P1_DIR_STATE              _GPREG(0x078)
> +#define LPC32XX_GPIO_P3_INP_STATE              (0x000)
> +#define LPC32XX_GPIO_P3_OUTP_SET               (0x004)
> +#define LPC32XX_GPIO_P3_OUTP_CLR               (0x008)
> +#define LPC32XX_GPIO_P3_OUTP_STATE             (0x00C)
> +#define LPC32XX_GPIO_P2_DIR_SET                        (0x010)
> +#define LPC32XX_GPIO_P2_DIR_CLR                        (0x014)
> +#define LPC32XX_GPIO_P2_DIR_STATE              (0x018)
> +#define LPC32XX_GPIO_P2_INP_STATE              (0x01C)
> +#define LPC32XX_GPIO_P2_OUTP_SET               (0x020)
> +#define LPC32XX_GPIO_P2_OUTP_CLR               (0x024)
> +#define LPC32XX_GPIO_P2_MUX_SET                        (0x028)
> +#define LPC32XX_GPIO_P2_MUX_CLR                        (0x02C)
> +#define LPC32XX_GPIO_P2_MUX_STATE              (0x030)
> +#define LPC32XX_GPIO_P0_INP_STATE              (0x040)
> +#define LPC32XX_GPIO_P0_OUTP_SET               (0x044)
> +#define LPC32XX_GPIO_P0_OUTP_CLR               (0x048)
> +#define LPC32XX_GPIO_P0_OUTP_STATE             (0x04C)
> +#define LPC32XX_GPIO_P0_DIR_SET                        (0x050)
> +#define LPC32XX_GPIO_P0_DIR_CLR                        (0x054)
> +#define LPC32XX_GPIO_P0_DIR_STATE              (0x058)
> +#define LPC32XX_GPIO_P1_INP_STATE              (0x060)
> +#define LPC32XX_GPIO_P1_OUTP_SET               (0x064)
> +#define LPC32XX_GPIO_P1_OUTP_CLR               (0x068)
> +#define LPC32XX_GPIO_P1_OUTP_STATE             (0x06C)
> +#define LPC32XX_GPIO_P1_DIR_SET                        (0x070)
> +#define LPC32XX_GPIO_P1_DIR_CLR                        (0x074)
> +#define LPC32XX_GPIO_P1_DIR_STATE              (0x078)
>
>  #define GPIO012_PIN_TO_BIT(x)                  (1 << (x))
>  #define GPIO3_PIN_TO_BIT(x)                    (1 << ((x) + 25))
> @@ -72,12 +69,12 @@
>  #define LPC32XX_GPO_P3_GRP     (LPC32XX_GPI_P3_GRP + LPC32XX_GPI_P3_MAX)
>
>  struct gpio_regs {
> -       void __iomem *inp_state;
> -       void __iomem *outp_state;
> -       void __iomem *outp_set;
> -       void __iomem *outp_clr;
> -       void __iomem *dir_set;
> -       void __iomem *dir_clr;
> +       unsigned long inp_state;
> +       unsigned long outp_state;
> +       unsigned long outp_set;
> +       unsigned long outp_clr;
> +       unsigned long dir_set;
> +       unsigned long dir_clr;
>  };
>
>  /*
> @@ -165,16 +162,27 @@ static struct gpio_regs gpio_grp_regs_p3 =3D {
>  struct lpc32xx_gpio_chip {
>         struct gpio_chip        chip;
>         struct gpio_regs        *gpio_grp;
> +       void __iomem            *reg_base;
>  };
>
> +static inline u32 gpreg_read(struct lpc32xx_gpio_chip *group, unsigned l=
ong offset)
> +{
> +       return __raw_readl(group->reg_base + offset);
> +}
> +
> +static inline void gpreg_write(struct lpc32xx_gpio_chip *group, u32 val,=
 unsigned long offset)
> +{
> +       __raw_writel(val, group->reg_base + offset);
> +}
> +
>  static void __set_gpio_dir_p012(struct lpc32xx_gpio_chip *group,
>         unsigned pin, int input)
>  {
>         if (input)
> -               __raw_writel(GPIO012_PIN_TO_BIT(pin),
> +               gpreg_write(group, GPIO012_PIN_TO_BIT(pin),
>                         group->gpio_grp->dir_clr);
>         else
> -               __raw_writel(GPIO012_PIN_TO_BIT(pin),
> +               gpreg_write(group, GPIO012_PIN_TO_BIT(pin),
>                         group->gpio_grp->dir_set);
>  }
>
> @@ -184,19 +192,19 @@ static void __set_gpio_dir_p3(struct lpc32xx_gpio_c=
hip *group,
>         u32 u =3D GPIO3_PIN_TO_BIT(pin);
>
>         if (input)
> -               __raw_writel(u, group->gpio_grp->dir_clr);
> +               gpreg_write(group, u, group->gpio_grp->dir_clr);
>         else
> -               __raw_writel(u, group->gpio_grp->dir_set);
> +               gpreg_write(group, u, group->gpio_grp->dir_set);
>  }
>
>  static void __set_gpio_level_p012(struct lpc32xx_gpio_chip *group,
>         unsigned pin, int high)
>  {
>         if (high)
> -               __raw_writel(GPIO012_PIN_TO_BIT(pin),
> +               gpreg_write(group, GPIO012_PIN_TO_BIT(pin),
>                         group->gpio_grp->outp_set);
>         else
> -               __raw_writel(GPIO012_PIN_TO_BIT(pin),
> +               gpreg_write(group, GPIO012_PIN_TO_BIT(pin),
>                         group->gpio_grp->outp_clr);
>  }
>
> @@ -206,31 +214,31 @@ static void __set_gpio_level_p3(struct lpc32xx_gpio=
_chip *group,
>         u32 u =3D GPIO3_PIN_TO_BIT(pin);
>
>         if (high)
> -               __raw_writel(u, group->gpio_grp->outp_set);
> +               gpreg_write(group, u, group->gpio_grp->outp_set);
>         else
> -               __raw_writel(u, group->gpio_grp->outp_clr);
> +               gpreg_write(group, u, group->gpio_grp->outp_clr);
>  }
>
>  static void __set_gpo_level_p3(struct lpc32xx_gpio_chip *group,
>         unsigned pin, int high)
>  {
>         if (high)
> -               __raw_writel(GPO3_PIN_TO_BIT(pin), group->gpio_grp->outp_=
set);
> +               gpreg_write(group, GPO3_PIN_TO_BIT(pin), group->gpio_grp-=
>outp_set);
>         else
> -               __raw_writel(GPO3_PIN_TO_BIT(pin), group->gpio_grp->outp_=
clr);
> +               gpreg_write(group, GPO3_PIN_TO_BIT(pin), group->gpio_grp-=
>outp_clr);
>  }
>
>  static int __get_gpio_state_p012(struct lpc32xx_gpio_chip *group,
>         unsigned pin)
>  {
> -       return GPIO012_PIN_IN_SEL(__raw_readl(group->gpio_grp->inp_state)=
,
> +       return GPIO012_PIN_IN_SEL(gpreg_read(group, group->gpio_grp->inp_=
state),
>                 pin);
>  }
>
>  static int __get_gpio_state_p3(struct lpc32xx_gpio_chip *group,
>         unsigned pin)
>  {
> -       int state =3D __raw_readl(group->gpio_grp->inp_state);
> +       int state =3D gpreg_read(group, group->gpio_grp->inp_state);
>
>         /*
>          * P3 GPIO pin input mapping is not contiguous, GPIOP3-0..4 is ma=
pped
> @@ -242,13 +250,13 @@ static int __get_gpio_state_p3(struct lpc32xx_gpio_=
chip *group,
>  static int __get_gpi_state_p3(struct lpc32xx_gpio_chip *group,
>         unsigned pin)
>  {
> -       return GPI3_PIN_IN_SEL(__raw_readl(group->gpio_grp->inp_state), p=
in);
> +       return GPI3_PIN_IN_SEL(gpreg_read(group, group->gpio_grp->inp_sta=
te), pin);
>  }
>
>  static int __get_gpo_state_p3(struct lpc32xx_gpio_chip *group,
>         unsigned pin)
>  {
> -       return GPO3_PIN_IN_SEL(__raw_readl(group->gpio_grp->outp_state), =
pin);
> +       return GPO3_PIN_IN_SEL(gpreg_read(group, group->gpio_grp->outp_st=
ate), pin);
>  }
>
>  /*
> @@ -497,12 +505,18 @@ static int lpc32xx_of_xlate(struct gpio_chip *gc,
>  static int lpc32xx_gpio_probe(struct platform_device *pdev)
>  {
>         int i;
> +       void __iomem *reg_base;
> +
> +       reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(reg_base))
> +               return PTR_ERR(reg_base);
>
>         for (i =3D 0; i < ARRAY_SIZE(lpc32xx_gpiochip); i++) {
>                 if (pdev->dev.of_node) {
>                         lpc32xx_gpiochip[i].chip.of_xlate =3D lpc32xx_of_=
xlate;
>                         lpc32xx_gpiochip[i].chip.of_gpio_n_cells =3D 3;
>                         lpc32xx_gpiochip[i].chip.of_node =3D pdev->dev.of=
_node;
> +                       lpc32xx_gpiochip[i].reg_base =3D reg_base;
>                 }
>                 devm_gpiochip_add_data(&pdev->dev, &lpc32xx_gpiochip[i].c=
hip,
>                                   &lpc32xx_gpiochip[i]);
> @@ -527,3 +541,7 @@ static struct platform_driver lpc32xx_gpio_driver =3D=
 {
>  };
>
>  module_platform_driver(lpc32xx_gpio_driver);
> +
> +MODULE_AUTHOR("Kevin Wells <kevin.wells@nxp.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("GPIO driver for LPC32xx SoC");
> --
> 2.20.0
>

Applied, thanks!

Bart
