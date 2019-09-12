Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C07EC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF48B2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 15:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568303263;
	bh=18IJlk8EX7HYcJS+3ZaT1kODSo/n9g0xZTFRgbWkHyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mZq0ldSvyI2R9DkxSW48a0tRciSNOI5DGWqjFzxisHW6dBVU43allq6PTQGtLm8w9
	 w8wGzAXyRu7iHbv22nX+AVVk6zFbNDJhxdbAUU2+/s0pcjRjPUBgPHHM6lJZVwfXUo
	 /Pl6561cmI993/WHJuz+nXiQQNuYx5Nqyg6DseoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbfILPrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 11:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732739AbfILPrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 11:47:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB88420678;
        Thu, 12 Sep 2019 15:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568303261;
        bh=18IJlk8EX7HYcJS+3ZaT1kODSo/n9g0xZTFRgbWkHyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+7n5ZwTi5iO92nzRsZuhddgNgkKr+ZDQnizKKIKuJerB3DugVmu7dmwebacTcuIx
         vlMGX91f2N8xG9wDD0+PlmwqXsCb1Ae2hdvxnxUKwN5+nolt2iCnxgzj0uSlpwUHE/
         6FS6By3bu6EqNzkwuvvUBOwiCQ39OVFYiWzjY4ME=
Date:   Thu, 12 Sep 2019 16:47:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Message-ID: <20190912154734.j3mmjmqf2iltbenm@willie-the-truck>
References: <20190906082305.GU2349@hirez.programming.kicks-ass.net>
 <20190908134909.12389-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wg3AANn8K3OyT7KRNvVC5s0rvWVxXJ=_R+TAd3CGdcF+A@mail.gmail.com>
 <137355288.1941.1568108882233.JavaMail.zimbra@efficios.com>
 <20190912134802.mhxyy25xemy5sycm@willie-the-truck>
 <CAHk-=wgC8YspwtUeaV9ZwHjZDfXaJaT7i4v==Dp-vnVOF5i6qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgC8YspwtUeaV9ZwHjZDfXaJaT7i4v==Dp-vnVOF5i6qg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 03:24:35PM +0100, Linus Torvalds wrote:
> On Thu, Sep 12, 2019 at 2:48 PM Will Deacon <will@kernel.org> wrote:
> >
> > So the man page for sys_membarrier states that the expedited variants "never
> > block", which feels pretty strong. Do any other system calls claim to
> > provide this guarantee without a failure path if blocking is necessary?
> 
> The traditional semantics for "we don't block" is that "we block on
> memory allocations and locking and user accesses etc, but  we don't
> wait for our own IO".
> 
> So there may be new IO started (and waited on) as part of allocating
> new memory etc, or in just paging in user memory, but the IO that the
> operation _itself_ explicitly starts is not waited on.

Thanks, that makes sense, and I'd be inclined to suggest an update to the
sys_membarrier manpage to make this more clear since the "never blocks"
phrasing doesn't seem to be used like this for other system calls.

> No system call should ever be considered "atomic" in any sense. If
> you're doing RT, you should maybe expect "getpid()" to not ever block,
> but that's just about the exclusive list of truly nonblocking system
> calls, and even that can be preempted.

In which case, why can't we just use GFP_KERNEL for the cpumask allocation
instead of GFP_NOWAIT and then remove the failure path altogether? Mathieu?

Will
