Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9A4C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554D72148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTvgsQAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfDXHod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:44:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43045 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDXHoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:44:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id u15so15266519otq.10;
        Wed, 24 Apr 2019 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qCjGxZmiCkiHUTMgOACp/Bx3F7z8GujZGFTCdjAFcSk=;
        b=eTvgsQADT+MJKUdz1OfDyz/dMeY7rN+YfTH4Q7mCirS/UZCOQiROrioKLI6coQ2lo0
         Cx688xgSatBKfA7lWqe6HiOkT75vkJieZEHptjeipEApAhT/whEKN1FuiZmoHeXcaTUY
         LrpXOZ4hIJrLFr3kLi3opf8SZuaEf7MAfYHGJLJxiVWvMJlU5q/mrlsXlBfhu/3YxFOC
         zPTeM8k3plJEdB7OUhHfks4lPC1FBF1NOoww0iXcE7oNXQXMmNqCS2wl06kQLqpLp0xL
         HOVbKwvXpgFcXXpLGzgG1LFhI2zT1nykaj/yXXjkK2sYS+bFYmRAdMRMFaz/1hTtN1kK
         jm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qCjGxZmiCkiHUTMgOACp/Bx3F7z8GujZGFTCdjAFcSk=;
        b=CZfw+1HPrRxDB+nL34VrqXBSvWvzMQV43xQnmnp/bsssbMVcmoo5aVJHO/Foif+Kp5
         Q+I2IrV9p4lhH9mypLtL6IZyLTVGNdH6D8OThJ3lWqcyee9Z/rtb9bUBDJH7lsA7l2sz
         jxAm6Kg+MM+/O4GCqV1A5DSAaXyRIkU0EZFtHWpVvA39gCX2x4B1t+JJ8uuO0mylRURT
         pyIaAD/QVagjFKJyrNVC5DKelVRsPEfMDxsxpg1Gnho8UXjKTCd142A+/aoHwOaA+OwD
         jD6wOrjeQqcO5R06PNbOMe1Vxcf38C2IkhdL2SVFwueHkXuFOQyvHUqk4anCDKUg9R8b
         E0Cg==
X-Gm-Message-State: APjAAAU4GJ1gwb+59HeCP34gSxmPybg66l2Tk1k65e1GOwZpgVnY1+xy
        C5vDJPPHQnxUlxBuEdAOYu0rkoCZGV3miWaYI5s=
X-Google-Smtp-Source: APXvYqxYORwgO8EaGKmzNTTr7R/pGRbQUBVRAGEUI9TTDcMgc6r6Az8wxniWjXgwq8+hcS8611Ws1y2BussBQyrAkVI=
X-Received: by 2002:a9d:491a:: with SMTP id e26mr1430678otf.66.1556091871589;
 Wed, 24 Apr 2019 00:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190423200045.6992-1-c.cantanheide@gmail.com>
In-Reply-To: <20190423200045.6992-1-c.cantanheide@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 24 Apr 2019 10:44:19 +0300
Message-ID: <CA+U=DsrH7NmPx0=cEToq=tw4Vk9N5NeJ6zh7GWbyN_z6C+5CYw@mail.gmail.com>
Subject: Re: [PATCH] Wqiio: adc: ad7766: Change alignment to match paranthesis
To:     =?UTF-8?Q?Camylla_Gon=C3=A7alves_Cantanheide?= 
        <c.cantanheide@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:01 PM Camylla Gon=C3=A7alves Cantanheide
<c.cantanheide@gmail.com> wrote:
>
> This commit align broken line to match upper line parenthesis,
> in lines 80, 130, 237, 242, 255, 264 and 293. Solves the checkpatch.pl's =
message:
>
> CHECK: Alignment should match open parenthesis
>
> In lines 130, 255, 264 and 293 it was necessary to break a line.
>

This patch seems duplicate.
I can't tell if it's different from the other.
Has the same problem.

