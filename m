Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67DAC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B4C2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df8hz9ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfCLWiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:38:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43838 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfCLWiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:38:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so2854609pfh.10;
        Tue, 12 Mar 2019 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UykSa0CBEPUem0AbxJYF2Dlvbvu24y1KIIhaADlP1+Y=;
        b=Df8hz9riEjR4HlxcjRyRn/ocH2RVMJ58pBhcC2qD7+4m9Fz7gH4ogZMG9oSu0pcENO
         q1kymOjBqcMCozQOr4RhePPqDfoPfEpc/RE98oYHJUUjOd7uSHxa1VOG5xp/nWmqLvep
         /O/UN8FvfhpWNITYhobg2rozgIGII5h9uwdqecAdF91DkQc8g6X9XCNDLqJbkx9JPavq
         cvHO34ydiPAYmUdkukLFjItIPQC/exLIHlF62zMjVIa51uiZ4KoF3srG/6P9aS3PRvEl
         pxlDKb7kyWWH3kVb90hpwpsb3LLW2AAu502fxb6mgkXVD3jWMqJ2TcGBzfhemvHsgmQW
         rpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UykSa0CBEPUem0AbxJYF2Dlvbvu24y1KIIhaADlP1+Y=;
        b=pdT5a2bVhvNYH8MRu7UDxjk0r6ciUKW1fUsbeKcTpoBSsK8QR2RyXx5SsqKcsTumrF
         fQcY+Dynr+V1XgwNf2nQkr9bjriXINyNlgi1FJJ0lS/3S6xSq7vCvYerSHI8rZeXQhQF
         H9ZGAKL0bgI4KpNyQi2uUFH6yq2olDZy1JBK6z4swjeR58BlW9orBpJ2d1WgGrrPwnKl
         EvT18xm875xnqkdJ2IZdHtxXPTkdLFhvI0vMqaD7D6EnNB0cpzkQCUk52bueGeV5CBp4
         QMtEfEooAUXcJQ0idmYPIzroEmGSRkMVvffd+WgXTxJLxHvwTJh1JMYDifstV5AK30DL
         uNTA==
X-Gm-Message-State: APjAAAWDYKXqD0Abv/Ft6kiu7XZYVC1xgILp56erm5Epcd7ffGSRmFnF
        7eINz55TBuzdnra8qR/+2SY=
X-Google-Smtp-Source: APXvYqwcqePWrb/7HT5HrjT82TfnbIPqCIgnqho4+1/GP5EYkR8R8Pp5AvfK0bsWXVV4dLUhxBi7hg==
X-Received: by 2002:a63:4718:: with SMTP id u24mr37740472pga.381.1552430281710;
        Tue, 12 Mar 2019 15:38:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x19sm12941336pfm.108.2019.03.12.15.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 15:38:00 -0700 (PDT)
Date:   Tue, 12 Mar 2019 15:37:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina3221) Add averaging mode support
Message-ID: <20190312223759.GA31590@roeck-us.net>
References: <20190312220431.26710-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312220431.26710-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 03:04:31PM -0700, Nicolin Chen wrote:
> The CONFIG register has a 3-bit averaging mode field for users
> to setup the number of samples that are collected and averaged
> together. This is very useful to filter noise from sensor data.
> 
> This patch adds an 'average' sysfs node, and updates wait time
> calculation by taking this average value into account.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  Documentation/hwmon/ina3221 |  2 ++
>  drivers/hwmon/ina3221.c     | 61 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
> index 4b82cbfb551c..1e25be009d24 100644
> --- a/Documentation/hwmon/ina3221
> +++ b/Documentation/hwmon/ina3221
> @@ -35,3 +35,5 @@ curr[123]_max           Warning alert current(mA) setting, activates the
>                            average is above this value.
>  curr[123]_max_alarm     Warning alert current limit exceeded
>  in[456]_input           Shunt voltage(uV) for channels 1, 2, and 3 respectively
> +average                 Averaging mode. Supports the list of number of samples:
> +                          1, 4, 16, 64, 128, 256, 512, 1024

This is the number of samples, so I think "samples" would be a better
attribute name. This would also avoid confusion with other _average
attributes.

