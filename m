Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B88C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3557D20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzuJF1Lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbfDJMJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:09:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43886 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbfDJMJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:09:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so1307208plp.10;
        Wed, 10 Apr 2019 05:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P9/qECQB27HLydIa4oROR36cY5V7hC0m0n0SnzgnDQw=;
        b=RzuJF1LhGc3wLsvmooNyFOUhJSMB9AsPrPGXRlnTWtOnaRuNN5P9mNcDDwdmSBy9Fh
         fUY9EmX+mxdXwwBISD28RzwdH2PPp9W0R65Am5oxmXq5ORx/e3qArR7tkmWNk7Qjlidw
         cvXWWPWdvjKKmAeS9YGuOcvkm35ooNegx2uliamLx2sSGx+aUO+Mwy6DZbJ2ZUqav6Iq
         w7qWlelWOBHzfyh/T+I+e3yYI7lMVkn2Xeg+yEVDt8Zb9Fiso//zb+mKhoEwYRDQydfc
         1z6+hef5G3T/T0/O+ait1VPrDpWZN79SQ+6QWFaX+emeAAdrLriDPrhQWFTcMgBuSFkL
         d+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P9/qECQB27HLydIa4oROR36cY5V7hC0m0n0SnzgnDQw=;
        b=qumgxAeUJaNF8tixBxXXrmNfxXowvb77ccNhqRqf7nl5H5q2wPBFMwvtPKeSJOqQpF
         qPCiBhA5NUGNdH6rXbhkuO0WYKXP9zsyPJR6tmF4DPyRWDyWJbBqTU7omQdp/e+82jGp
         9YsrN6YyN15W6Z8NZsIQJbSfb7F70hga/TvHTjc9FJvbnD+lCATU19txWASMUOMfsOzD
         r3jgLywh3p+AVmUMCs2tybZ6NR30AQZ58TYgzS6BYVDl1E5nq0If8BGfCYlPR4u3zYdY
         cHesOcVYE0kEF2ixjJRDsfXlkGS5O1LIu/IySss9kDZdC1xLQ1c7kJaLWKCWAs4FBWSh
         Osaw==
X-Gm-Message-State: APjAAAX9QK5S4Tno8eoiDH6M/h+IcTPxbexeF1shXvbWlO3M/KvksJYz
        BzCUuwEdj6FUrP7lcU3YuZ4YenFy
X-Google-Smtp-Source: APXvYqxV/GyoOyxWLBTx4eQnUTAfcFz2hdwQZzmxlAYwoMBQvG6TQ9majjE9Str3AWf9Mjyi6omZAQ==
X-Received: by 2002:a17:902:599d:: with SMTP id p29mr17503573pli.156.1554898160816;
        Wed, 10 Apr 2019 05:09:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t21sm15015320pfe.22.2019.04.10.05.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 05:09:19 -0700 (PDT)
Subject: Re: [PATCH 10/23] watchdog: of_xilinx_wdt: Convert to use device
 managed functions and other improvements
To:     Michal Simek <michal.simek@xilinx.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
 <1554830641-9247-11-git-send-email-linux@roeck-us.net>
 <85e92d6f-5521-af0a-f6e0-b3411b7cd8e9@xilinx.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0946e8ae-e829-807f-2e56-a27c67da7073@roeck-us.net>
