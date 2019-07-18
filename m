Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF6DC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06ECE217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563460316;
	bh=n0QuHuPmfGNDd/UjBj7iq8FnefrdHa1lz8nf16gnbDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VbNIPeqLOTk7TMs/tynvYdzAgQzIguIlAVt5n15wPuhPMYkkmNGu397Q54cqDePrL
	 Ayvtz2CMxhgTUinZspdVTNy1M6v9oSHawJtPMYdVTsjk5ZPdzl5zOmPdURz1xNw0BP
	 vP8mG7wrj5HHQ57+p4ovJcYKP7eZ2XPZqfKzi4aQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390887AbfGRObz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390758AbfGRObh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:31:37 -0400
Received: from devnote2 (ae027047.dynamic.ppp.asahi-net.or.jp [14.3.27.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2D48217F4;
        Thu, 18 Jul 2019 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563460296;
        bh=n0QuHuPmfGNDd/UjBj7iq8FnefrdHa1lz8nf16gnbDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SAx8gDCjJJ1wdu+rR633sjpFn5TnWHaw0ry7jDsMkQ0OJxT3DG0n4HrAafwjAmlSv
         c874iRbW+O2MqL45QNl0N8V73NSlzxPS3wZtU+mLqoFvncxRhIigcgHEv16ZuA03Ug
         OlOMEGUQ5iEUFMYfXhfniBGHtbYlo1bWZjLa1SCk=
Date:   Thu, 18 Jul 2019 23:31:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
Subject: Re: [PATCH 3/3] arm64: debug: Remove rcu_read_lock from debug
 exception
Message-Id: <20190718233133.146065f668da6297e57e52ef@kernel.org>
In-Reply-To: <20190718092022.GA3625@blommer>
References: <156342860634.8565.14804606041960884732.stgit@devnote2>
        <156342863822.8565.7624877983728871995.stgit@devnote2>
        <20190718062215.GG14271@linux.ibm.com>
        <20190718092022.GA3625@blommer>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2019 10:20:23 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Jul 17, 2019 at 11:22:15PM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 18, 2019 at 02:43:58PM +0900, Masami Hiramatsu wrote:
> > > Remove rcu_read_lock()/rcu_read_unlock() from debug exception
> > > handlers since the software breakpoint can be hit on idle task.
> 
> Why precisely do we need to elide these? Are we seeing warnings today?

Yes, unfortunately, or fortunately. Naresh reported that warns when
ftracetest ran. I confirmed that happens if I probe on default_idle_call too.

/sys/kernel/debug/tracing # echo p default_idle_call >> kprobe_events 
/sys/kernel/debug/tracing # echo 1 > events/kprobes/enable 
/sys/kernel/debug/tracing # [  135.122237] 
[  135.125035] =============================
[  135.125310] WARNING: suspicious RCU usage
[  135.125581] 5.2.0-08445-g9187c508bdc7 #20 Not tainted
[  135.125904] -----------------------------
[  135.126205] include/linux/rcupdate.h:594 rcu_read_lock() used illegally while idle!
[  135.126839] 
[  135.126839] other info that might help us debug this:
[  135.126839] 
[  135.127410] 
[  135.127410] RCU used illegally from idle CPU!
[  135.127410] rcu_scheduler_active = 2, debug_locks = 1
[  135.128114] RCU used illegally from extended quiescent state!
[  135.128555] 1 lock held by swapper/0/0:
[  135.128944]  #0: (____ptrval____) (rcu_read_lock){....}, at: call_break_hook+0x0/0x178
[  135.130499] 
[  135.130499] stack backtrace:
[  135.131192] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-08445-g9187c508bdc7 #20
[  135.131841] Hardware name: linux,dummy-virt (DT)
[  135.132224] Call trace:
[  135.132491]  dump_backtrace+0x0/0x140
[  135.132806]  show_stack+0x24/0x30
[  135.133133]  dump_stack+0xc4/0x10c
[  135.133726]  lockdep_rcu_suspicious+0xf8/0x108
[  135.134171]  call_break_hook+0x170/0x178
[  135.134486]  brk_handler+0x28/0x68
[  135.134792]  do_debug_exception+0x90/0x150
[  135.135051]  el1_dbg+0x18/0x8c
[  135.135260]  default_idle_call+0x0/0x44
[  135.135516]  cpu_startup_entry+0x2c/0x30
[  135.135815]  rest_init+0x1b0/0x280
[  135.136044]  arch_call_rest_init+0x14/0x1c
[  135.136305]  start_kernel+0x4d4/0x500
[  135.136597] 


> 
> > The exception entry and exit use irq_enter() and irq_exit(), in this
> > case, correct?  Otherwise RCU will be ignoring this CPU.
> 
> This is missing today, which sounds like the underlying bug.

Agreed. I'm not so familier with how debug exception is handled on arm64,
would it be a kind of NMI or IRQ?

Anyway, it seems that normal irqs are also not calling irq_enter/exit
except for arch/arm64/kernel/smp.c. We need to fix that too for avoiding
unexpected RCU issues.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
