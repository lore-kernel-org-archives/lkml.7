Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600BDC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFF520828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfLJRKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:10:14 -0500
Received: from foss.arm.com ([217.140.110.172]:51320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfLJRKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:10:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 459D11FB;
        Tue, 10 Dec 2019 09:10:13 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29BCF3F6CF;
        Tue, 10 Dec 2019 09:10:12 -0800 (PST)
Subject: Re: [PATCH v2 3/4] sched/fair: Make task_fits_capacity() consider
 uclamp restrictions
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, qperret@google.com,
        qais.yousef@arm.com, morten.rasmussen@arm.com
References: <20191203155907.2086-1-valentin.schneider@arm.com>
 <20191203155907.2086-4-valentin.schneider@arm.com>
 <5549acc0-c5d6-a263-d995-edfeba467915@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <72ffafa9-743c-ff2c-52e3-011f2099f80f@arm.com>
Date:   Tue, 10 Dec 2019 17:10:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5549acc0-c5d6-a263-d995-edfeba467915@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 17:07, Dietmar Eggemann wrote:
> On 03/12/2019 16:59, Valentin Schneider wrote:
> 
> [...]
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 08a233e97a01..dc3e86cb2b2e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3711,6 +3711,22 @@ static inline unsigned long task_util_est(struct task_struct *p)
>>  	return max(task_util(p), _task_util_est(p));
>>  }
>>  
>> +#ifdef CONFIG_UCLAMP_TASK
>> +static inline
>> +unsigned long uclamp_task_util(struct task_struct *p)
>> +{
>> +	return clamp(task_util_est(p),
>> +		     (unsigned long)uclamp_eff_value(p, UCLAMP_MIN),
>> +		     (unsigned long)uclamp_eff_value(p, UCLAMP_MAX));
>> +}
>> +#else
>> +static inline
>> +unsigned long uclamp_task_util(struct task_struct *p)
> 
> [...]
> 
> Save some lines?
> 

Right! I went a bit overboard there.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
<snip> 
