Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DD1CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BFE2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfJaPid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:38:33 -0400
Received: from foss.arm.com ([217.140.110.172]:50604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfJaPid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:38:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE9AA1F1;
        Thu, 31 Oct 2019 08:38:32 -0700 (PDT)
Received: from [192.168.1.20] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 964123F71E;
        Thu, 31 Oct 2019 08:38:30 -0700 (PDT)
Subject: Re: [Patch v4 4/6] sched/fair: update cpu_capcity to reflect thermal
 pressure
To:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-5-git-send-email-thara.gopinath@linaro.org>
 <20191023122252.dz7obopab6iizy4s@e107158-lin.cambridge.arm.com>
 <20191028153010.GE4097@hirez.programming.kicks-ass.net>
 <20191031105342.b3sl5xhysldfla3g@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e875ef90-d561-4eee-4951-6556ac89c6a2@arm.com>
Date:   Thu, 31 Oct 2019 16:38:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031105342.b3sl5xhysldfla3g@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.19 11:53, Qais Yousef wrote:
> On 10/28/19 16:30, Peter Zijlstra wrote:
>> On Wed, Oct 23, 2019 at 01:28:40PM +0100, Qais Yousef wrote:
>>> On 10/22/19 16:34, Thara Gopinath wrote:
>>>> cpu_capacity relflects the maximum available capacity of a cpu. Thermal
>>>> pressure on a cpu means this maximum available capacity is reduced. This
>>>> patch reduces the average thermal pressure for a cpu from its maximum
>>>> available capacity so that cpu_capacity reflects the actual
>>>> available capacity.
>>>>
>>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>>>> ---
>>>>  kernel/sched/fair.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 4f9c2cb..be3e802 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -7727,6 +7727,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
>>>>  
>>>>  	used = READ_ONCE(rq->avg_rt.util_avg);
>>>>  	used += READ_ONCE(rq->avg_dl.util_avg);
>>>> +	used += READ_ONCE(rq->avg_thermal.load_avg);
>>>
>>> Maybe a naive question - but can we add util_avg with load_avg without
>>> a conversion? I thought the 2 signals have different properties.
>>
>> Changelog of patch #1 explains, it's in that dense blob of text.
>>
>> But yes, you're quite right that that wants a comment here.
> 
> Thanks for the pointer! A comment would be nice indeed.
> 
> To make sure I got this correctly - it's because avg_thermal.load_avg
> represents delta_capacity which is already a 'converted' form of load. So this
> makes avg_thermal.load_avg a util_avg really. Correct?
> 
> If I managed to get it right somehow. It'd be nice if we can do inverse
> conversion on delta_capacity so that avg_thermal.{load_avg, util_avg} meaning
> is consistent across the board. But I don't feel strongly about it if this gets
> documented properly.

So why can't we use rq->avg_thermal.util_avg here? Since capacity is
closer to util than to load?

Is it because you want to use the influence of ___update_load_sum(...,
unsigned long load eq. per-cpu delta_capacity in your signal?

Why not call it this way then?

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 38210691c615..d3035457483f 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -357,9 +357,9 @@ int update_thermal_load_avg(u64 now, struct rq *rq,
u64 capacity)
 {
        if (___update_load_sum(now, &rq->avg_thermal,
                               capacity,
-                              capacity,
-                              capacity)) {
-               ___update_load_avg(&rq->avg_thermal, 1, 1);
+                              0,
+                              0)) {
+               ___update_load_avg(&rq->avg_thermal, 1, 0);
                return 1;
        }
