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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C88DC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E230421019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7WxGo3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390897AbfGRSYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:24:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36588 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfGRSYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:24:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so28326844ljj.3;
        Thu, 18 Jul 2019 11:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zi0v22VFx/F+B7JLRqGKl/zXkfUz0hlM2pIpm9EwL00=;
        b=O7WxGo3DHdSzzJAaIaLhjlZAI2oCBe9joEOOWjGAx2mDOYaMkPwqfcf4vHn1MXvKmp
         +ceYMYOhWXHsdaTVR6IIKECcFEYob2nYwynq8JWTIEQz3R1lPU7SAwRa1FSdLnY6uBRR
         97VOPmnLl/au8hRXqoR7cI2l8mAEvu6DXu6k8Zjl8NKRIBbqfzkQLQjOykp4SW359Mv3
         5ZNctyHVlZ/bJ4qh0YM8e6ERx5KnKmpGFNa57C/u0q4ua0Jutwb41B235WlJuL/BSi5k
         yGksDJ0QcGIcheds0dDNgxTOxBt228DO3p6fBUh/bZQ5i/J3441sKr6Kzh3rxXns5Jet
         y7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zi0v22VFx/F+B7JLRqGKl/zXkfUz0hlM2pIpm9EwL00=;
        b=dwHzGHVCI1IcEb5RJLHL9MwPfYEwQrVM7F/ZOEmwdV8hhJk3oyW0754642Iz7pIbc7
         hLOueY4PfvOvsTNfpqHvZnV+VfJisd5mkZO5acuWhTnH2JMmDNtyZGAVvuZm/YWWYt3P
         DZ5ikckTecgDvgWkRm0zWJyM+zwRo8uMGWfSZMwhueu/7z6CaDDyAzzcjWVGae1Fs6iM
         FfY+cskkG9k9ICyGuf2+WzI3OflCWWFlSd73ixI81Gk3L69eINFlQYe8mBs4bYz571pQ
         qNocfYkXG88r68bLR5vNiZoYHOyq2XueTtEnTTa0xSGLFUpcq4YEkQFZUfFiQm3KX6JA
         aHjQ==
X-Gm-Message-State: APjAAAXnznh5UDSFyDQeUkhPcbVeaT5iLZPIiJ60O+fJ7Oq1JSwBFJPz
        XfGDwI5ZfH0RODPdsv9ah/qB2hXR
X-Google-Smtp-Source: APXvYqylgVnbbmG1ZShaVSYw+pueYT0PQJw6yJDWGOexh/J96R3yrjpdbugyKtFDLHkJtnlhxUNAXA==
X-Received: by 2002:a2e:9a13:: with SMTP id o19mr25760065lji.102.1563474261113;
        Thu, 18 Jul 2019 11:24:21 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id o17sm5252400ljg.71.2019.07.18.11.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 11:24:20 -0700 (PDT)
Subject: Re: [PATCH v1] soc/tegra: pmc: Query PCLK clock rate at probe time
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190707230843.11224-1-digetx@gmail.com>
 <c9bd6dd3-7a03-6e2c-db9f-fefa059a428f@nvidia.com>
 <aa12115c-bf1c-f50b-f38a-97fb398d1af0@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d9b64f71-a91d-be34-1f36-28727c4beff6@gmail.com>
Date:   Thu, 18 Jul 2019 21:24:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <aa12115c-bf1c-f50b-f38a-97fb398d1af0@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.07.2019 12:53, Jon Hunter пишет:
> 
> On 18/07/2019 10:45, Jon Hunter wrote:
>>
>> On 08/07/2019 00:08, Dmitry Osipenko wrote:
>>> The PCLK clock is running off SCLK, which is a critical clock that is
>>> very unlikely to randomly change its rate. It's also a bit clumsy (and
>>> apparently incorrect) to query the clock's rate with interrupts being
>>> disabled because clk_get_rate() takes a mutex and that's the case during
>>> suspend/cpuidle entering. Lastly, it's better to always fully reprogram
>>> PMC state because it's not obvious whether it could be changed after SC7.
>>
>> I agree with the first part, but I would drop the last sentence because
>> I see no evidence of this. Maybe Peter can confirm.
>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/soc/tegra/pmc.c | 26 +++++++++++---------------
>>>  1 file changed, 11 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>> index 9f9c1c677cf4..532e0ada012b 100644
>>> --- a/drivers/soc/tegra/pmc.c
>>> +++ b/drivers/soc/tegra/pmc.c
>>> @@ -1433,6 +1433,7 @@ void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
>>>  void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
>>>  {
>>>  	unsigned long long rate = 0;
>>> +	u64 ticks;
>>>  	u32 value;
>>>  
>>>  	switch (mode) {
>>> @@ -1441,7 +1442,7 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
>>>  		break;
>>>  
>>>  	case TEGRA_SUSPEND_LP2:
>>> -		rate = clk_get_rate(pmc->clk);
>>> +		rate = pmc->rate;
>>
>> There is another call to clk_get_rate() that could be removed as well.
>>
>>>  		break;
>>>  
>>>  	default:
>>> @@ -1451,26 +1452,20 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
>>>  	if (WARN_ON_ONCE(rate == 0))
>>>  		rate = 100000000;
>>>  
>>> -	if (rate != pmc->rate) {
>>> -		u64 ticks;
>>> -
>>> -		ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
>>> -		do_div(ticks, USEC_PER_SEC);
>>> -		tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
>>> -
>>> -		ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
>>> -		do_div(ticks, USEC_PER_SEC);
>>> -		tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
>>> +	ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
>>> +	do_div(ticks, USEC_PER_SEC);
>>> +	tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
>>
>> You could go a step further and update the cpu_good_time/cpu_off_time to
>> be ticks and calculated once during probe and recalculated if
>> tegra_pmc_set_suspend_mode is called. I am not sure why we really need
>> to pass mode to tegra_pmc_enter_suspend_mode() seeing as the mode is
>> stored in the pmc struct.
>>
>>>  
>>> -		wmb();
>>> -
>>> -		pmc->rate = rate;
>>> -	}
>>> +	ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
>>> +	do_div(ticks, USEC_PER_SEC);
>>> +	tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
>>>  
>>>  	value = tegra_pmc_readl(pmc, PMC_CNTRL);
>>>  	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
>>>  	value |= PMC_CNTRL_CPU_PWRREQ_OE;
>>>  	tegra_pmc_writel(pmc, value, PMC_CNTRL);
>>> +
>>> +	wmb();
> 
> I would not move the barrier unless there is a good reason. Maybe it is
> intentional that this happens before the other writes.

Looking at 'git blame', the barrier was copied by Thierry while he moved
PMC driver form mach-tegra/ to soc/. Originally the barrier appeared in
d552920a02759cdc45d8507868de10ac2f5b9a18 (ARM: tegra30: cpuidle: add
powered-down state for CPU0).

But really there is no good justification for that barrier at all
because PMC logic kicks-in when CPU enters power-gated state and at that
point all CPU accesses guaranteed to be finished no matter what, hence
this barrier just doesn't make much sense and can be removed safely.
I'll make a separate commit for that.
