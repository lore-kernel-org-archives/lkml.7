Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4C1C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211D32077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd9fvU4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfDPNXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:23:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37378 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfDPNXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:23:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so10351500pgc.4;
        Tue, 16 Apr 2019 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YTcai3ILqiFQ0jFaP1rQRFUTWlngnMBopiXkVQbHRlg=;
        b=Vd9fvU4PnFlrh7s4E9wblubIalsFj6J4baNeHXwlb3AczNr8RgDAu/YRUss1UCR64g
         pGwioKEcPOLA04UDvylIKl82yGaZKpe+zrg+1uO5RUjIanfDWwOAqlIake46qjztHvcT
         snBnRngHxgGU4rDBziicd3ce68ENZybhlHAFsytWQxiZmk4IR+A1aSBBEbBHtN80/lJl
         DP0LjDsxuuvi3Pbm9lTuPMnEaZOJUSmh6b5rbYN1ad8Eq/aXhRHx3jiSIKyzdf3TwoYi
         egDt7q9k12VD6UDgfyUIYIwPjdMwqV8SU7MyIEKrXTeVa0zFlNIBmGzm3p3PSUgwtaqn
         FlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YTcai3ILqiFQ0jFaP1rQRFUTWlngnMBopiXkVQbHRlg=;
        b=Ye8uTQ7mVBJV1XezRF7kQNWO2Vy8T18iU3rZ4x6vRXGMIx+io5w9uqpv2icZURZ8So
         Fe/mP2KDD8weKGoXkWaKdaDZzG3PZaOoxTPCNW8fAZzuvuZD+ap1c94XFFgs+vhMgb3t
         PI+TjmPMiQRiVvrIE1BTZOs8ek8FZqG4XQYM7XLs4Icf3eEIpc7Qk8cQpiwkQXOGZs5w
         hg+FivC2ZBH8d4c1JqwKlbO5kWS0IHAlj0xDyaJaTkCdbUVF7KJrkZcqIIEv5GShGCop
         XOesiIy8xup1hUnSe6h7IG8v1tWcXaHqJZ4DlCTq2qpHk3ITIhZ8vA2NrSSoBhoLRWWk
         prXw==
X-Gm-Message-State: APjAAAUlWysS7jTxmBcXNUgRVZZkChLMkas2+ULQ+XIYLuSSGNjM69Pk
        JqVBgMZCxvqXugX6m6uE81V3oDKT
X-Google-Smtp-Source: APXvYqw/s3TXNvlgP5EucJboiFEgnGRxmVa5YbwHQmHCMJ+PyxRciRx5Z27Yv0WpDVaXKq83xM7ylA==
X-Received: by 2002:a63:6844:: with SMTP id d65mr77767431pgc.393.1555420990346;
        Tue, 16 Apr 2019 06:23:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l1sm66358724pgo.13.2019.04.16.06.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 06:23:09 -0700 (PDT)
Subject: Re: [PATCH v2 01/16] watchdog: refactor watchdog_init_timeout
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-2-wsa+renesas@sang-engineering.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b65ae931-bfb3-acb4-8097-da4b81be1ea5@roeck-us.net>
Date:   Tue, 16 Apr 2019 06:23:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416102515.12269-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 3:25 AM, Wolfram Sang wrote:
> The function is not easy to read and has a problem: -EINVAL is returned
> when the module parameter is invalid but the DT parameter is OK.
> 
> Refactor the code to have the same pattern of checks for the module
> parameter and DT. Further ones can be easily added in the future if the
> need arises. The above mentioned problem is fixed, too.
> 
> Some documentation is added to describe the different handlings of '0'
> for the module parameter and the DT property.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/watchdog_core.c | 33 +++++++++++++++++++--------------
>   1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index eb8fa25f8eb2..21e53cc49977 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -105,9 +105,12 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
>    * timeout module parameter (if it is valid value) or the timeout-sec property
>    * (only if it is a valid value and the timeout_parm is out of bounds).
>    * If none of them are valid then we keep the old value (which should normally
> - * be the default timeout value).
> + * be the default timeout value). Note that for the module parameter, '0' means
> + * 'use default' while it is an invalid value for the timeout-sec property.
> + * It should simply be dropped if you want to use the default value then.
>    *
> - * A zero is returned on success and -EINVAL for failure.
> + * A zero is returned on success or -EINVAL if all provided values are out of
> + * bounds.
>    */
>   int watchdog_init_timeout(struct watchdog_device *wdd,
>   				unsigned int timeout_parm, struct device *dev)
> @@ -117,22 +120,24 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
>   
>   	watchdog_check_min_max_timeout(wdd);
>   
> -	/* try to get the timeout module parameter first */
> -	if (!watchdog_timeout_invalid(wdd, timeout_parm) && timeout_parm) {
> -		wdd->timeout = timeout_parm;
> -		return ret;
> -	}
> -	if (timeout_parm)
> +	/* check the driver supplied value (likely a module parameter) first */
> +	if (timeout_parm) {
> +		if (!watchdog_timeout_invalid(wdd, timeout_parm)) {
> +			wdd->timeout = timeout_parm;
> +			return 0;
> +		}
>   		ret = -EINVAL;
> +	}
>   
>   	/* try to get the timeout_sec property */
> -	if (dev == NULL || dev->of_node == NULL)
> -		return ret;
> -	of_property_read_u32(dev->of_node, "timeout-sec", &t);
> -	if (!watchdog_timeout_invalid(wdd, t) && t)
> -		wdd->timeout = t;
> -	else
> +	if (dev && dev->of_node &&
> +	    of_property_read_u32(dev->of_node, "timeout-sec", &t) == 0) {
> +		if (t && !watchdog_timeout_invalid(wdd, t)) {
> +			wdd->timeout = t;
> +			return 0;
> +		}
>   		ret = -EINVAL;
> +	}
>   
>   	return ret;
>   }
> 

