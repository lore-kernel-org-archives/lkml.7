Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71908C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464C62187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbfKFU4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:56:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45261 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732001AbfKFU4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:56:47 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSSM5-00032Z-UJ; Wed, 06 Nov 2019 21:56:42 +0100
Message-Id: <20191106193459.581614484@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 20:34:59 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch 0/9] x86/iopl: Prevent user space from using CLI/STI with
 iopl(3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the result of the previous discussion about assumptions that user
space always runs with interrupts enabled:

 https://lore.kernel.org/r/20191023123118.296135499@linutronix.de

The infinite wisdom of hardware designers coupled the I/O permission level
of accessing all 65536 I/O ports with the ability to use CLI/STI.

iopl(3), if granted gives this ability to user space. That's broken in
several ways:

  1) User space can lock up the machine when an interrupt disabled region
     runs into an infinite loop.

  2) Disabling interrupts in user space has no semantics, at least no well
     defined, consistent and understandable semantics.

     syscalls and exceptions ignore that state and can block, preempt etc.

#1 could be arguably achieved by fiddling with the wrong I/O ports as well.

#2 is the real issue:

It causes a problem in the user/kernel interface and in exception
handlers as it is a common assumption that user space executes with
interrupts enabled. But with IOPL(3) this assumption is not correct.
Neither for syscalls nor for exceptions.

There is code in the low level entry and exception handlers which
makes this assumption.  Even experienced kernel developers trip over
that as shown in the discussion referenced above.

Ideally we should delete iopl(), but there are existing users including
DPDK. None of those I checked rely on the CLI/STI ability. They all use it
for conveniance to access I/O ports.

The only thing I found using CLI/STI was some really ancient X
implementation. So dragons might be lurking, but that X stuff really won't
work on a current kernel anymore :)

After quite some discussion I came up with a solution to emulate IOPL via
the I/O bitmap mechanism without copying 8k of zeroed bitmap on every
context switch which is the main concern of people who prefer iopl() over
ioperm().

The trick is to use the io-bitmap offset in the TSS to point the CPU to a
bitmap with all bits cleared. This is slightly slower than just relying on
the IOPL magic in (E)FLAGS, but it's almost not noticeable.

The same trick can be used when switching away from a task which uses an
I/O bitmap to a task which does not. Instead of cleaning up the bitmap
storage, just point the I/O bitmap offset to a location which is outside of
the TSS limit. That puts the copy overhead solely on tasks which have
actually an I/O bitmap installed. The copy mechanism is quite stupid as
well as it starts always from 0 even if the first cleared bit is right at
the end of the bitmap.

The following series addresses this.

The first few patches are preparatory and consolidate needlessly duplicated
code to avoid duplicating all the changes for the IOPL emulation.

At the end it removes the legacy support completely which cleans up quite
some code all over the place including paravirt.

The improvement for switching away from an I/O bitmap using task to a sane
task w/o I/O bitmap is quite measurable in a microbench mark.

Also avoiding to copy several kilobytes just to update a tiny region has a
measurable impact.

Removing CLI/STI from iopl() allows us to consolidate and simplify the
entry and exception code instead of wasting time and racking nerves by
analysing the world and some more whether there is an implicit
assumption of user space having interrupts always enabled.

The series is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/iopl

Thanks,

	tglx

8<---------------
 arch/x86/Kconfig                      |   26 ++++
 arch/x86/include/asm/paravirt.h       |    4 
 arch/x86/include/asm/paravirt_types.h |    2 
 arch/x86/include/asm/processor.h      |   92 ++++++++-------
 arch/x86/include/asm/ptrace.h         |    6 +
 arch/x86/include/asm/switch_to.h      |   10 +
 arch/x86/include/asm/xen/hypervisor.h |    2 
 arch/x86/kernel/cpu/common.c          |  176 +++++++++++------------------
 arch/x86/kernel/doublefault.c         |    2 
 arch/x86/kernel/ioport.c              |  203 ++++++++++++++++++++++++----------
 arch/x86/kernel/paravirt.c            |    2 
 arch/x86/kernel/process.c             |  177 ++++++++++++++++++++++++-----
 arch/x86/kernel/process_32.c          |   77 ------------
 arch/x86/kernel/process_64.c          |   86 --------------
 arch/x86/kernel/ptrace.c              |    2 
 arch/x86/xen/enlighten_pv.c           |   10 -
 tools/testing/selftests/x86/iopl.c    |  104 +++++++++++++++--
 17 files changed, 556 insertions(+), 425 deletions(-)

