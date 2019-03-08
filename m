Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12579C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D340E20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCHKyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:54:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfCHKyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:54:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21AF059476;
        Fri,  8 Mar 2019 10:54:17 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-204-24.brq.redhat.com [10.40.204.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDC0560141;
        Fri,  8 Mar 2019 10:54:14 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2] powerpc/mm: move warning from resize_hpt_for_hotplug()
Date:   Fri,  8 Mar 2019 11:54:13 +0100
Message-Id: <20190308105413.4302-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 08 Mar 2019 10:54:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resize_hpt_for_hotplug() reports a warning when it cannot
resize the hash page table ("Unable to resize hash page
table to target order") but in some cases it's not a problem
and can make user thinks something has not worked properly.

This patch moves the warning to arch_remove_memory() to
only report the problem when it is needed.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 arch/powerpc/include/asm/sparsemem.h  |  4 ++--
 arch/powerpc/mm/hash_utils_64.c       | 17 ++++++-----------
 arch/powerpc/mm/mem.c                 |  3 ++-
 arch/powerpc/platforms/pseries/lpar.c |  3 ++-
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index 68da49320592..3192d454a733 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -17,9 +17,9 @@ extern int create_section_mapping(unsigned long start, unsigned long end, int ni
 extern int remove_section_mapping(unsigned long start, unsigned long end);
 
 #ifdef CONFIG_PPC_BOOK3S_64
-extern void resize_hpt_for_hotplug(unsigned long new_mem_size);
+extern int resize_hpt_for_hotplug(unsigned long new_mem_size);
 #else
-static inline void resize_hpt_for_hotplug(unsigned long new_mem_size) { }
+static inline int resize_hpt_for_hotplug(unsigned long new_mem_size) { return 0; }
 #endif
 
 #ifdef CONFIG_NUMA
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0cc7fbc3bd1c..40bb2a8326bb 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -755,12 +755,12 @@ static unsigned long __init htab_get_table_size(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-void resize_hpt_for_hotplug(unsigned long new_mem_size)
+int resize_hpt_for_hotplug(unsigned long new_mem_size)
 {
 	unsigned target_hpt_shift;
 
 	if (!mmu_hash_ops.resize_hpt)
-		return;
+		return 0;
 
 	target_hpt_shift = htab_shift_for_mem_size(new_mem_size);
 
@@ -773,15 +773,10 @@ void resize_hpt_for_hotplug(unsigned long new_mem_size)
 	 * current shift
 	 */
 	if ((target_hpt_shift > ppc64_pft_size)
-	    || (target_hpt_shift < (ppc64_pft_size - 1))) {
-		int rc;
-
-		rc = mmu_hash_ops.resize_hpt(target_hpt_shift);
-		if (rc && (rc != -ENODEV))
-			printk(KERN_WARNING
-			       "Unable to resize hash page table to target order %d: %d\n",
-			       target_hpt_shift, rc);
-	}
+	    || (target_hpt_shift < (ppc64_pft_size - 1)))
+		return mmu_hash_ops.resize_hpt(target_hpt_shift);
+
+	return 0;
 }
 
 int hash__create_section_mapping(unsigned long start, unsigned long end, int nid)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 33cc6f676fa6..0d40d970cf4a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -169,7 +169,8 @@ int __meminit arch_remove_memory(int nid, u64 start, u64 size,
 	 */
 	vm_unmap_aliases();
 
-	resize_hpt_for_hotplug(memblock_phys_mem_size());
+	if (resize_hpt_for_hotplug(memblock_phys_mem_size()) == -ENOSPC)
+		pr_warn("Hash collision while resizing HPT\n");
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index f2a9f0adc2d3..1034ef1fe2b4 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -901,8 +901,10 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
 		break;
 
 	case H_PARAMETER:
+		pr_warn("Invalid argument from H_RESIZE_HPT_PREPARE\n");
 		return -EINVAL;
 	case H_RESOURCE:
+		pr_warn("Operation not permitted from H_RESIZE_HPT_PREPARE\n");
 		return -EPERM;
 	default:
 		pr_warn("Unexpected error %d from H_RESIZE_HPT_PREPARE\n", rc);
@@ -918,7 +920,6 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
 	if (rc != 0) {
 		switch (state.commit_rc) {
 		case H_PTEG_FULL:
-			pr_warn("Hash collision while resizing HPT\n");
 			return -ENOSPC;
 
 		default:
-- 
2.20.1

