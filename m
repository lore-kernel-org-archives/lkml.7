Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC434C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3A720B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL+CRB0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfFSAlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 20:41:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53704 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFSAlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 20:41:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so5147617wmj.3;
        Tue, 18 Jun 2019 17:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4SHCjBMan004B+ijIlPx4Pn3xROU+n7uFgrQp2KsfSs=;
        b=eL+CRB0yQi9G/o531hvb2YOujfgf1xcnevSWIFFukShk/sDef498WkAoHShxPC0m5T
         rqVJ2SJmmL98sI2FQeVeYLw/N85A/Zud1WJ1MTjr0HoolcTeFcV6EHzwFE7mWNmpBldY
         bIyiM9by8ogLGzdelWaDbzAAsKwCfAeIPeTSpagrI+6N9btBBid0mHUDvxGzdEmTifF7
         GjmxXLlLfVfv78OSH1Wa5CXrNhb0WwRLUNpvqGyf2ft/h9xYqcMFtG+I4jUJc0Y0fJsn
         qtPk/rLLEkEwbhZ8FwyzVDSpfmPI/OIXbw4u857NjtcZNrir+ke/9Oz1ZB9cIB20vfY1
         8kFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4SHCjBMan004B+ijIlPx4Pn3xROU+n7uFgrQp2KsfSs=;
        b=K2dUuDi79vUqAu0W06t7NuZkQ7Zde/yhEtl1mnGG8Z2swlxEULgQXEudDw0DhoFDix
         zVs1+BBb68bFGyTNLa2ipAdifDPl1XWvBjpC9F92ndrTk82mLaQ4HN36cvwxWeiVUJ2J
         JHRvlmpKsWsqilecA6mUpwGKV3GlZcNfNsTOJcpXZC+XgJEOxn+ewwcm2TYUuWR9y70w
         dyKZo/SmXlx77b/+7+NeZlHwZ/sdqYNS8k5mSdvi2axnWGl//HOXSS4pQcGm43TN7wEd
         ny5ic0nOWdF9iKqz/UZ5aFLoOhiQJTVTRwNKenf9mYtgk4OopVCInRU3y8D+mpOKv4AL
         f91A==
X-Gm-Message-State: APjAAAV83LmFJjGzt0HItD/wkrLxkZkNKCensHkLZ2imexhcC5azFSIC
        CL8De1DTLGw6R8YYDr+9JChzAg7a
X-Google-Smtp-Source: APXvYqyM5EDqjy/4xxrG+0PX2bsz4GstmJ3Q06xdocP3+YhT8u2Fk4bpcgwr500Dp8PQQLTiXPHvrA==
X-Received: by 2002:a1c:a686:: with SMTP id p128mr157437wme.163.1560904867553;
        Tue, 18 Jun 2019 17:41:07 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id n10sm15767722wrw.83.2019.06.18.17.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 17:41:06 -0700 (PDT)
Subject: Re: [PATCH v3 3/8] clocksource/drivers/tegra: Set and use timer's
 period
To:     Jon Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-4-digetx@gmail.com>
 <16c20c1b-d106-cb1e-6d67-bdd402ecf57f@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <17556fe2-8481-258a-9be9-2598da0a67eb@gmail.com>
Date:   Wed, 19 Jun 2019 03:41:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <16c20c1b-d106-cb1e-6d67-bdd402ecf57f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.06.2019 19:32, Jon Hunter пишет:
> 
> On 18/06/2019 15:03, Dmitry Osipenko wrote:
>> The of_clk structure has a period field that is set up initially by
>> timer_of_clk_init(), that period value need to be adjusted for a case of
>> TIMER1-9 that are running at a fixed rate that doesn't match the clock's
>> rate. Note that the period value is currently used only by some of the
>> clocksource drivers internally and hence this is just a minor cleanup
>> change that doesn't fix anything.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/clocksource/timer-tegra.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
>> index ff5a4ccb5d52..e6221e070499 100644
>> --- a/drivers/clocksource/timer-tegra.c
>> +++ b/drivers/clocksource/timer-tegra.c
>> @@ -71,9 +71,9 @@ static int tegra_timer_shutdown(struct clock_event_device *evt)
>>  static int tegra_timer_set_periodic(struct clock_event_device *evt)
>>  {
>>  	void __iomem *reg_base = timer_of_base(to_timer_of(evt)); 
>> +	unsigned long period = timer_of_period(to_timer_of(evt));
>>  
>> -	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER |
>> -		       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
>> +	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER | (period - 1),
>>  		       reg_base + TIMER_PTV);
>>  
>>  	return 0;
>> @@ -297,6 +297,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>>  		cpu_to->clkevt.rating = rating;
>>  		cpu_to->clkevt.cpumask = cpumask_of(cpu);
>>  		cpu_to->of_base.base = timer_reg_base + base;
>> +		cpu_to->of_clk.period = rate / HZ;
>>  		cpu_to->of_clk.rate = rate;
>>  
>>  		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
> 
> Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
