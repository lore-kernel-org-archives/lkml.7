Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B4EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B163A20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDCORM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:17:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41330 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfDCORM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:17:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FEAEA78;
        Wed,  3 Apr 2019 07:17:11 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D29D3F68F;
        Wed,  3 Apr 2019 07:17:07 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     linux-mm@kvack.org
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
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v8 00/20] Convert x86 & arm64 to use generic page walk
Date:   Wed,  3 Apr 2019 15:16:07 +0100
Message-Id: <20190403141627.11664-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most architectures current have a debugfs file for dumping the kernel
page tables. Currently each architecture has to implement custom
functions for walking the page tables because the generic
walk_page_range() function is unable to walk the page tables used by the
kernel.

This series extends the capabilities of walk_page_range() so that it can
deal with the page tables of the kernel (which have no VMAs and can
contain larger huge pages than exist for user space). x86 and arm64 are
then converted to make use of walk_page_range() removing the custom page
table walkers.

To enable a generic page table walker to walk the unusual mappings of
the kernel we need to implement a set of functions which let us know
when the walker has reached the leaf entry. Since arm, powerpc, s390,
sparc and x86 all have p?d_large macros lets standardise on that and
implement those that are missing.

Potentially future changes could unify the implementations of the
debugfs walkers further, moving the common functionality into common
code. This would require a common way of handling the effective
permissions (currently implemented only for x86) along with a per-arch
way of formatting the page table information for debugfs. One
immediate benefit would be getting the KASAN speed up optimisation in
arm64 (and other arches) which is currently only implemented for x86.

Also available as a git tree:
git://linux-arm.org/linux-sp.git walk_page_range/v8

Changes since v7:
https://lore.kernel.org/lkml/20190328152104.23106-1-steven.price@arm.com/T/
 * Updated commit message in patch 2 to clarify that we rely on the page
   tables being walked to be the same page size/depth as the kernel's
   (since this confused me earlier today).

Changes since v6:
https://lore.kernel.org/lkml/20190326162624.20736-1-steven.price@arm.com/T/
 * Split the changes for powerpc. pmd_large() is now added in patch 4
   patch, and pmd_is_leaf() removed in patch 5.

Changes since v5:
https://lore.kernel.org/lkml/20190321141953.31960-1-steven.price@arm.com/T/
 * Updated comment for struct mm_walk based on Mike Rapoport's
   suggestion

Changes since v4:
https://lore.kernel.org/lkml/20190306155031.4291-1-steven.price@arm.com/T/
 * Correctly force result to a boolean in p?d_large for powerpc.
 * Added Acked-bys
 * Rebased onto v5.1-rc1

Changes since v3:
https://lore.kernel.org/lkml/20190227170608.27963-1-steven.price@arm.com/T/
 * Restored the generic macros, only implement p?d_large() for
   architectures that have support for large pages. This also means
   adding dummy #defines for architectures that define p?d_large as
   static inline to avoid picking up the generic macro.
 * Drop the 'depth' argument from pte_hole
 * Because we no longer have the depth for holes, we also drop support
   in x86 for showing missing pages in debugfs. See discussion below:
   https://lore.kernel.org/lkml/26df02dd-c54e-ea91-bdd1-0a4aad3a30ac@arm.com/
 * mips: only define p?d_large when _PAGE_HUGE is defined.

Changes since v2:
https://lore.kernel.org/lkml/20190221113502.54153-1-steven.price@arm.com/T/
 * Rather than attemping to provide generic macros, actually implement
   p?d_large() for each architecture.

Changes since v1:
https://lore.kernel.org/lkml/20190215170235.23360-1-steven.price@arm.com/T/
 * Added p4d_large() macro
 * Comments to explain p?d_large() macro semantics
 * Expanded comment for pte_hole() callback to explain mapping between
   depth and P?D
 * Handle folded page tables at all levels, so depth from pte_hole()
   ignores folding at any level (see real_depth() function in
   mm/pagewalk.c)

Steven Price (20):
  arc: mm: Add p?d_large() definitions
  arm64: mm: Add p?d_large() definitions
  mips: mm: Add p?d_large() definitions
  powerpc: mm: Add p?d_large() definitions
  KVM: PPC: Book3S HV: Remove pmd_is_leaf()
  riscv: mm: Add p?d_large() definitions
  s390: mm: Add p?d_large() definitions
  sparc: mm: Add p?d_large() definitions
  x86: mm: Add p?d_large() definitions
  mm: Add generic p?d_large() macros
  mm: pagewalk: Add p4d_entry() and pgd_entry()
  mm: pagewalk: Allow walking without vma
  mm: pagewalk: Add test_p?d callbacks
  arm64: mm: Convert mm/dump.c to use walk_page_range()
  x86: mm: Don't display pages which aren't present in debugfs
  x86: mm: Point to struct seq_file from struct pg_state
  x86: mm+efi: Convert ptdump_walk_pgd_level() to take a mm_struct
  x86: mm: Convert ptdump_walk_pgd_level_debugfs() to take an mm_struct
  x86: mm: Convert ptdump_walk_pgd_level_core() to take an mm_struct
  x86: mm: Convert dump_pagetables to use walk_page_range

 arch/arc/include/asm/pgtable.h               |   1 +
 arch/arm64/include/asm/pgtable.h             |   2 +
 arch/arm64/mm/dump.c                         | 117 +++----
 arch/mips/include/asm/pgtable-64.h           |   8 +
 arch/powerpc/include/asm/book3s/64/pgtable.h |  30 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c       |  12 +-
 arch/riscv/include/asm/pgtable-64.h          |   7 +
 arch/riscv/include/asm/pgtable.h             |   7 +
 arch/s390/include/asm/pgtable.h              |   2 +
 arch/sparc/include/asm/pgtable_64.h          |   2 +
 arch/x86/include/asm/pgtable.h               |  10 +-
 arch/x86/mm/debug_pagetables.c               |   8 +-
 arch/x86/mm/dump_pagetables.c                | 347 ++++++++++---------
 arch/x86/platform/efi/efi_32.c               |   2 +-
 arch/x86/platform/efi/efi_64.c               |   4 +-
 include/asm-generic/pgtable.h                |  19 +
 include/linux/mm.h                           |  26 +-
 mm/pagewalk.c                                |  76 +++-
 18 files changed, 407 insertions(+), 273 deletions(-)

-- 
2.20.1

