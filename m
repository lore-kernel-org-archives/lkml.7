Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136C9C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E9E206FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKMVCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:02:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38880 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfKMVCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:20 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmH-00066C-Lg; Wed, 13 Nov 2019 22:02:13 +0100
Message-Id: <20191113204240.767922595@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:40 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V3 00/20] x86/iopl: Prevent user space from using CLI/STI with
 iopl(3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third version of the attempt to confine the unwanted side
effects of iopl(). The first version of this series can be found here:

   https://lore.kernel.org/r/20191106193459.581614484@linutronix.de

Second version is here:

   https://lore.kernel.org/r/20191111220314.519933535@linutronix.de

The V1 cover letter also contains a longer variant of the
background. Summary:

iopl(level = 3) enables aside of access to all 65536 I/O ports also the
usage of CLI/STI in user space.

Disabling interrupts in user space can lead to system lockups and breaks
assumptions in the kernel that userspace always runs with interrupts
enabled.

iopl() is often preferred over ioperm() as it avoids the overhead of
copying the tasks I/O bitmap to the TSS bitmap on context switch. This
overhead can be avoided by providing a all zeroes bitmap in the TSS and
switching the TSS bitmap offset to this permit all IO bitmap. It's
marginally slower than iopl() which is a one time setup, but prevents the
usage of CLI/STI in user space.

The changes vs. V3:

    - Split out the restructuring of the first/subsequent ioperm()
      invocation into a seperate patch to address the inconsisteny which
      Andy detected in the patch which introduces the concept of
      invalidating the I/O bitmap base to speed up context switching.
      This change is moved in front so the subsequent changes are
      functionally correct.

    - Moved the non HW TSS data related to I/O bitmap(s) into a seperate
      data structure. Modified version of Ingos proposed patch.

    - Made struct memeber names more consistent (Ingo)

    - Dropped the bitmap union. It is not longer necessary because V2
      already dropped the finer grained copying algorithm. The sequence
      count approach should avoid most of the copying overhead when the
      number of ioperm() using processes is very low which is the normal
      case.

    - Dropped the pointer storage of the bitmap in the TSS data as it is
      not required (Peter, Andy)

    - Fixed the missing refcount setting in the bitmap duplication code
      path. (Peter, Andy)

    - Updated changelog and comment to explain the bitmap invalidation
      logic. (Andy)

    - Removed TIF_IO_BITMAP from the TIF flags which are evaluated on the
      next task for entering the slow path.

    - Folded the NULL pointer check fix

    - Simplified the config option in the legacy removal patch (Andy)

    - Extended the scope of the config option to disable ioperm() along
      with iopl() which also mokes all related storage and functions
      compile time conditional. (Andy)

The series is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/iopl

Thanks,

	tglx
---
 arch/x86/Kconfig                        |   18 ++
 arch/x86/entry/common.c                 |    4 
 arch/x86/include/asm/io_bitmap.h        |   29 ++++
 arch/x86/include/asm/paravirt.h         |    4 
 arch/x86/include/asm/paravirt_types.h   |    2 
 arch/x86/include/asm/pgtable_32_types.h |    2 
 arch/x86/include/asm/processor.h        |  113 ++++++++++-------
 arch/x86/include/asm/ptrace.h           |    6 
 arch/x86/include/asm/switch_to.h        |   10 +
 arch/x86/include/asm/thread_info.h      |   14 +-
 arch/x86/include/asm/xen/hypervisor.h   |    2 
 arch/x86/kernel/cpu/common.c            |  188 ++++++++++++----------------
 arch/x86/kernel/doublefault.c           |    2 
 arch/x86/kernel/ioport.c                |  209 +++++++++++++++++++++-----------
 arch/x86/kernel/paravirt.c              |    2 
 arch/x86/kernel/process.c               |  200 ++++++++++++++++++++++++------
 arch/x86/kernel/process_32.c            |   77 -----------
 arch/x86/kernel/process_64.c            |   86 -------------
 arch/x86/kernel/ptrace.c                |   12 +
 arch/x86/kvm/vmx/vmx.c                  |    8 -
 arch/x86/mm/cpu_entry_area.c            |    8 +
 arch/x86/xen/enlighten_pv.c             |   10 -
 tools/testing/selftests/x86/ioperm.c    |   16 ++
 tools/testing/selftests/x86/iopl.c      |  129 ++++++++++++++++++-
 24 files changed, 674 insertions(+), 477 deletions(-)

