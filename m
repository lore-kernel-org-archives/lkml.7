Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A831C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AAE20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gma/1wB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbfDQNqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:46:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41618 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQNqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:46:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so12058769plj.8;
        Wed, 17 Apr 2019 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VLDmq67Pulu5jqUpk3um5ILaGvV5qHO65zeQTS5srK0=;
        b=gma/1wB7w3rD5+KrDw7qbj5JxZhFiyvQ5t10Nb6EKM8ZT6xweW0uPlQ/2C59FtlvWH
         hzuvGGMCyajYfauAr4ofzrNrvQ7UTxml5Dyz158tCG8dmOJUU50BbmUdlCB5BYJYoyNK
         lrep+c6TXuSvYJl/QQzaX5PqMJTG06e02FRyT0rwdzcAyI+PDREGOr+LOAsoreZoj/Sv
         k/JZxRzVNpVLL+ncwLtvBN7MGgtZTdrutsBoBRF07OHZ/HAq7qOCFXeOsKdY7dSMVYlN
         i5OHtGvXgyvS4cQfNbSp9TlRlNSiDcr+0AVwKfHivYIDxqSBHFHyKOJEu1S3d3avwH6p
         XbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VLDmq67Pulu5jqUpk3um5ILaGvV5qHO65zeQTS5srK0=;
        b=lfgaTrX4UvLTq665M5CUf6dWoRjhg/lz22DjLIrYR/ZZ/zqd5sUCugKQGSFwQiQw3q
         fcVKajwy1oTxxYBVnCxOFqm1bS6i81Bt8EVYXpvW+ivgDEoBXuOeMEH8ThsJLqcJo0w8
         fVir0YHI1INo1VcuYsqtzyhWWkRfr1kDR8YuiE4qajxUt126Jy/PBOK4yCWOz/85XLkN
         ZfB1Sy/wXNlKkC2PT9iLvwcXBGPsGjb4+HbNnk7B2vS4C9GpBHMz4R606CHZLLYRWCOk
         R2k5MsHlXv+Pw3TKZ+3N595mDfoyr179PZbw6TSXhsbokrSlkK2lnxgZl4B+XmQbOPMf
         Y3uA==
X-Gm-Message-State: APjAAAWjEkfhA3gK0KtLuYl7W15XgGssE3g5j/ZSuekvq382g6CSvViz
        IuTcKuTGu5PbGtDKytfjqsEHhTIl
X-Google-Smtp-Source: APXvYqwRZrvhh9s3MhhfD7FaVeNhX5h2bJe2EbdiK46S/s5Q/pIQDSOZi6Cj0YmijSJ6s5jl1vvolQ==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr47345550pla.137.1555508812678;
        Wed, 17 Apr 2019 06:46:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b3sm75157478pfi.82.2019.04.17.06.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 06:46:51 -0700 (PDT)
Subject: Re: [PATCH] hwmon: (ina3221) Add voltage conversion time settings
To:     Nicolin Chen <nicoleotsuka@gmail.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
References: <20190416235548.22733-1-nicoleotsuka@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1ad27385-e62a-d4f0-2590-c50458119f12@roeck-us.net>
Date:   Wed, 17 Apr 2019 06:46:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416235548.22733-1-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 4:55 PM, Nicolin Chen wrote:
> The CONFIG register has two 3-bit fields for conversion time
> settings of Bus-voltage and Shunt-voltage, respectively. The
> conversion settings, along with averaging mode, allow users
> to optimize available timing requirement.
> 
> This patch adds an 'update_interval' sysfs node through the
> hwmon_chip_info of hwmon core. It reflects a total hardware
> conversion time:
>      samples * channels * (Bus + Shunt conversion times)
> 
> Though INA3221 supports different conversion time setups for
> Bus and Shunt voltages, this patch only adds the support of
> a unified setting for both conversion times, by dividing the
> conversion time into two equal values.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> 
> Hi Guenter,
> 
> I am not quite sure if this update_interval is the best way to
> implement the conversion time settings but I can't find another
> common approach. This implementation certainly has drawbacks:
>   1) It can't configure Bus and Shunt conversion times separately
>      (Not crucial for me at this point as I set them equally)
>   2) Users need to calculate for the settings of conversion time
>   3) The ABI defines update_interval in msec while the hardware
>      and datasheet does in usec, and that generates rounding diff
>   4) The update_interval value would be spontaneously modified
>      everytime number of samples or number of enabled channels
>      gets changed. This might confuses users who tries to have
>      a fixed update_interval other than really merely setting
>      conversion time.
> 
> I see IIO subsystem have something like IIO_CHAN_INFO_INT_TIME
> for conversion time setting exclusively. Do we have something
> similar under hwmon?
> 

No. I think what you have should be good enough for now.
Please see comments below.

Thanks,
Guenter

