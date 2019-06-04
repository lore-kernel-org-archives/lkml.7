Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85A5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC9E23AA3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfFDNVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:21:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbfFDNVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:21:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6A4E356F5;
        Tue,  4 Jun 2019 13:21:23 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4C2B1001DD2;
        Tue,  4 Jun 2019 13:21:19 +0000 (UTC)
Subject: Re: [PATCH v8 07/19] locking/rwsem: Implement lock handoff to prevent
 lock starvation
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-8-longman@redhat.com>
 <CAHttsrYx=pgen5yVpYfCKaymoCaA7iJ52B8t_ycD2UcDR2848Q@mail.gmail.com>
 <CAHttsrZCGMqBi4ifj7A1rO3G3nOz-0pbD8TXRtUQ1rGQRAGiUw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d423baba-35d7-19aa-f192-b25f62e9e265@redhat.com>
Date:   Tue, 4 Jun 2019 09:21:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHttsrZCGMqBi4ifj7A1rO3G3nOz-0pbD8TXRtUQ1rGQRAGiUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 04 Jun 2019 13:21:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/19 11:26 PM, Yuyang Du wrote:
> On Tue, 4 Jun 2019 at 11:03, Yuyang Du <duyuyang@gmail.com> wrote:
>> Hi Waiman,
>>
>> On Tue, 21 May 2019 at 05:01, Waiman Long <longman@redhat.com> wrote:
>>> Because of writer lock stealing, it is possible that a constant
>>> stream of incoming writers will cause a waiting writer or reader to
>>> wait indefinitely leading to lock starvation.
>>>
>>> This patch implements a lock handoff mechanism to disable lock stealing
>>> and force lock handoff to the first waiter or waiters (for readers)
>>> in the queue after at least a 4ms waiting period unless it is a RT
>>> writer task which doesn't need to wait. The waiting period is used to
>>> avoid discouraging lock stealing too much to affect performance.
>> I was working on a patchset to solve read-write lock deadlock
>> detection problem (https://lkml.org/lkml/2019/5/16/93).
>>
>> One of the mistakes in that work is that I considered the following
>> case as deadlock:
> Sorry everyone, but let me rephrase:
>
> One of the mistakes in that work is that I considered the following
> case as no deadlock:
>
>>   T1            T2
>>   --            --
>>
>>   down_read1    down_write2
>>
>>   down_write2   down_read1

Yes, that combination shouldn't cause a deadlock. However, the lockdep
code isn't able to recognize this case and so you may still see splat
about possible deadlock scenario when lockdep checking is enabled. So
the general advise is still to try to rearrange the lock ordering, if
possible.

>> So I was trying to understand what really went wrong and find the
>> problem is that if I understand correctly the current rwsem design
>> isn't showing real fairness but priority in favor of write locks, and
>> thus one of the bad effects is that read locks can be starved if write
>> locks keep coming.
>>
>> Luckily, I noticed you are revamping rwsem and seem to have thought
>> about it already. I am not crystal sure what is your work's
>> ramification on the above case, so hope that you can shed some light
>> and perhaps share your thoughts on this.

Lock starvation is certainly possible with the current rwsem code. Why
don't try to apply the patch to see if it can remedy your problem?

Cheers,
Longman

