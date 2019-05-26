Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7110AC28CBF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 17:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3A42085A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 17:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558892097;
	bh=+m0uS2lL/v35KGStzpr9dgbNrhGRKJ8cMxaKGqrRsq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RHjcCQ93/FaLWWTIOvnENSRA+8/BYjlVQAgxyV8C2beoPaa2WdD44+hIbaPpwM/hP
	 KkG231qUrJuJh2riEzOT1IJD4atGZHvmLd3Hyo71OoRA31kIoULGdRZldQEkNSQY2/
	 xwprG2Tfz7cpdel3WC+vGPvuEOTlMXiWafepWhpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfEZRe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 13:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfEZRez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 13:34:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C7E920815;
        Sun, 26 May 2019 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558892094;
        bh=+m0uS2lL/v35KGStzpr9dgbNrhGRKJ8cMxaKGqrRsq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=istdS91Wd6REpUiRl/kaCPbURG5Yhf5zj38cD4jebLvGJyeZqY5NRGQNTtt38Lo9F
         CEBRheWLNgtCzMN38sFJW9s+CV4a05GXHi1ELF7mvDwzEWFUPMBHSmlBZ+FJFUFOC7
         sXaWfP9WBZLqxL/uksovWs5idnezsiEtE2kRfCsI=
Date:   Sun, 26 May 2019 18:34:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, lars@metafoo.de, knaack.h@gmx.de,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/3] iio: dps310: Temperature measurement errata
Message-ID: <20190526183449.51750b58@archlinux>
In-Reply-To: <1558404814-26078-3-git-send-email-eajames@linux.ibm.com>
References: <1558404814-26078-1-git-send-email-eajames@linux.ibm.com>
        <1558404814-26078-3-git-send-email-eajames@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 21:13:33 -0500
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
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

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

