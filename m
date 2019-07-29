Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF220C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F24206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfG2Ovx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:51:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbfG2Ovx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:51:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07480C057E9F;
        Mon, 29 Jul 2019 14:51:53 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 479A55D6A0;
        Mon, 29 Jul 2019 14:51:52 +0000 (UTC)
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>
References: <20190727171047.31610-1-longman@redhat.com>
 <20190729085235.GT31381@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4cd17c3a-428c-37a0-b3a2-04e6195a61d5@redhat.com>
Date:   Mon, 29 Jul 2019 10:51:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190729085235.GT31381@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 29 Jul 2019 14:51:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 4:52 AM, Peter Zijlstra wrote:
> On Sat, Jul 27, 2019 at 01:10:47PM -0400, Waiman Long wrote:
>> It was found that a dying mm_struct where the owning task has exited
>> can stay on as active_mm of kernel threads as long as no other user
>> tasks run on those CPUs that use it as active_mm. This prolongs the
>> life time of dying mm holding up memory and other resources like swap
>> space that cannot be freed.
> Sure, but this has been so 'forever', why is it a problem now?

I ran into this probem when running a test program that keeps on
allocating and touch memory and it eventually fails as the swap space is
full. After the failure, I could not rerun the test program again
because the swap space remained full. I finally track it down to the
fact that the mm stayed on as active_mm of kernel threads. I have to
make sure that all the idle cpus get a user task to run to bump the
dying mm off the active_mm of those cpus, but this is just a workaround,
not a solution to this problem.

>
>> Fix that by forcing the kernel threads to use init_mm as the active_mm
>> if the previous active_mm is dying.
>>
>> The determination of a dying mm is based on the absence of an owning
>> task. The selection of the owning task only happens with the CONFIG_MEMCG
>> option. Without that, there is no simple way to determine the life span
>> of a given mm. So it falls back to the old behavior.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  include/linux/mm_types.h | 15 +++++++++++++++
>>  kernel/sched/core.c      | 13 +++++++++++--
>>  mm/init-mm.c             |  4 ++++
>>  3 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 3a37a89eb7a7..32712e78763c 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -623,6 +623,21 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
>>  	return atomic_read(&mm->tlb_flush_pending) > 1;
>>  }
>>  
>> +#ifdef CONFIG_MEMCG
>> +/*
>> + * A mm is considered dying if there is no owning task.
>> + */
>> +static inline bool mm_dying(struct mm_struct *mm)
>> +{
>> +	return !mm->owner;
>> +}
>> +#else
>> +static inline bool mm_dying(struct mm_struct *mm)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +
>>  struct vm_fault;
> Yuck. So people without memcg will still suffer the terrible 'whatever
> it is this patch fixes'.
>
That is true.
>>  /**
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 2b037f195473..923a63262dfd 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3233,13 +3233,22 @@ context_switch(struct rq *rq, struct task_struct *prev,
>>  	 * Both of these contain the full memory barrier required by
>>  	 * membarrier after storing to rq->curr, before returning to
>>  	 * user-space.
>> +	 *
>> +	 * If mm is NULL and oldmm is dying (!owner), we switch to
>> +	 * init_mm instead to make sure that oldmm can be freed ASAP.
>>  	 */
>> -	if (!mm) {
>> +	if (!mm && !mm_dying(oldmm)) {
>>  		next->active_mm = oldmm;
>>  		mmgrab(oldmm);
>>  		enter_lazy_tlb(oldmm, next);
>> -	} else
>> +	} else {
>> +		if (!mm) {
>> +			mm = &init_mm;
>> +			next->active_mm = mm;
>> +			mmgrab(mm);
>> +		}
>>  		switch_mm_irqs_off(oldmm, mm, next);
>> +	}
>>  
>>  	if (!prev->mm) {
>>  		prev->active_mm = NULL;
> Bah, I see we _still_ haven't 'fixed' that code. And you're making an
> even bigger mess of it.
>
> Let me go find where that cleanup went.

It would be nice if there is a better solution.

Cheers,
Longman

