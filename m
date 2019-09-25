Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14608C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3432054F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nF3zC9zO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393512AbfIYHhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:37:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392973AbfIYHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=de5nn/eSh/M6SfFOgTwUQaAn196rLscasGKtD5AUuUs=; b=nF3zC9zOKMeYOwaM5E9MTgulD
        fRQB/uFnc0EG2pJZT4t4cBrswF5dlPePWEXSJGj4I0AkeuCU1jlCs0BklqrxF5dsJqx/825QDldMT
        3HrJtOxS3kUQ6xuCegEDWM1ZszdRP4yGpmAZZatq7p0KZs8LfT4FWOY1vxbGPczM03BSTbGk8jXuj
        DxWSHmMXinYQDTKoPK8ZNPgfX4i5MeGpntXTy8u4v27rX2ETeKQKqTxN54jEwzPk8SUrnaMyVGzeY
        /NTC3qi7RSPVjpxirIQOxBJdwD3+0PgOzpeic1Rm9OUkPq/45Z/TFbnLe/Myejll2yLbrCQs2kTb3
        zNrZ8KVgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iD1qy-0003zh-FA; Wed, 25 Sep 2019 07:36:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8BCDD3012CF;
        Wed, 25 Sep 2019 09:35:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7027A200D2661; Wed, 25 Sep 2019 09:36:43 +0200 (CEST)
Date:   Wed, 25 Sep 2019 09:36:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
Message-ID: <20190925073643.GA4536@hirez.programming.kicks-ass.net>
References: <20190903074718.GT2386@hirez.programming.kicks-ass.net>
 <87k1apqqgk.fsf@x220.int.ebiederm.org>
 <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
 <874l1tp7st.fsf@x220.int.ebiederm.org>
 <CAHk-=wjvyRJEdativFqqGGxzSgWnc-m7b+B04iQBMcZV4uM=hA@mail.gmail.com>
 <20190903200603.GW2349@hirez.programming.kicks-ass.net>
 <20190903213218.GG4125@linux.ibm.com>
 <87r24umryu.fsf@x220.int.ebiederm.org>
 <20190906070736.GR2349@hirez.programming.kicks-ass.net>
 <87woehek20.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woehek20.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 07:22:15AM -0500, Eric W. Biederman wrote:

> Let me see if I can explain my confusion in terms of task_numa_compare.
> 
> The function task_numa_comare now does:
> 
> 	rcu_read_lock();
> 	cur = rcu_dereference(dst_rq->curr);
> 
> Then it proceeds to examine a few fields of cur.
> 
> 	cur->flags;
>         cur->cpus_ptr;
>         cur->numa_group;
>         cur->numa_faults[];
>         cur->total_numa_faults;
>         cur->se.cfs_rq;
> 
> My concern here is the ordering between setting rq->curr and and setting
> those other fields.  If we read values of those fields that were not
> current when we set cur than I think task_numa_compare would give an
> incorrect answer.

That code is explicitly without serialization. One memory barrier isn't
going to make any difference what so ever.

Specifically, those numbers will change _after_ we make it current, not
before.

> From what I can see pick_next_task_fair does not mess with any of
> the fields that task_numa_compare uses.  So the existing memory barrier
> should be more than sufficient for that case.

There should not be, but even if there is, load-balancing in general
(very much including the NUMA balancing) is completely unserialized and
prone to reading stale data at all times.

This is on purpose; it minimizes the interference of load-balancing, and
if we make a 'wrong' choice, the next pass can fix it up.

> So I think I just need to write up a patch 4/3 that replaces the my
> "rcu_assign_pointer(rq->curr, next)" with "RCU_INIT_POINTER(rq->curr,
> next)".  And includes a great big comment to that effect.
> 
> 
> 
> Now maybe I am wrong.  Maybe we can afford to see data that was changed
> before the task became rq->curr in task_numa_compare.  But I don't think
> so.  I really think it is that full memory barrier just a bit earlier
> in __schedule that is keeping us safe.
> 
> Am I wrong?

Not in so far that we now both seem to agree on using
RCU_INIT_POINTER(); but we're still disagreeing on why.

My argument is that since we can already obtain any task_struct pointer
through find_task_by_vpid() and friends, any access to its individual
members must already have serialzation rules (or explicitly none, as for
load-balancing).

I'm viewing this as just another variant of find_task_by_vpid(), except
we index by CPU instead of PID. There can be changes to task_struct
between to invocations of find_task_by_vpid(), any user will have to
somehow deal with that. This is no different.

Take for instance p->cpus_ptr, it has very specific serialzation rules
(which that NUMA balancer thing blatantly ignores), as do a lot of other
task_struct fields.

The memory barrier in question isn't going to help with any of that.

Specifically, if we care about the consistency of the numbers changed by
pick_next_task(), we must acquire rq->lock (of course, once we do that,
we can immediately use rq->curr without further RCU use).
