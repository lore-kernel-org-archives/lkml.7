Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD0CC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B01F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYOJGcNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390962AbfGRSMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:12:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40250 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRSMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:12:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id m8so28244695lji.7;
        Thu, 18 Jul 2019 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dAl3eDfisZ18QLZIHY2seQs2RuMzg+EqdXaDuRAy/dM=;
        b=rYOJGcNFE0NWbDYygP+1RRqBUa8FHCapYn1UswpF+6WRNigTw6GRVlMnNmVuwYYw+y
         RudusUAwVPQLDzOik2MgR30sOY88dYJQ9tixZUtI2AM5BXvV29PdjPzR90SKvWSKTKg1
         yMZBwBQ/qRSyrxgxIk5HJe9oMqO8mxxXRH7wCfuv9SZOrbDdh9mX9U509gixv1xcQOWF
         y66cgkD5KWT3+MPYF2gAIwsePsOGQmT2WClNlUWb+44s3JYnu65sVxPZu6e4VVVBCSVq
         YPGDiAPSO27/67G+z/hnIKfrZQu/00bQkdQ1qC44xaUjHq5SUV55u1OU6DD1liZU2N6p
         h4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dAl3eDfisZ18QLZIHY2seQs2RuMzg+EqdXaDuRAy/dM=;
        b=nsbQfWc+zxO9GxpWJVXdqsUw+kD1y5EpO0lmqQLE9Bw2zKQ7f/0gfEgkV9Ecvc5pLP
         51YdnAa74Jds/GATQeYBIOZPcIpHJm6SClhePEL6QFkRI10qO9fSRbYcLgMMrOz/Y0qP
         vwD3TMtU5yhB0I/MAJMQsb0i+vMCh41YvocnmDDyNzcmWR43jZ/FtJ+u3y19iFopdD6f
         VkkQbXoOKvYduFF0RbRwjPEI5H8Ui8Yj+uFB06VafPMgu7YCFB/sjbEZQMAEL45AmkcE
         0o1ngAWZ8wF66tNRQKKW6TM8qgqaraVDDVNWf+5MRd8aW0u10rGgzaZr2bJUp7/4krZT
         4AbQ==
X-Gm-Message-State: APjAAAXc6CD04MElPAS5zoNZw2R2b1t2dV2dHPzbHkZgM7djB7JUcMOO
        0rUGCsqruWjs1ueWibZSu6AbbLwp
X-Google-Smtp-Source: APXvYqz9Iac/ot87wpXEaVHzdMAxsWhf7X2fpSbr4iqyWUepWopA5br3uptabxJ6aGX7JKHbb+MeYQ==
X-Received: by 2002:a2e:9003:: with SMTP id h3mr23771082ljg.194.1563473532618;
        Thu, 18 Jul 2019 11:12:12 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id z12sm4112997lfg.67.2019.07.18.11.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 11:12:11 -0700 (PDT)
Subject: Re: [PATCH v1] soc/tegra: pmc: Query PCLK clock rate at probe time
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190707230843.11224-1-digetx@gmail.com>
 <c9bd6dd3-7a03-6e2c-db9f-fefa059a428f@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <040ce6d7-5c97-6112-4b9e-a320d12fcdca@gmail.com>
Date:   Thu, 18 Jul 2019 21:12:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c9bd6dd3-7a03-6e2c-db9f-fefa059a428f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.07.2019 12:45, Jon Hunter пишет:
> 
> On 08/07/2019 00:08, Dmitry Osipenko wrote:
>> The PCLK clock is running off SCLK, which is a critical clock that is
>> very unlikely to randomly change its rate. It's also a bit clumsy (and
>> apparently incorrect) to query the clock's rate with interrupts being
>> disabled because clk_get_rate() takes a mutex and that's the case during
>> suspend/cpuidle entering. Lastly, it's better to always fully reprogram
>> PMC state because it's not obvious whether it could be changed after SC7.
> 
> I agree with the first part, but I would drop the last sentence because
> I see no evidence of this. Maybe Peter can confirm.

Okay.

>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/soc/tegra/pmc.c | 26 +++++++++++---------------
>>  1 file changed, 11 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index 9f9c1c677cf4..532e0ada012b 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -1433,6 +1433,7 @@ void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
>>  void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
>>  {
>>  	unsigned long long rate = 0;
>> +	u64 ticks;
>>  	u32 value;
>>  
>>  	switch (mode) {
>> @@ -1441,7 +1442,7 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
>>  		break;
>>  
>>  	case TEGRA_SUSPEND_LP2:
>> -		rate = clk_get_rate(pmc->clk);
>> +		rate = pmc->rate;
> 
> There is another call to clk_get_rate() that could be removed as well.

Indeed!

>>  		break;
>>  
>>  	default:
>> @@ -1451,26 +1452,20 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
>>  	if (WARN_ON_ONCE(rate == 0))
>>  		rate = 100000000;
>>  
>> -	if (rate != pmc->rate) {
>> -		u64 ticks;
>> -
>> -		ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
>> -		do_div(ticks, USEC_PER_SEC);
>> -		tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
>> -
>> -		ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
>> -		do_div(ticks, USEC_PER_SEC);
>> -		tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
>> +	ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
>> +	do_div(ticks, USEC_PER_SEC);
>> +	tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
> 
> You could go a step further and update the cpu_good_time/cpu_off_time to
> be ticks and calculated once during probe and recalculated if
> tegra_pmc_set_suspend_mode is called. I am not sure why we really need
> to pass mode to tegra_pmc_enter_suspend_mode() seeing as the mode is
> stored in the pmc struct.

The mode will differ depending on the idling mode. The system suspend
could be LP1, while CPUIDLE is LP2. Hence the mode need to be
reconfigured dynamically and thus the ticks.

>>  
>> -		wmb();
>> -
>> -		pmc->rate = rate;
>> -	}
>> +	ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
>> +	do_div(ticks, USEC_PER_SEC);
>> +	tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
>>  
>>  	value = tegra_pmc_readl(pmc, PMC_CNTRL);
>>  	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
>>  	value |= PMC_CNTRL_CPU_PWRREQ_OE;
>>  	tegra_pmc_writel(pmc, value, PMC_CNTRL);
>> +
>> +	wmb();
>>  }
>>  #endif
>>  
>> @@ -2082,6 +2077,7 @@ static int tegra_pmc_probe(struct platform_device *pdev)
>>  		pmc->clk = NULL;
>>  	}
>>  
>> +	pmc->rate = clk_get_rate(pmc->clk);
> 
> You should check the value returned is not 0 here.

Good point!