I'll need to check with other chips if this is the best approach and
name for the attribute, especially to see if it should be chip-wide
or per sensor.

> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index 3626b87a5fd2..259c192427ac 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -51,6 +51,9 @@
>  #define INA3221_CONFIG_VBUS_CT_SHIFT	6
>  #define INA3221_CONFIG_VBUS_CT_MASK	GENMASK(8, 6)
>  #define INA3221_CONFIG_VBUS_CT(x)	(((x) & GENMASK(8, 6)) >> 6)
> +#define INA3221_CONFIG_AVG_SHIFT	9
> +#define INA3221_CONFIG_AVG_MASK		GENMASK(11, 9)
> +#define INA3221_CONFIG_AVG(x)		(((x) & GENMASK(11, 9)) >> 9)
>  #define INA3221_CONFIG_CHs_EN_MASK	GENMASK(14, 12)
>  #define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
>  
> @@ -135,17 +138,24 @@ static const u16 ina3221_conv_time[] = {
>  	140, 204, 332, 588, 1100, 2116, 4156, 8244,
>  };
>  
> +/* Lookup table for averaging rates */
> +static const int ina3221_avg[] = {
> +	1, 4, 16, 64, 128, 256, 512, 1024,
> +};
> +
>  static inline int ina3221_wait_for_data(struct ina3221_data *ina)
>  {
>  	u32 channels = hweight16(ina->reg_config & INA3221_CONFIG_CHs_EN_MASK);
>  	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(ina->reg_config);
>  	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(ina->reg_config);
> +	u32 avg_idx = INA3221_CONFIG_AVG(ina->reg_config);
>  	u32 vbus_ct = ina3221_conv_time[vbus_ct_idx];
>  	u32 vsh_ct = ina3221_conv_time[vsh_ct_idx];
> +	u32 avg = ina3221_avg[avg_idx];
>  	u32 wait, cvrf;
>  
>  	/* Calculate total conversion time */
> -	wait = channels * (vbus_ct + vsh_ct);
> +	wait = channels * (vbus_ct + vsh_ct) * avg;
>  
>  	/* Polling the CVRF bit to make sure read data is ready */
>  	return regmap_field_read_poll_timeout(ina->fields[F_CVRF],
> @@ -545,15 +555,64 @@ static ssize_t ina3221_shunt_store(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t ina3221_avg_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	u32 avg_idx = INA3221_CONFIG_AVG(ina->reg_config);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", ina3221_avg[avg_idx]);
> +}
> +
> +static ssize_t ina3221_avg_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	int ret, avg, i;
> +
> +	ret = kstrtoint(buf, 0, &avg);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(ina3221_avg); i++)
> +		if (ina3221_avg[i] == avg)
> +			break;

Please use find_closest().

> +
> +	if (i == ARRAY_SIZE(ina3221_avg))
> +		return -EINVAL;
> +
> +	mutex_lock(&ina->lock);
> +
> +	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
> +				 INA3221_CONFIG_AVG_MASK,
> +				 i << INA3221_CONFIG_AVG_SHIFT);
> +	if (ret)
> +		goto unlock;
> +
> +	/* Update reg_config accordingly */
> +	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
> +	if (ret)
> +		goto unlock;
> +
> +unlock:
> +	mutex_unlock(&ina->lock);
> +
> +	return ret ? ret : count;
> +}
> +
>  /* shunt resistance */
>  static SENSOR_DEVICE_ATTR_RW(shunt1_resistor, ina3221_shunt, INA3221_CHANNEL1);
>  static SENSOR_DEVICE_ATTR_RW(shunt2_resistor, ina3221_shunt, INA3221_CHANNEL2);
>  static SENSOR_DEVICE_ATTR_RW(shunt3_resistor, ina3221_shunt, INA3221_CHANNEL3);
> +/* averaging mode */
> +static SENSOR_DEVICE_ATTR_RW(average, ina3221_avg, 0);
>  
>  static struct attribute *ina3221_attrs[] = {
>  	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
>  	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
>  	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
> +	&sensor_dev_attr_average.dev_attr.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(ina3221);
> -- 
> 2.17.1
> 
