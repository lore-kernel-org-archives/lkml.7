Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A41C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EA4217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aC8u2hYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfEJGmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 02:42:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35967 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfEJGmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 02:42:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so2518135pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 23:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cVET4/9VEsoCcizpYYKFH4n+sy/V1MxHnMW8LTHhZfg=;
        b=aC8u2hYRX4tsUez/u0xmNE7+uVk5cv7e8jNX9ogNqizuaN6/WHmJWCRz/rp3UDDHmH
         Wyn+2xK24//ospIkqqhWogp9vWbfgSek9MQ1eRjnqctK7NG8+kTIdUBZ9w9T1qNjy02H
         xa0H0lX0WY9FNenlLh2pT3BXErU6176dsBznn4VCggHpBzu9HgJ3iuVI/ZWcAGGeETdi
         ZQHnozRKcTPoxaJ8WdYUzekaMqeEmayyJ9yI02O8P0oWMcTLT3FaRddu48HkP6RPE/sT
         rZyW2QA7hErFTKVtXSn8QXBCkPCvTna+mWEGd/RU4YfL9smybzbhZltRG1mstb7796DG
         sQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cVET4/9VEsoCcizpYYKFH4n+sy/V1MxHnMW8LTHhZfg=;
        b=CH2K97/owjIkDPW9ojyjZlZVhUWSAesL6kAKkuEtdrqL2T34uELJigGAFp9u8teXPU
         eXbtoLmhP/S6oIfS/0Hx5y0AnnAy3eyRdV+4iTUMtg9w/v+l+0Ii1kGYnOaXJUHAoKa6
         wZQujvU47aS9giSNcLw2PB1mRGV/VZtBbJnMEnbe/5de0Yy6G5ftMdF/Xn58e7KnxP1m
         3Kw3fzntzT7P0dP2HPqLg4q1Tq1O03Kv6ZFKHitXkP/sKe29LYtfrm+Xv9SVEdTNzMO7
         rXVghbtYkPROYocnATcyOCO9NC1e0M/edpDpiVUybDeXiM+G66Qhsg7xjQOt44ppIMpV
         bZgA==
X-Gm-Message-State: APjAAAVa1g+nqNZvCY21j8c986b4U7xpFMzsNEfpj0TAZ+f8xRkT5SIu
        HxLwnYlyPuTCxjo+bYYhAmp7pw==
X-Google-Smtp-Source: APXvYqyIVlmyLENCmzXI2xDiln+nLBG+l8JXPiF+cfeQ2YJ4wiiz54LiMocSDujnrU9Gf9BkRdwwvA==
X-Received: by 2002:a62:2687:: with SMTP id m129mr11991540pfm.204.1557470569520;
        Thu, 09 May 2019 23:42:49 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id s11sm5733051pga.36.2019.05.09.23.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 23:42:48 -0700 (PDT)
Date:   Fri, 10 May 2019 12:12:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] thermal: cpu_cooling: Actually trace CPU load in
 thermal_power_cpu_get_power
Message-ID: <20190510064246.fanpmhdlbtpngzor@vireshk-i7>
References: <20190502183238.182058-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502183238.182058-1-mka@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-05-19, 11:32, Matthias Kaehlcke wrote:
> The CPU load values passed to the thermal_power_cpu_get_power
> tracepoint are zero for all CPUs, unless, unless the
> thermal_power_cpu_limit tracepoint is enabled too:
> 
>   irq/41-rockchip-98    [000] ....   290.972410: thermal_power_cpu_get_power:
>   cpus=0000000f freq=1800000 load={{0x0,0x0,0x0,0x0}} dynamic_power=4815
> 
> vs
> 
>   irq/41-rockchip-96    [000] ....    95.773585: thermal_power_cpu_get_power:
>   cpus=0000000f freq=1800000 load={{0x56,0x64,0x64,0x5e}} dynamic_power=4959
>   irq/41-rockchip-96    [000] ....    95.773596: thermal_power_cpu_limit:
>   cpus=0000000f freq=408000 cdev_state=10 power=416
> 
> There seems to be no good reason for omitting the CPU load information
> depending on another tracepoint. My guess is that the intention was to
> check whether thermal_power_cpu_get_power is (still) enabled, however
> 'load_cpu != NULL' already indicates that it was at least enabled when
> cpufreq_get_requested_power() was entered, there seems little gain
> from omitting the assignment if the tracepoint was just disabled, so
> just remove the check.
> 
> Fixes: 6828a4711f99 ("thermal: add trace events to the power allocator governor")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/cpu_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index f7c1f49ec87f..b437804e099b 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -458,7 +458,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
>  			load = 0;
>  
>  		total_load += load;
> -		if (trace_thermal_power_cpu_limit_enabled() && load_cpu)
> +		if (load_cpu)
>  			load_cpu[i] = load;
>  
>  		i++;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
