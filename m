Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B0CC072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453AF20851
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfETFSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 01:18:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37240 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfETFSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:18:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7260480D;
        Sun, 19 May 2019 22:18:44 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 436DD3F5AF;
        Sun, 19 May 2019 22:18:37 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc:     mark.rutland@arm.com, mhocko@suse.com, ira.weiny@intel.com,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        james.morse@arm.com, cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com
Subject: [PATCH V4 2/4] arm64/mm: Inhibit huge-vmap with ptdump
Date:   Mon, 20 May 2019 10:48:34 +0530
Message-Id: <1558329516-10445-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558329516-10445-1-git-send-email-anshuman.khandual@arm.com>
References: <1558329516-10445-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

The arm64 ptdump code can race with concurrent modification of the
kernel page tables. At the time this was added, this was sound as:

* Modifications to leaf entries could result in stale information being
  logged, but would not result in a functional problem.

* Boot time modifications to non-leaf entries (e.g. freeing of initmem)
  were performed when the ptdump code cannot be invoked.

* At runtime, modifications to non-leaf entries only occurred in the
  vmalloc region, and these were strictly additive, as intermediate
  entries were never freed.

However, since commit:

  commit 324420bf91f6 ("arm64: add support for ioremap() block mappings")

... it has been possible to create huge mappings in the vmalloc area at
runtime, and as part of this existing intermediate levels of table my be
removed and freed.

It's possible for the ptdump code to race with this, and continue to
walk tables which have been freed (and potentially poisoned or
reallocated). As a result of this, the ptdump code may dereference bogus
addresses, which could be fatal.

Since huge-vmap is a TLB and memory optimization, we can disable it when
the runtime ptdump code is in use to avoid this problem.

Fixes: 324420bf91f60582 ("arm64: add support for ioremap() block mappings")
Acked-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a170c63..a1bfc44 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -955,13 +955,18 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
 
 int __init arch_ioremap_pud_supported(void)
 {
-	/* only 4k granule supports level 1 block mappings */
-	return IS_ENABLED(CONFIG_ARM64_4K_PAGES);
+	/*
+	 * Only 4k granule supports level 1 block mappings.
+	 * SW table walks can't handle removal of intermediate entries.
+	 */
+	return IS_ENABLED(CONFIG_ARM64_4K_PAGES) &&
+	       !IS_ENABLED(CONFIG_ARM64_PTDUMP_DEBUGFS);
 }
 
 int __init arch_ioremap_pmd_supported(void)
 {
-	return 1;
+	/* See arch_ioremap_pud_supported() */
+	return !IS_ENABLED(CONFIG_ARM64_PTDUMP_DEBUGFS);
 }
 
 int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
-- 
2.7.4

