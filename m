Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E27C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946262173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="MDIF/NBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfLLIr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:47:59 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:65218 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbfLLIr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:47:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id F36563F738;
        Thu, 12 Dec 2019 09:47:55 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=MDIF/NBN;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Btx1NEBhA_AG; Thu, 12 Dec 2019 09:47:55 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 4DA8E3F5A2;
        Thu, 12 Dec 2019 09:47:51 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 7B2D936042C;
        Thu, 12 Dec 2019 09:47:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1576140471; bh=xDdj038OxNx6FifZJPJkQxRdKvS25lsUfMjZTeK+6SM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDIF/NBNgTVxbb+ZZxfRkZOV5hdSSC6PIfL5HN9g8RqVhm61mZ72BKJKvJrx8SPah
         obldM8qxBliaCh4RBwGAgKIoPBBH/OzWBPuRNF5XkEGzkL2N2S/9WJ6eItjMRwLD0N
         lQo7IYcgfqMahIPTpm3jw+tcCuX5ic11tXiTTyHw=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v4 1/2] mm: Add a vmf_insert_mixed_prot() function
Date:   Thu, 12 Dec 2019 09:47:40 +0100
Message-Id: <20191212084741.9251-2-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191212084741.9251-1-thomas_os@shipmail.org>
References: <20191212084741.9251-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The TTM module today uses a hack to be able to set a different page
protection than struct vm_area_struct::vm_page_prot. To be able to do
this properly, add the needed vm functionality as vmf_insert_mixed_prot().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 include/linux/mm.h       |  2 ++
 include/linux/mm_types.h |  7 ++++++-
 mm/memory.c              | 43 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cc292273e6ba..29575d3c1e47 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2548,6 +2548,8 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			pfn_t pfn);
+vm_fault_t vmf_insert_mixed_prot(struct vm_area_struct *vma, unsigned long addr,
+			pfn_t pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 		unsigned long addr, pfn_t pfn);
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2222fa795284..ac96afdbb4bc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -307,7 +307,12 @@ struct vm_area_struct {
 	/* Second cache line starts here. */
 
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
-	pgprot_t vm_page_prot;		/* Access permissions of this VMA. */
+
+	/*
+	 * Access permissions of this VMA.
+	 * See vmf_insert_mixed() for discussion.
+	 */
+	pgprot_t vm_page_prot;
 	unsigned long vm_flags;		/* Flags, see mm.h. */
 
 	/*
diff --git a/mm/memory.c b/mm/memory.c
index b1ca51a079f2..269a8a871e83 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1646,6 +1646,9 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
  * vmf_insert_pfn_prot should only be used if using multiple VMAs is
  * impractical.
  *
+ * See vmf_insert_mixed_prot() for a discussion of the implication of using
+ * a value of @pgprot different from that of @vma->vm_page_prot.
+ *
  * Context: Process context.  May allocate using %GFP_KERNEL.
  * Return: vm_fault_t value.
  */
@@ -1719,9 +1722,9 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
 }
 
 static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn, bool mkwrite)
+		unsigned long addr, pfn_t pfn, pgprot_t pgprot,
+		bool mkwrite)
 {
-	pgprot_t pgprot = vma->vm_page_prot;
 	int err;
 
 	BUG_ON(!vm_mixed_ok(vma, pfn));
@@ -1764,10 +1767,42 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	return VM_FAULT_NOPAGE;
 }
 
+/**
+ * vmf_insert_mixed_prot - insert single pfn into user vma with specified pgprot
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ * @pgprot: pgprot flags for the inserted page
+ *
+ * This is exactly like vmf_insert_mixed(), except that it allows drivers to
+ * to override pgprot on a per-page basis.
+ *
+ * Typically this function should be used by drivers to set caching- and
+ * encryption bits different than those of @vma->vm_page_prot, because
+ * the caching- or encryption mode may not be known at mmap() time.
+ * This is ok as long as @vma->vm_page_prot is not used by the core vm
+ * to set caching and encryption bits for those vmas (except for COW pages).
+ * This is ensured by core vm only modifying these page table entries using
+ * functions that don't touch caching- or encryption bits, using pte_modify()
+ * if needed. (See for example mprotect()).
+ * Also when new page-table entries are created, this is only done using the
+ * fault() callback, and never using the value of vma->vm_page_prot,
+ * except for page-table entries that point to anonymous pages as the result
+ * of COW.
+ *
+ * Context: Process context.  May allocate using %GFP_KERNEL.
+ * Return: vm_fault_t value.
+ */
+vm_fault_t vmf_insert_mixed_prot(struct vm_area_struct *vma, unsigned long addr,
+				 pfn_t pfn, pgprot_t pgprot)
+{
+	return __vm_insert_mixed(vma, addr, pfn, pgprot, false);
+}
+
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 		pfn_t pfn)
 {
-	return __vm_insert_mixed(vma, addr, pfn, false);
+	return __vm_insert_mixed(vma, addr, pfn, vma->vm_page_prot, false);
 }
 EXPORT_SYMBOL(vmf_insert_mixed);
 
@@ -1779,7 +1814,7 @@ EXPORT_SYMBOL(vmf_insert_mixed);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 		unsigned long addr, pfn_t pfn)
 {
-	return __vm_insert_mixed(vma, addr, pfn, true);
+	return __vm_insert_mixed(vma, addr, pfn, vma->vm_page_prot, true);
 }
 EXPORT_SYMBOL(vmf_insert_mixed_mkwrite);
 
-- 
2.21.0

