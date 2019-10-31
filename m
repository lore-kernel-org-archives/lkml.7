Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81D2CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAA520873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfJaQos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:44:48 -0400
Received: from foss.arm.com ([217.140.110.172]:51810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfJaQos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:44:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96B361FB;
        Thu, 31 Oct 2019 09:44:47 -0700 (PDT)
Received: from [192.168.1.20] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 834F03F6C4;
        Thu, 31 Oct 2019 09:44:45 -0700 (PDT)
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
 <e38e9c86-7433-7c4b-d9c1-38fd2458b953@arm.com>
 <CAKfTPtCQe8qd1e5s-jf_5C7eaGVc7OYcXYgdvBK+ACF8aL7ByQ@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <aeb800c0-f23a-b9c3-6014-f5248f84adbd@arm.com>
Date:   Thu, 31 Oct 2019 17:44:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCQe8qd1e5s-jf_5C7eaGVc7OYcXYgdvBK+ACF8aL7ByQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.19 17:31, Vincent Guittot wrote:
> On Thu, 31 Oct 2019 at 17:17, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 31.10.19 16:48, Vincent Guittot wrote:
>>> On Thu, 31 Oct 2019 at 16:38, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 31.10.19 11:53, Qais Yousef wrote:
>>>>> On 10/28/19 16:30, Peter Zijlstra wrote:
>>>>>> On Wed, Oct 23, 2019 at 01:28:40PM +0100, Qais Yousef wrote:
>>>>>>> On 10/22/19 16:34, Thara Gopinath wrote:

[...]

>>>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>>>> index 38210691c615..d3035457483f 100644
>>>> --- a/kernel/sched/pelt.c
>>>> +++ b/kernel/sched/pelt.c
>>>> @@ -357,9 +357,9 @@ int update_thermal_load_avg(u64 now, struct rq *rq,
>>>> u64 capacity)
>>>>  {
>>>>         if (___update_load_sum(now, &rq->avg_thermal,
>>>>                                capacity,
>>>> -                              capacity,
>>>> -                              capacity)) {
>>>> -               ___update_load_avg(&rq->avg_thermal, 1, 1);
>>>> +                              0,
>>>> +                              0)) {
>>>> +               ___update_load_avg(&rq->avg_thermal, 1, 0);
>>>>                 return 1;
>>>>         }
>>
>> So we could call it this way since we don't care about runnable_load or
>> util?
> 
> one way or the other is quite similar but the current solution is
> aligned with other irq, rt, dl signals which duplicates the same state
> in each fields

I see. But there is a subtle difference. For irq, rt, dl, we have to
also set load (even we only use util) because of:

___update_load_sum() {

        ...
        if (!load)
                runnable = running = 0;
        ...
}

which is there for se's only.

I like self-explanatory code but I agree in this case it's not obvious.