> Signed-off-by: Camylla Gon=C3=A7alves Cantanheide <c.cantanheide@gmail.co=
m>
> ---
>  .../bindings/iio/adc/nuvoton,npcm-adc.txt     |  11 -
>  .../iio/chemical/plantower,pms7003.txt        |  20 ++
>  .../devicetree/bindings/vendor-prefixes.txt   |   1 +
>  drivers/iio/adc/ad7766.c                      |  22 +-
>  drivers/iio/chemical/Kconfig                  |  10 +
>  drivers/iio/chemical/Makefile                 |   1 +
>  drivers/iio/chemical/pms7003.c                | 340 ++++++++++++++++++
>  drivers/iio/chemical/sps30.c                  |   3 +
>  8 files changed, 388 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/planto=
wer,pms7003.txt
>  create mode 100644 drivers/iio/chemical/pms7003.c
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.t=
xt b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> index 1b8132cd9060..eb939fe77836 100644
> --- a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> @@ -14,11 +14,6 @@ Optional properties:
>                            vref-supply is not added the ADC will use inte=
rnal voltage
>                            reference.
>
> -Required Node in the NPCM7xx BMC:
> -An additional register is present in the NPCM7xx SOC which is
> -assumed to be in the same device tree, with and marked as
> -compatible with "nuvoton,npcm750-rst".
> -
>  Example:
>
>  adc: adc@f000c000 {
> @@ -27,9 +22,3 @@ adc: adc@f000c000 {
>         interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
>         clocks =3D <&clk NPCM7XX_CLK_ADC>;
>  };
> -
> -rst: rst@f0801000 {
> -       compatible =3D "nuvoton,npcm750-rst", "syscon",
> -       "simple-mfd";
> -       reg =3D <0xf0801000 0x6C>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms=
7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003=
.txt
> new file mode 100644
> index 000000000000..7b5f06f324c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.tx=
t
> @@ -0,0 +1,20 @@
> +* Plantower PMS7003 particulate matter sensor
> +
> +Required properties:
> +- compatible: must be "plantower,pms7003"
> +- vcc-supply: phandle to the regulator that provides power to the sensor
> +
> +Optional properties:
> +- plantower,set-gpios: phandle to the GPIO connected to the SET line
> +- reset-gpios: phandle to the GPIO connected to the RESET line
> +
> +Refer to serial/slave-device.txt for generic serial attached device bind=
ings.
> +
> +Example:
> +
> +&uart0 {
> +       air-pollution-sensor {
> +               compatible =3D "plantower,pms7003";
> +               vcc-supply =3D <&reg_vcc5v0>;
> +       };
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Docu=
mentation/devicetree/bindings/vendor-prefixes.txt
> index 389508584f48..42816baeb381 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -304,6 +304,7 @@ phytec      PHYTEC Messtechnik GmbH
>  picochip       Picochip Ltd
>  pine64 Pine64
>  pixcir  PIXCIR MICROELECTRONICS Co., Ltd
> +plantower Plantower Co., Ltd
>  plathome       Plat'Home Co., Ltd.
>  plda   PLDA
>  plx    Broadcom Corporation (formerly PLX Technology)
> diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
> index 3ae14fc8c649..101502435768 100644
> --- a/drivers/iio/adc/ad7766.c
> +++ b/drivers/iio/adc/ad7766.c
> @@ -77,7 +77,7 @@ static irqreturn_t ad7766_trigger_handler(int irq, void=
 *p)
>                 goto done;
>
>         iio_push_to_buffers_with_timestamp(indio_dev, ad7766->data,
> -               pf->timestamp);
> +                                          pf->timestamp);
>  done:
>         iio_trigger_notify_done(indio_dev->trig);
>
> @@ -127,7 +127,8 @@ static int ad7766_postdisable(struct iio_dev *indio_d=
ev)
>  }
>
>  static int ad7766_read_raw(struct iio_dev *indio_dev,
> -       const struct iio_chan_spec *chan, int *val, int *val2, long info)
> +                          const struct iio_chan_spec *chan, int *val,
> +                          int *val2, long info)
>  {
>         struct ad7766 *ad7766 =3D iio_priv(indio_dev);
>         struct regulator *vref =3D ad7766->reg[AD7766_SUPPLY_VREF].consum=
er;
> @@ -234,12 +235,12 @@ static int ad7766_probe(struct spi_device *spi)
>         ad7766->reg[AD7766_SUPPLY_VREF].supply =3D "vref";
>
>         ret =3D devm_regulator_bulk_get(&spi->dev, ARRAY_SIZE(ad7766->reg=
),
> -               ad7766->reg);
> +                                     ad7766->reg);
>         if (ret)
>                 return ret;
>
>         ad7766->pd_gpio =3D devm_gpiod_get_optional(&spi->dev, "powerdown=
",
> -               GPIOD_OUT_HIGH);
> +                                                 GPIOD_OUT_HIGH);
>         if (IS_ERR(ad7766->pd_gpio))
>                 return PTR_ERR(ad7766->pd_gpio);
>
> @@ -252,7 +253,8 @@ static int ad7766_probe(struct spi_device *spi)
>
>         if (spi->irq > 0) {
>                 ad7766->trig =3D devm_iio_trigger_alloc(&spi->dev, "%s-de=
v%d",
> -                       indio_dev->name, indio_dev->id);
> +                                                     indio_dev->name,
> +                                                     indio_dev->id);
>                 if (!ad7766->trig)
>                         return -ENOMEM;
>
> @@ -261,8 +263,9 @@ static int ad7766_probe(struct spi_device *spi)
>                 iio_trigger_set_drvdata(ad7766->trig, ad7766);
>
>                 ret =3D devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
> -                       IRQF_TRIGGER_FALLING, dev_name(&spi->dev),
> -                       ad7766->trig);
> +                                      IRQF_TRIGGER_FALLING,
> +                                      dev_name(&spi->dev),
> +                                      ad7766->trig);
>                 if (ret < 0)
>                         return ret;
>
> @@ -290,8 +293,9 @@ static int ad7766_probe(struct spi_device *spi)
>         spi_message_add_tail(&ad7766->xfer, &ad7766->msg);
>
>         ret =3D devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> -               &iio_pollfunc_store_time, &ad7766_trigger_handler,
> -               &ad7766_buffer_setup_ops);
> +                                             &iio_pollfunc_store_time,
> +                                             &ad7766_trigger_handler,
> +                                             &ad7766_buffer_setup_ops);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 57832b4360e9..d5d146e9e372 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -61,6 +61,16 @@ config IAQCORE
>           iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
>           sensors
>
> +config PMS7003
> +       tristate "Plantower PMS7003 particulate matter sensor"
> +       depends on SERIAL_DEV_BUS
> +       help
> +         Say Y here to build support for the Plantower PMS7003 particula=
te
> +         matter sensor.
> +
> +         To compile this driver as a module, choose M here: the module w=
ill
> +         be called pms7003.
> +
>  config SPS30
>         tristate "SPS30 particulate matter sensor"
>         depends on I2C
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefil=
e
> index 65bf0f89c0e4..f5d1365acb49 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_BME680_I2C) +=3D bme680_i2c.o
>  obj-$(CONFIG_BME680_SPI) +=3D bme680_spi.o
>  obj-$(CONFIG_CCS811)           +=3D ccs811.o
>  obj-$(CONFIG_IAQCORE)          +=3D ams-iaq-core.o
> +obj-$(CONFIG_PMS7003) +=3D pms7003.o
>  obj-$(CONFIG_SENSIRION_SGP30)  +=3D sgp30.o
>  obj-$(CONFIG_SPS30) +=3D sps30.o
>  obj-$(CONFIG_VZ89X)            +=3D vz89x.o
> diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms700=
3.c
> new file mode 100644
> index 000000000000..db8e7b2327b3
> --- /dev/null
> +++ b/drivers/iio/chemical/pms7003.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Plantower PMS7003 particulate matter sensor driver
> + *
> + * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/serdev.h>
> +
> +#define PMS7003_DRIVER_NAME "pms7003"
> +
> +#define PMS7003_MAGIC 0x424d
> +/* last 2 data bytes hold frame checksum */
> +#define PMS7003_MAX_DATA_LENGTH 28
> +#define PMS7003_CHECKSUM_LENGTH 2
> +#define PMS7003_PM10_OFFSET 10
> +#define PMS7003_PM2P5_OFFSET 8
> +#define PMS7003_PM1_OFFSET 6
> +
> +#define PMS7003_TIMEOUT msecs_to_jiffies(6000)
> +#define PMS7003_CMD_LENGTH 7
> +#define PMS7003_PM_MAX 1000
> +#define PMS7003_PM_MIN 0
> +
> +enum {
> +       PM1,
> +       PM2P5,
> +       PM10,
> +};
> +
> +enum pms7003_cmd {
> +       CMD_WAKEUP,
> +       CMD_ENTER_PASSIVE_MODE,
> +       CMD_READ_PASSIVE,
> +       CMD_SLEEP,
> +};
> +
> +/*
> + * commands have following format:
> + *
> + * +------+------+-----+------+-----+-----------+-----------+
> + * | 0x42 | 0x4d | cmd | 0x00 | arg | cksum msb | cksum lsb |
> + * +------+------+-----+------+-----+-----------+-----------+
> + */
> +static const u8 pms7003_cmd_tbl[][PMS7003_CMD_LENGTH] =3D {
> +       [CMD_WAKEUP] =3D { 0x42, 0x4d, 0xe4, 0x00, 0x01, 0x01, 0x74 },
> +       [CMD_ENTER_PASSIVE_MODE] =3D { 0x42, 0x4d, 0xe1, 0x00, 0x00, 0x01=
, 0x70 },
> +       [CMD_READ_PASSIVE] =3D { 0x42, 0x4d, 0xe2, 0x00, 0x00, 0x01, 0x71=
 },
> +       [CMD_SLEEP] =3D { 0x42, 0x4d, 0xe4, 0x00, 0x00, 0x01, 0x73 },
> +};
> +
> +struct pms7003_frame {
> +       u8 data[PMS7003_MAX_DATA_LENGTH];
> +       u16 expected_length;
> +       u16 length;
> +};
> +
> +struct pms7003_state {
> +       struct serdev_device *serdev;
> +       struct pms7003_frame frame;
> +       struct completion frame_ready;
> +       struct mutex lock; /* must be held whenever state gets touched */
> +};
> +
> +static int pms7003_do_cmd(struct pms7003_state *state, enum pms7003_cmd =
cmd)
> +{
> +       int ret;
> +
> +       ret =3D serdev_device_write(state->serdev, pms7003_cmd_tbl[cmd],
> +                                 PMS7003_CMD_LENGTH, PMS7003_TIMEOUT);
> +       if (ret < PMS7003_CMD_LENGTH)
> +               return ret < 0 ? ret : -EIO;
> +
> +       ret =3D wait_for_completion_interruptible_timeout(&state->frame_r=
eady,
> +                                                       PMS7003_TIMEOUT);
> +       if (!ret)
> +               ret =3D -ETIMEDOUT;
> +
> +       return ret < 0 ? ret : 0;
> +}
> +
> +static u16 pms7003_get_pm(const u8 *data)
> +{
> +       return clamp_val(get_unaligned_be16(data),
> +                        PMS7003_PM_MIN, PMS7003_PM_MAX);
> +}
> +
> +static irqreturn_t pms7003_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf =3D p;
> +       struct iio_dev *indio_dev =3D pf->indio_dev;
> +       struct pms7003_state *state =3D iio_priv(indio_dev);
> +       struct pms7003_frame *frame =3D &state->frame;
> +       u16 data[3 + 1 + 4]; /* PM1, PM2P5, PM10, padding, timestamp */
> +       int ret;
> +
> +       mutex_lock(&state->lock);
> +       ret =3D pms7003_do_cmd(state, CMD_READ_PASSIVE);
> +       if (ret) {
> +               mutex_unlock(&state->lock);
> +               goto err;
> +       }
> +
> +       data[PM1] =3D pms7003_get_pm(frame->data + PMS7003_PM1_OFFSET);
> +       data[PM2P5] =3D pms7003_get_pm(frame->data + PMS7003_PM2P5_OFFSET=
);
> +       data[PM10] =3D pms7003_get_pm(frame->data + PMS7003_PM10_OFFSET);
> +       mutex_unlock(&state->lock);
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, data,
> +                                          iio_get_time_ns(indio_dev));
> +err:
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int pms7003_read_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan,
> +                           int *val, int *val2, long mask)
> +{
> +       struct pms7003_state *state =3D iio_priv(indio_dev);
> +       struct pms7003_frame *frame =3D &state->frame;
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_PROCESSED:
> +               switch (chan->type) {
> +               case IIO_MASSCONCENTRATION:
> +                       mutex_lock(&state->lock);
> +                       ret =3D pms7003_do_cmd(state, CMD_READ_PASSIVE);
> +                       if (ret) {
> +                               mutex_unlock(&state->lock);
> +                               return ret;
> +                       }
> +
> +                       *val =3D pms7003_get_pm(frame->data + chan->addre=
ss);
> +                       mutex_unlock(&state->lock);
> +
> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static const struct iio_info pms7003_info =3D {
> +       .read_raw =3D pms7003_read_raw,
> +};
> +
> +#define PMS7003_CHAN(_index, _mod, _addr) { \
> +       .type =3D IIO_MASSCONCENTRATION, \
> +       .modified =3D 1, \
> +       .channel2 =3D IIO_MOD_ ## _mod, \
> +       .address =3D _addr, \
> +       .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED), \
> +       .scan_index =3D _index, \
> +       .scan_type =3D { \
> +               .sign =3D 'u', \
> +               .realbits =3D 10, \
> +               .storagebits =3D 16, \
> +               .endianness =3D IIO_CPU, \
> +       }, \
> +}
> +
> +static const struct iio_chan_spec pms7003_channels[] =3D {
> +       PMS7003_CHAN(0, PM1, PMS7003_PM1_OFFSET),
> +       PMS7003_CHAN(1, PM2P5, PMS7003_PM2P5_OFFSET),
> +       PMS7003_CHAN(2, PM10, PMS7003_PM10_OFFSET),
> +       IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static u16 pms7003_calc_checksum(struct pms7003_frame *frame)
> +{
> +       u16 checksum =3D (PMS7003_MAGIC >> 8) + (u8)(PMS7003_MAGIC & 0xff=
) +
> +                      (frame->length >> 8) + (u8)frame->length;
> +       int i;
> +
> +       for (i =3D 0; i < frame->length - PMS7003_CHECKSUM_LENGTH; i++)
> +               checksum +=3D frame->data[i];
> +
> +       return checksum;
> +}
> +
> +static bool pms7003_frame_is_okay(struct pms7003_frame *frame)
> +{
> +       int offset =3D frame->length - PMS7003_CHECKSUM_LENGTH;
> +       u16 checksum =3D get_unaligned_be16(frame->data + offset);
> +
> +       return checksum =3D=3D pms7003_calc_checksum(frame);
> +}
> +
> +static int pms7003_receive_buf(struct serdev_device *serdev,
> +                              const unsigned char *buf, size_t size)
> +{
> +       struct iio_dev *indio_dev =3D serdev_device_get_drvdata(serdev);
> +       struct pms7003_state *state =3D iio_priv(indio_dev);
> +       struct pms7003_frame *frame =3D &state->frame;
> +       int num;
> +
> +       if (!frame->expected_length) {
> +               u16 magic;
> +
> +               /* wait for SOF and data length */
> +               if (size < 4)
> +                       return 0;
> +
> +               magic =3D get_unaligned_be16(buf);
> +               if (magic !=3D PMS7003_MAGIC)
> +                       return 2;
> +
> +               num =3D get_unaligned_be16(buf + 2);
> +               if (num <=3D PMS7003_MAX_DATA_LENGTH) {
> +                       frame->expected_length =3D num;
> +                       frame->length =3D 0;
> +               }
> +
> +               return 4;
> +       }
> +
> +       num =3D min(size, (size_t)(frame->expected_length - frame->length=
));
> +       memcpy(frame->data + frame->length, buf, num);
> +       frame->length +=3D num;
> +
> +       if (frame->length =3D=3D frame->expected_length) {
> +               if (pms7003_frame_is_okay(frame))
> +                       complete(&state->frame_ready);
> +
> +               frame->expected_length =3D 0;
> +       }
> +
> +       return num;
> +}
> +
> +static const struct serdev_device_ops pms7003_serdev_ops =3D {
> +       .receive_buf =3D pms7003_receive_buf,
> +       .write_wakeup =3D serdev_device_write_wakeup,
> +};
> +
> +static void pms7003_stop(void *data)
> +{
> +       struct pms7003_state *state =3D data;
> +
> +       pms7003_do_cmd(state, CMD_SLEEP);
> +}
> +
> +static const unsigned long pms7003_scan_masks[] =3D { 0x07, 0x00 };
> +
> +static int pms7003_probe(struct serdev_device *serdev)
> +{
> +       struct pms7003_state *state;
> +       struct iio_dev *indio_dev;
> +       int ret;
> +
> +       indio_dev =3D devm_iio_device_alloc(&serdev->dev, sizeof(*state))=
;
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       state =3D iio_priv(indio_dev);
> +       serdev_device_set_drvdata(serdev, indio_dev);
> +       state->serdev =3D serdev;
> +       indio_dev->dev.parent =3D &serdev->dev;
> +       indio_dev->info =3D &pms7003_info;
> +       indio_dev->name =3D PMS7003_DRIVER_NAME;
> +       indio_dev->channels =3D pms7003_channels,
> +       indio_dev->num_channels =3D ARRAY_SIZE(pms7003_channels);
> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> +       indio_dev->available_scan_masks =3D pms7003_scan_masks;
> +
> +       mutex_init(&state->lock);
> +       init_completion(&state->frame_ready);
> +
> +       serdev_device_set_client_ops(serdev, &pms7003_serdev_ops);
> +       ret =3D devm_serdev_device_open(&serdev->dev, serdev);
> +       if (ret)
> +               return ret;
> +
> +       serdev_device_set_baudrate(serdev, 9600);
> +       serdev_device_set_flow_control(serdev, false);
> +
> +       ret =3D serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D pms7003_do_cmd(state, CMD_WAKEUP);
> +       if (ret) {
> +               dev_err(&serdev->dev, "failed to wakeup sensor\n");
> +               return ret;
> +       }
> +
> +       ret =3D pms7003_do_cmd(state, CMD_ENTER_PASSIVE_MODE);
> +       if (ret) {
> +               dev_err(&serdev->dev, "failed to enter passive mode\n");
> +               return ret;
> +       }
> +
> +       ret =3D devm_add_action_or_reset(&serdev->dev, pms7003_stop, stat=
e);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D devm_iio_triggered_buffer_setup(&serdev->dev, indio_dev, =
NULL,
> +                                             pms7003_trigger_handler, NU=
LL);
> +       if (ret)
> +               return ret;
> +
> +       return devm_iio_device_register(&serdev->dev, indio_dev);
> +}
> +
> +static const struct of_device_id pms7003_of_match[] =3D {
> +       { .compatible =3D "plantower,pms7003" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, pms7003_of_match);
> +
> +static struct serdev_device_driver pms7003_driver =3D {
> +       .driver =3D {
> +               .name =3D PMS7003_DRIVER_NAME,
> +               .of_match_table =3D pms7003_of_match,
> +       },
> +       .probe =3D pms7003_probe,
> +};
> +module_serdev_device_driver(pms7003_driver);
> +
> +MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
> +MODULE_DESCRIPTION("Plantower PMS7003 particulate matter sensor driver")=
;
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index 375df5060ed5..edbb956e81e8 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> @@ -118,6 +118,7 @@ static int sps30_do_cmd(struct sps30_state *state, u1=
6 cmd, u8 *data, int size)
>         case SPS30_READ_AUTO_CLEANING_PERIOD:
>                 buf[0] =3D SPS30_AUTO_CLEANING_PERIOD >> 8;
>                 buf[1] =3D (u8)SPS30_AUTO_CLEANING_PERIOD;
> +               /* fall through */
>         case SPS30_READ_DATA_READY_FLAG:
>         case SPS30_READ_DATA:
>         case SPS30_READ_SERIAL:
> @@ -295,6 +296,8 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
>                                 *val2 =3D 10000;
>
>                                 return IIO_VAL_INT_PLUS_MICRO;
> +                       default:
> +                               return -EINVAL;
>                         }
>                 default:
>                         return -EINVAL;
> --
> 2.17.1
>
