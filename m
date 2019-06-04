Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A53C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852F7208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFDRaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:30:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfFDRaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:30:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1EC3B2F8BC1;
        Tue,  4 Jun 2019 17:30:02 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E461919C69;
        Tue,  4 Jun 2019 17:30:00 +0000 (UTC)
Subject: Re: [PATCH v8 15/19] locking/rwsem: Adaptive disabling of reader
 optimistic spinning
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
 <20190520205918.22251-16-longman@redhat.com>
 <20190604092008.GJ3402@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8e7d19ea-f2e6-f441-6ab9-cbff6d96589c@redhat.com>
Date:   Tue, 4 Jun 2019 13:30:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604092008.GJ3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 04 Jun 2019 17:30:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 5:20 AM, Peter Zijlstra wrote:
> On Mon, May 20, 2019 at 04:59:14PM -0400, Waiman Long wrote:
>> @@ -286,6 +325,7 @@ struct rwsem_waiter {
>>  	struct task_struct *task;
>>  	enum rwsem_waiter_type type;
>>  	unsigned long timeout;
>> +	long last_rowner;
>>  };
>>  #define rwsem_first_waiter(sem) \
>>  	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
>> +static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
>> +					      long last_rowner)
>> +static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
>> +					      unsigned long last_rowner)
>> +	waiter.last_rowner = atomic_long_read(&sem->owner);
> That's somewhat inconsistent wrt the type. I'll make it unsigned long,
> as that is what makes most sense, given there's a pointer inside.

Thank for spotting that, I will fix it.

-Longman

