Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896CDC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4896C217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYZVS6ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbfKFRxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:53:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36137 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfKFRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:53:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id d13so25411404qko.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Ftk18S8wR2FwZXFsfv5TX/VhCJr3QuM7Ugjyky/oois=;
        b=PYZVS6eic6ywHgAWhZ0slu1m0lqe8jsFYTXwps7NgP7Zy3dwnPmKZcV9iRpb9YSq2C
         tii63sbNFb2MoNTm2vyj2netv9Pm3vW/gv0L1D1Vm2DDbZFr/Ze9b4w5f8hRB8dEYdgn
         t99rteomrM7J2W4NAenfT2kNxrmRef552adWUcR4Pqfv2VLLjpN1hYi4njYISxAiZ0ZQ
         HgaAeUC8Cj4R61U5XZgDmZwwHosjHUo0qpZj7wlH0O7XpVShPNhiwfVzEuvr7FovbGkY
         IBSrjBE3z77APmyhR2PPRwp4+b6sstHOhdlk/e1n+gKT6n5Nxdc1WLnhFtMpCJakvsu0
         G1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Ftk18S8wR2FwZXFsfv5TX/VhCJr3QuM7Ugjyky/oois=;
        b=dDT7Io1xCODJjZIhxHW/qX6E1KbNTBRJA1yo1oQZwKirFC/MLiM4GxMAGyF0CDjUZ4
         2qMq3xkbW5JKKi1X5lNo5O8IUCCuChzVAcgB4fIA/UYC/CG93T2nrUWld+D+umtYRleQ
         w2AAu7GVoHhmilqpBNRgj/15wNUItirnZ0iSK0h3NSEEnwGAtXmVf3FxoS3+FGkREeQG
         ZRhIa/FOSSU5u7bYgylcVGE/OhgxypbsOoGu7ZdWGQLWz6tuXG67KEgleAGlqiOGQxgY
         bcC679joGlfZZ+v/BMUE1t1dLHOty0eXiWNi5UlVB92ez/ZCl2ecAHW9gvzu7+DlTvWb
         EkVQ==
X-Gm-Message-State: APjAAAWxBJ1q7FKKK9nh4QOp4yqKq7JwNe1xPaiLkRhzXlmVCO6c4Jjq
        a3slvO/I94yXasr4//th6MPNkg==
X-Google-Smtp-Source: APXvYqwhLlIai52h6gAWWwD8eX5gN2LF3vX9K4kJDsFLK1Mn1AnyHd0YxHjLa9/y3vUzB3fvNlPW7Q==
X-Received: by 2002:ae9:eb07:: with SMTP id b7mr3216060qkg.104.1573062797273;
        Wed, 06 Nov 2019 09:53:17 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id m65sm10496688qte.54.2019.11.06.09.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 09:53:16 -0800 (PST)
Subject: Re: [Patch v5 2/6] sched/fair: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
 <20191105202037.GA17494@e108754-lin> <5DC1E348.2090104@linaro.org>
 <20191105211446.GA25349@e108754-lin> <5DC1E9BC.1010001@linaro.org>
 <20191105215233.GA6450@e108754-lin>
 <436ad772-c727-127e-1469-d99549db03fc@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DC3088B.8070401@linaro.org>
Date:   Wed, 6 Nov 2019 12:53:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <436ad772-c727-127e-1469-d99549db03fc@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2019 07:50 AM, Dietmar Eggemann wrote:
> On 05/11/2019 22:53, Ionela Voinescu wrote:
>> On Tuesday 05 Nov 2019 at 16:29:32 (-0500), Thara Gopinath wrote:
>>> On 11/05/2019 04:15 PM, Ionela Voinescu wrote:
>>>> On Tuesday 05 Nov 2019 at 16:02:00 (-0500), Thara Gopinath wrote:
>>>>> On 11/05/2019 03:21 PM, Ionela Voinescu wrote:
>>>>>> Hi Thara,
>>>>>>
>>>>>> On Tuesday 05 Nov 2019 at 13:49:42 (-0500), Thara Gopinath wrote:
>>>>>> [...]
>>>>>>> +static void trigger_thermal_pressure_average(struct rq *rq)
>>>>>>> +{
>>>>>>> +#ifdef CONFIG_SMP
>>>>>>> +	update_thermal_load_avg(rq_clock_task(rq), rq,
>>>>>>> +				per_cpu(thermal_pressure, cpu_of(rq)));
>>>>>>> +#endif
>>>>>>> +}
>>>>>>
>>>>>> Why did you decide to keep trigger_thermal_pressure_average and not
>>>>>> call update_thermal_load_avg directly?
>>>>>>
>>>>>> For !CONFIG_SMP you already have an update_thermal_load_avg function
>>>>>> that does nothing, in kernel/sched/pelt.h, so you don't need that
>>>>>> ifdef. 
>>>>> Hi,
>>>>>
>>>>> Yes you are right. But later with the shift option added, I shift
>>>>> rq_clock_task(rq) by the shift. I thought it is better to contain it in
>>>>> a function that replicate it in three different places. I can remove the
>>>>> CONFIG_SMP in the next version.
>>>>
>>>> You could still keep that in one place if you shift the now argument of
>>>> ___update_load_sum instead.
>>>
>>> No. I cannot do this. The authors of the pelt framework  prefers not to
>>> include a shift parameter there. I had discussed this with Vincent earlier.
>>>
>>
>> Right! I missed Vincent's last comment on this in v4. 
>>
>> I would argue that it's more of a PELT parameter than a CFS parameter
>> :), where it's currently being used. I would also argue that's more of a
>> PELT parameter than a thermal parameter. It controls the PELT time
>> progression for the thermal signal, but it seems more to configure the
>> PELT algorithm, rather than directly characterize thermals.
>>
>> In any case, it only seemed to me that adding a wrapper function for
>> this purpose only was not worth doing.
> 
> Coming back to the v4 discussion
> https://lore.kernel.org/r/379d23e5-79a5-9d90-0fb6-125d9be85e99@arm.com
> 
> There is no API between pelt.c and other parts of the scheduler/kernel
> so why should we keep an unnecessary parameter and wrapper functions?
> 
> There is also no abstraction, update_thermal_load_avg() in pelt.c even
> carries '_thermal_' in its name.
> 
> So why not define this shift value '[sched_|pelt_]thermal_decay_shift'
> there as well? It belongs to update_thermal_load_avg().
> 
> All call sites of update_thermal_load_avg() use 'rq_clock_task(rq) >>
> sched_thermal_decay_shift' so I don't see the need to pass it in.
> 
> IMHO, preparing for eventual code changes (e.g. parsing different now
> values) is not a good practice in the kernel. Keeping the code small and
> tidy is.

I think we are going in circles on this one. I acknowledge you have an
issue. That being said, I also understand the need to keep the pelt
framework code tight. Also Ionela pointed out that there could be a need
for a faster decay in which case it could mean a left shift leading to
further complications if defined in pelt.c (I am not saying that I will
implement a faster decay in this patch set but it is more of a future
extension if needed!)

I can make trigger_thermal_pressure_average inline if that will
alleviate some of the concerns.

I would also urge you to reconsider the merits of arguing this point
back and forth.
> 


-- 
Warm Regards
Thara
