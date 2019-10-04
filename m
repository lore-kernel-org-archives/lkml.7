Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2FBC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B9F222CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfJDSQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:16:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:15508 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfJDSQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:16:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 11:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="204394738"
Received: from chang-linux-3.sc.intel.com ([172.25.66.185])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2019 11:16:57 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH v9 00/17] Enable FSGSBASE instructions
Date:   Fri,  4 Oct 2019 11:15:52 -0700
Message-Id: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benefits:
Currently a user process that wishes to read or write the FS/GS base must
make a system call. But recent X86 processors have added new instructions
for use in 64-bit mode that allow direct access to the FS and GS segment
base addresses.  The operating system controls whether applications can
use these instructions with a %cr4 control bit.

In addition to benefits to applications, performance improvements to the
OS context switch code are possible by making use of these instructions. A
third party reported out promising performance numbers out of their
initial benchmarking of the previous version of this patch series [9].

Enablement check:
The kernel provides information about the enabled state of FSGSBASE to
applications using the ELF_AUX vector. If the HWCAP2_FSGSBASE bit is set in
the AUX vector, the kernel has FSGSBASE instructions enabled and
applications can use them.

Kernel changes:
Major changes made in the kernel are in context switch, paranoid path, and
ptrace. In a context switch, a task's FS/GS base will be secured regardless
of its selector. In the paranoid path, GS base is unconditionally
overwritten to the kernel GS base on entry and the original GS base is
restored on exit. Ptrace includes divergence of FS/GS index and base
values.

Security:
For mitigating the Spectre v1 SWAPGS issue, LFENCE instructions were added
on most kernel entries. Those patches are dependent on previous behaviors
that users couldn't load a kernel address into the GS base. These patches
change that assumption since the user can load any address into GS base.
The changes to the kernel entry path in this patch series take account of
the SWAPGS issue.

Updates from v8 [10]:
* Internalized the interrupt check in the helper functions (Andy L.)
* Simplified GS base helper functions (Tony L.)
* Changed the patch order to put the paranoid path changes before the
  context switch changes (Tony L.)
* Fixed typos (Randy D.) and massaged a few sentences in the documentation
* Massaged the FSGSBASE enablement message

Previous versions: [1-7]

[1] version 1: https://lkml.kernel.org/r/1521481767-22113-1-git-send-email-chang.seok.bae@intel.com/
[2] version 2: https://lkml.kernel.org/r/1527789525-8857-1-git-send-email-chang.seok.bae@intel.com/
[3] version 3: https://lkml.kernel.org/r/20181023184234.14025-1-chang.seok.bae@intel.com/
[4] version 4: https://lkml.kernel.org/r/20190116224849.8617-1-chang.seok.bae@intel.com/
[5] version 5: https://lkml.kernel.org/r/20190201205319.15995-1-chang.seok.bae@intel.com/
[6] version 6: https://lkml.kernel.org/r/1552680405-5265-1-git-send-email-chang.seok.bae@intel.com/
[7] version 7: https://lkml.kernel.org/r/1557309753-24073-1-git-send-email-chang.seok.bae@intel.com/
[8] previously merged point (right before reverted):
    https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86-cpu-for-linus&id=697096b14444f458fb81212d1c
82d7846e932455
[9] initial benchmark: https://www.phoronix.com/scan.php?page=article&item=linux-wip-fsgsbase&num=1
[10] version 8: https://lore.kernel.org/lkml/1568318818-4091-1-git-send-email-chang.seok.bae@intel.com/

Andi Kleen (2):
  x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
  x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2

Andy Lutomirski (4):
  x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
  x86/entry/64: Clean up paranoid exit
  x86/fsgsbase/64: Use FSGSBASE in switch_to() if available
  x86/fsgsbase/64: Enable FSGSBASE on 64bit by default and add a chicken
    bit

Chang S. Bae (9):
  x86/ptrace: Prevent ptrace from clearing the FS/GS selector
  selftests/x86/fsgsbase: Test GS selector on ptracer-induced GS base
    write
  x86/entry/64: Switch CR3 before SWAPGS in paranoid entry
  x86/entry/64: Introduce the FIND_PERCPU_BASE macro
  x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit
  x86/entry/64: Document GSBASE handling in the paranoid path
  x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
  x86/fsgsbase/64: Use FSGSBASE instructions on thread copy and ptrace
  selftests/x86/fsgsbase: Test ptracer-induced GS base write with
    FSGSBASE

Thomas Gleixner (1):
  Documentation/x86/64: Add documentation for GS/FS addressing mode

Tony Luck (1):
  x86/speculation/swapgs: Check FSGSBASE in enabling SWAPGS mitigation

 Documentation/admin-guide/kernel-parameters.txt |   2 +
 Documentation/x86/entry_64.rst                  |   9 ++
 Documentation/x86/x86_64/fsgs.rst               | 199 ++++++++++++++++++++++++
 Documentation/x86/x86_64/index.rst              |   1 +
 arch/x86/entry/calling.h                        |  40 +++++
 arch/x86/entry/entry_64.S                       | 134 ++++++++++++----
 arch/x86/include/asm/fsgsbase.h                 |  45 ++++--
 arch/x86/include/asm/inst.h                     |  15 ++
 arch/x86/include/uapi/asm/hwcap2.h              |   3 +
 arch/x86/kernel/cpu/bugs.c                      |   6 +-
 arch/x86/kernel/cpu/common.c                    |  22 +++
 arch/x86/kernel/process_64.c                    | 107 +++++++++++--
 arch/x86/kernel/ptrace.c                        |  14 +-
 tools/testing/selftests/x86/fsgsbase.c          |  24 ++-
 14 files changed, 549 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/x86/x86_64/fsgs.rst

-- 
2.7.4

