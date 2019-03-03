Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D60FC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C2320866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551617608;
	bh=CbcBv9gMyHwqcKa9aeW+eyyiTqlmKtgZl8Po0yYcTLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NpPRfeXtXdrl20HuVselxecbDG9hFYwHC7vd7Iqiiad6Uz4oPf808NV6eJ5jxJ6gC
	 Q6kRQMlJfBG4EcLb3hty3Zo+ZS91pmY7HO9IyRqqiqW9biVA9/5MQX0vMA28Gv6npn
	 Rilpr55pIaATHqV8QeRZtllCvndGbKgnVxgmAs5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCCMx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 07:53:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbfCCMxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 07:53:25 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D3720857;
        Sun,  3 Mar 2019 12:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551617604;
        bh=CbcBv9gMyHwqcKa9aeW+eyyiTqlmKtgZl8Po0yYcTLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oSiHtmspmdgOP0PAzyy1HP+tvFSKY642u1AVKxOv854C8m2eask7A77+fuqDPYtn9
         x3Ju7ZV5Hjgi1SRtQ5zesv7YCufB9izWP88AsyuuYy/96x5RembOvVKsbCex3A0xeg
         rS2Imq8IUHPa7qUCSErzVdEhxa8SJMOFA/hK/FfQ=
Date:   Sun, 3 Mar 2019 12:53:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 6/7] iio: imu: adis16480: Add support for ADIS1649x
 family of devices
Message-ID: <20190303125318.3d227260@archlinux>
In-Reply-To: <1551284068-4882-7-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
        <1551284068-4882-7-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 18:14:27 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The ADIS16495 and ADIS16497 are inertial systems that include a triaxis
