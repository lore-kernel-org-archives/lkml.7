Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66112C004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418C52075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfECRPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 13:15:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfECRPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 13:15:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 481CD3081252;
        Fri,  3 May 2019 17:15:24 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D45E31001944;
        Fri,  3 May 2019 17:15:22 +0000 (UTC)
Subject: Re: [PATCH-tip v7 11/20] locking/rwsem: Wake up almost all readers in
 wait queue
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
 <20190428212557.13482-12-longman@redhat.com>
 <20190503165141.GI2623@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1e5e939f-3725-14d9-feec-aabb63998406@redhat.com>
Date:   Fri, 3 May 2019 13:15:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503165141.GI2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 03 May 2019 17:15:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/19 12:51 PM, Peter Zijlstra wrote:
> On Sun, Apr 28, 2019 at 05:25:48PM -0400, Waiman Long wrote:
>> When the front of the wait queue is a reader, other readers
>> immediately following the first reader will also be woken up at the
>> same time. However, if there is a writer in between. Those readers
>> behind the writer will not be woken up.
>> @@ -345,13 +359,20 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
>>  	 * 2) For each waiters in the new list, clear waiter->task and
>>  	 *    put them into wake_q to be woken up later.
>>  	 */
>> -	list_for_each_entry(waiter, &sem->wait_list, list) {
>> +	INIT_LIST_HEAD(&wlist);
>> +	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
>>  		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
>> -			break;
>> +			continue;
>>  
>>  		woken++;
>> +		list_move_tail(&waiter->list, &wlist);
>> +
>> +		/*
>> +		 * Limit # of readers that can be woken up per wakeup call.
>> +		 */
>> +		if (woken >= MAX_READERS_WAKEUP)
>> +			break;
>>  	}
>> -	list_cut_before(&wlist, &sem->wait_list, &waiter->list);
>>  
>>  	adjustment = woken * RWSEM_READER_BIAS - adjustment;
>>  	lockevent_cond_inc(rwsem_wake_reader, woken);
> An idea for later; maybe we can simplify this by playing silly games
> with the queueing.
>
> Writers: always list_add_tail()
> Readers: keep a pointer to first_reader in the queue;
> 	 when NULL; list_add_tail() and set
> 	 otherwise: list_add_tail(, first_reader);
>
> Possily also keep a count of first_reader list size, and if 'big' reset
> first_reader.
>
> That way we never have to skip over writers.
>
Yes, that can work. However, that will require adding one more pointer
to the rw_semaphore structure. The performance gain with this
optimization may not justify increasing the size of the structure by 4/8
bytes.

Cheers,
Longman

