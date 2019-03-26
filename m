Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFD6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C386D20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="npiKpOw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfCZImm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:42:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38354 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731215AbfCZImm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:42:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id e80so10721735ote.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yyueg/5QPXEDA9Qx/Y/hTBw+uzxv2uAz7UQTh0sClhI=;
        b=npiKpOw0ev2Jaf1C7z/YO6iJiAw0JsGdWToCU+49GP4nFmbbo3bNjUuysGd2MghT/G
         ahaxlb83omZE+A/b4vjhrp0C+bbp0FLeotO0xNj0NnvI7Sht039vDLwiOtXlRaZhMbf6
         kOzIh5y8wYmTzk31PSQ4XXUaj9oMWFYlPnfCi2jKc0SHeD0Df/9Vi3FRCb3BvflQE9oX
         sfYWsrlx76jnSM6KOaLtCNbzbpkemXiq4zeorOiYVzUMShtHqYONQptfQkV2MhN9Ku12
         fKPOlimL7Fddec8m71aB0Ml76gK46rHGuXC0XdCCYoIecce/0QdkRHF3/yMDobM5ZOEA
         jDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yyueg/5QPXEDA9Qx/Y/hTBw+uzxv2uAz7UQTh0sClhI=;
        b=LT3sKt7Os3DZkaWbi/CTrzJM6DnCSktvRiCc1MJ9ZLvuFOkuWv+0JR0gE9Pz4ogJ0M
         BNqiUU2xw+gMolhAlFoKyXvQ0/YGIXtF/+Z4doYEwihHUTC3UOIwUPKmOhy9jMXmMuF5
         WxE6RDy0uRNpx/XdgcCui9RiawYm25d/5gEV15SXOf4y6/xjBNgNEwW8KpoufckKN+f/
         GqEv+YiyrEygk2FvHCrXaVhzMJC2XYa+qsanAwDTEf4IgWgkUegHaaiAlMGg2hczI+Xa
         J85mDBApr1jbmUnhOpKayza7X1O4DNRwQZpsfNVWFTxWJsjPbDElxE1pNY56Xf7OhELN
         lZMw==
X-Gm-Message-State: APjAAAXlU/MCZJMEwsr17lBtFT7IIzXgu8N8aAovB/HgAUnSQOA/P0po
        yJVRACS2yB0SE4H4hAPjF5j9V9GXedBfcps3xtDBVw==
X-Google-Smtp-Source: APXvYqxZQNW6Hw2v9G9+6dWv0O6uHmLX4hi5rb5sxeqIY7bdWO83bD/N4HTt0VfaWLIGD3H/2By90CStKzigWDKy29A=
X-Received: by 2002:a9d:6ad1:: with SMTP id m17mr20512971otq.108.1553589760744;
 Tue, 26 Mar 2019 01:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553537396.git.sramani@mellanox.com> <3baa6eaf49633014279fcf451abba16304e3e8d1.1553537396.git.sramani@mellanox.com>
