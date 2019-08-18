Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB08C3A59F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E6621851
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566153649;
	bh=xbKF9nBPTFlOUppqVQ15SfctyUzM/6FbCjJp8GNqP88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=drY4vZ/5rLl5cqrric2VEOp3kimIFkjJA4rzWIrMbRo+3LRZ1HekaPg9QLDfZ3ang
	 qIdB7dGqy1CvhP+6SxLN/AJQ89CVSV3ZYHQpaGONs7UzdPlDwvn7G3UxLGAX62U3jl
	 bL0rAEo7QuGQo9Iyj/CQPIYwgVW5PY7a4p2jHsKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfHRSks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 14:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfHRSks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 14:40:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2521820B7C;
        Sun, 18 Aug 2019 18:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566153647;
        bh=xbKF9nBPTFlOUppqVQ15SfctyUzM/6FbCjJp8GNqP88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=17ysbt1Dw9AT6Oetc8OwNZg1hrRKA7iM3Q77HVTxCjdrBxd1OJwxIlDuYFiwGm0Jv
         P5ejNdCz422xRe/tpmoHTB0jdUP4TdhXapVd0/JCz9suOkYOMFmOWr73iXwwWk0XLm
         V49td6Run7Iehm3PYZU6HTHT05Ahf/afnMFb6GNk=
Date:   Sun, 18 Aug 2019 19:35:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH V3 2/4] iio: adc: ad_sigma_delta: Export ad_sd_calibrate
Message-ID: <20190818193533.172fd2ef@archlinux>
In-Reply-To: <20190814073150.4602-2-mircea.caprioru@analog.com>
References: <20190814073150.4602-1-mircea.caprioru@analog.com>
        <20190814073150.4602-2-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 10:31:48 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch exports the ad_sd_calibrate function in order to be able to
> call it from outside ad_sigma_delta.
> 
> There are cases where the option to calibrate one channel at a time is
> necessary (ex. system calibration for zero scale and full scale).
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Applied,

Thanks,

Jonathan

> ---
> Changelog V2:
> - no changes here
> 
> Changelog V3:
> - no changes here
> 
>  drivers/iio/adc/ad_sigma_delta.c       | 3 ++-
>  include/linux/iio/adc/ad_sigma_delta.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 2640b75fb774..8ba90486c787 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -205,7 +205,7 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
>  }
>  EXPORT_SYMBOL_GPL(ad_sd_reset);
>  
> -static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
> +int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
>  	unsigned int mode, unsigned int channel)
>  {
>  	int ret;
> @@ -242,6 +242,7 @@ static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(ad_sd_calibrate);
>  
>  /**
>   * ad_sd_calibrate_all() - Performs channel calibration
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 7716fa0c9fce..8a4e25a7080c 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -119,6 +119,8 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
>  
>  int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  	const struct iio_chan_spec *chan, int *val);
> +int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
> +	unsigned int mode, unsigned int channel);
>  int ad_sd_calibrate_all(struct ad_sigma_delta *sigma_delta,
>  	const struct ad_sd_calib_data *cd, unsigned int n);
>  int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,

