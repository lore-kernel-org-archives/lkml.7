Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E879C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E061F206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3HRgKEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfD0A3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 20:29:21 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39019 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfD0A3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 20:29:21 -0400
Received: by mail-it1-f194.google.com with SMTP id e13so8432250itk.4;
        Fri, 26 Apr 2019 17:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/9ogiJA+JEDZV4ay5Fz25UoFk62Jo7d7QFIc7jAMGTk=;
        b=d3HRgKEpfoDEewQsqEfMOPChnsAHfjy8C8l1a1q8VTa4uiM+SvaHqAGJ4KTQ2lSBZh
         1YIL1zbwQ+lwN12KyWIzDehCDp6QdvUvLiuEUumYKuAh/i1RlntME0Q8TYcSoNB1F5BD
         yn6bptTChMQSPhFOu9WFlZqjxHIqapAGH5knjXKbbKoes9FDsmTE0TqDn06hxJBBRKDO
         StTgKF7Inmo8wkNj0rsNJ0vIECzzzGofSUaHeHA/Hyq0Tp3EQzMbizXKut4QUXem2iOR
         /ICgJNfBO+4+2lM4UUCY4wRyyK7x0EDxEchR/dhXP72BnEkuaqFvVkgyYHmg2VNOBbOx
         hcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/9ogiJA+JEDZV4ay5Fz25UoFk62Jo7d7QFIc7jAMGTk=;
        b=Sy5s/L5oFcBhiBJyoB0ZJoFrZs99mIa+s4K6fhBDZ1FNPPopCXK95XLOsdD9zvElZy
         f8CW+5eJ6wJs/wsgBDfR2vMzxd8EDKBlyMXjkZYw1CScGsK/3eIlvhAu5KGbnxBRhrxT
         PEifoWLCZFvCbwpNtHrDfVRTsZMD5gN54kWchFFrjDtxUwV9AqLDfbBn8jwh5ZQ4KW04
         S1qkga+oHMkBkNNTW32MgM6q3+DszwkDJ/uiH/oCtdXxLTEMEXN/WHHCvOb5p+px0U2v
         g/5FpPeKz7NWOTaR3OsWNzIlRcmXYh+BeZ2gUsnvlOms1HdVedrArCvsiUuueAwYmZjf
         89Xw==
X-Gm-Message-State: APjAAAV1SBFDsOYDiDCOMg4avWGvKeK2dEzoqgjz2QxMObHNVv8AurFj
        w51o9vRqc29yNuPXk5WVZRVKgmi3qBIJJrFqZoI=
X-Google-Smtp-Source: APXvYqxTpFzIMxrJVciQhd6ivaaXywhPPOFpCJaH+Lrggft22ilmcFg874vKP2IqkyNzFCJuD+1nRl+6zbjKSwKfprw=
X-Received: by 2002:a02:1049:: with SMTP id 70mr31482030jay.114.1556324959616;
 Fri, 26 Apr 2019 17:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190417084457.28747-1-andrew.smirnov@gmail.com>
 <20190417084457.28747-3-andrew.smirnov@gmail.com> <CAFqH_53vo__70Xm5pOoLvqPG2iNN32VP5cbFCatDq=o0GLYzsA@mail.gmail.com>
In-Reply-To: <CAFqH_53vo__70Xm5pOoLvqPG2iNN32VP5cbFCatDq=o0GLYzsA@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 26 Apr 2019 17:29:08 -0700
Message-ID: <CAHQ1cqG3SywejRSYi2SE9O9o4k2jfNC0vuxQ1b__otXbTH8K_w@mail.gmail.com>
Subject: Re: [PATCH 2/3] power: supply: Add driver for Microchip UCS1002
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Chris Health <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 9:52 AM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Hi Andrey,
>
> Many thanks to push this upstream. Actually this the fifth version [1]
> of this patchset. I think that is interesting for the maintainers
> maintain the history and the changelog.
>
> [1] https://lkml.org/lkml/2016/3/14/233

I probably won't change the version numbering of the series at this
point, but I'll definitely add the link above to the cover letter.

