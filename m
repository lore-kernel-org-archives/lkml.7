Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA49C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040AD2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbfHAOip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:38:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36216 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731397AbfHAOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:38:20 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htCDU-0000lv-Qd; Thu, 01 Aug 2019 16:38:04 +0200
Message-Id: <20190801143250.370326052@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 01 Aug 2019 16:32:50 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org,
        Radim Krcmar <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [patch 0/5] posix-cpu-timers: Move expiry into task work context
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running posix cpu timers in hard interrupt context has a few downsides:

 - For PREEMPT_RT it cannot work as the expiry code needs to take sighand
   lock, which is a 'sleeping spinlock' in RT

 - For fine grained accounting it's just wrong to run this in context of
   the timer interrupt because that way a process specific cpu time is
   accounted to the timer interrupt.

There is no real hard requirement to run the expiry code in hard interrupt
context. The posix CPU timers are an approximation anyway, so having them
expired and evaluated in task work context does not really make them worse.

That unearthed the fact that KVM is missing to handle task work before
entering a VM which is delaying pending task work until the vCPU thread
goes all the way back to user space qemu.

The series implements the necessary handling for x86/KVM and switches the
posix cpu timer expiry into task work for X86. The posix timer modification
is conditional on a selectable config switch as this requires that
task work is handled in KVM.

The available tests pass and no problematic difference has been observed.

Thanks,

	tglx

8<--------------------
 arch/x86/kvm/x86.c             |    8 ++++-
 arch/x86/Kconfig               |    1 
 include/linux/sched.h          |    3 ++
 include/linux/tracehook.h      |   15 ++++++++++
 kernel/task_work.c             |   19 ++++++++++++
 kernel/time/Kconfig            |    5 +++
 kernel/time/posix-cpu-timers.c |   61 ++++++++++++++++++++++++++++++-----------
 7 files changed, 95 insertions(+), 17 deletions(-)



