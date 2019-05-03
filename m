Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7964C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BF42089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfECN5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:57:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35291 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbfECN5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:57:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC6C48F295;
        Fri,  3 May 2019 13:57:45 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FDB05F9B8;
        Fri,  3 May 2019 13:57:44 +0000 (UTC)
Subject: Re: [PATCH-tip v7 08/20] locking/rwsem: Implement lock handoff to
 prevent lock starvation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190428212557.13482-1-longman@redhat.com>
 <20190428212557.13482-9-longman@redhat.com>
 <20190503131054.GE2623@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a2582814-cdd0-e5a9-1dd7-f426127ea462@redhat.com>
Date:   Fri, 3 May 2019 09:57:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503131054.GE2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 03 May 2019 13:57:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/19 9:10 AM, Peter Zijlstra wrote:
> On Sun, Apr 28, 2019 at 05:25:45PM -0400, Waiman Long wrote:
>> +static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
>> +					enum writer_wait_state wstate)
>>  {
>>  	long new;
>>  
>> +	lockdep_assert_held(&sem->wait_lock);
>> +	do {
>> +		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>>  
>> +		if (has_handoff && wstate == WRITER_NOT_FIRST)
>> +			return false;
>>  
>> +		if (count & RWSEM_LOCK_MASK) {
>> +			if (has_handoff || (wstate != WRITER_HANDOFF))
>> +				return false;
>> +			new = count | RWSEM_FLAG_HANDOFF;
>> +		} else {
>> +			new = (count | RWSEM_WRITER_LOCKED) &
>> +				~RWSEM_FLAG_HANDOFF;
>>  
>> +			if (list_is_singular(&sem->wait_list))
>> +				new &= ~RWSEM_FLAG_WAITERS;
>> +		}
>> +	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
>> +
>> +	/*
>> +	 * We have either acquired the lock with handoff bit cleared or
>> +	 * set the handoff bit.
>> +	 */
>> +	if (new & RWSEM_FLAG_HANDOFF)
>> +		return false;
>> +
>> +	rwsem_set_owner(sem);
>> +	return true;
>>  }
> I've changed that like so.
>
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -406,19 +406,23 @@ static inline bool rwsem_try_write_lock(
>  	long new;
>  
>  	lockdep_assert_held(&sem->wait_lock);
> +
>  	do {
>  		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>  
>  		if (has_handoff && wstate == WRITER_NOT_FIRST)
>  			return false;
>  
> +		new = count;
> +
>  		if (count & RWSEM_LOCK_MASK) {
>  			if (has_handoff || (wstate != WRITER_HANDOFF))
>  				return false;
> -			new = count | RWSEM_FLAG_HANDOFF;
> +
> +			new |= RWSEM_FLAG_HANDOFF;
>  		} else {
> -			new = (count | RWSEM_WRITER_LOCKED) &
> -				~RWSEM_FLAG_HANDOFF;
> +			new |= RWSEM_WRITER_LOCKED;
> +			new &= ~RWSEM_FLAG_HANDOFF;
>  
>  			if (list_is_singular(&sem->wait_list))
>  				new &= ~RWSEM_FLAG_WAITERS;

Will the apply the changes in the next version.

Thanks,
Longman

