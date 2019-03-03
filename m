Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62C2C4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44B420866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551617272;
	bh=E2HkPwXGrgM27CZAke25vLwGR+iBhhZBrDe/33OOzzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=r/RIjetTX4SYv3hANaaSc+Z7iJKAnNp0SHa3RHx9bemWmsnwnZ00hUm5vH7ArGS5K
	 rwOnrWtDj2CVwV4GasBInNUzk6lRcOs9/HUcVQCGmwl//+iaKttmtT1xFX3lp3jR0x
	 vp9zoK64gpyDrF0vLtB6Ozohak8OO8B5Is8xffkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfCCMrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 07:47:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfCCMrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 07:47:51 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D01620857;
        Sun,  3 Mar 2019 12:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551617269;
        bh=E2HkPwXGrgM27CZAke25vLwGR+iBhhZBrDe/33OOzzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uwvn/SCAhbOo8WOvh6ENLz+PpMvsyd0MG60te1jem+LHw+W4obov/jYWuFdCfC8B2
         xPszf8/PLNO5tVY68ujosrywTgCJvp1Q/N8AfLKuPOTb6N0QUx0dzHflNu0frgXgUb
         Uiw5fxjy3X4BLQNOnsP0oEy0osvcAgorFYhAYACQ=
Date:   Sun, 3 Mar 2019 12:47:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] iio: imu: adis16480: Treat temperature scale in
 a generic way
Message-ID: <20190303124744.3bd0ac0a@archlinux>
In-Reply-To: <1551284068-4882-4-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
        <1551284068-4882-4-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 18:14:24 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> All supported devices provide internal temperature measurement from -40 C
> to +85 C, with +25 C representing value 0x00.
> 
> This patch treats the temperature scale in a generic way, similar to the
> accelerometer and gyroscope scales. So far, there are no temperature max
> scale differences between the supported devices. However, devices that
> will make use of this feature will be added in the future.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied.  Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 150d814..5a2864a 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -124,6 +124,7 @@ struct adis16480_chip_info {
>  	unsigned int gyro_max_scale;
>  	unsigned int accel_max_val;
>  	unsigned int accel_max_scale;
> +	unsigned int temp_scale;
>  };
>  
>  enum adis16480_int_pin {
> @@ -530,6 +531,7 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
>  	const struct iio_chan_spec *chan, int *val, int *val2, long info)
>  {
>  	struct adis16480 *st = iio_priv(indio_dev);
> +	unsigned int temp;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -549,8 +551,13 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
>  			*val2 = 100; /* 0.0001 gauss */
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
> -			*val = 5;
> -			*val2 = 650000; /* 5.65 milli degree Celsius */
> +			/*
> +			 * +85 degrees Celsius = temp_max_scale
> +			 * +25 degrees Celsius = 0
> +			 * LSB, 25 degrees Celsius  = 60 / temp_max_scale
> +			 */
> +			*val = st->chip_info->temp_scale / 1000;
> +			*val2 = (st->chip_info->temp_scale % 1000) * 1000;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_PRESSURE:
>  			*val = 0;
> @@ -561,7 +568,8 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
>  		}
>  	case IIO_CHAN_INFO_OFFSET:
>  		/* Only the temperature channel has a offset */
> -		*val = 4425; /* 25 degree Celsius = 0x0000 */
> +		temp = 25 * 1000000LL; /* 25 degree Celsius = 0x0000 */
> +		*val = DIV_ROUND_CLOSEST_ULL(temp, st->chip_info->temp_scale);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		return adis16480_get_calibbias(indio_dev, chan, val);
> @@ -717,6 +725,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.gyro_max_scale = 300,
>  		.accel_max_val = IIO_M_S_2_TO_G(21973),
>  		.accel_max_scale = 18,
> +		.temp_scale = 5650, /* 5.65 milli degree Celsius */
>  	},
>  	[ADIS16480] = {
>  		.channels = adis16480_channels,
> @@ -725,6 +734,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.gyro_max_scale = 450,
>  		.accel_max_val = IIO_M_S_2_TO_G(12500),
>  		.accel_max_scale = 10,
> +		.temp_scale = 5650, /* 5.65 milli degree Celsius */
>  	},
>  	[ADIS16485] = {
>  		.channels = adis16485_channels,
> @@ -733,6 +743,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.gyro_max_scale = 450,
>  		.accel_max_val = IIO_M_S_2_TO_G(20000),
>  		.accel_max_scale = 5,
> +		.temp_scale = 5650, /* 5.65 milli degree Celsius */
>  	},
>  	[ADIS16488] = {
>  		.channels = adis16480_channels,
> @@ -741,6 +752,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.gyro_max_scale = 450,
>  		.accel_max_val = IIO_M_S_2_TO_G(22500),
>  		.accel_max_scale = 18,
> +		.temp_scale = 5650, /* 5.65 milli degree Celsius */
>  	},
>  };
>  

