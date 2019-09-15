Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4039FC4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F30321479
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfIOR7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 13:59:47 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55774 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIOR7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 13:59:46 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i9Yo7-0006M9-9P; Sun, 15 Sep 2019 11:59:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i9Yo6-0007iN-AW; Sun, 15 Sep 2019 11:59:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
        <20190915144129.GL30224@paulmck-ThinkPad-P72>
Date:   Sun, 15 Sep 2019 12:59:10 -0500
In-Reply-To: <20190915144129.GL30224@paulmck-ThinkPad-P72> (Paul E. McKenney's
        message of "Sun, 15 Sep 2019 07:41:29 -0700")
Message-ID: <87ef0hcufl.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i9Yo6-0007iN-AW;;;mid=<87ef0hcufl.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+LXTj+wchIcd4h01Tp9jA+22aUPdNOM/A=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 4/4] task: RCUify the assignment of rq->curr
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> So this looks good in and of itself, but I still do not see what prevents
> the unfortunate sequence of events called out in my previous email.
> On the other hand, if ->rcu and ->rcu_users were not allocated on top
> of each other by a union, I would be happy to provide a Reviewed-by.
>
> And I am fundamentally distrusting of a refcount_dec_and_test() that
> is immediately followed by code that clobbers the now-zero value.
> Yes, this does have valid use cases, but it has a lot more invalid
> use cases.  The valid use cases have excluded all increments somehow
> else, so that the refcount_dec_and_test() call's only job is to
> synchronize between concurrent calls to put_task_struct_rcu_user().
> But I am not seeing the "excluded all increments somehow".
>
> So, what am I missing here?

Probably only that the users of the task_struct in this sense are now
quite mature.

The two data structures that allow rcu access to the task_struct are
the pid hash and the runqueue.    The practical problem is that they
have two very different lifetimes.  So we need some kind of logic that
let's us know when they are both done.  A recount does that job very
well.

Placing the recount on the same storage as the unused (at that point)
rcu_head removes the need to be clever in other ways to avoid bloating
the task_struct.

If you really want a reference to the task_struct from rcu context you
can just use get_task_struct.  Because until the grace period completes
it is guaranteed that the task_struct has a positive count.

Right now I can't imagine a use case for wanting to increase rcu_users
anywhere or to decrease rcu_users except where we do.  If there is such
a case most likely it will increase the reference count at
initialization time.

If anyone validly wants to increment rcu_users from an rcu critical
section we can move it out of the union at that time.

Eric
