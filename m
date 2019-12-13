Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C24C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 06:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8F8214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 06:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQBWlcsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfLMGGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 01:06:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35669 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfLMGGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 01:06:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id s10so799240plp.2;
        Thu, 12 Dec 2019 22:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oTcpJNk1xqKGyB5ClAR/s3v8RFY0BEnq+v19yEDpJbk=;
        b=GQBWlcszvv5PGxYVAfrOSXSUt48y7V81ivYARzQtMMY+sz6ilI/paRYxJhfgj0vnZY
         WRyJw1FeC/qV5UxnlnCFzn4KM2iHW3fBeI+oy+uUlu7wvrGdVp8iL+eXn7HNPGLDnkrr
         Nsj4WMdGcqA4Ko0fBaVM9J4xMAMMdKKJhDMzDmhZdmNMxfhepWq7285obv6Ub5hsgKfh
         WX/dKSrPzVzvjmAe03kzo7JaR6NXW1C9kb85DHy43zw1bmtkMCc+KAxnSW/Ktt56SFmk
         cRNKYUZBd4vWLgGBAAY2oy4jDyPbZtAmJQzuzoOmu9Y3NyCSNu6tTJjGwzL8uy8fWJld
         /rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oTcpJNk1xqKGyB5ClAR/s3v8RFY0BEnq+v19yEDpJbk=;
        b=ZNm4SCxPaBdETWR9GSBbUh3mrrJg1pgV9i4gbK9VNZiWvix3ipALMeRGOQv9HSqJ9k
         w5gF+qQABUB2hOE9dvaC/FztuKe+oTlaeqH+lvYGmjmNERAH09Y9LUxOebAigaF2BLUh
         9d3yWLkxk+JxBKhj7DHtfREX6T8rRPSzKhOx/Y50268ViLHiqF+pwgJzFPpAs34MNELv
         b7oN4cINN+CC4DUzeCYfcz6hvLGa05NUZjowz6/HxX2uhE8ipZN23rPGxTURmr7LZ4Qk
         GFRWoTWtpxNkcYzTkJdPPvmS4Jk6twV+6UEJSLcFrm5R/geygmUGM/u+OrJW43VBM6P6
         ptug==
X-Gm-Message-State: APjAAAW+mpXvH6vy0nc8qAx8I3bgN5i+Og+I9XMoo36f/KP5160DZNgu
        8TlRw8QOmgX/b3f6SctFLGs=
X-Google-Smtp-Source: APXvYqxHC4EwkoEsA6d0ud4NuxpyBl1jUHDJihm6TQB0jKGokpavCDdX6mETYwj1FhyZW2jxcz4faw==
X-Received: by 2002:a17:90a:bc05:: with SMTP id w5mr14491704pjr.64.1576217172025;
        Thu, 12 Dec 2019 22:06:12 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p16sm8964659pgi.50.2019.12.12.22.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Dec 2019 22:06:11 -0800 (PST)
Date:   Thu, 12 Dec 2019 22:06:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [-next] hwmon: (w83627ehf) make sensor_dev_attr_##_name
 variables static
Message-ID: <20191213060609.GA20673@roeck-us.net>
References: <20191213015605.172472-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213015605.172472-1-chenzhou10@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 09:56:05AM +0800, Chen Zhou wrote:
> Fix sparse warning:
> 
> drivers/hwmon/w83627ehf.c:1202:1: warning: symbol 'sensor_dev_attr_pwm1_target' was not declared. Should it be static?

...

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Applied (though I removed most of the log messages - there no point of
having all of them in the commit message).

Guenter

