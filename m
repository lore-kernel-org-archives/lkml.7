Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAC4C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FEE20674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfFXLYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:24:16 -0400
Received: from foss.arm.com ([217.140.110.172]:47508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfFXLYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:24:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B918D2B;
        Mon, 24 Jun 2019 04:24:14 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D847D3F718;
        Mon, 24 Jun 2019 04:24:12 -0700 (PDT)
Subject: Re: [PATCH 5/8] sched,cfs: use explicit cfs_rq of parent se helper
To:     Rik van Riel <riel@surriel.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org
References: <20190612193227.993-1-riel@surriel.com>
 <20190612193227.993-6-riel@surriel.com>
 <55c0dc01-24b2-bb7f-6ceb-b65c52f7b46b@arm.com>
 <c5c73fd374ed952eedc46a89af294e1d521609b2.camel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1f90005d-1130-399b-8642-9e1ad7089ab3@arm.com>
Date:   Mon, 24 Jun 2019 13:24:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c5c73fd374ed952eedc46a89af294e1d521609b2.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/19 6:29 PM, Rik van Riel wrote:
> On Thu, 2019-06-20 at 18:23 +0200, Dietmar Eggemann wrote:
>> On 6/12/19 9:32 PM, Rik van Riel wrote:

[...]

>>> @@ -7779,7 +7788,7 @@ static void update_cfs_rq_h_load(struct
>>> cfs_rq *cfs_rq)
>>>  
>>>  	WRITE_ONCE(cfs_rq->h_load_next, NULL);
>>>  	for_each_sched_entity(se) {
>>> -		cfs_rq = cfs_rq_of(se);
>>> +		cfs_rq = group_cfs_rq_of_parent(se);
>>
>> Why do you change this here? task_se_h_load() calls
>> update_cfs_rq_h_load() with cfs_rq = group_cfs_rq_of_parent(se)
>> because
>> the task might not be on the cfs_rq yet.
> 
> Because patch 6 points cfs_rq_of(se) at the CPU's top level
> cfs_rq for every task se ...
> 
> ... but I guess since I have not changed where the cfs_rq_of
> points for cgroup sched_entities, this change is not necessary
> at this time, and I should be able to go without it, in this
> function.

IMHO, since you only change set_task_rq() (p->se.cfs_rq =
&cpu_rq(cpu)->cfs instead of tg->cfs_rq[cpu] in 8/8) (used for a task)
and not init_tg_cfs_entry() (used for a taskgroup), 'cfs_rq_of(se) ==
se->parent->my_q' should still be true in update_cfs_rq_h_load().

update_cfs_rq_h_load() only deals with se's representing taskgroups. So
cfs_rq_of(se) and group_cfs_rq_of_parent(se) should deliver the same
result for these se's.

>> But inside update_cfs_rq_h_load() the first se is derived from
>> cfs_rq->tg->se[cpu_of(rq)] so in the first for_each_sched_entity()
>> loop
>> we should still start with group_cfs_rq() (se->my_q) ?

Here I was wrong. The first loop did use cfs_rq_of() and not group_cfs_rq().
[...]

