Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223AAC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0098F206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfG3N7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfG3N7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:59:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BE5D81F0E;
        Tue, 30 Jul 2019 13:59:54 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 208BA60856;
        Tue, 30 Jul 2019 13:59:53 +0000 (UTC)
Subject: Re: [PATCH v3] sched/core: Don't use dying mm as active_mm of
 kthreads
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>
References: <20190729210728.21634-1-longman@redhat.com>
 <20190730084321.GL31381@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <396ac6c6-6c99-3cb8-6ff7-106c82df29ab@redhat.com>
Date:   Tue, 30 Jul 2019 09:59:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730084321.GL31381@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 30 Jul 2019 13:59:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/19 4:43 AM, Peter Zijlstra wrote:
> On Mon, Jul 29, 2019 at 05:07:28PM -0400, Waiman Long wrote:
>> It was found that a dying mm_struct where the owning task has exited
>> can stay on as active_mm of kernel threads as long as no other user
>> tasks run on those CPUs that use it as active_mm. This prolongs the
>> life time of dying mm holding up some resources that cannot be freed
>> on a mostly idle system.
>>
>> Fix that by forcing the kernel threads to use init_mm as the active_mm
>> during a kernel thread to kernel thread transition if the previous
>> active_mm is dying (!mm_users). This will allows the freeing of resources
>> associated with the dying mm ASAP.
>>
>> The presence of a kernel-to-kernel thread transition indicates that
>> the cpu is probably idling with no higher priority user task to run.
>> So the overhead of loading the mm_users cacheline should not really
>> matter in this case.
>>
>> My testing on an x86 system showed that the mm_struct was freed within
>> seconds after the task exited instead of staying alive for minutes or
>> even longer on a mostly idle system before this patch.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/sched/core.c | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 795077af4f1a..41997e676251 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3214,6 +3214,8 @@ static __always_inline struct rq *
>>  context_switch(struct rq *rq, struct task_struct *prev,
>>  	       struct task_struct *next, struct rq_flags *rf)
>>  {
>> +	struct mm_struct *next_mm = next->mm;
>> +
>>  	prepare_task_switch(rq, prev, next);
>>  
>>  	/*
>> @@ -3229,8 +3231,22 @@ context_switch(struct rq *rq, struct task_struct *prev,
>>  	 *
>>  	 * kernel ->   user   switch + mmdrop() active
>>  	 *   user ->   user   switch
>> +	 *
>> +	 * kernel -> kernel and !prev->active_mm->mm_users:
>> +	 *   switch to init_mm + mmgrab() + mmdrop()
>>  	 */
>> -	if (!next->mm) {                                // to kernel
>> +	if (!next_mm) {					// to kernel
>> +		/*
>> +		 * Checking is only done on kernel -> kernel transition
>> +		 * to avoid any performance overhead while user tasks
>> +		 * are running.
>> +		 */
>> +		if (unlikely(!prev->mm &&
>> +			     !atomic_read(&prev->active_mm->mm_users))) {
>> +			next_mm = next->active_mm = &init_mm;
>> +			mmgrab(next_mm);
>> +			goto mm_switch;
>> +		}
>>  		enter_lazy_tlb(prev->active_mm, next);
>>  
>>  		next->active_mm = prev->active_mm;
> So I _really_ hate this complication. I'm thinking if you really care
> about this the time is much better spend getting rid of the active_mm
> tracking for x86 entirely.
>
That is fine. I won't pursue further. I will take a look at your
suggestion when I have time, but it will probably be a while :-)

Cheers,
Longman