> ---
>  drivers/hwmon/w83627ehf.c | 56 +++++++++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> index 207cc74..0a13f6b 100644
> --- a/drivers/hwmon/w83627ehf.c
> +++ b/drivers/hwmon/w83627ehf.c
> @@ -1199,22 +1199,22 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
>  	return count;
>  }
>  
> -SENSOR_DEVICE_ATTR(pwm1_target, 0644, show_target_temp,
> +static SENSOR_DEVICE_ATTR(pwm1_target, 0644, show_target_temp,
>  	    store_target_temp, 0);
> -SENSOR_DEVICE_ATTR(pwm2_target, 0644, show_target_temp,
> +static SENSOR_DEVICE_ATTR(pwm2_target, 0644, show_target_temp,
>  	    store_target_temp, 1);
> -SENSOR_DEVICE_ATTR(pwm3_target, 0644, show_target_temp,
> +static SENSOR_DEVICE_ATTR(pwm3_target, 0644, show_target_temp,
>  	    store_target_temp, 2);
> -SENSOR_DEVICE_ATTR(pwm4_target, 0644, show_target_temp,
> +static SENSOR_DEVICE_ATTR(pwm4_target, 0644, show_target_temp,
>  	    store_target_temp, 3);
>  
> -SENSOR_DEVICE_ATTR(pwm1_tolerance, 0644, show_tolerance,
> +static SENSOR_DEVICE_ATTR(pwm1_tolerance, 0644, show_tolerance,
>  	    store_tolerance, 0);
> -SENSOR_DEVICE_ATTR(pwm2_tolerance, 0644, show_tolerance,
> +static SENSOR_DEVICE_ATTR(pwm2_tolerance, 0644, show_tolerance,
>  	    store_tolerance, 1);
> -SENSOR_DEVICE_ATTR(pwm3_tolerance, 0644, show_tolerance,
> +static SENSOR_DEVICE_ATTR(pwm3_tolerance, 0644, show_tolerance,
>  	    store_tolerance, 2);
> -SENSOR_DEVICE_ATTR(pwm4_tolerance, 0644, show_tolerance,
> +static SENSOR_DEVICE_ATTR(pwm4_tolerance, 0644, show_tolerance,
>  	    store_tolerance, 3);
>  
>  /* Smart Fan registers */
> @@ -1291,35 +1291,35 @@ store_##reg(struct device *dev, struct device_attribute *attr, \
>  
>  fan_time_functions(fan_stop_time, FAN_STOP_TIME)
>  
> -SENSOR_DEVICE_ATTR(pwm4_stop_time, 0644, show_fan_stop_time,
> +static SENSOR_DEVICE_ATTR(pwm4_stop_time, 0644, show_fan_stop_time,
>  	    store_fan_stop_time, 3);
> -SENSOR_DEVICE_ATTR(pwm4_start_output, 0644, show_fan_start_output,
> +static SENSOR_DEVICE_ATTR(pwm4_start_output, 0644, show_fan_start_output,
>  	    store_fan_start_output, 3);
> -SENSOR_DEVICE_ATTR(pwm4_stop_output, 0644, show_fan_stop_output,
> +static SENSOR_DEVICE_ATTR(pwm4_stop_output, 0644, show_fan_stop_output,
>  	    store_fan_stop_output, 3);
> -SENSOR_DEVICE_ATTR(pwm4_max_output, 0644, show_fan_max_output,
> +static SENSOR_DEVICE_ATTR(pwm4_max_output, 0644, show_fan_max_output,
>  	    store_fan_max_output, 3);
> -SENSOR_DEVICE_ATTR(pwm4_step_output, 0644, show_fan_step_output,
> +static SENSOR_DEVICE_ATTR(pwm4_step_output, 0644, show_fan_step_output,
>  	    store_fan_step_output, 3);
>  
> -SENSOR_DEVICE_ATTR(pwm3_stop_time, 0644, show_fan_stop_time,
> +static SENSOR_DEVICE_ATTR(pwm3_stop_time, 0644, show_fan_stop_time,
>  	    store_fan_stop_time, 2);
> -SENSOR_DEVICE_ATTR(pwm3_start_output, 0644, show_fan_start_output,
> +static SENSOR_DEVICE_ATTR(pwm3_start_output, 0644, show_fan_start_output,
>  	    store_fan_start_output, 2);
> -SENSOR_DEVICE_ATTR(pwm3_stop_output, 0644, show_fan_stop_output,
> +static SENSOR_DEVICE_ATTR(pwm3_stop_output, 0644, show_fan_stop_output,
>  		    store_fan_stop_output, 2);
>  
> -SENSOR_DEVICE_ATTR(pwm1_stop_time, 0644, show_fan_stop_time,
> +static SENSOR_DEVICE_ATTR(pwm1_stop_time, 0644, show_fan_stop_time,
>  	    store_fan_stop_time, 0);
> -SENSOR_DEVICE_ATTR(pwm2_stop_time, 0644, show_fan_stop_time,
> +static SENSOR_DEVICE_ATTR(pwm2_stop_time, 0644, show_fan_stop_time,
>  	    store_fan_stop_time, 1);
> -SENSOR_DEVICE_ATTR(pwm1_start_output, 0644, show_fan_start_output,
> +static SENSOR_DEVICE_ATTR(pwm1_start_output, 0644, show_fan_start_output,
>  	    store_fan_start_output, 0);
> -SENSOR_DEVICE_ATTR(pwm2_start_output, 0644, show_fan_start_output,
> +static SENSOR_DEVICE_ATTR(pwm2_start_output, 0644, show_fan_start_output,
>  	    store_fan_start_output, 1);
> -SENSOR_DEVICE_ATTR(pwm1_stop_output, 0644, show_fan_stop_output,
> +static SENSOR_DEVICE_ATTR(pwm1_stop_output, 0644, show_fan_stop_output,
>  	    store_fan_stop_output, 0);
> -SENSOR_DEVICE_ATTR(pwm2_stop_output, 0644, show_fan_stop_output,
> +static SENSOR_DEVICE_ATTR(pwm2_stop_output, 0644, show_fan_stop_output,
>  	    store_fan_stop_output, 1);
>  
>  
> @@ -1327,17 +1327,17 @@ SENSOR_DEVICE_ATTR(pwm2_stop_output, 0644, show_fan_stop_output,
>   * pwm1 and pwm3 don't support max and step settings on all chips.
>   * Need to check support while generating/removing attribute files.
>   */
> -SENSOR_DEVICE_ATTR(pwm1_max_output, 0644, show_fan_max_output,
> +static SENSOR_DEVICE_ATTR(pwm1_max_output, 0644, show_fan_max_output,
>  	    store_fan_max_output, 0);
> -SENSOR_DEVICE_ATTR(pwm1_step_output, 0644, show_fan_step_output,
> +static SENSOR_DEVICE_ATTR(pwm1_step_output, 0644, show_fan_step_output,
>  	    store_fan_step_output, 0);
> -SENSOR_DEVICE_ATTR(pwm2_max_output, 0644, show_fan_max_output,
> +static SENSOR_DEVICE_ATTR(pwm2_max_output, 0644, show_fan_max_output,
>  	    store_fan_max_output, 1);
> -SENSOR_DEVICE_ATTR(pwm2_step_output, 0644, show_fan_step_output,
> +static SENSOR_DEVICE_ATTR(pwm2_step_output, 0644, show_fan_step_output,
>  	    store_fan_step_output, 1);
> -SENSOR_DEVICE_ATTR(pwm3_max_output, 0644, show_fan_max_output,
> +static SENSOR_DEVICE_ATTR(pwm3_max_output, 0644, show_fan_max_output,
>  	    store_fan_max_output, 2);
> -SENSOR_DEVICE_ATTR(pwm3_step_output, 0644, show_fan_step_output,
> +static SENSOR_DEVICE_ATTR(pwm3_step_output, 0644, show_fan_step_output,
>  	    store_fan_step_output, 2);
>  
>  static ssize_t
