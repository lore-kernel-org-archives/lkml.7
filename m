Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E5EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3CF20674
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dACY2WLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389027AbfDRNpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:45:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40757 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388263AbfDRNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:45:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so1229632pgl.7;
        Thu, 18 Apr 2019 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ERIN0ZDeFPChco92LNU+j6MjTlKTGi0GeGyWd/t58BM=;
        b=dACY2WLgi+ok9Gz7GZogUCyHmuYSwt35M9wPX/VMB84uUFoyBBJbUo0hV8iqJUVpbq
         8RK00TviQYDZYvHRmZ2k6xvGFxRgbEHUIiu5FSy/HRRUZkiHOUj26sgMKVW22HL5NAvR
         GA3066KlD4svi7QmfrfGH3WTmTAXCnpPewH/T5nq3mcFyqWf21oVfJFoCSkjUjjYXWxt
         WgNaAiXbn7W0/MWi43jGHz6CU8LjA2+a8XTbKzhEjoephNPVI4ugYx6hxb+EzsHqa42J
         EMT2mfwuxUo9BbBVWVeO6w8VV+9DaUUN00hqUKb7BmyUw6c6BDYsuNodoEmabO8apV90
         8/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ERIN0ZDeFPChco92LNU+j6MjTlKTGi0GeGyWd/t58BM=;
        b=lVWJNgT5Pr51ZlE6mVdbf4sCXfqwfcArBTZH63R7EU7o3LUxWS2VnhEg/uvDYOsZcN
         VYdP6rQiSJCg9DvQaNNyg/zUpvnoYWE1k2BoKstb4Oz/yQAyo+uszfzcF8zXuRl2Dlhy
         OKWNkKvEZ+XVeW4jeE1TKiSZDjAOINrvQLf46maHqps4KeeUbyyQ4Z1V44A/ou52HyaG
         ONho0JI1LVpmsLUQ5Eyx1o9V4wQziiQzihy4IJrUI5L4vmhdrkp12w8H8oE/CTWNa0AU
         pMxH3wmdUsGtiUDya474J+ZEjbaTbvVRLsY0d09eH0hT37Cv1Kfj0PpxcaTrLluRpYk9
         3EdA==
X-Gm-Message-State: APjAAAXb+dvXv3/0cPrAMVCbeWtQQwTpiexdJOFBA9YKeN0a9qfeiee+
        XxFamyy3yHjD6Z9KsoW46bs=
X-Google-Smtp-Source: APXvYqxGj+XxLK84Ggmo3JK//tNnsWSHD7AifT0oNYTYY9ZyZm5rmyOryXoScTzYV+aoKzlymUbJmA==
X-Received: by 2002:a62:4554:: with SMTP id s81mr68175071pfa.66.1555595134119;
        Thu, 18 Apr 2019 06:45:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f87sm3957882pff.56.2019.04.18.06.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:45:32 -0700 (PDT)
Date:   Thu, 18 Apr 2019 06:45:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (ina3221) Add voltage conversion time
 settings
Message-ID: <20190418134531.GA20851@roeck-us.net>
References: <20190417231210.5762-1-nicoleotsuka@gmail.com>
 <20190417231210.5762-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417231210.5762-3-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:12:10PM -0700, Nicolin Chen wrote:
> The CONFIG register has two 3-bit fields for conversion time
> settings of Bus-voltage and Shunt-voltage, respectively. The
> conversion settings, along with averaging mode, allow users
> to optimize available timing requirement.
> 
> This patch adds an 'update_interval' sysfs node through the
> hwmon_chip_info of hwmon core. It reflects a total hardware
> conversion time:
>     samples * channels * (Bus + Shunt conversion times)
> 
> Though INA3221 supports different conversion time setups for
> Bus and Shunt voltages, this patch only adds the support of
> a unified setting for both conversion times, by dividing the
> conversion time into two equal values.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Applied to -next. I had to update the documentation for the .rst formatting
changes. Hope I got it right.

Thanks,
Guenter

