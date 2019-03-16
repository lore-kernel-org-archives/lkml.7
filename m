Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCDAC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F40E2186A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552755172;
	bh=dmf7QsFHbOzm57ewRg0hW0LygKeGeuE7wm5dGlkeZWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=y7Mrdzb7ua7Cm0RBR9acdW14nPgrZRNvYAr7178MQYYpalFQbYDYsDWhdBE+Me0l+
	 TzBnyXB7IskaCR++OjCWVR1Y9i846PrTq81lqNDva2Mxnq+g7iNQ9YxTQdSwYGUxnq
	 Q1eE7CIADlkjFqaAhu+joMuBszvP8gaqSmHAKX2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfCPQwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbfCPQwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:52:51 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2040E2075C;
        Sat, 16 Mar 2019 16:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552755169;
        bh=dmf7QsFHbOzm57ewRg0hW0LygKeGeuE7wm5dGlkeZWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t15kNGPsAkJI3MWx/QosLd/lBnsj5mUGMY0LIHpl8H2YsRo2pBqpomXME9uPZEZIP
         DxXzcqJHudHpPB0Wgm0VA8PbHpzJrntMVNDyD/A11kGwCDX5q8CpQCqZEtKPQKbgAx
         YUJlLSlL9pQ3DRj7lnw1eLBWLNtgF8nTd6XWhuIs=
Date:   Sat, 16 Mar 2019 16:52:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7192: Use DT clock binding
Message-ID: <20190316165153.14341f49@archlinux>
In-Reply-To: <20190315112903.15855-1-mircea.caprioru@analog.com>
References: <20190315112903.15855-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190316165244.9POVRwtcGO16dnh5y_nU4KY3phNEvUA9v4Cs906dsyw@z>

