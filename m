Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB59EC4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9876720866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551617472;
	bh=gF81hsfkbUWmkTb4lwetaCe4FI4errIsYOlUYYwsO/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NAsJjlUo2XlD+bh8XqXh3G/n2562qki+/VtkfBGoC2yS586jiTxzlfWKMiqyOt8G3
	 tIg+cHWFnL4LVc2BkU3egDYhoKolWIBRiHvcJS4qhIVR477irQLeGmHPk49GnBrpM1
	 EjOwG3nAN8frWa0X2FAIGxENICdLWdz9l9TwnS8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfCCMvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 07:51:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfCCMvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 07:51:10 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23B1420857;
        Sun,  3 Mar 2019 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551617469;
        bh=gF81hsfkbUWmkTb4lwetaCe4FI4errIsYOlUYYwsO/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ThAkEMSdLu16IwuxNThuMb1olxbqHgh72ZIhDOISHCHZHpC5OWXb0rdbLjossEDiH
         ZYi5j/VJK8fPsG3zbI4tZBHT9ISw4Rs8ia5CWoCsC3vqEb80O7dnlOCZLTR3SrHBwZ
         /biYCZMYxMLnETNJgRGPQfky3SCvZma4sReAQbR4=
Date:   Sun, 3 Mar 2019 12:51:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] iio: imu: adis16480: Calculate the sampling
 frequency in a generic way
Message-ID: <20190303125103.5d9b5e5a@archlinux>
In-Reply-To: <1551284068-4882-5-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
        <1551284068-4882-5-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 18:14:25 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The adis1648x devices have an internal clock of 2.46 kSPS. The sampling
> frequency is calculated by applying a decimation rate which can take the
> maximum value of 2047.
> 
> Although all adis1648x devices are similar in this regard, devices that
> will use this feature will be added in the future.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Straight forward refactor so fine.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

A comment inline about something in the old code!

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 5a2864a..92abc95 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -125,6 +125,8 @@ struct adis16480_chip_info {
>  	unsigned int accel_max_val;
>  	unsigned int accel_max_scale;
>  	unsigned int temp_scale;
> +	unsigned int int_clk;
> +	unsigned int max_dec_rate;
>  };
>  
>  enum adis16480_int_pin {
> @@ -299,9 +301,9 @@ static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
>  	if (t <= 0)
>  		return -EINVAL;
>  
> -	t = 2460000 / t;
> -	if (t > 2048)
> -		t = 2048;
> +	t = st->chip_info->int_clk / t;
> +	if (t > st->chip_info->max_dec_rate)
> +		t = st->chip_info->max_dec_rate;
>  
>  	if (t != 0)
>  		t--;
> @@ -320,7 +322,7 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
>  	if (ret < 0)
>  		return ret;
>  
> -	freq = 2460000 / (t + 1);
> +	freq = st->chip_info->int_clk / (t + 1);

I'm a little curious about why t + 1?  Presumably to avoid weird rounding
issues, but maybe a nice addition would be a comment explaining this.

>  	*val = freq / 1000;
>  	*val2 = (freq % 1000) * 1000;
>  
> @@ -726,6 +728,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.accel_max_val = IIO_M_S_2_TO_G(21973),
>  		.accel_max_scale = 18,
>  		.temp_scale = 5650, /* 5.65 milli degree Celsius */
> +		.int_clk = 2460000,
> +		.max_dec_rate = 2048,
>  	},
>  	[ADIS16480] = {
>  		.channels = adis16480_channels,
> @@ -735,6 +739,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.accel_max_val = IIO_M_S_2_TO_G(12500),
>  		.accel_max_scale = 10,
>  		.temp_scale = 5650, /* 5.65 milli degree Celsius */
> +		.int_clk = 2460000,
> +		.max_dec_rate = 2048,
>  	},
>  	[ADIS16485] = {
>  		.channels = adis16485_channels,
> @@ -744,6 +750,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.accel_max_val = IIO_M_S_2_TO_G(20000),
>  		.accel_max_scale = 5,
>  		.temp_scale = 5650, /* 5.65 milli degree Celsius */
> +		.int_clk = 2460000,
> +		.max_dec_rate = 2048,
>  	},
>  	[ADIS16488] = {
>  		.channels = adis16480_channels,
> @@ -753,6 +761,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.accel_max_val = IIO_M_S_2_TO_G(22500),
>  		.accel_max_scale = 18,
>  		.temp_scale = 5650, /* 5.65 milli degree Celsius */
> +		.int_clk = 2460000,
> +		.max_dec_rate = 2048,
>  	},
>  };
>  

