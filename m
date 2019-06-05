Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94A2C28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C185620866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODm6ZU5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfFEU3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:29:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41429 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEU3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:29:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so6207757pgg.8;
        Wed, 05 Jun 2019 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tsU7PRmGx4zvDabkVGTD+3FltQQMUc79t0+U+ftspnw=;
        b=ODm6ZU5sz+MM5ETw8XEA48YgdGABlObgcXaKta8uTBcE/RZDVQszuQO2Jn5MTvFMGo
         TfPsItoNWKzIiDzEMPJXXWrL5mCBz2HOA9kig9U7wdx+dQpwp98Obf3TAVrTsnPaiN7g
         SfgY4ANoz4IBp4UUIbHuHETmSHk71NilQAbJo7JW13KPesBqqaITPB7+ljovj+KcDPjD
         Y4X+gK2Pb/IK3qruO3XTx99g9G+Ah3xVp/olk6Do1C5TStsFVSBwyZXZVuGp7qDXARTM
         tWdxS3XO1ZJx3Q5HWJbTcn20UWe+aCc7JyOEgx8VqUeH+ej7YNJf5IRcmW/WV6nJxdeZ
         nHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tsU7PRmGx4zvDabkVGTD+3FltQQMUc79t0+U+ftspnw=;
        b=kzhhmmzcrpGVun9izd5sTSfMgvLOkKmMTzBjZcosP7neBasMApR10a8JxYzocf8SFq
         4vRATPF2IWeIJhqg6Dbp1zyf2ZEWfjKJSTWedoJXpTS9u+DMtXcv10mJVCK5rUY58mAv
         MoyomXLHCVzWaWuyuyy+13NFMjWPQFhH9f4OyqzYrBBvbyc8ORssf9tgRIm1EZsVD0Rx
         WxUId82cG9bu1KruwR+7AWt2w7Is5vTGqhuvP+IBpIn9cfDvNAsZtp0eTf8FLd7I5LAx
         esPckMfrApk8kQ5yYAr0UC1AQssalj93bLwWzX0DULGC20RCkfQ2uEtaJFuARwn4JBM/
         taEQ==
X-Gm-Message-State: APjAAAXwgQ9/pRfH9ocajMGF0gzctaFW9WygGedPZnOuGj0MlmMPq86s
        8kENGK5Nv3HyqKd5yG/IKEFzEdNC
X-Google-Smtp-Source: APXvYqwlbeiCZvnPsWb/TW3E5NygNfC1uCWXlC93nb0M8t/h/xvoDiSQx0b44mckY0u2XbQYV0iB9g==
X-Received: by 2002:aa7:8b49:: with SMTP id i9mr21261054pfd.74.1559766560648;
        Wed, 05 Jun 2019 13:29:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s1sm17357165pgp.94.2019.06.05.13.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:29:20 -0700 (PDT)
Date:   Wed, 5 Jun 2019 13:29:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] hwmon: core: fix potential memory leak in
 *hwmon_device_register*
Message-ID: <20190605202919.GA28892@roeck-us.net>
References: <20190530025605.3698-1-eduval@amazon.com>
 <20190530025605.3698-3-eduval@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530025605.3698-3-eduval@amazon.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 07:56:05PM -0700, Eduardo Valentin wrote:
> When registering a hwmon device with HWMON_C_REGISTER_TZ flag
> in place, the hwmon subsystem will attempt to register the device
> also with the thermal subsystem. When the of-thermal registration
> fails, __hwmon_device_register jumps to ida_remove, leaving
> the locally allocated hwdev pointer.
> 
> This patch fixes the leak by jumping to a new label that
> will first unregister hdev and then fall into the kfree of hwdev
> to finally remove the idas and propagate the error code.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduval@amazon.com>

Applied.

Thanks,
Guenter

> ---
> V1->V2: removed the device_unregister() before jumping
> into the new label, as suggested in the first review round.
> 
>  drivers/hwmon/hwmon.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 429784edd5ff..620f05fc412a 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -652,10 +652,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  				if (info[i]->config[j] & HWMON_T_INPUT) {
>  					err = hwmon_thermal_add_sensor(dev,
>  								hwdev, j);
> -					if (err) {
> -						device_unregister(hdev);
> -						goto ida_remove;
> -					}
> +					if (err)
> +						goto device_unregister;
>  				}
>  			}
>  		}
> @@ -663,6 +661,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  
>  	return hdev;
>  
> +device_unregister:
> +	device_unregister(hdev);
>  free_hwmon:
>  	kfree(hwdev);
>  ida_remove:
