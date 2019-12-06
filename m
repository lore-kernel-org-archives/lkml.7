Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D7BC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA202173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLFQFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:05:02 -0500
Received: from foss.arm.com ([217.140.110.172]:48996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfLFQFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:05:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B60E31B;
        Fri,  6 Dec 2019 08:05:01 -0800 (PST)
Received: from [192.168.1.13] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 418ED3F718;
        Fri,  6 Dec 2019 08:04:58 -0800 (PST)
Subject: Re: [RFC 3/3] Allow sched_{get,set}attr to change latency_tolerance
 of the task
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Parth Shah <parth@linux.ibm.com>, Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        pavel@ucw.cz, dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, viresh.kumar@linaro.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <20191125094618.30298-4-parth@linux.ibm.com>
 <20191203083915.yahl2qd3wnnkqxxs@e107158-lin.cambridge.arm.com>
 <cfb607c1-6be9-853d-cfad-6787f78fa6ad@linux.ibm.com>
 <ffe4f4de-d433-91be-00ce-20b625807f20@arm.com>
Message-ID: <09e9a3e1-9c43-a541-01e6-e1b429a63a6f@arm.com>
Date:   Fri, 6 Dec 2019 17:04:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <ffe4f4de-d433-91be-00ce-20b625807f20@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.12.19 10:24, Dietmar Eggemann wrote:
> On 03/12/2019 16:51, Parth Shah wrote:
>>  
>> On 12/3/19 2:09 PM, Qais Yousef wrote:
>>> On 11/25/19 15:16, Parth Shah wrote:
> 
> [...]
> 
>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>> index ea7abbf5c1bb..dfd36ec14404 100644
>>>> --- a/kernel/sched/core.c
>>>> +++ b/kernel/sched/core.c
>>>> @@ -4695,6 +4695,9 @@ static void __setscheduler_params(struct task_struct *p,
>>>>  	p->rt_priority = attr->sched_priority;
>>>>  	p->normal_prio = normal_prio(p);
>>>>  	set_load_weight(p, true);
>>>> +
>>>> +	/* Change latency tolerance of the task if !SCHED_FLAG_KEEP_PARAMS */
> 
> IMHO, this comment seems to be gratuitous.
> 
>>>> +	p->latency_tolerance = attr->sched_latency_tolerance;
>>>>  }
> 
> [...]
> 

This also would require some changes to UAPI
(include/uapi/linux/sched.h, include/uapi/linux/sched/types.h), see
commit a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support
utilization clamping") and tools headers UAPI
(tools/include/uapi/linux/sched.h), see commit c093de6bd3c5 ("tools
headers UAPI: Sync sched.h with the kernel").
