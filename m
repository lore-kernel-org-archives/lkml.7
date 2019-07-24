Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E030BC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D3D229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfGXKp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:45:29 -0400
Received: from foss.arm.com ([217.140.110.172]:38730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfGXKp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:45:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63678337;
        Wed, 24 Jul 2019 03:45:28 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCB8D3F71F;
        Wed, 24 Jul 2019 03:45:26 -0700 (PDT)
Date:   Wed, 24 Jul 2019 11:45:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH 3/3] arm64: debug: Remove rcu_read_lock from debug
 exception
Message-ID: <20190724104518.GA2624@lakrids.cambridge.arm.com>
References: <156342860634.8565.14804606041960884732.stgit@devnote2>
 <156342863822.8565.7624877983728871995.stgit@devnote2>
 <20190718062215.GG14271@linux.ibm.com>
 <20190718092022.GA3625@blommer>
 <20190718233133.146065f668da6297e57e52ef@kernel.org>
 <20190719095958.GA19605@lakrids.cambridge.arm.com>
 <20190720165458.7333b65244312843c2ca6857@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190720165458.7333b65244312843c2ca6857@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 04:54:58PM +0900, Masami Hiramatsu wrote:
> Hi Mark,
> 
> On Fri, 19 Jul 2019 10:59:59 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Thu, Jul 18, 2019 at 11:31:33PM +0900, Masami Hiramatsu wrote:
> > > On Thu, 18 Jul 2019 10:20:23 +0100
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > 
> > > > On Wed, Jul 17, 2019 at 11:22:15PM -0700, Paul E. McKenney wrote:
> > > > > On Thu, Jul 18, 2019 at 02:43:58PM +0900, Masami Hiramatsu wrote:
> > > > > > Remove rcu_read_lock()/rcu_read_unlock() from debug exception
> > > > > > handlers since the software breakpoint can be hit on idle task.
> > > > 
> > > > Why precisely do we need to elide these? Are we seeing warnings today?
> > > 
> > > Yes, unfortunately, or fortunately. Naresh reported that warns when
> > > ftracetest ran. I confirmed that happens if I probe on default_idle_call too.
> > > 
> > > /sys/kernel/debug/tracing # echo p default_idle_call >> kprobe_events 
> > > /sys/kernel/debug/tracing # echo 1 > events/kprobes/enable 
> > > /sys/kernel/debug/tracing # [  135.122237] 
> > > [  135.125035] =============================
> > > [  135.125310] WARNING: suspicious RCU usage
> > > [  135.125581] 5.2.0-08445-g9187c508bdc7 #20 Not tainted
> > > [  135.125904] -----------------------------
> > > [  135.126205] include/linux/rcupdate.h:594 rcu_read_lock() used illegally while idle!
> > > [  135.126839] 
> > > [  135.126839] other info that might help us debug this:
> > > [  135.126839] 
> > > [  135.127410] 
> > > [  135.127410] RCU used illegally from idle CPU!
> > > [  135.127410] rcu_scheduler_active = 2, debug_locks = 1
> > > [  135.128114] RCU used illegally from extended quiescent state!
> > > [  135.128555] 1 lock held by swapper/0/0:
> > > [  135.128944]  #0: (____ptrval____) (rcu_read_lock){....}, at: call_break_hook+0x0/0x178
> > > [  135.130499] 
> > > [  135.130499] stack backtrace:
> > > [  135.131192] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-08445-g9187c508bdc7 #20
> > > [  135.131841] Hardware name: linux,dummy-virt (DT)
> > > [  135.132224] Call trace:
> > > [  135.132491]  dump_backtrace+0x0/0x140
> > > [  135.132806]  show_stack+0x24/0x30
> > > [  135.133133]  dump_stack+0xc4/0x10c
> > > [  135.133726]  lockdep_rcu_suspicious+0xf8/0x108
> > > [  135.134171]  call_break_hook+0x170/0x178
> > > [  135.134486]  brk_handler+0x28/0x68
> > > [  135.134792]  do_debug_exception+0x90/0x150
> > > [  135.135051]  el1_dbg+0x18/0x8c
> > > [  135.135260]  default_idle_call+0x0/0x44
> > > [  135.135516]  cpu_startup_entry+0x2c/0x30
> > > [  135.135815]  rest_init+0x1b0/0x280
> > > [  135.136044]  arch_call_rest_init+0x14/0x1c
> > > [  135.136305]  start_kernel+0x4d4/0x500
> > > [  135.136597] 
> > > 
> > > > > The exception entry and exit use irq_enter() and irq_exit(), in this
> > > > > case, correct?  Otherwise RCU will be ignoring this CPU.
> > > > 
> > > > This is missing today, which sounds like the underlying bug.
> > > 
> > > Agreed. I'm not so familier with how debug exception is handled on arm64,
> > > would it be a kind of NMI or IRQ?
> > 
> > They're more like faults, in that they're synchronous exceptions.
> > 
> > Given that, I think using irq_enter() / irq_exit() would be surprising
> > here, but perhaps they're misnamed.
> > 
> > What do other architectures do here? Having a kprobe on the critical
> > path to idle doesn't sound specific to arm64, but perhaps it is (and we
> > should rule it out).
> 
> On x86, it uses rcu_nmi_enter/exit() for kernel mode. For user mode,
> we don't need to care since it must not be an idle task.

Ok. IIUC, doing the same for arm64 would make sense.

Thanks,
Mark.
