Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAF8C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 07:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BD82084C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 07:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563609434;
	bh=c/qcAjooUS+XTsmTRW+jDhrjLGqeN6OgrxYeSB1F2M8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KRSelpjFaJdpfOk+EWQi15BH2wVlVOy6qHnRrPHT+UM4FAI9532sucB35CuzMioyp
	 unETTXEzm62WPnyj/sSmRtAxZUbqWJwIeOMadvzcv1WvWIYE3meE9DrSVndjayb//m
	 Fjx6/zQb7z6I4dq/EQTLuKo2ETcwT3Rj0fOl9woc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfGTHzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 03:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfGTHzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 03:55:05 -0400
Received: from devnote2 (72.65.214.202.bf.2iij.net [202.214.65.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FF552084C;
        Sat, 20 Jul 2019 07:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563609304;
        bh=c/qcAjooUS+XTsmTRW+jDhrjLGqeN6OgrxYeSB1F2M8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q53+vJzOimnDeGgWyVZmYWxjmNNd7QWjAXgV8FUwBw9FZzRKqtNbdE1oxIDPBib5J
         NW0eJH2epYH4GvO6jdUpcjmSOtJpQrm3oX/qGhKMnk6IB40vJdAZzdTgNJaRJqFrFK
         i1lY0g8c0blNVYVjwEwQSZWyN1rA0dijHyn+HXDk=
Date:   Sat, 20 Jul 2019 16:54:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-Id: <20190720165458.7333b65244312843c2ca6857@kernel.org>
In-Reply-To: <20190719095958.GA19605@lakrids.cambridge.arm.com>
References: <156342860634.8565.14804606041960884732.stgit@devnote2>
        <156342863822.8565.7624877983728871995.stgit@devnote2>
        <20190718062215.GG14271@linux.ibm.com>
        <20190718092022.GA3625@blommer>
        <20190718233133.146065f668da6297e57e52ef@kernel.org>
        <20190719095958.GA19605@lakrids.cambridge.arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, 19 Jul 2019 10:59:59 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Thu, Jul 18, 2019 at 11:31:33PM +0900, Masami Hiramatsu wrote:
> > On Thu, 18 Jul 2019 10:20:23 +0100
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > On Wed, Jul 17, 2019 at 11:22:15PM -0700, Paul E. McKenney wrote:
> > > > On Thu, Jul 18, 2019 at 02:43:58PM +0900, Masami Hiramatsu wrote:
> > > > > Remove rcu_read_lock()/rcu_read_unlock() from debug exception
> > > > > handlers since the software breakpoint can be hit on idle task.
> > > 
> > > Why precisely do we need to elide these? Are we seeing warnings today?
> > 
> > Yes, unfortunately, or fortunately. Naresh reported that warns when
> > ftracetest ran. I confirmed that happens if I probe on default_idle_call too.
> > 
> > /sys/kernel/debug/tracing # echo p default_idle_call >> kprobe_events 
> > /sys/kernel/debug/tracing # echo 1 > events/kprobes/enable 
> > /sys/kernel/debug/tracing # [  135.122237] 
> > [  135.125035] =============================
> > [  135.125310] WARNING: suspicious RCU usage
> > [  135.125581] 5.2.0-08445-g9187c508bdc7 #20 Not tainted
> > [  135.125904] -----------------------------
> > [  135.126205] include/linux/rcupdate.h:594 rcu_read_lock() used illegally while idle!
> > [  135.126839] 
> > [  135.126839] other info that might help us debug this:
> > [  135.126839] 
> > [  135.127410] 
> > [  135.127410] RCU used illegally from idle CPU!
> > [  135.127410] rcu_scheduler_active = 2, debug_locks = 1
> > [  135.128114] RCU used illegally from extended quiescent state!
> > [  135.128555] 1 lock held by swapper/0/0:
> > [  135.128944]  #0: (____ptrval____) (rcu_read_lock){....}, at: call_break_hook+0x0/0x178
> > [  135.130499] 
> > [  135.130499] stack backtrace:
> > [  135.131192] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-08445-g9187c508bdc7 #20
> > [  135.131841] Hardware name: linux,dummy-virt (DT)
> > [  135.132224] Call trace:
> > [  135.132491]  dump_backtrace+0x0/0x140
> > [  135.132806]  show_stack+0x24/0x30
> > [  135.133133]  dump_stack+0xc4/0x10c
> > [  135.133726]  lockdep_rcu_suspicious+0xf8/0x108
> > [  135.134171]  call_break_hook+0x170/0x178
> > [  135.134486]  brk_handler+0x28/0x68
> > [  135.134792]  do_debug_exception+0x90/0x150
> > [  135.135051]  el1_dbg+0x18/0x8c
> > [  135.135260]  default_idle_call+0x0/0x44
> > [  135.135516]  cpu_startup_entry+0x2c/0x30
> > [  135.135815]  rest_init+0x1b0/0x280
> > [  135.136044]  arch_call_rest_init+0x14/0x1c
> > [  135.136305]  start_kernel+0x4d4/0x500
> > [  135.136597] 
> > 
> > > > The exception entry and exit use irq_enter() and irq_exit(), in this
> > > > case, correct?  Otherwise RCU will be ignoring this CPU.
> > > 
> > > This is missing today, which sounds like the underlying bug.
> > 
> > Agreed. I'm not so familier with how debug exception is handled on arm64,
> > would it be a kind of NMI or IRQ?
> 
> They're more like faults, in that they're synchronous exceptions.
> 
> Given that, I think using irq_enter() / irq_exit() would be surprising
> here, but perhaps they're misnamed.
> 
> What do other architectures do here? Having a kprobe on the critical
> path to idle doesn't sound specific to arm64, but perhaps it is (and we
> should rule it out).

On x86, it uses rcu_nmi_enter/exit() for kernel mode. For user mode,
we don't need to care since it must not be an idle task.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
