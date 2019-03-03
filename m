Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF7EC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FCB20866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551617535;
	bh=v6ufvXDUl3z9Um3SZ8bGyC9kYeh91wdZkVW7ebmJxJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kQKfvfUgSTrvs2PjAgFEQB+m3bhf4f7ayXn4nPnFX4XB1LmGKgIkAHQv5KQEjGyQJ
	 XzyimKnYtvtWqNYMB/xnmO2OqxIPqEQKa1iN7OuDAGo777qbHednOWD+0a/sCcLKmN
	 FkuGWnMdE5dJ6eePLQaWURpjfYZakUGx10o4RrRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfCCMwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 07:52:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfCCMwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 07:52:13 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52D1520857;
        Sun,  3 Mar 2019 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551617532;
        bh=v6ufvXDUl3z9Um3SZ8bGyC9kYeh91wdZkVW7ebmJxJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ad2Go2AZDswS9tGc1h5Remx9fMjhNVbuZhcoWO7huXYe98JjxTpNQ5rEvpq1ksdDC
         Tl4xiiMW4DSD0pqggmq+VdXc+rH7/gNSUyLfW+EokM0pX9VE37dEiZ4rCYe8DrhA2i
         7f17tSib4BkcZdnnnR1iC641VYq9p8NW23OFucgI=
Date:   Sun, 3 Mar 2019 12:52:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] iio: imu: adis16480: Deal with filter freq in a
 generic way
Message-ID: <20190303125205.6ac90646@archlinux>
In-Reply-To: <1551284068-4882-6-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
        <1551284068-4882-6-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 18:14:26 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> When setting the filter frequency, the driver looks into the
> adis16480_def_filter_freqs table for the best match. Pass this table to
> the chip_info struct since future devices will need to use a different
> table.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 92abc95..c90375d 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -127,6 +127,7 @@ struct adis16480_chip_info {
>  	unsigned int temp_scale;
>  	unsigned int int_clk;
>  	unsigned int max_dec_rate;
> +	const unsigned int *filter_freqs;
>  };
>  
>  enum adis16480_int_pin {
> @@ -483,7 +484,7 @@ static int adis16480_get_filter_freq(struct iio_dev *indio_dev,
>  	if (!(val & enable_mask))
>  		*freq = 0;
>  	else
> -		*freq = adis16480_def_filter_freqs[(val >> offset) & 0x3];
> +		*freq = st->chip_info->filter_freqs[(val >> offset) & 0x3];
>  
>  	return IIO_VAL_INT;
>  }
> @@ -510,10 +511,10 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
>  		val &= ~enable_mask;
>  	} else {
>  		best_freq = 0;
> -		best_diff = 310;
> +		best_diff = st->chip_info->filter_freqs[0];
>  		for (i = 0; i < ARRAY_SIZE(adis16480_def_filter_freqs); i++) {
> -			if (adis16480_def_filter_freqs[i] >= freq) {
> -				diff = adis16480_def_filter_freqs[i] - freq;
> +			if (st->chip_info->filter_freqs[i] >= freq) {
> +				diff = st->chip_info->filter_freqs[i] - freq;
>  				if (diff < best_diff) {
>  					best_diff = diff;
>  					best_freq = i;
> @@ -730,6 +731,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.temp_scale = 5650, /* 5.65 milli degree Celsius */
>  		.int_clk = 2460000,
>  		.max_dec_rate = 2048,
> +		.filter_freqs = adis16480_def_filter_freqs,
>  	},
>  	[ADIS16480] = {
>  		.channels = adis16480_channels,
> @@ -741,6 +743,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.temp_scale = 5650, /* 5.65 milli degree Celsius */
>  		.int_clk = 2460000,
>  		.max_dec_rate = 2048,
> +		.filter_freqs = adis16480_def_filter_freqs,
>  	},
>  	[ADIS16485] = {
>  		.channels = adis16485_channels,
> @@ -752,6 +755,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.temp_scale = 5650, /* 5.65 milli degree Celsius */
>  		.int_clk = 2460000,
>  		.max_dec_rate = 2048,
> +		.filter_freqs = adis16480_def_filter_freqs,
>  	},
>  	[ADIS16488] = {
>  		.channels = adis16480_channels,
> @@ -763,6 +767,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.temp_scale = 5650, /* 5.65 milli degree Celsius */
>  		.int_clk = 2460000,
>  		.max_dec_rate = 2048,
> +		.filter_freqs = adis16480_def_filter_freqs,
>  	},
>  };
>  

