Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831A9C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5583021848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPSyyXqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbfKFWfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:35:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36785 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFWfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:35:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id k13so60942pgh.3;
        Wed, 06 Nov 2019 14:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j+qLkwetpwDDMd9S2NQSFpmOChY51lQbcBGMbI8PvEI=;
        b=bPSyyXqRuoJkim7wGZMqTTDtIpD89qy7d4wVPzn9adO6MJwE6XsjfY1fK6IlOJI2nd
         LII0WsYg+XuX5e9xxCkbWzcEMWXuI/myPsUsFVec5wpEmXXLaU1csJj87xiwskzpMVCB
         B2Bu5XgbHmGcWM9mZEVOr4jVMxH4H9RzcjKRw+tdbJxfh2aXhSe0KfYf+zaf1ZsyZHzi
         yYLdY6mQKdnseM01SEal1QZcOlRo1UV8AQ58GQhSj2xts1dlJFh0Gyt9/DLUl1eVnYex
         yYtY7BVwN3wtCOM6RkliRA7gesJUd9sklMxW6JAhv6POnnNCk+fW313kLszZ9Gj4PWaH
         qMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j+qLkwetpwDDMd9S2NQSFpmOChY51lQbcBGMbI8PvEI=;
        b=V7GWGi+8rqp2Wp0I8Z/Q9ba3MS1n6FugpYELt3pXFhTaF61yHAqHL8IZPZ1JphZkTQ
         n90sSCQAUtgZaenTRH4QdF1RMOK7ZwZQ5rNLGpwLnxeFfdDkVdb78mpraJbWgY+ehwDB
         jZAKWQOhV0q8Ko0zcUEHLKZJTyFbsG0nP/DiVloq/0M3C/Emx3VFzAxw5FkkgsPLexc7
         ZqZC1msEOo/hT0Uy/Gof4ynMuLT79dvyvvs8cIf1r6uwgpB/TvR98btkDvwkU+NMb+sA
         4XNg4rHHQ5IIMdD5vsd6Rpb7sxhiWzctnrBNsFPbOQczwHp1k7H+uP9ztBCxfBz35SDI
         dZpg==
X-Gm-Message-State: APjAAAVHP36F4t5MJH+3YCpw4dN1iExgw2+LQtN0tQl/iIK4yYb9jUkK
        fUD0LbfN3VVxufxflgfdjdo=
X-Google-Smtp-Source: APXvYqwcA4I/oUFrumUxBIXj2bldJNFE1aXnGLJGVtU8202f+ZbbICZy+cM1pl9WsRawNnEb0GsXAQ==
X-Received: by 2002:a17:90a:ff04:: with SMTP id ce4mr286465pjb.133.1573079736656;
        Wed, 06 Nov 2019 14:35:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y22sm15546pfn.6.2019.11.06.14.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 14:35:36 -0800 (PST)
Date:   Wed, 6 Nov 2019 14:35:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
Subject: Re: [PATCH 1/2] hwmon: (pmbus/ibm-cffps) Switch LEDs to blocking
 brightness call
Message-ID: <20191106223535.GA20168@roeck-us.net>
References: <20191106200106.29519-1-eajames@linux.ibm.com>
 <20191106200106.29519-2-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106200106.29519-2-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 02:01:05PM -0600, Eddie James wrote:
> Since i2c_smbus functions can sleep, the brightness setting function
> for this driver must be the blocking version to avoid scheduling while
> atomic.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index d61547ed0da0..c6a00e83aac6 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -297,8 +297,8 @@ static int ibm_cffps_read_word_data(struct i2c_client *client, int page,
>  	return rc;
>  }
>  
> -static void ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
> -					 enum led_brightness brightness)
> +static int ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
> +					enum led_brightness brightness)
>  {
>  	int rc;
>  	struct ibm_cffps *psu = container_of(led_cdev, struct ibm_cffps, led);
> @@ -316,9 +316,11 @@ static void ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
>  	rc = i2c_smbus_write_byte_data(psu->client, CFFPS_SYS_CONFIG_CMD,
>  				       psu->led_state);
>  	if (rc < 0)
> -		return;
> +		return rc;
>  
>  	led_cdev->brightness = brightness;
> +
> +	return 0;
>  }
>  
>  static int ibm_cffps_led_blink_set(struct led_classdev *led_cdev,
> @@ -356,7 +358,7 @@ static void ibm_cffps_create_led_class(struct ibm_cffps *psu)
>  		 client->addr);
>  	psu->led.name = psu->led_name;
>  	psu->led.max_brightness = LED_FULL;
> -	psu->led.brightness_set = ibm_cffps_led_brightness_set;
> +	psu->led.brightness_set_blocking = ibm_cffps_led_brightness_set;
>  	psu->led.blink_set = ibm_cffps_led_blink_set;
>  
>  	rc = devm_led_classdev_register(dev, &psu->led);
