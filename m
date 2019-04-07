Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4635DC282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0992320B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554634465;
	bh=iTiO+5kEp1QErb90eTAPBY3RZYbr5ypFvAM1OBy1HAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BjDylbK0mbdFih8nTYp2R2y0vP/5pV3RLEHP8NIifNwFrTHveaHTqTsRpEU+ufwko
	 hN7kIFhKAdR0kbWa+HX/uPJbErOwhd5ye6bUiGMeD5QTE+WyIgu232m7DWTys9qvlR
	 MprtaKz17WYagwJMilWNAM5qNxQPrqYeXri+MaYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfDGKyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 06:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfDGKyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 06:54:23 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51B82218CD;
        Sun,  7 Apr 2019 10:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554634462;
        bh=iTiO+5kEp1QErb90eTAPBY3RZYbr5ypFvAM1OBy1HAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eOPiYLiBbZku++4KwYxNwY1+yCu/Hbz+rRa6M/dt1MXtBYRsZyRnRtEwF+Jyjaw3V
         EqWx9hoOoRfwLf+uMnMNolHxgq2mn6AJ797V0Un5YoLgR0wWn/9P5JVgSlrclRsWBf
         /Sx5BC3nkZdJskWre+WSGFK8V5RqvhfZphrT+4ro=
Date:   Sun, 7 Apr 2019 11:54:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 2/3] iio: adc: ad7616: Add support for AD7616 ADC
Message-ID: <20190407115415.71705dd1@archlinux>
In-Reply-To: <20190402131841.8430-2-beniamin.bia@analog.com>
References: <20190402131841.8430-1-beniamin.bia@analog.com>
        <20190402131841.8430-2-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019 16:18:40 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> The AD7616 is a 12-bit ADC with 16 channels.
> 
> The AD7616 can be configured to work in hardware mode by controlling it via
> gpio pins and read data via spi. No support for software mode yet, but it
> is a work in progress.
> 
> This device requires a reset in order to update oversampling, so chip info
> has got a new attribute to mark this.
> 
> The current assumption that this driver makes for AD7616, is that it's
> working in Hardware Mode with Serial, Burst and Sequencer modes activated.
> To activate them, following pins must be pulled high:
> 	-SER/PAR
> 	-SEQEN
> And following must be pulled low:
> 	-WR/BURST
> 	-DB4/SEQEN
> 
> Datasheets:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7616.pdf
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Looks good to me. One thing to look at in future is making it completely
clear what the various people in the signed-off-by list did.  It may
be that you would ideally have a co-authored-by tag in here?  The
usecases for that have only be clarified very recently so I won't
worry too much this time.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7606.c     | 46 ++++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/ad7606.h     |  9 ++++---
>  drivers/iio/adc/ad7606_spi.c |  2 ++
>  3 files changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 6b87ed410c93..24c70c3cefb4 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -39,6 +39,10 @@ static const unsigned int ad7606_oversampling_avail[7] = {
>  	1, 2, 4, 8, 16, 32, 64,
>  };
>  
> +static const unsigned int ad7616_oversampling_avail[8] = {
> +	1, 2, 4, 8, 16, 32, 64, 128,
> +};
> +
>  static int ad7606_reset(struct ad7606_state *st)
>  {
>  	if (st->gpio_reset) {
> @@ -220,6 +224,11 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  		mutex_lock(&st->lock);
>  		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
>  				      st->gpio_os->info, values);
> +
> +		/* AD7616 requires a reset to update value */
> +		if (st->chip_info->os_req_reset)
> +			ad7606_reset(st);
> +
>  		st->oversampling = st->oversampling_avail[i];
>  		mutex_unlock(&st->lock);
>  
> @@ -314,6 +323,36 @@ static const struct iio_chan_spec ad7606_channels[] = {
>  	AD7606_CHANNEL(7),
>  };
>  
> +/*
> + * The current assumption that this driver makes for AD7616, is that it's
> + * working in Hardware Mode with Serial, Burst and Sequencer modes activated.
> + * To activate them, following pins must be pulled high:
> + *	-SER/PAR
> + *	-SEQEN
> + * And following pins must be pulled low:
> + *	-WR/BURST
> + *	-DB4/SER1W
> + */
> +static const struct iio_chan_spec ad7616_channels[] = {
> +	IIO_CHAN_SOFT_TIMESTAMP(16),
> +	AD7606_CHANNEL(0),
> +	AD7606_CHANNEL(1),
> +	AD7606_CHANNEL(2),
> +	AD7606_CHANNEL(3),
> +	AD7606_CHANNEL(4),
> +	AD7606_CHANNEL(5),
> +	AD7606_CHANNEL(6),
> +	AD7606_CHANNEL(7),
> +	AD7606_CHANNEL(8),
> +	AD7606_CHANNEL(9),
> +	AD7606_CHANNEL(10),
> +	AD7606_CHANNEL(11),
> +	AD7606_CHANNEL(12),
> +	AD7606_CHANNEL(13),
> +	AD7606_CHANNEL(14),
> +	AD7606_CHANNEL(15),
> +};
> +
>  static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
>  	/* More devices added in future */
>  	[ID_AD7605_4] = {
> @@ -338,6 +377,13 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
>  		.oversampling_avail = ad7606_oversampling_avail,
>  		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
>  	},
> +	[ID_AD7616] = {
> +		.channels = ad7616_channels,
> +		.num_channels = 17,
> +		.oversampling_avail = ad7616_oversampling_avail,
> +		.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
> +		.os_req_reset = true,
> +	},
>  };
>  
>  static int ad7606_request_gpios(struct ad7606_state *st)
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 8c91bd427c4e..f9ef52131e74 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -15,12 +15,14 @@
>   * @oversampling_avail	pointer to the array which stores the available
>   *			oversampling ratios.
>   * @oversampling_num	number of elements stored in oversampling_avail array
> + * @os_req_reset	some devices require a reset to update oversampling
>   */
>  struct ad7606_chip_info {
>  	const struct iio_chan_spec	*channels;
>  	unsigned int			num_channels;
>  	const unsigned int		*oversampling_avail;
>  	unsigned int			oversampling_num;
> +	bool				os_req_reset;
>  };
>  
>  /**
> @@ -76,9 +78,9 @@ struct ad7606_state {
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> -	 * 8 * 16-bit samples + 64-bit timestamp
> +	 * 16 * 16-bit samples + 64-bit timestamp
>  	 */
> -	unsigned short			data[12] ____cacheline_aligned;
> +	unsigned short			data[20] ____cacheline_aligned;
>  };
>  
>  /**
> @@ -98,7 +100,8 @@ enum ad7606_supported_device_ids {
>  	ID_AD7605_4,
>  	ID_AD7606_8,
>  	ID_AD7606_6,
> -	ID_AD7606_4
> +	ID_AD7606_4,
> +	ID_AD7616,
>  };
>  
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index 4fd0ec36a086..b7faef69a58f 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -53,6 +53,7 @@ static const struct spi_device_id ad7606_id_table[] = {
>  	{ "ad7606-4", ID_AD7606_4 },
>  	{ "ad7606-6", ID_AD7606_6 },
>  	{ "ad7606-8", ID_AD7606_8 },
> +	{ "ad7616",   ID_AD7616 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, ad7606_id_table);
> @@ -62,6 +63,7 @@ static const struct of_device_id ad7606_of_match[] = {
>  	{ .compatible = "adi,ad7606-4" },
>  	{ .compatible = "adi,ad7606-6" },
>  	{ .compatible = "adi,ad7606-8" },
> +	{ .compatible = "adi,ad7616" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, ad7606_of_match);

