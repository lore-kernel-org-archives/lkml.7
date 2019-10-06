Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F63ECE58D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE802133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570353588;
	bh=RaGNb1u3bc63/uCEtd4tmegwYacTtQnWlLgt8LRv7UI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XNZ9a/daAsOhVDI2Xqwngrbt9FHyZ69t68H6GBBjEsxpVHk6W065WGeB0AOgKbcUX
	 NLQvp3lkVygG7EUHd5KNtclJzjSBiAa9pnOWW2c+wno1PEsssEfazHUkM+FN9r2fqS
	 aSYT2HmwPJXhPKV7AIRwcwxfd3kRG42vCGhXYxRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfJFJTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 05:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfJFJTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 05:19:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 770122133F;
        Sun,  6 Oct 2019 09:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570353586;
        bh=RaGNb1u3bc63/uCEtd4tmegwYacTtQnWlLgt8LRv7UI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mtcabC5nUydTdJS6CWumk7NLH8utjo71Z528gtRUO1xWtxtB6yf4UzbPyLCufTUTB
         hLnCH8LAyAbqAUDrbVwZHInDhnMjPUqthF8swdEBpXSwrKr6rT3w8/LVDtMZOCsWRp
         8MDCxxJEo54n/+57bPK+Cne2C2vEwu4m9PeHcS8I=
Date:   Sun, 6 Oct 2019 10:19:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/10] iio: imu: adis: create an unlocked version of
 adis_reset()
Message-ID: <20191006101942.4fce6760@archlinux>
In-Reply-To: <20190926111812.15957-6-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
        <20190926111812.15957-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2019 14:18:07 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The reset routine may also be important to be protected by the state-lock
> and grouped with other operations, so create an unlocked version, so that
> this can be done.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied
> ---
>  drivers/iio/imu/adis.c       |  8 ++++----
>  include/linux/iio/imu/adis.h | 19 ++++++++++++++++++-
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index e461b9ae22a5..b14101bf34b9 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -309,23 +309,23 @@ int __adis_check_status(struct adis *adis)
>  EXPORT_SYMBOL_GPL(__adis_check_status);
>  
>  /**
> - * adis_reset() - Reset the device
> + * __adis_reset() - Reset the device (unlocked version)
>   * @adis: The adis device
>   *
>   * Returns 0 on success, a negative error code otherwise
>   */
> -int adis_reset(struct adis *adis)
> +int __adis_reset(struct adis *adis)
>  {
>  	int ret;
>  
> -	ret = adis_write_reg_8(adis, adis->data->glob_cmd_reg,
> +	ret = __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
>  			ADIS_GLOB_CMD_SW_RESET);
>  	if (ret)
>  		dev_err(&adis->spi->dev, "Failed to reset device: %d\n", ret);
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(adis_reset);
> +EXPORT_SYMBOL_GPL(__adis_reset);
>  
>  static int adis_self_test(struct adis *adis)
>  {
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index f4ffba0c36b1..966af241710f 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -73,7 +73,24 @@ struct adis {
>  
>  int adis_init(struct adis *adis, struct iio_dev *indio_dev,
>  	struct spi_device *spi, const struct adis_data *data);
> -int adis_reset(struct adis *adis);
> +int __adis_reset(struct adis *adis);
> +
> +/**
> + * adis_reset() - Reset the device
> + * @adis: The adis device
> + *
> + * Returns 0 on success, a negative error code otherwise
> + */
> +static inline int adis_reset(struct adis *adis)
> +{
> +	int ret;
> +
> +	mutex_lock(&adis->state_lock);
> +	ret = __adis_reset(adis);
> +	mutex_unlock(&adis->state_lock);
> +
> +	return ret;
> +}
>  
>  int __adis_write_reg(struct adis *adis, unsigned int reg,
>  	unsigned int val, unsigned int size);

