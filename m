Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D12C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082FC222EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfKSPNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:13:00 -0500
Received: from foss.arm.com ([217.140.110.172]:54104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfKSPM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:12:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D743E30E;
        Tue, 19 Nov 2019 07:12:58 -0800 (PST)
Received: from [10.1.33.133] (e123648.cambridge.arm.com [10.1.33.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16D8C3F6C4;
        Tue, 19 Nov 2019 07:12:55 -0800 (PST)
Subject: Re: Re: [Patch v5 0/6] Introduce Thermal Pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "qperret@google.com" <qperret@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amit.kachhap@gmail.com" <amit.kachhap@gmail.com>,
        "javi.merino@kernel.org" <javi.merino@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <cb27d440-1421-b95e-19c3-4278dd37efda@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <416e69eb-fd45-84c9-864f-d047258e02ec@arm.com>
Date:   Tue, 19 Nov 2019 15:12:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cb27d440-1421-b95e-19c3-4278dd37efda@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/19 11:21 AM, Lukasz Luba wrote:
> Hi Thara,
> 
> I am going to try your patch set on some different board.
> To do that I need more information regarding your setup.
> Please find my comments below. I need probably one hack
> which do not fully understand.
> 
> On 11/5/19 6:49 PM, Thara Gopinath wrote:
>> Thermal governors can respond to an overheat event of a cpu by
>> capping the cpu's maximum possible frequency. This in turn
>> means that the maximum available compute capacity of the
>> cpu is restricted. But today in the kernel, task scheduler is
>> not notified of capping of maximum frequency of a cpu.
>> In other words, scheduler is unaware of maximum capacity
>> restrictions placed on a cpu due to thermal activity.
>> This patch series attempts to address this issue.
>> The benefits identified are better task placement among available
>> cpus in event of overheating which in turn leads to better
>> performance numbers.
>>
>> The reduction in the maximum possible capacity of a cpu due to a
>> thermal event can be considered as thermal pressure. Instantaneous
>> thermal pressure is hard to record and can sometime be erroneous
>> as there can be mismatch between the actual capping of capacity
>> and scheduler recording it. Thus solution is to have a weighted
>> average per cpu value for thermal pressure over time.
>> The weight reflects the amount of time the cpu has spent at a
>> capped maximum frequency. Since thermal pressure is recorded as
>> an average, it must be decayed periodically. Exisiting algorithm
>> in the kernel scheduler pelt framework is re-used to calculate
>> the weighted average. This patch series also defines a sysctl
>> inerface to allow for a configurable decay period.
>>
>> Regarding testing, basic build, boot and sanity testing have been
>> performed on db845c platform with debian file system.
>> Further, dhrystone and hackbench tests have been
>> run with the thermal pressure algorithm. During testing, due to
>> constraints of step wise governor in dealing with big little systems,
> I don't understand this modification. Could you explain what was the
> issue and if this modification did not break the original
> thermal solution upfront? You are then comparing this modified
> version and treat it as an 'origin', am I right?
With Ionela's help I understood the reason for doing this hack.

For those who follow: She created a 'capacity inversion' between
big and little cores to tests if the patches really work.
How: she starts throttling big cores at lower temperature, so earlier
in time, thus the power is shifted towards little cores (which are more
energy efficient and can run with higher frequency). The big cores
run at minimum frequency and little (hopefully) at max frequency.

This 'capacity inversion' is the use case which might occur in the
real world. It is hard to trigger it in normal benchmarks, though.
I don't know how often this 'capacity inversion' occurs and for how
long it stays in real workloads. Based on the tests run with default
thermal solution and results almost the same, I would say that it is
not often (maybe 3% of the test period, otherwise I would get better
results because this patch set solves this issue).
I have run a few different kernels and benchmarks without this
'capacity inversions' and I don't see the regression (and benefits
from this solution), which is also a big plus in case of mainlining it.

In case where the 'capacity inversion' is artificially introduced
into the system for 100% time, the stress tests show huge difference.
Please refer to Ionela's test results [1] (~30% better).

Regards,
Lukasz Luba


[1] 
https://docs.google.com/spreadsheets/d/1ibxDSSSLTodLzihNAw6jM36eVZABuPMMnjvV-Xh4NEo/edit#gid=0
