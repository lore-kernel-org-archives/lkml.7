Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463DDC3A5A8
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD2222DA9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcFErEda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfHaPGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 11:06:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36732 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfHaPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 11:06:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so4681997plr.3;
        Sat, 31 Aug 2019 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u1DCZh7j+TpknkccBgeBvz8YM54cv01G+W7Fn/Mmg90=;
        b=vcFErEdaMDbMBmg/0/NGgsPFRa2o2rEZEzjPh5Wlplwi8J6/wc1Or0AotYzwMYlfcE
         i83yKII2H+HgizYyl/1MLJVeqKj7kiHM9Eyq4UlHn3HDrYsZZJsb/0lO44fFfJuNE3/y
         5zl232nQdKgig/1D7x7DjuizqUDCqXoHYiIT0eZfgS0GHLMwSzPaW2QGziQK8IRtBfG+
         EBnZS4fmkKnbynKwesx1nbCs0XB7eLTifpMG+od/rwMXeosdHsHFYX6Jrsmpdw+Pik8l
         lZLq6ZOnDXUyf16p9KGPmeiucY2dMqIwV7SDLnyWk3pJ6ih64Ve0JfyQUfdFBKcSO0FQ
         hOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=u1DCZh7j+TpknkccBgeBvz8YM54cv01G+W7Fn/Mmg90=;
        b=UsDBYTklZ4hVUkLOUGynzLS9clBLB1Hwn4n3tjdfyP4M9cokUcQJldqHxLCrFFlUIA
         j96iZMPZ0bKWql54IfiG6zFBUU36ZYFeBGFY1ia6elvBb0uGyoWHhmE6RwzL2ufRQmJL
         yqaAxGIJtt17n4wdwiNBYyJ21Oi+BJpYMljT7ljFn1i6U27pC0yJm3XFZpBBjb2Imd4b
         Sw+i+njdvZgaevD0iX73J0GWlzkL7yRQYqa22jKQYBnlTomM36Et0KhmeA9872XBh1b8
         dNrSS3WzgZPE7MKMM0vFkw1eJa6hrSBLW2L23IKZMhYCQBI8mCSF5rJCilZZvIaR6/Jf
         TTjw==
X-Gm-Message-State: APjAAAX2SQFi05lvnJPT+oBAwTLLiMKpeIPBGr/SsIDcdO+SNDKSK1T6
        QwhQKEWmZVo4rFZ/w1XrBJzti7K+
X-Google-Smtp-Source: APXvYqwULm87nFISUE9eBef45oIqACxgdsbp69dTRSm4c5WAPMMnDrIhxFodYTCmeumONC0o3c6wDg==
X-Received: by 2002:a17:902:20cc:: with SMTP id v12mr19776641plg.188.1567263994767;
        Sat, 31 Aug 2019 08:06:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b3sm12037076pfp.65.2019.08.31.08.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 08:06:34 -0700 (PDT)
Date:   Sat, 31 Aug 2019 08:06:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: (iio_hwmon) Enable power exporting from IIO
Message-ID: <20190831150633.GA8338@roeck-us.net>
References: <db71f5ae87e4521a2856a1be5544de0b6cede575.1566483741.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db71f5ae87e4521a2856a1be5544de0b6cede575.1566483741.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 04:22:24PM +0200, Michal Simek wrote:
> There is no reason why power channel shouldn't be exported as is done for
> voltage, current, temperature and humidity.
> 
> Power channel is available on iio ina226 driver.
> 
> Sysfs IIO documentation for power attribute added by commit 7c6d5c7ee883
> ("iio: Documentation: Add missing documentation for power attribute")
> is declaring that value is in mili-Watts but hwmon interface is expecting
> value in micro-Watts that's why there is a need for mili-Watts to
> micro-Watts conversion.
> 
> Tested on Xilinx ZCU102 board.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Changes in v1:
> - from RFC - fix power conversion mili-Watts to micro-Watts
> 
>  drivers/hwmon/iio_hwmon.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index f1c2d5faedf0..b85a125dd86f 100644
> --- a/drivers/hwmon/iio_hwmon.c
> +++ b/drivers/hwmon/iio_hwmon.c
> @@ -44,12 +44,20 @@ static ssize_t iio_hwmon_read_val(struct device *dev,
>  	int ret;
>  	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
>  	struct iio_hwmon_state *state = dev_get_drvdata(dev);
> +	struct iio_channel *chan = &state->channels[sattr->index];
> +	enum iio_chan_type type;
> +
> +	ret = iio_read_channel_processed(chan, &result);
> +	if (ret < 0)
> +		return ret;
>  
> -	ret = iio_read_channel_processed(&state->channels[sattr->index],
> -					&result);
> +	ret = iio_get_channel_type(chan, &type);
>  	if (ret < 0)
>  		return ret;
>  
> +	if (type == IIO_POWER)
> +		result *= 1000; /* mili-Watts to micro-Watts conversion */
> +
>  	return sprintf(buf, "%d\n", result);
>  }
>  
> @@ -59,7 +67,7 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  	struct iio_hwmon_state *st;
>  	struct sensor_device_attribute *a;
>  	int ret, i;
> -	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1;
> +	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1, power_i = 1;
>  	enum iio_chan_type type;
>  	struct iio_channel *channels;
>  	struct device *hwmon_dev;
> @@ -114,6 +122,10 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  			n = curr_i++;
>  			prefix = "curr";
>  			break;
> +		case IIO_POWER:
> +			n = power_i++;
> +			prefix = "power";
> +			break;
>  		case IIO_HUMIDITYRELATIVE:
>  			n = humidity_i++;
>  			prefix = "humidity";
