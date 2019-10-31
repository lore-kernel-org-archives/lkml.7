Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A06ACA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC072067D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dyhyZY+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfJaGrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 02:47:06 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45722 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfJaGrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 02:47:05 -0400
Received: by mail-il1-f194.google.com with SMTP id b12so4362074ilf.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 23:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UbINaEL7uEmVhMBDTrMvg3CwkYHIDyJU/KDjcZwXBRU=;
        b=dyhyZY+qStUbwpgZgu3g0hKVfuqEhVmIGxbJ7I98dDnOcWp8Q7GWGTgWzETzVBDiXf
         +A9EKboAktB/3j2LjQO5C5+dUhZ8zYR9p43VkY9zVQBVkNbj1fFWl0A7SopDjL6Jh07X
         1JKb+kzK7tO956j+9/FngG3efnq+/wPVHg92liw8dey+4O46b6ZA1Xl4jBgNTY+NP5Sq
         pGo/S29AoYRJhe9DwpyL7bDngD3azLu4rKBu8COz5EaaXmygxyDs+B1Q7Yoy36q245DA
         nItTYV6XGP49kmri43w9ML6JZuRgTfsNPhxg18nBhVXI3pz9fRgTXKecY9/l7tzpY+OT
         St/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UbINaEL7uEmVhMBDTrMvg3CwkYHIDyJU/KDjcZwXBRU=;
        b=KQUy1OA+AKSqOeTtDGkKPHiYHdkdZe69zXrx0RBtOltqkGJ+I47pzL9Xejn+0j/3Ho
         Z8IOcquxxXQClcZw3yqkoAu2r+2FfXorFHaA1vTpZRHoG91J/LLKNfjEMnczXohZjjrI
         dLyi4wZ06cD0Lgb36ae18wsMXFpKGcT7ddKtMOLZtLJqyrvg8ytVS9o2+MJkg+b8RcYE
         LY8+Up1q4z6C6kjdBq8mb1KL5SPU9Q/6dQBOEHNLpoAoHq6qQhQaefoNLwNmnesojiKf
         or+c+q5H9IlFHnAl73PIiKGphubi/Hqh4BTQ0L701ms6Dhso4DrE8DtCuUp+DRF4fJl0
         S/Hw==
X-Gm-Message-State: APjAAAVBTwWFjT7pKtt9jt3tQYlh4JxtS6hrNLQfosHlxcb161p74DDd
        z4u9BmWCzoZzi6hByvh0lhx372o0VVKvWlUoLw7JzA==
X-Google-Smtp-Source: APXvYqxZte1VCMheKpdohqNf3k0Xj+jtf5V1WBdC+f2Po/bj5Olb2gNSryX+q+CFFRoF6+cFhc+ZlxfseISEUdeY2X8=
X-Received: by 2002:a92:48cf:: with SMTP id j76mr4358045ilg.189.1572504422911;
 Wed, 30 Oct 2019 23:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191007024131.22708-1-brgl@bgdev.pl> <20191012143722.7cb7015d@archlinux>
 <CAMRc=MekOWGKo4eJ69ifV+MG5==PetPpb87Amrqm_x95sjFiGQ@mail.gmail.com> <20191022111502.5097190e@archlinux>
In-Reply-To: <20191022111502.5097190e@archlinux>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 31 Oct 2019 07:46:51 +0100
Message-ID: <CAMRc=Me=d9MmMPTmwMk-5mYkgrFS5+3y4RNj6CQinWG8N2YntA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: pressure: bmp280: use devm action and remove
 labels from probe
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 22 pa=C5=BA 2019 o 12:15 Jonathan Cameron <jic23@kernel.org> napisa=C5=
=82(a):
>
> On Mon, 21 Oct 2019 14:47:18 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > sob., 12 pa=C5=BA 2019 o 15:37 Jonathan Cameron <jic23@kernel.org> napi=
sa=C5=82(a):
> > >
> > > On Mon,  7 Oct 2019 04:41:31 +0200
> > > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > We can drop some duplicate code if we use devm_action for disabling
> > > > regulators and pm and the managed variant of iio_device_register().
> > > >
> > > > This allows us to completely remove all remove() callbacks from bot=
h
> > > > i2c and spi code.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > This is on top of the bulk regulator patch which is awaiting precusor=
s
> > > getting to my upstream.  I'll hold this one as well on that.
> > >
> > > If it looks like I've forgotten it then give me a poke.
> > >
> >
> > Hi Jonathan,
> >
> > gentle poke after v5.4-rc4. Only one of the three patches is in next
> > so far, the one using bulk regulators is missing too besides this one.
> Thanks for the reminder.
>
> Applied to the togreg branch of iio.git and pushed out as testing for the
> autobuilders to play with it.
>

Hi,

I don't see it in the togreg branch of the iio tree - did something go
wrong with testing?

