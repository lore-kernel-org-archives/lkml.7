Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9515CC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602DB217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARwv/kx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfKFRbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:31:32 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38494 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfKFRbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:31:32 -0500
Received: by mail-qv1-f68.google.com with SMTP id q19so1754147qvs.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ExuEOPScksUQeuJbhuT7dj9C0QRTL/j977coYpBdQZo=;
        b=ARwv/kx4zGJsdOmco+/3etCfBYoQzfqA6G7Kbjjrb8P/4a5/wcN1ZqjYmJywNpOnrU
         Ze0BmtJM62nSeysU3d2CpHCG/LlEE0KqWFpoY81755py/lwL8z+CEVNFwGfiiY1dmuvg
         I1rKSljSE+ctKcYE8qi7JmIPhU10pdqNfj6a2FRxhGj9RTcNwjkWcilu7QexCO6fBP5H
         eMjZzTJ3twxtBv8g+DsBGZd9WbyI2k+AALBXK10coMIKVnsB2E6TwWvl8tHwPS5AMpzN
         R+RdK0mWH9YYRo0mXuw1IdFp8rGiislLaWWx+hMeenag0zGe6PhO81Id9eKjACFsRAhC
         E1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ExuEOPScksUQeuJbhuT7dj9C0QRTL/j977coYpBdQZo=;
        b=U+iDUwGNDytSY5vwfDQrmwLBlZoMZINONwuePtIaPyMOKbxWrythGXfOlrhr0ge8Ty
         4x4C73uX73ZbABgQdtruI3GoS79D7dUT1UMo+XGg3EPgMxgljydS29SPBcudAk4BpNLY
         1d8ZzMuu6Nh4gS38gk1BzRgwqGcbEGWmDadhUtCK3i1mJCkfwFOA+b9s2zzNuMvKej2L
         I8F+ABcZe7+7oNfewLgW+69DdXZ7KSjOrx9oOaUB/NuIqilMFGtmiLg6Z5h29u48V9KW
         g5gpZyY5esIVWkTgdR0uLyjDiWVsmzqiXVanr1QXjE8tZ5qv+U64e5p76rPkxYcsHXD2
         9ttg==
X-Gm-Message-State: APjAAAUkBefAOMEKa7gSoeX9JlQ/iX1oTjFhsXyxRCez4bX4Io1+5h9f
        AaP+F+fEU36KblpsKzzre1ejOWgC7lM=
X-Google-Smtp-Source: APXvYqyzQm1CiVXM8U2EC8ubOvDY13p4XMrOK4mul1Pr/LlCIZTqt/hMwI7JUEDpOIoK6/fqTZiiDg==
X-Received: by 2002:a0c:f114:: with SMTP id i20mr3312670qvl.167.1573061491125;
        Wed, 06 Nov 2019 09:31:31 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id s21sm15507649qtc.12.2019.11.06.09.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 09:31:30 -0800 (PST)
Subject: Re: [Patch v5 4/6] sched/fair: update cpu_capcity to reflect thermal
 pressure
To:     Qais Yousef <qais.yousef@arm.com>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-5-git-send-email-thara.gopinath@linaro.org>
 <20191106165646.vc7j4hbhj2hcrku4@e107158-lin.cambridge.arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DC30371.1000209@linaro.org>
Date:   Wed, 6 Nov 2019 12:31:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191106165646.vc7j4hbhj2hcrku4@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2019 11:56 AM, Qais Yousef wrote:
> On 11/05/19 13:49, Thara Gopinath wrote:
>> cpu_capacity relflects the maximum available capacity of a cpu. Thermal
>> pressure on a cpu means this maximum available capacity is reduced. This
>> patch reduces the average thermal pressure for a cpu from its maximum
>> available capacity so that cpu_capacity reflects the actual
>> available capacity.
>>
>> Other signals that are deducted from cpu_capacity to reflect the actual
>> capacity available are rt and dl util_avg. util_avg tracks a binary signal
>> and uses the weights 1024 and 0. Whereas thermal pressure is tracked
>> using load_avg. load_avg uses the actual "delta" capacity as the weight.
> 
> I think you intended to put this as comment...
> 
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  kernel/sched/fair.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 9fb0494..5f6c371 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7738,6 +7738,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
>>  
>>  	used = READ_ONCE(rq->avg_rt.util_avg);
>>  	used += READ_ONCE(rq->avg_dl.util_avg);
>> +	used += READ_ONCE(rq->avg_thermal.load_avg);
> 
> ... here?

I did not!  But I can.
> 
> I find the explanation hard to parse too. Do you think you can rephrase it?
> Something based on what you wrote here would be more understandable IMHO:
> https://lore.kernel.org/lkml/5DBB05BC.40502@linaro.org/
I will try to rephrase it! I am sorry that you found it hard to parse.
Honestly, I cannot copy paste the code snippet I pointed out to you here
in comment.(And I think that is the reason you found it easier to
understand) But I will try my best to put it in words.

> 
> 
> Thanks!
> 
> --
> Qais Yousef
> 
>>  
>>  	if (unlikely(used >= max))
>>  		return 1;
>> -- 
>> 2.1.4
>>


-- 
Warm Regards
Thara
