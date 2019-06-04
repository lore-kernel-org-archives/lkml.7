Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04F7C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5622053B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfFDQAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:00:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbfFDQAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:00:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBE6F30C31AF;
        Tue,  4 Jun 2019 16:00:38 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F12517CFA;
        Tue,  4 Jun 2019 16:00:34 +0000 (UTC)
Subject: Re: [PATCH v8 07/19] locking/rwsem: Implement lock handoff to prevent
 lock starvation
To:     Boqun Feng <boqun.feng@gmail.com>, Yuyang Du <duyuyang@gmail.com>
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
        huang ying <huang.ying.caritas@gmail.com>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-8-longman@redhat.com>
 <CAHttsrYx=pgen5yVpYfCKaymoCaA7iJ52B8t_ycD2UcDR2848Q@mail.gmail.com>
 <CAHttsrZCGMqBi4ifj7A1rO3G3nOz-0pbD8TXRtUQ1rGQRAGiUw@mail.gmail.com>
 <20190604091220.GA29633@tardis>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d1a2894e-144e-d30b-966d-c2fd7b6f3f7e@redhat.com>
Date:   Tue, 4 Jun 2019 12:00:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604091220.GA29633@tardis>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 04 Jun 2019 16:00:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 5:12 AM, Boqun Feng wrote:
> On Tue, Jun 04, 2019 at 11:26:30AM +0800, Yuyang Du wrote:
>> On Tue, 4 Jun 2019 at 11:03, Yuyang Du <duyuyang@gmail.com> wrote:
>>> Hi Waiman,
>>>
>>> On Tue, 21 May 2019 at 05:01, Waiman Long <longman@redhat.com> wrote:
>>>> Because of writer lock stealing, it is possible that a constant
>>>> stream of incoming writers will cause a waiting writer or reader to
>>>> wait indefinitely leading to lock starvation.
>>>>
>>>> This patch implements a lock handoff mechanism to disable lock stealing
>>>> and force lock handoff to the first waiter or waiters (for readers)
>>>> in the queue after at least a 4ms waiting period unless it is a RT
>>>> writer task which doesn't need to wait. The waiting period is used to
>>>> avoid discouraging lock stealing too much to affect performance.
>>> I was working on a patchset to solve read-write lock deadlock
>>> detection problem (https://lkml.org/lkml/2019/5/16/93).
>>>
>>> One of the mistakes in that work is that I considered the following
>>> case as deadlock:
>> Sorry everyone, but let me rephrase:
>>
>> One of the mistakes in that work is that I considered the following
>> case as no deadlock:
>>
>>>   T1            T2
>>>   --            --
>>>
>>>   down_read1    down_write2
>>>
>>>   down_write2   down_read1
>>>
> Not sure I understand the whole context here, but isn't adding a third
> independent task makes this a deadlock?
>
> 	 T1            T2		T3
> 	 --            --		--
>
> 	 down_read1    down_write2
> 	 				down_write1
> 	 down_write2   down_read1
>
> from the perspective of lockdep, we cannot be sure whether there will
> a T3 or not.

Yes, that will be a deadlock even with the my rwsem patch applied, as it
will still try to preserve the reader-writer ordering. So it will
certainly be safer to have the same lock ordering for both tasks.

>
> In case that I mis-understood you, maybe your point is about in the
> above case whether "down_read1" on T2 can *gauranteedly* steal (in the
> sense of breaking the fairness) the read lock after Waiman modification?
> If so, I will wait for Waiman's response ;-)

With my patchset applied, the reader-writer ordering is still supposed
to be preserved. Of course, there can be exceptions depending on the
exact timing, but we can't rely on that to prevent deadlock.

Cheers,
Longman