In-Reply-To: <3baa6eaf49633014279fcf451abba16304e3e8d1.1553537396.git.sramani@mellanox.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 26 Mar 2019 09:42:29 +0100
Message-ID: <CAMpxmJWEFd6S0ogs5n6kQTJegtznLchPM1=2WnSHeC0QMVo+TQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] gpio: add driver for Mellanox BlueField GPIO controller
To:     Shravan Kumar Ramani <sramani@mellanox.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 25 mar 2019 o 19:30 Shravan Kumar Ramani <sramani@mellanox.com>
napisa=C5=82(a):
>
> This patch adds support for the GPIO controller used by Mellanox
> BlueField SOCs.
>
> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
> ---
>  drivers/gpio/Kconfig      |   7 +++
>  drivers/gpio/Makefile     |   1 +
>  drivers/gpio/gpio-mlxbf.c | 154 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 162 insertions(+)
>  create mode 100644 drivers/gpio/gpio-mlxbf.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 3f50526..0d9ddff 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1316,6 +1316,13 @@ config GPIO_MERRIFIELD
>         help
>           Say Y here to support Intel Merrifield GPIO.
>
> +config GPIO_MLXBF
> +       tristate "Mellanox BlueField SoC GPIO"
> +       depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || COMPILE_TEST
> +       select GPIO_GENERIC
> +       help
> +         Say Y here if you want GPIO support on Mellanox BlueField SoC.
> +
>  config GPIO_ML_IOH
>         tristate "OKI SEMICONDUCTOR ML7213 IOH GPIO support"
>         depends on X86 || COMPILE_TEST
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 54d5527..db8d854 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_GPIO_MENZ127)    +=3D gpio-menz127.o
>  obj-$(CONFIG_GPIO_MERRIFIELD)  +=3D gpio-merrifield.o
>  obj-$(CONFIG_GPIO_MC33880)     +=3D gpio-mc33880.o
>  obj-$(CONFIG_GPIO_MC9S08DZ60)  +=3D gpio-mc9s08dz60.o
> +obj-$(CONFIG_GPIO_MLXBF)       +=3D gpio-mlxbf.o
>  obj-$(CONFIG_GPIO_ML_IOH)      +=3D gpio-ml-ioh.o
>  obj-$(CONFIG_GPIO_MM_LANTIQ)   +=3D gpio-mm-lantiq.o
>  obj-$(CONFIG_GPIO_MOCKUP)      +=3D gpio-mockup.o
> diff --git a/drivers/gpio/gpio-mlxbf.c b/drivers/gpio/gpio-mlxbf.c
> new file mode 100644
> index 0000000..42087c6
> --- /dev/null
> +++ b/drivers/gpio/gpio-mlxbf.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +#include <linux/version.h>
> +
> +/* Number of pins on BlueField */
> +#define MLXBF_GPIO_NR 54
> +
> +/* Pad Electrical Controls. */
> +#define MLXBF_GPIO_PAD_CONTROL_FIRST_WORD 0x0700
> +#define MLXBF_GPIO_PAD_CONTROL_1_FIRST_WORD 0x0708
> +#define MLXBF_GPIO_PAD_CONTROL_2_FIRST_WORD 0x0710
> +#define MLXBF_GPIO_PAD_CONTROL_3_FIRST_WORD 0x0718
> +
> +#define MLXBF_GPIO_PIN_DIR_I 0x1040
> +#define MLXBF_GPIO_PIN_DIR_O 0x1048
> +#define MLXBF_GPIO_PIN_STATE 0x1000
> +#define MLXBF_GPIO_SCRATCHPAD 0x20
> +
> +#ifdef CONFIG_PM
> +struct mlxbf_gpio_context_save_regs {
> +       u64 scratchpad;
> +       u64 pad_control[MLXBF_GPIO_NR];
> +       u64 pin_dir_i;
> +       u64 pin_dir_o;
> +};
> +#endif
> +
> +/* Device state structure. */
> +struct mlxbf_gpio_state {
> +       struct gpio_chip gc;
> +
> +       /* Memory Address */
> +       void __iomem *base;
> +
> +#ifdef CONFIG_PM
> +       struct mlxbf_gpio_context_save_regs csave_regs;
> +#endif
> +};
> +
> +static int mlxbf_gpio_probe(struct platform_device *pdev)
> +{
> +       struct mlxbf_gpio_state *gs;
> +       struct device *dev =3D &pdev->dev;
> +       struct gpio_chip *gc;
> +       struct resource *res;
> +       int ret;
> +
> +       gs =3D devm_kzalloc(&pdev->dev, sizeof(*gs), GFP_KERNEL);
> +       if (!gs)
> +               return -ENOMEM;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       gs->base =3D devm_ioremap_resource(&pdev->dev, res);

As of v5.1-rc1 we have devm_platform_ioremap_resource(). Please use it here=
.

> +       if (IS_ERR(gs->base))
> +               return PTR_ERR(gs->base);
> +
> +       gc =3D &gs->gc;
> +       ret =3D bgpio_init(gc, dev, 8,
> +                        gs->base + MLXBF_GPIO_PIN_STATE,
> +                        NULL,
> +                        NULL,
> +                        gs->base + MLXBF_GPIO_PIN_DIR_O,
> +                        gs->base + MLXBF_GPIO_PIN_DIR_I,
> +                        0);
> +       if (ret)
> +               return -ENODEV;

Add a new line after the return.

> +       gc->owner =3D THIS_MODULE;
> +       gc->ngpio =3D MLXBF_GPIO_NR;
> +
> +       ret =3D devm_gpiochip_add_data(dev, &gs->gc, gs);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed adding memory mapped gpiochip=
\n");
> +               return ret;
> +       }
> +
> +       platform_set_drvdata(pdev, gs);
> +       dev_info(&pdev->dev, "registered Mellanox BlueField GPIO");
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int mlxbf_gpio_suspend(struct platform_device *pdev, pm_message_t=
 state)
