Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3928C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94166206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfJBJZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:25:00 -0400
Received: from foss.arm.com ([217.140.110.172]:39776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfJBJY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:24:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D8EF1000;
        Wed,  2 Oct 2019 02:24:58 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB7F13F706;
        Wed,  2 Oct 2019 02:24:56 -0700 (PDT)
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
 <CAKfTPtAOErKG3XJDbLQEGgqs485ad4R7xc3k1UA9h5092GnkqQ@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1aea9422-a164-ceb6-5b8f-da728718bab9@arm.com>
Date:   Wed, 2 Oct 2019 11:24:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAOErKG3XJDbLQEGgqs485ad4R7xc3k1UA9h5092GnkqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2019 10:23, Vincent Guittot wrote:
> On Tue, 1 Oct 2019 at 18:53, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 01/10/2019 10:14, Vincent Guittot wrote:
>>> On Mon, 30 Sep 2019 at 18:24, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> Hi Vincent,
>>>>
>>>> On 19/09/2019 09:33, Vincent Guittot wrote:
>>
> [...]
> 
>>
>>>>> +             if (busiest->group_weight == 1 || sds->prefer_sibling) {
>>>>> +                     /*
>>>>> +                      * When prefer sibling, evenly spread running tasks on
>>>>> +                      * groups.
>>>>> +                      */
>>>>> +                     env->balance_type = migrate_task;
>>>>> +                     env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
>>>>> +                     return;
>>>>> +             }
>>>>> +
>>>>> +             /*
>>>>> +              * If there is no overload, we just want to even the number of
>>>>> +              * idle cpus.
>>>>> +              */
>>>>> +             env->balance_type = migrate_task;
>>>>> +             env->imbalance = max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1);
>>>>
>>>> Why do we need a max_t(long, 0, ...) here and not for the 'if
>>>> (busiest->group_weight == 1 || sds->prefer_sibling)' case?
>>>
>>> For env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
>>>
>>> either we have sds->prefer_sibling && busiest->sum_nr_running >
>>> local->sum_nr_running + 1
>>
>> I see, this corresponds to
>>
>> /* Try to move all excess tasks to child's sibling domain */
>>        if (sds.prefer_sibling && local->group_type == group_has_spare &&
>>            busiest->sum_h_nr_running > local->sum_h_nr_running + 1)
>>                goto force_balance;
>>
>> in find_busiest_group, I assume.
> 
> yes. But it seems that I missed a case:
> 
> prefer_sibling is set
> busiest->sum_h_nr_running <= local->sum_h_nr_running + 1 so we skip
> goto force_balance above
> But env->idle != CPU_NOT_IDLE  and local->idle_cpus >
> (busiest->idle_cpus + 1) so we also skip goto out_balance and finally
> call calculate_imbalance()
> 
> in calculate_imbalance with prefer_sibling set, imbalance =
> (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
> 
> so we probably want something similar to max_t(long, 0,
> (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1)

Makes sense.

Caught a couple of

[  369.310464] 0-3->4-7 2->5 env->imbalance = 2147483646
[  369.310796] 0-3->4-7 2->4 env->imbalance = 2147483647

in this if condition on h620 running hackbench.
