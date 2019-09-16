Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7D1C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C318C216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568632398;
	bh=4QQ2eiBlqJRzgxliw5y5akvBuWcVbxlPaiWGoXLDSwU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BDUKuAY+d9Nt2Og7dh/Pc/nT7nmGLrRAgugijbx4QSE5jLadGB9RlyBanwXnof3pN
	 OQZeblV+nRElNtEvRlXdeo9BxxWwEMFNr3YA72T1ly2UdB8H+PDQG7Zz7KV5OcDcM6
	 IscV2ene33gjwbIGwfDEwyvGTzAMB+foR6/e0Wx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfIPLNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfIPLNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:13:17 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EE0020678;
        Mon, 16 Sep 2019 11:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568632396;
        bh=4QQ2eiBlqJRzgxliw5y5akvBuWcVbxlPaiWGoXLDSwU=;
        h=From:To:Cc:Subject:Date:From;
        b=kdNe0Xcs2py7uB37hd6OaC+BxcCHF5OAByCYeUHAyhugtMNIKvpzqdLnk1LCMAvSQ
         L1akARt7IHyBiHokMbRVQBDV97iFrGKs7dO18RusjbkiH9i6Xgsb9OJybR91wGwiVE
         +FebuWPhvzAXJ7y5QPEc0mjqDmAYymnRN99C3SEI=
From:   Mike Rapoport <rppt@kernel.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: [PATCH v2] mips: sgi-ip27: switch from DISCONTIGMEM to SPARSEMEM
Date:   Mon, 16 Sep 2019 14:13:10 +0300
Message-Id: <1568632390-20893-1-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The memory initialization of SGI-IP27 is already half-way to support
SPARSEMEM. It only had free_bootmem_with_active_regions() left-overs
interfering with sparse_memory_present_with_active_regions().

Replace these calls with simpler memblocks_present() call in prom_meminit()
and adjust arch/mips/Kconfig to enable SPARSEMEM and SPARSEMEM_EXTREME for
SGI-IP27.

Co-developed-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---

v2: don't add extra sparse_init() and use memblocks_present() instead of
sparse_memory_present_with_active_regions()

 arch/mips/Kconfig                | 12 ++----------
 arch/mips/sgi-ip27/ip27-memory.c |  6 ++----
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d50fafd..e4b02b5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -669,6 +669,7 @@ config SGI_IP22
 config SGI_IP27
 	bool "SGI IP27 (Origin200/2000)"
 	select ARCH_HAS_PHYS_TO_DMA
+	select ARCH_SPARSEMEM_ENABLE
 	select FW_ARC
 	select FW_ARC64
 	select BOOT_ELF64
@@ -2633,18 +2634,9 @@ config ARCH_FLATMEM_ENABLE
 	def_bool y
 	depends on !NUMA && !CPU_LOONGSON2
 
-config ARCH_DISCONTIGMEM_ENABLE
-	bool
-	default y if SGI_IP27
-	help
-	  Say Y to support efficient handling of discontiguous physical memory,
-	  for architectures which are either NUMA (Non-Uniform Memory Access)
-	  or have huge holes in the physical address space for other reasons.
-	  See <file:Documentation/vm/numa.rst> for more.
-
 config ARCH_SPARSEMEM_ENABLE
 	bool
-	select SPARSEMEM_STATIC
+	select SPARSEMEM_STATIC if !SGI_IP27
 
 config NUMA
 	bool "NUMA Support"
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index fb077a9..9db8692 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -406,12 +406,8 @@ static void __init node_mem_init(cnodeid_t node)
 	slot_freepfn += PFN_UP(sizeof(struct pglist_data) +
 			       sizeof(struct hub_data));
 
-	free_bootmem_with_active_regions(node, end_pfn);
-
 	memblock_reserve(slot_firstpfn << PAGE_SHIFT,
 			 ((slot_freepfn - slot_firstpfn) << PAGE_SHIFT));
-
-	sparse_memory_present_with_active_regions(node);
 }
 
 /*
@@ -444,6 +440,8 @@ void __init prom_meminit(void)
 		}
 		__node_data[node] = &null_node;
 	}
+
+	memblocks_present();
 }
 
 void __init prom_free_prom_memory(void)
-- 
2.7.4

