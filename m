Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C916C4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0179420836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552151164;
	bh=pEuSfNN9C65N9vAmSvligHXic92oXGyw1M8kGzz5m14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gz+gesHvuboS3Z781OYDiGMYIRsgseO4oXH/FbjbA0T2NxD1arMs+ZNWEXssfrn6R
	 hu08aG4HPJr4R3bYRhpzsIJ4/oIh18b1YS3rh5xYiYnOgwNG9ksT13+tq0S1dpVKiA
	 wi/l2LYVk88msaQDMC8Xn+paE7H+DGTIRByWjeMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfCIRGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:06:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfCIRGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 12:06:02 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 171C520815;
        Sat,  9 Mar 2019 17:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552151161;
        bh=pEuSfNN9C65N9vAmSvligHXic92oXGyw1M8kGzz5m14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Doct0kQz+TzLHSyd4zN4yMSfuZ09BnEPx5nE8kqxXYFM7meNByuYCJQgE2eRIqAnX
         K/SBXqW1TncsG4E/NUvX/vEH+nzSR2itL5h872wckHMBgQXnu3cZrB1F9X1NyC/RLn
         hpAgGK3IxB94RwQrjIhZXoxvF5WzEKF0jlLZs97Q=
Date:   Sat, 9 Mar 2019 17:05:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-iio@vger.kernel.org, himanshujha199640@gmail.com,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dpfrey@gmail.com, colin.king@canonical.com
Subject: Re: [PATCH v3 1/2] iio/chemical/bme680: Report temperature in
 millidegrees
Message-ID: <20190309170555.4982543d@archlinux>
In-Reply-To: <1551857508-4254-1-git-send-email-mike.looijmans@topic.nl>
References: <1550238475-25698-1-git-send-email-mike.looijmans@topic.nl>
        <1551857508-4254-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Mar 2019 08:31:47 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The standard unit for temperature is millidegrees Celcius. Adapt the
> driver to report in millidegrees instead of degrees.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
I tweaked the patch title to make it obvious this was a fix
(added the word fix ;)

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
> v2: Remove unused 'addr7' variable                                                       
> v3: Split patch into temperature and SPI
> 
>  drivers/iio/chemical/bme680_core.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 70c1fe4..fefe32b 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -583,8 +583,7 @@ static int bme680_gas_config(struct bme680_data *data)
>  	return ret;
>  }
>  
> -static int bme680_read_temp(struct bme680_data *data,
> -			    int *val, int *val2)
> +static int bme680_read_temp(struct bme680_data *data, int *val)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
> @@ -617,10 +616,9 @@ static int bme680_read_temp(struct bme680_data *data,
>  	 * compensate_press/compensate_humid to get compensated
>  	 * pressure/humidity readings.
>  	 */
> -	if (val && val2) {
> -		*val = comp_temp;
> -		*val2 = 100;
> -		return IIO_VAL_FRACTIONAL;
> +	if (val) {
> +		*val = comp_temp * 10; /* Centidegrees to millidegrees */
> +		return IIO_VAL_INT;
>  	}
>  
>  	return ret;
> @@ -635,7 +633,7 @@ static int bme680_read_press(struct bme680_data *data,
>  	s32 adc_press;
>  
>  	/* Read and compensate temperature to get a reading of t_fine */
> -	ret = bme680_read_temp(data, NULL, NULL);
> +	ret = bme680_read_temp(data, NULL);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -668,7 +666,7 @@ static int bme680_read_humid(struct bme680_data *data,
>  	u32 comp_humidity;
>  
>  	/* Read and compensate temperature to get a reading of t_fine */
> -	ret = bme680_read_temp(data, NULL, NULL);
> +	ret = bme680_read_temp(data, NULL);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -761,7 +759,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -			return bme680_read_temp(data, val, val2);
> +			return bme680_read_temp(data, val);
>  		case IIO_PRESSURE:
>  			return bme680_read_press(data, val, val2);
>  		case IIO_HUMIDITYRELATIVE:

