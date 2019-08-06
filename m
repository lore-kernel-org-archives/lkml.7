Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02E0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE3921874
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7s3HncI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfHFWjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:39:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39428 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfHFWja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:39:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so38296379pfn.6;
        Tue, 06 Aug 2019 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C3EbHa7TnEve9bV6l/TQFntHUBZi1XxEAg1kw3UzgnI=;
        b=e7s3HncItoeV65GzCZMVeB5+uTZTSAejMmWkun7aiDoVHk7cPRmWoHwMh62JHXFsHi
         W6nPXMwW0CmZTQgrmK7QCAa4gONxMN3DWTtEh5X1NvpXejncrKSs65PrQYqrwBAV4F9H
         X7py/HPCesmSYpKJabww4YYxiA1Rgiyy4RwPZJtGsQmAhh8+Qt00zHCeBj3Af3wSPpRK
         KUhvq019D42t33+3HKR/i7blWsuQigMOOq7B0bo7X9VckQuaf99Qn5UsiDlpHrO9XO2X
         NZKCMDJ9SMxMkbVrR1WcFxioJtHteN2yFk3lkU3ZhyEa2yOeeO4qSYpQXCk6unyt17af
         rxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=C3EbHa7TnEve9bV6l/TQFntHUBZi1XxEAg1kw3UzgnI=;
        b=kZ37fLOSIbzPZwr0uwALIu6VA7Gq35744kD+ID0qhSc2Uf4asCpVUF8bLmEPQb2gTb
         GL4SxYiBCjCaitikuEuLCtVbsh4yk4QRzsNvRvLNTxX9RirkdvgrCP3faoz1yQn3E9yr
         PR2SL1TpOEB8E64G1QmVOcuDUMfhO4JG///Qey0URnDphTTsFERi+zffaClTZbgiIuky
         3U34tTo8o63WYRuc4RFNA2LPndzzvRI5FV4OslKucQXy/RxkwONDtaOLwhZYgykRSYcy
         09+n7yDEJOHlLk4r/Z2DDyNdeUhOMNHuVRAJBlkTudmjmFT8SkWZi131KPajKkoXqfxP
         iiTw==
X-Gm-Message-State: APjAAAVbCLRewUryFQH2fMzoJwJOCMGmkbuFgIfNzciUXULWpzVn/i4I
        27hS0za13Kj/iU3KzzZ91LJUldWu
X-Google-Smtp-Source: APXvYqydwNNB+rfGbmKIAH/tmc7XRS0oxpKzuDtQxIh1/ro0VpP+jpcjdi3l+y09xQ/emMBoMiYSrw==
X-Received: by 2002:a63:6205:: with SMTP id w5mr4592320pgb.199.1565131169762;
        Tue, 06 Aug 2019 15:39:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b126sm128901391pfa.126.2019.08.06.15.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 15:39:29 -0700 (PDT)
Date:   Tue, 6 Aug 2019 15:39:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Iker Perez <iker.perez@codethink.co.uk>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] hwmon: (lm75) Create structure to save all the
 configuration parameters.
Message-ID: <20190806223928.GB17293@roeck-us.net>
References: <20190806091107.13322-1-iker.perez@codethink.co.uk>
 <20190806091107.13322-2-iker.perez@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806091107.13322-2-iker.perez@codethink.co.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 10:11:04AM +0100, Iker Perez wrote:
