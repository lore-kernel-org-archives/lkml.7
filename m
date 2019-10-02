Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEDCC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC42206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfJBJVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:21:40 -0400
Received: from foss.arm.com ([217.140.110.172]:39678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfJBJVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:21:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA7FA1570;
        Wed,  2 Oct 2019 02:21:38 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB2F93F706;
        Wed,  2 Oct 2019 02:21:36 -0700 (PDT)
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <9bfb3252-c268-8c0c-9c72-65f872e9c8b2@arm.com>
 <CAKfTPtDUFMFnD+RZndx0+8A+V9HV9Hv0TN+p=mAge0VsqS6xmA@mail.gmail.com>
 <3dca46c5-c395-e2b3-a7e8-e9208ba741c8@arm.com>
 <CAKfTPtDGxX11=vgJsV-o-jOxgPmbr0VXWmR6LEVuD6WG=VRXyA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b2d10a98-6688-3909-1bd9-e5700c521d5d@arm.com>
Date:   Wed, 2 Oct 2019 11:21:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDGxX11=vgJsV-o-jOxgPmbr0VXWmR6LEVuD6WG=VRXyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2019 08:44, Vincent Guittot wrote:
> On Tue, 1 Oct 2019 at 18:53, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 01/10/2019 10:14, Vincent Guittot wrote:
>>> On Mon, 30 Sep 2019 at 18:24, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> Hi Vincent,
>>>>
>>>> On 19/09/2019 09:33, Vincent Guittot wrote:
>>
>> [...]
>>
>>>>> @@ -7347,7 +7362,7 @@ static int detach_tasks(struct lb_env *env)
>>>>>   {
>>>>>         struct list_head *tasks = &env->src_rq->cfs_tasks;
>>>>>         struct task_struct *p;
>>>>> -     unsigned long load;
>>>>> +     unsigned long util, load;
>>>>
>>>> Minor: Order by length or reduce scope to while loop ?
>>>
>>> I don't get your point here
>>
>> Nothing dramatic here! Just
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d0c3aa1dc290..a08f342ead89 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7333,8 +7333,8 @@ static const unsigned int sched_nr_migrate_break = 32;
>>  static int detach_tasks(struct lb_env *env)
>>  {
>>         struct list_head *tasks = &env->src_rq->cfs_tasks;
>> -       struct task_struct *p;
>>         unsigned long load, util;
>> +       struct task_struct *p;
> 
> hmm... I still don't get this.
> We usually gather pointers instead of interleaving them with other varaiables

I thought we should always order local variable declarations from
longest to shortest line but can't find this rule in coding-style.rst
either.

[...]
