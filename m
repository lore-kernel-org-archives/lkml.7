Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16006C04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94C7205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjZeETvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEGXl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 19:41:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34616 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGXl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 19:41:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck18so8948606plb.1;
        Tue, 07 May 2019 16:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6S43puIWlKpo3l0ctTYo9CwnfuvXVXnPWjkU3LnYrYE=;
        b=GjZeETvJT+eTWZ1uhPcJw7Bco8Ytbnq5Ktg3NTxlpUZBqTga93GcdN2/9ngvD/6dcR
         wSdJarS82zLEtv+15PpZwSzBaLZNI5NgBVmRGnYwfukvjjO+sPldzkBKeHcZl1499w8y
         FUxjc27cnAM2BwgvaxkDFedwHnI9x91/xkIfk2jgFMp48c9c95ZrVGtTRRdUsDRe0as/
         EiVWzqVG1BXnHnI1xyQhCDkeBV650Esz+Em4N2UsfBTuv9qku+0E2m3gCLfyTQFGZpIU
         gTUArMIb28nXA5QKC2GfnyXDKGNSqjtdqDRQwinPl51JXDJrc7BncgukshFwUma73Knj
         n1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6S43puIWlKpo3l0ctTYo9CwnfuvXVXnPWjkU3LnYrYE=;
        b=Dcqhy/OP0DM+hL2fM2yabWDLgUK7tVyKGgs0yaujYP3cSaCvGStHE69ZbHd5w2DpzG
         rN2zGVbm4BvANB3VyMzbsrCNw0MUVLha+3XhSYZ1ojiT8lzFEzCwo0ycnQqHBxP7APjA
         c1OzMkJtb7Hb+3RWD+pOj/mn8IExqUSzJ4SaN0lyFUbpuhoHE1bKEwl1geln4dzIqU4E
         7wAATPXoKF8PuiJW445KQuy5sYVDBxIFyGgsNPj4gNQpnXJ23ncaUhfZbSDA+b91EY8t
         RLaA2o7pn9MtJLnmsDB5bHKzyGnDrizH3tulClx579NcpPZ613o2EQ1jf8XDIRuEgwiD
         +Y4w==
X-Gm-Message-State: APjAAAXYbltNC2b3t1m0O/0FlurYC2B4pBsozI69eDPlv3L5jHTrc/lR
        3T/a4w4ybetxeWtRGg+fR9KR2gkG
X-Google-Smtp-Source: APXvYqxccXn8zrgvQZyT7s/F9BOzQU9Kx3XQQw3HZ0E/XS1FVv/mBe9nJlyrYN/apNwFQfaXSQNwUA==
X-Received: by 2002:a17:902:bc83:: with SMTP id bb3mr41252727plb.303.1557272517350;
        Tue, 07 May 2019 16:41:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h189sm24700224pfc.125.2019.05.07.16.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 16:41:55 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] hwmon: scmi: Scale values to target desired HWMON
 units
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
References: <20190507230917.21659-1-f.fainelli@gmail.com>
 <20190507230917.21659-3-f.fainelli@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <690aff21-d68c-7d62-071f-ba1c9502e5ac@roeck-us.net>
Date:   Tue, 7 May 2019 16:41:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507230917.21659-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/19 4:09 PM, Florian Fainelli wrote:
> If the SCMI firmware implementation is reporting values in a scale that
> is different from the HWMON units, we need to scale up or down the value
> according to how far appart they are.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   drivers/hwmon/scmi-hwmon.c | 43 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index a80183a488c5..7820854e5954 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -18,6 +18,47 @@ struct scmi_sensors {
>   	const struct scmi_sensor_info **info[hwmon_max];
>   };
>   
> +static inline u64 __pow10(u8 x)
> +{
> +	u64 r = 1;
> +
> +	if (unlikely(x > 18))
> +		return r;
> +

Strictly speaking that would be 19 (10^19=0x8AC7230489E80000),
and I am not sure if returning 1 in that case is such a good idea.
If you really want to handle over/underflow situations, it should
be in the calling code.

Thanks,
Guenter

> +	while (x--)
> +		r *= 10;
> +
> +	return r;
> +}
> +
> +static u64 scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 value)
> +{
> +	s8 scale = sensor->scale;
> +	u64 f;
> +
> +	switch (sensor->type) {
> +	case TEMPERATURE_C:
> +	case VOLTAGE:
> +	case CURRENT:
> +		scale += 3;
> +		break;
> +	case POWER:
> +	case ENERGY:
> +		scale += 6;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	f = __pow10(abs(scale));
> +	if (scale > 0)
> +		value *= f;
> +	else
> +		value = div64_u64(value, f);
> +
> +        return value;
> +}
> +
>   static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>   			   u32 attr, int channel, long *val)
>   {
> @@ -30,7 +71,7 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>   	sensor = *(scmi_sensors->info[type] + channel);
>   	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
>   	if (!ret)
> -		*val = value;
> +		*val = scmi_hwmon_scale(sensor, value);
>   
>   	return ret;
>   }
> 

