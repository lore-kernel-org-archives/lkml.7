Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2D8CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91C720869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfKDRmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:42:06 -0500
Received: from foss.arm.com ([217.140.110.172]:48194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbfKDRmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:42:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0C401F1;
        Mon,  4 Nov 2019 09:42:01 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D262B3F71A;
        Mon,  4 Nov 2019 09:41:59 -0800 (PST)
Subject: Re: [Patch v4 2/6] sched: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-3-git-send-email-thara.gopinath@linaro.org>
 <379d23e5-79a5-9d90-0fb6-125d9be85e99@arm.com> <5DBC9C57.3040504@linaro.org>
 <dc30ed89-6581-d99d-03bb-58ea40b74a3d@arm.com>
 <CAKfTPtBQ1_7ApBkAQrEBy7twohSiM3WcYa-JiHekbedR8C3EKg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d7c590b5-f415-ecad-0e81-def9f9bc1296@arm.com>
Date:   Mon, 4 Nov 2019 18:41:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBQ1_7ApBkAQrEBy7twohSiM3WcYa-JiHekbedR8C3EKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2019 18:34, Vincent Guittot wrote:
> On Mon, 4 Nov 2019 at 18:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 01/11/2019 21:57, Thara Gopinath wrote:
>>> On 11/01/2019 08:17 AM, Dietmar Eggemann wrote:
>>>> On 22.10.19 22:34, Thara Gopinath wrote:

[...]

>>> You still need now.All the update_*_avg apis take now as a parameter.
>>
>> You do need it for the ___update_load_sum() call inside the
>> foo_load_avg() functions. But that doesn't mean you have to pass it into
>> foo_load_avg(). Look at update_irq_load_avg() for example. We don't pass
>> rq->clock as now in there.
> 
> update_irq_load_avg is the exception but having now as a parameter is
> the default behavior that update_thermal_load_avg have to follow

Why would this be? Just so the functions have the the same parameters?

In this case you could argue that update_irq_load_avg() has to pass in
rq->clock as now.

>> -int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
>> +extern int sched_thermal_decay_coeff;
>> +
>> +int update_thermal_load_avg(struct rq *rq, u64 capacity)
>>  {
>> +       u64 now = rq_clock_task(rq) >> sched_thermal_decay_coeff;
>> +
>>         if (___update_load_sum(now, &rq->avg_thermal,
>>                                capacity,
>>                                capacity,
