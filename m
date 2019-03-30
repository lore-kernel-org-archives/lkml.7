Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B94C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18430218D8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553970572;
	bh=Hf07yBfKV+VMAzF72oJijpYa3GZZ9YA60WKOdiJ2cdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ro46qaV0jEYxvCVnVYHbFZzvtWDsPJgPU3CKnRmWNxZRgU4q9Jz5dZP/dt7IjCA6Q
	 oVphdg8mtZr9bEjHI3KmvBxERcrncvnWhVLzvVfnmbcY4If5lV1SqkvhxYy1mcKnlW
	 wz4U0ozNnas8QGyEXAU8BplUgaXZ0r2P5bQqPRvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbfC3S3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730203AbfC3S3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:29:31 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A50222082C;
        Sat, 30 Mar 2019 18:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553970569;
        bh=Hf07yBfKV+VMAzF72oJijpYa3GZZ9YA60WKOdiJ2cdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p/V0y1zOwnyq6vfmiNL6M5PGczu53Rg2KQgGKUHst9gvWHMEtvM/Kw+kNAU/t8oFh
         ti5SLCZp2ZjueAb3lEow6N4JM4VOvv7HF52qqxCa5Ep00nu9lVyZZB9L16YWHPmR/D
         hodx9vmK3KgMM88gWc8pPbM3FNx05GC32HKybngI=
Date:   Sat, 30 Mar 2019 18:29:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     stevemo@skydio.com
Cc:     gaireg@gaireg.de, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh@kernel.org>,
        Douglas Fischer <fischerdouglasc@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randolph =?UTF-8?B?TWFhw59lbg==?= <gaireg@gaireg.de>
Subject: Re: [PATCH] iio: imu: mpu6050: Fix FIFO layout for ICM20602
Message-ID: <20190330182923.549949d5@archlinux>
In-Reply-To: <20190326090238.23651-1-stevemo@skydio.com>
References: <20190326090238.23651-1-stevemo@skydio.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 02:01:45 -0700
stevemo@skydio.com wrote:
+CC Randolph, who I think introduced the support.

> From: Steve Moskovchenko <stevemo@skydio.com>
> 
> The MPU6050 driver has recently gained support for the
> ICM20602 IMU, which is very similar to MPU6xxx. However,
> the ICM20602's Gyro data specifically includes temperature
> readings, which were not present on MPU6xxx parts. As a
> result, the driver will under-read the ICM20602's FIFO
> register, causing the same (partial) sample to be returned
> for all reads, until the FIFO overflows.
> 
> Fix this by adding a table of scan elements speciically for
> the ICM20602, which takes the extra temperature data into
> consideration.
> 
> While we're at it, fix the temperature offset and scaling
> on ICM20602, since it uses different scale/offset constants
> than the rest of the MPU6xxx devices.
> 
> Signed-off-by: Steve Moskovchenko <stevemo@skydio.com>
Hi Steve

This all looks sensible to me.  Ideally should have had a fixes tag.

If no one shouts in the next few days I'll pick this up and add one.
Give me a poke if I seem to have forgotten it in a week or so.

Thanks,

Jonathan


> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 46 ++++++++++++++++++++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 20 +++++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c |  8 +++-
>  3 files changed, 67 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 650de0fefb7b..fedd3f2b0135 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -471,7 +471,10 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
>  			*val = 0;
> -			*val2 = INV_MPU6050_TEMP_SCALE;
> +			if (st->chip_type == INV_ICM20602)
> +				*val2 = INV_ICM20602_TEMP_SCALE;
> +			else
> +				*val2 = INV_MPU6050_TEMP_SCALE;
>  
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
> @@ -480,7 +483,10 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OFFSET:
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -			*val = INV_MPU6050_TEMP_OFFSET;
> +			if (st->chip_type == INV_ICM20602)
> +				*val = INV_ICM20602_TEMP_OFFSET;
> +			else
> +				*val = INV_MPU6050_TEMP_OFFSET;
>  
>  			return IIO_VAL_INT;
>  		default:
> @@ -845,6 +851,32 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
>  	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
>  };
>  
> +static const struct iio_chan_spec inv_icm20602_channels[] = {
> +	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP),
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> +				| BIT(IIO_CHAN_INFO_OFFSET)
> +				| BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = INV_ICM20602_SCAN_GYRO_TEMP,
> +		.scan_type = {
> +				.sign = 's',
> +				.realbits = 16,
> +				.storagebits = 16,
> +				.shift = 0,
> +				.endianness = IIO_BE,
> +			     },
> +	},
> +
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_ICM20602_SCAN_GYRO_X),
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_ICM20602_SCAN_GYRO_Y),
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_ICM20602_SCAN_GYRO_Z),
> +
> +	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_ICM20602_SCAN_ACCL_Y),
> +	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_ICM20602_SCAN_ACCL_X),
> +	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_ICM20602_SCAN_ACCL_Z),
> +};
> +
>  /*
>   * The user can choose any frequency between INV_MPU6050_MIN_FIFO_RATE and
>   * INV_MPU6050_MAX_FIFO_RATE, but only these frequencies are matched by the
> @@ -1100,8 +1132,14 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		indio_dev->name = name;
>  	else
>  		indio_dev->name = dev_name(dev);
> -	indio_dev->channels = inv_mpu_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
> +
> +	if (chip_type == INV_ICM20602) {
> +		indio_dev->channels = inv_icm20602_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(inv_icm20602_channels);
> +	} else {
> +		indio_dev->channels = inv_mpu_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
> +	}
>  
>  	indio_dev->info = &mpu_info;
>  	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 325afd9f5f61..eb04391feaa8 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -208,6 +208,9 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_BYTES_PER_3AXIS_SENSOR   6
>  #define INV_MPU6050_FIFO_COUNT_BYTE          2
>  
> +/* ICM20602 gyro data includes temperature */
> +#define INV_ICM20602_BYTES_PER_GYRO_SENSOR   8
> +
>  /* mpu6500 registers */
>  #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
>  #define INV_MPU6500_REG_ACCEL_OFFSET        0x77
> @@ -229,6 +232,9 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_GYRO_CONFIG_FSR_SHIFT    3
>  #define INV_MPU6050_ACCL_CONFIG_FSR_SHIFT    3
>  
> +#define INV_ICM20602_TEMP_OFFSET	     8170
> +#define INV_ICM20602_TEMP_SCALE		     3060
> +
>  /* 6 + 6 round up and plus 8 */
>  #define INV_MPU6050_OUTPUT_DATA_SIZE         24
>  
> @@ -270,7 +276,7 @@ struct inv_mpu6050_state {
>  #define INV_ICM20608_WHOAMI_VALUE		0xAF
>  #define INV_ICM20602_WHOAMI_VALUE		0x12
>  
> -/* scan element definition */
> +/* scan element definition for generic MPU6xxx devices */
>  enum inv_mpu6050_scan {
>  	INV_MPU6050_SCAN_ACCL_X,
>  	INV_MPU6050_SCAN_ACCL_Y,
> @@ -281,6 +287,18 @@ enum inv_mpu6050_scan {
>  	INV_MPU6050_SCAN_TIMESTAMP,
>  };
>  
> +/* scan element definition for ICM20602, which includes gyro temp */
> +enum inv_icm20602_scan {
> +	INV_ICM20602_SCAN_ACCL_X,
> +	INV_ICM20602_SCAN_ACCL_Y,
> +	INV_ICM20602_SCAN_ACCL_Z,
> +	INV_ICM20602_SCAN_GYRO_TEMP,
> +	INV_ICM20602_SCAN_GYRO_X,
> +	INV_ICM20602_SCAN_GYRO_Y,
> +	INV_ICM20602_SCAN_GYRO_Z,
> +	INV_ICM20602_SCAN_TIMESTAMP,
> +};
> +
>  enum inv_mpu6050_filter_e {
>  	INV_MPU6050_FILTER_256HZ_NOLPF2 = 0,
>  	INV_MPU6050_FILTER_188HZ,
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 548e042f7b5b..20828d6a13f9 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -204,8 +204,12 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	if (st->chip_config.accl_fifo_enable)
>  		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
>  
> -	if (st->chip_config.gyro_fifo_enable)
> -		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
> +	if (st->chip_config.gyro_fifo_enable) {
> +		if (st->chip_type == INV_ICM20602)
> +			bytes_per_datum += INV_ICM20602_BYTES_PER_GYRO_SENSOR;
> +		else
> +			bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
> +	}
>  
>  	/*
>  	 * read fifo_count register to know how many bytes are inside the FIFO

