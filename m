Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1111C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B1321773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfEWJRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:17:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41100 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfEWJRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:17:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE3FC341;
        Thu, 23 May 2019 02:17:53 -0700 (PDT)
Received: from e111045-lin.cambridge.arm.com (unknown [10.1.39.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3827F3F718;
        Thu, 23 May 2019 02:17:52 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marc.zyngier@arm.com, james.morse@arm.com, will.deacon@arm.com,
        guillaume.gardet@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@arm.com>
Subject: [PATCH] arm64/kernel: kaslr: reduce module randomization range to 2 GB
Date:   Thu, 23 May 2019 10:17:37 +0100
Message-Id: <20190523091737.18797-1-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit

  7290d5809571 ("module: use relative references for __ksymtab entries")

updated the ksymtab handling of some KASLR capable architectures
so that ksymtab entries are emitted as pairs of 32-bit relative
references. This reduces the size of the entries, but more
importantly, it gets rid of statically assigned absolute
addresses, which require fixing up at boot time if the kernel
is self relocating (which takes a 24 byte RELA entry for each
member of the ksymtab struct).

Since ksymtab entries are always part of the same module as the
symbol they export, it was assumed at the time that a 32-bit
relative reference is always sufficient to capture the offset
between a ksymtab entry and its target symbol.

Unfortunately, this is not always true: in the case of per-CPU
variables, a per-CPU variable's base address (which usually differs
from the actual address of any of its per-CPU copies) is allocated
in the vicinity of the ..data.percpu section in the core kernel
(i.e., in the per-CPU reserved region which follows the section
containing the core kernel's statically allocated per-CPU variables).

Since we randomize the module space over a 4 GB window covering
the core kernel (based on the -/+ 4 GB range of an ADRP/ADD pair),
we may end up putting the core kernel out of the -/+ 2 GB range of
32-bit relative references of module ksymtab entries that refer to
per-CPU variables.

So reduce the module randomization range a bit further. We lose
1 bit of randomization this way, but this is something we can
tolerate.

Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
---

This supersedes

module/ksymtab: use 64-bit relative reference for target symbol
x86/tools: deal with 64-bit relative relocations for per-CPU symbols

and is complemented by

arm64/module: deal with ambiguity in PRELxx relocation ranges

 arch/arm64/kernel/kaslr.c  | 4 ++--
 arch/arm64/kernel/module.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index b09b6f75f759..5d5f3ed3e66a 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -152,8 +152,8 @@ u64 __init kaslr_early_init(u64 dt_phys)
 		 * resolved via PLTs. (Branches between modules will be
 		 * resolved normally.)
 		 */
-		module_range = SZ_4G - (u64)(_end - _stext);
-		module_alloc_base = max((u64)_end + offset - SZ_4G,
+		module_range = SZ_2G - (u64)(_end - _stext);
+		module_alloc_base = max((u64)_end + offset - SZ_2G,
 					(u64)MODULES_VADDR);
 	} else {
 		/*
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 2e4e3915b4d0..b2f99ff76ed1 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -56,7 +56,7 @@ void *module_alloc(unsigned long size)
 		 * can simply omit this fallback in that case.
 		 */
 		p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
-				module_alloc_base + SZ_4G, GFP_KERNEL,
+				module_alloc_base + SZ_2G, GFP_KERNEL,
 				PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 
-- 
2.17.1

