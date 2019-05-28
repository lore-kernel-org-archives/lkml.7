Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F84DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CC520B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRuIGDpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfE1Tq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:46:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43793 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1Tqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:46:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so11593190pgv.10;
        Tue, 28 May 2019 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vykqyVooyGgAqRQdSZwn7Wka9YU9SKnfGeAFnE60xVE=;
        b=jRuIGDpMf5ZpSxHepupwKxnFp3xFdUmES6yBKZgYMfA5ynZtUE0qJ2oUtjIeo9IedT
         nz1/VSoJyWK+SxZ8kchL1HhQoCQzfIbU4dzK2ztxkc4SjThSbChRnB/5V+BOhYHizxw4
         p7h0C7eH6sU6Fzbp/q2K/tWm+0M18zXbXyqOcOZVNh42dkeV9NavXYO52Mm2wqR/stoL
         L6I8oVS+ghvI+T/KSQZUqI0tfL2oo0ERmjNvlCvIc+WjIK8CX0UDazDNV14rTohxKY6r
         1/Ud9sTUqKo8dSBMOLSanW0Nc3Yxoqpf67HKBPILVjrWIgIyHQeZQk8Zda+l/Md6h/bH
         zVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vykqyVooyGgAqRQdSZwn7Wka9YU9SKnfGeAFnE60xVE=;
        b=UyvLHKXRvf2m44X9I08XeUpulNKnXMSnN6kjjICEY39mBVwtGBYBlt3/EwDEYiY/Ua
         l6+Pz3y+Qx62stB5dMuYi7/0pW3l9Bf6dFb/g9NK7CRXB2aEerhLN4lUCmknFtI+9293
         mYOFYVp0ncyRcSIkjAW0MBE51BKMG4AW96ztELk4zWHXzcQcKZK2dMhYge1MS0p2TtlO
         fiB6vF2zHoa4MYMZHP6A8ZTq9L5v3r+gzGaPNw11LYSqwzoiNz3fHIiXfSjET6Ppiuqv
         pxSj4KHBs8IFnSIklAhUAotAgk0+07S1E3qnZkS0FHAXuFuuJ9EOSLtaeSCNfOVNWQnu
         B+kA==
X-Gm-Message-State: APjAAAUKY2rhK/wJjV/YH7XCnG1FJdBG2M5eIgozpbnUqiuRkmR+9DYx
        fJAYEIvsgovoEV9QVY46sLaQrLE8
X-Google-Smtp-Source: APXvYqz2rnJelIiTR9IfTMTWk024QR5bpWL/5/gUa98T9CBh2tX0CxNSwhVw0PW/psDYIOLZ7x296Q==
X-Received: by 2002:a17:90a:2a8f:: with SMTP id j15mr7822030pjd.98.1559072813744;
        Tue, 28 May 2019 12:46:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n35sm13869861pgl.44.2019.05.28.12.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 12:46:53 -0700 (PDT)
Date:   Tue, 28 May 2019 12:46:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] adm1275: support PMBUS_VIRT_*_SAMPLES
Message-ID: <20190528194652.GE24853@roeck-us.net>
References: <20190524124841.GA25728@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524124841.GA25728@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:49:13PM +0000, Adamski, Krzysztof (Nokia - PL/Wroclaw) wrote:
> The device supports setting the number of samples for averaging the
> measurements. There are two separate settings - PWR_AVG for averaging
> PIN and VI_AVG for averaging VIN/VAUX/IOUT, both being part of
> PMON_CONFIG register. The values are stored as exponent of base 2 of the
> actual number of samples that will be taken.
> 
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> ---
>  drivers/hwmon/pmbus/adm1275.c | 68 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index f569372c9204..4efe1a9df563 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -23,6 +23,8 @@
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/log2.h>
>  #include "pmbus.h"
>  
>  enum chips { adm1075, adm1272, adm1275, adm1276, adm1278, adm1293, adm1294 };
> @@ -78,6 +80,10 @@ enum chips { adm1075, adm1272, adm1275, adm1276, adm1278, adm1293, adm1294 };
>  #define ADM1075_VAUX_OV_WARN		BIT(7)
>  #define ADM1075_VAUX_UV_WARN		BIT(6)
>  
> +#define ADM1275_PWR_AVG_MASK		GENMASK(13, 11)
> +#define ADM1275_VI_AVG_MASK		GENMASK(10, 8)
> +#define ADM1275_SAMPLES_AVG_MAX	128
> +
>  struct adm1275_data {
>  	int id;
>  	bool have_oc_fault;
> @@ -90,6 +96,7 @@ struct adm1275_data {
>  	bool have_pin_max;
>  	bool have_temp_max;
>  	struct pmbus_driver_info info;
> +	struct mutex lock;
>  };
>  
>  #define to_adm1275_data(x)  container_of(x, struct adm1275_data, info)
> @@ -164,6 +171,38 @@ static const struct coefficients adm1293_coefficients[] = {
>  	[18] = { 7658, 0, -3 },		/* power, 21V, irange200 */
>  };
>  
> +static inline int adm1275_read_pmon_config(struct i2c_client *client, u64 mask)

Why is the mask passed through as u64 ?

> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(client, ADM1275_PMON_CONFIG);
> +	if (ret < 0)
> +		return ret;
> +
> +	return FIELD_GET(mask, ret);
> +}
> +
> +static inline int adm1275_write_pmon_config(struct i2c_client *client, u64 mask,
> +					    u16 word)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct adm1275_data *data = to_adm1275_data(info);
> +	int ret;
> +
> +	mutex_lock(&data->lock);

