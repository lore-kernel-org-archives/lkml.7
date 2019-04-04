Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C31C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70042206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EN2giNZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfDDHbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:31:04 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50560 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfDDHbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:31:04 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so2237203itk.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W3qRumDcCEooDznDVBL44wVEXvSRV+tP+OEWP01Htt8=;
        b=EN2giNZPQFhQC2oaueAWjXt4xjABMrlD8Zw3wINpk6G2jIei0PHzoCrxKXNzRcks1A
         S7V0bDHt0wsHZwfBNlBYrY2EWKcJ5yvxzfYrAmF/esy+VRUgavb97vsgxEqDlDaDru4B
         CUpDTd1TP2FVuwcPdnjc311T8i8LKNOOdpuBv1leNLSq8I+ox0gKkA/RH7HCtz4YhSsk
         xqww5F7+1j0LxDAnCXLvseW4lLfp5NRpNT18zy72DnDSCzE3t0Jtqno+rssyON/Abtmg
         +J1Cal+enaHcDmB3YsXZ0nyP2jZiZKUStDPKU6JCjrk7ZVOdSrLAb5dyYkKyn+NXZUA6
         Bv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W3qRumDcCEooDznDVBL44wVEXvSRV+tP+OEWP01Htt8=;
        b=mrq2Rteuu+XSqJNDrzVXOMr5LiouJmYVTyq26lC/TktWXP/DgaM7iBIEkxHG1vdWq1
         xztoN+yDM0RANDF0XT0hSGaYsXkNlZafYsUH+e7y0+5hfE1ShlH6VdgpHfoSiGw1CUa8
         Q4wgD9WBnuYd37zUgSwts1CdOeL1X8fPapZUmScVKvrSqK4kEBE7TRrB48mKv43RJrpe
         gkhP1YKTXZnQjfCWDzoopqGJip5DNyfxkWoJ/Aswi4O1ePQtyhEVlyva/dr9/AeXP8+e
         0RL9lcFNZs1yVVFKCkOsNKGMlZbCDR5aHevI7cRS/K8fOkciR6XDjj42kzHp/axmsZD/
         /bkA==
X-Gm-Message-State: APjAAAUwkTPi3MBHh8baUPc8oVyhMKqpFrVRDAgX3Z6Kh0qacqeCSoL1
        UK1SOqCBjqUYmQHCL4s65WOXDPjdzuXiJjYNMRotgg==
X-Google-Smtp-Source: APXvYqzYwjimeCK+LqqK4WGybPg4hK02K5Nf7Pg1rx/zNKIv2A501Zjc709C53upb593uqufpfw6mSahcvLcyht7KnM=
X-Received: by 2002:a24:57cf:: with SMTP id u198mr2953852ita.162.1554363062840;
 Thu, 04 Apr 2019 00:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190403090108.24788-1-brgl@bgdev.pl> <20190403090108.24788-7-brgl@bgdev.pl>
 <20190404071538.GH6830@dell>
