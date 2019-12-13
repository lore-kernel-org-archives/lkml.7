Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C33C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767C522527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbfLMBvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 20:51:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727070AbfLMBvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 20:51:46 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ECEFD6F1AB2081F9C279;
        Fri, 13 Dec 2019 09:51:42 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.236) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 13 Dec 2019
 09:51:32 +0800
Subject: Re: [PATCH] sched/fair: Optimize select_idle_cpu
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenwandun@huawei.com>, <xiexiuqi@huawei.com>,
        <liwei391@huawei.com>, <huawei.libin@huawei.com>,
        <bobo.shaobowang@huawei.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>
References: <20191212144102.181510-1-cj.chengjian@huawei.com>
 <20191212150429.GZ2827@hirez.programming.kicks-ass.net>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <52112146-a4ee-d09f-b61e-9aa35e2e5298@huawei.com>
Date:   Fri, 13 Dec 2019 09:51:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191212150429.GZ2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.236]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/12 23:04, Peter Zijlstra wrote:
> On Thu, Dec 12, 2019 at 10:41:02PM +0800, Cheng Jian wrote:
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 08a233e97a01..16a29b570803 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5834,6 +5834,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>   	s64 delta;
>>   	int this = smp_processor_id();
>>   	int cpu, nr = INT_MAX, si_cpu = -1;
>> +	struct cpumask cpus;
> NAK, you must not put a cpumask on stack.
>
> .

Hi, Peter

     I saw the same work in select_idle_core, and I was wondering why 
the per_cpu variable was

needed for this yesterday. Now I think I probably understand : cpumask 
may be too large,

putting it on the stack may cause overflow. Is this correct ?

     I'm sorry I made a mistake like this. I will fix it in v2

     Thank you very much.


         -- Cheng Jian



