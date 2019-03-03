Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456E4C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9D220866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551619730;
	bh=6KcEsyVyVrAJALEjI0okWya77jfax1ZE0UGEQXRLWKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=noZafD3LyN1HlCcNAkN5sFX0c0u857Khwtq9T9v/xXtYyLX0NYR8nVzpo4CuEPo17
	 RLhZO5ZkL6PJEw+C/r69bS6GKi0+GD4XSaypQi+ZmNKSQFB7VMIbYK2QlY0WWG5SMo
	 wfsBCRl4hMf9r/FXnmxXIBzkEvbvDG7jtT6VYUbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCCN2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 08:28:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbfCCN2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 08:28:48 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4836F20857;
        Sun,  3 Mar 2019 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551619727;
        bh=6KcEsyVyVrAJALEjI0okWya77jfax1ZE0UGEQXRLWKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e1RgXtNaGAFKgqjN6Xr5+tR/w4BJdDxF8JcgVAx5EmMURQOVqv3qPs8MbpNtnWMFm
         0Z2bzawmj0opOxtpNfJOIIEahCZ3JzKtu2ErwIdPjzoM0Cwo8U16W5FMQ+yVJH8eDt
         HlkIOeeej4aHzWogXv7Lh5AtCpjzCagZzp2d/fcM=
Date:   Sun, 3 Mar 2019 13:28:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <biabeniamin@outlook.com>
Subject: Re: [PATCH v3 2/3] staging: iio: frequency: ad9834: Move phase and
 scale to standard iio attribute
Message-ID: <20190303132841.7da1e454@archlinux>
In-Reply-To: <20190225191731.5822-2-beniamin.bia@analog.com>
References: <20190225191731.5822-1-beniamin.bia@analog.com>
        <20190225191731.5822-2-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 21:17:31 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> The custom phase and scale attributes were moved to standard iio types.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
> Changes in v3:
>         -abi documentation added
> 
>  .../testing/sysfs-bus-iio-frequency-ad9834    | 10 ++--
>  drivers/staging/iio/frequency/ad9834.c        | 53 +++++++++++--------
>  2 files changed, 38 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834
> index b912b49473a3..656aa5b6d22b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834
> @@ -1,3 +1,5 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_scale
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_frequency
>  KernelVersion:	3.5.0
>  Date:		April 2012
> @@ -16,7 +18,7 @@ Description:
>  		value is between 0 and clock frequency / 2.
>  		Reading returns the value of frequency written in register 1.
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_phase0
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_phase

Ah, I see what you are doing here.  Much better to just have the final ABI
documented to discuss than doing it in steps.

