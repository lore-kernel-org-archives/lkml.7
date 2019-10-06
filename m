Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F85C4740A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 01:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E55B222D3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 01:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfJFBb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 21:31:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:59618 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfJFBbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 21:31:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2019 18:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,261,1566889200"; 
   d="scan'208";a="217534714"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga004.fm.intel.com with ESMTP; 05 Oct 2019 18:31:54 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, osalvador@suse.de, hch@infradead.org,
        willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2 3/3] mm/mmap.c: extract __vma_unlink_list as counter part for __vma_link_list
Date:   Sun,  6 Oct 2019 09:26:36 +0800
Message-Id: <20191006012636.31521-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191006012636.31521-1-richardw.yang@linux.intel.com>
References: <20191006012636.31521-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just make the code a little easy to read.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
Note: For nommu part, the code is not tested.

---
v2: rebase on top of 5.4-rc1
---
 mm/internal.h |  1 +
 mm/mmap.c     | 12 +-----------
 mm/nommu.c    |  8 +-------
 mm/util.c     | 14 ++++++++++++++
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 8e596fa8a7de..f93fd474dac3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -291,6 +291,7 @@ static inline bool is_data_mapping(vm_flags_t flags)
 /* mm/util.c */
 void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct vm_area_struct *prev);
+void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
 
 #ifdef CONFIG_MMU
 extern long populate_vma_page_range(struct vm_area_struct *vma,
diff --git a/mm/mmap.c b/mm/mmap.c
index 2ca805209c47..3ab5d20289be 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -686,18 +686,8 @@ static __always_inline void __vma_unlink_common(struct mm_struct *mm,
 						struct vm_area_struct *vma,
 						struct vm_area_struct *ignore)
 {
-	struct vm_area_struct *prev, *next;
-
 	vma_rb_erase_ignore(vma, &mm->mm_rb, ignore);
-	next = vma->vm_next;
-	prev = vma->vm_prev;
-	if (prev)
-		prev->vm_next = next;
-	else
-		mm->mmap = next;
-	if (next)
-		next->vm_prev = prev;
-
+	__vma_unlink_list(mm, vma);
 	/* Kill the cache */
 	vmacache_invalidate(mm);
 }
diff --git a/mm/nommu.c b/mm/nommu.c
index 2bb923210128..21ddf689d4fa 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -673,13 +673,7 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
 	/* remove from the MM's tree and list */
 	rb_erase(&vma->vm_rb, &mm->mm_rb);
 
-	if (vma->vm_prev)
-		vma->vm_prev->vm_next = vma->vm_next;
-	else
-		mm->mmap = vma->vm_next;
-
-	if (vma->vm_next)
-		vma->vm_next->vm_prev = vma->vm_prev;
+	__vma_unlink_list(mm, vma);
 }
 
 /*
diff --git a/mm/util.c b/mm/util.c
index 023defd39a0d..988d11e6c17c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -288,6 +288,20 @@ void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 		next->vm_prev = vma;
 }
 
+void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	struct vm_area_struct *prev, *next;
+
+	next = vma->vm_next;
+	prev = vma->vm_prev;
+	if (prev)
+		prev->vm_next = next;
+	else
+		mm->mmap = next;
+	if (next)
+		next->vm_prev = prev;
+}
+
 /* Check if the vma is being used as a stack by this task */
 int vma_is_stack_for_current(struct vm_area_struct *vma)
 {
-- 
2.17.1

