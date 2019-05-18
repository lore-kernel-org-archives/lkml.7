Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF31EC072A4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 10:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9015020C01
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 10:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558176232;
	bh=FPuET957IVsJTVkL6+gB6VWuxqUetLWhiGUZNP9FBEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AjnsWzw76Rdxi4cxrKZCZMxvXMe16tiAPxLyVgAF+kbfPwsawXvjtZ/T8j1NGzrNo
	 F/6ZPfcAJ/YiIqEggs9VmwYoA8OYW6/23wY5NFcib1sGMmvFBBheUfZwPMVchRKa+O
	 5X9edbzmaGmJeY8na5+z2t4l2YP4ewRClACttKv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfERKnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 06:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfERKnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 06:43:51 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A234220872;
        Sat, 18 May 2019 10:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558176230;
        bh=FPuET957IVsJTVkL6+gB6VWuxqUetLWhiGUZNP9FBEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IaIEpyp1Lg1VQPtuUxCkq2/7AspYMgsg99m7+xJwuMdw+SOfp8vc1NSN+jI235byZ
         sBl4QVxIl23PSnaxJjOXourrrE+onhQNQM95/+IaRq0tXrkg9rXgRKFLI32zmp0/Cr
         +ogfW8gyCrft1wgtDuZjJJr47bdj0YsRj+kev+PI=
Date:   Sat, 18 May 2019 11:43:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, lars@metafoo.de, knaack.h@gmx.de,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/3] iio: dps310: Temperature measurement errata
Message-ID: <20190518114346.51a54093@archlinux>
In-Reply-To: <1557945677-12838-3-git-send-email-eajames@linux.ibm.com>
References: <1557945677-12838-1-git-send-email-eajames@linux.ibm.com>
        <1557945677-12838-3-git-send-email-eajames@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 13:41:16 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> 
> Add a manufacturer's suggested workaround to deal with early revisions
> of chip that don't indicate correct temperature. Readings can be in the
> ~60C range when they should be in the ~20's.
> 
> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
Looks fine to me.

For reference:

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/pressure/dps310.c | 52 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 9acfccb..a093e3a 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -53,7 +53,6 @@
>  #define DPS310_RESET		0x0c
>  #define  DPS310_RESET_MAGIC	0x09
>  #define DPS310_COEF_BASE	0x10
> -#define DPS310_COEF_SRC		0x28
>  
>  /* Make sure sleep time is <= 20ms for usleep_range */
>  #define DPS310_POLL_SLEEP_US(t)		min(20000, (t) / 8)
> @@ -234,6 +233,10 @@ static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
>  	case DPS310_MEAS_CFG:
>  	case DPS310_CFG_REG:
>  	case DPS310_RESET:
> +	/* No documentation available on the registers below */
> +	case 0x0e:
> +	case 0x0f:
> +	case 0x62:
>  		return true;
>  	default:
>  		return false;
> @@ -250,6 +253,7 @@ static bool dps310_is_volatile_reg(struct device *dev, unsigned int reg)
>  	case DPS310_TMP_B1:
>  	case DPS310_TMP_B2:
>  	case DPS310_MEAS_CFG:
> +	case 0x32:	/* No documentation available on this register */
>  		return true;
>  	default:
>  		return false;
> @@ -360,7 +364,7 @@ static void dps310_reset(void *action_data)
>  	.writeable_reg = dps310_is_writeable_reg,
>  	.volatile_reg = dps310_is_volatile_reg,
>  	.cache_type = REGCACHE_RBTREE,
> -	.max_register = DPS310_COEF_SRC,
> +	.max_register = 0x62, /* No documentation available on this register */
>  };
>  
>  static const struct iio_info dps310_info = {
> @@ -368,6 +372,46 @@ static void dps310_reset(void *action_data)
>  	.write_raw = dps310_write_raw,
>  };
>  
> +/*
> + * Some verions of chip will read temperatures in the ~60C range when
> + * its actually ~20C. This is the manufacturer recommended workaround
> + * to correct the issue. The registers used below are undocumented.
> + */
> +static int dps310_temp_workaround(struct dps310_data *data)
> +{
> +	int rc;
> +	int reg;
> +
> +	rc = regmap_read(data->regmap, 0x32, &reg);
> +	if (rc < 0)
> +		return rc;
> +
> +	/*
> +	 * If bit 1 is set then the device is okay, and the workaround does not
> +	 * need to be applied
> +	 */
> +	if (reg & BIT(1))
> +		return 0;
> +
> +	rc = regmap_write(data->regmap, 0x0e, 0xA5);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_write(data->regmap, 0x0f, 0x96);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_write(data->regmap, 0x62, 0x02);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_write(data->regmap, 0x0e, 0x00);
> +	if (rc < 0)
> +		return rc;
> +
> +	return regmap_write(data->regmap, 0x0f, 0x00);
> +}
> +
>  static int dps310_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -439,6 +483,10 @@ static int dps310_probe(struct i2c_client *client,
>  	if (rc < 0)
>  		return rc;
>  
> +	rc = dps310_temp_workaround(data);
> +	if (rc < 0)
> +		return rc;
> +
>  	rc = devm_iio_device_register(&client->dev, iio);
>  	if (rc)
>  		return rc;

