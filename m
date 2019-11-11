Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966F9C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7169E22467
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfKKWgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:36:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60000 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKKWfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:35:45 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUIHb-0000tR-Hv; Mon, 11 Nov 2019 23:35:39 +0100
Message-Id: <20191111220314.519933535@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 23:03:14 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V2 00/16] x86/iopl: Prevent user space from using CLI/STI with
 iopl(3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second version of the attempt to confine the unwanted side
effects of iopl(). The first version of this series can be found here:

   https://lore.kernel.org/r/20191106193459.581614484@linutronix.de

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

The changes vs. V1:

    - Fix the reported fallout on 32bit (0-day/Ingo)

    - Implement a sequence count based conditional update (Linus)

    - Drop the copy optimization

    - Move the bitmap copying out of the context switch into the exit to
      user mode machinery. The context switch merely invalidates the TSS
      bitmap offset when a task using an I/O bitmap gets scheduled out.

    - Move all bitmap information into a data structure to avoid adding
      more fields to thread_struct.

    - Add a refcount so the potentially pointless duplication of the bitmap
      at fork can be avoided. 

    - Better sharing of update functions (Andy)

    - More updates to self tests to verify the share/unshare mechanism and
      the restore of an I/O bitmap when iopl() permissions are dropped.

    - Pick up a few acked/reviewed-by tags as applicable

The series is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/iopl

Thanks,

	tglx
---
 arch/x86/Kconfig                        |   26 ++++
 arch/x86/entry/common.c                 |    4 
 arch/x86/include/asm/iobitmap.h         |   25 ++++
 arch/x86/include/asm/paravirt.h         |    4 
 arch/x86/include/asm/paravirt_types.h   |    2 
 arch/x86/include/asm/pgtable_32_types.h |    2 
 arch/x86/include/asm/processor.h        |   97 +++++++++-------
 arch/x86/include/asm/ptrace.h           |    6 
 arch/x86/include/asm/switch_to.h        |   10 +
 arch/x86/include/asm/xen/hypervisor.h   |    2 
 arch/x86/kernel/cpu/common.c            |  175 +++++++++++-----------------
 arch/x86/kernel/doublefault.c           |    2 
 arch/x86/kernel/ioport.c                |  176 ++++++++++++++++++-----------
 arch/x86/kernel/paravirt.c              |    2 
 arch/x86/kernel/process.c               |  194 +++++++++++++++++++++++++-------
 arch/x86/kernel/process_32.c            |   77 ------------
 arch/x86/kernel/process_64.c            |   86 --------------
 arch/x86/kernel/ptrace.c                |   12 +
 arch/x86/kvm/vmx/vmx.c                  |    8 -
 arch/x86/mm/cpu_entry_area.c            |    8 +
 arch/x86/xen/enlighten_pv.c             |   10 -
 tools/testing/selftests/x86/ioperm.c    |   16 ++
 tools/testing/selftests/x86/iopl.c      |  129 +++++++++++++++++++--
 23 files changed, 614 insertions(+), 459 deletions(-)