Date:   Wed, 10 Apr 2019 05:09:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <85e92d6f-5521-af0a-f6e0-b3411b7cd8e9@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 11:38 PM, Michal Simek wrote:
> On 09. 04. 19 19:23, Guenter Roeck wrote:
>> Use device managed functions to simplify error handling, reduce
>> source code size, improve readability, and reduce the likelyhood of bugs.
>> Other improvements as listed below.
>>
>> The conversion was done automatically with coccinelle using the
>> following semantic patches. The semantic patches and the scripts
>> used to generate this commit log are available at
>> https://github.com/groeck/coccinelle-patches
>>
>> - Drop assignments to otherwise unused variables
>> - Drop empty remove function
>> - Use devm_add_action_or_reset() for calls to clk_disable_unprepare
>> - Introduce local variable 'struct device *dev' and use it instead of
>>    dereferencing it repeatedly
>> - Use devm_watchdog_register_driver() to register watchdog device
>>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/watchdog/of_xilinx_wdt.c | 58 ++++++++++++++++++----------------------
>>   1 file changed, 26 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
>> index 5c977164b3e5..03786992b701 100644
>> --- a/drivers/watchdog/of_xilinx_wdt.c
>> +++ b/drivers/watchdog/of_xilinx_wdt.c
>> @@ -151,41 +151,46 @@ static u32 xwdt_selftest(struct xwdt_device *xdev)
>>   		return XWT_TIMER_FAILED;
>>   }
>>   
>> +static void xwdt_clk_disable_unprepare(void *data)
>> +{
>> +	clk_disable_unprepare(data);
>> +}
>> +
>>   static int xwdt_probe(struct platform_device *pdev)
>>   {
>> +	struct device *dev = &pdev->dev;
>>   	int rc;
>>   	u32 pfreq = 0, enable_once = 0;
>>   	struct xwdt_device *xdev;
>>   	struct watchdog_device *xilinx_wdt_wdd;
>>   
>> -	xdev = devm_kzalloc(&pdev->dev, sizeof(*xdev), GFP_KERNEL);
>> +	xdev = devm_kzalloc(dev, sizeof(*xdev), GFP_KERNEL);
>>   	if (!xdev)
>>   		return -ENOMEM;
>>   
>>   	xilinx_wdt_wdd = &xdev->xilinx_wdt_wdd;
>>   	xilinx_wdt_wdd->info = &xilinx_wdt_ident;
>>   	xilinx_wdt_wdd->ops = &xilinx_wdt_ops;
>> -	xilinx_wdt_wdd->parent = &pdev->dev;
>> +	xilinx_wdt_wdd->parent = dev;
>>   
>>   	xdev->base = devm_platform_ioremap_resource(pdev, 0);
>>   	if (IS_ERR(xdev->base))
>>   		return PTR_ERR(xdev->base);
>>   
>> -	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-interval",
>> +	rc = of_property_read_u32(dev->of_node, "xlnx,wdt-interval",
>>   				  &xdev->wdt_interval);
>>   	if (rc)
>> -		dev_warn(&pdev->dev,
>> -			 "Parameter \"xlnx,wdt-interval\" not found\n");
>> +		dev_warn(dev, "Parameter \"xlnx,wdt-interval\" not found\n");
>>   
>> -	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-enable-once",
>> +	rc = of_property_read_u32(dev->of_node, "xlnx,wdt-enable-once",
>>   				  &enable_once);
>>   	if (rc)
>> -		dev_warn(&pdev->dev,
>> +		dev_warn(dev,
>>   			 "Parameter \"xlnx,wdt-enable-once\" not found\n");
>>   
>>   	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
>>   
>> -	xdev->clk = devm_clk_get(&pdev->dev, NULL);
>> +	xdev->clk = devm_clk_get(dev, NULL);
>>   	if (IS_ERR(xdev->clk)) {
>>   		if (PTR_ERR(xdev->clk) != -ENOENT)
>>   			return PTR_ERR(xdev->clk);
>> @@ -196,10 +201,10 @@ static int xwdt_probe(struct platform_device *pdev)
>>   		 */
>>   		xdev->clk = NULL;
>>   
>> -		rc = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>> +		rc = of_property_read_u32(dev->of_node, "clock-frequency",
>>   					  &pfreq);
>>   		if (rc)
>> -			dev_warn(&pdev->dev,
>> +			dev_warn(dev,
>>   				 "The watchdog clock freq cannot be obtained\n");
>>   	} else {
>>   		pfreq = clk_get_rate(xdev->clk);
>> @@ -218,44 +223,34 @@ static int xwdt_probe(struct platform_device *pdev)
>>   
>>   	rc = clk_prepare_enable(xdev->clk);
>>   	if (rc) {
>> -		dev_err(&pdev->dev, "unable to enable clock\n");
>> +		dev_err(dev, "unable to enable clock\n");
>>   		return rc;
>>   	}
>> +	rc = devm_add_action_or_reset(dev, xwdt_clk_disable_unprepare,
>> +				      xdev->clk);
>> +	if (rc)
>> +		return rc;
>>   
>>   	rc = xwdt_selftest(xdev);
>>   	if (rc == XWT_TIMER_FAILED) {
>> -		dev_err(&pdev->dev, "SelfTest routine error\n");
>> -		goto err_clk_disable;
>> +		dev_err(dev, "SelfTest routine error\n");
>> +		return rc;
>>   	}
>>   
>> -	rc = watchdog_register_device(xilinx_wdt_wdd);
>> +	rc = devm_watchdog_register_device(dev, xilinx_wdt_wdd);
>>   	if (rc) {
>> -		dev_err(&pdev->dev, "Cannot register watchdog (err=%d)\n", rc);
>> -		goto err_clk_disable;
>> +		dev_err(dev, "Cannot register watchdog (err=%d)\n", rc);
>> +		return rc;
>>   	}
>>   
>>   	clk_disable(xdev->clk);
>>   
>> -	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
>> +	dev_info(dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
>>   		 xdev->base, xilinx_wdt_wdd->timeout);
>>   
>>   	platform_set_drvdata(pdev, xdev);
>>   
>>   	return 0;
>> -err_clk_disable:
>> -	clk_disable_unprepare(xdev->clk);
>> -
>> -	return rc;
>> -}
>> -
>> -static int xwdt_remove(struct platform_device *pdev)
>> -{
>> -	struct xwdt_device *xdev = platform_get_drvdata(pdev);
>> -
>> -	watchdog_unregister_device(&xdev->xilinx_wdt_wdd);
>> -	clk_disable_unprepare(xdev->clk);
>> -
>> -	return 0;
>>   }
>>   
>>   /**
>> @@ -303,7 +298,6 @@ MODULE_DEVICE_TABLE(of, xwdt_of_match);
>>   
>>   static struct platform_driver xwdt_driver = {
>>   	.probe       = xwdt_probe,
>> -	.remove      = xwdt_remove,
>>   	.driver = {
>>   		.name  = WATCHDOG_NAME,
>>   		.of_match_table = xwdt_of_match,
>>
> 
> Looks good to me. I would prefer to do it via 3 patches but I will let
> Wim to comment.
> 

I could do that, but the total series is already more than 60 patches.
Splitting them up would mean hundreds of patches.

> Acked-by: Michal Simek <michal.simek@xilinx.com>
> 

Thanks,
Guenter
