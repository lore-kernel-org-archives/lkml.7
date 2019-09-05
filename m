Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628A9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCE020692
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfIEUDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:03:15 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:49198 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfIEUDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:03:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i5xyH-0001xb-MB; Thu, 05 Sep 2019 14:03:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i5xyG-0007jz-QM; Thu, 05 Sep 2019 14:03:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, mpe@ellerman.id.au
References: <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
        <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
        <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
        <20190903074117.GX2369@hirez.programming.kicks-ass.net>
        <20190903074718.GT2386@hirez.programming.kicks-ass.net>
        <87k1apqqgk.fsf@x220.int.ebiederm.org>
        <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
        <874l1tp7st.fsf@x220.int.ebiederm.org>
        <CAHk-=wjvyRJEdativFqqGGxzSgWnc-m7b+B04iQBMcZV4uM=hA@mail.gmail.com>
        <20190903200603.GW2349@hirez.programming.kicks-ass.net>
        <20190903213218.GG4125@linux.ibm.com>
Date:   Thu, 05 Sep 2019 15:02:49 -0500
In-Reply-To: <20190903213218.GG4125@linux.ibm.com> (Paul E. McKenney's message
        of "Tue, 3 Sep 2019 14:32:18 -0700")
Message-ID: <87r24umryu.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i5xyG-0007jz-QM;;;mid=<87r24umryu.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+VmoE5LIizasbxQiu3HicjHrn61hokgnc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Tue, Sep 03, 2019 at 10:06:03PM +0200, Peter Zijlstra wrote:
>> On Tue, Sep 03, 2019 at 12:18:47PM -0700, Linus Torvalds wrote:
>> > Now, if you can point to some particular field where that ordering
>> > makes sense for the particular case of "make it active on the
>> > runqueue" vs "look up the task from the runqueue using RCU", then I do
>> > think that the whole release->acquire consistency makes sense.
>> > 
>> > But it's not clear that such a field exists, particularly when this is
>> > in no way the *common* way to even get a task pointer, and other paths
>> > do *not* use the runqueue as the serialization point.
>> 
>> Even if we could find a case (and I'm not seeing one in a hurry), I
>> would try really hard to avoid adding extra barriers here and instead
>> make the consumer a little more complicated if at all possible.
>> 
>> The Power folks got rid of a SYNC (yes, more expensive than LWSYNC) from
>> their __switch_to() implementation and that had a measurable impact.
>> 
>> 9145effd626d ("powerpc/64: Drop explicit hwsync in context switch")
>
> The patch [1] looks good to me.  And yes, if the structure pointed to by
> the second argument of rcu_assign_pointer() is already visible to readers,
> it is OK to instead use RCU_INIT_POINTER().  Yes, this loses ordering.
> But weren't these simple assignments before RCU got involved?
>
> As a very rough rule of thumb, LWSYNC is about twice as fast as SYNC.
> (Depends on workload, exact details of the hardware, timing, phase of
> the moon, you name it.)  So removing the LWSYNC is likely to provide
> measureable benefit, but I must defer to the powerpc maintainers.
> To that end, I added Michael on CC.
>
> [1] https://lore.kernel.org/lkml/878sr6t21a.fsf_-_@x220.int.ebiederm.org/

Paul, what is the purpose of the barrier in rcu_assign_pointer?

My intuition says it is the assignment half of rcu_dereference, and that
anything that rcu_dereference does not need is too strong.

My basic understanding is that only alpha ever has the memory ordering
issue that rcu_dereference deals with.  So I am a bit surprised that
this is anything other than a noop for anything except alpha.

In my patch I used rcu_assign_pointer because that is the canonically
correct way to do things.  Peter makes a good case that adding an extra
barrier in ___schedule could be detrimental to system performance.
At the same time if there is a correctness issue on alpha that we have
been overlooking because of low testing volume on alpha I don't want to
just let this slide and have very subtle bugs.

The practical concern is that people have been really wanting to do
lockless and rcu operations on tasks in the runqueue for a while and
there are several very clever pieces of code doing that now.  By
changing the location of the rcu put I am trying to make these uses
ordinary rcu uses.

The uses in question are the pieces of code I update in:
https://lore.kernel.org/lkml/8736het20c.fsf_-_@x220.int.ebiederm.org/

In short.  Why is rcu_assign_pointer() more than WRITE_ONCE() on
anything but alpha?  Do other architectures need more?  Is the trade off
worth it if we avoid using rcu_assign_pointer on performance critical
paths.

Eric

p.s. I am being slow at working through all of this as I am dealing
     with my young baby son, and busy packing for the conference.

     I might not be able to get back to this discussion until after
     I have landed in Lisbon on Saturday night.
