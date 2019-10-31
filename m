Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F1DCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030B920650
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfJaQRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:17:11 -0400
Received: from foss.arm.com ([217.140.110.172]:51322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJaQRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:17:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74A921FB;
        Thu, 31 Oct 2019 09:17:10 -0700 (PDT)
Received: from [192.168.1.20] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 682C23F71E;
        Thu, 31 Oct 2019 09:17:08 -0700 (PDT)
Subject: Re: [Patch v4 4/6] sched/fair: update cpu_capcity to reflect thermal
 pressure
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-5-git-send-email-thara.gopinath@linaro.org>
 <20191023122252.dz7obopab6iizy4s@e107158-lin.cambridge.arm.com>
 <20191028153010.GE4097@hirez.programming.kicks-ass.net>
 <20191031105342.b3sl5xhysldfla3g@e107158-lin.cambridge.arm.com>
 <e875ef90-d561-4eee-4951-6556ac89c6a2@arm.com>
 <CAKfTPtCTYOBQ+TUYaGsEGK-UTQ=2of=1WYeeiMzak7ZhEPRxmA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e38e9c86-7433-7c4b-d9c1-38fd2458b953@arm.com>
Date:   Thu, 31 Oct 2019 17:17:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCTYOBQ+TUYaGsEGK-UTQ=2of=1WYeeiMzak7ZhEPRxmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.19 16:48, Vincent Guittot wrote:
> On Thu, 31 Oct 2019 at 16:38, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 31.10.19 11:53, Qais Yousef wrote:
>>> On 10/28/19 16:30, Peter Zijlstra wrote:
>>>> On Wed, Oct 23, 2019 at 01:28:40PM +0100, Qais Yousef wrote:
>>>>> On 10/22/19 16:34, Thara Gopinath wrote:

[...]

>>> To make sure I got this correctly - it's because avg_thermal.load_avg
>>> represents delta_capacity which is already a 'converted' form of load. So this
>>> makes avg_thermal.load_avg a util_avg really. Correct?
>>>
>>> If I managed to get it right somehow. It'd be nice if we can do inverse
>>> conversion on delta_capacity so that avg_thermal.{load_avg, util_avg} meaning
>>> is consistent across the board. But I don't feel strongly about it if this gets
>>> documented properly.
>>
>> So why can't we use rq->avg_thermal.util_avg here? Since capacity is
>> closer to util than to load?
>>
>> Is it because you want to use the influence of ___update_load_sum(...,
>> unsigned long load eq. per-cpu delta_capacity in your signal?
>>
>> Why not call it this way then?
> 
> util_avg tracks a binary state with 2 fixed weights: running(1024)  vs
> not running (0)
> In the case of thermal pressure, we want to track how much pressure is
> put on the CPU: capping to half the max frequency is not the same as
> capping only 10%
> load_avg is not boolean but you set the weight  you want to apply and
> this weight reflects the amount of pressure.

I see. This is what I meant by 'load (weight) eq. per-cpu delta_capacity
(pressure)'.


>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>> index 38210691c615..d3035457483f 100644
>> --- a/kernel/sched/pelt.c
>> +++ b/kernel/sched/pelt.c
>> @@ -357,9 +357,9 @@ int update_thermal_load_avg(u64 now, struct rq *rq,
>> u64 capacity)
>>  {
>>         if (___update_load_sum(now, &rq->avg_thermal,
>>                                capacity,
>> -                              capacity,
>> -                              capacity)) {
>> -               ___update_load_avg(&rq->avg_thermal, 1, 1);
>> +                              0,
>> +                              0)) {
>> +               ___update_load_avg(&rq->avg_thermal, 1, 0);
>>                 return 1;
>>         }

So we could call it this way since we don't care about runnable_load or
util?
