Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC49C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E93206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDoibyed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfDPQsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:48:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42921 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPQsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:48:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so28023665wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hw9EKvdn6C8hf0+XO/MtInCImrRvmuEaZu1qoCQTskU=;
        b=KDoibyedSqsHM84JGq0m00J7uB/e58akaWZ82W3M0mYeSGyz1UdYSshucRiETOW8yl
         zPrQEUZB+c6Ub0UZTqhfRRIRTj+nNnfi72Zzq1JF4wAK3e3ROr9eEc787JOJIAmSlb88
         jO0sIk8ziA9us58hXy1Z/a9fINbJNgedCVsF15jU+U8HW9oepRyeTBMCgj+7+lUAF5C7
         TLEfqYEoCUuGQFPnp/g4K+qS5MhVtRoesKDadF4xLgoH36k79UVxY6ImPI90ntxdZHjy
         bg3vZWebSdVrG/AveSR/SCr1EZSRgAppXmcN5eLpBdSi6RIvOvKcMpTQ4w9SDYw78DDo
         UUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hw9EKvdn6C8hf0+XO/MtInCImrRvmuEaZu1qoCQTskU=;
        b=tis4HsIIqN28gvv/j6TmN9gw/e1GYgvdLaVAIp0/QVtKTQEa5sFejOSiGvCwUW67KI
         dWBBSf4ua0QxW5VnucnFAC95ZmkM7+1jN8App8d+cfzVSPy270zeEnBkIcklK0SfXTkK
         HBUJwpcLkAMWxUrK7pMRZlcw/kneyorUAQx0IDAX40ZcPsyq3sl2HYkbtnR/+PkvtuUe
         Otmdrrzl5/CWPfI+KHhh6+SLJ7sxp7o235Dw9p7TTB7BZd3dV9d2je6aymg7XpM0VuIW
         52oxr88S5/6tASmZPy4/0QjmtCu1XpCMkwsY4qW5WOuyMxZuY3zePKWhYl/cVKawJQ5d
         JXHA==
X-Gm-Message-State: APjAAAVKboCcxpUhvdhajqNeXb8u/QE+ejsZepAT5hO/eU49AS9YHHpK
        N+Yr3Pm7vkRavkevRixvDobRDwyl0fM=
X-Google-Smtp-Source: APXvYqzM0jJPaHk6PzOi3fz+tIpWpCznGYf60h0DMIJb7lQwU/+vSUnkqTA67e0HKS8w9AT5Gl1/dg==
X-Received: by 2002:adf:edca:: with SMTP id v10mr24543947wro.157.1555433317107;
        Tue, 16 Apr 2019 09:48:37 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id u189sm24840530wme.25.2019.04.16.09.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:48:36 -0700 (PDT)
Subject: Re: [PATCH] clocksource: timer-probe: change log level to info
To:     Moses Christopher <moseschristopherb@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20190416163230.4992-1-moseschristopherb@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fb216787-fb0f-6d22-7984-1f5cefd8f72f@linaro.org>
Date:   Tue, 16 Apr 2019 18:48:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416163230.4992-1-moseschristopherb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2019 18:32, Moses Christopher wrote:
>   - In drivers/clocksource/timer-probe.c, the log level for the message
>     stating "no matching timers found" should be informational rather
>     than critical.
>   - Reference:
>      - https://e2e.ti.com/support/processors/f/791/t/726024

Thanks for the pointer.

Actually in most of the cases when there are no timers found after this
sequence it is because a definition is missing in the DT or the timer
was not able to initialize and we end up with a stuck board at boot time.

May be pr_warn would be more appropriate in this case.

However, if this omap board can boot without DT defined timers, does it
make sense to run the timer-probe code?


> Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
> ---
>  drivers/clocksource/timer-probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
> index 028075720334..f0dcb41e079f 100644
> --- a/drivers/clocksource/timer-probe.c
> +++ b/drivers/clocksource/timer-probe.c
> @@ -50,5 +50,5 @@ void __init timer_probe(void)
>  	timers += acpi_probe_device_table(timer);
>  
>  	if (!timers)
> -		pr_crit("%s: no matching timers found\n", __func__);
> +		pr_info("%s: no matching timers found\n", __func__);
>  }
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