>
> Missatge de Andrey Smirnov <andrew.smirnov@gmail.com> del dia dc., 17
> d=E2=80=99abr. 2019 a les 10:46:
> >
> > Add driver for Microchip UCS1002 Programmable USB Port Power
> > Controller with Charger Emulation. The driver exposed a power supply
> > device to control/monitor various parameter of the device as well as a
> > regulator to allow controlling VBUS line.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Health <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  drivers/power/supply/Kconfig         |   9 +
> >  drivers/power/supply/Makefile        |   1 +
> >  drivers/power/supply/ucs1002_power.c | 639 +++++++++++++++++++++++++++
> >  3 files changed, 649 insertions(+)
> >  create mode 100644 drivers/power/supply/ucs1002_power.c
> >
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfi=
g
> > index e901b9879e7e..c614c8a196f3 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -660,4 +660,13 @@ config FUEL_GAUGE_SC27XX
> >          Say Y here to enable support for fuel gauge with SC27XX
> >          PMIC chips.
> >
> > +config CHARGER_UCS1002
> > +        tristate "Microchip UCS1002 USB Port Power Controller"
> > +       depends on I2C
> > +       depends on OF
> > +       select REGMAP_I2C
> > +       help
> > +         Say Y to enable support for Microchip UCS1002 Programmable
> > +         USB Port Power Controller with Charger Emulation.
> > +
> >  endif # POWER_SUPPLY
> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makef=
ile
> > index b731c2a9b695..c56803a9e4fe 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -87,3 +87,4 @@ obj-$(CONFIG_AXP288_CHARGER)  +=3D axp288_charger.o
> >  obj-$(CONFIG_CHARGER_CROS_USBPD)       +=3D cros_usbpd-charger.o
> >  obj-$(CONFIG_CHARGER_SC2731)   +=3D sc2731_charger.o
> >  obj-$(CONFIG_FUEL_GAUGE_SC27XX)        +=3D sc27xx_fuel_gauge.o
> > +obj-$(CONFIG_CHARGER_UCS1002)  +=3D ucs1002_power.o
> > diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/suppl=
y/ucs1002_power.c
> > new file mode 100644
> > index 000000000000..b0b81d62e003
> > --- /dev/null
> > +++ b/drivers/power/supply/ucs1002_power.c
> > @@ -0,0 +1,639 @@
> > +// SPDX-License-Identifier: GPL-2.0+
>
> There is a license mismatch, or this should be GPL-2.0 or
> MODULE_LICENCE should GPL.
>

OK, will change MODULE_LICENSE to GPL in v2.

