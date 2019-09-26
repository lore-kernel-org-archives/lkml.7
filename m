Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C3EC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DCD21A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391285AbfIZBtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:49:51 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:38064 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388759AbfIZBtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:49:51 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDIui-0000jf-AQ; Wed, 25 Sep 2019 19:49:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDIuh-0005km-Di; Wed, 25 Sep 2019 19:49:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
        <20190830160957.GC2634@redhat.com>
        <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
        <87o906wimo.fsf@x220.int.ebiederm.org>
        <20190902134003.GA14770@redhat.com>
        <87tv9uiq9r.fsf@x220.int.ebiederm.org>
        <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
        <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
        <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
        <87ftkzdpjd.fsf_-_@x220.int.ebiederm.org>
        <20190920230247.GA6449@lenoir>
Date:   Wed, 25 Sep 2019 20:49:17 -0500
In-Reply-To: <20190920230247.GA6449@lenoir> (Frederic Weisbecker's message of
        "Sat, 21 Sep 2019 01:02:49 +0200")
Message-ID: <87k19vyggy.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iDIuh-0005km-Di;;;mid=<87k19vyggy.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/vXS4c/TBUpfjl6nT0dzrJH0S5jUSRrMo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 4/4] task: RCUify the assignment of rq->curr
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:

> On Sat, Sep 14, 2019 at 07:35:02AM -0500, Eric W. Biederman wrote:
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 69015b7c28da..668262806942 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3857,7 +3857,11 @@ static void __sched notrace __schedule(bool preempt)
>>  
>>  	if (likely(prev != next)) {
>>  		rq->nr_switches++;
>> -		rq->curr = next;
>> +		/*
>> +		 * RCU users of rcu_dereference(rq->curr) may not see
>> +		 * changes to task_struct made by pick_next_task().
>> +		 */
>> +		RCU_INIT_POINTER(rq->curr, next);
>
> It would be nice to have more explanations in the comments as to why we
> don't use rcu_assign_pointer() here (the very fast-path issue) and why
> it is expected to be fine (the rq_lock() + post spinlock barrier) under
> which condition. Some short summary of the changelog. Because that line
> implies way too many subtleties.

Crucially that line documents the standard rules don't apply,
and it documents which guarantees a new user of the code can probably
count on.  I say probably because the comment may go stale before I new
user of rcu appears.  I have my hopes things are simple enough at that
location that if the comment needs to be changed it can be.

If it is not obvious from reading the code that calls
"task_rcu_dereference(rq->curr)" now "rcu_dereference(rq->curr)" why we
don't need the guarantees from rcu_assign_pointet() my sense is that
it should be those locations that document what guarantees they need.

Of the several different locations that use this my sense is that they
all have different requirements.

- The rcuwait code just needs the lifetime change as it never dereferences
  rq->curr.

- The membarrier code just looks at rq->curr->mm for a moment so it
  hardly needs anything.  I suspect we might be able to make the rcu
  critical section smaller in that code.

- I don't know the code in task_numa_compare() well enough even to make an
  educated guess.  Peter asserts (if I read his reply correctly) it is
  all just a heuristic so stale values should not matter.

  My reading of the code strongly suggests that we have the ordinary
  rcu_assign_pointer() guarantees there.  The few fields that are not
  covered by the ordinary guarantees do not appear to be read.  So even
  if Peter is wrong RCU_INIT_POINTER appears safe to me.

  I also don't think we will have confusion with people reading the
  code and expecting ordinary rcu_dereference semantics().

I can't possibly see putting the above several lines in a meaningful
comment where RCU_INIT_POINTER is called.  Especially in a comment
that will survive changes to any of those functions.  My experience
is comments that try that are almost always overlooked when someone
updates the code.

I barely found all of the comments that depended upon the details of
task_rcu_dereference and updated them in my patchset, when I removed
the need for task_rcu_dereference.

I don't think it would be wise to put a comment that is a wall of words
in the middle of __schedule().  I think it will become inaccurate with
time and because it is a lot of words I think it will be ignored.


As for the __schedule: It is the heart of the scheduler.  It is
performance code.  It is clever code.  It is likely to stay that way
because it is the scheduler.  There are good technical reasons for the
code is the way it is, and anyone changing the scheduler in a
responsible manner that includes benchmarking should find those
technical reasons quickly enough.


So I think a quick word to the wise is enough.  Comments are certainly
not enough to prevent people being careless and making foolish mistakes.

Eric

