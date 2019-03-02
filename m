Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C64C00319
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888332086D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551553412;
	bh=5VLPngbe73QUbv0dPkB2AbupKEM9t/QTbXdtDSUJtPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uoOLtXJ2+GgKitfUqIZUFQeYmKl8GctSZMUBeDzSoHz3Zw1wKtvX72MNyVkMQ4QBT
	 Iwu7O5vbZbN2/hXN+qOYNxLVWsYoo2dSY7YE8KHQgtH7LTwU4tVJfgFZaUqZa2GPjO
	 +8fDJuM5KXG7Uy89HjE+EBGhREjNm1LW3RaGaN+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfCBTDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 14:03:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfCBTDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 14:03:30 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED7ED20863;
        Sat,  2 Mar 2019 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551553409;
        bh=5VLPngbe73QUbv0dPkB2AbupKEM9t/QTbXdtDSUJtPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=191BKD/uS6Hyr123mr1WAk76y1/yO2AnOYdgT6Nl0m3nj8f6J/SFXdgZnzHh5Qnm9
         BEZJzL6NRvoWAx99z+2QxjnthI0lBBLmkEyCmVy4OOF97wtYLicEj8VEhvk9vcvZyV
         exZZlCKxje7YZ11wFJvIZbTPrTUhwB1v+rHVDptI=
Date:   Sat, 2 Mar 2019 19:03:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/9] staging: iio: ad7780: add gain & filter gpio
 support
Message-ID: <20190302190322.1075a654@archlinux>
In-Reply-To: <4f945f058c8536a2731c4de3e0b9227a41cd2891.camel@analog.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
        <b83c0558a600cb44677b0d06f31e014be550b8bf.1551358569.git.renatogeh@gmail.com>
        <4f945f058c8536a2731c4de3e0b9227a41cd2891.camel@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 06:56:14 +0000
"Ardelean, Alexandru" <Alex.Ardelean@analog.com> wrote:

> On Thu, 2019-02-28 at 11:23 -0300, Renato Lui Geh wrote:
> > 
> > 
> > Previously, the AD7780 driver only supported gpio for the 'powerdown'
> > pin. This commit adds suppport for the 'gain' and 'filter' pin.
> > 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> > Co-developed-by: Giuliano Belinassi <giuliano.belinassi@usp.br>

A few follow up comments (particularly as Alex asked questions ;)