Why is another lock on top of the lock provided by the pmbus core required ?

> +	ret = i2c_smbus_read_word_data(client, ADM1275_PMON_CONFIG);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	word = FIELD_PREP(mask, word) | (ret & ~mask);
> +	ret = i2c_smbus_write_word_data(client, ADM1275_PMON_CONFIG, word);
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
>  static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
>  {
>  	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> @@ -242,6 +281,19 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
>  		if (!data->have_temp_max)
>  			return -ENXIO;
>  		break;
> +	case PMBUS_VIRT_POWER_SAMPLES:
> +		ret = adm1275_read_pmon_config(client, ADM1275_PWR_AVG_MASK);
> +		if (ret < 0)
> +			break;
> +		ret = 1 << ret;

		ret = BIT(ret);

> +		break;
> +	case PMBUS_VIRT_IN_SAMPLES:
> +	case PMBUS_VIRT_CURR_SAMPLES:
> +		ret = adm1275_read_pmon_config(client, ADM1275_VI_AVG_MASK);
> +		if (ret < 0)
> +			break;
> +		ret = 1 << ret;

		ret = BIT(ret);

> +		break;
>  	default:
>  		ret = -ENODATA;
>  		break;
> @@ -286,6 +338,17 @@ static int adm1275_write_word_data(struct i2c_client *client, int page, int reg,
>  	case PMBUS_VIRT_RESET_TEMP_HISTORY:
>  		ret = pmbus_write_word_data(client, 0, ADM1278_PEAK_TEMP, 0);
>  		break;
> +	case PMBUS_VIRT_POWER_SAMPLES:
> +		word = clamp_val(word, 1, ADM1275_SAMPLES_AVG_MAX);
> +		ret = adm1275_write_pmon_config(client, ADM1275_PWR_AVG_MASK,
> +						ilog2(word));
> +		break;
> +	case PMBUS_VIRT_IN_SAMPLES:
> +	case PMBUS_VIRT_CURR_SAMPLES:
> +		word = clamp_val(word, 1, ADM1275_SAMPLES_AVG_MAX);
> +		ret = adm1275_write_pmon_config(client, ADM1275_VI_AVG_MASK,
> +						ilog2(word));
> +		break;
>  	default:
>  		ret = -ENODATA;
>  		break;
> @@ -422,6 +485,8 @@ static int adm1275_probe(struct i2c_client *client,
>  	if (!data)
>  		return -ENOMEM;
>  
> +	mutex_init(&data->lock);
> +
>  	if (of_property_read_u32(client->dev.of_node,
>  				 "shunt-resistor-micro-ohms", &shunt))
>  		shunt = 1000; /* 1 mOhm if not set via DT */
> @@ -439,7 +504,8 @@ static int adm1275_probe(struct i2c_client *client,
>  	info->format[PSC_CURRENT_OUT] = direct;
>  	info->format[PSC_POWER] = direct;
>  	info->format[PSC_TEMPERATURE] = direct;
> -	info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
> +	info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +			PMBUS_HAVE_SAMPLES;
>  
>  	info->read_word_data = adm1275_read_word_data;
>  	info->read_byte_data = adm1275_read_byte_data;
> -- 
> 2.20.1
> 
