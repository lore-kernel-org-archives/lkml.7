Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2227EECE58F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBEB20867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570353776;
	bh=IESTabkUnRSANPWGIqFvSEN95bBO9CaqzCswxLOBIy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=puW3fOUFgCaU/iYOZcr+4m1ckXfZzVVDLDwC/c/43EFeD58fWbQSyf3pw2XlKFybL
	 7zv7EyBf0ma3LwFxU3Iiyh/WkSM76FfY8dz1zHsRoUe56C3c0ns1FK+rMFozc9YKgw
	 2jIgjViUQ3jV6H+4bdzO+0+yoeo+Gwou2/Q1nY9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfJFJWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 05:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfJFJWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 05:22:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94475206C2;
        Sun,  6 Oct 2019 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570353770;
        bh=IESTabkUnRSANPWGIqFvSEN95bBO9CaqzCswxLOBIy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cdyYrQv3aZseDXATxfl/RYKzoqHrpLEqXY+IEopu6rC/h+CXKQ63HUBT96zeToK7H
         rIDyPAyijsl2FYcR5cdCsFl46NuCF32LLWuFc37nKAqYPuDMZEzcH1uklAGrQYVQLi
         Tib3NkyF8ZYIkRh/84wD56TOEWhi8DTHrLQ1jLqM=
Date:   Sun, 6 Oct 2019 10:22:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] iio: gyro: adis16136: rework locks using ADIS
 library's state lock
Message-ID: <20191006102244.719d3941@archlinux>
In-Reply-To: <20190926111812.15957-10-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
        <20190926111812.15957-10-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2019 14:18:11 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This replaces indio_dev's mlock with the state lock/mutex from the ADIS
> library.
> 
> The __adis16136_get_freq() function has been prefixed to mark it as
> unlocked. The adis16136_{set,get}_filter() functions now hold the state
> lock for all the ops that they do.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/adis16136.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> index 5bec7ad53d8b..2d2c48f0b996 100644
> --- a/drivers/iio/gyro/adis16136.c
> +++ b/drivers/iio/gyro/adis16136.c
> @@ -185,12 +185,12 @@ static int adis16136_set_freq(struct adis16136 *adis16136, unsigned int freq)
>  	return adis_write_reg_16(&adis16136->adis, ADIS16136_REG_SMPL_PRD, t);
>  }
>  
> -static int adis16136_get_freq(struct adis16136 *adis16136, unsigned int *freq)
> +static int __adis16136_get_freq(struct adis16136 *adis16136, unsigned int *freq)
>  {
>  	uint16_t t;
>  	int ret;
>  
> -	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_SMPL_PRD, &t);
> +	ret = __adis_read_reg_16(&adis16136->adis, ADIS16136_REG_SMPL_PRD, &t);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -224,10 +224,13 @@ static ssize_t adis16136_read_frequency(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct adis16136 *adis16136 = iio_priv(indio_dev);
> +	struct mutex *slock = &adis16136->adis.state_lock;
>  	unsigned int freq;
>  	int ret;
>  
> -	ret = adis16136_get_freq(adis16136, &freq);
> +	mutex_lock(slock);
> +	ret = __adis16136_get_freq(adis16136, &freq);
> +	mutex_unlock(slock);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -252,42 +255,50 @@ static const unsigned adis16136_3db_divisors[] = {
>  static int adis16136_set_filter(struct iio_dev *indio_dev, int val)
>  {
>  	struct adis16136 *adis16136 = iio_priv(indio_dev);
> +	struct mutex *slock = &adis16136->adis.state_lock;
>  	unsigned int freq;
>  	int i, ret;
>  
> -	ret = adis16136_get_freq(adis16136, &freq);
> +	mutex_lock(slock);
> +	ret = __adis16136_get_freq(adis16136, &freq);
>  	if (ret < 0)
> -		return ret;
> +		goto out_unlock;
>  
>  	for (i = ARRAY_SIZE(adis16136_3db_divisors) - 1; i >= 1; i--) {
>  		if (freq / adis16136_3db_divisors[i] >= val)
>  			break;
>  	}
>  
> -	return adis_write_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, i);
> +	ret = __adis_write_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, i);
> +out_unlock:
> +	mutex_unlock(slock);
> +
> +	return ret;
>  }
>  
>  static int adis16136_get_filter(struct iio_dev *indio_dev, int *val)
>  {
>  	struct adis16136 *adis16136 = iio_priv(indio_dev);
> +	struct mutex *slock = &adis16136->adis.state_lock;
>  	unsigned int freq;
>  	uint16_t val16;
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(slock);
>  
> -	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, &val16);
> +	ret = __adis_read_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT,
> +				 &val16);
>  	if (ret < 0)
>  		goto err_unlock;
>  
> -	ret = adis16136_get_freq(adis16136, &freq);
> +	ret = __adis16136_get_freq(adis16136, &freq);
>  	if (ret < 0)
>  		goto err_unlock;
>  
>  	*val = freq / adis16136_3db_divisors[val16 & 0x07];
>  
>  err_unlock:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(slock);
>  
>  	return ret ? ret : IIO_VAL_INT;
>  }

