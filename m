Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE72CC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8983E20866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551623902;
	bh=I3ForcG84qOojCHsVQgtiMWgqnIQCoZ+dlB7Nt6d/1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YUlXhqAucKLmOBOTA9dxti1ud5B6ah5cGYat7U8Ax9Epj8MRxkZActwBt2N1yJzPJ
	 ECaEbBgmHkDpvsNVLc2WlThDxuuqkL/HmxjZ1QqtIEX0T2YwHMzi4C8XH7Q9obg6ee
	 1qApWPGyxO8hYRINnmIYS7NgeHPK1ql4jGkvIcYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfCCOiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 09:38:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfCCOiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 09:38:20 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4CEE20836;
        Sun,  3 Mar 2019 14:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551623898;
        bh=I3ForcG84qOojCHsVQgtiMWgqnIQCoZ+dlB7Nt6d/1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W+p66yx1L7qN4EECsMX1iHcCciDhMyzaCtOBJM9ag/H7v41KE0fPoY3VR22qjftjb
         dCxCIF4ZE7xqgJPkO2oQtbogornF0RWDBzrHNe3Nt9OEzl1XpIQVkCrTg3Ae4SZcKh
         w8pn6asrCsGAoPjnjfh9HX9+/RmGJIIN4w/iXEkM=
Date:   Sun, 3 Mar 2019 14:38:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Robert Eshleman <bobbyeshleman@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: light: Add driver for ap3216c
Message-ID: <20190303143813.3b5a3f22@archlinux>
In-Reply-To: <CAGngYiUkdehPwyN-oEBrUOpBzvkHef=TwyjCXKYawB54pmAdVg@mail.gmail.com>
References: <42dbbd7568e4216a320c6fd617bd91c1ee045af0.1551037168.git.bobbyeshleman@gmail.com>
        <CAGngYiUkdehPwyN-oEBrUOpBzvkHef=TwyjCXKYawB54pmAdVg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 11:49:54 -0500
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> Hi, comments inline.
>=20
> On Sun, Feb 24, 2019 at 3:36 PM Robert Eshleman <bobbyeshleman@gmail.com>=
 wrote:
> >
> >     This patch adds support for the ap3216c ambient light and proximity
> >     sensor.
> >
> >     Supported features include:
> >
> >     * Illuminance (lux)
> >     * Proximity (raw)
> >     * IR (raw)
> >     * Rising/falling threshold events for illuminance and proximity
> >     * Calibration scale for illuminance
> >     * Calibration bias for proximity
> >
> > Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
Hmm. Just been thinking a bit about the events on here and wondered
if it is possible to mask them through careful use of the threshold
values - i.e. can we stop the hardware generating the interrupts for
the ones we don't want. It would be unusual for hardware to be
designed where this wasn't possible.

=46rom reading the datasheet I think we can, but obviously you will want
to try checking!

So for the lower thresholds the DS states:
An interrupt is triggered when ALS ADC (Registers 0CH & 0DH) < ALS ADC Low =
Threshold.
So if we set the low threshold to 0 that is never true.
For the high thresholds
An interrupt is triggered when ALS ADC (Registers 0CH and 0DH) > ALS ADC Hi=
gh Threshold
So if we set the threshold to the maximum value that is never true either.

So I'd propose a change to how you handle the thresholds.
When the value is set, if the threshold is not currently enabled, cache it =
rather than
directly writing.  When enabling then write the threshold.

This will get rid of any potential issues around the _en flags by moving it
all into hardware.

However it does depend on the datasheet being correct!

Otherwise, a few additional comments from me.
I piggy backed on Sven's review to hopefully avoid too much
repetition!

Jonathan

