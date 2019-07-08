Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AF8C606AA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5A720665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfGHKlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 06:41:19 -0400
Received: from foss.arm.com ([217.140.110.172]:44302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfGHKlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 06:41:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9270E360;
        Mon,  8 Jul 2019 03:41:18 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA2FE3F246;
        Mon,  8 Jul 2019 03:41:15 -0700 (PDT)
Subject: Re: [RFC PATCH 2/6] sched/dl: Capacity-aware migrations
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-3-luca.abeni@santannapisa.it>
 <b920d85b-4228-52fd-22db-3a0c26cf8ebd@arm.com>
 <20190708094136.7bce5f46@sweethome>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7d323b6f-ae15-b04d-cd67-a5e6f8d101d5@arm.com>
Date:   Mon, 8 Jul 2019 12:41:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190708094136.7bce5f46@sweethome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/19 9:41 AM, luca abeni wrote:
> Hi Dietmar,
> 
> On Thu, 4 Jul 2019 14:05:22 +0200
> Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> 
>> On 5/6/19 6:48 AM, Luca Abeni wrote:
>>
>> [...]
>>
>>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>>> index 5b981eeeb944..3436f3d8fa8f 100644
>>> --- a/kernel/sched/deadline.c
>>> +++ b/kernel/sched/deadline.c
>>> @@ -1584,6 +1584,9 @@ select_task_rq_dl(struct task_struct *p, int
>>> cpu, int sd_flag, int flags) if (sd_flag != SD_BALANCE_WAKE)
>>>  		goto out;
>>>  
>>> +	if (dl_entity_is_special(&p->dl))
>>> +		goto out;  
>>
>> I wonder if this is really required. The if condition
>>
>> 1591         if (unlikely(dl_task(curr)) &&
>> 1592             (curr->nr_cpus_allowed < 2 ||
>> 1593              !dl_entity_preempt(&p->dl, &curr->dl)) &&
>> 1594             (p->nr_cpus_allowed > 1)) {
>>
>> further below uses '!dl_entity_preempt(&p->dl, &curr->dl))' which
>> returns 'dl_entity_is_special(a) || ...'
> 
> Uhm... I do not remember the details; I remember that the check fixed
> something during the development of the patchset, but I did not check
> if it was still needed when I forward-ported the patches...
> 
> So, maybe it worked around some bugs in previous versions of the
> kernel, but is not needed now.

I figured it out in the meantime ... you added a ' ... ||
static_branch_unlikely(&sched_asym_cpucapacity)' in this patch to this
if condition which let's special dl tasks (like sugov:X) enter this
condition e.g. on big.LITTLE.
