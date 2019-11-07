Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF77C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DAB214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbfKGLgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:36:31 -0500
Received: from foss.arm.com ([217.140.110.172]:54592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfKGLga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:36:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D43AD7CD;
        Thu,  7 Nov 2019 03:36:29 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C5283F6C4;
        Thu,  7 Nov 2019 03:36:27 -0800 (PST)
Subject: Re: [Patch v5 2/6] sched/fair: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
 <20191105202037.GA17494@e108754-lin> <5DC1E348.2090104@linaro.org>
 <20191105211446.GA25349@e108754-lin> <5DC1E9BC.1010001@linaro.org>
 <20191105215233.GA6450@e108754-lin>
 <436ad772-c727-127e-1469-d99549db03fc@arm.com> <5DC3088B.8070401@linaro.org>
 <943a8368-1f19-d981-7583-0db4e32895af@arm.com>
 <CAKfTPtBkDzYv5cFgCNjOHN53KBQZJBAJ77ft-CARo=g=GuZ8Sg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7f93ad5f-cce2-707b-7562-5860bcdd4ae1@arm.com>
Date:   Thu, 7 Nov 2019 12:36:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBkDzYv5cFgCNjOHN53KBQZJBAJ77ft-CARo=g=GuZ8Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2019 11:48, Vincent Guittot wrote:
> On Thu, 7 Nov 2019 at 10:32, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 06/11/2019 18:53, Thara Gopinath wrote:
>>> On 11/06/2019 07:50 AM, Dietmar Eggemann wrote:
>>>> On 05/11/2019 22:53, Ionela Voinescu wrote:
>>>>> On Tuesday 05 Nov 2019 at 16:29:32 (-0500), Thara Gopinath wrote:
>>>>>> On 11/05/2019 04:15 PM, Ionela Voinescu wrote:
>>>>>>> On Tuesday 05 Nov 2019 at 16:02:00 (-0500), Thara Gopinath wrote:
>>>>>>>> On 11/05/2019 03:21 PM, Ionela Voinescu wrote:

[...]

> In fact, trigger_thermal_pressure_average is only there because of
> shifting the clock which is introduced only in patch 6.
> So remove trigger_thermal_pressure_average from this patch and call directly
> 
> +       update_thermal_load_avg(rq_clock_task(rq), rq,
> +                               per_cpu(thermal_pressure, cpu_of(rq)));
> 
> in patch3

I like the rq_clock_thermal() idea in
https://lore.kernel.org/r/20191107104901.GA472@linaro.org to get rid of
trigger_thermal_pressure_average().

>> That's not the issue here. The issue is the extra shim layer which is
>> unnecessary in the current implementation.
>>
>> update_blocked_averages()
>> {
>>     ...
>>     update_rt_rq_load_avg()
>>     update_dl_rq_load_avg()
>>     update_irq_load_avg()
>>     trigger_thermal_pressure_average() <--- ?
>>     ...
>> }

[...]
