Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B29BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590AA20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfLJSbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:31:25 -0500
Received: from foss.arm.com ([217.140.110.172]:53254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfLJSbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:31:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 612711FB;
        Tue, 10 Dec 2019 10:31:24 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44F9D3F6CF;
        Tue, 10 Dec 2019 10:31:23 -0800 (PST)
Subject: Re: [PATCH v2 1/4] sched/uclamp: Make uclamp_util_*() helpers use and
 return UL values
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, qperret@google.com,
        qais.yousef@arm.com, morten.rasmussen@arm.com
References: <20191203155907.2086-1-valentin.schneider@arm.com>
 <20191203155907.2086-2-valentin.schneider@arm.com>
 <5b293a96-438e-e4f8-3fb0-3820c6d9651c@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <a8493b19-e724-0e5d-6ab5-60a6d53b3798@arm.com>
Date:   Tue, 10 Dec 2019 18:31:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5b293a96-438e-e4f8-3fb0-3820c6d9651c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 18:09, Dietmar Eggemann wrote:
> On 03/12/2019 16:59, Valentin Schneider wrote:
> 
> [...]
> 
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 280a3c735935..f1d035e5df7e 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -2303,15 +2303,15 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
>>  unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
>>  
>>  static __always_inline
>> -unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
>> -			      struct task_struct *p)
>> +unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
>> +			       struct task_struct *p)
>>  {
>> -	unsigned int min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
>> -	unsigned int max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
>> +	unsigned long min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
>> +	unsigned long max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
>>  
>>  	if (p) {
>> -		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
>> -		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
>> +		min_util = max_t(unsigned long, min_util, uclamp_eff_value(p, UCLAMP_MIN));
>> +		max_util = max_t(unsigned long, max_util, uclamp_eff_value(p, UCLAMP_MAX));
>>  	}
>>  
>>  	/*
>> @@ -2325,17 +2325,17 @@ unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
>>  	return clamp(util, min_util, max_util);
>>  }
>>  
>> -static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
>> +static inline unsigned long uclamp_util(struct rq *rq, unsigned long util)
>>  {
>>  	return uclamp_util_with(rq, util, NULL);
>>  }
>>  #else /* CONFIG_UCLAMP_TASK */
>> -static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
>> -					    struct task_struct *p)
>> +static inline unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
>> +					     struct task_struct *p)
>>  {
>>  	return util;
>>  }
>> -static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
>> +static inline unsigned long uclamp_util(struct rq *rq, unsigned long util)
>>  {
>>  	return util;
>>  }
> 
> There doesn't seem to be any user of uclamp_util(), only uclamp_util_with()?
> 

It was added in

  982d9cdc22c9 ("sched/cpufreq, sched/uclamp: Add clamps for FAIR and RT tasks")

uclamp_util_with() followed closely in

  9d20ad7dfc9a ("sched/uclamp: Add uclamp_util_with()")

and the sole uclamp_util() user (schedutil_cpu_util()) moved to the latter
in 

  af24bde8df20 ("sched/uclamp: Add uclamp support to energy_compute()")


So it does seem like we could get rid of it - I could see it being useful
later on, but it's useless right now.


