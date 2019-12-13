Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6ECC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C677B2253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLMJrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:47:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfLMJrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:47:23 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D5F2D2A762260A0E853F;
        Fri, 13 Dec 2019 17:47:20 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.236) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 13 Dec 2019
 17:47:11 +0800
Subject: Re: [PATCH] sched/fair: Optimize select_idle_cpu
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenwandun@huawei.com>, <xiexiuqi@huawei.com>,
        <liwei391@huawei.com>, <huawei.libin@huawei.com>,
        <bobo.shaobowang@huawei.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>
References: <20191212144102.181510-1-cj.chengjian@huawei.com>
 <20191212152406.GB2827@hirez.programming.kicks-ass.net>
 <2498b792-8549-5ffd-0d85-179740e356a0@arm.com>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <bc0c48aa-4b98-b8e6-f828-762c4b90bfab@huawei.com>
Date:   Fri, 13 Dec 2019 17:47:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <2498b792-8549-5ffd-0d85-179740e356a0@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.236]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/12 23:44, Valentin Schneider wrote:
> On 12/12/2019 15:24, Peter Zijlstra wrote:
>> On Thu, Dec 12, 2019 at 10:41:02PM +0800, Cheng Jian wrote:
>>
>>> Fixes: 1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")
>> The 'funny' thing is that select_idle_core() actually does the right
>> thing.
>>
>> Copying that should work:
>>
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 08a233e97a01..416d574dcebf 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5828,6 +5837,7 @@ static inline int select_idle_smt(struct task_struct *p, int target)
>>    */
>>   static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
>>   {
>> +	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>>   	struct sched_domain *this_sd;
>>   	u64 avg_cost, avg_idle;
>>   	u64 time, cost;
>> @@ -5859,11 +5869,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>   
>>   	time = cpu_clock(this);
>>   
>> -	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
>> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>> +
>> +	for_each_cpu_wrap(cpu, cpus, target) {
>>   		if (!--nr)
>>   			return si_cpu;
>> -		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>> -			continue;
>>   		if (available_idle_cpu(cpu))
>>   			break;
>>   		if (si_cpu == -1 && sched_idle_cpu(cpu))
>>
> That looks sane enough. I'd only argue the changelog should directly point
> out that the issue is we consume some CPUs out of 'nr' that are not allowed
> for the task and thus waste our attempts.
>
> .


Hi，Valentin

Yeah，Yours are more clear.

Thank you so much.


-- Cheng Jian



