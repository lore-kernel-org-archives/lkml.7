Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CBEC10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F7220866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551619660;
	bh=fn07zB3Gi1/EuJE1k6KhMmzYH+tvhLWyfILed4jwdlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zT4HX6m2dO7D29wQ5RZZfucB5+GDCBera7M/CYMnnGwA4Wsq/xv/DjMEJmHzOzOUb
	 ZcuXpyYmli4Z5KlSMSzw9wg5kKdGX531GK/4eHfUzOUMAZY9IE5av+x+u8iln7TXDG
	 yh1bcmZbAiFyI+Q9ZJlrzmNvp4k6DJj9iHWJC/FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfCCN1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 08:27:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbfCCN1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 08:27:38 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C59120857;
        Sun,  3 Mar 2019 13:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551619656;
        bh=fn07zB3Gi1/EuJE1k6KhMmzYH+tvhLWyfILed4jwdlM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gs4m5RJYohk4HKvcTebzQpNTRgi5Z3K9UfZJ+3pSdQPRodiqbsfT8RnPsE0PnCwfI
         vc+Fil/4caBqf0Pn5gtaKxlPk3xbXYwDo1Nxe+7S8swEj14nywvA9fYfAbtJf2Kpfi
         z9DBwrWAwFs+knvpRodmrq3iQE28uJ7j+Jj11b3c=
Date:   Sun, 3 Mar 2019 13:27:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <biabeniamin@outlook.com>
Subject: Re: [PATCH v3 1/3] staging: iio: frequency: ad9834: Move frequency
 to standard iio types
Message-ID: <20190303132731.41cfdf80@archlinux>
In-Reply-To: <20190225191731.5822-1-beniamin.bia@analog.com>
References: <20190225191731.5822-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 21:17:30 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Frequency attribute is added with a standard type from iio framework
> instead of custom attribute. This is a small step towards removing any
> unnecessary custom attribute. Ad9834 will diverge from ad9833 in the
> future, that is why we have two identical arrays for ad9834 and 9833.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>

What happened to patch 3?

I definitely want wider discussion of the ABI in here if anyone has time
to comment!

Note that I would prefer to separate out the ABI as a separate patch to
aid discussion in future series. It's fine to have it after the patches
that implement it.

> ---
> Changed in v3:
>         -based on Jonathan suggestion, i replaced default option with
>         Ad9834 DeviceId
>         -added a local variable in frequency to simplify the code
>         -added ABI documentation
> 
>  .../testing/sysfs-bus-iio-frequency-ad9834    | 129 ++++++++++++++++++
>  drivers/staging/iio/frequency/ad9834.c        | 104 +++++++++++---
>  2 files changed, 216 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834
> new file mode 100644
> index 000000000000..b912b49473a3
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834
> @@ -0,0 +1,129 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_frequency
> +KernelVersion:	3.5.0
> +Date:		April 2012
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Represents the value from frequency register 0 of device. The
> +		value is between 0 and clock frequency / 2.
> +		Reading returns the value of frequency written in register 0.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage1_frequency
> +KernelVersion:	3.5.0
> +Date:		April 2012
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Represents the value from frequency register 1 of device. The
> +		value is between 0 and clock frequency / 2.
> +		Reading returns the value of frequency written in register 1.

Hmm. So this is the fundamental question of this ABI.  Is it fine to represent
two different possible outputs that are (sort of) muxed onto one wire as separate
channels?  FSK / PSK as relevant.
It may be that we need

/sys/bus/iio/devices/iio:deviceX/out_voltage0_symbol0_frequency
/sys/bus/iio/devices/iio:deviceX/out_voltage0_symbol1_frequency
for example to more cleanly represent this?  Perhaps using modifiers to
hammer this into the existing framework.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_phase0
> +KernelVersion:	3.5.0
> +Date:		April 2012
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Represents the value from phase register 0 of device. The value
> +		is between 0 and 4096 rad.
> +		Reading returns the value of phase written in register 0.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_phase1
> +KernelVersion:	3.5.0
> +Date:		April 2012
> +Date:		February 2019
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Represents the value from phase register 1 of device.
> +		The value is between 0 and 4096 rad
> +		Reading returns the value of phase written in register 1.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out0_wavetype_available
> +KernelVersion:	3.5.0
> +Date:		April 2012
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the possible waveform of output:
> +		sine - for a sinewave
> +		triangle - for a triangle signal
> +		square - squarewave, this is only available on ad9833/7
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out0_wavetype
> +KernelVersion:	3.5.0
> +Date:		April 2012
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Represents the output waveform of channel:
> +		sine - for a sinewave
> +		triangle - for a triangle signal
> +		square - squarewave, this is only available on ad9833/7


