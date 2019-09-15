Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7A3C4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 18:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7C1214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 18:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568573311;
	bh=Q65ysGE7tex/SoKRefwCT7cU0TVvw0VivGUeZ/3Xs90=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dAFJJKJJyVgzygc9u5r/xODGoleZdrT3Q/x23EnDA8Mr0EpzExAL1DnxBEKFuAPUq
	 Kikhj64D3qU+jXi69m4su9qDMupLjKlHzr45FHbV1opYpnOi3s0FP1QGrl2cYmoAP9
	 amqrd9xzkqlap1DdAryvjSVkKzky3KM5nT/zFVJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfIOSsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 14:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfIOSs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 14:48:29 -0400
Received: from paulmck-ThinkPad-P72 (96-84-246-146-static.hfc.comcastbusiness.net [96.84.246.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118B920830;
        Sun, 15 Sep 2019 18:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568573309;
        bh=Q65ysGE7tex/SoKRefwCT7cU0TVvw0VivGUeZ/3Xs90=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FqB02FrRbUd1U9iSWMYgnTrWWXQGDMKSq9Yh/KNTnOQZStlmtvJoWC0W8yySyihwz
         GCwSRlH1jciQkaq+ny7qquv/+cLn7/7IFLPCK+Gpk/M77w4Vw91lDtnv164zIzJaaa
         3oZQYBBKx2tK3pGAoWpbRlZQ4cM1ahQV9blwWGRg=
Date:   Sun, 15 Sep 2019 11:48:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
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
Subject: Re: [PATCH v2 4/4] task: RCUify the assignment of rq->curr
Message-ID: <20190915184825.GQ30224@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
 <87ftkzdpjd.fsf_-_@x220.int.ebiederm.org>
 <20190915144129.GL30224@paulmck-ThinkPad-P72>
 <87ef0hcufl.fsf@x220.int.ebiederm.org>
 <87v9tta03l.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9tta03l.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 01:25:02PM -0500, Eric W. Biederman wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> > "Paul E. McKenney" <paulmck@kernel.org> writes:
> >
> >> So this looks good in and of itself, but I still do not see what prevents
> >> the unfortunate sequence of events called out in my previous email.
> >> On the other hand, if ->rcu and ->rcu_users were not allocated on top
> >> of each other by a union, I would be happy to provide a Reviewed-by.
> >>
> >> And I am fundamentally distrusting of a refcount_dec_and_test() that
> >> is immediately followed by code that clobbers the now-zero value.
> >> Yes, this does have valid use cases, but it has a lot more invalid
> >> use cases.  The valid use cases have excluded all increments somehow
> >> else, so that the refcount_dec_and_test() call's only job is to
> >> synchronize between concurrent calls to put_task_struct_rcu_user().
> >> But I am not seeing the "excluded all increments somehow".
> >>
> >> So, what am I missing here?
> >
> > Probably only that the users of the task_struct in this sense are now
> > quite mature.
> >
> > The two data structures that allow rcu access to the task_struct are
> > the pid hash and the runqueue.    The practical problem is that they
> > have two very different lifetimes.  So we need some kind of logic that
> > let's us know when they are both done.  A recount does that job very
> > well.
> >
> > Placing the recount on the same storage as the unused (at that point)
> > rcu_head removes the need to be clever in other ways to avoid bloating
> > the task_struct.
> >
> > If you really want a reference to the task_struct from rcu context you
> > can just use get_task_struct.  Because until the grace period completes
> > it is guaranteed that the task_struct has a positive count.
> >
> > Right now I can't imagine a use case for wanting to increase rcu_users
> > anywhere or to decrease rcu_users except where we do.  If there is such
> > a case most likely it will increase the reference count at
> > initialization time.
> >
> > If anyone validly wants to increment rcu_users from an rcu critical
> > section we can move it out of the union at that time.
> 
> Paul were you worrying about incrementing rcu_users because Frederic
> Weisbecker brought the concept up earlier in the review?
> 
> It was his confusion that the point of rcu_users was so that it could
> be incremented from an rcu critical section.  That definitely is not
> the point of rcu_users.
> 
> If you were wondering about someone messing with rcu_users from an rcu
> critical region independently that does suggest the code could use
> a "comment saying don't do that!"  Multiple people getting confused
> about the purpose of a reference count independently does suggest there
> is a human factor problem in there somewhere.

I would welcome a "this is never incremented" comment or some such.

							Thanx, Paul
