Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE56BC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5835222D9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCXLGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 07:06:16 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:36532 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXLGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 07:06:16 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 92FE99E7727;
        Sun, 24 Mar 2019 11:06:11 +0000 (GMT)
Date:   Sun, 24 Mar 2019 11:06:09 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 01/11] staging: iio: ad7780: add gain & filter gpio
 support
Message-ID: <20190324110609.3cb21436@archlinux>
In-Reply-To: <20190316174640.12810916@archlinux>
References: <cover.1552700652.git.renatogeh@gmail.com>
        <2687836c5b442990ee50d4efe787a3927c750bbc.1552700652.git.renatogeh@gmail.com>
        <20190316174640.12810916@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019 17:46:40 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 15 Mar 2019 23:12:27 -0300
> Renato Lui Geh <renatogeh@gmail.com> wrote:
> 
> > Previously, the AD7780 driver only supported gpio for the 'powerdown'
> > pin. This commit adds suppport for the 'gain' and 'filter' pin.
> > 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> > Co-developed-by: Giuliano Belinassi <giuliano.belinassi@usp.br>  
> Something a little odd happened when trying to use git am on this,
> but patch was happy so I did it that way. Please give it a quick
> sanity check once I push the tree out incase we have a real problem.
> 
> Applied to the togreg branch of iio.git to be shortly pushed out
> as testing for the autobuilders to play with it.

Ah, we missed a 64 bit being divided below. Found by 0day.


> 
> Thanks,
> 
> Jonathan
> 
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
> > Changes in v5:
> >  - ad778x_odr_avail moved to filter patch
> >  - Split gain reading to its own patch
> >  - Init GPIOs in a separate function
> > 
> >  drivers/staging/iio/adc/ad7780.c | 114 ++++++++++++++++++++++++++-----
> >  1 file changed, 96 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> > index c4a85789c2db..07e5e35c92a3 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -39,6 +39,9 @@
> >  #define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
> >  #define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
> >  
> > +#define AD7780_GAIN_MIDPOINT	64
> > +#define AD7780_FILTER_MIDPOINT	13350
> > +
> >  struct ad7780_chip_info {
> >  	struct iio_chan_spec	channel;
> >  	unsigned int		pattern_mask;
> > @@ -50,7 +53,10 @@ struct ad7780_state {
> >  	const struct ad7780_chip_info	*chip_info;
> >  	struct regulator		*reg;
> >  	struct gpio_desc		*powerdown_gpio;
> > -	unsigned int	gain;
> > +	struct gpio_desc		*gain_gpio;
> > +	struct gpio_desc		*filter_gpio;
> > +	unsigned int			gain;
> > +	unsigned int			int_vref_mv;
> >  
> >  	struct ad_sigma_delta sd;
> >  };
> > @@ -104,8 +110,10 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
> >  		voltage_uv = regulator_get_voltage(st->reg);
> >  		if (voltage_uv < 0)
> >  			return voltage_uv;
> > -		*val = (voltage_uv / 1000) * st->gain;
> > +		voltage_uv /= 1000;
> > +		*val = voltage_uv * st->gain;
> >  		*val2 = chan->scan_type.realbits - 1;
> > +		st->int_vref_mv = voltage_uv;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >  	case IIO_CHAN_INFO_OFFSET:
> >  		*val = -(1 << (chan->scan_type.realbits - 1));
> > @@ -115,6 +123,50 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
> >  	return -EINVAL;
> >  }
> >  
> > +static int ad7780_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int val,
> > +			    int val2,
> > +			    long m)
> > +{
> > +	struct ad7780_state *st = iio_priv(indio_dev);
> > +	const struct ad7780_chip_info *chip_info = st->chip_info;
> > +	unsigned long long vref;
> > +	unsigned int full_scale, gain;
> > +
> > +	if (!chip_info->is_ad778x)
> > +		return -EINVAL;
> > +
> > +	switch (m) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (val != 0)
> > +			return -EINVAL;
> > +
> > +		vref = st->int_vref_mv * 1000000LL;
> > +		full_scale = 1 << (chip_info->channel.scan_type.realbits - 1);
> > +		gain = DIV_ROUND_CLOSEST(vref, full_scale);

DIV_ROUND_CLOSEST_ULL needed as vref is long long.

I'll fix up.

Jonathan

> > +		gain = DIV_ROUND_CLOSEST(gain, val2);
> > +		st->gain = gain;
> > +		if (gain < AD7780_GAIN_MIDPOINT)
> > +			gain = 0;
> > +		else
> > +			gain = 1;
> > +		gpiod_set_value(st->gain_gpio, gain);
> > +		break;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		if (1000*val + val2/1000 < AD7780_FILTER_MIDPOINT)
> > +			val = 0;
> > +		else
> > +			val = 1;
> > +		gpiod_set_value(st->filter_gpio, val);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
> >  				     unsigned int raw_sample)
> >  {
> > @@ -125,13 +177,6 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
> >  	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
> >  		return -EIO;
> >  
> > -	if (chip_info->is_ad778x) {
> > -		if (raw_sample & AD7780_GAIN)
> > -			st->gain = 1;
> > -		else
> > -			st->gain = 128;
> > -	}
> > -
> >  	return 0;
> >  }
> >  
> > @@ -173,8 +218,47 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
> >  
> >  static const struct iio_info ad7780_info = {
> >  	.read_raw = ad7780_read_raw,
> > +	.write_raw = ad7780_write_raw,
> >  };
> >  
> > +static int ad7780_init_gpios(struct device *dev, struct ad7780_state *st)
> > +{
> > +	int ret;
> > +
> > +	st->powerdown_gpio = devm_gpiod_get_optional(dev,
> > +						     "powerdown",
> > +						     GPIOD_OUT_LOW);
> > +	if (IS_ERR(st->powerdown_gpio)) {
> > +		ret = PTR_ERR(st->powerdown_gpio);
> > +		dev_err(dev, "Failed to request powerdown GPIO: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	if (!st->chip_info->is_ad778x)
> > +		return 0;
> > +  
> nitpick: One blank line is always enough. More just reduces the amount of
> code that can be seen at a time.
> 
> > +
> > +	st->gain_gpio = devm_gpiod_get_optional(dev,
> > +						"adi,gain",
> > +						GPIOD_OUT_HIGH);
> > +	if (IS_ERR(st->gain_gpio)) {
> > +		ret = PTR_ERR(st->gain_gpio);
> > +		dev_err(dev, "Failed to request gain GPIO: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	st->filter_gpio = devm_gpiod_get_optional(dev,
> > +						  "adi,filter",
> > +						  GPIOD_OUT_HIGH);
> > +	if (IS_ERR(st->filter_gpio)) {
> > +		ret = PTR_ERR(st->filter_gpio);
> > +		dev_err(dev, "Failed to request filter GPIO: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int ad7780_probe(struct spi_device *spi)
> >  {
> >  	struct ad7780_state *st;
> > @@ -212,15 +296,9 @@ static int ad7780_probe(struct spi_device *spi)
> >  	indio_dev->num_channels = 1;
> >  	indio_dev->info = &ad7780_info;
> >  
> > -	st->powerdown_gpio = devm_gpiod_get_optional(&spi->dev,
> > -						     "powerdown",
> > -						     GPIOD_OUT_LOW);
> > -	if (IS_ERR(st->powerdown_gpio)) {
> > -		ret = PTR_ERR(st->powerdown_gpio);
> > -		dev_err(&spi->dev, "Failed to request powerdown GPIO: %d\n",
> > -			ret);
> > -		goto error_disable_reg;
> > -	}
> > +	ret = ad7780_init_gpios(&spi->dev, st);
> > +	if (ret)
> > +		goto error_cleanup_buffer_and_trigger;
> >  
> >  	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
> >  	if (ret)  
> 