So these are different channels?  out0 and out1 different pins?
I am particularly confused given on the ad9834 they are IOUT and IOUTB
and seem to track together.


> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out1_wavetype_available
> +KernelVersion:	3.5.0
> +Date:		April 2012
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the possible waveform type for accumulator
> +		output:
> +		square - for a squarewave output
> +		nothing - when orbiten is activated
> +		This is only available on ad9834
Ah. Is this actually the sign bit output on that device?  That I would treat
as a different channel. We don't really have a clean description for
multiple outputs from a single generator, but we do allow any given control
to effect any other control, or to use shared attributes to cover multiple channels.
Here the frequency and phase controls for example.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out1_wavetype
> +KernelVersion:	3.5.0
> +Date:		April 2012
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Represents the accumulator output waveform:
> +		square or nothing when orbiten is activated

Nothing seems to overlap with enabled below. If there is no reason a user
would care which was true, I would just have this as a fixed value of square.
They can disable the output if they like.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_pincontrol_en
> +KernelVersion:	3.5.0
> +Date:		April 2012
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Represents the PIN_SW bit and determines if the device is
> +		control by spi or by gpio pins.
> +		Reading returns the selected method.
> +		Is only available for ad9834.

This is something that should probably come from DT. Is there a good reason you might want
to control it from userspace?

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_frequencysymbol
> +KernelVersion:	3.5.0
> +Date:		April 2012
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Represents which frequency register is selected. These devices
> +		have two registers for frequency and phase but only one
> +		output. The user can select which one controls the output.
> +		0 represents frequency 0 which is mapped to
> +		out_altvoltage0_frequency
> +		1 represents frequency 1 which is mapped to
> +		out_altvoltage1_frequency
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_phasesymbol
> +KernelVersion:	3.5.0
> +Date:		April 2012
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Represents which phase register is selected. These devices
> +		have two registers for frequency and phase but only one
> +		output. The user can select which one controls the output.
> +		0 represents phase 0 which is mapped to
> +		out_altvoltage0_phase0
> +		1 represents phase 1 which is mapped to
> +		out_altvoltage0_phase1
These two seems about as good as we can do. Also will generalise to more
complex chips with more than 2 options which is good

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out0_enable
> +KernelVersion:	3.5.0
> +Date:		April 2012
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Enable or disable the output from channel.
> +		0 represents disabled
> +		1 represents enabled