> From: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>
> 
> * Add to lm75_data kind field to store the kind of device the driver is
>   working with.
> * Add an structure to store the configuration parameters of all the
>   supported devices.
> * Delete resolution_limits from lm75_data and include them in the structure
>   described above.
> * Add a pointer to the configuration parameters structure to be used as a
>   reference to obtain the parameters.
> * Delete switch-case approach to get the device configuration parameters.
> * The structure is cleaner and easier to maintain.
> 
> Signed-off-by: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>
> ---
>  drivers/hwmon/lm75.c | 275 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 169 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index a2d3f2ce3e1d..1c012301b6ca 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -18,7 +18,6 @@
>  #include <linux/regmap.h>
>  #include "lm75.h"
>  
> -
>  /*
>   * This driver handles the LM75 and compatible digital temperature sensors.
>   */
> @@ -51,6 +50,25 @@ enum lm75_type {		/* keep sorted in alphabetical order */
>  	tmp75c,
>  };
>  
> +/**
> + * struct lm75_params - lm75 configuration parameters.
> + * @set_mask:		Bits to set in cofiguration register when configuring
> + *			the chip.
> + * @clr_mask:		Bits to clear in configuration register when configuring
> + *			the chip.
> + * @resolution:		Number of bits to represent the temperatue value.
> + * @resolution_limits:	Resolution range.
> + * default_sample_time:	Sample time to be set by default.
> + */
> +
> +struct lm75_params {
> +	u8		set_mask;
> +	u8		clr_mask;
> +	u8		default_resolution;
> +	u8		resolution_limits;
> +	unsigned int	default_sample_time;
> +};
> +
>  /* Addresses scanned */
>  static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
>  					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
> @@ -63,15 +81,147 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
>  
>  /* Each client has this additional data */
>  struct lm75_data {
> -	struct i2c_client	*client;
> -	struct regmap		*regmap;
> -	u8			orig_conf;
> -	u8			resolution;	/* In bits, between 9 and 16 */
> -	u8			resolution_limits;
> -	unsigned int		sample_time;	/* In ms */
> +	struct i2c_client		*client;
> +	struct regmap			*regmap;
> +	u8				orig_conf;
> +	u8				current_conf;
> +	u8				resolution;	/* In bits, 9 to 16 */
> +	unsigned int			sample_time;	/* In ms */
> +	enum lm75_type			kind;
> +	const struct lm75_params	*params;
>  };
>  
>  /*-----------------------------------------------------------------------*/
> +/* The structure below stores the configuration values of the supported devices.
> + * In case of being supported multiple configurations, the default one must
> + * always be the first element of the array
> + */
> +static const struct lm75_params device_params[] = {
> +	[adt75] = {
> +		.clr_mask = 1 << 5,	/* not one-shot mode */
> +		.default_resolution = 12,
> +		.default_sample_time = MSEC_PER_SEC / 8,
> +	},
> +	[ds1775] = {
> +		.clr_mask = 3 << 5,
> +		.set_mask = 2 << 5,	/* 11-bit mode */
> +		.default_resolution = 11,
> +		.default_sample_time = MSEC_PER_SEC,
> +	},
> +	[ds75] = {
> +		.clr_mask = 3 << 5,
> +		.set_mask = 2 << 5,	/* 11-bit mode */
> +		.default_resolution = 11,
> +		.default_sample_time = MSEC_PER_SEC,
> +	},
> +	[stds75] = {
> +		.clr_mask = 3 << 5,
> +		.set_mask = 2 << 5,	/* 11-bit mode */
> +		.default_resolution = 11,
> +		.default_sample_time = MSEC_PER_SEC,
> +	},
> +	[stlm75] = {
> +		.default_resolution = 9,
> +		.default_sample_time = MSEC_PER_SEC / 5,
> +	},
> +	[ds7505] = {
> +		.set_mask = 3 << 5,	/* 12-bit mode*/
> +		.default_resolution = 12,
> +		.default_sample_time = MSEC_PER_SEC / 4,
> +	},
> +	[g751] = {
> +		.default_resolution = 9,
> +		.default_sample_time = MSEC_PER_SEC / 2,
> +	},
> +	[lm75] = {
> +		.default_resolution = 9,
> +		.default_sample_time = MSEC_PER_SEC / 2,
> +	},
> +	[lm75a] = {
> +		.default_resolution = 9,
> +		.default_sample_time = MSEC_PER_SEC / 2,
> +	},
> +	[lm75b] = {
> +		.default_resolution = 11,
> +		.default_sample_time = MSEC_PER_SEC / 4,
> +	},
> +	[max6625] = {
> +		.default_resolution = 9,
> +		.default_sample_time = MSEC_PER_SEC / 4,
> +	},
> +	[max6626] = {
> +		.default_resolution = 12,
> +		.default_sample_time = MSEC_PER_SEC / 4,
> +		.resolution_limits = 9,
> +	},
> +	[max31725] = {
> +		.default_resolution = 16,
> +		.default_sample_time = MSEC_PER_SEC / 8,
> +	},
> +	[tcn75] = {
> +		.default_resolution = 9,
> +		.default_sample_time = MSEC_PER_SEC / 8,
> +	},
> +	[mcp980x] = {
> +		.set_mask = 3 << 5,	/* 12-bit mode */
> +		.clr_mask = 1 << 7,	/* not one-shot mode */
> +		.default_resolution = 12,
> +		.resolution_limits = 9,
> +		.default_sample_time = MSEC_PER_SEC,
> +	},
> +	[tmp100] = {
> +		.set_mask = 3 << 5,	/* 12-bit mode */
> +		.clr_mask = 1 << 7,	/* not one-shot mode */
> +		.default_resolution = 12,
> +		.default_sample_time = MSEC_PER_SEC,
> +	},
> +	[tmp101] = {
> +		.set_mask = 3 << 5,	/* 12-bit mode */
> +		.clr_mask = 1 << 7,	/* not one-shot mode */
> +		.default_resolution = 12,
> +		.default_sample_time = MSEC_PER_SEC,
> +	},
> +	[tmp112] = {
> +		.set_mask = 3 << 5,	/* 12-bit mode */
> +		.clr_mask = 1 << 7,	/* no one-shot mode*/
> +		.default_resolution = 12,
> +		.default_sample_time = MSEC_PER_SEC / 4,
> +	},
> +	[tmp105] = {
> +		.set_mask = 3 << 5,	/* 12-bit mode */
> +		.clr_mask = 1 << 7,	/* not one-shot mode*/
> +		.default_resolution = 12,
> +		.default_sample_time = MSEC_PER_SEC / 2,
> +	},
> +	[tmp175] = {
> +		.set_mask = 3 << 5,	/* 12-bit mode */
> +		.clr_mask = 1 << 7,	/* not one-shot mode*/
> +		.default_resolution = 12,
> +		.default_sample_time = MSEC_PER_SEC / 2,
> +	},
> +	[tmp275] = {
> +		.set_mask = 3 << 5,	/* 12-bit mode */
> +		.clr_mask = 1 << 7,	/* not one-shot mode*/
> +		.default_resolution = 12,
> +		.default_sample_time = MSEC_PER_SEC / 2,
> +	},
> +	[tmp75] = {
> +		.set_mask = 3 << 5,	/* 12-bit mode */
> +		.clr_mask = 1 << 7,	/* not one-shot mode*/
> +		.default_resolution = 12,
> +		.default_sample_time = MSEC_PER_SEC / 2,
> +	},
> +	[tmp75b] = { /* not one-shot mode, Conversion rate 37Hz */
> +		.clr_mask = 1 << 7 | 3 << 5,
> +		.default_resolution = 12,
> +		.default_sample_time = MSEC_PER_SEC / 37,
> +	},
> +	[tmp75c] = {
> +		.clr_mask = 1 << 5,	/*not one-shot mode*/
> +		.default_resolution = 12,
> +		.default_sample_time = MSEC_PER_SEC / 4,
> +	}
> +};
>  
>  static inline long lm75_reg_to_mc(s16 temp, u8 resolution)
>  {
> @@ -146,8 +296,8 @@ static int lm75_write(struct device *dev, enum hwmon_sensor_types type,
>  	 * Resolution of limit registers is assumed to be the same as the
>  	 * temperature input register resolution unless given explicitly.
>  	 */
> -	if (data->resolution_limits)
> -		resolution = data->resolution_limits;
> +	if (data->params->resolution_limits)
> +		resolution = data->params->resolution_limits;
>  	else
>  		resolution = data->resolution;
>  
> @@ -239,7 +389,6 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	struct device *hwmon_dev;
>  	struct lm75_data *data;
>  	int status, err;
> -	u8 set_mask, clr_mask;
>  	int new;
>  	enum lm75_type kind;
>  
> @@ -257,6 +406,7 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		return -ENOMEM;
>  
>  	data->client = client;
> +	data->kind = kind;
>  
>  	data->regmap = devm_regmap_init_i2c(client, &lm75_regmap_config);
>  	if (IS_ERR(data->regmap))
> @@ -265,109 +415,22 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	/* Set to LM75 resolution (9 bits, 1/2 degree C) and range.
>  	 * Then tweak to be more precise when appropriate.
>  	 */
> -	set_mask = 0;
> -	clr_mask = LM75_SHUTDOWN;		/* continuous conversions */
> -
> -	switch (kind) {
> -	case adt75:
> -		clr_mask |= 1 << 5;		/* not one-shot mode */
> -		data->resolution = 12;
> -		data->sample_time = MSEC_PER_SEC / 8;
> -		break;
> -	case ds1775:
> -	case ds75:
> -	case stds75:
> -		clr_mask |= 3 << 5;
> -		set_mask |= 2 << 5;		/* 11-bit mode */
> -		data->resolution = 11;
> -		data->sample_time = MSEC_PER_SEC;
> -		break;
> -	case stlm75:
> -		data->resolution = 9;
> -		data->sample_time = MSEC_PER_SEC / 5;
> -		break;
> -	case ds7505:
> -		set_mask |= 3 << 5;		/* 12-bit mode */
> -		data->resolution = 12;
> -		data->sample_time = MSEC_PER_SEC / 4;
> -		break;
> -	case g751:
> -	case lm75:
> -	case lm75a:
> -		data->resolution = 9;
> -		data->sample_time = MSEC_PER_SEC / 2;
> -		break;
> -	case lm75b:
> -		data->resolution = 11;
> -		data->sample_time = MSEC_PER_SEC / 4;
> -		break;
> -	case max6625:
> -		data->resolution = 9;
> -		data->sample_time = MSEC_PER_SEC / 4;
> -		break;
> -	case max6626:
> -		data->resolution = 12;
> -		data->resolution_limits = 9;
> -		data->sample_time = MSEC_PER_SEC / 4;
> -		break;
> -	case max31725:
> -		data->resolution = 16;
> -		data->sample_time = MSEC_PER_SEC / 8;
> -		break;
> -	case tcn75:
> -		data->resolution = 9;
> -		data->sample_time = MSEC_PER_SEC / 8;
> -		break;
> -	case pct2075:
> -		data->resolution = 11;
> -		data->sample_time = MSEC_PER_SEC / 10;
> -		break;

This entry got lost in the rebase to hwmon-next.

Guenter
