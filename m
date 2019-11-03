Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66FFCA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 10:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D92E2084D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572776876;
	bh=9OAjTKHed8RbyMuAolcS5ZGUIeVO864LWqv7m+LFdA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JxfzEEjMUZGioTQ/BV6h9UV3mT0OPmnIdO1Bbj/MQ+PehCwAfeEw7klss2d/0o2M+
	 XDLWTcoHiE47iygXNx7OPFdZjXLWqOuVoz7+nOCAfMOO4j4HUtIBGL23krnB/8hd52
	 TSYGVtMBVH4zu0soKZQsELkBvCpQP4QETNsCLmDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKCK1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 05:27:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfKCK1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 05:27:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A8F320842;
        Sun,  3 Nov 2019 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572776873;
        bh=9OAjTKHed8RbyMuAolcS5ZGUIeVO864LWqv7m+LFdA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lgYxIg6hGVcsdTs0hGPGUt0vUKGxYsViiJMRabvXpC3gwnaZCIFhU+x3gL1tmzFn+
         v03amFox7NQB2s0yJnt5gG1xx81Evmn2xb7cIQVIoq/p1ZfkIJ5U0wqMQyxmk1AetH
         LTKBwJrXM7W7vKvc4BrormtRNJSw8yYZw6Ad8E4E=
Date:   Sun, 3 Nov 2019 10:27:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH 04/10] iio: imu: adis16480: check ret val for non-zero
 vs less-than-zero
Message-ID: <20191103102749.7507e410@archlinux>
In-Reply-To: <20191101093505.9408-5-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
        <20191101093505.9408-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2019 11:34:59 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The ADIS library functions return zero on success, and negative values for
> error. Positive values aren't returned, but we only care about the success
> value (which is zero).
> 
> This change is mostly needed so that the compiler won't make any inferences
> about some about values being potentially un-initialized. This only
> triggers after making some functions inline, because the compiler can
> better follow return paths.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index b99d73887c9f..86801f3c5f0d 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -181,7 +181,7 @@ static ssize_t adis16480_show_firmware_revision(struct file *file,
>  	int ret;
>  
>  	ret = adis_read_reg_16(&adis16480->adis, ADIS16480_REG_FIRM_REV, &rev);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	len = scnprintf(buf, sizeof(buf), "%x.%x\n", rev >> 8, rev & 0xff);
> @@ -206,11 +206,11 @@ static ssize_t adis16480_show_firmware_date(struct file *file,
>  	int ret;
>  
>  	ret = adis_read_reg_16(&adis16480->adis, ADIS16480_REG_FIRM_Y, &year);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	ret = adis_read_reg_16(&adis16480->adis, ADIS16480_REG_FIRM_DM, &md);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	len = snprintf(buf, sizeof(buf), "%.2x-%.2x-%.4x\n",
> @@ -234,7 +234,7 @@ static int adis16480_show_serial_number(void *arg, u64 *val)
>  
>  	ret = adis_read_reg_16(&adis16480->adis, ADIS16480_REG_SERIAL_NUM,
>  		&serial);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	*val = serial;
> @@ -252,7 +252,7 @@ static int adis16480_show_product_id(void *arg, u64 *val)
>  
>  	ret = adis_read_reg_16(&adis16480->adis, ADIS16480_REG_PROD_ID,
>  		&prod_id);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	*val = prod_id;
> @@ -270,7 +270,7 @@ static int adis16480_show_flash_count(void *arg, u64 *val)
>  
>  	ret = adis_read_reg_32(&adis16480->adis, ADIS16480_REG_FLASH_CNT,
>  		&flash_count);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	*val = flash_count;
> @@ -359,7 +359,7 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
>  		reg = ADIS16480_REG_DEC_RATE;
>  
>  	ret = adis_read_reg_16(&st->adis, reg, &t);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	/*
> @@ -462,7 +462,7 @@ static int adis16480_get_calibbias(struct iio_dev *indio_dev,
>  			ret = -EINVAL;
>  	}
>  
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	return IIO_VAL_INT;
> @@ -489,7 +489,7 @@ static int adis16480_get_calibscale(struct iio_dev *indio_dev,
>  	int ret;
>  
>  	ret = adis_read_reg_16(&st->adis, reg, &val16);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	*scale = sign_extend32(val16, 15);
> @@ -535,7 +535,7 @@ static int adis16480_get_filter_freq(struct iio_dev *indio_dev,
>  	enable_mask = BIT(offset + 2);
>  
>  	ret = adis_read_reg_16(&st->adis, reg, &val);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	if (!(val & enable_mask))
> @@ -561,7 +561,7 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
>  	enable_mask = BIT(offset + 2);
>  
>  	ret = adis_read_reg_16(&st->adis, reg, &val);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	if (freq == 0) {
> @@ -937,7 +937,7 @@ static int adis16480_enable_irq(struct adis *adis, bool enable)
>  	int ret;
>  
>  	ret = adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	val &= ~ADIS16480_DRDY_EN_MSK;
> @@ -1115,7 +1115,7 @@ static int adis16480_ext_clk_config(struct adis16480 *st,
>  	int ret;
>  
>  	ret = adis_read_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, &val);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	pin = adis16480_of_get_ext_clk_pin(st, of_node);
> @@ -1141,7 +1141,7 @@ static int adis16480_ext_clk_config(struct adis16480 *st,
>  	val |= mode;
>  
>  	ret = adis_write_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, val);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	return clk_prepare_enable(st->ext_clk);

