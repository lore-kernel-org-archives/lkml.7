Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF051C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C5F2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csOjKCZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfEHScu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:32:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44647 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfEHScs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:32:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id g9so789446pfo.11;
        Wed, 08 May 2019 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w8iERNhjq4OzlLmPnHYUtIOOz9hjBDMOTj3lfmGbD88=;
        b=csOjKCZWFc7h/tvZm5iqctBGtliiS0aJWn6m4UCGgErAj3BADJf1b/pOoDIi2xbnLk
         IUIQYP6o81N8xJmmjgjWTtJ54UqTLLEO+Q6vJdk0VLZ5+cz3urCOJzaz5bp2Cm9yprNt
         o+2/m/66V1r0iUNn0RS6rP8/24NeN8EPVNbB3egVuSaIuLcmYrtsVy+TxCq0auMO8fqj
         NFie/xcxbkhm05WJn2Imb3IxYvSpU3p5ZIhcCPHwn+6KncdSHWZ/4EPVgsRHetsuW3/S
         Xnuorw9H65DeKNFlp052rMx8UZJSl1ttTHO3LukVYiJhNYSDN7NU+MtEcF1Oqa7nS2mr
         Ednw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=w8iERNhjq4OzlLmPnHYUtIOOz9hjBDMOTj3lfmGbD88=;
        b=Zfy45Pkuqwlqje6cTRvqXCk3Cx73ms8kuugpOHpSfFp8WxQxs19zW4TW8Gcp10hjE8
         A/Q4XFSHzAli74SsRK7EnblDeMTc2cZPw99DVEEsdzOjFtvkU/y4b93co0OGzi+HXGX9
         l3t/tvj/7RhPU1eB+yd+9fFewOHl2Qq7Cq5B6Rx7YY4i5xoxlCUp18gSzkjoXwSnpijE
         lF+DZTPRgeI4stWxLUwLacSejYjoiPoCoheZOREa3s8GZpiVfeVizhW048mU9vbQdqVB
         Ji4RdRfGWlIlI3b1OyXjEdDgbBtksm3P7qmTh44XCN0n/L5R6+CSdf+KDWEsgWBTflkV
         VE4g==
X-Gm-Message-State: APjAAAXjypzMwpXTRrIFX8ECpi+zscGYVjLQY1Fey2b4Jc3Sx2DXgBB3
        hz68tY+gZ+miz8y6U55ziw8=
X-Google-Smtp-Source: APXvYqwLYUVaKYkkXyJSAw3vwXScZuxYcOcqIn/p6Q7XM2+c5JUQm0gApMQMJJweVC7xeA+dHN91Sw==
X-Received: by 2002:aa7:8252:: with SMTP id e18mr50800633pfn.105.1557340367126;
        Wed, 08 May 2019 11:32:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a18sm22025285pff.6.2019.05.08.11.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 11:32:45 -0700 (PDT)
Date:   Wed, 8 May 2019 11:32:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] hwmon: scmi: Scale values to target desired HWMON
 units
Message-ID: <20190508183244.GA25133@roeck-us.net>
References: <20190508170035.19671-1-f.fainelli@gmail.com>
 <20190508170035.19671-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508170035.19671-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, May 08, 2019 at 10:00:35AM -0700, Florian Fainelli wrote:
> If the SCMI firmware implementation is reporting values in a scale that
> is different from the HWMON units, we need to scale up or down the value
> according to how far appart they are.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/hwmon/scmi-hwmon.c | 46 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index a80183a488c5..4399372e2131 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/hwmon.h>
> +#include <linux/limits.h>
>  #include <linux/module.h>
>  #include <linux/scmi_protocol.h>
>  #include <linux/slab.h>
> @@ -18,6 +19,47 @@ struct scmi_sensors {
>  	const struct scmi_sensor_info **info[hwmon_max];
>  };
>  
> +static inline u64 __pow10(u8 x)
> +{
> +	u64 r = 1;
> +
> +	while (x--)
> +		r *= 10;
> +
> +	return r;
> +}
> +
> +static int scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 *value)
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
> +	if (f == U64_MAX)
> +		return -E2BIG;

Unfortunately that is not how integer overflows work.

A test program with increasing values of scale reports:

0: 1
...
18: 1000000000000000000
19: 10000000000000000000
20: 7766279631452241920
21: 3875820019684212736
22: 1864712049423024128
23: 200376420520689664
24: 2003764205206896640
...
61: 11529215046068469760
62: 4611686018427387904
63: 9223372036854775808
64: 0
...

You'll have to check for abs(scale) > 19 if you want to report overflows.

Guenter

> +
> +	if (scale > 0)
> +		*value *= f;
> +	else
> +		*value = div64_u64(*value, f);
> +
> +        return 0;
> +}
> +
>  static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  			   u32 attr, int channel, long *val)
>  {
> @@ -29,6 +71,10 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  
>  	sensor = *(scmi_sensors->info[type] + channel);
>  	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
> +	if (ret)
> +		return ret;
> +
> +	ret = scmi_hwmon_scale(sensor, value);
>  	if (!ret)
>  		*val = value;
>  
> -- 
> 2.17.1
> 
