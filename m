Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D0C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F1620862
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfENJAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:00:09 -0400
Received: from foss.arm.com ([217.140.101.70]:51906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfENJAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:00:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDE66374;
        Tue, 14 May 2019 02:00:07 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C03A3F71E;
        Tue, 14 May 2019 02:00:00 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
Subject: [PATCH V3 0/4] arm64/mm: Enable memory hot remove
Date:   Tue, 14 May 2019 14:30:03 +0530
Message-Id: <1557824407-19092-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables memory hot remove on arm64 after fixing a memblock
removal ordering problem in generic __remove_memory() and kernel page
table race conditions on arm64. This is based on the following arm64
working tree.

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core

David had pointed out that the following patch is already in next/master
(58b11e136dcc14358) and will conflict with the last patch here. Will fix
the conflict once this series gets reviewed and agreed upon.

Author: David Hildenbrand <david@redhat.com>
Date:   Wed Apr 10 11:02:27 2019 +1000

    mm/memory_hotplug: make __remove_pages() and arch_remove_memory() never fail

    All callers of arch_remove_memory() ignore errors.  And we should really
    try to remove any errors from the memory removal path.  No more errors are
    reported from __remove_pages().  BUG() in s390x code in case
    arch_remove_memory() is triggered.  We may implement that properly later.
    WARN in case powerpc code failed to remove the section mapping, which is
    better than ignoring the error completely right now.

Testing:

Tested memory hot remove on arm64 for 4K, 16K, 64K page config options with
all possible CONFIG_ARM64_VA_BITS and CONFIG_PGTABLE_LEVELS combinations. But
build tested on non arm64 platforms.

Changes in V3:
 
- Implemented most of the suggestions from Mark Rutland for remove_pagetable()
- Fixed applicable PGTABLE_LEVEL wrappers around pgtable page freeing functions
- Replaced 'direct' with 'sparse_vmap' in remove_pagetable() with inverted polarity
- Changed pointer names ('p' at end) and removed tmp from iterations
- Perform intermediate TLB invalidation while clearing pgtable entries
- Dropped flush_tlb_kernel_range() in remove_pagetable()
- Added flush_tlb_kernel_range() in remove_pte_table() instead
- Renamed page freeing functions for pgtable page and mapped pages
- Used page range size instead of order while freeing mapped or pgtable pages
- Removed all PageReserved() handling while freeing mapped or pgtable pages
- Replaced XXX_index() with XXX_offset() while walking the kernel page table
- Used READ_ONCE() while fetching individual pgtable entries
- Taken overall init_mm.page_table_lock instead of just while changing an entry
- Dropped previously added [pmd|pud]_index() which are not required anymore

- Added a new patch to protect kernel page table race condtion for ptdump
- Added a new patch from Mark Rutland to prevent huge-vmap with ptdump

Changes in V2: (https://lkml.org/lkml/2019/4/14/5)

- Added all received review and ack tags
- Split the series from ZONE_DEVICE enablement for better review
- Moved memblock re-order patch to the front as per Robin Murphy
- Updated commit message on memblock re-order patch per Michal Hocko
- Dropped [pmd|pud]_large() definitions
- Used existing [pmd|pud]_sect() instead of earlier [pmd|pud]_large()
- Removed __meminit and __ref tags as per Oscar Salvador
- Dropped unnecessary 'ret' init in arch_add_memory() per Robin Murphy
- Skipped calling into pgtable_page_dtor() for linear mapping page table
  pages and updated all relevant functions

Changes in V1: (https://lkml.org/lkml/2019/4/3/28)

Anshuman Khandual (3):
  mm/hotplug: Reorder arch_remove_memory() call in __remove_memory()
  arm64/mm: Hold memory hotplug lock while walking for kernel page table dump
  arm64/mm: Enable memory hot remove

Mark Rutland (1):
  arm64/mm: Inhibit huge-vmap with ptdump

 arch/arm64/Kconfig             |   3 +
 arch/arm64/mm/mmu.c            | 215 ++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/mm/ptdump_debugfs.c |   3 +
 mm/memory_hotplug.c            |   3 +-
 4 files changed, 217 insertions(+), 7 deletions(-)

-- 
2.7.4

