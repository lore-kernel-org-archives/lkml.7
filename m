Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7DBC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E92A2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCz67vUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbfFJKjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:39:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41433 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389217AbfFJKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:39:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id s21so7455398lji.8;
        Mon, 10 Jun 2019 03:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hp7w9EcTH4KoMgfbV9O4tF43GQhl8J4iWH4CNXKJYUo=;
        b=bCz67vUq0UCl9uUSJrNhDdwSkJLYFfbl268PifQuzXtVXxfgDyJVbRClyy5PXaRs5J
         ipGnjD1Hwd0RO6VkPm9FzQ49WQcUqTjoEW4NfzFAqsBO3hZwvvBwmLHZLRrtTzlBNS7p
         Oi5PRq59hOqwbyf/BRIiAS1QgmK6mLVTuJ+UEo9lUkzjfaDQVw5l1SNRp9mdvLzOdNxU
         Lfza/Y/R5u97oHI/Cu5Y6VsGMRgoFUSXiTd8+TzVAzbO0b4U1FCMAOrqpTyuNdatyNnw
         YlwiehFgqtkWrDWQJ20GpEMj+fsHUZkF93KryKwdBI4mYDn0I7x5kmog1IUImaRuAL3+
         1EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hp7w9EcTH4KoMgfbV9O4tF43GQhl8J4iWH4CNXKJYUo=;
        b=ByJ+XviRe64Qt+3shlBXx5sE4wRmgzbYLlBwUIj3bWTLjtnbrZDws9MqKC1DczY9A1
         9KvBL9Buh5V+prBlRvscBufoJASlsiSZLDAtOasmgV2ZOyFa1QHBb5bjlzWrW7BWPYLz
         VKqrYoKpDIRR6Wv5G1Y6KugSYxxEk6UiiUZfqLqKNtuFyJYvlh627Omylbg/afW/sjdR
         EYwAqxmqXnrQjbf2dC0YJjs2ZP8wJQe22HaY6de68zII1YHyKtsevwRM/690BI92P13+
         aeYhkFnnIQAGMGcPjYiA1SWxgjhlljO1MSp6236eoq7al36161UY2U4UeYqggd4xVetM
         /+HQ==
X-Gm-Message-State: APjAAAX3oBBQAFLY5IT6T0DiYM/8Rjk6BgSmwTT4BI8hL9MBg9gg4lNO
        KCS4i9Oli1DtXZZJGFSj1vHV1b+v
X-Google-Smtp-Source: APXvYqy6dE+w/d1u45lfinXgUoGU2kUiYOqHJEz/yVSwhrUuWmGw17GdIvpO9ivXBlM6KbjC+6tfPQ==
X-Received: by 2002:a2e:5b5b:: with SMTP id p88mr26490359ljb.192.1560163141834;
        Mon, 10 Jun 2019 03:39:01 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id z6sm1391557ljk.57.2019.06.10.03.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:39:01 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] clocksource/drivers/tegra: Remove duplicated use
 of per_cpu_ptr
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190609192730.29459-1-digetx@gmail.com>
 <20190609192730.29459-2-digetx@gmail.com>
 <4e1f1389-afde-3994-2ccc-4e57e9ad78d1@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <479f97eb-f695-31d8-d12b-4b577b90f4d0@gmail.com>
Date:   Mon, 10 Jun 2019 13:39:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4e1f1389-afde-3994-2ccc-4e57e9ad78d1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.06.2019 11:11, Daniel Lezcano пишет:
> 
> Hi Dmitry,
> 
> 
> On 09/06/2019 21:27, Dmitry Osipenko wrote:
>> It was left unnoticed by accident, which means that the code could be
>> cleaned up a tad more.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/clocksource/timer-tegra.c | 40 +++++++++++++++++++------------
>>  1 file changed, 25 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
>> index 9406855781ff..6da169de47f9 100644
>> --- a/drivers/clocksource/timer-tegra.c
>> +++ b/drivers/clocksource/timer-tegra.c
>> @@ -216,6 +216,19 @@ static inline unsigned int tegra_irq_idx_for_cpu(int cpu, bool tegra20)
>>  	return TIMER10_IRQ_IDX + cpu;
>>  }
>>  
>> +static inline unsigned long tegra_rate_for_timer(struct timer_of *to,
>> +						 bool tegra20)
>> +{
>> +	/*
>> +	 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
>> +	 * parent clock.
>> +	 */
>> +	if (tegra20)
>> +		return 1000000;
> 
> Mind to take the opportunity to convert the literal value to a constant?

Sure!

>> +
>> +	return to->of_clk.rate;
>> +}
>> +
>>  static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>>  				   int rating)
>>  {
>> @@ -268,30 +281,27 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>>  
>>  	for_each_possible_cpu(cpu) {
>>  		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
>> +		unsigned long flags = IRQF_TIMER | IRQF_NOBALANCING;
>> +		unsigned long rate = tegra_rate_for_timer(&tegra_to, tegra20);

Oh, this actually shall be (to, tegra20). Will correct this in v2!

>>  		unsigned int base = tegra_base_for_cpu(cpu, tegra20);
>>  		unsigned int idx = tegra_irq_idx_for_cpu(cpu, tegra20);
>> +		unsigned int irq = irq_of_parse_and_map(np, idx);
>>  
>> -		/*
>> -		 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
>> -		 * parent clock.
>> -		 */
>> -		if (tegra20)
>> -			cpu_to->of_clk.rate = 1000000;

I also spotted that there is a bug here that I introduced in a previous
patch. The of_clk.rate is initialized only for the first per-cpu
clocksource and then we need to replicate it for the rest of CPU's in a
case of T210. I'll add an explicit fixup for this.