> gyroscope and a triaxis accelerometer. The serial peripheral interface
> (SPI) provide a simple interface for data collection and configuration
> control. The devices are similar to ADIS16475, ADIS16480, ADIS16485 and
> ADIS16488, the main differences are highlighted below:
> 
> * The temperature data scale is 0.00565 C/LSB for ADIS16475 and ADIS1648x
>   devices, while for ADIS1649x 0.0125 C/LSB.
> 
> * ADIS1649x devices support different gyroscope measurement ranges which
>   are dependent on the dash number (-1, -2, -3), see Table 24 in the
>   ADIS16495 datasheet. However, the ADIS16497 gyroscopes have the same
>   scale as ADIS16495.
> 
> * ADIS16495 devices support the acceleration maximum range of 8g, while
>   ADIS16497 devices go up to 40g.
> 
> * The internal clock for ADIS1649x devices is 4.25 kSPS. The sampling
>   frequency is calculated by applying a decimation rate which can take a
>   maximum value of 4250.
> 
> * ADIS1649x devices support different default filter frequencies.
> 
> Datasheets:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/adis16495.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/adis16497.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied. Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 97 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index c90375d..28cece3 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -453,6 +453,13 @@ static const unsigned int adis16480_def_filter_freqs[] = {
>  	63,
>  };
>  
> +static const unsigned int adis16495_def_filter_freqs[] = {
> +	300,
> +	100,
> +	300,
> +	100,
> +};
> +
>  static const unsigned int ad16480_filter_data[][2] = {
>  	[ADIS16480_SCAN_GYRO_X]		= { ADIS16480_REG_FILTER_BNK0, 0 },
>  	[ADIS16480_SCAN_GYRO_Y]		= { ADIS16480_REG_FILTER_BNK0, 3 },
> @@ -713,6 +720,12 @@ enum adis16480_variant {
>  	ADIS16480,
>  	ADIS16485,
>  	ADIS16488,
> +	ADIS16495_1,
> +	ADIS16495_2,
> +	ADIS16495_3,
> +	ADIS16497_1,
> +	ADIS16497_2,
> +	ADIS16497_3,
>  };
>  
>  static const struct adis16480_chip_info adis16480_chip_info[] = {
> @@ -769,6 +782,78 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.max_dec_rate = 2048,
>  		.filter_freqs = adis16480_def_filter_freqs,
>  	},
> +	[ADIS16495_1] = {
> +		.channels = adis16485_channels,
> +		.num_channels = ARRAY_SIZE(adis16485_channels),
> +		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
> +		.gyro_max_scale = 125,
> +		.accel_max_val = IIO_M_S_2_TO_G(32000),
> +		.accel_max_scale = 8,
> +		.temp_scale = 12500, /* 12.5 milli degree Celsius */
> +		.int_clk = 4250000,
> +		.max_dec_rate = 4250,
> +		.filter_freqs = adis16495_def_filter_freqs,
> +	},
> +	[ADIS16495_2] = {
> +		.channels = adis16485_channels,
> +		.num_channels = ARRAY_SIZE(adis16485_channels),
> +		.gyro_max_val = IIO_RAD_TO_DEGREE(18000),
> +		.gyro_max_scale = 450,
> +		.accel_max_val = IIO_M_S_2_TO_G(32000),
> +		.accel_max_scale = 8,
> +		.temp_scale = 12500, /* 12.5 milli degree Celsius */
> +		.int_clk = 4250000,
> +		.max_dec_rate = 4250,
> +		.filter_freqs = adis16495_def_filter_freqs,
> +	},
> +	[ADIS16495_3] = {
> +		.channels = adis16485_channels,
> +		.num_channels = ARRAY_SIZE(adis16485_channels),
> +		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
> +		.gyro_max_scale = 2000,
> +		.accel_max_val = IIO_M_S_2_TO_G(32000),
> +		.accel_max_scale = 8,
> +		.temp_scale = 12500, /* 12.5 milli degree Celsius */
> +		.int_clk = 4250000,
> +		.max_dec_rate = 4250,
> +		.filter_freqs = adis16495_def_filter_freqs,
> +	},
> +	[ADIS16497_1] = {
> +		.channels = adis16485_channels,
> +		.num_channels = ARRAY_SIZE(adis16485_channels),
> +		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
> +		.gyro_max_scale = 125,
> +		.accel_max_val = IIO_M_S_2_TO_G(32000),
> +		.accel_max_scale = 40,
> +		.temp_scale = 12500, /* 12.5 milli degree Celsius */
> +		.int_clk = 4250000,
> +		.max_dec_rate = 4250,
> +		.filter_freqs = adis16495_def_filter_freqs,
> +	},
> +	[ADIS16497_2] = {
> +		.channels = adis16485_channels,
> +		.num_channels = ARRAY_SIZE(adis16485_channels),
> +		.gyro_max_val = IIO_RAD_TO_DEGREE(18000),
> +		.gyro_max_scale = 450,
> +		.accel_max_val = IIO_M_S_2_TO_G(32000),
> +		.accel_max_scale = 40,
> +		.temp_scale = 12500, /* 12.5 milli degree Celsius */
> +		.int_clk = 4250000,
> +		.max_dec_rate = 4250,
> +		.filter_freqs = adis16495_def_filter_freqs,
> +	},
> +	[ADIS16497_3] = {
> +		.channels = adis16485_channels,
> +		.num_channels = ARRAY_SIZE(adis16485_channels),
> +		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
> +		.gyro_max_scale = 2000,
> +		.accel_max_val = IIO_M_S_2_TO_G(32000),
> +		.accel_max_scale = 40,
> +		.temp_scale = 12500, /* 12.5 milli degree Celsius */
> +		.int_clk = 4250000,
> +		.max_dec_rate = 4250,
> +		.filter_freqs = adis16495_def_filter_freqs,
> +	},
>  };
>  
>  static const struct iio_info adis16480_info = {
> @@ -1014,6 +1099,12 @@ static const struct spi_device_id adis16480_ids[] = {
>  	{ "adis16480", ADIS16480 },
>  	{ "adis16485", ADIS16485 },
>  	{ "adis16488", ADIS16488 },
> +	{ "adis16495-1", ADIS16495_1 },
> +	{ "adis16495-2", ADIS16495_2 },
> +	{ "adis16495-3", ADIS16495_3 },
> +	{ "adis16497-1", ADIS16497_1 },
> +	{ "adis16497-2", ADIS16497_2 },
> +	{ "adis16497-3", ADIS16497_3 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adis16480_ids);
> @@ -1023,6 +1114,12 @@ static const struct of_device_id adis16480_of_match[] = {
>  	{ .compatible = "adi,adis16480" },
>  	{ .compatible = "adi,adis16485" },
>  	{ .compatible = "adi,adis16488" },
> +	{ .compatible = "adi,adis16495-1" },
> +	{ .compatible = "adi,adis16495-2" },
> +	{ .compatible = "adi,adis16495-3" },
> +	{ .compatible = "adi,adis16497-1" },
> +	{ .compatible = "adi,adis16497-2" },
> +	{ .compatible = "adi,adis16497-3" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, adis16480_of_match);

