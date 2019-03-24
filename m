Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10D9C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B588821741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553448875;
	bh=PvoCuKwW7DI2JVBDkf0YUNNjEdKODMrujI7t4XtFxlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xRDTuAsninl8THxj7dNK+xw5EqoLXQYMznRnu7B271BeTJoyXsiv/XRuIfOdr2KDr
	 hLe/Cj2UJ3NSpHJvIlDZz5haGjqbWGZyeXIW6Vpgggk4R6keRttKXCU1mPLbt89Fzn
	 AiFjfT61/uNYq/gWxIMTK8b2G1cHyuUAXHbYhN74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfCXRee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfCXRee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:34:34 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D84202171F;
        Sun, 24 Mar 2019 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553448872;
        bh=PvoCuKwW7DI2JVBDkf0YUNNjEdKODMrujI7t4XtFxlY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QB17A7qHAdjV89iF9ddnmZkCyOHmTzkJIx3wdgmraQVA3/Iq1IxaLOKO/WLw8usi4
         BgnZCkDO4VFC9/MfYMcVChxorxbbjLKCt66W25IhmLXiX6eh2jLejQzZQEJ4pZ0NAA
         kohvZiSoKCvgVnJwDVHGcaPfcLysEYRxCHoO4J0A=
Date:   Sun, 24 Mar 2019 17:34:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: adc: ad7192: Use read_avail for available
 attributes
Message-ID: <20190324173427.62f004cb@archlinux>
In-Reply-To: <20190319142520.664-1-mircea.caprioru@analog.com>
References: <20190319142520.664-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 16:25:20 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch removes the in_voltage-voltage_scale_available and
> in_voltage_scale_available attributes. These are replaced with available
> attributes added in info_mask_shared_by_type_available.
> 
> With this modification the iio core will be responsible with naming the
> attributes thus removing the checkpatch warning related to
> in_voltage-voltage_scale_available naming.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>

Thanks for sorting this out!  Many future newbies will avoid the
trap this set a a result of this ;)

There is a lot of code in here just to tweak whether the scale available bit
is set or not.

Hmm. Lets do this for now, but we may need to have a a think about whether
to adjust the ad_ core to deal with it at some point.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7192.c | 99 ++++++++++++++++++++------------
>  1 file changed, 61 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index acdbc07fd259..d8a20f9066f4 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -337,30 +337,6 @@ static int ad7192_setup(struct ad7192_state *st,
>  	return ret;
>  }
>  
> -static ssize_t
> -ad7192_show_scale_available(struct device *dev,
> -			    struct device_attribute *attr, char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7192_state *st = iio_priv(indio_dev);
> -	int i, len = 0;
> -
> -	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
> -		len += sprintf(buf + len, "%d.%09u ", st->scale_avail[i][0],
> -			       st->scale_avail[i][1]);
> -
> -	len += sprintf(buf + len, "\n");
> -
> -	return len;
> -}
> -
> -static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> -			     in_voltage-voltage_scale_available,
> -			     0444, ad7192_show_scale_available, NULL, 0);
> -
> -static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
> -		       ad7192_show_scale_available, NULL, 0);
> -
>  static ssize_t ad7192_show_ac_excitation(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
> @@ -435,8 +411,6 @@ static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
>  		       AD7192_REG_MODE);
>  
>  static struct attribute *ad7192_attributes[] = {
> -	&iio_dev_attr_in_v_m_v_scale_available.dev_attr.attr,
> -	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
>  	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
>  	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
>  	NULL
> @@ -447,8 +421,6 @@ static const struct attribute_group ad7192_attribute_group = {
>  };
>  
>  static struct attribute *ad7195_attributes[] = {
> -	&iio_dev_attr_in_v_m_v_scale_available.dev_attr.attr,
> -	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
>  	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
>  	NULL
>  };
> @@ -579,10 +551,31 @@ static int ad7192_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int ad7192_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
> +{
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)st->scale_avail;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		/* Values are stored in a 2D matrix  */
> +		*length = ARRAY_SIZE(st->scale_avail) * 2;
> +
> +		return IIO_AVAIL_LIST;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static const struct iio_info ad7192_info = {
>  	.read_raw = ad7192_read_raw,
>  	.write_raw = ad7192_write_raw,
>  	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
> +	.read_avail = ad7192_read_avail,
>  	.attrs = &ad7192_attribute_group,
>  	.validate_trigger = ad_sd_validate_trigger,
>  };
> @@ -591,6 +584,7 @@ static const struct iio_info ad7195_info = {
>  	.read_raw = ad7192_read_raw,
>  	.write_raw = ad7192_write_raw,
>  	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
> +	.read_avail = ad7192_read_avail,
>  	.attrs = &ad7195_attribute_group,
>  	.validate_trigger = ad_sd_validate_trigger,
>  };
> @@ -625,6 +619,42 @@ static const struct iio_chan_spec ad7193_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(14),
>  };
>  
> +static int ad7192_channels_config(struct iio_dev *indio_dev)
> +{
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +	const struct iio_chan_spec *channels;
> +	struct iio_chan_spec *chan;
> +	int i;
> +
> +	switch (st->devid) {
> +	case ID_AD7193:
> +		channels = ad7193_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad7193_channels);
> +		break;
> +	default:
> +		channels = ad7192_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad7192_channels);
> +		break;
> +	}
> +
> +	chan = devm_kcalloc(indio_dev->dev.parent, indio_dev->num_channels,
> +			    sizeof(*chan), GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = chan;
> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		*chan = channels[i];
> +		if (chan->type != IIO_TEMP)
> +			chan->info_mask_shared_by_type_available |=
> +				BIT(IIO_CHAN_INFO_SCALE);
> +		chan++;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ad7192_probe(struct spi_device *spi)
>  {
>  	const struct ad7192_platform_data *pdata = dev_get_platdata(&spi->dev);
> @@ -687,16 +717,9 @@ static int ad7192_probe(struct spi_device *spi)
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	switch (st->devid) {
> -	case ID_AD7193:
> -		indio_dev->channels = ad7193_channels;
> -		indio_dev->num_channels = ARRAY_SIZE(ad7193_channels);
> -		break;
> -	default:
> -		indio_dev->channels = ad7192_channels;
> -		indio_dev->num_channels = ARRAY_SIZE(ad7192_channels);
> -		break;
> -	}
> +	ret = ad7192_channels_config(indio_dev);
> +	if (ret < 0)
> +		goto error_disable_dvdd;
>  
>  	if (st->devid == ID_AD7195)
>  		indio_dev->info = &ad7195_info;