On Fri, 15 Mar 2019 13:29:02 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch replaces the platform data clock select member with DT clock
> binding. Through the DT the external clock binding is specified. If this is
> not provided then the device will use the internal clock source.
> 
> With the external clock binding there is the option to use a clock or a
> crystal as the clock source. When an external crystal is used it is
> connected to MCLK1 and MCLK2 pins. If the external clock is used only MCLK2
> pin will be connected.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Note I reordered with earlier patch to avoid breaking bisectablity.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7192.c | 84 ++++++++++++++++++++++----------
>  drivers/staging/iio/adc/ad7192.h |  2 -
>  2 files changed, 58 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 27f962b8c4ef..5c54ce380fa5 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/interrupt.h>
> +#include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -156,14 +157,16 @@
>  struct ad7192_state {
>  	struct regulator		*avdd;
>  	struct regulator		*dvdd;
> +	struct clk			*mclk;
>  	u16				int_vref_mv;
> -	u32				mclk;
> +	u32				fclk;
>  	u32				f_order;
>  	u32				mode;
>  	u32				conf;
>  	u32				scale_avail[8][2];
>  	u8				gpocon;
>  	u8				devid;
> +	u8				clock_sel;
>  	struct mutex			lock;	/* protect sensor state */
>  
>  	struct ad_sigma_delta		sd;
> @@ -226,6 +229,27 @@ static inline bool ad7192_valid_external_frequency(u32 freq)
>  		freq <= AD7192_EXT_FREQ_MHZ_MAX);
>  }
>  
> +static int ad7192_of_clock_select(struct ad7192_state *st)
> +{
> +	struct device_node *np = st->sd.spi->dev.of_node;
> +	unsigned int clock_sel;
> +
> +	clock_sel = AD7192_CLK_INT;
> +
> +	/* use internal clock */
> +	if (PTR_ERR(st->mclk) == -ENOENT) {
> +		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
> +			clock_sel = AD7192_CLK_INT_CO;
> +	} else {
> +		if (of_property_read_bool(np, "adi,clock-xtal"))
> +			clock_sel = AD7192_CLK_EXT_MCLK1_2;
> +		else
> +			clock_sel = AD7192_CLK_EXT_MCLK2;
> +	}
> +
> +	return clock_sel;
> +}
> +
>  static int ad7192_setup(struct ad7192_state *st,
>  			const struct ad7192_platform_data *pdata)
>  {
> @@ -250,28 +274,8 @@ static int ad7192_setup(struct ad7192_state *st,
>  		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X)\n",
>  			 id);
>  
> -	switch (pdata->clock_source_sel) {
> -	case AD7192_CLK_INT:
> -	case AD7192_CLK_INT_CO:
> -		st->mclk = AD7192_INT_FREQ_MHZ;
> -		break;
> -	case AD7192_CLK_EXT_MCLK1_2:
> -	case AD7192_CLK_EXT_MCLK2:
> -		if (ad7192_valid_external_frequency(pdata->ext_clk_hz)) {
> -			st->mclk = pdata->ext_clk_hz;
> -			break;
> -		}
> -		dev_err(&st->sd.spi->dev, "Invalid frequency setting %u\n",
> -			pdata->ext_clk_hz);
> -		ret = -EINVAL;
> -		goto out;
> -	default:
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
>  	st->mode = AD7192_MODE_SEL(AD7192_MODE_IDLE) |
> -		AD7192_MODE_CLKSRC(pdata->clock_source_sel) |
> +		AD7192_MODE_CLKSRC(st->clock_sel) |
>  		AD7192_MODE_RATE(480);
>  
>  	st->conf = AD7192_CONF_GAIN(0);
> @@ -496,7 +500,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>  			*val -= 273 * ad7192_get_temp_scale(unipolar);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val = st->mclk /
> +		*val = st->fclk /
>  			(st->f_order * 1024 * AD7192_MODE_RATE(st->mode));
>  		return IIO_VAL_INT;
>  	}
> @@ -543,7 +547,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  			break;
>  		}
>  
> -		div = st->mclk / (val * st->f_order * 1024);
> +		div = st->fclk / (val * st->f_order * 1024);
>  		if (div < 1 || div > 1023) {
>  			ret = -EINVAL;
>  			break;
> @@ -706,15 +710,42 @@ static int ad7192_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_disable_dvdd;
>  
> +	st->fclk = AD7192_INT_FREQ_MHZ;
> +
> +	st->mclk = devm_clk_get(&st->sd.spi->dev, "mclk");
> +	if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) != -ENOENT) {
> +		ret = PTR_ERR(st->mclk);
> +		goto error_remove_trigger;
> +	}
> +
> +	st->clock_sel = ad7192_of_clock_select(st);
> +
> +	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
> +	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
> +		ret = clk_prepare_enable(st->mclk);
> +		if (ret < 0)
> +			goto error_remove_trigger;
> +
> +		st->fclk = clk_get_rate(st->mclk);
> +		if (!ad7192_valid_external_frequency(st->fclk)) {
> +			ret = -EINVAL;
> +			dev_err(&spi->dev,
> +				"External clock frequency out of bounds\n");
> +			goto error_disable_clk;
> +		}
> +	}
> +
>  	ret = ad7192_setup(st, pdata);
>  	if (ret)
> -		goto error_remove_trigger;
> +		goto error_disable_clk;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
> -		goto error_remove_trigger;
> +		goto error_disable_clk;
>  	return 0;
>  
> +error_disable_clk:
> +	clk_disable_unprepare(st->mclk);
>  error_remove_trigger:
>  	ad_sd_cleanup_buffer_and_trigger(indio_dev);
>  error_disable_dvdd:
> @@ -731,6 +762,7 @@ static int ad7192_remove(struct spi_device *spi)
>  	struct ad7192_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> +	clk_disable_unprepare(st->mclk);
>  	ad_sd_cleanup_buffer_and_trigger(indio_dev);
>  
>  	regulator_disable(st->dvdd);
> diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
> index 7433a43c2611..3be3ee269ed5 100644
> --- a/drivers/staging/iio/adc/ad7192.h
> +++ b/drivers/staging/iio/adc/ad7192.h
> @@ -33,8 +33,6 @@
>  
>  struct ad7192_platform_data {
>  	u16		vref_mv;
> -	u8		clock_source_sel;
> -	u32		ext_clk_hz;
>  	bool		refin2_en;
>  	bool		rej60_en;
>  	bool		sinc3_en;

