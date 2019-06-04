Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AB5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B539720717
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfFDPo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:44:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728142AbfFDPo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:44:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 706E4A7F8;
        Tue,  4 Jun 2019 15:44:52 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EBE95D705;
        Tue,  4 Jun 2019 15:44:47 +0000 (UTC)
Subject: Re: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an
 atomic_long_t
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
 <20190520205918.22251-14-longman@redhat.com>
 <20190604085238.GF3402@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <0d4d11c4-80e8-f75f-fae8-b653481db260@redhat.com>
Date:   Tue, 4 Jun 2019 11:44:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604085238.GF3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 04 Jun 2019 15:44:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 4:52 AM, Peter Zijlstra wrote:
> On Mon, May 20, 2019 at 04:59:12PM -0400, Waiman Long wrote:
>> +static inline struct task_struct *rwsem_read_owner(struct rw_semaphore *sem)
>> +{
>> +	return (struct task_struct *)(atomic_long_read(&sem->owner) &
>> +					~RWSEM_OWNER_FLAGS_MASK);
>> +}
>> +
>> +/*
>> + * Return the real task structure pointer of the owner and the embedded
>> + * flags in the owner. pflags must be non-NULL.
>> + */
>> +static inline struct task_struct *
>> +rwsem_read_owner_flags(struct rw_semaphore *sem, long *pflags)
>> +{
>> +	long owner = atomic_long_read(&sem->owner);
>> +
>> +	*pflags = owner & RWSEM_OWNER_FLAGS_MASK;
>> +	return (struct task_struct *)(owner & ~RWSEM_OWNER_FLAGS_MASK);
>> +}
> I got confused by the 'read' part in those nanes, I initially thought
> they paired with rwsem_set_reader_owned().

Sorry for the confusion. I initially use "get", but I am afraid that it
may get confused with "get/put" for reference counting. So I used read
instead.


> So I've done 's/rwsem_read_owner/rwsem_owner/g on it.

I am fine with getting rid of the "read" from the function names.

Cheers,
Longman

