Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2F5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D5320857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQcRgJzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfDIRjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:39:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42138 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfDIRjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:39:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so9704885pgh.9;
        Tue, 09 Apr 2019 10:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FkWPlTNyww3Y5PNxC/9hBUyclKUMgys/V7yUT22pasA=;
        b=AQcRgJzXByHl0Ttybwx74DlfBhhJA4cEUauuz//fp+koIwrpxDms6wBonCP48oXOHG
         1yAckvH14dgl2vRVSuva2woqsGhUHcOqMLqL3BPTaLFJOF2FJ90JiTx/dSX8VzRkDBtC
         FkmDk8oVNY7m1k+ULQTUSura917cMTrPWrkPgIeluubIQA6hYx07gztP4wY1Mp+lVUxC
         KErCIT+BGSH/ui0bnQgW93+U7uWj+i1KQLbxspQNkvaxaym0ehFO6LGrwX9GhS185K6k
         4z5qEfGZ8rwTRQAnxwVDXM4lJuFkvVOpS1YhDrY6f5g0f1bGlKA8rLZ73eQ2t7XxFtp6
         l9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FkWPlTNyww3Y5PNxC/9hBUyclKUMgys/V7yUT22pasA=;
        b=ujoKjPXrFZg01AIiiAteAC/SAHvR1SqUNIbex4Yj/npJ24ny7QMGhanlMI6F5qebkF
         EMFt9wF9Ea7ZRvX6cmpcYsrPi3TQ0XWhZKBGTnXBqbbQjOMLnamEGGnEf1aiJ5c3T/jF
         Thk42FTeMYeh+WAPYklmXxmnsKqGEZejFEjhJFXC8+Filo2MjiNR+m81kfuzcNRuMKnq
         imhS43x+oe4jXL1EkRMZYr062AiXY70ibqYlGbdshjnDPhUuEOIz2lLNjAL4LOlz+tL9
         PfWK2EZs3dBxu22ddFcVBZrQJHspWYe+wMK0TFCCQWZKg0fkLpGcZsYFgUDEf4BYsWYE
         fmVA==
X-Gm-Message-State: APjAAAUI8+UFk/yBbrWJ+nI+Q1v/2hOLd7Vl6iTC/xgIh2aln4By8A2X
        uVvRSqOdEJwJblX4ptkBqiw=
X-Google-Smtp-Source: APXvYqyTSylcczp2n6f+PXTzdmiNRBQf95DCx+6DzslAwdr9HNXT1jFrTGAEhFFJntojbw0ryDOPcA==
X-Received: by 2002:a65:64cf:: with SMTP id t15mr34944580pgv.322.1554831540982;
        Tue, 09 Apr 2019 10:39:00 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t82sm90606016pfa.153.2019.04.09.10.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:39:00 -0700 (PDT)
Date:   Tue, 9 Apr 2019 10:38:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/23] watchdog: 1: Convert to use device managed
 functions and other improvements
Message-ID: <20190409173859.GA15798@roeck-us.net>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
 <1554830641-9247-19-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554830641-9247-19-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 10:23:56AM -0700, Guenter Roeck wrote:
> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> Other improvements as listed below.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Replace devm_add_action() followed by failure action with
>   devm_add_action_or_reset()
> - Replace 'val = e; return val;' with 'return e;'
> - Introduce local variable 'struct device *dev' and use it instead of
>   dereferencing it repeatedly
> - Use devm_watchdog_register_driver() to register watchdog device
> 
Hmm, something went wrong with the subject line. Should have been
"watchdog: sprd_wdt:". Sorry for that.

