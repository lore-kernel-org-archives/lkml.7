Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8EFC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AB02133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VPV23PNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDIQgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:36:17 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34274 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIQgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:36:16 -0400
Received: by mail-yw1-f66.google.com with SMTP id x129so6484696ywc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xpIFPTZQr0g3xRCPusrGDi9fMWXkv23vj9IPJLmKgbE=;
        b=VPV23PNF3ThSzi2Uk1p4UvmW9Y9fWckNBvPpyfORjw4qTXM0/dTa091enhNNZm/rIs
         x5K0vkV7M/pVdQ2eI0SWlYiQHy0h/cgyDS7RDBqekpfi8RRbDIb8PvmF/4wISLGs1Z1p
         8IJT/nHLaERb/XqE+umEmsSqteJhwTroaCr1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xpIFPTZQr0g3xRCPusrGDi9fMWXkv23vj9IPJLmKgbE=;
        b=ZxpJ+x2zbzbpzR/eKHg22CaUZKg6OswHzFMRrrRBLHnShl78JaWmG1MMjTR8qcBILR
         hYMfL266/Vx6SWppmOv4bosDs85w25SKaPJf4PoI5kIko2I7kLqr5Hpb0IfyA3kVDyy+
         r6LCjgtDaL37qmBOZk/PirNI1uBm0JeQgcGBDiAlOUoDJy53Oxxg8AiqRBf3RCmRoaNH
         8Kj1f8k3OkFGc0L3y8V1DDn/YsSZajNe+JGO63lliI1buroCSmgSXXBsqufqYE2h6Yjl
         ugWgRZHCqmJmythEsCiZtfdmkgBx/VJjRe8fmLnVO1/+Fi1YEEmSct2JNLL02HbiEVEC
         SCYw==
X-Gm-Message-State: APjAAAWdoIRgJtvTewZV3vrRw37Pc5wOGDN6j9J1cD0c+v5kbYwoFFAr
        z2iM21J2ACQTH/LlZWfR5KY4Zw==
X-Google-Smtp-Source: APXvYqyaAfXovzDycNls/rhUePW03AQsspPZUOsUaN3Xl99mi3nkjczVadwSkzA++KdF34Q/u6YSHg==
X-Received: by 2002:a0d:dd50:: with SMTP id g77mr28042515ywe.309.1554827775078;
        Tue, 09 Apr 2019 09:36:15 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id f133sm12824468ywb.107.2019.04.09.09.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:36:14 -0700 (PDT)
Subject: Re: [PATCH 07/22] watchdog: bcm_kona_wdt: Convert to use device
 managed functions and other improvements
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
 <1554752326-13319-8-git-send-email-linux@roeck-us.net>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <b4b1e6c1-cbc4-1369-4518-26a2ba20b597@broadcom.com>
Date:   Tue, 9 Apr 2019 09:36:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554752326-13319-8-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/2019 12:38 PM, Guenter Roeck wrote:
> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> Other improvements as listed below.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Use local variable 'struct device *dev' consistently
> - Use devm_watchdog_register_driver() to register watchdog device
> - Replace shutdown function with call to watchdog_stop_on_reboot()
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/bcm_kona_wdt.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
> index d52334ab0805..e2ad44816359 100644
> --- a/drivers/watchdog/bcm_kona_wdt.c
> +++ b/drivers/watchdog/bcm_kona_wdt.c
> @@ -271,11 +271,6 @@ static struct watchdog_device bcm_kona_wdt_wdd = {
>  	.timeout =	SECWDOG_MAX_COUNT >> SECWDOG_DEFAULT_RESOLUTION,
>  };
>  
> -static void bcm_kona_wdt_shutdown(struct platform_device *pdev)
> -{
> -	bcm_kona_wdt_stop(&bcm_kona_wdt_wdd);
> -}
> -
>  static int bcm_kona_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -301,7 +296,7 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, wdt);
>  	watchdog_set_drvdata(&bcm_kona_wdt_wdd, wdt);
> -	bcm_kona_wdt_wdd.parent = &pdev->dev;
> +	bcm_kona_wdt_wdd.parent = dev;
>  
>  	ret = bcm_kona_wdt_set_timeout_reg(&bcm_kona_wdt_wdd, 0);
>  	if (ret) {
> @@ -309,7 +304,9 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = watchdog_register_device(&bcm_kona_wdt_wdd);
> +	watchdog_stop_on_reboot(&bcm_kona_wdt_wdd);
> +	watchdog_stop_on_unregister(&bcm_kona_wdt_wdd);
> +	ret = devm_watchdog_register_device(dev, &bcm_kona_wdt_wdd);
>  	if (ret) {
>  		dev_err(dev, "Failed to register watchdog device");
>  		return ret;
> @@ -324,8 +321,6 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
>  static int bcm_kona_wdt_remove(struct platform_device *pdev)
>  {
>  	bcm_kona_wdt_debug_exit(pdev);
> -	bcm_kona_wdt_shutdown(pdev);
> -	watchdog_unregister_device(&bcm_kona_wdt_wdd);
>  	dev_dbg(&pdev->dev, "Watchdog driver disabled");
>  
>  	return 0;
> @@ -344,7 +339,6 @@ static struct platform_driver bcm_kona_wdt_driver = {
>  		  },
>  	.probe = bcm_kona_wdt_probe,
>  	.remove = bcm_kona_wdt_remove,
> -	.shutdown = bcm_kona_wdt_shutdown,
>  };
>  
>  module_platform_driver(bcm_kona_wdt_driver);
> 

Change looks good to me. Thanks!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