So this is represented on DACs etc as powerdown and has modes to indicate
if it is high impedance or similar when off.
We should use that sort of interface her as well.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out1_enable
> +KernelVersion:	3.5.0
> +Date:		April 2012
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Enable or disable the output from accumulator channel.
> +		0 represents disabled
> +		1 represents enabled
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index f036f75d1f22..8465dac656dd 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -81,6 +81,8 @@ struct ad9834_state {
>  	struct spi_message		freq_msg;
>  	struct mutex                    lock;   /* protect sensor state */
>  
> +	unsigned long			frequency[2];
> +
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -89,6 +91,11 @@ struct ad9834_state {
>  	__be16				freq_data[2];
>  };
>  
> +enum ad9834_ch_addr {
> +	AD9834_CHANNEL_ADDRESS0,
> +	AD9834_CHANNEL_ADDRESS1,
> +};
> +
>  /**
>   * ad9834_supported_device_ids:
>   */
> @@ -100,6 +107,24 @@ enum ad9834_supported_device_ids {
>  	ID_AD9838,
>  };
>  
> +#define AD9833_CHANNEL(chan) {						\
> +		.type = IIO_ALTVOLTAGE,					\
> +		.indexed = 1,						\
> +		.output = 1,						\
> +		.channel = (chan),					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY)	\
> +}
> +
> +static const struct iio_chan_spec ad9833_channels[] = {
> +	AD9833_CHANNEL(0),
> +	AD9833_CHANNEL(1),
> +};
> +
> +static const struct iio_chan_spec ad9834_channels[] = {
> +	AD9833_CHANNEL(0),
> +	AD9833_CHANNEL(1),
> +};
> +
>  static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
> @@ -109,10 +134,13 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
>  }
>  
>  static int ad9834_write_frequency(struct ad9834_state *st,
> -				  unsigned long addr, unsigned long fout)
> +				  enum ad9834_ch_addr addr,
> +				  unsigned long fout)
>  {
> +	unsigned long frequency_register;
>  	unsigned long clk_freq;
>  	unsigned long regval;
> +	int ret;
>  
>  	clk_freq = clk_get_rate(st->mclk);
>  
> @@ -121,13 +149,24 @@ static int ad9834_write_frequency(struct ad9834_state *st,
>  
>  	regval = ad9834_calc_freqreg(clk_freq, fout);
>  
> -	st->freq_data[0] = cpu_to_be16(addr | (regval &
> +	if (addr == AD9834_CHANNEL_ADDRESS0)
> +		frequency_register = AD9834_REG_FREQ0;
> +	else
> +		frequency_register = AD9834_REG_FREQ1;
> +
> +	st->freq_data[0] = cpu_to_be16(frequency_register | (regval &
>  				       RES_MASK(AD9834_FREQ_BITS / 2)));
> -	st->freq_data[1] = cpu_to_be16(addr | ((regval >>
> +	st->freq_data[1] = cpu_to_be16(frequency_register | ((regval >>
>  				       (AD9834_FREQ_BITS / 2)) &
>  				       RES_MASK(AD9834_FREQ_BITS / 2)));
>  
> -	return spi_sync(st->spi, &st->freq_msg);
> +	ret = spi_sync(st->spi, &st->freq_msg);
> +	if (ret)
> +		return ret;
> +
> +	st->frequency[(int)addr] = fout;
> +
> +	return 0;
>  }
>  
>  static int ad9834_write_phase(struct ad9834_state *st,
> @@ -140,6 +179,39 @@ static int ad9834_write_phase(struct ad9834_state *st,
>  	return spi_sync(st->spi, &st->msg);
>  }
>  
> +static int ad9834_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct ad9834_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		*val = st->frequency[chan->channel];
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad9834_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ad9834_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		return ad9834_write_frequency(st,
> +					      (enum ad9834_ch_addr)chan->channel,
> +					      val);
> +	default:
> +		return  -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static ssize_t ad9834_write(struct device *dev,
>  			    struct device_attribute *attr,
>  			    const char *buf,
> @@ -157,10 +229,6 @@ static ssize_t ad9834_write(struct device *dev,
>  
>  	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
> -	case AD9834_REG_FREQ0:
> -	case AD9834_REG_FREQ1:
> -		ret = ad9834_write_frequency(st, this_attr->address, val);
> -		break;
>  	case AD9834_REG_PHASE0:
>  	case AD9834_REG_PHASE1:
>  		ret = ad9834_write_phase(st, this_attr->address, val);
> @@ -323,8 +391,6 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
>   * see dds.h for further information
>   */
>  
> -static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9834_write, AD9834_REG_FREQ0);
> -static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9834_write, AD9834_REG_FREQ1);
>  static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
>  static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
>  
> @@ -342,8 +408,6 @@ static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
>  static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
>  
>  static struct attribute *ad9834_attributes[] = {
> -	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
>  	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> @@ -361,8 +425,6 @@ static struct attribute *ad9834_attributes[] = {
>  };
>  
>  static struct attribute *ad9833_attributes[] = {
> -	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
>  	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> @@ -384,11 +446,15 @@ static const struct attribute_group ad9833_attribute_group = {
>  };
>  
>  static const struct iio_info ad9834_info = {
> +	.write_raw = &ad9834_write_raw,
> +	.read_raw = &ad9834_read_raw,
>  	.attrs = &ad9834_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
>  
>  static const struct iio_info ad9833_info = {
> +	.write_raw = &ad9834_write_raw,
> +	.read_raw = &ad9834_read_raw,
>  	.attrs = &ad9833_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
> @@ -435,9 +501,13 @@ static int ad9834_probe(struct spi_device *spi)
>  	switch (st->devid) {
>  	case ID_AD9833:
>  	case ID_AD9837:
> +		indio_dev->channels = ad9833_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad9833_channels);
>  		indio_dev->info = &ad9833_info;
>  		break;
> -	default:
> +	case ID_AD9834:
> +		indio_dev->channels = ad9834_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad9834_channels);
>  		indio_dev->info = &ad9834_info;
>  		break;
>  	}
> @@ -474,11 +544,11 @@ static int ad9834_probe(struct spi_device *spi)
>  		goto error_clock_unprepare;
>  	}
>  
> -	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, 1000000);
> +	ret = ad9834_write_frequency(st, AD9834_CHANNEL_ADDRESS0, 1000000);
>  	if (ret)
>  		goto error_clock_unprepare;
>  
> -	ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, 5000000);
> +	ret = ad9834_write_frequency(st, AD9834_CHANNEL_ADDRESS1, 5000000);
>  	if (ret)
>  		goto error_clock_unprepare;
>  

