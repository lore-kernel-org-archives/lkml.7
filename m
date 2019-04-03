Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5D8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC922147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QI5qSAZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfDCKlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:41:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfDCKlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HOqA3G6fAyIiMpTLMLBhRjQF/GEAu7CsNovS/oe9CVU=; b=QI5qSAZJxnd2V4dLaP+BEQzM9
        Hab3Xr5RDHoZ3JnZUX1NlcgVJD/xDHjUkxPzV/9MPHZha6kMIJZ22t8GulN8MrvlpZG3oSSc7t9DT
        TMLmwEsttFxI3Lo2o9BHsCzHlZMViYK3alGqjNt+d4wHDowDdEX/Evs0Gf8wqNoPwaoOp+I16q5K+
        skrYdXwWhbr+nlNmGOuMBQnqd8XgfIBdSfw+KZT0OE0o+ZPs0/rIuez9ql2EajzQK4v+HGeis7qBx
        TA7iKmVs0eUd00JrXCD2v63yKIXX2jVhoyggH835HidG0evW5ddWaJIeB08gp3iDYX9HKHx3cBYBN
        s8IL9ljAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBdKL-0006OS-3C; Wed, 03 Apr 2019 10:41:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 263E8202194EC; Wed,  3 Apr 2019 12:41:03 +0200 (CEST)
Date:   Wed, 3 Apr 2019 12:41:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     acme@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: WARN_ON_ONCE() hit at kernel/events/core.c:330
Message-ID: <20190403104103.GE4038@hirez.programming.kicks-ass.net>
References: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:47:00AM +0200, Thomas-Mich Richter wrote:
> I use linux 5.1.0-rc3 on s390 and got this WARN_ON_ONCE message:
> 
> WARNING: CPU: 15 PID: 0 at kernel/events/core.c:330
>                 event_function_local.constprop.79+0xe2/0xe8
> 
> which was introduced with
>    commit cca2094605ef ("perf/core: Fix event_function_local()").
> 
> This is the WARN_ON_ONCE message, which sometimes shows up in the kernel
> log:
>  [ 4598.316519] WARNING: CPU: 15 PID: 0 at kernel/events/core.c:330
>                 event_function_local.constprop.79+0xe2/0xe8
>  [ 4598.316524] Kernel panic - not syncing: panic_on_warn set ...
>  [ 4598.316527] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G           OE
>                 5.1.0-20190402.rc3.git0.5e7a8ca31926.300.fc29.s390x+git #1
>  [ 4598.316529] Hardware name: IBM 2964 NC9 712 (LPAR)
>  [ 4598.316531] Call Trace:
>  [ 4598.316534] ([<0000000000112eb8>] show_stack+0x58/0x70)
>  [ 4598.316538]  [<0000000000a820aa>] dump_stack+0x7a/0xa8
>  [ 4598.316541]  [<0000000000143b52>] panic+0x11a/0x2d0
>  [ 4598.316543]  [<00000000001439b0>] __warn+0xf8/0x118
>  [ 4598.316545]  [<0000000000a811a8>] report_bug+0xd8/0x150
>  [ 4598.316547]  [<00000000001014ac>] do_report_trap+0xc4/0xe0
>  [ 4598.316549]  [<0000000000101680>] illegal_op+0x138/0x150
>  [ 4598.316552]  [<0000000000aa233c>] pgm_check_handler+0x1cc/0x220
>  [ 4598.316554]  [<00000000002a6d02>] event_function_local.constprop.79+
>                                                 0xe2/0xe8
>  [ 4598.316556] ([<00000000002a6c7a>] event_function_local.constprop.79+
>                                                 0x5a/0xe8)
>  [ 4598.316559]  [<00000000002aa400>] perf_pending_event+0x88/0xb0
>  [ 4598.316561]  [<0000000000271a8c>] irq_work_run_list+0x8c/0xb8
>  [ 4598.316563]  [<0000000000271d78>] irq_work_tick+0x48/0x68
>  [ 4598.316566]  [<00000000001d6058>] update_process_times+0x68/0x80
>  [ 4598.316568]  [<00000000001e6c10>] tick_sched_handle.isra.6+0x50/0x60
>  [ 4598.316570]  [<00000000001e6c7e>] tick_sched_timer+0x5e/0xb8
>  [ 4598.316573]  [<00000000001d6b6a>] __hrtimer_run_queues+0x10a/0x2c0
>  [ 4598.316575]  [<00000000001d7a88>] hrtimer_interrupt+0x138/0x2a8
>  [ 4598.316577]  [<000000000010c3e4>] do_IRQ+0xac/0xb0
>  [ 4598.316597]  [<0000000000aa2744>] ext_int_handler+0x128/0x12c
>  [ 4598.316600]  [<00000000001034f6>] enabled_wait+0x46/0xd0
>  [ 4598.316602] ([<000003e000d2fe10>] 0x3e000d2fe10)
>  [ 4598.316604]  [<0000000000103842>] arch_cpu_idle+0x3a/0x50
>  [ 4598.316606]  [<000000000017b808>] do_idle+0x180/0x1b0
>  [ 4598.316608]  [<000000000017ba06>] cpu_startup_entry+0x36/0x40
>  [ 4598.316611]  [<0000000000115d16>] smp_init_secondary+0xd6/0xf0
>  [ 4598.316613]  [<000000000011521e>] smp_start_secondary+0x86/0x98
> 
> Any ideas or hints who to avoid/fix this warning?

Some thoughts here:

  https://lkml.kernel.org/r/20190213101644.GN32534@hirez.programming.kicks-ass.net

tl;dr, I've no frigging clue.

> I ran a user space program which uses
> 
>   1. perf_event_open() system call with type HARDWARE
>      and PERF_COUNT_HW_CPU_CYCLES in sampling mode.
>   2. Assigns signal SIGIO to the file descriptor returned from
>      perf_event_open() using:
>        rc = fcntl(fd, F_SETFL, O_RDWR | O_NONBLOCK | O_ASYNC);
>        rc |= fcntl(fd, F_SETSIG, signo);
>        rc |= fcntl(fd, F_SETOWN, getpid());
> 
>   3. The signal handler increments some variables and issues
>        ioctl(fd, PERF_EVENT_IOC_REFRESH, 1);
>      to restart signal delivery.
> 
> I can send you the test program if needed.

Does it reproduce on x86 without virt on? I don't have a PPC LPAR to
test things on.
