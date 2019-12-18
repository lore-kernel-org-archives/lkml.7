Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B805C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EFD227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfLRQY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:24:29 -0500
Received: from foss.arm.com ([217.140.110.172]:51836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfLRQYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:24:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E80D30E;
        Wed, 18 Dec 2019 08:24:24 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A156B3F719;
        Wed, 18 Dec 2019 08:24:21 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH v17 00/23] Generic page walk and ptdump
Date:   Wed, 18 Dec 2019 16:23:39 +0000
Message-Id: <20191218162402.45610-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version is two patches lighter than v16:
 mm: pagewalk: Add test_p?d callbacks
 x86: mm: Convert ptdump_walk_pgd_level_core() to take an mm_struct

There is a new enum page_walk_action in struct mm_walk which allows the
callbacks to decide whether to recurse (ACTION_SUBTREE - the default),
skip (ACTION_CONTINUE) or to be called again (ACTION_AGAIN). These are
introduced in patch 11 and used for hmm.c to adapt it to the new
behaviour of the pud_entry() callback.

The new page_walk_action means that we no longer need to test_p?d()
callbacks as the p?d_entry() callbacks can simply return ACTION_CONTINUE
to skip parts of the tree.

The x86 patch is dropped because I've updated patch 20 to always use a
'fake_mm' structure which simplifies the code and avoids issues with
potentially double locking the mmap_sem of the real mm.

Previous description for the series
-----------------------------------

Many architectures current have a debugfs file for dumping the kernel
page tables. Currently each architecture has to implement custom
functions for this because the details of walking the page tables used
by the kernel are different between architectures.

This series extends the capabilities of walk_page_range() so that it can
deal with the page tables of the kernel (which have no VMAs and can
contain larger huge pages than exist for user space). A generic PTDUMP
implementation is the implemented making use of the new functionality of
walk_page_range() and finally arm64 and x86 are switch to using it,
removing the custom table walkers.

To enable a generic page table walker to walk the unusual mappings of
the kernel we need to implement a set of functions which let us know
when the walker has reached the leaf entry. After a suggestion from Will
Deacon I've chosen the name p?d_leaf() as this (hopefully) describes
the purpose (and is a new name so has no historic baggage). Some
architectures have p?d_large macros but this is easily confused with
"large pages".

This series ends with a generic PTDUMP implemention for arm64 and x86.

Mostly this is a clean up and there should be very little functional
change. The exceptions are:

* arm64 PTDUMP debugfs now displays pages which aren't present (patch 22).

* arm64 has the ability to efficiently process KASAN pages (which
  previously only x86 implemented). This means that the combination of
  KASAN and DEBUG_WX is now useable.

Also available as a git tree:
git://linux-arm.org/linux-sp.git walk_page_range/v17

Changes since v16:
https://lore.kernel.org/lkml/20191206135316.47703-1-steven.price@arm.com/
 * Introduced the ACTION_{SUBTREE,CONTINUE,AGAIN} concept suggested by
   Thomas Hellström
 * Reworked the KASAN support to avoid the need for test_p?d() callbacks
   by using ACTION_CONTINUE instead
 * powerpc: Use p?d_is_leaf rather than adding new functions
 * Simplify x86 changes by leaving ptdump_walk_pgd_level_core() taking
   a pgd

Changes since v15:
https://lore.kernel.org/lkml/20191101140942.51554-1-steven.price@arm.com/
 * Rebased onto Linus' tree, which includes the conflicting commit:
   ace88f1018b8 ("mm: pagewalk: Take the pagetable lock in walk_pte_range()")
 * New patch fixing conflict with above patch
 * Squashed in fix for ordering of "static const"
 * Squashed in fix checking p*d_present()
 * New patch fixing termination condition for walk_pte_range()

Changes since v14:
https://lore.kernel.org/lkml/20191028135910.33253-1-steven.price@arm.com/
 * Switch walk_page_range() into two functions, the existing
   walk_page_range() now still requires VMAs (and treats areas without a
   VMA as a 'hole'). The new walk_page_range_novma() ignores VMAs and
   will report the actual page table layout. This fixes the previous
   breakage of /proc/<pid>/pagemap
 * New patch at the end of the series which reduces the 'level' numbers
   by 1 to simplify the code slightly
 * Added tags

Changes since v13:
https://lore.kernel.org/lkml/20191024093716.49420-1-steven.price@arm.com/
 * Fixed typo in arc definition of pmd_leaf() spotted by the kbuild test
   robot
 * Added tags

Changes since v12:
https://lore.kernel.org/lkml/20191018101248.33727-1-steven.price@arm.com/
 * Correct code format in riscv pud_leaf()/pmd_leaf()
 * v12 may not have reached everyone because of mail server problems
   (which are now hopefully resolved!)

Changes since v11:
https://lore.kernel.org/lkml/20191007153822.16518-1-steven.price@arm.com/
 * Use "-1" as dummy depth parameter in patch 14.

Changes since v10:
https://lore.kernel.org/lkml/20190731154603.41797-1-steven.price@arm.com/
 * Rebased to v5.4-rc1 - mainly various updates to deal with the
   splitting out of ops from struct mm_walk.
 * Deal with PGD_LEVEL_MULT not always being constant on x86.

Changes since v9:
https://lore.kernel.org/lkml/20190722154210.42799-1-steven.price@arm.com/
 * Moved generic macros to first page in the series and explained the
   macro naming in the commit message.
 * mips: Moved macros to pgtable.h as they are now valid for both 32 and 64
   bit
 * x86: Dropped patch which changed the debugfs output for x86, instead
   we have...
 * new patch adding 'depth' parameter to pte_hole. This is used to
   provide the necessary information to output lines for 'holes' in the
   debugfs files
 * new patch changing arm64 debugfs output to include holes to match x86
 * generic ptdump KASAN handling has been simplified and now works with
   CONFIG_DEBUG_VIRTUAL.

Changes since v8:
https://lore.kernel.org/lkml/20190403141627.11664-1-steven.price@arm.com/
 * Rename from p?d_large() to p?d_leaf()
 * Dropped patches migrating arm64/x86 custom walkers to
   walk_page_range() in favour of adding a generic PTDUMP implementation
   and migrating arm64/x86 to that instead.
 * Rebased to v5.3-rc1

Steven Price (23):
  mm: Add generic p?d_leaf() macros
  arc: mm: Add p?d_leaf() definitions
  arm: mm: Add p?d_leaf() definitions
  arm64: mm: Add p?d_leaf() definitions
  mips: mm: Add p?d_leaf() definitions
  powerpc: mm: Add p?d_leaf() definitions
  riscv: mm: Add p?d_leaf() definitions
  s390: mm: Add p?d_leaf() definitions
  sparc: mm: Add p?d_leaf() definitions
  x86: mm: Add p?d_leaf() definitions
  mm: pagewalk: Add p4d_entry() and pgd_entry()
  mm: pagewalk: Allow walking without vma
  mm: pagewalk: Don't lock PTEs for walk_page_range_novma()
  mm: pagewalk: fix termination condition in walk_pte_range()
  mm: pagewalk: Add 'depth' parameter to pte_hole
  x86: mm: Point to struct seq_file from struct pg_state
  x86: mm+efi: Convert ptdump_walk_pgd_level() to take a mm_struct
  x86: mm: Convert ptdump_walk_pgd_level_debugfs() to take an mm_struct
  mm: Add generic ptdump
  x86: mm: Convert dump_pagetables to use walk_page_range
  arm64: mm: Convert mm/dump.c to use walk_page_range()
  arm64: mm: Display non-present entries in ptdump
  mm: ptdump: Reduce level numbers by 1 in note_page()

 arch/arc/include/asm/pgtable.h               |   1 +
 arch/arm/include/asm/pgtable-2level.h        |   1 +
 arch/arm/include/asm/pgtable-3level.h        |   1 +
 arch/arm64/Kconfig                           |   1 +
 arch/arm64/Kconfig.debug                     |  19 +-
 arch/arm64/include/asm/pgtable.h             |   2 +
 arch/arm64/include/asm/ptdump.h              |   8 +-
 arch/arm64/mm/Makefile                       |   4 +-
 arch/arm64/mm/dump.c                         | 148 ++++-----
 arch/arm64/mm/mmu.c                          |   4 +-
 arch/arm64/mm/ptdump_debugfs.c               |   2 +-
 arch/mips/include/asm/pgtable.h              |   5 +
 arch/powerpc/include/asm/book3s/64/pgtable.h |   3 +
 arch/riscv/include/asm/pgtable-64.h          |   7 +
 arch/riscv/include/asm/pgtable.h             |   7 +
 arch/s390/include/asm/pgtable.h              |   2 +
 arch/sparc/include/asm/pgtable_64.h          |   2 +
 arch/x86/Kconfig                             |   1 +
 arch/x86/Kconfig.debug                       |  20 +-
 arch/x86/include/asm/pgtable.h               |  10 +-
 arch/x86/mm/Makefile                         |   4 +-
 arch/x86/mm/debug_pagetables.c               |   8 +-
 arch/x86/mm/dump_pagetables.c                | 320 +++++--------------
 arch/x86/platform/efi/efi_32.c               |   2 +-
 arch/x86/platform/efi/efi_64.c               |   4 +-
 drivers/firmware/efi/arm-runtime.c           |   2 +-
 fs/proc/task_mmu.c                           |   4 +-
 include/asm-generic/pgtable.h                |  20 ++
 include/linux/pagewalk.h                     |  46 ++-
 include/linux/ptdump.h                       |  22 ++
 mm/Kconfig.debug                             |  21 ++
 mm/Makefile                                  |   1 +
 mm/hmm.c                                     |  59 ++--
 mm/migrate.c                                 |   5 +-
 mm/mincore.c                                 |   1 +
 mm/pagewalk.c                                | 156 ++++++---
 mm/ptdump.c                                  | 139 ++++++++
 37 files changed, 596 insertions(+), 466 deletions(-)
 create mode 100644 include/linux/ptdump.h
 create mode 100644 mm/ptdump.c

-- 
2.20.1