> > ---
> > Changes in v2:
> > - Add mutex protection in IRQ handler
> > - Support interrupt clearing for PS and ALS separately
> > - Mask away reserved bits when reading device registers
> > - Use regmap_bulk_read and regmap_bulk_write when possible
> > - Style cleanup
> >
> >  drivers/iio/light/Kconfig   |  11 +
> >  drivers/iio/light/Makefile  |   1 +
> >  drivers/iio/light/ap3216c.c | 809 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 821 insertions(+)
> >  create mode 100644 drivers/iio/light/ap3216c.c
> >
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index 36f458433480..74688d19beb1 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -41,6 +41,17 @@ config AL3320A
> >          To compile this driver as a module, choose M here: the
> >          module will be called al3320a.
> >
> > +config AP3216C
> > +       tristate "AP3216C Ambient Light and Proximity sensor"
> > +       select REGMAP_I2C
> > +       depends on I2C
> > +       help
> > +         Say Y here to build a driver for the AP3216C Ambient Light and
> > +         Proximity sensor.
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called ap3216c.
> > +
> >  config APDS9300
> >         tristate "APDS9300 ambient light sensor"
> >         depends on I2C
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index 286bf3975372..7d2f8fa0f30d 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -7,6 +7,7 @@
> >  obj-$(CONFIG_ACPI_ALS)         +=3D acpi-als.o
> >  obj-$(CONFIG_ADJD_S311)                +=3D adjd_s311.o
> >  obj-$(CONFIG_AL3320A)          +=3D al3320a.o
> > +obj-$(CONFIG_AP3216C)          +=3D ap3216c.o
> >  obj-$(CONFIG_APDS9300)         +=3D apds9300.o
> >  obj-$(CONFIG_APDS9960)         +=3D apds9960.o
> >  obj-$(CONFIG_BH1750)           +=3D bh1750.o
> > diff --git a/drivers/iio/light/ap3216c.c b/drivers/iio/light/ap3216c.c
> > new file mode 100644
> > index 000000000000..aaa319b932e6
> > --- /dev/null
> > +++ b/drivers/iio/light/ap3216c.c
> > @@ -0,0 +1,809 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * AP3216C Ambient Light and Infrared Proximity Sensor
> > + *
> > + * Copyright (c) 2019, Robert Eshleman.
> > + *
> > + * Datasheet: https://pdf-datasheet-datasheet.netdna-ssl.com/pdf-down/=
A/P/3/AP3216C-LITE-ON.pdf
> > + *
> > + * 7-bit I2C slave address 0x1E
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/bits.h>
> > +#include <linux/regmap.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/events.h>
> > +
> > +#define AP3216C_DRV_NAME "ap3216c"
> > +
> > +/* register addresses */
> > +#define AP3216C_SYS 0x0
> > +#define AP3216C_INT_STATUS 0x01
> > +#define AP3216C_INT_CLR 0x02
> > +#define AP3216C_IR_DATA_LO 0x0A
> > +#define AP3216C_IR_DATA_HI 0x0B
> > +#define AP3216C_ALS_DATA_LO 0x0C
> > +#define AP3216C_ALS_DATA_HI 0x0D
> > +#define AP3216C_PS_DATA_LO 0x0E
> > +#define AP3216C_PS_DATA_HI 0x0F
> > +#define AP3216C_ALS_CFG 0x10
> > +#define AP3216C_ALS_CALIB 0x19
> > +#define AP3216C_ALS_LO_THR_LO 0x1A
> > +#define AP3216C_ALS_LO_THR_HI 0x1B
> > +#define AP3216C_ALS_HI_THR_LO 0x1C
> > +#define AP3216C_ALS_HI_THR_HI 0x1D
> > +#define AP3216C_PS_CFG 0x20
> > +#define AP3216C_PS_CALIB_LO 0x28
> > +#define AP3216C_PS_CALIB_HI 0x29
> > +#define AP3216C_PS_LO_THR_LO 0x2A
> > +#define AP3216C_PS_LO_THR_HI 0x2B
> > +#define AP3216C_PS_HI_THR_LO 0x2C
> > +#define AP3216C_PS_HI_THR_HI 0x2D
> > +
> > +/* SYS_MODE mask and config value */
> > +#define AP3216C_SYS_MODE_ALS_PS 0x3
> > +
> > +/* INT_STATUS masks and config value */
> > +#define AP3216C_INT_STATUS_ALS_MASK BIT(0)
> > +#define AP3216C_INT_STATUS_PS_MASK BIT(1) =20
>=20
> these are identical to PS_CLR, ALS_CLR?
> maybe just use AP3216C_INT_STATUS_[PS|ALS] for both?
>=20
> > +#define AP3216C_INT_STATUS_CLR GENMASK(1, 0) =20
>=20
> unused?
>=20
> > +#define AP3216C_INT_ALS_CLR BIT(0)
> > +#define AP3216C_INT_PS_CLR BIT(1)
> > +#define AP3216C_INT_CLR_MANUAL 1
> > +
> > +/* IR_DATA mask/shift */
> > +#define AP3216C_IR_DATA_LO_MASK GENMASK(1, 0)
> > +#define AP3216C_IR_DATA_HI_SHIFT 2
> > +
> > +/* ALS_DATA shift and fractional helper */
> > +#define AP3216C_ALS_DATA_HI_SHIFT 8
> > +#define AP3216C_ALS_DATA_DENOM 100000
> > +
> > +/* ALS_CALIB masks/shifts */
> > +#define AP3216C_ALS_CALIB_INT_MASK GENMASK(7, 6)
> > +#define AP3216C_ALS_CALIB_INT_SHIFT 6
> > +#define AP3216C_ALS_CALIB_DEC_MASK GENMASK(5, 0)
> > +
> > +/* PS_DATA shifts/masks/bits */
> > +#define AP3216C_PS_DATA_LO_MASK GENMASK(3, 0)
> > +#define AP3216C_PS_DATA_LO_IR_OF BIT(6)
> > +#define AP3216C_PS_DATA_HI_MASK GENMASK(5, 0)
> > +#define AP3216C_PS_DATA_HI_SHIFT 4
> > +#define AP3216C_PS_DATA_HI_IR_OF BIT(6)
> > +
> > +/* ALS_CFG masks */
> > +#define AP3216C_ALS_CFG_GAIN_MASK GENMASK(5, 4)
> > +#define AP3216C_ALS_CFG_GAIN_SHIFT 4
> > +
> > +/* ALS_CALIB shifts */
> > +#define AP3216C_ALS_CALIB_INT_SHIFT 6
> > +
> > +/* ALS_HI_THR masks and shifts */
> > +#define AP3216C_ALS_HI_THR_LO_MASK GENMASK(7, 0)
> > +#define AP3216C_ALS_HI_THR_HI_SHIFT 8
> > +#define AP3216C_ALS_HI_THR_HI_MASK GENMASK(16, 8)
> > +#define AP3216C_ALS_HI_THR_HI_READ_MASK GENMASK(7, 0)
> > +#define AP3216C_ALS_HI_THR_HI_SHIFT 8
> > +
> > +#define AP3216C_ALS_THR_HI_SHIFT 8
> > +
> > +/* ALS_LO_THR masks and shifts */
> > +#define AP3216C_ALS_LO_THR_LO_MASK GENMASK(7, 0)
> > +#define AP3216C_ALS_LO_THR_HI_MASK GENMASK(16, 8)
> > +#define AP3216C_ALS_LO_THR_HI_SHIFT 8
> > +
> > +/* PS_CFG reg mask/shift/bit values */
> > +#define AP3216C_PS_CFG_GAIN_MASK GENMASK(3, 2)
> > +#define AP3216C_PS_CFG_GAIN_SHIFT 2
> > +#define AP3216C_PS_CFG_GAIN(val) \
> > +       (1 << ((val & AP3216C_PS_CFG_GAIN_MASK) >> AP3216C_PS_CFG_GAIN_=
SHIFT))
> > +
> > +/* PS_LO and PS_HI multiplier values */
> > +#define AP3216C_PS_LO_THR_HI_MULT 4
> > +#define AP3216C_PS_HI_THR_HI_MULT 4
> > +#define AP3216C_PS_THR_HI_MULT 4
> > +
> > +/* PS_THR_LO and PS_THR_HI masks/shifts */
> > +#define AP3216C_PS_THR_LO_MASK GENMASK(1, 0)
> > +#define AP3216C_PS_THR_HI_MASK GENMASK(10, 2)
> > +#define AP3216C_PS_THR_HI_SHIFT 2
> > +
> > +/* PS_CALIB_HI and PS_CALIB_LO shift/mask/bit values */
> > +#define AP3216C_PS_CALIB_HI_SHIFT 1
> > +#define AP3216C_PS_CALIB_HI_MASK GENMASK(8, 1)
> > +#define AP3216C_PS_CALIB_LO_MASK BIT(0)
> > +
> > +/* ALS fractional helper values */
> > +#define AP3216C_ALS_INTEG_MULT 1000
> > +#define AP3216C_ALS_FRACT_DIV 100
> > +
> > +/* ALS_CALIB min/max values (0.0 <=3D ALS_CALIB <=3D 3.984375) */
> > +#define AP3216C_ALS_CALIB_INT_MIN 0
> > +#define AP3216C_ALS_CALIB_DEC_MIN 0
> > +#define AP3216C_ALS_CALIB_INT_MAX 3
> > +#define AP3216C_ALS_CALIB_DEC_MAX 984375
> > +
> > +/* ALS_CALIB conversion denominator */
> > +#define AP3216C_ALS_CALIB_DENOM 64
> > +
> > +#define AP3216C_IIO_MULT 1000000
> > +#define AP3216C_PS_THR_MAX (BIT(10) - 1)
> > +
> > +/* See ALS configuration ALS_GAIN field in datasheet */
> > +#define AP3216C_ALS_THR_MAX 20661
> > +
> > +static const u16 ap3216c_gain_array[] =3D {
> > +       3500,  /* 0.3500 lux resolution */
> > +        788,  /* 0.0788 lux resolution */
> > +        197,  /* 0.0197 lux resolution */
> > +         49,  /* 0.0049 lux resolution */
> > +};
> > +
> > +static const u16 ap3216c_als_max_thr_array[] =3D {
> > +       20661,  /* max thr when gain is 0.3500 */
> > +        5162,  /* max thr when gain is 0.0788 */
> > +        1291,  /* max thr when gain is 0.0197 */
> > +         323,  /* max thr when gain is 0.0049*/
> > +};
> > +
> > +struct ap3216c_data {
> > +       struct regmap *regmap;
> > +       struct i2c_client *client;
> > +       struct mutex lock;
> > +       bool als_thresh_en;
> > +       bool prox_thresh_en;
> > +};
> > +
> > +static const struct iio_event_spec ap3216c_event_spec[] =3D {
> > +       {
> > +               .type =3D IIO_EV_TYPE_THRESH,
> > +               .dir =3D IIO_EV_DIR_RISING,
> > +               .mask_separate =3D BIT(IIO_EV_INFO_VALUE),
> > +       },
> > +       {
> > +               .type =3D IIO_EV_TYPE_THRESH,
> > +               .dir =3D IIO_EV_DIR_FALLING,
> > +               .mask_separate =3D BIT(IIO_EV_INFO_VALUE),
> > +       },
> > +       {
> > +               .type =3D IIO_EV_TYPE_THRESH,
> > +               .dir =3D IIO_EV_DIR_EITHER,
> > +               .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE),
> > +       },
> > +};
> > +
> > +static const struct iio_chan_spec ap3216c_channels[] =3D {
> > +       {
> > +               .type =3D IIO_LIGHT,
> > +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED) |
> > +                                     BIT(IIO_CHAN_INFO_CALIBSCALE),
> > +               .event_spec =3D ap3216c_event_spec,
> > +               .num_event_specs =3D ARRAY_SIZE(ap3216c_event_spec),
> > +       },
> > +       {
> > +               .type =3D IIO_PROXIMITY,
> > +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                     BIT(IIO_CHAN_INFO_CALIBBIAS),
> > +               .event_spec =3D ap3216c_event_spec,
> > +               .num_event_specs =3D ARRAY_SIZE(ap3216c_event_spec),
> > +       },
> > +       {
> > +               .type =3D IIO_LIGHT,
> > +               .modified =3D 1,
> > +               .channel2 =3D IIO_MOD_LIGHT_IR,
> > +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > +       }
> > +};
> > +
> > +static int ap3216c_read_gain(struct ap3216c_data *data, u16 *gain)
> > +{
> > +       unsigned int cfg;
> > +       int ret;
> > +
> > +       ret =3D regmap_read(data->regmap, AP3216C_ALS_CFG, &cfg);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       *gain =3D ap3216c_gain_array[(cfg & AP3216C_ALS_CFG_GAIN_MASK) =
>>
> > +                                   AP3216C_ALS_CFG_GAIN_SHIFT];
> > +       return 0;
> > +}
> > +
> > +static int ap3216c_read_max_thr(struct ap3216c_data *data, u16 *max_th=
r)
> > +{
> > +       unsigned int cfg;
> > +       int ret;
> > +
> > +       ret =3D regmap_read(data->regmap, AP3216C_ALS_CFG, &cfg);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       /* max thr is derived from the gain bits of ALS_CFG */
> > +       *max_thr =3D ap3216c_als_max_thr_array[
> > +                       (cfg & AP3216C_ALS_CFG_GAIN_MASK) >>
> > +                        AP3216C_ALS_CFG_GAIN_SHIFT];
> > +       return 0;
> > +}
> > +
> > +static int ap3216c_write_event_value(struct iio_dev *indio_dev,
> > +                                    const struct iio_chan_spec *chan,
> > +                                    enum iio_event_type type,
> > +                                    enum iio_event_direction dir,
> > +                                    enum iio_event_info info,
> > +                                    int val, int val2)
> > +{
> > +       struct ap3216c_data *data =3D iio_priv(indio_dev);
> > +       u8 vals[2];
> > +       int integral, fractional;
> > +       u16 thr, max_thr, gain;
> > +       int ret;
> > +
> > +       if (val < 0 || val2 < 0)
> > +               return -EINVAL;
> > +
> > +       switch (chan->type) {
> > +       case IIO_LIGHT:
> > +               ret =3D ap3216c_read_max_thr(data, &max_thr);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               if (val > max_thr)
> > +                       val =3D max_thr;
> > +
> > +               ret =3D ap3216c_read_gain(data, &gain);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               integral =3D val * AP3216C_ALS_INTEG_MULT / gain;
> > +               fractional =3D val2 / AP3216C_ALS_FRACT_DIV / gain;
> > +
> > +               thr =3D integral + fractional;
> > +
> > +               switch (dir) {
> > +               case IIO_EV_DIR_RISING:
> > +                       vals[0] =3D thr & AP3216C_ALS_HI_THR_LO_MASK;
> > +                       vals[1] =3D (thr & AP3216C_ALS_HI_THR_HI_MASK) =
>>
> > +                                  AP3216C_ALS_HI_THR_HI_SHIFT;
> > +
> > +                       return regmap_bulk_write(data->regmap,
> > +                                                AP3216C_ALS_HI_THR_LO,
> > +                                                vals, 2);
> > +
> > +               case IIO_EV_DIR_FALLING:
> > +                       vals[0] =3D thr & AP3216C_ALS_LO_THR_LO_MASK;
> > +                       vals[1] =3D (thr & AP3216C_ALS_LO_THR_HI_MASK) =
>>
> > +                                  AP3216C_ALS_LO_THR_HI_SHIFT;
> > +
> > +                       return regmap_bulk_write(data->regmap,
> > +                                                AP3216C_ALS_LO_THR_LO,
> > +                                                vals, 2);
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +
> > +
> > +       case IIO_PROXIMITY:
> > +               if (val > AP3216C_PS_THR_MAX)
> > +                       val =3D AP3216C_PS_THR_MAX;
> > +
> > +               vals[0] =3D val & AP3216C_PS_THR_LO_MASK;
> > +               vals[1] =3D (val & AP3216C_PS_THR_HI_MASK) >>
> > +                          AP3216C_PS_THR_HI_SHIFT;
> > +
> > +               switch (dir) {
> > +               case IIO_EV_DIR_RISING:
> > +                       return regmap_bulk_write(data->regmap,
> > +                                                AP3216C_PS_HI_THR_LO,
> > +                                                vals, 2);
> > +
> > +               case IIO_EV_DIR_FALLING:
> > +                       return regmap_bulk_write(data->regmap,
> > +                                                AP3216C_PS_LO_THR_LO,
> > +                                                vals, 2);
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static int ap3216c_get_als_reg(enum iio_event_direction dir)
> > +{
> > +       switch (dir) {
> > +       case IIO_EV_DIR_RISING:
> > +               return AP3216C_ALS_HI_THR_LO;
> > +
> > +       case IIO_EV_DIR_FALLING:
> > +               return AP3216C_ALS_LO_THR_LO;
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static int ap3216c_get_ps_reg(enum iio_event_direction dir)
> > +{
> > +       switch (dir) {
> > +       case IIO_EV_DIR_RISING:
> > +               return AP3216C_PS_HI_THR_LO;
> > +
> > +       case IIO_EV_DIR_FALLING:
> > +               return AP3216C_PS_LO_THR_LO;
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static int ap3216c_read_event_value(struct iio_dev *indio_dev,
> > +                                    const struct iio_chan_spec *chan,
> > +                                    enum iio_event_type type,
> > +                                    enum iio_event_direction dir,
> > +                                    enum iio_event_info info,
> > +                                    int *val, int *val2)
> > +{
> > +       struct ap3216c_data *data =3D iio_priv(indio_dev);
> > +       u16 gain;
> > +       u8 vals[2];
> > +       int reg, ret;
> > +
> > +       switch (chan->type) {
> > +       case IIO_LIGHT:
> > +               reg =3D ap3216c_get_als_reg(dir);
> > +               if (reg < 0)
> > +                       return reg;
> > +
> > +               ret =3D regmap_bulk_read(data->regmap, reg, vals, 2);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               ret =3D ap3216c_read_gain(data, &gain);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               *val =3D ((vals[1] << AP3216C_ALS_THR_HI_SHIFT) | vals[=
0]) *
> > +                        gain / AP3216C_ALS_INTEG_MULT;
> > +               return IIO_VAL_INT;
> > +
> > +       case IIO_PROXIMITY:
> > +               reg =3D ap3216c_get_ps_reg(dir);
> > +               if (reg < 0)
> > +                       return reg;
> > +
> > +               ret =3D regmap_bulk_read(data->regmap, reg, vals, 2);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               *val =3D (vals[1] << 2) | (vals[0] & AP3216C_PS_THR_LO_=
MASK);
> > +
> > +               return IIO_VAL_INT;
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static int ap3216c_read_event_config(struct iio_dev *indio_dev,
> > +                                   const struct iio_chan_spec *chan,
> > +                                   enum iio_event_type type,
> > +                                   enum iio_event_direction dir)
> > +{
> > +       struct ap3216c_data *data =3D iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       mutex_lock(&data->lock);
> > +       switch (chan->type) {
> > +       case IIO_LIGHT:
> > +               ret =3D data->als_thresh_en;
> > +               break;
> > +
> > +       case IIO_PROXIMITY:
> > +               ret =3D data->prox_thresh_en;
> > +               break;
> > +
> > +       default:
> > +               ret =3D -EINVAL;
> > +               break;
> > +       }
> > +       mutex_unlock(&data->lock);
> > +
> > +       return ret;
> > +}
> > +
> > +static int ap3216c_write_event_config(struct iio_dev *indio_dev,
> > +                                    const struct iio_chan_spec *chan,
> > +                                    enum iio_event_type type,
> > +                                    enum iio_event_direction dir, int =
state)
> > +{
> > +       struct ap3216c_data *data =3D iio_priv(indio_dev);
> > +       int ret =3D 0;
> > +
> > +       mutex_lock(&data->lock);
> > +       switch (chan->type) {
> > +       case IIO_LIGHT: =20
>=20
> is it ok to allow userspace to set thresh_en =3D 1, even if the chip's ir=
q line
> is not connected ? (client->irq =3D=3D 0) ?
Good catch.
Indeed doesn't make much sense.

The best way to handle this is to have two iio_chan_spec arrays, one
with events and one without. Pick between them at probe time.
That way the interface to set this is not there unless it will actually
work.

>=20
> > +               data->als_thresh_en =3D state;
> > +               break;
> > +
> > +       case IIO_PROXIMITY:
> > +               data->prox_thresh_en =3D state;
> > +               break;
> > +
> > +       default:
> > +               ret =3D -EINVAL;
> > +               break;
> > +       }
> > +       mutex_unlock(&data->lock);
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct regmap_config ap3216c_regmap_config =3D {
> > +       .reg_bits =3D 8,
> > +       .val_bits =3D 8,
> > +       .max_register =3D AP3216C_PS_HI_THR_HI,
> > +}; =20
>=20
> IMHO using this config, bulk_read may default to raw_read, i.e.
> bulk_read(regmap, ALS_DATA_LO, vals, 2) may result in a 2-byte read from
> ALS_DATA_LO. but looking at the datasheet page 9 (i2c read / read combine=
d)
> this i2c mode doesn't appear to be documented? the docs imply we should d=
o:
> single-byte read from ALS_DATA_LO, followed by single-byte read from
> ALS_DATA_HI.

Alternatively if you have a scope or equivalent to verify if it is doing
these as a multi byte read and working that would be even better.
It is not uncommon for hardware to implement fairly standard i2c features
like this and not document them because they weren't what the test code
the docs writer got given does! (may not be true here of course)


>=20
> maybe this works by accident?
> perhaps force the regmap core to follow the chip datasheet explicitly by =
adding
>        .use_single_rw =3D true,

use_single_read I think.

> ?
>=20
> > +
> > +/**
> > + * Returns integral part of decimal between 0.0 and 3.984275
> > + */
> > +static int ap3216c_als_calibscale_int(int val)
> > +{
> > +       if (val > AP3216C_ALS_CALIB_INT_MAX)
> > +               return AP3216C_ALS_CALIB_INT_MAX;
> > +
> > +       if (val <=3D AP3216C_ALS_CALIB_INT_MIN)
> > +               return AP3216C_ALS_CALIB_INT_MIN;
> > +
> > +       return val;
> > +}
> > +
> > +/**
> > + * Returns decimal part of decimal number between 0.0 and 3.984275
> > + */
> > +static int ap3216c_als_calibscale_dec(int val, int val2)
> > +{
> > +       /* Return max decimal if number exceeds calibscale max */
> > +       if (val > AP3216C_ALS_CALIB_INT_MAX ||
> > +           (val =3D=3D AP3216C_ALS_CALIB_INT_MAX &&
> > +            val2 > AP3216C_ALS_CALIB_DEC_MAX))
> > +               return AP3216C_ALS_CALIB_DEC_MAX;
> > +
> > +       /* Floor the decimal if integral below minimum */
> > +       if (val <=3D AP3216C_ALS_CALIB_INT_MIN)
> > +               return AP3216C_ALS_CALIB_DEC_MIN;
> > +
> > +       /* Floor the decimal if decimal below minimum */
> > +       if (val2 < AP3216C_ALS_CALIB_DEC_MIN)
> > +               return AP3216C_ALS_CALIB_DEC_MIN;
> > +
> > +       /* Return max decimal if decimal above maximum */
> > +       if (val2 > AP3216C_ALS_CALIB_DEC_MAX)
> > +               return AP3216C_ALS_CALIB_DEC_MAX;
> > +
> > +       return val2;
> > +}
> > +
> > +static int ap3216c_write_raw(struct iio_dev *indio_dev,
> > +                            struct iio_chan_spec const *chan,
> > +                            int val, int val2, long mask)
> > +{
> > +       struct ap3216c_data *data =3D iio_priv(indio_dev);
> > +       int integral, decimal;
> > +       u8 vals[2];
> > +       int tmp;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_CALIBSCALE:
> > +               switch (chan->type) {
> > +               case IIO_LIGHT:
> > +                       integral =3D ap3216c_als_calibscale_int(val);
> > +                       decimal =3D ap3216c_als_calibscale_dec(val, val=
2);
> > +
> > +                       tmp =3D integral << AP3216C_ALS_CALIB_INT_SHIFT;
> > +
> > +                       /*
> > +                        * Reverse scaling by multiplying by the scaling
> > +                        * denominator and dividing by IIO multiplier.
> > +                        */
> > +                       tmp |=3D (decimal * AP3216C_ALS_CALIB_DENOM) /
> > +                               AP3216C_IIO_MULT;
> > +
> > +                       return regmap_write(data->regmap,
> > +                                           AP3216C_ALS_CALIB, tmp);
> > +
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +
> > +       case IIO_CHAN_INFO_CALIBBIAS:
> > +               switch (chan->type) {
> > +               case IIO_PROXIMITY:
> > +                       vals[0] =3D val & AP3216C_PS_CALIB_LO_MASK;
> > +                       vals[1] =3D (val & AP3216C_PS_CALIB_HI_MASK) >>
> > +                                  AP3216C_PS_CALIB_HI_SHIFT;
> > +
> > +                       return regmap_bulk_write(data->regmap,
> > +                                                AP3216C_PS_CALIB_LO,
> > +                                                vals, 2);
> > +
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static int ap3216c_read_raw(struct iio_dev *indio_dev,
> > +                               struct iio_chan_spec const *chan,
> > +                               int *val, int *val2, long mask)
> > +{
> > +       struct ap3216c_data *data =3D iio_priv(indio_dev);
> > +       u16 gain;
> > +       u8 vals[2];
> > +       int cfg, tmp;
> > +       int ret;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_CALIBSCALE:
> > +               switch (chan->type) {
> > +               case IIO_LIGHT:
> > +                       ret =3D regmap_read(data->regmap,
> > +                                         AP3216C_ALS_CALIB, &tmp);
> > +                       if (ret < 0)
> > +                               return ret;
> > +
> > +                       /* Scale is multiplied by 1/64 */
> > +                       *val =3D tmp;
> > +                       *val2 =3D AP3216C_ALS_CALIB_DENOM;
> > +
> > +                       return IIO_VAL_FRACTIONAL;
> > +
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +
> > +       case IIO_CHAN_INFO_CALIBBIAS:
> > +               switch (chan->type) {
> > +               case IIO_PROXIMITY:
> > +                       ret =3D regmap_bulk_read(data->regmap,
> > +                                              AP3216C_PS_CALIB_LO,
> > +                                              vals, 2);
> > +                       if (ret < 0)
> > +                               return ret;
> > +
> > +                       *val =3D (vals[0] & AP3216C_PS_CALIB_LO_MASK) |
> > +                              ((vals[1] & AP3216C_PS_CALIB_HI_MASK) <<
> > +                               AP3216C_PS_CALIB_HI_SHIFT);
> > +
> > +                       return IIO_VAL_INT;
> > +
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +
> > +       case IIO_CHAN_INFO_PROCESSED:
> > +               switch (chan->type) {
> > +               case IIO_LIGHT:
> > +                       ret =3D regmap_bulk_read(data->regmap,
> > +                                              AP3216C_ALS_DATA_LO,
> > +                                              vals, 2);
> > +                       if (ret < 0)
> > +                               return ret;
> > +
> > +                       ret =3D ap3216c_read_gain(data, &gain);
> > +                       if (ret < 0)
> > +                               return ret;
> > +
> > +                       *val =3D ((vals[1] << AP3216C_ALS_DATA_HI_SHIFT=
) |
> > +                                vals[0]) * gain;
> > +                       *val2 =3D AP3216C_ALS_DATA_DENOM;
> > +
> > +                       return IIO_VAL_FRACTIONAL;
> > +
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +
> > +       case IIO_CHAN_INFO_RAW:
> > +               switch (chan->type) {
> > +               case IIO_LIGHT:
> > +                       if (chan->channel2 !=3D IIO_MOD_LIGHT_IR)
> > +                               return -EINVAL;
> > +
> > +                       ret =3D regmap_bulk_read(data->regmap,
> > +                                              AP3216C_IR_DATA_LO,
> > +                                              vals, 2); =20
>=20
> maybe add a comment that [IR|ALS|PS]_DATA_[HI_LO] registers are 'special':
> they have to be read in the correct order, and atomically, and document
> that bulk_read() currently satisfies those requirements ?
>=20
> otherwise this is easy to forget - even for our future selves :)

Agreed. This would definitely be good to have documented.

>=20
> > +
> > +                       *val =3D (vals[0] & AP3216C_IR_DATA_LO_MASK) |
> > +                              (vals[1] << AP3216C_IR_DATA_HI_SHIFT);
> > +
> > +
> > +                       return IIO_VAL_INT;
> > +
> > +               case IIO_PROXIMITY:
> > +                       ret =3D regmap_bulk_read(data->regmap,
> > +                                              AP3216C_PS_DATA_LO,
> > +                                              vals, 2);
> > +                       if (ret < 0)
> > +                               return ret;
> > +
> > +                       ret =3D regmap_read(data->regmap,
> > +                                         AP3216C_PS_CFG, &cfg);
> > +                       if (ret < 0)
> > +                               return ret;
> > +
> > +                       tmp =3D vals[0] & AP3216C_PS_DATA_LO_MASK;
> > +                       tmp |=3D (vals[1] & AP3216C_PS_DATA_HI_MASK) <<
> > +                               AP3216C_PS_DATA_HI_SHIFT;
> > +                       *val =3D tmp * AP3216C_PS_CFG_GAIN(cfg);
> > +
> > +                       return IIO_VAL_INT;
> > +
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static const struct iio_info ap3216c_info =3D {
> > +       .read_raw =3D ap3216c_read_raw,
> > +       .write_raw =3D ap3216c_write_raw,
> > +       .read_event_value =3D ap3216c_read_event_value,
> > +       .write_event_value =3D ap3216c_write_event_value,
> > +       .read_event_config =3D ap3216c_read_event_config,
> > +       .write_event_config =3D ap3216c_write_event_config,
> > +};
> > +
> > +static irqreturn_t ap3216c_event_handler(int irq, void *p)
> > +{
> > +       struct iio_dev *indio_dev =3D p;
> > +       struct ap3216c_data *data =3D iio_priv(indio_dev);
> > +       int status;
> > +       s64 timestamp;
> > +       int ret;
> > +
> > +       mutex_lock(&data->lock); =20
>=20
> IMHO the discussion between Jonathan & myself on your v1 patch ended with=
 the
> conclusion that a mutex isn't needed for visibility here - the mutex in k=
ernfs
> will ensure this. So there was consensus that the mutex here is not neede=
d.
>=20
> > +       ret =3D regmap_read(data->regmap, AP3216C_INT_STATUS, &status);
> > +       if (ret) {
> > +               dev_err(&data->client->dev, "error reading IRQ status\n=
");
> > +               goto done;
> > +       }
> > +
> > +       /* The IRQ was not from this device */
> > +       if (!status) {
> > +               mutex_unlock(&data->lock);
> > +               return IRQ_NONE;
> > +       }
> > +
> > +       timestamp =3D iio_get_time_ns(indio_dev);
> > +       if (status & AP3216C_INT_STATUS_PS_MASK) {
> > +               if (data->prox_thresh_en)

Hmm.  See comment at the top.  I think we can mask these in hardware by
playing with the thresholds.

> > +                       iio_push_event(indio_dev,
> > +                                      IIO_UNMOD_EVENT_CODE(IIO_PROXIMI=
TY, 0,
> > +                                                           IIO_EV_TYPE=
_THRESH,
> > +                                                           IIO_EV_DIR_=
EITHER),
> > +                                      timestamp);
> > +
> > +               ret =3D regmap_write(data->regmap,
> > +                                  AP3216C_INT_STATUS, AP3216C_INT_PS_C=
LR);
> > +               if (ret < 0)
> > +                       dev_err(&data->client->dev, "error clearing PS =
interrupt\n");
> > +       }
> > +
> > +       if (status & AP3216C_INT_STATUS_ALS_MASK) {
> > +               if (data->als_thresh_en)
> > +                       iio_push_event(indio_dev,
> > +                                      IIO_UNMOD_EVENT_CODE(IIO_LIGHT, =
0,
> > +                                                           IIO_EV_TYPE=
_THRESH,
> > +                                                           IIO_EV_DIR_=
EITHER),
> > +                                      timestamp);
> > +
> > +               ret =3D regmap_write(data->regmap,
> > +                                  AP3216C_INT_STATUS, AP3216C_INT_ALS_=
CLR);
> > +               if (ret < 0)
> > +                       dev_err(&data->client->dev, "error clearing ALS=
 interrupt\n");
> > +       }
> > +
> > +done:
> > +       mutex_unlock(&data->lock);
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static int ap3216c_probe(struct i2c_client *client,
> > +                         const struct i2c_device_id *id)
> > +{
> > +       struct ap3216c_data *data;
> > +       struct iio_dev *indio_dev;
> > +       int ret;
> > +
> > +       indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data)=
);
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       data =3D iio_priv(indio_dev);
> > +       data->client =3D client;
> > +       mutex_init(&data->lock);
> > +       indio_dev->dev.parent =3D &client->dev;
> > +       indio_dev->info =3D &ap3216c_info;
> > +       indio_dev->name =3D AP3216C_DRV_NAME;
> > +       indio_dev->channels =3D ap3216c_channels;
> > +       indio_dev->num_channels =3D ARRAY_SIZE(ap3216c_channels);
> > +
> > +       data->regmap =3D devm_regmap_init_i2c(client, &ap3216c_regmap_c=
onfig);
> > +       if (IS_ERR(data->regmap)) {
> > +               dev_err(&client->dev, "Failed to allocate register map\=
n");
> > +               return PTR_ERR(data->regmap);
> > +       }
> > +
> > +       /* Default to thresh events disabled */
> > +       data->als_thresh_en =3D false;
> > +       data->prox_thresh_en =3D false;
> > +
> > +       /*
> > +        * Require that that the interrupt is cleared only when the INT=
_STATUS
> > +        * register is written to, instead of when data is read.
> > +        */
> > +       ret =3D regmap_write(data->regmap,
> > +                          AP3216C_INT_CLR, AP3216C_INT_CLR_MANUAL);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret =3D regmap_write(data->regmap, AP3216C_INT_STATUS,
> > +                          AP3216C_INT_PS_CLR | AP3216C_INT_ALS_CLR);
> > +       if (ret < 0) {
> > +               dev_err(&data->client->dev, "error clearing interrupts\=
n");
> > +               return ret;
> > +       }
> > +
> > +       if (client->irq) {
> > +               ret =3D devm_request_threaded_irq(&client->dev, client-=
>irq,
> > +                                               NULL, ap3216c_event_han=
dler,
> > +                                               IRQF_TRIGGER_FALLING |
> > +                                               IRQF_SHARED | IRQF_ONES=
HOT,
> > +                                               client->name, indio_dev=
);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       /* Enable ALS and PS+IR */
> > +       ret =3D regmap_write(data->regmap, AP3216C_SYS, AP3216C_SYS_MOD=
E_ALS_PS);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> > +static const struct of_device_id ap3216c_of_match[] =3D {
> > +       { .compatible =3D "liteon,ap3216c", },
> > +       { },
> > +};
> > +MODULE_DEVICE_TABLE(of, ap3216c_of_match);
> > +
> > +static const struct i2c_device_id ap3216c_id[] =3D {
> > +       {"ap3216c", 0},
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ap3216c_id);
> > +
> > +static struct i2c_driver ap3216c_driver =3D {
> > +       .driver =3D {
> > +               .name   =3D AP3216C_DRV_NAME,
> > +       },
> > +       .probe          =3D ap3216c_probe,
> > +       .id_table       =3D ap3216c_id,
> > +};
> > +module_i2c_driver(ap3216c_driver);
> > +
> > +MODULE_AUTHOR("Robert Eshleman <bobbyeshleman@gmail.com>");
> > +MODULE_DESCRIPTION("AP3216C Ambient Light and Proximity Sensor");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.20.1
> > =20

