Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B10C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CBB206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgAGVY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:24:56 -0500
Received: from ale.deltatee.com ([207.54.116.67]:51290 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbgAGVAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:00:17 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iovxQ-0007vu-Dd; Tue, 07 Jan 2020 14:00:11 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iovxI-0001zG-Sv; Tue, 07 Jan 2020 14:00:00 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Tue,  7 Jan 2020 13:59:56 -0700
Message-Id: <20200107205959.7575-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107205959.7575-1-logang@deltatee.com>
References: <20200107205959.7575-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, dan.j.williams@intel.com, akpm@linux-foundation.org, hch@lst.de, catalin.marinas@arm.com, benh@kernel.crashing.org, tglx@linutronix.de, david@redhat.com, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, mhocko@kernel.org, will@kernel.org, luto@kernel.org, peterz@infradead.org, ebadger@gigaio.com, logang@deltatee.com, paulus@samba.org, mpe@ellerman.id.au
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 5/8] powerpc/mm: Thread pgprot_t through create_section_mapping()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prepartion to support a pgprot_t argument for arch_add_memory().

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h  |  3 ++-
 arch/powerpc/include/asm/book3s/64/radix.h |  3 ++-
 arch/powerpc/include/asm/sparsemem.h       |  3 ++-
 arch/powerpc/mm/book3s64/hash_utils.c      |  5 +++--
 arch/powerpc/mm/book3s64/pgtable.c         |  7 ++++---
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 18 +++++++++++-------
 arch/powerpc/mm/mem.c                      |  5 +++--
 7 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 2781ebf6add4..6fc4520092c7 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -251,7 +251,8 @@ extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
 extern void hash__vmemmap_remove_mapping(unsigned long start,
 				     unsigned long page_size);
 
-int hash__create_section_mapping(unsigned long start, unsigned long end, int nid);
+int hash__create_section_mapping(unsigned long start, unsigned long end,
+				 int nid, pgprot_t prot);
 int hash__remove_section_mapping(unsigned long start, unsigned long end);
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index d97db3ad9aae..46799f3c3d1d 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -289,7 +289,8 @@ static inline unsigned long radix__get_tree_size(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int radix__create_section_mapping(unsigned long start, unsigned long end, int nid);
+int radix__create_section_mapping(unsigned long start, unsigned long end,
+				  int nid, pgprot_t prot);
 int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #endif /* CONFIG_MEMORY_HOTPLUG */
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index 3192d454a733..c89b32443cff 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -13,7 +13,8 @@
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-extern int create_section_mapping(unsigned long start, unsigned long end, int nid);
+extern int create_section_mapping(unsigned long start, unsigned long end,
+				  int nid, pgprot_t prot);
 extern int remove_section_mapping(unsigned long start, unsigned long end);
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index b30435c7d804..276e353d5264 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -800,7 +800,8 @@ int resize_hpt_for_hotplug(unsigned long new_mem_size)
 	return 0;
 }
 
-int hash__create_section_mapping(unsigned long start, unsigned long end, int nid)
+int hash__create_section_mapping(unsigned long start, unsigned long end,
+				 int nid, pgprot_t prot)
 {
 	int rc;
 
@@ -810,7 +811,7 @@ int hash__create_section_mapping(unsigned long start, unsigned long end, int nid
 	}
 
 	rc = htab_bolt_mapping(start, end, __pa(start),
-			       pgprot_val(PAGE_KERNEL), mmu_linear_psize,
+			       pgprot_val(prot), mmu_linear_psize,
 			       mmu_kernel_ssize);
 
 	if (rc < 0) {
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 75483b40fcb1..b60c18d2e5c9 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -171,12 +171,13 @@ void mmu_cleanup_all(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int __meminit create_section_mapping(unsigned long start, unsigned long end, int nid)
+int __meminit create_section_mapping(unsigned long start, unsigned long end,
+				     int nid, pgprot_t prot)
 {
 	if (radix_enabled())
-		return radix__create_section_mapping(start, end, nid);
+		return radix__create_section_mapping(start, end, nid, prot);
 
-	return hash__create_section_mapping(start, end, nid);
+	return hash__create_section_mapping(start, end, nid, prot);
 }
 
 int __meminit remove_section_mapping(unsigned long start, unsigned long end)
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 974109bb85db..2a21fb4a22b2 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -253,7 +253,7 @@ static unsigned long next_boundary(unsigned long addr, unsigned long end)
 
 static int __meminit create_physical_mapping(unsigned long start,
 					     unsigned long end,
-					     int nid)
+					     int nid, pgprot_t _prot)
 {
 	unsigned long vaddr, addr, mapping_size = 0;
 	bool prev_exec, exec = false;
@@ -289,7 +289,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 			prot = PAGE_KERNEL_X;
 			exec = true;
 		} else {
-			prot = PAGE_KERNEL;
+			prot = _prot;
 			exec = false;
 		}
 
@@ -333,7 +333,7 @@ static void __init radix_init_pgtable(void)
 
 		WARN_ON(create_physical_mapping(reg->base,
 						reg->base + reg->size,
-						-1));
+						-1, PAGE_KERNEL));
 	}
 
 	/* Find out how many PID bits are supported */
@@ -708,8 +708,10 @@ static int __meminit stop_machine_change_mapping(void *data)
 
 	spin_unlock(&init_mm.page_table_lock);
 	pte_clear(&init_mm, params->aligned_start, params->pte);
-	create_physical_mapping(__pa(params->aligned_start), __pa(params->start), -1);
-	create_physical_mapping(__pa(params->end), __pa(params->aligned_end), -1);
+	create_physical_mapping(__pa(params->aligned_start),
+				__pa(params->start), -1, PAGE_KERNEL);
+	create_physical_mapping(__pa(params->end), __pa(params->aligned_end),
+				-1, PAGE_KERNEL);
 	spin_lock(&init_mm.page_table_lock);
 	return 0;
 }
@@ -866,14 +868,16 @@ static void __meminit remove_pagetable(unsigned long start, unsigned long end)
 	radix__flush_tlb_kernel_range(start, end);
 }
 
-int __meminit radix__create_section_mapping(unsigned long start, unsigned long end, int nid)
+int __meminit radix__create_section_mapping(unsigned long start,
+					    unsigned long end, int nid,
+					    pgprot_t prot)
 {
 	if (end >= RADIX_VMALLOC_START) {
 		pr_warn("Outside the supported range\n");
 		return -1;
 	}
 
-	return create_physical_mapping(__pa(start), __pa(end), nid);
+	return create_physical_mapping(__pa(start), __pa(end), nid, prot);
 }
 
 int __meminit radix__remove_section_mapping(unsigned long start, unsigned long end)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 9dd9c3c1be7f..631ee684721f 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -95,7 +95,8 @@ int memory_add_physaddr_to_nid(u64 start)
 }
 #endif
 
-int __weak create_section_mapping(unsigned long start, unsigned long end, int nid)
+int __weak create_section_mapping(unsigned long start, unsigned long end,
+				  int nid, pgprot_t prot)
 {
 	return -ENODEV;
 }
@@ -136,7 +137,7 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
 	resize_hpt_for_hotplug(memblock_phys_mem_size());
 
 	start = (unsigned long)__va(start);
-	rc = create_section_mapping(start, start + size, nid);
+	rc = create_section_mapping(start, start + size, nid, PAGE_KERNEL);
 	if (rc) {
 		pr_warn("Unable to create mapping for hot added memory 0x%llx..0x%llx: %d\n",
 			start, start + size, rc);
-- 
2.20.1

