Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47B6C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC52A2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfDNP6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 11:58:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43174 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDNP6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 11:58:33 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFhWU-0002Qk-Bp; Sun, 14 Apr 2019 17:58:26 +0200
Message-Id: <20190414154621.172182181@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 14 Apr 2019 17:46:21 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V3 00/32] x86: Add guard pages to exception and interrupt
 stacks
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is an updated version of the guard page series:

 V1:   https://lkml.kernel.org/r/20190331214020.836098943@linutronix.de
 V2:   https://lkml.kernel.org/r/20190405150658.237064784@linutronix.de

Changes vs. V2:

  - Fixed the broken stack trace storage in slub

  - Adjust the guard page ordering and fix the top macro (Sean)

  - Fix an off by one in the debug stack check (Sean)

  - Rename ISTACK_ prefix to ESTACK_ (Josh)

  - Collected Acked/Reviewed-by tags

The lot is also available from tip:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/stackguards

     310a7f5b0b42 ("x86/irq/64: Remove stack overflow debug code")

Thanks,

        tglx

8<-------------
 Documentation/x86/kernel-stacks       |   13 +++-
 arch/x86/Kconfig                      |    2 
 arch/x86/entry/entry_64.S             |   16 ++---
 arch/x86/include/asm/cpu_entry_area.h |   69 +++++++++++++++++++++--
 arch/x86/include/asm/debugreg.h       |    2 
 arch/x86/include/asm/irq.h            |    6 --
 arch/x86/include/asm/page_32_types.h  |    8 +-
 arch/x86/include/asm/page_64_types.h  |   16 ++---
 arch/x86/include/asm/processor.h      |   43 +++++---------
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
 arch/x86/kernel/irq_64.c              |   89 +++++++++++++++---------------
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
 mm/slab.c                             |   30 ++++------
 32 files changed, 382 insertions(+), 290 deletions(-)

