Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61907C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F8D2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zJBWF8s3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfGJK5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 06:57:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46464 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfGJK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 06:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=utBFxVhyB8ZxzFitDOrwnqSfnKM7QaqPSKn/G6kD5cE=; b=zJBWF8s3nJ9WwOHnQb+FPJ960
        iG6NREH6eSAXowzaL6SBU8qaJ4aPLgNFBlMNteQ+ZEUT5sWlmt29rdGiQ7deipxwsnRV+txjI+O82
        TxrGKgf0g+mXgARL3UCS5IzmOpHoC6lR5TtADEENuDktciv3xiTouudFvzIh0FFM7k6T+tjKyQVpP
        BXBKk/xVu6AuJOdI/tzlYb/fkMfew6johgeoPsb/CWhBQCynuTeBGZ3BZVeJM5qADmKAhdQDb5tak
        iUNdFmkSThIGjimFLFOD2tdNBO5OyaCZqWWXh8f42oZvql8eGkjlndf8F2U3UyOd6C0ml4XXFM3KP
        O/Sk7rgqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlAI6-0003m6-LT; Wed, 10 Jul 2019 10:57:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35A3F20977440; Wed, 10 Jul 2019 12:57:36 +0200 (CEST)
Date:   Wed, 10 Jul 2019 12:57:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] scheduler changes for v5.3
Message-ID: <20190710105736.GK3402@hirez.programming.kicks-ass.net>
References: <20190708115349.GA14779@gmail.com>
 <CANcMJZAYhqdO5sGbwW7GszL9NtNgMy0+uMe+bVSQHqyewQcy_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANcMJZAYhqdO5sGbwW7GszL9NtNgMy0+uMe+bVSQHqyewQcy_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 10:48:49PM -0700, John Stultz wrote:
> On Mon, Jul 8, 2019 at 9:33 AM Ingo Molnar <mingo@kernel.org> wrote:
> > Please pull the latest sched-core-for-linus git tree from:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus
> ....
> > Peter Zijlstra (1):
> >       sched/core: Optimize try_to_wake_up() for local wakeups
> 
> Hey Peter, Ingo,
>    Since this change landed in Linus' tree, I've been seeing a lot of
> the following dmesg noise when running AOSP on the HiKey960 board.
> 
> [  173.162712] CPU: 2 PID: 731 Comm: ndroid.systemui Tainted: G S
>           5.2.0-rc5-00110-g6751c43d94d6 #447
> [  173.162721] Hardware name: HiKey960 (DT)
> [  173.171194] caller is try_to_wake_up+0x3e4/0x788
> [  173.179605] Call trace:
> [  173.179617]  dump_backtrace+0x0/0x140
> [  173.179626]  show_stack+0x14/0x20
> [  173.179638]  dump_stack+0x9c/0xc4
> [  173.179649]  debug_smp_processor_id+0x148/0x150
> [  173.179659]  try_to_wake_up+0x3e4/0x788
> [  173.179669]  wake_up_q+0x5c/0x98
> [  173.179681]  futex_wake+0x170/0x1a8
> [  173.179696]  do_futex+0x560/0xf30
> [  173.284541]  __arm64_sys_futex+0xfc/0x148
> [  173.288570]  el0_svc_common.constprop.0+0x64/0x188
> [  173.293371]  el0_svc_handler+0x28/0x78
> [  173.297131]  el0_svc+0x8/0xc
> [  173.300045] CPU: 0 PID: 1258 Comm: Binder:363_5 Tainted: G S
>         5.2.0-rc5-00110-g6751c43d94d6 #447
> [  173.301130] BUG: using smp_processor_id() in preemptible [00000000]
> code: ndroid.systemui/731
> [  173.310074] Hardware name: HiKey960 (DT)
> [  173.310084] Call trace:
> [  173.310112]  dump_backtrace+0x0/0x140
> [  173.310131]  show_stack+0x14/0x20
> [  173.318685] caller is try_to_wake_up+0x3e4/0x788
> [  173.322583]  dump_stack+0x9c/0xc4
> [  173.322595]  debug_smp_processor_id+0x148/0x150
> [  173.322605]  try_to_wake_up+0x3e4/0x788
> [  173.322615]  wake_up_q+0x5c/0x98
> [  173.322628]  futex_wake+0x170/0x1a8
> [  173.322641]  do_futex+0x560/0xf30
> [  173.358367]  __arm64_sys_futex+0xfc/0x148
> [  173.362397]  el0_svc_common.constprop.0+0x64/0x188
> [  173.367199]  el0_svc_handler+0x28/0x78
> [  173.370956]  el0_svc+0x8/0xc
> 

Urgh.. however didn't we find that before :/ stupid stats.

Something like the below ought to fix, but let me see if I can come up
with something saner...

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 108449526f11..0b22e55cebe8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2399,6 +2399,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	unsigned long flags;
 	int cpu, success = 0;
 
+	preempt_disable();
 	if (p == current) {
 		/*
 		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
@@ -2412,7 +2413,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
 		if (!(p->state & state))
-			return false;
+			goto out;
 
 		success = 1;
 		cpu = task_cpu(p);
@@ -2526,6 +2527,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 out:
 	if (success)
 		ttwu_stat(p, cpu, wake_flags);
+	preempt_enable();
 
 	return success;
 }