> +{
> +       struct mlxbf_gpio_state *gs =3D platform_get_drvdata(pdev);
> +
> +       gs->csave_regs.scratchpad =3D readq(gs->base + MLXBF_GPIO_SCRATCH=
PAD);
> +       gs->csave_regs.pad_control[0] =3D
> +               readq(gs->base + MLXBF_GPIO_PAD_CONTROL_FIRST_WORD);
> +       gs->csave_regs.pad_control[1] =3D
> +               readq(gs->base + MLXBF_GPIO_PAD_CONTROL_1_FIRST_WORD);
> +       gs->csave_regs.pad_control[2] =3D
> +               readq(gs->base + MLXBF_GPIO_PAD_CONTROL_2_FIRST_WORD);
> +       gs->csave_regs.pad_control[3] =3D
> +               readq(gs->base + MLXBF_GPIO_PAD_CONTROL_3_FIRST_WORD);
> +       gs->csave_regs.pin_dir_i =3D readq(gs->base + MLXBF_GPIO_PIN_DIR_=
I);
> +       gs->csave_regs.pin_dir_o =3D readq(gs->base + MLXBF_GPIO_PIN_DIR_=
O);
> +
> +       return 0;
> +}
> +
> +static int mlxbf_gpio_resume(struct platform_device *pdev)
> +{
> +       struct mlxbf_gpio_state *gs =3D platform_get_drvdata(pdev);
> +
> +       writeq(gs->csave_regs.scratchpad, gs->base + MLXBF_GPIO_SCRATCHPA=
D);
> +       writeq(gs->csave_regs.pad_control[0],
> +              gs->base + MLXBF_GPIO_PAD_CONTROL_FIRST_WORD);
> +       writeq(gs->csave_regs.pad_control[1],
> +              gs->base + MLXBF_GPIO_PAD_CONTROL_1_FIRST_WORD);
> +       writeq(gs->csave_regs.pad_control[2],
> +              gs->base + MLXBF_GPIO_PAD_CONTROL_2_FIRST_WORD);
> +       writeq(gs->csave_regs.pad_control[3],
> +              gs->base + MLXBF_GPIO_PAD_CONTROL_3_FIRST_WORD);
> +       writeq(gs->csave_regs.pin_dir_i, gs->base + MLXBF_GPIO_PIN_DIR_I)=
;
> +       writeq(gs->csave_regs.pin_dir_o, gs->base + MLXBF_GPIO_PIN_DIR_O)=
;
> +
> +       return 0;
> +}
> +#endif
> +
> +static const struct acpi_device_id mlxbf_gpio_acpi_match[] =3D {
> +       { "MLNXBF02", 0 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, mlxbf_gpio_acpi_match);
> +
> +static struct platform_driver mlxbf_gpio_driver =3D {
> +       .driver =3D {
> +               .name =3D "mlxbf_gpio",
> +               .acpi_match_table =3D ACPI_PTR(mlxbf_gpio_acpi_match),
> +       },
> +       .probe    =3D mlxbf_gpio_probe,
> +#ifdef CONFIG_PM
> +       .suspend  =3D mlxbf_gpio_suspend,
> +       .resume   =3D mlxbf_gpio_resume,
> +#endif
> +};
> +
> +module_platform_driver(mlxbf_gpio_driver);
> +
> +MODULE_DESCRIPTION("Mellanox BlueField GPIO Driver");
> +MODULE_AUTHOR("Mellanox Technologies");
> +MODULE_LICENSE("GPL");
> --
> 2.1.2
>

Other than that, looks good to me. I like how this driver shrank since v1.

Bart
