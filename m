Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3A0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDAE21928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568910380;
	bh=L+a2RPg7TvMt+BcXyUJ5gIfCb7Ud4JWHpFNge+LYu8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rd02KJtvpNsCOfB7Fh5q9JpSp3AVbz5ONzM0MZNbqMB3gUQGok28xqLU69tuDKVLA
	 03+bxA+JkJZX3Xy7JIHWAvjpUSkf1FwhgcPNrCw29suwpcfDip+GQXS2W4bvCHFvEj
	 jhYVg4PIv22rMfZhdpdbAjqa2BNZS5bqiQARSMPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404315AbfISQ0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404291AbfISQ0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:26:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C5A20644;
        Thu, 19 Sep 2019 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568910377;
        bh=L+a2RPg7TvMt+BcXyUJ5gIfCb7Ud4JWHpFNge+LYu8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZGQO3wKwkYqExwdREYGgvRhqE/puQ+8Hd9m3GHgSeLOBdrXEjpVJ8prsZ+q6NL0X
         gk5XT36Yyhyg0jkCuXsWTM5AcNXMHzYcx1rud7bqwAdIytemUMA7MA2lDjvKPWq+Ve
         FLOYvZKqbqmI24eexR7dTv2xeOIkxmJlakxjNnE4=
Date:   Thu, 19 Sep 2019 17:26:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 4/4] Fix: sched/membarrier: p->mm->membarrier_state
 racy load (v2)
Message-ID: <20190919162611.wizldpybn3qd5cik@willie-the-truck>
References: <20190906082305.GU2349@hirez.programming.kicks-ass.net>
 <20190908134909.12389-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wg3AANn8K3OyT7KRNvVC5s0rvWVxXJ=_R+TAd3CGdcF+A@mail.gmail.com>
 <137355288.1941.1568108882233.JavaMail.zimbra@efficios.com>
 <20190912134802.mhxyy25xemy5sycm@willie-the-truck>
 <CAHk-=wgC8YspwtUeaV9ZwHjZDfXaJaT7i4v==Dp-vnVOF5i6qg@mail.gmail.com>
 <20190912154734.j3mmjmqf2iltbenm@willie-the-truck>
 <1283729551.2396.1568384548023.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1283729551.2396.1568384548023.JavaMail.zimbra@efficios.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Sorry for the delay in responding.

On Fri, Sep 13, 2019 at 10:22:28AM -0400, Mathieu Desnoyers wrote:
> ----- On Sep 12, 2019, at 11:47 AM, Will Deacon will@kernel.org wrote:
> 
> > On Thu, Sep 12, 2019 at 03:24:35PM +0100, Linus Torvalds wrote:
> >> On Thu, Sep 12, 2019 at 2:48 PM Will Deacon <will@kernel.org> wrote:
> >> >
> >> > So the man page for sys_membarrier states that the expedited variants "never
> >> > block", which feels pretty strong. Do any other system calls claim to
> >> > provide this guarantee without a failure path if blocking is necessary?
> >> 
> >> The traditional semantics for "we don't block" is that "we block on
> >> memory allocations and locking and user accesses etc, but  we don't
> >> wait for our own IO".
> >> 
> >> So there may be new IO started (and waited on) as part of allocating
> >> new memory etc, or in just paging in user memory, but the IO that the
> >> operation _itself_ explicitly starts is not waited on.
> > 
> > Thanks, that makes sense, and I'd be inclined to suggest an update to the
> > sys_membarrier manpage to make this more clear since the "never blocks"
> > phrasing doesn't seem to be used like this for other system calls.
> 
> The current wording from membarrier(2) is:
> 
>               The  "expedited" commands complete faster than the non-expedited
>               ones; they never block, but have the downside of  causing  extra
>               overhead.
> 
> We could simply remove the "; they never block" part then ?

I think so, yes. That or, "; they do not voluntarily block" or something
like that. Maybe look at other man pages for inspiration ;)

> >> No system call should ever be considered "atomic" in any sense. If
> >> you're doing RT, you should maybe expect "getpid()" to not ever block,
> >> but that's just about the exclusive list of truly nonblocking system
> >> calls, and even that can be preempted.
> > 
> > In which case, why can't we just use GFP_KERNEL for the cpumask allocation
> > instead of GFP_NOWAIT and then remove the failure path altogether? Mathieu?
> 
> Looking at:
> 
> #define GFP_KERNEL      (__GFP_RECLAIM | __GFP_IO | __GFP_FS)
> 
> I notice that it does not include __GFP_NOFAIL. What prevents GFP_KERNEL from
> failing, and where is this guarantee documented ?

There was an lwn article a little while ago about this:

https://lwn.net/Articles/723317/

I'm not sure what (if anything) has changed in this regard since then,
however.

> Regarding __GFP_NOFAIL, its use seems to be discouraged in linux/gfp.h:
> 
>  * %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
>  * cannot handle allocation failures. The allocation could block
>  * indefinitely but will never return with failure. Testing for
>  * failure is pointless.
>  * New users should be evaluated carefully (and the flag should be
>  * used only when there is no reasonable failure policy) but it is
>  * definitely preferable to use the flag rather than opencode endless
>  * loop around allocator.
>  * Using this flag for costly allocations is _highly_ discouraged.
> 
> So I am reluctant to use it.
> 
> But if we can agree on the right combination of flags that guarantees there
> is no failure, I would be perfectly fine with using them to remove the fallback
> code.

I reckon you'll be fine using GFP_KERNEL and returning -ENOMEM on allocation
failure. This shouldn't happen in practice and it removes the fallback
path.

Will