> ---
> Changelog
> v1->v2:
>  * Merged two adjacent calls of regmap_update_bits().
>  * Replaced CONFIG register read-back with tmp variable
> 
>  Documentation/hwmon/ina3221 |  9 ++++++
>  drivers/hwmon/ina3221.c     | 58 ++++++++++++++++++++++++++++++++-----
>  2 files changed, 59 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
> index ed3f22769d4b..3b05170112f0 100644
> --- a/Documentation/hwmon/ina3221
> +++ b/Documentation/hwmon/ina3221
> @@ -38,3 +38,12 @@ in[456]_input           Shunt voltage(uV) for channels 1, 2, and 3 respectively
>  samples                 Number of samples using in the averaging mode.
>                            Supports the list of number of samples:
>                            1, 4, 16, 64, 128, 256, 512, 1024
> +update_interval         Data conversion time in millisecond, following:
> +                          update_interval = C x S x (BC + SC)
> +                              C: number of enabled channels
> +                              S: number of samples
> +                             BC: bus-voltage conversion time in millisecond
> +                             SC: shunt-voltage conversion time in millisecond
> +                          Affects both Bus- and Shunt-voltage conversion time.
> +                          Note that setting update_interval to 0ms sets both BC
> +                          and SC to 140 us (minimum conversion time).
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index 62040aac653c..e0637fed9585 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -144,19 +144,37 @@ static const int ina3221_avg_samples[] = {
>  	1, 4, 16, 64, 128, 256, 512, 1024,
>  };
>  
> -static inline int ina3221_wait_for_data(struct ina3221_data *ina)
> +/* Converting update_interval in msec to conversion time in usec */
> +static inline u32 ina3221_interval_ms_to_conv_time(u16 config, int interval)
> +{
> +	u32 channels = hweight16(config & INA3221_CONFIG_CHs_EN_MASK);
> +	u32 samples_idx = INA3221_CONFIG_AVG(config);
> +	u32 samples = ina3221_avg_samples[samples_idx];
> +
> +	/* Bisect the result to Bus and Shunt conversion times */
> +	return DIV_ROUND_CLOSEST(interval * 1000 / 2, channels * samples);
> +}
> +
> +/* Converting CONFIG register value to update_interval in usec */
> +static inline u32 ina3221_reg_to_interval_us(u16 config)
>  {
> -	u32 channels = hweight16(ina->reg_config & INA3221_CONFIG_CHs_EN_MASK);
> -	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(ina->reg_config);
> -	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(ina->reg_config);
> -	u32 samples_idx = INA3221_CONFIG_AVG(ina->reg_config);
> +	u32 channels = hweight16(config & INA3221_CONFIG_CHs_EN_MASK);
> +	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(config);
> +	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(config);
> +	u32 samples_idx = INA3221_CONFIG_AVG(config);
>  	u32 samples = ina3221_avg_samples[samples_idx];
>  	u32 vbus_ct = ina3221_conv_time[vbus_ct_idx];
>  	u32 vsh_ct = ina3221_conv_time[vsh_ct_idx];
> -	u32 wait, cvrf;
>  
>  	/* Calculate total conversion time */
> -	wait = channels * (vbus_ct + vsh_ct) * samples;
> +	return channels * (vbus_ct + vsh_ct) * samples;
> +}
> +
> +static inline int ina3221_wait_for_data(struct ina3221_data *ina)
> +{
> +	u32 wait, cvrf;
> +
> +	wait = ina3221_reg_to_interval_us(ina->reg_config);
>  
>  	/* Polling the CVRF bit to make sure read data is ready */
>  	return regmap_field_read_poll_timeout(ina->fields[F_CVRF],
> @@ -197,6 +215,11 @@ static int ina3221_read_chip(struct device *dev, u32 attr, long *val)
>  		regval = INA3221_CONFIG_AVG(ina->reg_config);
>  		*val = ina3221_avg_samples[regval];
>  		return 0;
> +	case hwmon_chip_update_interval:
> +		/* Return in msec */
> +		*val = ina3221_reg_to_interval_us(ina->reg_config);
> +		*val = DIV_ROUND_CLOSEST(*val, 1000);
> +		return 0;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -322,6 +345,23 @@ static int ina3221_write_chip(struct device *dev, u32 attr, long val)
>  		if (ret)
>  			return ret;
>  
> +		/* Update reg_config accordingly */
> +		ina->reg_config = tmp;
> +		return 0;
> +	case hwmon_chip_update_interval:
> +		tmp = ina3221_interval_ms_to_conv_time(ina->reg_config, val);
> +		idx = find_closest(tmp, ina3221_conv_time,
> +				   ARRAY_SIZE(ina3221_conv_time));
> +
> +		/* Update Bus and Shunt voltage conversion times */
> +		tmp = INA3221_CONFIG_VBUS_CT_MASK | INA3221_CONFIG_VSH_CT_MASK;
> +		tmp = (ina->reg_config & ~tmp) |
> +		      (idx << INA3221_CONFIG_VBUS_CT_SHIFT) |
> +		      (idx << INA3221_CONFIG_VSH_CT_SHIFT);
> +		ret = regmap_write(ina->regmap, INA3221_CONFIG, tmp);
> +		if (ret)
> +			return ret;
> +
>  		/* Update reg_config accordingly */
>  		ina->reg_config = tmp;
>  		return 0;
> @@ -483,6 +523,7 @@ static umode_t ina3221_is_visible(const void *drvdata,
>  	case hwmon_chip:
>  		switch (attr) {
>  		case hwmon_chip_samples:
> +		case hwmon_chip_update_interval:
>  			return 0644;
>  		default:
>  			return 0;
> @@ -528,7 +569,8 @@ static umode_t ina3221_is_visible(const void *drvdata,
>  
>  static const struct hwmon_channel_info *ina3221_info[] = {
>  	HWMON_CHANNEL_INFO(chip,
> -			   HWMON_C_SAMPLES),
> +			   HWMON_C_SAMPLES,
> +			   HWMON_C_UPDATE_INTERVAL),
>  	HWMON_CHANNEL_INFO(in,
>  			   /* 0: dummy, skipped in is_visible */
>  			   HWMON_I_INPUT,
