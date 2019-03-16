Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E443CC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6889218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552758957;
	bh=zrzXPciFGASrB1+lQG4H/u1D6sELZcPgSHAhBz16scg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pJkQR7V+auYhdVSXPtpR891JbOhshf25h9/yV1fDpa/kzI5JW3IWGRPsFn3Iu61Lu
	 STdjC69S+nCr7Rbjesn8LtOGMxqc/VIn3Og8dA1UWfjYhOdolf+QUCiQaS0dVr1JqI
	 R3Pne3xh2DnR+p5CLreKQWhh0EARiBfbc+z5VwR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCPRz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPRz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:55:56 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 357F3218D0;
        Sat, 16 Mar 2019 17:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552758955;
        bh=zrzXPciFGASrB1+lQG4H/u1D6sELZcPgSHAhBz16scg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nLGRAMgONXJMnhW6PSvALgAzzrikbRrzfZyF7Etn7QWaAy7zGe0OjkblCP6UB/JRi
         RlHvVHH8pCXORotGMRXbA7fBiylrh2PdvaIMfGBPGlTlCrkz7UX6ZkwRZf+0ciA+eM
         +FJDvBQM9t0lJm0AZsIxpPkWusGA1e+6BO+gJ6Xs=
Date:   Sat, 16 Mar 2019 17:55:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 04/11] staging: iio: ad7780: add filter reading to
 ad778x
Message-ID: <20190316175548.2873277a@archlinux>
In-Reply-To: <66a914ed7d1512f5aedfc5a0c6cbae38f5588e35.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
        <66a914ed7d1512f5aedfc5a0c6cbae38f5588e35.1552700652.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 23:13:42 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> This patch adds the new feature of reading the filter odr value for
> ad778x chips. This value is stored in the chip's state struct whenever a
> read or write call is performed on the chip's driver.
> 
> This feature requires sharing SAMP_FREQ. Since the ad717x does not have
> a filter option, the driver only shares the relevant info mask for the
> ad778x family.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
Applied,

Thanks,

Jonathan

> ---
> Changes in v4:
>  - As mentioned in the previous patch, this was originally as part of
>    the 'add gain & filter gpio support' patch
> Changes in v5:
>  - Moved ad778x_odr_avail declaration from GPIO patch to this one
> 
>  drivers/staging/iio/adc/ad7780.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index fbcc0d3345ca..8ff74427d975 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -42,7 +42,8 @@
>  #define AD7780_GAIN_MIDPOINT	64
>  #define AD7780_FILTER_MIDPOINT	13350
>  
> -static const unsigned int ad778x_gain[2] = { 1, 128 };
> +static const unsigned int ad778x_gain[2]      = { 1, 128 };
> +static const unsigned int ad778x_odr_avail[2] = { 10000, 16700 };
>  
>  struct ad7780_chip_info {
>  	struct iio_chan_spec	channel;
> @@ -58,6 +59,7 @@ struct ad7780_state {
>  	struct gpio_desc		*gain_gpio;
>  	struct gpio_desc		*filter_gpio;
>  	unsigned int			gain;
> +	unsigned int			odr;
>  	unsigned int			int_vref_mv;
>  
>  	struct ad_sigma_delta sd;
> @@ -120,6 +122,9 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val = -(1 << (chan->scan_type.realbits - 1));
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->odr;
> +		return IIO_VAL_INT;
>  	default:
>  		break;
>  	}
> @@ -162,6 +167,7 @@ static int ad7780_write_raw(struct iio_dev *indio_dev,
>  			val = 0;
>  		else
>  			val = 1;
> +		st->odr = ad778x_odr_avail[val];
>  		gpiod_set_value(st->filter_gpio, val);
>  		break;
>  	default:
> @@ -181,8 +187,10 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
>  	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
>  		return -EIO;
>  
> -	if (chip_info->is_ad778x)
> +	if (chip_info->is_ad778x) {
>  		st->gain = ad778x_gain[raw_sample & AD7780_GAIN];
> +		st->odr = ad778x_odr_avail[raw_sample & AD7780_FILTER];
> +	}
>  
>  	return 0;
>  }
> @@ -194,17 +202,19 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
>  };
>  
>  #define AD7780_CHANNEL(bits, wordsize) \
> +	AD_SD_CHANNEL(1, 0, 0, bits, 32, wordsize - bits)
> +#define AD7170_CHANNEL(bits, wordsize) \
>  	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
>  
>  static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
>  	[ID_AD7170] = {
> -		.channel = AD7780_CHANNEL(12, 24),
> +		.channel = AD7170_CHANNEL(12, 24),
>  		.pattern = AD7170_PATTERN,
>  		.pattern_mask = AD7170_PATTERN_MASK,
>  		.is_ad778x = false,
>  	},
>  	[ID_AD7171] = {
> -		.channel = AD7780_CHANNEL(16, 24),
> +		.channel = AD7170_CHANNEL(16, 24),
>  		.pattern = AD7170_PATTERN,
>  		.pattern_mask = AD7170_PATTERN_MASK,
>  		.is_ad778x = false,