> > +/*
> > + * Driver for UCS1002 Programmable USB Port Power Controller
> > + *
> > + * Copyright (C) 2019 Zodiac Inflight Innovations
> > + */
> > +#include <linux/freezer.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kthread.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/driver.h>
> > +#include <linux/regulator/of_regulator.h>
> > +
> > +/* UCS1002 Registers */
> > +#define UCS1002_REG_CURRENT_MEASUREMENT        0x00
> > +
> > +/*
> > + * The Total Accumulated Charge registers store the total accumulated
> > + * charge delivered from the VS source to a portable device. The total
> > + * value is calculated using four registers, from 01h to 04h. The bit
> > + * weighting of the registers is given in mA/hrs.
> > + */
> > +#define UCS1002_REG_TOTAL_ACC_CHARGE   0x01
> > +
> > +/* Other Status Register */
> > +#define UCS1002_REG_OTHER_STATUS       0x0f
> > +#  define F_ADET_PIN                   BIT(4)
> > +#  define F_CHG_ACT                    BIT(3)
> > +
> > +/* Interrupt Status */
> > +#define UCS1002_REG_INTERRUPT_STATUS   0x10
> > +#  define F_DISCHARGE_ERR              BIT(6)
> > +#  define F_RESET                      BIT(5)
> > +#  define F_MIN_KEEP_OUT               BIT(4)
> > +#  define F_TSD                                BIT(3)
> > +#  define F_OVER_VOLT                  BIT(2)
> > +#  define F_BACK_VOLT                  BIT(1)
> > +#  define F_OVER_ILIM                  BIT(0)
> > +
> > +/* Pin Status Register */
> > +#define UCS1002_REG_PIN_STATUS         0x14
> > +#  define UCS1002_PWR_STATE_MASK       0x03
> > +#  define F_PWR_EN_PIN                 BIT(6)
> > +#  define F_M2_PIN                     BIT(5)
> > +#  define F_M1_PIN                     BIT(4)
> > +#  define F_EM_EN_PIN                  BIT(3)
> > +#  define F_SEL_PIN                    BIT(2)
> > +#  define F_ACTIVE_MODE_MASK           GENMASK(5, 3)
> > +#  define F_ACTIVE_MODE_PASSTHROUGH    F_M2_PIN
> > +#  define F_ACTIVE_MODE_DEDICATED      F_EM_EN_PIN
> > +#  define F_ACTIVE_MODE_BC12_DCP       (F_M2_PIN | F_EM_EN_PIN)
> > +#  define F_ACTIVE_MODE_BC12_SDP       F_M1_PIN
> > +#  define F_ACTIVE_MODE_BC12_CDP       (F_M1_PIN | F_M2_PIN | F_EM_EN_=
PIN)
> > +
> > +/* General Configuration Register */
> > +#define UCS1002_REG_GENERAL_CFG                0x15
> > +#  define F_RATION_EN                  BIT(3)
> > +
> > +/* Emulation Configuration Register */
> > +#define UCS1002_REG_EMU_CFG            0x16
> > +
> > +/* Switch Configuration Register */
> > +#define UCS1002_REG_SWITCH_CFG         0x17
> > +#  define F_PIN_IGNORE                 BIT(7)
> > +#  define F_EM_EN_SET                  BIT(5)
> > +#  define F_M2_SET                     BIT(4)
> > +#  define F_M1_SET                     BIT(3)
> > +#  define F_S0_SET                     BIT(2)
> > +#  define F_PWR_EN_SET                 BIT(1)
> > +#  define F_LATCH_SET                  BIT(0)
> > +#  define V_SET_ACTIVE_MODE_MASK       GENMASK(5, 3)
> > +#  define V_SET_ACTIVE_MODE_PASSTHROUGH        F_M2_SET
> > +#  define V_SET_ACTIVE_MODE_DEDICATED  F_EM_EN_SET
> > +#  define V_SET_ACTIVE_MODE_BC12_DCP   (F_M2_SET | F_EM_EN_SET)
> > +#  define V_SET_ACTIVE_MODE_BC12_SDP   F_M1_SET
> > +#  define V_SET_ACTIVE_MODE_BC12_CDP   (F_M1_SET | F_M2_SET | F_EM_EN_=
SET)
> > +
> > +/* Current Limit Register */
> > +#define UCS1002_REG_ILIMIT             0x19
> > +#  define UCS1002_ILIM_SW_MASK         GENMASK(3, 0)
> > +
> > +/* Product ID */
> > +#define UCS1002_REG_PRODUCT_ID         0xfd
> > +#  define UCS1002_PRODUCT_ID           0x4e
> > +
> > +/* Manufacture name */
> > +#define UCS1002_MANUFACTURER           "SMSC"
> > +
> > +struct ucs1002_info {
> > +       struct power_supply *charger;
> > +       struct i2c_client *client;
> > +       struct regmap *regmap;
> > +       struct regulator_desc *regulator_descriptor;
> > +       bool present;
> > +};
> > +
> > +static enum power_supply_property ucs1002_props[] =3D {
> > +       POWER_SUPPLY_PROP_ONLINE,
> > +       POWER_SUPPLY_PROP_CHARGE_NOW,
> > +       POWER_SUPPLY_PROP_CURRENT_NOW,
> > +       POWER_SUPPLY_PROP_CURRENT_MAX,
> > +       POWER_SUPPLY_PROP_PRESENT, /* the presence of PED */
> > +       POWER_SUPPLY_PROP_MANUFACTURER,
> > +       POWER_SUPPLY_PROP_USB_TYPE,
> > +       POWER_SUPPLY_PROP_HEALTH,
> > +};
> > +
> > +static int ucs1002_get_online(struct ucs1002_info *info,
> > +                             union power_supply_propval *val)
> > +{
> > +       unsigned int reg;
> > +       int ret;
> > +
> > +       ret =3D regmap_read(info->regmap, UCS1002_REG_OTHER_STATUS, &re=
g);
> > +       if (ret)
> > +               return ret;
> > +
> > +       val->intval =3D !!(reg & F_CHG_ACT);
> > +
> > +       return 0;
> > +}
> > +
> > +static int ucs1002_get_charge(struct ucs1002_info *info,
> > +                             union power_supply_propval *val)
> > +{
> > +       /*
> > +        * To fit within 32 bits some values are rounded (uA/h)
> > +        *
> > +        * For Total Accumulated Charge Middle Low Byte register, addr
> > +        * 03h, byte 2
> > +        *
> > +        *   B0: 0.01084 mA/h rounded to 11 uA/h
> > +        *   B1: 0.02169 mA/h rounded to 22 uA/h
> > +        *   B2: 0.04340 mA/h rounded to 43 uA/h
> > +        *   B3: 0.08676 mA/h rounded to 87 uA/h
> > +        *   B4: 0.17350 mA/h rounded to 173 u=C3=81/h
> > +        *
> > +        * For Total Accumulated Charge Low Byte register, addr 04h,
> > +        * byte 3
> > +        *
> > +        *   B6: 0.00271 mA/h rounded to 3 uA/h
> > +        *   B7: 0.005422 mA/h rounded to 5 uA/h
> > +        */
> > +       static const int bit_weights_uAh[BITS_PER_TYPE(u32)] =3D {
> > +               0, 0, 0, 0, 0, 0, 3, 5,
> > +
>
> nit: I personally don't like these empty lines here.
>

I'll add comments to clarify that those represent individual bytes to
replace the empty lines.

> > +               11, 22, 43, 87, 173, 347, 694, 1388,
> > +
> > +               2776, 5552, 11105, 22210, 44420, 88840, 177700, 355400,
> > +
> > +               710700, 1421000, 2843000, 5685000, 11371000, 22742000,
> > +               45484000, 90968000,
> > +       };
> > +       unsigned long total_acc_charger;
> > +       unsigned int reg;
> > +       int i, ret;
> > +
> > +       ret =3D regmap_bulk_read(info->regmap, UCS1002_REG_TOTAL_ACC_CH=
ARGE,
> > +                              &reg, sizeof(u32));
> > +       if (ret)
> > +               return ret;
> > +
> > +       total_acc_charger =3D be32_to_cpu(reg);
> > +       val->intval =3D 0;
> > +
> > +       for_each_set_bit(i, &total_acc_charger, ARRAY_SIZE(bit_weights_=
uAh))
> > +               val->intval +=3D bit_weights_uAh[i];
> > +
> > +       return 0;
> > +}
> > +
> > +static int ucs1002_get_current(struct ucs1002_info *info,
> > +                              union power_supply_propval *val)
> > +{
> > +       /*
> > +        * The Current Measurement register stores the measured
> > +        * current value delivered to the portable device. The range
> > +        * is from 9.76 mA to 2.5 A.
> > +        */
> > +       static const int bit_weights_uA[BITS_PER_TYPE(u8)] =3D {
> > +               9760, 19500, 39000, 78100, 156200, 312300, 624600, 1249=
300,
> > +       };
> > +       unsigned long current_measurement;
> > +       unsigned int reg;
> > +       int i, ret;
> > +
> > +       ret =3D regmap_read(info->regmap, UCS1002_REG_CURRENT_MEASUREME=
NT, &reg);
> > +       if (ret)
> > +               return ret;
> > +
> > +       current_measurement =3D reg;
> > +       val->intval =3D 0;
> > +
> > +       for_each_set_bit(i, &current_measurement, ARRAY_SIZE(bit_weight=
s_uA))
> > +               val->intval +=3D bit_weights_uA[i];
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * The Current Limit register stores the maximum current used by the
> > + * port switch. The range is from 500mA to 2.5 A.
> > + */
> > +static const u32 ucs1002_current_limit_uA[] =3D {
> > +       500000, 900000, 1000000, 1200000, 1500000, 1800000, 2000000, 25=
00000,
> > +};
> > +
> > +static int ucs1002_get_max_current(struct ucs1002_info *info,
> > +                                  union power_supply_propval *val)
> > +{
> > +       unsigned int reg;
> > +       int ret;
> > +
> > +       ret =3D regmap_read(info->regmap, UCS1002_REG_ILIMIT, &reg);
> > +       if (ret)
> > +               return ret;
> > +
> > +       val->intval =3D ucs1002_current_limit_uA[reg & UCS1002_ILIM_SW_=
MASK];
> > +
> > +       return 0;
> > +}
> > +
> > +static int ucs1002_set_max_current(struct ucs1002_info *info, u32 val)
> > +{
> > +       unsigned int reg;
> > +       int ret, idx;
> > +
> > +       for (idx =3D 0; idx < ARRAY_SIZE(ucs1002_current_limit_uA); idx=
++) {
> > +               if (val =3D=3D ucs1002_current_limit_uA[idx])
> > +                       break;
> > +       }
> > +
> > +       if (idx =3D=3D ARRAY_SIZE(ucs1002_current_limit_uA)) {
> > +               dev_err(&info->client->dev,
> > +                       "%d is an invalid max current value\n", val);
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret =3D regmap_write(info->regmap, UCS1002_REG_ILIMIT, idx);
> > +       if (ret)
> > +               return ret;
> > +       /*
> > +        * Any current limit setting exceeding the one set via ILIM
> > +        * pin will be rejected, so we read out freshly changed limit
> > +        * to make sure that it took effect.
> > +        */
> > +       ret =3D regmap_read(info->regmap, UCS1002_REG_ILIMIT, &reg);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (reg !=3D idx)
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> > +
> > +static enum power_supply_usb_type ucs1002_usb_types[] =3D {
> > +       POWER_SUPPLY_USB_TYPE_PD,
> > +       POWER_SUPPLY_USB_TYPE_SDP,
> > +       POWER_SUPPLY_USB_TYPE_DCP,
> > +       POWER_SUPPLY_USB_TYPE_CDP,
> > +       POWER_SUPPLY_USB_TYPE_UNKNOWN,
> > +};
> > +
> > +static int ucs1002_set_usb_type(struct ucs1002_info *info, int val)
> > +{
> > +       unsigned int mode;
> > +
> > +       if (val >=3D ARRAY_SIZE(ucs1002_usb_types))
> > +               return -EINVAL;
> > +
> > +       switch (ucs1002_usb_types[val]) {
> > +       case POWER_SUPPLY_USB_TYPE_PD:
> > +               mode =3D V_SET_ACTIVE_MODE_DEDICATED;
> > +               break;
> > +       case POWER_SUPPLY_USB_TYPE_SDP:
> > +               mode =3D V_SET_ACTIVE_MODE_BC12_SDP;
> > +               break;
> > +       case POWER_SUPPLY_USB_TYPE_DCP:
> > +               mode =3D V_SET_ACTIVE_MODE_BC12_DCP;
> > +               break;
> > +       case POWER_SUPPLY_USB_TYPE_CDP:
> > +               mode =3D V_SET_ACTIVE_MODE_BC12_CDP;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       return regmap_update_bits(info->regmap, UCS1002_REG_SWITCH_CFG,
> > +                                 V_SET_ACTIVE_MODE_MASK, mode);
> > +}
> > +
> > +static int ucs1002_get_usb_type(struct ucs1002_info *info,
> > +                               union power_supply_propval *val)
> > +{
> > +       enum power_supply_usb_type type;
> > +       unsigned int reg;
> > +       int ret;
> > +
> > +       ret =3D regmap_read(info->regmap, UCS1002_REG_PIN_STATUS, &reg)=
;
> > +       if (ret)
> > +               return ret;
> > +
> > +       switch (reg & F_ACTIVE_MODE_MASK) {
> > +       default:
> > +               type =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> > +               break;
> > +       case F_ACTIVE_MODE_DEDICATED:
> > +               type =3D POWER_SUPPLY_USB_TYPE_PD;
> > +               break;
> > +       case F_ACTIVE_MODE_BC12_SDP:
> > +               type =3D POWER_SUPPLY_USB_TYPE_SDP;
> > +               break;
> > +       case F_ACTIVE_MODE_BC12_DCP:
> > +               type =3D POWER_SUPPLY_USB_TYPE_DCP;
> > +               break;
> > +       case F_ACTIVE_MODE_BC12_CDP:
> > +               type =3D POWER_SUPPLY_USB_TYPE_CDP;
> > +               break;
> > +       };
> > +
> > +       val->intval =3D type;
> > +
> > +       return 0;
> > +}
> > +
> > +static int ucs1002_get_health(struct ucs1002_info *info,
> > +                             union power_supply_propval *val)
> > +{
> > +       unsigned int reg;
> > +       int ret, health;
> > +
> > +       ret =3D regmap_read(info->regmap, UCS1002_REG_INTERRUPT_STATUS,=
 &reg);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (reg & F_TSD)
> > +               health =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> > +       else if (reg & (F_OVER_VOLT | F_BACK_VOLT))
> > +               health =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> > +       else if (reg & F_OVER_ILIM)
> > +               health =3D POWER_SUPPLY_HEALTH_OVERCURRENT;
> > +       else if (reg & (F_DISCHARGE_ERR | F_MIN_KEEP_OUT))
> > +               health =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> > +       else
> > +               health =3D POWER_SUPPLY_HEALTH_GOOD;
> > +
> > +       val->intval =3D health;
> > +
> > +       return 0;
> > +}
> > +
> > +static int ucs1002_get_property(struct power_supply *psy,
> > +                               enum power_supply_property psp,
> > +                               union power_supply_propval *val)
> > +{
> > +       struct ucs1002_info *info =3D power_supply_get_drvdata(psy);
> > +
> > +       switch (psp) {
> > +       case POWER_SUPPLY_PROP_ONLINE:
> > +               return ucs1002_get_online(info, val);
> > +       case POWER_SUPPLY_PROP_CHARGE_NOW:
> > +               return ucs1002_get_charge(info, val);
> > +       case POWER_SUPPLY_PROP_CURRENT_NOW:
> > +               return ucs1002_get_current(info, val);
> > +       case POWER_SUPPLY_PROP_CURRENT_MAX:
> > +               return ucs1002_get_max_current(info, val);
> > +       case POWER_SUPPLY_PROP_USB_TYPE:
> > +               return ucs1002_get_usb_type(info, val);
> > +       case POWER_SUPPLY_PROP_HEALTH:
> > +               return ucs1002_get_health(info, val);
> > +       case POWER_SUPPLY_PROP_PRESENT:
> > +               val->intval =3D info->present;
> > +               return 0;
> > +       case POWER_SUPPLY_PROP_MANUFACTURER:
> > +               val->strval =3D UCS1002_MANUFACTURER;
> > +               return 0;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static int ucs1002_set_property(struct power_supply *psy,
> > +                               enum power_supply_property psp,
> > +                               const union power_supply_propval *val)
> > +{
> > +       struct ucs1002_info *info =3D power_supply_get_drvdata(psy);
> > +
> > +       switch (psp) {
> > +       case POWER_SUPPLY_PROP_CURRENT_MAX:
> > +               return ucs1002_set_max_current(info, val->intval);
> > +       case POWER_SUPPLY_PROP_USB_TYPE:
> > +               return ucs1002_set_usb_type(info, val->intval);
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static int ucs1002_property_is_writeable(struct power_supply *psy,
> > +                                        enum power_supply_property psp=
)
> > +{
> > +       switch (psp) {
> > +       case POWER_SUPPLY_PROP_CURRENT_MAX:
> > +       case POWER_SUPPLY_PROP_USB_TYPE:
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> > +static const struct power_supply_desc ucs1002_charger_desc =3D {
> > +       .name                   =3D "ucs1002",
> > +       .type                   =3D POWER_SUPPLY_TYPE_USB,
> > +       .usb_types              =3D ucs1002_usb_types,
> > +       .num_usb_types          =3D ARRAY_SIZE(ucs1002_usb_types),
> > +       .get_property           =3D ucs1002_get_property,
> > +       .set_property           =3D ucs1002_set_property,
> > +       .property_is_writeable  =3D ucs1002_property_is_writeable,
> > +       .properties             =3D ucs1002_props,
> > +       .num_properties         =3D ARRAY_SIZE(ucs1002_props),
> > +};
> > +
> > +static irqreturn_t ucs1002_charger_irq(int irq, void *data)
> > +{
> > +       int ret, regval;
> > +       bool present;
> > +       struct ucs1002_info *info =3D data;
> > +
> > +       present =3D info->present;
> > +
> > +       ret =3D regmap_read(info->regmap, UCS1002_REG_OTHER_STATUS, &re=
gval);
> > +       if (ret)
> > +               return IRQ_HANDLED;
> > +
> > +       /* update attached status */
> > +       info->present =3D (regval & F_ADET_PIN) ? true : false;
> > +
> > +       /* notify the change */
> > +       if (present !=3D info->present)
> > +               power_supply_changed(info->charger);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t ucs1002_alert_irq(int irq, void *data)
> > +{
> > +       struct ucs1002_info *info =3D data;
> > +
> > +       power_supply_changed(info->charger);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static const struct regulator_ops ucs1002_regulator_ops =3D {
> > +       .is_enabled     =3D regulator_is_enabled_regmap,
> > +       .enable         =3D regulator_enable_regmap,
> > +       .disable        =3D regulator_disable_regmap,
> > +};
> > +
> > +static const struct regulator_desc ucs1002_regulator_descriptor =3D {
> > +       .name           =3D "ucs1002-vbus",
> > +       .ops            =3D &ucs1002_regulator_ops,
> > +       .type           =3D REGULATOR_VOLTAGE,
> > +       .owner          =3D THIS_MODULE,
> > +       .enable_reg     =3D UCS1002_REG_SWITCH_CFG,
> > +       .enable_mask    =3D F_PWR_EN_SET,
> > +       .enable_val     =3D F_PWR_EN_SET,
> > +       .fixed_uV       =3D 5000000,
> > +       .n_voltages     =3D 1,
> > +};
> > +
> > +static int ucs1002_probe(struct i2c_client *client,
> > +                        const struct i2c_device_id *dev_id)
> > +{
> > +       struct device *dev =3D &client->dev;
> > +       struct power_supply_config charger_config =3D {};
> > +       const struct regmap_config regmap_config =3D {
> > +               .reg_bits =3D 8,
> > +               .val_bits =3D 8,
> > +       };
> > +       struct regulator_config regulator_config =3D {};
> > +       int irq_a_det, irq_alert, ret;
> > +       struct regulator_dev *rdev;
> > +       struct ucs1002_info *info;
> > +       unsigned int regval;
> > +
> > +       info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> > +       if (!info)
> > +               return -ENOMEM;
> > +
> > +       info->regmap =3D devm_regmap_init_i2c(client, &regmap_config);
> > +       if (IS_ERR(info->regmap)) {
> > +               ret =3D PTR_ERR(info->regmap);
> > +               dev_err(dev, "regmap initialization failed: %d\n", ret)=
;
> > +               return ret;
> > +       }
> > +
> > +       info->client =3D client;
> > +
> > +       irq_a_det =3D of_irq_get_byname(dev->of_node, "a_det");
> > +       irq_alert =3D of_irq_get_byname(dev->of_node, "alert");
> > +
> > +       charger_config.of_node =3D dev->of_node;
> > +       charger_config.drv_data =3D info;
> > +
> > +       ret =3D regmap_read(info->regmap, UCS1002_REG_PRODUCT_ID, &regv=
al);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (regval !=3D UCS1002_PRODUCT_ID) {
> > +               dev_err(dev,
> > +                       "Product ID does not match (0x%02x !=3D 0x%02x)=
\n",
> > +                       regval, UCS1002_PRODUCT_ID);
> > +               return -ENODEV;
> > +       }
> > +
> > +       dev_info(dev, "registered with product id 0x%02x\n", regval);
> > +
> > +       /* Enable charge rationing by default */
> > +       ret =3D regmap_update_bits(info->regmap, UCS1002_REG_GENERAL_CF=
G,
> > +                                F_RATION_EN, F_RATION_EN);
> > +       if (ret)
> > +               return ret;
> > +
> > +       dev_dbg(dev, "set active mode selection through i2c\n");
> > +       /*
> > +        * Ignore the M1, M2, PWR_EN, and EM_EN pin states. Set active
> > +        * mode selection to Dedicated Charger Emulation Cycle.
> > +        *
> > +        * #M1    #M2    EM_EN
> > +        *  0      0       1   - Dedicated Charger Emulation Cycle
> > +        *
> > +        */
> > +       ret =3D regmap_update_bits(info->regmap, UCS1002_REG_SWITCH_CFG=
,
> > +                                F_PIN_IGNORE | F_EM_EN_SET | F_M2_SET =
|
> > +                                F_M1_SET, F_PIN_IGNORE | F_EM_EN_SET);
> > +       if (ret)
> > +               return ret;
> > +       /*
> > +        * Be safe and set initial current limit to 500mA
> > +        */
> > +       ret =3D ucs1002_set_max_current(info, 500000);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to read max current default\n");
> > +               return ret;
> > +       }
> > +
> > +       info->charger =3D devm_power_supply_register(dev, &ucs1002_char=
ger_desc,
> > +                                                  &charger_config);
> > +       if (IS_ERR(info->charger)) {
> > +               dev_err(dev, "failed to register power supply\n");
> > +               return PTR_ERR(info->charger);
> > +       }
> > +
> > +       ret =3D regmap_read(info->regmap, UCS1002_REG_PIN_STATUS, &regv=
al);
> > +       if (ret)
> > +               return ret;
> > +
> > +       info->regulator_descriptor =3D
> > +               devm_kmemdup(dev, &ucs1002_regulator_descriptor,
> > +                            sizeof(ucs1002_regulator_descriptor),
> > +                            GFP_KERNEL);
> > +       info->regulator_descriptor->enable_is_inverted =3D !(regval & F=
_SEL_PIN);
> > +
> > +       regulator_config.dev =3D dev;
> > +       regulator_config.of_node =3D dev->of_node;
> > +       regulator_config.regmap =3D info->regmap;
> > +
> > +       rdev =3D devm_regulator_register(dev, info->regulator_descripto=
r,
> > +                                      &regulator_config);
> > +       if (IS_ERR(rdev)) {
> > +               dev_err(dev, "failed to register VBUS regulator\n");
> > +               return PTR_ERR(rdev);
> > +       }
> > +
> > +       if (irq_a_det > 0) {
> > +               ret =3D devm_request_threaded_irq(dev, irq_a_det, NULL,
> > +                                               ucs1002_charger_irq,
> > +                                               IRQF_TRIGGER_FALLING |
> > +                                               IRQF_TRIGGER_RISING |
> > +                                               IRQF_ONESHOT,
> > +                                               "ucs1002-a_det", info);
> > +               if (ret) {
> > +                       dev_err(dev, "failed to request A_DET threaded =
irq\n");
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       if (irq_alert > 0) {
> > +               ret =3D devm_request_threaded_irq(dev, irq_alert, NULL,
> > +                                               ucs1002_alert_irq,
> > +                                               IRQF_TRIGGER_FALLING |
> > +                                               IRQF_TRIGGER_RISING |
> > +                                               IRQF_ONESHOT,
> > +                                               "ucs1002-alert", info);
> > +               if (ret) {
> > +                       dev_err(dev, "failed to request ALERT threaded =
irq\n");
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_OF)
>
> This driver is DT only, this if is not needed.
>

Missed this, will drop in v2.

> > +static const struct of_device_id ucs1002_of_match[] =3D {
> > +       { .compatible =3D "microchip,ucs1002", },
> > +       { /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, ucs1002_of_match);
> > +#endif
> > +
> > +static const struct i2c_device_id ucs1002_ids[] =3D {
> > +       {"ucs1002", 0},
> > +       { /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ucs1002_ids);
> > +
> > +static struct i2c_driver ucs1002_driver =3D {
> > +       .driver =3D {
> > +                  .name =3D "ucs1002",
> > +                  .of_match_table =3D of_match_ptr(ucs1002_of_match),
>
> No need to use of_match_ptr, is DT-only.
>

Ditto.

> > +       },
> > +       .probe =3D ucs1002_probe,
> > +};
> > +module_i2c_driver(ucs1002_driver);
> > +
> > +MODULE_DESCRIPTION("Microchip UCS1002 Programmable USB Port Power Cont=
roller");
> > +MODULE_AUTHOR("Enric Balletbo Serra <enric.balletbo@collabora.com>");
>
> I'm not sure how much differs this patch from the one I sent 3 years
> ago ... but if i'm the author or co-author you should add the
> signed-off-by.
>
> [1] https://lkml.org/lkml/2016/3/14/233
> [2] https://www.spinics.net/lists/devicetree/msg122745.html
>

Yeah, you're right. Will add in v2.

Thanks,
Andrey Smirnov
