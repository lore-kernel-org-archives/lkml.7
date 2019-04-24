Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C315C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5975A2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127780;
	bh=tqkGpJGwOVo6XQncQffXaW5+FEV12kvcQdDx5u1IYUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cJ7DAUDyFxopgVDesNdE0uhgr8QXg/YMv6XQlWqdqQ7y7MRq9PKqbFxmF5rlrIC5F
	 HBwCjzXIYot6prv990eKOC9UUv2j95LIgpkXV2lu7lvnnyxZLRRAGQ3vPVAvA7NREQ
	 lDlVS5u0vDIG6sEdzYdGH4nwr6fqVImqh27UgJIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391531AbfDXRff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391886AbfDXRf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:28 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B07B42054F;
        Wed, 24 Apr 2019 17:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127327;
        bh=tqkGpJGwOVo6XQncQffXaW5+FEV12kvcQdDx5u1IYUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tpn4RD159eIDoKZ/wVZUT8zCccHunLVo7yYBBOtA1iwWWyhEYP7Lx3e5Dr0geTW8h
         1lkvaGq1tmveSi8V3lald+uMObhtQ9vSanCIYLAzQvMSX6iz6rfMc6DWbdAI/gTT+0
         AlvA8eQ1avrKVkhS76bI6Qx23QNr3LJQpRi4f27M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 5.0 049/115] fs/dax: Deposit pagetable even when installing zero page
Date:   Wed, 24 Apr 2019 19:09:45 +0200
Message-Id: <20190424170927.876092256@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

commit 11cf9d863dcb583345723b0ed72173348761e9c0 upstream.

Architectures like ppc64 use the deposited page table to store hardware
page table slot information. Make sure we deposit a page table when
using zero page at the pmd level for hash.

Without this we hit

Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc000000000082a74
Oops: Kernel access of bad area, sig: 11 [#1]
....

NIP [c000000000082a74] __hash_page_thp+0x224/0x5b0
LR [c0000000000829a4] __hash_page_thp+0x154/0x5b0
Call Trace:
 hash_page_mm+0x43c/0x740
 do_hash_page+0x2c/0x3c
 copy_from_iter_flushcache+0xa4/0x4a0
 pmem_copy_from_iter+0x2c/0x50 [nd_pmem]
 dax_copy_from_iter+0x40/0x70
 dax_iomap_actor+0x134/0x360
 iomap_apply+0xfc/0x1b0
 dax_iomap_rw+0xac/0x130
 ext4_file_write_iter+0x254/0x460 [ext4]
 __vfs_write+0x120/0x1e0
 vfs_write+0xd8/0x220
 SyS_write+0x6c/0x110
 system_call+0x3c/0x130

Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
Cc: <stable@vger.kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dax.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/fs/dax.c
+++ b/fs/dax.c
@@ -33,6 +33,7 @@
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
+#include <asm/pgalloc.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -1409,7 +1410,9 @@ static vm_fault_t dax_pmd_load_hole(stru
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	unsigned long pmd_addr = vmf->address & PMD_MASK;
+	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = mapping->host;
+	pgtable_t pgtable = NULL;
 	struct page *zero_page;
 	spinlock_t *ptl;
 	pmd_t pmd_entry;
@@ -1424,12 +1427,22 @@ static vm_fault_t dax_pmd_load_hole(stru
 	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
 			DAX_PMD | DAX_ZERO_PAGE, false);
 
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (!pgtable)
+			return VM_FAULT_OOM;
+	}
+
 	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
 	if (!pmd_none(*(vmf->pmd))) {
 		spin_unlock(ptl);
 		goto fallback;
 	}
 
+	if (pgtable) {
+		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
+		mm_inc_nr_ptes(vma->vm_mm);
+	}
 	pmd_entry = mk_pmd(zero_page, vmf->vma->vm_page_prot);
 	pmd_entry = pmd_mkhuge(pmd_entry);
 	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
@@ -1438,6 +1451,8 @@ static vm_fault_t dax_pmd_load_hole(stru
 	return VM_FAULT_NOPAGE;
 
 fallback:
+	if (pgtable)
+		pte_free(vma->vm_mm, pgtable);
 	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_page, *entry);
 	return VM_FAULT_FALLBACK;
 }


