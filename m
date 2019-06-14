Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2B5C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC75217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKtf4ik0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfFNQpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:45:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36120 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfFNQpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:45:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id q26so2193788lfc.3;
        Fri, 14 Jun 2019 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gw/MY9qgeDsiVUyYG0Da4jLf/gn9jRPqLU0qfk6Sj5Q=;
        b=JKtf4ik0NbeTHSwAa8PoMb/iH5wstiMFSAQunFYk7cnjB9bgV5KUW7Ah3WUaqfhe9P
         OalXwS/wUotbFM27YlsEFBd4tUzBYXicRvag3cIqEUCNXfd2tZubtzt/JwEnfCT43Xd4
         eleGs+wceM9fI+PxzoUfNiOFXp1IqAllWqEg1HPX4bvZMHqMjTkGKaZLYE9TmjSKgQjp
         Ms5UbG5Ux1Z+SBgqgWSvkWPF+U31fRkiLHKpurUmdTzOhq8w3AgLiHhMgovwJ5kzTELK
         Lmh0amtVAM11mmWVBc69RPrYpwY28KqKC+F6yBYbhebvPo9KvVwE5P7nMXig83rlGD+r
         zRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gw/MY9qgeDsiVUyYG0Da4jLf/gn9jRPqLU0qfk6Sj5Q=;
        b=H/ayDzYTqZKecw8bXV3/uz2Y2GwOH/iMXYfAkqL7hZAlumrDArOerq+slohbcZ+Gk1
         zEKjwhUGdwnVWOOxo/kXXnT/wWieWXwBd2Vn3BRwrVBziFzz3S4RYtOFAxFoJ6BC3OvP
         2yMyL0YFddKoGqn5AXcJ/auAyIzQmlSQ/LfiWwIK28xDyxYJCZ+6bdY+NWxbVcF9q6G+
         6NDgXGgsFJuJNwqDqZfrL7ejX9qJ19pX2KB4aswmkeEWJBq/b30DP6LjSk4EBeYsD+p3
         GxJWh6OZb35yBZiUaXvuxiUyC4vQv6sz4b1IMkn/9NNuUaM8Br/la3xJhMUNl/xm+qyY
         l82A==
X-Gm-Message-State: APjAAAWLdMEE1hfUOfNxCdienK68/uYmdASlm6fyZFQ+Jb+FCHs5Vuow
        7FYV/KSjrhN1mQ7gpNU/uFOB2wMB
X-Google-Smtp-Source: APXvYqwnFkQTMrM/Hf9/rBogPFsz1fFn1ZMbAuJJDGYIGVOFc2HhOfBS9lTDIk9PGEKSOk5UqPDsrQ==
X-Received: by 2002:ac2:4209:: with SMTP id y9mr7701278lfh.83.1560530750347;
        Fri, 14 Jun 2019 09:45:50 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id f1sm202518ljf.53.2019.06.14.09.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:45:49 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] clocksource/drivers/tegra: Set and use timer's
 period
To:     Jon Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190610164400.11830-1-digetx@gmail.com>
 <20190610164400.11830-4-digetx@gmail.com>
 <ac8a1da8-9b82-3d5a-5fa6-0c1cc7f627f1@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3e941c50-ac62-719e-aac1-7072e9a3bcd0@gmail.com>
Date:   Fri, 14 Jun 2019 19:45:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ac8a1da8-9b82-3d5a-5fa6-0c1cc7f627f1@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.06.2019 18:48, Jon Hunter пишет:
> 
> On 10/06/2019 17:43, Dmitry Osipenko wrote:
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
>> index 810b4e7435cf..646b3530c2d2 100644
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
>> +		cpu_to->of_clk.period = DIV_ROUND_UP(rate, HZ);
> 
> Any reason you made this a round-up?

That's what timer_of_clk_init() does, I assume it should be a more correct variant.