> > ---
> > Changes in v3:
> >  - Renamed ad7780_chip_info's filter to odr
> >  - Renamed ad778x_filter to ad778x_odr_avail
> >  - Changed vref variable from unsigned int to unsigned long long to avoid
> >    overflow
> >  - Removed unnecessary AD_SD_CHANNEL macro
> > Changes in v4:
> >  - Removed useless macro
> >  - Added default case for switch to suppress warning
> >  - Removed chunks belonging to filter reading, adding these as a
> >    patch for itself
> > 
> >  drivers/staging/iio/adc/ad7780.c | 90 +++++++++++++++++++++++++++++---
> >  1 file changed, 84 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index c4a85789c2db..87fbcf510d45 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -39,6 +39,12 @@
> >  #define AD7170_PATTERN         (AD7780_PAT0 | AD7170_PAT2)
> >  #define AD7170_PATTERN_MASK    (AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
> > 
> > +#define AD7780_GAIN_MIDPOINT   64
> > +#define AD7780_FILTER_MIDPOINT 13350
> > +
> > +static const unsigned int ad778x_gain[2]      = { 1, 128 };
> > +static const unsigned int ad778x_odr_avail[2] = { 10000, 16700 };  
> 
> ad778x_odr_avail[2] is not used in this patch, so it should probably go
> into the next one 
> (i.e. staging: iio: ad7780: add filter reading to ad778x )
> 
> one good way of catching stuff like this is to do interactive rebase and
> compile your driver on each patch to see if the compiler catches this;
> i suspect the compiler would have thrown an error for this change
> 
> 
> > 
> >  struct ad7780_chip_info
> >         struct iio_chan_spec    channel;
> >         unsigned int            pattern_mask;
> > @@ -50,7 +56,10 @@ struct ad7780_state {
> >         const struct ad7780_chip_info   *chip_info;
> >         struct regulator                *reg;
> >         struct gpio_desc                *powerdown_gpio;
> > -       unsigned int    gain;
> > +       struct gpio_desc                *gain_gpio;
> > +       struct gpio_desc                *filter_gpio;
> > +       unsigned int                    gain;
> > +       unsigned int                    int_vref_mv;
> > 
> >         struct ad_sigma_delta sd;
> >  };
> > @@ -104,17 +113,65 @@ static int ad7780_read_raw(struct iio_dev
> > *indio_dev,
> >                 voltage_uv = regulator_get_voltage(st->reg);
> >                 if (voltage_uv < 0)
> >                         return voltage_uv;
> > -               *val = (voltage_uv / 1000) * st->gain;
> > +               voltage_uv /= 1000;
> > +               *val = voltage_uv * st->gain;
> >                 *val2 = chan->scan_type.realbits - 1;
> > +               st->int_vref_mv = voltage_uv;
> >                 return IIO_VAL_FRACTIONAL_LOG2;
> >         case IIO_CHAN_INFO_OFFSET:
> >                 *val = -(1 << (chan->scan_type.realbits - 1));
> >                 return IIO_VAL_INT;
> > +       default:
> > +       break;  
> 
> The indentation of the break statement is inconsistent with other places.
> Still, it does not add much value adding this change as-is, since it does
> not change any behavior, and is not an element needed by this change (i.e.
> adding gain & filter support via gpios)

Agreed. This is a tidy up.  Good one, but put it in a series doing just
tidy ups.

> 
> >         }
> > 
> >         return -EINVAL;
> >  }
> > 
> > +static int ad7780_write_raw(struct iio_dev *indio_dev,
> > +                           struct iio_chan_spec const *chan,
> > +                           int val,
> > +                           int val2,
> > +                           long m)
> > +{
> > +       struct ad7780_state *st = iio_priv(indio_dev);
> > +       const struct ad7780_chip_info *chip_info = st->chip_info;
> > +       unsigned long long vref;
> > +       unsigned int full_scale, gain;
> > +
> > +       if (!chip_info->is_ad778x)
> > +               return 0;

Should return an error I think?  Any such write isn't valid.

> > +
> > +       switch (m) {
> > +       case IIO_CHAN_INFO_SCALE:
> > +               if (val != 0)
> > +                       return -EINVAL;
> > +
> > +               vref = st->int_vref_mv * 1000000LL;
> > +               full_scale = 1 << (chip_info->channel.scan_type.realbits
> > - 1);
> > +               gain = DIV_ROUND_CLOSEST(vref, full_scale);
> > +               gain = DIV_ROUND_CLOSEST(gain, val2);
> > +               st->gain = gain;
> > +               if (gain < AD7780_GAIN_MIDPOINT)
> > +                       gain = 0;
> > +               else
> > +                       gain = 1;
> > +               gpiod_set_value(st->gain_gpio, gain);
> > +               break;
> > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > +               if (1000*val + val2/1000 < AD7780_FILTER_MIDPOINT)
> > +                       val = 0;
> > +               else
> > +                       val = 1;
> > +               gpiod_set_value(st->filter_gpio, val);
> > +               break;
> > +       default:
> > +       break;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
> >                                      unsigned int raw_sample)
> >  {
> > @@ -126,10 +183,7 @@ static int ad7780_postprocess_sample(struct
> > ad_sigma_delta *sigma_delta,
> >                 return -EIO;
> > 
> >         if (chip_info->is_ad778x) {
> > -               if (raw_sample & AD7780_GAIN)
> > -                       st->gain = 1;
> > -               else
> > -                       st->gain = 128;
> > +               st->gain = ad778x_gain[raw_sample & AD7780_GAIN];  
> 
> The new `ad778x_gain[]` array could have been it's own patch, but from my
> side it's fine to leave it here.
> I do like this change, but it's not a patch that semantically has to do
> anything with adding gain & filter gpio support.
> 
> 
> Let's see what Jonathan says.

It's small enough I don't mind, but ideal would have been a precursor patch
doing that refactoring.

> 
> >         }
> > 
> >         return 0;
> > @@ -173,6 +227,7 @@ static const struct ad7780_chip_info
> > ad7780_chip_info_tbl[] = {
> > 
> >  static const struct iio_info ad7780_info = {
> >         .read_raw = ad7780_read_raw,
> > +       .write_raw = ad7780_write_raw,
> >  };
> > 
> >  static int ad7780_probe(struct spi_device *spi)
> > @@ -222,6 +277,29 @@ static int ad7780_probe(struct spi_device *spi)
> >                 goto error_disable_reg;
> >         }
> > 
> > +       if (st->chip_info->is_ad778x) {
> > +               st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
> > +                                                       "adi,gain",
> > +                                                       GPIOD_OUT_HIGH);
> > +               if (IS_ERR(st->gain_gpio)) {
> > +                       ret = PTR_ERR(st->gain_gpio);
> > +                       dev_err(&spi->dev, "Failed to request gain GPIO:
> > %d\n",
> > +                               ret);
> > +                       goto error_disable_reg;
> > +               }
> > +
> > +               st->filter_gpio = devm_gpiod_get_optional(&spi->dev,
> > +                                                         "adi,filter",
> > +                                                         GPIOD_OUT_HIGH)
> > ;
> > +               if (IS_ERR(st->filter_gpio)) {
> > +                       ret = PTR_ERR(st->filter_gpio);
> > +                       dev_err(&spi->dev,
> > +                               "Failed to request filter GPIO: %d\n",
> > +                               ret);
> > +                       goto error_disable_reg;
> > +               }
> > +       }
> > +  
> 
> This is just a preference of mine [feel free to ignore for this patch].
> But, for this block of code, I would have added a separate function [
> called something like ad7780_init_gpios(struct device *dev, struct
> ad7780_state *st) )
> 
> you could also move the powerdown gpio there; and do something like
> 
> static int ad7780_init_gpios(struct device *dev, struct ad7780_state *st)
> {
> 
>       st->powerdown_gpio = devm_gpiod_get_optional(dev,
>                                                      "powerdown",
>                                                      GPIOD_OUT_LOW);
>         if (IS_ERR(st->powerdown_gpio)) {
>               ret = PTR_ERR(st->powerdown_gpio);
>               dev_err(dev, "Failed to request powerdown GPIO: %d\n", ret);
>               return ret;
>         }
> 
>        /**
>         * Note Alex: I'm a big fan of keeping things to a minimal 
>         * indentation level [especially where things can be elegant], 
>         * but that's a preference of mine
>         */

Me too ;)  Fast exit is always nice as well as saves anyone who cares
about this condition looking further.

>        if (!st->chip_info->is_ad778x)
>            return 0;
> 
> 
>         st->gain_gpio = devm_gpiod_get_optional(dev,
>                         "adi,gain",
>                         GPIOD_OUT_HIGH);
>         if (IS_ERR(st->gain_gpio)) {
>                 ret = PTR_ERR(st->gain_gpio);
>                 dev_err(dev, "Failed to request gain GPIO: %d\n", ret);
>                 return ret;
>         }
> 
>         st->filter_gpio = devm_gpiod_get_optional(dev,
>                         "adi,filter",
>                         GPIOD_OUT_HIGH);
> 
>         if (IS_ERR(st->filter_gpio)) {
>                 ret = PTR_ERR(st->filter_gpio);
>                 dev_err(dev, "Failed to request filter GPIO: %d\n", ret);
>                 return ret;
>         }
> 
>         return 0;
> }
> 
> 
> 
> >         ret = ad_sd_setup_buffer_and_trigger(indio_dev);
> >         if (ret)
> >                 goto error_disable_reg;
> > --
> > 2.21.0
> >   

