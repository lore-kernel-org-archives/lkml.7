Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60778ECE58D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2542F217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570357507;
	bh=5dXkGeS1kig5Ue4UK4C2E982asXKRCyRBugVRiHaaDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2GPLQ0GnEYw3TDgEgg/IZnZqEnjyxC8yvyP5K6kLNJnUIPn5j/LCT2MmctQXO6WKp
	 5GAiqdiTdrJBTuzYBvDprnXsOPUXQPh2jzEfBlRwg1RagWYE29vQ+rp+Hyxzd4jY2o
	 KcWgAJHd/tfXTJLCTXMN88n8KIKsSlcQ1HA3MSD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfJFKZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfJFKZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:25:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AB442084B;
        Sun,  6 Oct 2019 10:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570357504;
        bh=5dXkGeS1kig5Ue4UK4C2E982asXKRCyRBugVRiHaaDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YQrQ9Pq366epJ2H0Qv/ezLYUsEjVufKcdCxxAgGUWv1gJBD64u6QC9DUBy1DFsHIH
         0jDTpGOpdYjrf2SyS33JHraxQ1bO03wL/pb1noYe+n19n3oy57CaJWyaXpXpOZEpWS
         xmuYuFWXUXS4qm/xoXZtIaY/7r9LTfIunRtOQVYs=
Date:   Sun, 6 Oct 2019 11:24:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 5/7] iio: adc: max1027: Introduce 12-bit devices
 support
Message-ID: <20191006112459.55e8957a@archlinux>
In-Reply-To: <20191003173401.16343-6-miquel.raynal@bootlin.com>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
        <20191003173401.16343-6-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Oct 2019 19:33:59 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Maxim's max12xx series is very similar to the max10xx series, with the
> difference of the measurements depth which is upgraded from 10 to 12
> bits per channel. Everything else looks the same.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Looks good.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig   |  4 ++--
>  drivers/iio/adc/max1027.c | 44 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f0af3a42f53c..6ac16d738822 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -508,8 +508,8 @@ config MAX1027
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  Say yes here to build support for Maxim SPI ADC models
> -	  max1027, max1029 and max1031.
> +	  Say yes here to build support for Maxim SPI {10,12}-bit ADC models:
> +	  max1027, max1029, max1031, max1227, max1229 and max1231.
>  
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called max1027.
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 5d5d223dd42a..0d7116e9a63b 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -63,12 +63,18 @@ enum max1027_id {
>  	max1027,
>  	max1029,
>  	max1031,
> +	max1227,
> +	max1229,
> +	max1231,
>  };
>  
>  static const struct spi_device_id max1027_id[] = {
>  	{"max1027", max1027},
>  	{"max1029", max1029},
>  	{"max1031", max1031},
> +	{"max1227", max1227},
> +	{"max1229", max1229},
> +	{"max1231", max1231},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, max1027_id);
> @@ -78,6 +84,9 @@ static const struct of_device_id max1027_adc_dt_ids[] = {
>  	{ .compatible = "maxim,max1027" },
>  	{ .compatible = "maxim,max1029" },
>  	{ .compatible = "maxim,max1031" },
> +	{ .compatible = "maxim,max1227" },
> +	{ .compatible = "maxim,max1229" },
> +	{ .compatible = "maxim,max1231" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
> @@ -153,6 +162,21 @@ static const struct iio_chan_spec max1031_channels[] = {
>  	MAX1X31_CHANNELS(10)
>  };
>  
> +static const struct iio_chan_spec max1227_channels[] = {
> +	MAX1X27_CHANNELS(12)
> +};
> +
> +static const struct iio_chan_spec max1229_channels[] = {
> +	MAX1X27_CHANNELS(12),
> +	MAX1X29_CHANNELS(12)
> +};
> +
> +static const struct iio_chan_spec max1231_channels[] = {
> +	MAX1X27_CHANNELS(12),
> +	MAX1X29_CHANNELS(12),
> +	MAX1X31_CHANNELS(12)
> +};
> +
>  static const unsigned long max1027_available_scan_masks[] = {
>  	0x000001ff,
>  	0x00000000,
> @@ -194,6 +218,24 @@ static const struct max1027_chip_info max1027_chip_info_tbl[] = {
>  		.depth = 10,
>  		.available_scan_masks = max1031_available_scan_masks,
>  	},
> +	[max1227] = {
> +		.channels = max1227_channels,
> +		.num_channels = ARRAY_SIZE(max1227_channels),
> +		.depth = 12,
> +		.available_scan_masks = max1027_available_scan_masks,
> +	},
> +	[max1229] = {
> +		.channels = max1229_channels,
> +		.num_channels = ARRAY_SIZE(max1229_channels),
> +		.depth = 12,
> +		.available_scan_masks = max1029_available_scan_masks,
> +	},
> +	[max1231] = {
> +		.channels = max1231_channels,
> +		.num_channels = ARRAY_SIZE(max1231_channels),
> +		.depth = 12,
> +		.available_scan_masks = max1031_available_scan_masks,
> +	},
>  };
>  
>  struct max1027_state {
> @@ -490,5 +532,5 @@ static struct spi_driver max1027_driver = {
>  module_spi_driver(max1027_driver);
>  
>  MODULE_AUTHOR("Philippe Reynes <tremyfr@yahoo.fr>");
> -MODULE_DESCRIPTION("MAX1027/MAX1029/MAX1031 ADC");
> +MODULE_DESCRIPTION("MAX1X27/MAX1X29/MAX1X31 ADC");
>  MODULE_LICENSE("GPL v2");

