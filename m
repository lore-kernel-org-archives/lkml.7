Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9CAC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD07D218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552754726;
	bh=m92Zy73jzDgaKdtgMUBcgb1kVDQabnZLHPfcdxWmulc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=onsn9KZqdCzmTg4YMtOk7ofSJURMxGbUajHR/3y6XxqUpFBMKEqPsqugB8VOcj3+x
	 zDLNWxKhoOO0FPqmbz52I01Z6fPrihW5WkPE5s5q7KgQQ6JJx7lvFFSZ2T51LYey4n
	 AIHZLbVXso2GGPOqReUihN44SM3+7TIuwHw5a2gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfCPQpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPQpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:45:25 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 036282186A;
        Sat, 16 Mar 2019 16:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552754724;
        bh=m92Zy73jzDgaKdtgMUBcgb1kVDQabnZLHPfcdxWmulc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iGqJTDrt4QcyaW0m4zISyvem6a7VnhUloaa5k1GuSBnpEDK9irLveLbUuAPbJO22n
         1ITkV7p/aDGw/p/3OyEpHmuNnkoC00PTtA9nxObGS05GYuDrqNt6lAy7Dy/90HfGfG
         dkCkmH0jJeGY7tVI+wNSlas4rQJ9KFM+dqTBuESk=
Date:   Sat, 16 Mar 2019 16:45:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] staging: iio: adc: ad7192: Report error directly in
 ad7192_setup
Message-ID: <20190316164519.5faf1238@archlinux>
In-Reply-To: <20190315111425.14275-2-mircea.caprioru@analog.com>
References: <20190315111425.14275-1-mircea.caprioru@analog.com>
        <20190315111425.14275-2-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 13:14:25 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch removes the goto out statement thus ensuring that an error is
> report as soon as it occurs. This gives more information and improves
> readability.
No problem with the patch, but I'm not sure why it gives more information?
Gone from printing an useless error message to printing none.

I'll just drop that bit of the description in favour of code readability.
Hope you don't mind!

Jonathan
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
>  drivers/staging/iio/adc/ad7192.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index ebab75bdeed7..27f962b8c4ef 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -236,13 +236,13 @@ static int ad7192_setup(struct ad7192_state *st,
>  	/* reset the serial interface */
>  	ret = ad_sd_reset(&st->sd, 48);
>  	if (ret < 0)
> -		goto out;
> +		return ret;
>  	usleep_range(500, 1000); /* Wait for at least 500us */
>  
>  	/* write/read test for device presence */
>  	ret = ad_sd_read_reg(&st->sd, AD7192_REG_ID, 1, &id);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	id &= AD7192_ID_MASK;
>  
> @@ -310,15 +310,15 @@ static int ad7192_setup(struct ad7192_state *st,
>  
>  	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	ret = ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	ret = ad7192_calibrate_all(st);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	/* Populate available ADC input ranges */
>  	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
> @@ -332,9 +332,6 @@ static int ad7192_setup(struct ad7192_state *st,
>  	}
>  
>  	return 0;
> -out:
> -	dev_err(&st->sd.spi->dev, "setup failed\n");
> -	return ret;
>  }
>  
>  static ssize_t

