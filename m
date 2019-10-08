Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464CBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14492206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="Mu5RKinx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfJHJPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:15:45 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:52906 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbfJHJPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:15:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id A2D6E3F503;
        Tue,  8 Oct 2019 11:15:22 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Mu5RKinx;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mp64gV4EXqLH; Tue,  8 Oct 2019 11:15:19 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 1C3EE3F38D;
        Tue,  8 Oct 2019 11:15:18 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id CDE823605F2;
        Tue,  8 Oct 2019 11:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570526117; bh=hXvP5dhzYv9KPG1BwBx+8Jo6RS1I+93ap3Ix3m9ksOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mu5RKinxG23wx3lTcOpOtj9Yex7ZImSrlt+2kdvrGQFoMVCS47zpt961XJVt8PdCe
         VII72n4oDv85MUhYMonDb8uXPoy3GJwRZOLjVFZVu2Ml8FsTIjFa/hZOsYkw7z8BjK
         k79XWzkeBleFeq+3Dp+Qt9xX6iyOIJKxooLGs/+0=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v4 4/9] mm: Add a walk_page_mapping() function to the pagewalk code
Date:   Tue,  8 Oct 2019 11:15:03 +0200
Message-Id: <20191008091508.2682-5-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008091508.2682-1-thomas_os@shipmail.org>
References: <20191008091508.2682-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

For users that want to travers all page table entries pointing into a
region of a struct address_space mapping, introduce a walk_page_mapping()
function.

The walk_page_mapping() function will be initially be used for dirty-
tracking in virtual graphics drivers.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 include/linux/pagewalk.h |  9 ++++
 mm/pagewalk.c            | 94 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index c4a013eb445d..9b2742911eff 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -32,6 +32,9 @@ struct mm_walk;
  *			"do page table walk over the current vma", returning
  *			a negative value means "abort current page table walk
  *			right now" and returning 1 means "skip the current vma"
+ * @pre_vma:            if set, called before starting walk on a non-null vma.
+ * @post_vma:           if set, called after a walk on a non-null vma, provided
+ *                      that @pre_vma and the vma walk succeeded.
  */
 struct mm_walk_ops {
 	int (*pud_entry)(pud_t *pud, unsigned long addr,
@@ -47,6 +50,9 @@ struct mm_walk_ops {
 			     struct mm_walk *walk);
 	int (*test_walk)(unsigned long addr, unsigned long next,
 			struct mm_walk *walk);
+	int (*pre_vma)(unsigned long start, unsigned long end,
+		       struct mm_walk *walk);
+	void (*post_vma)(struct mm_walk *walk);
 };
 
 /**
@@ -70,5 +76,8 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 		void *private);
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		void *private);
+int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
+		      pgoff_t nr, const struct mm_walk_ops *ops,
+		      void *private);
 
 #endif /* _LINUX_PAGEWALK_H */
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index f844c2a2aa60..8de4574e7753 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -262,13 +262,23 @@ static int __walk_page_range(unsigned long start, unsigned long end,
 {
 	int err = 0;
 	struct vm_area_struct *vma = walk->vma;
+	const struct mm_walk_ops *ops = walk->ops;
+
+	if (vma && ops->pre_vma) {
+		err = ops->pre_vma(start, end, walk);
+		if (err)
+			return err;
+	}
 
 	if (vma && is_vm_hugetlb_page(vma)) {
-		if (walk->ops->hugetlb_entry)
+		if (ops->hugetlb_entry)
 			err = walk_hugetlb_range(start, end, walk);
 	} else
 		err = walk_pgd_range(start, end, walk);
 
+	if (vma && ops->post_vma)
+		ops->post_vma(walk);
+
 	return err;
 }
 
@@ -305,6 +315,11 @@ static int __walk_page_range(unsigned long start, unsigned long end,
  * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
  * purpose.
  *
+ * If operations need to be staged before and committed after a vma is walked,
+ * there are two callbacks, pre_vma() and post_vma(). Note that post_vma(),
+ * since it is intended to handle commit-type operations, can't return any
+ * errors.
+ *
  * struct mm_walk keeps current values of some common data like vma and pmd,
  * which are useful for the access from callbacks. If you want to pass some
  * caller-specific data to callbacks, @private should be helpful.
@@ -391,3 +406,80 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		return err;
 	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
 }
+
+/**
+ * walk_page_mapping - walk all memory areas mapped into a struct address_space.
+ * @mapping: Pointer to the struct address_space
+ * @first_index: First page offset in the address_space
+ * @nr: Number of incremental page offsets to cover
+ * @ops:	operation to call during the walk
+ * @private:	private data for callbacks' usage
+ *
+ * This function walks all memory areas mapped into a struct address_space.
+ * The walk is limited to only the given page-size index range, but if
+ * the index boundaries cross a huge page-table entry, that entry will be
+ * included.
+ *
+ * Also see walk_page_range() for additional information.
+ *
+ * Locking:
+ *   This function can't require that the struct mm_struct::mmap_sem is held,
+ *   since @mapping may be mapped by multiple processes. Instead
+ *   @mapping->i_mmap_rwsem must be held. This might have implications in the
+ *   callbacks, and it's up tho the caller to ensure that the
+ *   struct mm_struct::mmap_sem is not needed.
+ *
+ *   Also this means that a caller can't rely on the struct
+ *   vm_area_struct::vm_flags to be constant across a call,
+ *   except for immutable flags. Callers requiring this shouldn't use
+ *   this function.
+ *
+ * Return: 0 on success, negative error code on failure, positive number on
+ * caller defined premature termination.
+ */
+int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
+		      pgoff_t nr, const struct mm_walk_ops *ops,
+		      void *private)
+{
+	struct mm_walk walk = {
+		.ops		= ops,
+		.private	= private,
+	};
+	struct vm_area_struct *vma;
+	pgoff_t vba, vea, cba, cea;
+	unsigned long start_addr, end_addr;
+	int err = 0;
+
+	lockdep_assert_held(&mapping->i_mmap_rwsem);
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
+				  first_index + nr - 1) {
+		/* Clip to the vma */
+		vba = vma->vm_pgoff;
+		vea = vba + vma_pages(vma);
+		cba = first_index;
+		cba = max(cba, vba);
+		cea = first_index + nr;
+		cea = min(cea, vea);
+
+		start_addr = ((cba - vba) << PAGE_SHIFT) + vma->vm_start;
+		end_addr = ((cea - vba) << PAGE_SHIFT) + vma->vm_start;
+		if (start_addr >= end_addr)
+			continue;
+
+		walk.vma = vma;
+		walk.mm = vma->vm_mm;
+
+		err = walk_page_test(vma->vm_start, vma->vm_end, &walk);
+		if (err > 0) {
+			err = 0;
+			break;
+		} else if (err < 0)
+			break;
+
+		err = __walk_page_range(start_addr, end_addr, &walk);
+		if (err)
+			break;
+	}
+
+	return err;
+}
-- 
2.21.0