Bart

> Thanks,
>
> Jonathan
> >
> > Best regards,
> > Bartosz Golaszewski
> >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > > > ---
> > > > v1 -> v2:
> > > > - squash the patches using devm_iio_device_register() and devm_acti=
on
> > > >   to keep the changes bisectable
> > > >
> > > >  drivers/iio/pressure/bmp280-core.c | 62 +++++++++++++++-----------=
----
> > > >  drivers/iio/pressure/bmp280-i2c.c  |  6 ---
> > > >  drivers/iio/pressure/bmp280-spi.c  |  6 ---
> > > >  drivers/iio/pressure/bmp280.h      |  1 -
> > > >  4 files changed, 30 insertions(+), 45 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/press=
ure/bmp280-core.c
> > > > index c2988dbdb1a7..79254dd26dfd 100644
> > > > --- a/drivers/iio/pressure/bmp280-core.c
> > > > +++ b/drivers/iio/pressure/bmp280-core.c
> > > > @@ -984,6 +984,22 @@ static int bmp085_fetch_eoc_irq(struct device =
*dev,
> > > >       return 0;
> > > >  }
> > > >
> > > > +static void bmp280_pm_disable(void *data)
> > > > +{
> > > > +     struct device *dev =3D data;
> > > > +
> > > > +     pm_runtime_get_sync(dev);
> > > > +     pm_runtime_put_noidle(dev);
> > > > +     pm_runtime_disable(dev);
> > > > +}
> > > > +
> > > > +static void bmp280_regulators_disable(void *data)
> > > > +{
> > > > +     struct regulator_bulk_data *supplies =3D data;
> > > > +
> > > > +     regulator_bulk_disable(BMP280_NUM_SUPPLIES, supplies);
> > > > +}
> > > > +
> > > >  int bmp280_common_probe(struct device *dev,
> > > >                       struct regmap *regmap,
> > > >                       unsigned int chip,
> > > > @@ -1055,6 +1071,11 @@ int bmp280_common_probe(struct device *dev,
> > > >               return ret;
> > > >       }
> > > >
> > > > +     ret =3D devm_add_action_or_reset(dev, bmp280_regulators_disab=
le,
> > > > +                                    data->supplies);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > >       /* Wait to make sure we started up properly */
> > > >       usleep_range(data->start_up_time, data->start_up_time + 100);
> > > >
> > > > @@ -1069,17 +1090,16 @@ int bmp280_common_probe(struct device *dev,
> > > >       data->regmap =3D regmap;
> > > >       ret =3D regmap_read(regmap, BMP280_REG_ID, &chip_id);
> > > >       if (ret < 0)
> > > > -             goto out_disable_regulators;
> > > > +             return ret;
> > > >       if (chip_id !=3D chip) {
> > > >               dev_err(dev, "bad chip id: expected %x got %x\n",
> > > >                       chip, chip_id);
> > > > -             ret =3D -EINVAL;
> > > > -             goto out_disable_regulators;
> > > > +             return -EINVAL;
> > > >       }
> > > >
> > > >       ret =3D data->chip_info->chip_config(data);
> > > >       if (ret < 0)
> > > > -             goto out_disable_regulators;
> > > > +             return ret;
> > > >
> > > >       dev_set_drvdata(dev, indio_dev);
> > > >
> > > > @@ -1093,14 +1113,14 @@ int bmp280_common_probe(struct device *dev,
> > > >               if (ret < 0) {
> > > >                       dev_err(data->dev,
> > > >                               "failed to read calibration coefficie=
nts\n");
> > > > -                     goto out_disable_regulators;
> > > > +                     return ret;
> > > >               }
> > > >       } else if (chip_id =3D=3D BMP280_CHIP_ID || chip_id =3D=3D BM=
E280_CHIP_ID) {
> > > >               ret =3D bmp280_read_calib(data, &data->calib.bmp280, =
chip_id);
> > > >               if (ret < 0) {
> > > >                       dev_err(data->dev,
> > > >                               "failed to read calibration coefficie=
nts\n");
> > > > -                     goto out_disable_regulators;
> > > > +                     return ret;
> > > >               }
> > > >       }
> > > >
> > > > @@ -1112,7 +1132,7 @@ int bmp280_common_probe(struct device *dev,
> > > >       if (irq > 0 || (chip_id  =3D=3D BMP180_CHIP_ID)) {
> > > >               ret =3D bmp085_fetch_eoc_irq(dev, name, irq, data);
> > > >               if (ret)
> > > > -                     goto out_disable_regulators;
> > > > +                     return ret;
> > > >       }
> > > >
> > > >       /* Enable runtime PM */
> > > > @@ -1127,36 +1147,14 @@ int bmp280_common_probe(struct device *dev,
> > > >       pm_runtime_use_autosuspend(dev);
> > > >       pm_runtime_put(dev);
> > > >
> > > > -     ret =3D iio_device_register(indio_dev);
> > > > +     ret =3D devm_add_action_or_reset(dev, bmp280_pm_disable, dev)=
;
> > > >       if (ret)
> > > > -             goto out_runtime_pm_disable;
> > > > -
> > > > -     return 0;
> > > > +             return ret;
> > > >
> > > > -out_runtime_pm_disable:
> > > > -     pm_runtime_get_sync(data->dev);
> > > > -     pm_runtime_put_noidle(data->dev);
> > > > -     pm_runtime_disable(data->dev);
> > > > -out_disable_regulators:
> > > > -     regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
> > > > -     return ret;
> > > > +     return devm_iio_device_register(dev, indio_dev);
> > > >  }
> > > >  EXPORT_SYMBOL(bmp280_common_probe);
> > > >
> > > > -int bmp280_common_remove(struct device *dev)
> > > > -{
> > > > -     struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > > > -     struct bmp280_data *data =3D iio_priv(indio_dev);
> > > > -
> > > > -     iio_device_unregister(indio_dev);
> > > > -     pm_runtime_get_sync(data->dev);
> > > > -     pm_runtime_put_noidle(data->dev);
> > > > -     pm_runtime_disable(data->dev);
> > > > -     regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
> > > > -     return 0;
> > > > -}
> > > > -EXPORT_SYMBOL(bmp280_common_remove);
> > > > -
> > > >  #ifdef CONFIG_PM
> > > >  static int bmp280_runtime_suspend(struct device *dev)
> > > >  {
> > > > diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressu=
re/bmp280-i2c.c
> > > > index acd9a3784fb4..3109c8e2cc11 100644
> > > > --- a/drivers/iio/pressure/bmp280-i2c.c
> > > > +++ b/drivers/iio/pressure/bmp280-i2c.c
> > > > @@ -38,11 +38,6 @@ static int bmp280_i2c_probe(struct i2c_client *c=
lient,
> > > >                                  client->irq);
> > > >  }
> > > >
> > > > -static int bmp280_i2c_remove(struct i2c_client *client)
> > > > -{
> > > > -     return bmp280_common_remove(&client->dev);
> > > > -}
> > > > -
> > > >  static const struct acpi_device_id bmp280_acpi_i2c_match[] =3D {
> > > >       {"BMP0280", BMP280_CHIP_ID },
> > > >       {"BMP0180", BMP180_CHIP_ID },
> > > > @@ -82,7 +77,6 @@ static struct i2c_driver bmp280_i2c_driver =3D {
> > > >               .pm =3D &bmp280_dev_pm_ops,
> > > >       },
> > > >       .probe          =3D bmp280_i2c_probe,
> > > > -     .remove         =3D bmp280_i2c_remove,
> > > >       .id_table       =3D bmp280_i2c_id,
> > > >  };
> > > >  module_i2c_driver(bmp280_i2c_driver);
> > > > diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressu=
re/bmp280-spi.c
> > > > index 9d57b7a3b134..625b86878ad8 100644
> > > > --- a/drivers/iio/pressure/bmp280-spi.c
> > > > +++ b/drivers/iio/pressure/bmp280-spi.c
> > > > @@ -86,11 +86,6 @@ static int bmp280_spi_probe(struct spi_device *s=
pi)
> > > >                                  spi->irq);
> > > >  }
> > > >
> > > > -static int bmp280_spi_remove(struct spi_device *spi)
> > > > -{
> > > > -     return bmp280_common_remove(&spi->dev);
> > > > -}
> > > > -
> > > >  static const struct of_device_id bmp280_of_spi_match[] =3D {
> > > >       { .compatible =3D "bosch,bmp085", },
> > > >       { .compatible =3D "bosch,bmp180", },
> > > > @@ -118,7 +113,6 @@ static struct spi_driver bmp280_spi_driver =3D =
{
> > > >       },
> > > >       .id_table =3D bmp280_spi_id,
> > > >       .probe =3D bmp280_spi_probe,
> > > > -     .remove =3D bmp280_spi_remove,
> > > >  };
> > > >  module_spi_driver(bmp280_spi_driver);
> > > >
> > > > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/b=
mp280.h
> > > > index eda50ef65706..57ba0e85db91 100644
> > > > --- a/drivers/iio/pressure/bmp280.h
> > > > +++ b/drivers/iio/pressure/bmp280.h
> > > > @@ -112,7 +112,6 @@ int bmp280_common_probe(struct device *dev,
> > > >                       unsigned int chip,
> > > >                       const char *name,
> > > >                       int irq);
> > > > -int bmp280_common_remove(struct device *dev);
> > > >
> > > >  /* PM ops */
> > > >  extern const struct dev_pm_ops bmp280_dev_pm_ops;
> > >
>
