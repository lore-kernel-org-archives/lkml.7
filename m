Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D20C04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1CF20873
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6ybAWNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfEGNzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:55:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40243 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfEGNzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:55:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so8232578plr.7;
        Tue, 07 May 2019 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W9mmQAVmk1/1WRGRy8uFuq4PJRvCk5WRbIKsqF6QNjM=;
        b=P6ybAWNQyD1YpEGOcJiN5tx6vzTMqtcdSSwpC5VGv2sLVtDQjlpFqlB/UyjWAGbIS3
         QqqTZjJ+rXRg8xHgpgWaBiGnlTSPjmTD2x6Wl8rzL/QJJm9DLlNZovO2J27QSCXZ6vaf
         W6eL6mA9KD0MNSdHxWTchPpnEWfbNE0WPQSNrURfG1ECr31fNfaUEL/DDv0wIDFdiYOK
         Bv9kJs5EtZ6LYGeYtnkvmdy8r1BQDZETrkP9TEPrpka7I4Gv4hDbjdiliTi26uOJyB3i
         hUWfKcryJFZCqW+OutKd3L+/2N/d39FAb/0PBKuzKfD/fs0MpZsA4uB1OjDp3pGDayua
         XApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W9mmQAVmk1/1WRGRy8uFuq4PJRvCk5WRbIKsqF6QNjM=;
        b=nRQ1ehujhFNuYcnlkYCwMY7BmEGNZLcrPCIj7UcmX+iI8ejyvKxSM8qwJPx8b0q8Ol
         GxB71i7Y96IMlWtWLy8Xw46cpRkaTZq4q5m/R+IYo5SssQLcw0FxUCa3jRrDd23JMuBY
         ly6PB7+j8l0L8mAXaaHh/qp9dvIAQ7xGV+5wpdHFr6Y8HmcopW5aDRVzVzGEykJPkwdN
         qiZUqoZCw7WnZvt8OF/OJb5K1YDHnQfTbZEghA4xdXRsAtP0Hz1SyW7cTi+xJHOZB8Yp
         1AfBL6rn+VHUOpCzVbE2ssGurbnmEpucgzAiFxI9gTHLq3q+fPDIrJ65BMZn90KGG68X
         XkhQ==
X-Gm-Message-State: APjAAAX+B9ctIhmBGDfbIgEIMyHnl7UQfNX988sx9ZQQPGxgkYdP4N2y
        OD0jy7/jrUhrJmgvgmGZ2eVlduSn
X-Google-Smtp-Source: APXvYqz/Zkrl14vnslnQR8IBibK0hvVcuftBry4tRHN1LUOlfPu5i8kFvuS53+UxvCxZ2gPSRkKVkw==
X-Received: by 2002:a17:902:5c6:: with SMTP id f64mr26385253plf.208.1557237343851;
        Tue, 07 May 2019 06:55:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i75sm24693400pfj.80.2019.05.07.06.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 06:55:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] hwmon: scmi: Scale values to target desired HWMON
 units
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
References: <20190506224109.9357-1-f.fainelli@gmail.com>
 <20190506224109.9357-3-f.fainelli@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a4dd5f4f-af12-8783-c612-cf3e88a9b94f@roeck-us.net>
Date:   Tue, 7 May 2019 06:55:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506224109.9357-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On 5/6/19 3:41 PM, Florian Fainelli wrote:
> If the SCMI firmware implementation is reporting values in a scale that
> is different from the HWMON units, we need to scale up or down the value
> according to how far appart they are.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   drivers/hwmon/scmi-hwmon.c | 55 +++++++++++++++++++++++++++++++-------
>   1 file changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index a80183a488c5..e9913509cb88 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -18,6 +18,51 @@ struct scmi_sensors {
>   	const struct scmi_sensor_info **info[hwmon_max];
>   };
>   
> +static enum hwmon_sensor_types scmi_types[] = {
> +	[TEMPERATURE_C] = hwmon_temp,
> +	[VOLTAGE] = hwmon_in,
> +	[CURRENT] = hwmon_curr,
> +	[POWER] = hwmon_power,
> +	[ENERGY] = hwmon_energy,
> +};
> +
> +static u64 scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 value)
> +{
> +	u64 scaled_value = value;

I don't think that variable is necessary.

> +	s8 desired_scale;

Just scale ? Also, you could assign scale here directly, and subtract
the offset below. Then "n" would not be necessary.
Such as
	s8 scale = sensor->scale;	// assuming scale is s8
	...
	case CURRENT:
		scale += 3;
	...

That would also be less confusing, since it would avoid the double
negation.

> +	int n, p;

> +
> +	switch (sensor->type) {
> +	case TEMPERATURE_C:
> +	case VOLTAGE:
> +	case CURRENT:
> +		/* fall through */
Unnecessary comment

> +		desired_scale = -3;
> +		break;
> +	case POWER:
> +	case ENERGY:
> +		/* fall through */
Unnecessary comment.

> +		desired_scale = -6;
> +		break;
> +	default:
> +		return scaled_value;

Here we presumably want a scale of 0. However, if the scale passed
from SCMI is, say, -5 or +5, we return the original (unadjusted)
value. Seems to me we would still want to adjust the value to match
hwmon expectations. Am I missing something ?

> +	}
> +
> +	n = (s8)sensor->scale - desired_scale;
> +        if (n == 0)

Indentation seems off here.

> +                return scaled_value;
> +
> +	for (p = 0; p < abs(n); p++) {
> +		/* Need to scale up from sensor to HWMON */
> +		if (n > 0)
> +			scaled_value *= 10;
> +		else
> +			do_div(scaled_value, 10);
> +	}

Something like

	factor = pow10(abs(scale));
	if (scale > 0)
		value *= factor;
	else
		do_div(value, factor);

would avoid the repeated abs() and do_div(). Unfortunately there is
no pow10() helper, so you would have to write that. Still, I think
that would be much more efficient.

Thanks,
Guenter

> +
> +        return scaled_value;
> +}
> +
>   static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>   			   u32 attr, int channel, long *val)
>   {
> @@ -30,7 +75,7 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>   	sensor = *(scmi_sensors->info[type] + channel);
>   	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
>   	if (!ret)
> -		*val = value;
> +		*val = scmi_hwmon_scale(sensor, value);
>   
>   	return ret;
>   }
> @@ -91,14 +136,6 @@ static int scmi_hwmon_add_chan_info(struct hwmon_channel_info *scmi_hwmon_chan,
>   	return 0;
>   }
>   
> -static enum hwmon_sensor_types scmi_types[] = {
> -	[TEMPERATURE_C] = hwmon_temp,
> -	[VOLTAGE] = hwmon_in,
> -	[CURRENT] = hwmon_curr,
> -	[POWER] = hwmon_power,
> -	[ENERGY] = hwmon_energy,
> -};
> -
>   static u32 hwmon_attributes[] = {
>   	[hwmon_chip] = HWMON_C_REGISTER_TZ,
>   	[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
> 