In-Reply-To: <20190404071538.GH6830@dell>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 4 Apr 2019 09:30:52 +0200
Message-ID: <CAMRc=Mcfgw+tAM+B_phMX6x4qUHiTd6Yn2OnT4_dQ7AzypD-cg@mail.gmail.com>
Subject: Re: [PATCH v8 06/11] mfd: max77650: new core mfd driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 4 kwi 2019 o 09:15 Lee Jones <lee.jones@linaro.org> napisa=C5=82(a):
>
> On Wed, 03 Apr 2019, Bartosz Golaszewski wrote:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add the core mfd driver for max77650 PMIC. We define five sub-devices
> > for which the drivers will be added in subsequent patches.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/mfd/Kconfig          |  14 +++
> >  drivers/mfd/Makefile         |   1 +
> >  drivers/mfd/max77650.c       | 234 +++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/max77650.h |  59 +++++++++
> >  4 files changed, 308 insertions(+)
> >  create mode 100644 drivers/mfd/max77650.c
> >  create mode 100644 include/linux/mfd/max77650.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 0ce2d8dfc5f1..ade04e124aa0 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -733,6 +733,20 @@ config MFD_MAX77620
> >         provides common support for accessing the device; additional dr=
ivers
> >         must be enabled in order to use the functionality of the device=
.
> >
> > +config MFD_MAX77650
> > +     tristate "Maxim MAX77650/77651 PMIC Support"
> > +     depends on I2C
> > +     depends on OF || COMPILE_TEST
> > +     select MFD_CORE
> > +     select REGMAP_I2C
> > +     help
> > +       Say Y here to add support for Maxim Semiconductor MAX77650 and
> > +       MAX77651 Power Management ICs. This is the core multifunction
> > +       driver for interacting with the device. The module name is
> > +       'max77650'. Additional drivers can be enabled in order to use
> > +       the following functionalities of the device: GPIO, regulator,
> > +       charger, LED, onkey.
> > +
> >  config MFD_MAX77686
> >       tristate "Maxim Semiconductor MAX77686/802 PMIC Support"
> >       depends on I2C
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index b4569ed7f3f3..5727d099c16f 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -155,6 +155,7 @@ obj-$(CONFIG_MFD_DA9150)  +=3D da9150-core.o
> >
> >  obj-$(CONFIG_MFD_MAX14577)   +=3D max14577.o
> >  obj-$(CONFIG_MFD_MAX77620)   +=3D max77620.o
> > +obj-$(CONFIG_MFD_MAX77650)   +=3D max77650.o
> >  obj-$(CONFIG_MFD_MAX77686)   +=3D max77686.o
> >  obj-$(CONFIG_MFD_MAX77693)   +=3D max77693.o
> >  obj-$(CONFIG_MFD_MAX77843)   +=3D max77843.o
> > diff --git a/drivers/mfd/max77650.c b/drivers/mfd/max77650.c
> > new file mode 100644
> > index 000000000000..7a6c0a5cf602
> > --- /dev/null
> > +++ b/drivers/mfd/max77650.c
> > @@ -0,0 +1,234 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Copyright (C) 2018 BayLibre SAS
> > +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > +//
> > +// Core MFD driver for MAXIM 77650/77651 charger/power-supply.
> > +// Programming manual: https://pdfserv.maximintegrated.com/en/an/AN642=
8.pdf
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/max77650.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/regmap.h>
> > +
> > +#define MAX77650_INT_GPI_F_MSK               BIT(0)
> > +#define MAX77650_INT_GPI_R_MSK               BIT(1)
> > +#define MAX77650_INT_GPI_MSK \
> > +                     (MAX77650_INT_GPI_F_MSK | MAX77650_INT_GPI_R_MSK)
> > +#define MAX77650_INT_nEN_F_MSK               BIT(2)
> > +#define MAX77650_INT_nEN_R_MSK               BIT(3)
> > +#define MAX77650_INT_TJAL1_R_MSK     BIT(4)
> > +#define MAX77650_INT_TJAL2_R_MSK     BIT(5)
> > +#define MAX77650_INT_DOD_R_MSK               BIT(6)
> > +
> > +#define MAX77650_INT_THM_MSK         BIT(0)
> > +#define MAX77650_INT_CHG_MSK         BIT(1)
> > +#define MAX77650_INT_CHGIN_MSK               BIT(2)
> > +#define MAX77650_INT_TJ_REG_MSK              BIT(3)
> > +#define MAX77650_INT_CHGIN_CTRL_MSK  BIT(4)
> > +#define MAX77650_INT_SYS_CTRL_MSK    BIT(5)
> > +#define MAX77650_INT_SYS_CNFG_MSK    BIT(6)
> > +
> > +#define MAX77650_INT_GLBL_OFFSET     0
> > +#define MAX77650_INT_CHG_OFFSET              1
> > +
> > +#define MAX77650_SBIA_LPM_MASK               BIT(5)
> > +#define MAX77650_SBIA_LPM_DISABLED   0x00
> > +
> > +enum {
> > +     MAX77650_INT_GPI,
> > +     MAX77650_INT_nEN_F,
> > +     MAX77650_INT_nEN_R,
> > +     MAX77650_INT_TJAL1_R,
> > +     MAX77650_INT_TJAL2_R,
> > +     MAX77650_INT_DOD_R,
> > +     MAX77650_INT_THM,
> > +     MAX77650_INT_CHG,
> > +     MAX77650_INT_CHGIN,
> > +     MAX77650_INT_TJ_REG,
> > +     MAX77650_INT_CHGIN_CTRL,
> > +     MAX77650_INT_SYS_CTRL,
> > +     MAX77650_INT_SYS_CNFG,
> > +};
> > +
> > +static const struct resource max77650_charger_resources[] =3D {
> > +     DEFINE_RES_IRQ_NAMED(MAX77650_INT_CHG, "CHG"),
> > +     DEFINE_RES_IRQ_NAMED(MAX77650_INT_CHGIN, "CHGIN"),
> > +};
> > +
> > +static const struct resource max77650_gpio_resources[] =3D {
> > +     DEFINE_RES_IRQ_NAMED(MAX77650_INT_GPI, "GPI"),
> > +};
> > +
> > +static const struct resource max77650_onkey_resources[] =3D {
> > +     DEFINE_RES_IRQ_NAMED(MAX77650_INT_nEN_F, "nEN_F"),
> > +     DEFINE_RES_IRQ_NAMED(MAX77650_INT_nEN_R, "nEN_R"),
> > +};
> > +
> > +static const struct mfd_cell max77650_cells[] =3D {
> > +     {
> > +             .name           =3D "max77650-regulator",
> > +             .of_compatible  =3D "maxim,max77650-regulator",
>
> > +     },
> > +     {
>
> Nit: Place these all on the same line, like:
>
>         }, {
>
> > +             .name           =3D "max77650-charger",
> > +             .of_compatible  =3D "maxim,max77650-charger",
> > +             .resources      =3D max77650_charger_resources,
> > +             .num_resources  =3D ARRAY_SIZE(max77650_charger_resources=
),
> > +     },
> > +     {
> > +             .name           =3D "max77650-gpio",
> > +             .of_compatible  =3D "maxim,max77650-gpio",
> > +             .resources      =3D max77650_gpio_resources,
> > +             .num_resources  =3D ARRAY_SIZE(max77650_gpio_resources),
> > +     },
> > +     {
> > +             .name           =3D "max77650-led",
> > +             .of_compatible  =3D "maxim,max77650-led",
> > +     },
> > +     {
> > +             .name           =3D "max77650-onkey",
> > +             .of_compatible  =3D "maxim,max77650-onkey",
> > +             .resources      =3D max77650_onkey_resources,
> > +             .num_resources  =3D ARRAY_SIZE(max77650_onkey_resources),
> > +     },
> > +};
> > +
> > +static const struct regmap_irq max77650_irqs[] =3D {
> > +     [MAX77650_INT_GPI] =3D {
> > +             .reg_offset             =3D MAX77650_INT_GLBL_OFFSET,
> > +             .mask                   =3D MAX77650_INT_GPI_MSK,
> > +             .type =3D {
> > +                     .type_falling_val       =3D MAX77650_INT_GPI_F_MS=
K,
> > +                     .type_rising_val        =3D MAX77650_INT_GPI_R_MS=
K,
> > +                     .types_supported        =3D IRQ_TYPE_EDGE_BOTH,
>
> Not really a fan of these silly double/triple tabs everywhere.  I like
> a straight line as much as anyone, but I'd probably remove them from
> here.
>
> > +             },
> > +     },
> > +     REGMAP_IRQ_REG(MAX77650_INT_nEN_F,
> > +                    MAX77650_INT_GLBL_OFFSET, MAX77650_INT_nEN_F_MSK),
> > +     REGMAP_IRQ_REG(MAX77650_INT_nEN_R,
> > +                    MAX77650_INT_GLBL_OFFSET, MAX77650_INT_nEN_R_MSK),
> > +     REGMAP_IRQ_REG(MAX77650_INT_TJAL1_R,
> > +                    MAX77650_INT_GLBL_OFFSET, MAX77650_INT_TJAL1_R_MSK=
),
> > +     REGMAP_IRQ_REG(MAX77650_INT_TJAL2_R,
> > +                    MAX77650_INT_GLBL_OFFSET, MAX77650_INT_TJAL2_R_MSK=
),
> > +     REGMAP_IRQ_REG(MAX77650_INT_DOD_R,
> > +                    MAX77650_INT_GLBL_OFFSET, MAX77650_INT_DOD_R_MSK),
> > +     REGMAP_IRQ_REG(MAX77650_INT_THM,
> > +                    MAX77650_INT_CHG_OFFSET, MAX77650_INT_THM_MSK),
> > +     REGMAP_IRQ_REG(MAX77650_INT_CHG,
> > +                    MAX77650_INT_CHG_OFFSET, MAX77650_INT_CHG_MSK),
> > +     REGMAP_IRQ_REG(MAX77650_INT_CHGIN,
> > +                    MAX77650_INT_CHG_OFFSET, MAX77650_INT_CHGIN_MSK),
> > +     REGMAP_IRQ_REG(MAX77650_INT_TJ_REG,
> > +                    MAX77650_INT_CHG_OFFSET, MAX77650_INT_TJ_REG_MSK),
> > +     REGMAP_IRQ_REG(MAX77650_INT_CHGIN_CTRL,
> > +                    MAX77650_INT_CHG_OFFSET, MAX77650_INT_CHGIN_CTRL_M=
SK),
> > +     REGMAP_IRQ_REG(MAX77650_INT_SYS_CTRL,
> > +                    MAX77650_INT_CHG_OFFSET, MAX77650_INT_SYS_CTRL_MSK=
),
> > +     REGMAP_IRQ_REG(MAX77650_INT_SYS_CNFG,
> > +                    MAX77650_INT_CHG_OFFSET, MAX77650_INT_SYS_CNFG_MSK=
),
> > +};
> > +
> > +static const struct regmap_irq_chip max77650_irq_chip =3D {
> > +     .name                   =3D "max77650-irq",
> > +     .irqs                   =3D max77650_irqs,
> > +     .num_irqs               =3D ARRAY_SIZE(max77650_irqs),
> > +     .num_regs               =3D 2,
> > +     .status_base            =3D MAX77650_REG_INT_GLBL,
> > +     .mask_base              =3D MAX77650_REG_INTM_GLBL,
> > +     .type_in_mask           =3D true,
> > +     .type_invert            =3D true,
> > +     .init_ack_masked        =3D true,
> > +     .clear_on_unmask        =3D true,
> > +};
> > +
> > +static const struct regmap_config max77650_regmap_config =3D {
> > +     .name           =3D "max77650",
> > +     .reg_bits       =3D 8,
> > +     .val_bits       =3D 8,
> > +};
> > +
> > +static int max77650_i2c_probe(struct i2c_client *i2c)
> > +{
> > +     struct regmap_irq_chip_data *irq_data;
> > +     struct device *dev =3D &i2c->dev;
> > +     struct irq_domain *domain;
> > +     struct regmap *map;
> > +     unsigned int val;
> > +     int rv;
> > +
> > +     map =3D devm_regmap_init_i2c(i2c, &max77650_regmap_config);
> > +     if (IS_ERR(map)) {
> > +             dev_err(dev, "unable to initialize i2c regmap\n");
>
> "Unable to initialise I2C Regmap"
>
> > +             return PTR_ERR(map);
> > +     }
> > +
> > +     rv =3D regmap_read(map, MAX77650_REG_CID, &val);
> > +     if (rv) {
> > +             dev_err(dev, "unable to read the CID from device\n");
>
> "Unable to read Chip ID"
>
> > +             return rv;
> > +     }
> > +
> > +     switch (MAX77650_CID_BITS(val)) {
> > +     case MAX77650_CID_77650A:
> > +     case MAX77650_CID_77650C:
> > +     case MAX77650_CID_77651A:
> > +     case MAX77650_CID_77651B:
> > +             break;
> > +     default:
>
> So you're exiting silently here.  What is the user going to think?
>
> "Chip not supported - ID: %d"
>
> > +             return -ENODEV;
> > +     }
> > +
> > +     /*
> > +      * This IC has a low-power mode which reduces the quiescent curre=
nt
> > +      * consumption to ~5.6uA but is only suitable for systems consumi=
ng
> > +      * less than ~2mA. Since this is not likely the case even on
> > +      * linux-based wearables - keep the chip in normal power mode.
> > +      */
> > +     rv =3D regmap_update_bits(map,
> > +                             MAX77650_REG_CNFG_GLBL,
> > +                             MAX77650_SBIA_LPM_MASK,
> > +                             MAX77650_SBIA_LPM_DISABLED);
> > +     if (rv) {
> > +             dev_err(dev, "unable to change the power mode\n");
>
> "Unable ..."
>
> > +             return rv;
> > +     }
> > +
> > +     rv =3D devm_regmap_add_irq_chip(dev, map, i2c->irq,
> > +                                   IRQF_ONESHOT | IRQF_SHARED, 0,
> > +                                   &max77650_irq_chip, &irq_data);
> > +     if (rv) {
> > +             dev_err(dev, "unable to add the regmap irq chip\n");
>
> "Unable to add Regmap IRQ chip"
>
> > +             return rv;
> > +     }
> > +
> > +     domain =3D regmap_irq_get_domain(irq_data);
>
> No error checking?
>

This can only fail is irq_data is NULL and since the previous function
succeeded we know it isn't.

Bart

> > +     return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> > +                                 max77650_cells, ARRAY_SIZE(max77650_c=
ells),
> > +                                 NULL, 0, domain);
> > +}
> > +
> > +static const struct of_device_id max77650_of_match[] =3D {
> > +     { .compatible =3D "maxim,max77650" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, max77650_of_match);
> > +
> > +static struct i2c_driver max77650_i2c_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "max77650",
> > +             .of_match_table =3D of_match_ptr(max77650_of_match),
> > +     },
> > +     .probe_new =3D max77650_i2c_probe,
>
> I wrote this years ago.  Hasn't it gone away yet?
>
> > +};
> > +module_i2c_driver(max77650_i2c_driver);
> > +
> > +MODULE_DESCRIPTION("MAXIM 77650/77651 multi-function core driver");
> > +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/mfd/max77650.h b/include/linux/mfd/max77650.=
h
> > new file mode 100644
> > index 000000000000..c809e211a8cd
> > --- /dev/null
> > +++ b/include/linux/mfd/max77650.h
> > @@ -0,0 +1,59 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2018 BayLibre SAS
> > + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > + *
> > + * Common definitions for MAXIM 77650/77651 charger/power-supply.
> > + */
> > +
> > +#ifndef MAX77650_H
> > +#define MAX77650_H
> > +
> > +#include <linux/bits.h>
> > +
> > +#define MAX77650_REG_INT_GLBL                0x00
> > +#define MAX77650_REG_INT_CHG         0x01
> > +#define MAX77650_REG_STAT_CHG_A              0x02
> > +#define MAX77650_REG_STAT_CHG_B              0x03
> > +#define MAX77650_REG_ERCFLAG         0x04
> > +#define MAX77650_REG_STAT_GLBL               0x05
> > +#define MAX77650_REG_INTM_GLBL               0x06
> > +#define MAX77650_REG_INTM_CHG                0x07
> > +#define MAX77650_REG_CNFG_GLBL               0x10
> > +#define MAX77650_REG_CID             0x11
> > +#define MAX77650_REG_CNFG_GPIO               0x12
> > +#define MAX77650_REG_CNFG_CHG_A              0x18
> > +#define MAX77650_REG_CNFG_CHG_B              0x19
> > +#define MAX77650_REG_CNFG_CHG_C              0x1a
> > +#define MAX77650_REG_CNFG_CHG_D              0x1b
> > +#define MAX77650_REG_CNFG_CHG_E              0x1c
> > +#define MAX77650_REG_CNFG_CHG_F              0x1d
> > +#define MAX77650_REG_CNFG_CHG_G              0x1e
> > +#define MAX77650_REG_CNFG_CHG_H              0x1f
> > +#define MAX77650_REG_CNFG_CHG_I              0x20
> > +#define MAX77650_REG_CNFG_SBB_TOP    0x28
> > +#define MAX77650_REG_CNFG_SBB0_A     0x29
> > +#define MAX77650_REG_CNFG_SBB0_B     0x2a
> > +#define MAX77650_REG_CNFG_SBB1_A     0x2b
> > +#define MAX77650_REG_CNFG_SBB1_B     0x2c
> > +#define MAX77650_REG_CNFG_SBB2_A     0x2d
> > +#define MAX77650_REG_CNFG_SBB2_B     0x2e
> > +#define MAX77650_REG_CNFG_LDO_A              0x38
> > +#define MAX77650_REG_CNFG_LDO_B              0x39
> > +#define MAX77650_REG_CNFG_LED0_A     0x40
> > +#define MAX77650_REG_CNFG_LED1_A     0x41
> > +#define MAX77650_REG_CNFG_LED2_A     0x42
> > +#define MAX77650_REG_CNFG_LED0_B     0x43
> > +#define MAX77650_REG_CNFG_LED1_B     0x44
> > +#define MAX77650_REG_CNFG_LED2_B     0x45
> > +#define MAX77650_REG_CNFG_LED_TOP    0x46
> > +
> > +#define MAX77650_CID_MASK            GENMASK(3, 0)
> > +#define MAX77650_CID_BITS(_reg)              (_reg & MAX77650_CID_MASK=
)
> > +
> > +#define MAX77650_CID_77650A          0x03
> > +#define MAX77650_CID_77650C          0x0a
> > +#define MAX77650_CID_77651A          0x06
> > +#define MAX77650_CID_77651B          0x08
> > +
> > +#endif /* MAX77650_H */
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