> Thanks
> 
>   Documentation/hwmon/ina3221 |  9 +++++
>   drivers/hwmon/ina3221.c     | 65 ++++++++++++++++++++++++++++++++-----
>   2 files changed, 65 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
> index ed3f22769d4b..3b05170112f0 100644
> --- a/Documentation/hwmon/ina3221
> +++ b/Documentation/hwmon/ina3221
> @@ -38,3 +38,12 @@ in[456]_input           Shunt voltage(uV) for channels 1, 2, and 3 respectively
>   samples                 Number of samples using in the averaging mode.
>                             Supports the list of number of samples:
>                             1, 4, 16, 64, 128, 256, 512, 1024
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
> index 74d39d212931..af4ab8ddddce 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -144,19 +144,37 @@ static const int ina3221_avg_samples[] = {
>   	1, 4, 16, 64, 128, 256, 512, 1024,
>   };
>   
> -static inline int ina3221_wait_for_data(struct ina3221_data *ina)
> +/* Converting update_interval in msec to conversion time in usec */
> +static inline u32 ina3221_interval_ms_to_conv_time(u16 config, int interval)
>   {
> -	u32 channels = hweight16(ina->reg_config & INA3221_CONFIG_CHs_EN_MASK);
> -	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(ina->reg_config);
> -	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(ina->reg_config);
> -	u32 samples_idx = INA3221_CONFIG_AVG(ina->reg_config);
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
> +{
> +	u32 channels = hweight16(config & INA3221_CONFIG_CHs_EN_MASK);
> +	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(config);
> +	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(config);
> +	u32 samples_idx = INA3221_CONFIG_AVG(config);
>   	u32 samples = ina3221_avg_samples[samples_idx];
>   	u32 vbus_ct = ina3221_conv_time[vbus_ct_idx];
>   	u32 vsh_ct = ina3221_conv_time[vsh_ct_idx];
> -	u32 wait, cvrf;
>   
>   	/* Calculate total conversion time */
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
>   	/* Polling the CVRF bit to make sure read data is ready */
>   	return regmap_field_read_poll_timeout(ina->fields[F_CVRF],
> @@ -197,6 +215,11 @@ static int ina3221_read_chip(struct device *dev, u32 attr, long *val)
>   		regval = INA3221_CONFIG_AVG(ina->reg_config);
>   		*val = ina3221_avg_samples[regval];
>   		return 0;
> +	case hwmon_chip_update_interval:
> +		/* Return in msec */
> +		*val = ina3221_reg_to_interval_us(ina->reg_config);
> +		*val = DIV_ROUND_CLOSEST(*val, 1000);
> +		return 0;
>   	default:
>   		return -EOPNOTSUPP;
>   	}
> @@ -308,7 +331,7 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
>   static int ina3221_write_chip(struct device *dev, u32 attr, long val)
>   {
>   	struct ina3221_data *ina = dev_get_drvdata(dev);
> -	int ret, idx;
> +	int ret, idx, tmp;
>   
>   	switch (attr) {
>   	case hwmon_chip_samples:
> @@ -321,6 +344,28 @@ static int ina3221_write_chip(struct device *dev, u32 attr, long val)
>   		if (ret)
>   			return ret;
>   
> +		/* Update reg_config accordingly */
> +		return regmap_read(ina->regmap, INA3221_CONFIG,
> +				   &ina->reg_config);
> +	case hwmon_chip_update_interval:
> +		tmp = ina3221_interval_ms_to_conv_time(ina->reg_config, val);
> +		idx = find_closest(tmp, ina3221_conv_time,
> +				   ARRAY_SIZE(ina3221_conv_time));
> +
> +		/* Update Bus-voltage conversion time */
> +		ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
> +					 INA3221_CONFIG_VBUS_CT_MASK,
> +					 idx << INA3221_CONFIG_VBUS_CT_SHIFT);
> +		if (ret)
> +			return ret;
> +
> +		/* Update Shunt-voltage conversion time */
> +		ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
> +					 INA3221_CONFIG_VSH_CT_MASK,
> +					 idx << INA3221_CONFIG_VSH_CT_SHIFT);
> +		if (ret)
> +			return ret;

It should be possible to update both conversion times with a single call,
since both calls touch only one register. Something like

		ret = regmap_update_bits(ina->regmap, INA3221_CONFIG
			INA3221_CONFIG_VBUS_CT_MASK | INA3221_CONFIG_VSH_CT_MASK,
			(idx << INA3221_CONFIG_VBUS_CT_SHIFT) | (idx << INA3221_CONFIG_VSH_CT_SHIFT));

Granted, that is a bit long, but it saves an extra i2c write operation.

> +
>   		/* Update reg_config accordingly */
>   		return regmap_read(ina->regmap, INA3221_CONFIG,
>   				   &ina->reg_config);
> @@ -482,6 +527,7 @@ static umode_t ina3221_is_visible(const void *drvdata,
>   	case hwmon_chip:
>   		switch (attr) {
>   		case hwmon_chip_samples:
> +		case hwmon_chip_update_interval:
>   			return 0644;
>   		default:
>   			return 0;
> @@ -527,7 +573,8 @@ static umode_t ina3221_is_visible(const void *drvdata,
>   
>   static const struct hwmon_channel_info *ina3221_info[] = {
>   	HWMON_CHANNEL_INFO(chip,
> -			   HWMON_C_SAMPLES),
> +			   HWMON_C_SAMPLES,
> +			   HWMON_C_UPDATE_INTERVAL),
>   	HWMON_CHANNEL_INFO(in,
>   			   /* 0: dummy, skipped in is_visible */
>   			   HWMON_I_INPUT,
> 

