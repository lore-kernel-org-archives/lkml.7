Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8168FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EF520833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfDONnE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:43:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1815 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfDONnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:43:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4A364E92B;
        Mon, 15 Apr 2019 13:43:02 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-46.rdu2.redhat.com [10.10.122.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A8F619C56;
        Mon, 15 Apr 2019 13:43:01 +0000 (UTC)
Subject: Re: [PATCH-tip v3 02/14] locking/rwsem: Make owner available even if
 !CONFIG_RWSEM_SPIN_ON_OWNER
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190410184231.6748-1-longman@redhat.com>
 <20190410184231.6748-3-longman@redhat.com>
 <20190411081224.GB4038@hirez.programming.kicks-ass.net>
 <29aca54a-536e-6e46-7e18-658914c34548@redhat.com>
 <20190412070209.GC129493@gmail.com>
 <20190412070545.GF11158@hirez.programming.kicks-ass.net>
 <20190412070904.GA45214@gmail.com>
 <b97eb5d5-1658-c405-e52e-2d20c4840948@redhat.com>
 <33b0111b-fe0f-eefc-59f4-f06d84d9cacc@redhat.com>
 <277e9c8e-8913-b251-4c98-dd2d4997d643@redhat.com>
 <20190412164123.GA119547@gmail.com>
 <4aefd2cd-f303-99ed-ada9-e7ba2ae9cd3c@redhat.com>
 <00ce3ea9-0046-740f-6a6c-3b4aff2c3c6e@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <d012c68e-4c43-04af-3505-4c980e2d00a5@redhat.com>
Date:   Mon, 15 Apr 2019 09:43:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <00ce3ea9-0046-740f-6a6c-3b4aff2c3c6e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 15 Apr 2019 13:43:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 10:24 PM, Waiman Long wrote:
> On 04/12/2019 02:05 PM, Waiman Long wrote:
>
>>>  [locking/rwsem] adc32e8877: will-it-scale.per_thread_ops -21.0% regression
>> Will look into that also.
> I can reproduce the regression on the same skylake system.
>
> The results of the page_fault1 will-it-scale test are as follows:
>
>  Threads   K2      K3       K4       K5
>  -------   --      --       --       --
>     20  5549772  5550332  5463961  5400064
>     40  9540445 10286071  9705062  7706082
>     60  8187245  8212307  7777247  6647705
>     89  8390758  9619271  9019454  7124407
>
> So the wake-all-reader patch is good for this benchmark. The performance
> was reduced a bit with the reader-spin-on-writer patch. It got even worse
> with the writer-spin-on-reader patch.
>
> I looked at the perf output, rwsem contention accounted for less than
> 1% of the total cpu cycles. So I believe the regression was caused by
> the behavior change introduced by the two reader optimistic spinning
> patches. These patch will make writer less preferred than before. I
> think the performance of this microbenchmark may be more dependent on
> writer performance.
>
> Looking at the lock event counts for K5:
>
>  rwsem_opt_fail=253647
>  rwsem_opt_nospin=8776
>  rwsem_opt_rlock=259941
>  rwsem_opt_wlock=2543
>  rwsem_rlock=237747
>  rwsem_rlock_fail=0
>  rwsem_rlock_fast=0
>  rwsem_rlock_handoff=0
>  rwsem_sleep_reader=237747
>  rwsem_sleep_writer=23098
>  rwsem_wake_reader=6033
>  rwsem_wake_writer=47032
>  rwsem_wlock=15890
>  rwsem_wlock_fail=10
>  rwsem_wlock_handoff=3991
>
> For K4, it was
>
>  rwsem_opt_fail=479626
>  rwsem_opt_rlock=8877
>  rwsem_opt_wlock=114
>  rwsem_rlock=453874
>  rwsem_rlock_fail=0
>  rwsem_rlock_fast=1234
>  rwsem_rlock_handoff=0
>  rwsem_sleep_reader=453058
>  rwsem_sleep_writer=25836
>  rwsem_wake_reader=11054
>  rwsem_wake_writer=71568
>  rwsem_wlock=24515
>  rwsem_wlock_fail=3
>  rwsem_wlock_handoff=5245
>
> It can be seen that a lot more readers got the lock via optimistic
> spinning.  One possibility is that reader optimistic spinning causes
> readers to spread out into more lock acquisition groups than without. The
> K3 results show that grouping more readers into one lock acquisition
> group help to improve performance for this microbenchmark. I will need
> to run more tests to find out the root cause of this regression. It is
> not an easy problem to solve.

Just an update on my will-it-scale regression investigation. I have
tried various ways to tune the rwsem code to get more performance out
from this benchmark. I got some minor improvements but nothing major. So
it looks like that there are some workloads that have performance hurted
by reader optimistic spinning and this benchmark is one of them. Now I
am testing an adaptive reader optimistic spinning disabling patch that
shows great promise as I was able to bring back a major portion of the
lost performance. I will try to make the patch more aggressive to see if
it can bring most of the lost performance back.

Cheers,
Longman

