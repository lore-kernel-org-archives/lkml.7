Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A27BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E56623CB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfFDQys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:54:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfFDQys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:54:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F354E30C1AEA;
        Tue,  4 Jun 2019 16:54:42 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA18360566;
        Tue,  4 Jun 2019 16:54:39 +0000 (UTC)
Subject: Re: [PATCH v8 14/19] locking/rwsem: Enable time-based spinning on
 reader-owned rwsem
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-15-longman@redhat.com>
 <20190604090309.GG3402@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d334f007-85a4-59c3-ec5c-8dccd43d4f3d@redhat.com>
Date:   Tue, 4 Jun 2019 12:54:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604090309.GG3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 04 Jun 2019 16:54:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 5:03 AM, Peter Zijlstra wrote:
> On Mon, May 20, 2019 at 04:59:13PM -0400, Waiman Long wrote:
>> +static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
>> +{
>> +	long owner = atomic_long_read(&sem->owner);
>> +
>> +	while (owner & RWSEM_READER_OWNED) {
>> +		if (owner & RWSEM_NONSPINNABLE)
>> +			break;
>> +		owner = atomic_long_cmpxchg(&sem->owner, owner,
>> +					    owner | RWSEM_NONSPINNABLE);
>> +	}
>> +}
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -206,12 +206,13 @@ static inline void rwsem_set_nonspinnabl
>  {
>  	long owner = atomic_long_read(&sem->owner);
>  
> -	while (owner & RWSEM_READER_OWNED) {
> +	do {
> +		if (!(owner & RWSEM_READER_OWNED))
> +			break;
>  		if (owner & RWSEM_NONSPINNABLE)
>  			break;
> -		owner = atomic_long_cmpxchg(&sem->owner, owner,
> -					    owner | RWSEM_NONSPINNABLE);
> -	}
> +	} while (!atomic_long_try_cmpxchg(&sem->owner, &owner,
> +					  owner | RWSEM_NONSPINNABLE));
>  }
>  
>  /*

Sure.

Thanks,
Longman

