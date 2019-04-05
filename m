Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2FBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154F2218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfDEPLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:11:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731442AbfDEPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:08 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQUi-0005qm-6h; Fri, 05 Apr 2019 17:11:04 +0200
Message-Id: <20190405150658.237064784@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:06:58 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 00/29] x86: Add guard pages to exception and interrupt
 stacks
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is an updated version of the initial patch set which just covered the
exception (IST) stacks.

   https://lkml.kernel.org/r/20190331214020.836098943@linutronix.de

Aside of addressing the review comments the main change of V2 is that I
picked up the WIP series from Andy which adds guard pages to the interrupt
stack. With that _all_ stacks used on x86/64 have guard pages.

Changes vs. V1:

  - Correct dumpstack off by ones (Andy)

  - Split the debug stack into separate mappings with guard pages

  - Simplified the macro maze in the dumpstack speedup patch. Hopefully
    Josh likes that version better, otherwise I just sulk and reduce it to
    the quick range check.

  - Prepare for interrupt stack guards (Andy, myself)

  - Prevent crashing in the 32bit cpu bringup code when page allocation
    fails.

  - Add guard pages to the interrupt stack (Andy, todo's addressed by me)
  
  - Intermediate cleanup of the stack debugging code in irq_64 to
    address the backwards top/down variable names which caused me
    to get it wrong more than once.

    Kinda pointless exercise because the code is removed in the last patch
    as now all stacks have guard pages which catch overflow reliably
    instead of having heuristics which just add overhead to the interrupt
    fast path.

  - Addressed review comments

The lot is also available from tip:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/stackguards

	2bf08cce47f7 ("x86/irq/64: Remove stack overflow debug code")

Thanks,

	tglx

8<-------------
 Documentation/x86/kernel-stacks       |   13 +++-
 arch/x86/Kconfig                      |    2 
 arch/x86/entry/entry_64.S             |   16 ++---
 arch/x86/include/asm/cpu_entry_area.h |   73 +++++++++++++++++++++++--
 arch/x86/include/asm/debugreg.h       |    2 
 arch/x86/include/asm/irq.h            |    6 --
 arch/x86/include/asm/page_32_types.h  |    8 +-
 arch/x86/include/asm/page_64_types.h  |   15 ++---
 arch/x86/include/asm/processor.h      |   46 ++++++---------
 arch/x86/include/asm/smp.h            |    2 
 arch/x86/include/asm/stackprotector.h |    6 +-
 arch/x86/include/asm/stacktrace.h     |    2 
 arch/x86/kernel/asm-offsets_64.c      |    4 +
 arch/x86/kernel/cpu/common.c          |   60 +++-----------------
 arch/x86/kernel/dumpstack_32.c        |    8 +-
 arch/x86/kernel/dumpstack_64.c        |   99 +++++++++++++++++++++++-----------
 arch/x86/kernel/head_64.S             |    2 
 arch/x86/kernel/idt.c                 |   19 +++---
 arch/x86/kernel/irq_32.c              |   41 +++++++-------
 arch/x86/kernel/irq_64.c              |   88 +++++++++++++++---------------
 arch/x86/kernel/irqinit.c             |    4 -
 arch/x86/kernel/nmi.c                 |   20 ++++++
 arch/x86/kernel/setup_percpu.c        |    5 -
 arch/x86/kernel/smpboot.c             |   15 ++++-
 arch/x86/kernel/vmlinux.lds.S         |    7 +-
 arch/x86/mm/cpu_entry_area.c          |   64 +++++++++++++++------
 arch/x86/mm/fault.c                   |    3 -
 arch/x86/tools/relocs.c               |    2 
 arch/x86/xen/smp_pv.c                 |    4 +
 arch/x86/xen/xen-head.S               |   10 +--
 drivers/xen/events/events_base.c      |    1 
 31 files changed, 375 insertions(+), 272 deletions(-)



