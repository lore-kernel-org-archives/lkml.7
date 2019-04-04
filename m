Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5840CC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DCE205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Be5gVPsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbfDDJaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:30:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39391 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732607AbfDDJKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id b65so852355plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 02:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AxDq7pHW3vj/cwIjk1l2Yzg+qosU7oX38sUnSTW10iQ=;
        b=Be5gVPsiveNyFH3Hkrs0GH+mQq3asW9AP3DDoshxtCp8YQ5rZXANJ8ydxKD9Yb5zC/
         yQjBFcHtCHVmDqnrHLo/0jGsMrgZW3Yvte6WJshH5ycl3J7j+hn0JDILpJIUInWHL2pP
         j0D5dWxC/UAX3CgDIyUTRgkTYIrqvUZVUZ3M6ep0bF6mSfQzBT/aVb+F21oTU5GJ7q0E
         +vQt2cQbyZbNaHf8zWq9cqAkmM1KzHo+4xCcCEu5hyDxHf58xhTRxNGUAgcepHfN9wVI
         HdzaCKWRSL17tAN1iGKGNNLn49wLLkCTdOWXly6ykVjuKt6Y4DaRK31ZZGifXPbUmWQF
         GIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AxDq7pHW3vj/cwIjk1l2Yzg+qosU7oX38sUnSTW10iQ=;
        b=ttPrWobxfz5bjjQbQeE87lDyHA8vL6K0bWd88waSfRRP+4HIrumNZb3phESaGtklZD
         7kZQHd9TFfzk42H1ATBUDlTBVm981ybMRvg7GQBGFFtp4nxWWIVlhtPW5X64VlSi3+0L
         +jtRXV05vAZj9x5WV2aDwKUjN2rrzeGi8oAc5IoBM1SUVlptxZCbdHZDDUMCzCUHSxOD
         5/tC4pU08jwsPVz+pBk9GUlBrgceRXA2PPDxecLErGUB5hhS2aSQ3/WEw99Xy0t9+FSI
         8oxxyWh/bb5LVCSvKwuL0dY2nTKZeDGpGrr9/w2kQBKwAmBFcyce8m9W4Q8PQRwukGCr
         sqeQ==
X-Gm-Message-State: APjAAAWbO5vnM0vUAOKUOXQunHLkTxOo6rvKOnviSDg+Xag9Ru+iofpL
        uvRIPgqf4Pum8wcnyFDbH0wXv7PLH9XN2A==
X-Google-Smtp-Source: APXvYqxmimsJeLJMVnOSqnAq/ke0zJ5DbBEm+MDOQwbudONRUU0OoDBkefXj0NK24A2Z0Q7fp63BmQ==
X-Received: by 2002:a17:902:20e3:: with SMTP id v32mr4991165plg.213.1554369030763;
        Thu, 04 Apr 2019 02:10:30 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id o67sm25042372pga.55.2019.04.04.02.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 02:10:29 -0700 (PDT)
Subject: Re: [PATCH v3 12/13] thermal_hwmon: Add devres wrapper for
 thermal_add_hwmon_sysfs()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-13-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ec9203b2-9f5f-80e2-bcd0-9318083331ef@linaro.org>
Date:   Thu, 4 Apr 2019 11:10:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401041418.5999-13-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Add devres wrapper for thermal_add_hwmon_sysfs() to simplify driver
> code.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/thermal_hwmon.c | 28 ++++++++++++++++++++++++++++
>  drivers/thermal/thermal_hwmon.h |  7 +++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index 40c69a533b24..4e79524182e1 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -244,3 +244,31 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>  	kfree(hwmon);
>  }
>  EXPORT_SYMBOL_GPL(thermal_remove_hwmon_sysfs);
> +
> +static void devm_thermal_hwmon_release(struct device *dev, void *res)
> +{
> +	thermal_remove_hwmon_sysfs(*(struct thermal_zone_device **)res);
> +}
> +
> +int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
> +{
> +	struct thermal_zone_device **ptr;
> +	int ret;
> +
> +	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
> +			   GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	ret = thermal_add_hwmon_sysfs(tz);
> +	if (ret) {
> +		devres_free(ptr);
> +		return ret;
> +	}
> +
> +	*ptr = tz;
> +	devres_add(&tz->device, ptr);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_thermal_add_hwmon_sysfs);
> diff --git a/drivers/thermal/thermal_hwmon.h b/drivers/thermal/thermal_hwmon.h
> index a160b9d62dd0..1a9d65f6a6a8 100644
> --- a/drivers/thermal/thermal_hwmon.h
> +++ b/drivers/thermal/thermal_hwmon.h
> @@ -17,6 +17,7 @@
>  
>  #ifdef CONFIG_THERMAL_HWMON
>  int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
> +int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
>  void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz);
>  #else
>  static inline int
> @@ -25,6 +26,12 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>  	return 0;
>  }
>  
> +static inline int
> +devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
> +{
> +	return 0;
> +}
> +
>  static inline void
>  thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>  {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

