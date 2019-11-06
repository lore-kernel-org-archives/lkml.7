Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8457FC6194
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97269217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1fsHwJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbfKFWiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:38:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41064 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfKFWiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:38:11 -0500
Received: by mail-pl1-f194.google.com with SMTP id d29so5817205plj.8;
        Wed, 06 Nov 2019 14:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NhLwyjiytcYSqAw2MKZJzXtEEN6/UjRwW19b5+Kxoko=;
        b=B1fsHwJzunde+XUqyu3U6KO/UaBvzPKaViffUAvOFBsY+2+3d9EgH+Z2+yYgUrT2dj
         nfu/GSd1JkRgRRt9xX2iRkYmCCVzORgIK/dtOKfIFGi0pSa+7HdHS/4Ti7FQDHUXNWF/
         o5w1hTljp1oHK3OBmt1rxNEOZsaPOKxttj/yDfSokIr81sSP3sE7DAIEXbkzQxSNKktV
         dxpTQfDukUzQ80k6hEcrqsiqTpgx5MmrzS8eZe9ryvSZLTrdBKVadVcfVZEuq1Lcb1GI
         ulMcQcLhV9YRzzeD66PsT0ONqsWA01kFPNJNY85twehsMjp8Yx3I4DiM2c2lQkWwe1vH
         xk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NhLwyjiytcYSqAw2MKZJzXtEEN6/UjRwW19b5+Kxoko=;
        b=pzmH25k7H/O0PRjPuFfYr9lqM/XbVZddpLTl0xuAEuel6xwEDXZVdSzaKhxFParzmw
         eunm+KONgL75kLG2wiIHXB4iPfdQuNHfn9G9A+fneowE1zE1ZJh0BAltOvCEfRahyxxP
         euOVh03HIzTVOBb8XRxFYitHY+AnDltUhJdX5GrpYcwB2Hj0Q0gbhot43yE7gdCFcLF5
         ZzJFy+lziDUALH1hStujhTc2qz3wwkq0Paiu7s0uBexBRvCH/RDXtI3xM4ycj3jzVChg
         q4aU4Fr6NMsTHPy/wcKusfpMDGvjpNKwsA+A4LymTnc3dxV7Zocpov4NK1NEmfBpl5Yi
         Z9Qw==
X-Gm-Message-State: APjAAAUguX9gycEAoCUwJ9Y0shMFvu7KsSK06JVtxJZKJKZQLLJcAJDL
        fpMroCjlrayHdthBrqB0OPo=
X-Google-Smtp-Source: APXvYqwehfybuckKda8ttVPtF1fcYViIFX1E5srRIuEnDbfzuJmzexMVpUmMgwLKkCfzzu4HknuG+A==
X-Received: by 2002:a17:902:a98c:: with SMTP id bh12mr12236plb.289.1573079890298;
        Wed, 06 Nov 2019 14:38:10 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z11sm3735pfg.117.2019.11.06.14.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 14:38:09 -0800 (PST)
Date:   Wed, 6 Nov 2019 14:38:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
Subject: Re: [PATCH 2/2] hwmon: (pmbus/ibm-cffps) Fix LED blink behavior
Message-ID: <20191106223808.GA20956@roeck-us.net>
References: <20191106200106.29519-1-eajames@linux.ibm.com>
 <20191106200106.29519-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106200106.29519-3-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 02:01:06PM -0600, Eddie James wrote:
> The LED blink_set function incorrectly did not tell the PSU LED to blink
> if brightness was LED_OFF. Fix this, and also correct the LED_OFF
> command data, which should give control of the LED back to the PSU
> firmware. Also prevent I2C failures from getting the driver LED state
> out of sync and add some dev_dbg statements.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index c6a00e83aac6..d359b76bcb36 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -44,9 +44,13 @@
>  #define CFFPS_MFR_VAUX_FAULT			BIT(6)
>  #define CFFPS_MFR_CURRENT_SHARE_WARNING		BIT(7)
>  
> +/*
> + * LED off state actually relinquishes LED control to PSU firmware, so it can
> + * turn on the LED for faults.
> + */
> +#define CFFPS_LED_OFF				0
>  #define CFFPS_LED_BLINK				BIT(0)
>  #define CFFPS_LED_ON				BIT(1)
> -#define CFFPS_LED_OFF				BIT(2)
>  #define CFFPS_BLINK_RATE_MS			250
>  
>  enum {
> @@ -301,23 +305,31 @@ static int ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
>  					enum led_brightness brightness)
>  {
>  	int rc;
> +	u8 next_led_state;
>  	struct ibm_cffps *psu = container_of(led_cdev, struct ibm_cffps, led);
>  
>  	if (brightness == LED_OFF) {
> -		psu->led_state = CFFPS_LED_OFF;
> +		next_led_state = CFFPS_LED_OFF;
>  	} else {
>  		brightness = LED_FULL;
> +
>  		if (psu->led_state != CFFPS_LED_BLINK)
> -			psu->led_state = CFFPS_LED_ON;
> +			next_led_state = CFFPS_LED_ON;
> +		else
> +			next_led_state = CFFPS_LED_BLINK;
>  	}
>  
> +	dev_dbg(&psu->client->dev, "LED brightness set: %d. Command: %d.\n",
> +		brightness, next_led_state);
> +
>  	pmbus_set_page(psu->client, 0);
>  
>  	rc = i2c_smbus_write_byte_data(psu->client, CFFPS_SYS_CONFIG_CMD,
> -				       psu->led_state);
> +				       next_led_state);
>  	if (rc < 0)
>  		return rc;
>  
> +	psu->led_state = next_led_state;
>  	led_cdev->brightness = brightness;
>  
>  	return 0;
> @@ -330,10 +342,7 @@ static int ibm_cffps_led_blink_set(struct led_classdev *led_cdev,
>  	int rc;
>  	struct ibm_cffps *psu = container_of(led_cdev, struct ibm_cffps, led);
>  
> -	psu->led_state = CFFPS_LED_BLINK;
> -
> -	if (led_cdev->brightness == LED_OFF)
> -		return 0;
> +	dev_dbg(&psu->client->dev, "LED blink set.\n");
>  
>  	pmbus_set_page(psu->client, 0);
>  
> @@ -342,6 +351,8 @@ static int ibm_cffps_led_blink_set(struct led_classdev *led_cdev,
>  	if (rc < 0)
>  		return rc;
>  
> +	psu->led_state = CFFPS_LED_BLINK;
> +	led_cdev->brightness = LED_FULL;
>  	*delay_on = CFFPS_BLINK_RATE_MS;
>  	*delay_off = CFFPS_BLINK_RATE_MS;
>  
