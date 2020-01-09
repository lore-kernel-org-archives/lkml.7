Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C183C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1612072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgAIMY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:24:27 -0500
Received: from foss.arm.com ([217.140.110.172]:58390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729159AbgAIMY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:24:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2B0C328;
        Thu,  9 Jan 2020 04:24:26 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1D5A3F534;
        Thu,  9 Jan 2020 04:24:24 -0800 (PST)
Subject: Re: [Patch v6 1/7] sched/pelt.c: Add support to track thermal
 pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Quentin Perret <qperret@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-2-git-send-email-thara.gopinath@linaro.org>
 <cdaf2c1f-63bb-2430-c53a-f19a45035fc5@arm.com>
 <CALD-y_xHS7CaZ8SU--VP5+2F5Y8cVb4sw0XuG+JUpP_jxE7yuQ@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8a85f4c2-6ef8-314a-c56d-86c773d5ead0@arm.com>
Date:   Thu, 9 Jan 2020 13:24:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CALD-y_xHS7CaZ8SU--VP5+2F5Y8cVb4sw0XuG+JUpP_jxE7yuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2020 15:56, Thara Gopinath wrote:
> On Tue, 17 Dec 2019 at 07:54, Dietmar Eggemann <dietmar.eggemann@arm.com>
> wrote:
> 
>> On 12/12/2019 05:11, Thara Gopinath wrote:
>>
>> minor: in subject: s/sched/pelt.c/sched/pelt
>>
>> [...]
>>
>>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>>> index a96db50..9aac3b7 100644
>>> --- a/kernel/sched/pelt.c
>>> +++ b/kernel/sched/pelt.c
>>> @@ -353,6 +353,28 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq,
>> int running)
>>>       return 0;
>>>  }
>>>
>>> +/*
>>> + * thermal:
>>> + *
>>> + *   load_sum = \Sum se->avg.load_sum
>>
>> Why not '\Sum rq->avg.load_sum' ?
>>
> Hi Dietmar,
> 
> The header for all other update_*_load_avg api use se->avg. and not rq->avg.

True but at least they (rt_rq, dl_rq, irq) also say 'but
se->avg.util_sum is not tracked'.

I guess this comment originally came from the
'__update_load_avg_blocked_se(), __update_load_avg_se(),
__update_load_avg_cfs_rq()' block:

* cfq_rq:
 *
 *   load_sum = \Sum se_weight(se) * se->avg.load_sum

but for rt_rq, dl_rq, irq and thermal we don't have a relationship like
between se and cfs_rq's so that's why this comment confuses me.