>  KernelVersion:	3.5.0
>  Date:		April 2012
>  Contact:	linux-iio@vger.kernel.org
> @@ -25,7 +27,7 @@ Description:
>  		is between 0 and 4096 rad.
>  		Reading returns the value of phase written in register 0.
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_phase1
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage1_phase
>  KernelVersion:	3.5.0
>  Date:		April 2012
>  Date:		February 2019
> @@ -106,9 +108,9 @@ Description:
>  		have two registers for frequency and phase but only one
>  		output. The user can select which one controls the output.
>  		0 represents phase 0 which is mapped to
> -		out_altvoltage0_phase0
> +		out_altvoltage0_phase
>  		1 represents phase 1 which is mapped to
> -		out_altvoltage0_phase1
> +		out_altvoltage1_phase
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out0_enable
>  KernelVersion:	3.5.0
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 8465dac656dd..107d859dadd7 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -82,6 +82,7 @@ struct ad9834_state {
>  	struct mutex                    lock;   /* protect sensor state */
>  
>  	unsigned long			frequency[2];
> +	unsigned long			phase[2];
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -113,6 +114,8 @@ enum ad9834_supported_device_ids {
>  		.output = 1,						\
>  		.channel = (chan),					\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY)	\
> +						| BIT(IIO_CHAN_INFO_PHASE),\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>  }
>  
>  static const struct iio_chan_spec ad9833_channels[] = {
> @@ -170,13 +173,26 @@ static int ad9834_write_frequency(struct ad9834_state *st,
>  }
>  
>  static int ad9834_write_phase(struct ad9834_state *st,
> -			      unsigned long addr, unsigned long phase)
> +			      enum ad9834_ch_addr addr,
> +			      unsigned long phase)
>  {
> +	int ret;
> +
>  	if (phase > BIT(AD9834_PHASE_BITS))
>  		return -EINVAL;
> -	st->data = cpu_to_be16(addr | phase);
>  
> -	return spi_sync(st->spi, &st->msg);
> +	if (addr == AD9834_CHANNEL_ADDRESS0)
> +		st->data = cpu_to_be16(AD9834_REG_PHASE0 | phase);
> +	else
> +		st->data = cpu_to_be16(AD9834_REG_PHASE1 | phase);
> +
> +	ret = spi_sync(st->spi, &st->msg);
> +	if (ret)
> +		return ret;
> +
> +	st->phase[(int)addr] = phase;
> +
> +	return 0;
>  }
>  
>  static int ad9834_read_raw(struct iio_dev *indio_dev,
> @@ -189,6 +205,13 @@ static int ad9834_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_FREQUENCY:
>  		*val = st->frequency[chan->channel];
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PHASE:
> +		*val = st->phase[chan->channel];
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/*1 hz */
> +		*val = 1;
> +		return IIO_VAL_INT;
>  	}
>  
>  	return -EINVAL;
> @@ -205,6 +228,10 @@ static int ad9834_write_raw(struct iio_dev *indio_dev,
>  		return ad9834_write_frequency(st,
>  					      (enum ad9834_ch_addr)chan->channel,
>  					      val);
> +	case IIO_CHAN_INFO_PHASE:
> +		return ad9834_write_phase(st,
> +					  (enum ad9834_ch_addr)chan->channel,
> +					  val);
>  	default:
>  		return  -EINVAL;
>  	}
> @@ -229,10 +256,6 @@ static ssize_t ad9834_write(struct device *dev,
>  
>  	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
> -	case AD9834_REG_PHASE0:
> -	case AD9834_REG_PHASE1:
> -		ret = ad9834_write_phase(st, this_attr->address, val);
> -		break;
>  	case AD9834_OPBITEN:
>  		if (st->control & AD9834_MODE) {
>  			ret = -EINVAL;  /* AD9843 reserved mode */
> @@ -392,12 +415,8 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
>   */
>  
>  static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
> -static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
>  
> -static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9834_write, AD9834_REG_PHASE0);
> -static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9834_write, AD9834_REG_PHASE1);
>  static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL, ad9834_write, AD9834_PSEL);
> -static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
>  
>  static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
>  	ad9834_write, AD9834_PIN_SW);
> @@ -408,10 +427,6 @@ static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
>  static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
>  
>  static struct attribute *ad9834_attributes[] = {
> -	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> -	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
> @@ -425,10 +440,6 @@ static struct attribute *ad9834_attributes[] = {
>  };
>  
>  static struct attribute *ad9833_attributes[] = {
> -	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> -	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
> @@ -552,11 +563,11 @@ static int ad9834_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_clock_unprepare;
>  
> -	ret = ad9834_write_phase(st, AD9834_REG_PHASE0, 512);
> +	ret = ad9834_write_phase(st, AD9834_CHANNEL_ADDRESS0, 512);
>  	if (ret)
>  		goto error_clock_unprepare;
>  
> -	ret = ad9834_write_phase(st, AD9834_REG_PHASE1, 1024);
> +	ret = ad9834_write_phase(st, AD9834_CHANNEL_ADDRESS1, 1024);
>  	if (ret)
>  		goto error_clock_unprepare;
>  

