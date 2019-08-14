Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0B9C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626A32084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfHNCSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:18:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:54536 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbfHNCSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:18:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 19:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="205293131"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2019 19:18:19 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, osalvador@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 1/3] mm/mmap.c: prev could be retrieved from vma->vm_prev
Date:   Wed, 14 Aug 2019 10:17:53 +0800
Message-Id: <20190814021755.1977-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently __vma_unlink_common handles two cases:

  * has_prev
  * or not

When has_prev is false, it is obvious prev is calculated from
vma->vm_prev in __vma_unlink_common.

When has_prev is true, the prev is passed through from __vma_unlink_prev
in __vma_adjust for non-case 8. And at the beginning next is calculated
from vma->vm_next, which implies vma is next->vm_prev.

The above statement sounds a little complicated, while to think in
another point of view, no matter whether vma and next is swapped, the
mmap link list still preserves its property. It is proper to access
vma->vm_prev.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/mmap.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b8072630766f..3d56340fea36 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -675,23 +675,17 @@ static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 
 static __always_inline void __vma_unlink_common(struct mm_struct *mm,
 						struct vm_area_struct *vma,
-						struct vm_area_struct *prev,
-						bool has_prev,
 						struct vm_area_struct *ignore)
 {
-	struct vm_area_struct *next;
+	struct vm_area_struct *prev, *next;
 
 	vma_rb_erase_ignore(vma, &mm->mm_rb, ignore);
 	next = vma->vm_next;
-	if (has_prev)
+	prev = vma->vm_prev;
+	if (prev)
 		prev->vm_next = next;
-	else {
-		prev = vma->vm_prev;
-		if (prev)
-			prev->vm_next = next;
-		else
-			mm->mmap = next;
-	}
+	else
+		mm->mmap = next;
 	if (next)
 		next->vm_prev = prev;
 
@@ -703,7 +697,7 @@ static inline void __vma_unlink_prev(struct mm_struct *mm,
 				     struct vm_area_struct *vma,
 				     struct vm_area_struct *prev)
 {
-	__vma_unlink_common(mm, vma, prev, true, vma);
+	__vma_unlink_common(mm, vma, vma);
 }
 
 /*
@@ -891,7 +885,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			 * "next" (which is stored in post-swap()
 			 * "vma").
 			 */
-			__vma_unlink_common(mm, next, NULL, false, vma);
+			__vma_unlink_common(mm, next, vma);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
-- 
2.17.1

