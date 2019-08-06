Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C390C32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5236C20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvXxUdcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbfHFLEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:04:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39411 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730877AbfHFLEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:04:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so37780591pls.6;
        Tue, 06 Aug 2019 04:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oCsbQYgd4TTh/txNzms60bQxNH/zNuMkNW05qPXIyqc=;
        b=gvXxUdcq9/zEpEC2eKuUxRb8GnAFlHAXDIQ+P4f5v4rrFWnWz6Z8R3j308GwgZaCVh
         oNvJin5de5+5sx+yI2vKUWAUrmCnAcN8YLh2MA7DzlPZ9EQ0peX0YX5BgaZAFnhvPphh
         nzyyHimh54Lcvbkqqtjkhw6H1BZTXIRT0+71N7BIn5LJwO5+0GHi/hxcZ0VckDdVH//w
         MoVzxpOgCnY8c9HEpuEXusoRnDxRRQdokzTLuVQiBVfcZZjhLn6ZQ6TNDj/n+3ffIUwF
         EXQ7pIc6pdZs+ZfbrnmXp5AuesgUnlVOPq+WJhRoZB9tSO3hqgqnhZGAV3iXWS9t0qjh
         Wd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oCsbQYgd4TTh/txNzms60bQxNH/zNuMkNW05qPXIyqc=;
        b=prmIJXbnakW4JHXYUB8oNE9ckCBQS2PPVtsgo3oH991Kfvfo19AoBgwzQ61/Rlne7/
         GLYVAD8RSUuS8Lhiv2f2yrxiEee8kIpzNizYj+3OYNThfO15TJsD+mejIpGXIew2bxMQ
         QHVxxsle5XEXpybqA+EsUgYiHga5FR3fFHFxs8uGUvV5gO5nvUCth4oKZuDizwzyRy7n
         ZkCzcHSV1pjyqy+U/f4Qs4NX/dYjtWNZgunw5KG9W6SVjWGYL8Z1kGgBPJCaDW9N4NXh
         zLzmY+wVCMeK+AgV451OmEL/j8DBYokYJ5QiMn3L9z7ENg2/9xUOYJh8yjwwXick9OFq
         HPEw==
X-Gm-Message-State: APjAAAVsGvzmH9Wv5UyVs7I13nbQ2jcO98hLA0vEvulg3ikH3okRd/em
        It0fxGwjqVVSCCJQkoDmm5xzlcch
X-Google-Smtp-Source: APXvYqwhQbGHsLwtJvdBjR685yo7EvSLuv5Vex6Io0nCai2EsohoFVXylbpr3nXiJ2kJmsFax5sAag==
X-Received: by 2002:a17:902:8207:: with SMTP id x7mr2638026pln.63.1565089450725;
        Tue, 06 Aug 2019 04:04:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g92sm24987906pje.11.2019.08.06.04.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 04:04:09 -0700 (PDT)
Subject: Re: [PATCH] watchdog: jz4740: Fix unused variable warning in
 jz4740_wdt_probe
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190806073953.GA13685@embeddedor>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9c93e60f-4122-282c-db28-0b6dd64af3d5@roeck-us.net>
Date:   Tue, 6 Aug 2019 04:04:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806073953.GA13685@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 12:39 AM, Gustavo A. R. Silva wrote:
> Fix the following warning (Building: ci20_defconfig mips):
> 
> drivers/watchdog/jz4740_wdt.c: In function ‘jz4740_wdt_probe’:
> drivers/watchdog/jz4740_wdt.c:165:6: warning: unused variable ‘ret’ [-Wunused-variable]
>    int ret;
>        ^~~
> Fixes: 9ee644c9326c ("watchdog: jz4740_wdt: drop warning after registering device")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/jz4740_wdt.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index d4a90916dd38..c6052ae54f32 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -162,7 +162,6 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct jz4740_wdt_drvdata *drvdata;
>   	struct watchdog_device *jz4740_wdt;
> -	int ret;
>   
>   	drvdata = devm_kzalloc(dev, sizeof(struct jz4740_wdt_drvdata),
>   			       GFP_KERNEL);
> 