Guenter

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/sprd_wdt.c | 38 ++++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
> index a63163a93777..14874e9b207b 100644
> --- a/drivers/watchdog/sprd_wdt.c
> +++ b/drivers/watchdog/sprd_wdt.c
> @@ -245,9 +245,7 @@ static u32 sprd_wdt_get_timeleft(struct watchdog_device *wdd)
>  	u32 val;
>  
>  	val = sprd_wdt_get_cnt_value(wdt);
> -	val = val / SPRD_WDT_CNT_STEP;
> -
> -	return val;
> +	return val / SPRD_WDT_CNT_STEP;
>  }
>  
>  static const struct watchdog_ops sprd_wdt_ops = {
> @@ -269,10 +267,11 @@ static const struct watchdog_info sprd_wdt_info = {
>  
>  static int sprd_wdt_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct sprd_wdt *wdt;
>  	int ret;
>  
> -	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>  	if (!wdt)
>  		return -ENOMEM;
>  
> @@ -280,57 +279,56 @@ static int sprd_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(wdt->base))
>  		return PTR_ERR(wdt->base);
>  
> -	wdt->enable = devm_clk_get(&pdev->dev, "enable");
> +	wdt->enable = devm_clk_get(dev, "enable");
>  	if (IS_ERR(wdt->enable)) {
> -		dev_err(&pdev->dev, "can't get the enable clock\n");
> +		dev_err(dev, "can't get the enable clock\n");
>  		return PTR_ERR(wdt->enable);
>  	}
>  
> -	wdt->rtc_enable = devm_clk_get(&pdev->dev, "rtc_enable");
> +	wdt->rtc_enable = devm_clk_get(dev, "rtc_enable");
>  	if (IS_ERR(wdt->rtc_enable)) {
> -		dev_err(&pdev->dev, "can't get the rtc enable clock\n");
> +		dev_err(dev, "can't get the rtc enable clock\n");
>  		return PTR_ERR(wdt->rtc_enable);
>  	}
>  
>  	wdt->irq = platform_get_irq(pdev, 0);
>  	if (wdt->irq < 0) {
> -		dev_err(&pdev->dev, "failed to get IRQ resource\n");
> +		dev_err(dev, "failed to get IRQ resource\n");
>  		return wdt->irq;
>  	}
>  
> -	ret = devm_request_irq(&pdev->dev, wdt->irq, sprd_wdt_isr,
> -			       IRQF_NO_SUSPEND, "sprd-wdt", (void *)wdt);
> +	ret = devm_request_irq(dev, wdt->irq, sprd_wdt_isr, IRQF_NO_SUSPEND,
> +			       "sprd-wdt", (void *)wdt);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to register irq\n");
> +		dev_err(dev, "failed to register irq\n");
>  		return ret;
>  	}
>  
>  	wdt->wdd.info = &sprd_wdt_info;
>  	wdt->wdd.ops = &sprd_wdt_ops;
> -	wdt->wdd.parent = &pdev->dev;
> +	wdt->wdd.parent = dev;
>  	wdt->wdd.min_timeout = SPRD_WDT_MIN_TIMEOUT;
>  	wdt->wdd.max_timeout = SPRD_WDT_MAX_TIMEOUT;
>  	wdt->wdd.timeout = SPRD_WDT_MAX_TIMEOUT;
>  
>  	ret = sprd_wdt_enable(wdt);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to enable wdt\n");
> +		dev_err(dev, "failed to enable wdt\n");
>  		return ret;
>  	}
> -	ret = devm_add_action(&pdev->dev, sprd_wdt_disable, wdt);
> +	ret = devm_add_action_or_reset(dev, sprd_wdt_disable, wdt);
>  	if (ret) {
> -		sprd_wdt_disable(wdt);
> -		dev_err(&pdev->dev, "Failed to add wdt disable action\n");
> +		dev_err(dev, "Failed to add wdt disable action\n");
>  		return ret;
>  	}
>  
>  	watchdog_set_nowayout(&wdt->wdd, WATCHDOG_NOWAYOUT);
> -	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
> +	watchdog_init_timeout(&wdt->wdd, 0, dev);
>  
> -	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
> +	ret = devm_watchdog_register_device(dev, &wdt->wdd);
>  	if (ret) {
>  		sprd_wdt_disable(wdt);
> -		dev_err(&pdev->dev, "failed to register watchdog\n");
> +		dev_err(dev, "failed to register watchdog\n");
>  		return ret;
>  	}
>  	platform_set_drvdata(pdev, wdt);
