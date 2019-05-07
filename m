Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5AFC04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE41206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGP+20CM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfEGVOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:14:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34484 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfEGVOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:14:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck18so8797808plb.1;
        Tue, 07 May 2019 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jnh3OyB3pg4krglKKAZTgjWeTb51Mu7a+nGj/rrHdZU=;
        b=TGP+20CMVev4R/LFl07QzMVxWxt0d/zOI9TOl1yKaVPsRfcbEQde4vZelOCJ90Kw8/
         fzcKpW7H7ORKJgRfpHe41rGiWIa+rZ8/mvLmAREoCVxVhTmUzxwmN7B+Dp79ryCx9Ngt
         GMdcpOJL9gE6WNS1HY4/Ll1BjGLDlKDD5ciIlbUZ4KNnh8NEZC/hERuJALvddUgjdIN7
         KTQAEsACZeznHS3p2oCKXOy4WSp5bQetblpTLRpQWV4sxnVzHyhfWUCPoaMt0h1Sw6mA
         udtv1DnEzo2iJ8HIUTej0mfIiAnWg+9VlPykxFZmEPLuMZ5myJB1GtjOqPTyga4M+t6E
         fadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jnh3OyB3pg4krglKKAZTgjWeTb51Mu7a+nGj/rrHdZU=;
        b=cBd14PH/ffKppo/QBK6V1itVVVFP5W7ApsgZClRAY95/V8Nsk9Zq7HvPerLukuWOPk
         Qw/JW4Lig0d6xOo+qanj4Gw3RV/RTT2VwIr1geuZpjH0VmiUpdzXlMKHkgmb7xRLpgiH
         zJP8NNUA+E51x8t8ttHntOqxoYrDLUXLGvc7SuMkGzdChw+xmskpDx1ZBP1TM1VGACQ3
         +7oYeRgKKg6VSoInhcPkv8mKe6g+OWHk/1ITBypCrrX2rtBiHLyo9HJZn8+ezr0GAZk+
         0MSGGE8TJtD43eLYwN0mZtnCvbtPycEsA8hVi0DIbCxkJZK0ht8SoHcG2XYi1QJI+Mxa
         scqw==
X-Gm-Message-State: APjAAAW/O+wC7bBEwb5URMdESBU6oyP6Hov+AFVUfjLJaT03zpQPmSfr
        H80x6by8ivwH+vuvzEbznHA=
X-Google-Smtp-Source: APXvYqyyPSuo9mZZGgAtdJCo3Lx/KJweX4opkpet3eADhTkNs1WvpjzxIGgUqufpu5tKZ6oFrhiLbA==
X-Received: by 2002:a17:902:9686:: with SMTP id n6mr43464175plp.282.1557263679684;
        Tue, 07 May 2019 14:14:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v40sm7925116pgn.17.2019.05.07.14.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 14:14:38 -0700 (PDT)
Date:   Tue, 7 May 2019 14:14:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 3/3] hwmon: scmi: Scale values to target desired HWMON
 units
Message-ID: <20190507211437.GB4951@roeck-us.net>
References: <20190507193504.28248-1-f.fainelli@gmail.com>
 <20190507193504.28248-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507193504.28248-4-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 12:35:04PM -0700, Florian Fainelli wrote:
> If the SCMI firmware implementation is reporting values in a scale that
> is different from the HWMON units, we need to scale up or down the value
> according to how far appart they are.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/hwmon/scmi-hwmon.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index a80183a488c5..5c244053efc8 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -18,6 +18,34 @@ struct scmi_sensors {
>  	const struct scmi_sensor_info **info[hwmon_max];
>  };
>  
> +static u64 scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 value)
> +{
> +	s8 scale = sensor->scale;
> +	unsigned long long f;

do_div() takes either an uint32 or an unsigned long as second parameter,
so this doesn't really help. If you want to be able to handle scales
outside the 32-bit range, you would have to use u64 and div64_u64().

Guenter

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
> +	__pow10(abs(scale), f);
> +	if (scale > 0)
> +		value *= f;
> +	else
> +		do_div(value, f);
> +
> +        return value;
> +}
> +
>  static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  			   u32 attr, int channel, long *val)
>  {
> @@ -30,7 +58,7 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  	sensor = *(scmi_sensors->info[type] + channel);
>  	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
>  	if (!ret)
> -		*val = value;
> +		*val = scmi_hwmon_scale(sensor, value);
>  
>  	return ret;
>  }
> -- 
> 2.17.1
> 
