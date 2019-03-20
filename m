Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFE2C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082E4218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCTPXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:23:47 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:12321 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726595AbfCTPXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:23:46 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 20 Mar 2019 08:23:40 -0700
Received: from fedoratest.localdomain (unknown [10.30.24.114])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id D58B94199D;
        Wed, 20 Mar 2019 08:23:41 -0700 (PDT)
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/3] mm: Allow the [page|pfn]_mkwrite callbacks to drop the mmap_sem
Date:   Wed, 20 Mar 2019 16:23:13 +0100
Message-ID: <20190320152315.82758-2-thellstrom@vmware.com>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20190320152315.82758-1-thellstrom@vmware.com>
References: <20190320152315.82758-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (EX13-EDG-OU-002.vmware.com: thellstrom@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver fault callbacks are allowed to drop the mmap_sem when expecting
long hardware waits to avoid blocking other mm users. Allow the mkwrite
callbacks to do the same by returning early on VM_FAULT_RETRY.

In particular we want to be able to drop the mmap_sem when waiting for
a reservation object lock on a GPU buffer object. These locks may be
held while waiting for the GPU.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 mm/memory.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a52663c0612d..dcd80313cf10 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2144,7 +2144,7 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
 	ret = vmf->vma->vm_ops->page_mkwrite(vmf);
 	/* Restore original flags so that caller is not surprised */
 	vmf->flags = old_flags;
-	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
+	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_RETRY | VM_FAULT_NOPAGE)))
 		return ret;
 	if (unlikely(!(ret & VM_FAULT_LOCKED))) {
 		lock_page(page);
@@ -2419,7 +2419,7 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		vmf->flags |= FAULT_FLAG_MKWRITE;
 		ret = vma->vm_ops->pfn_mkwrite(vmf);
-		if (ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE))
+		if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY | VM_FAULT_NOPAGE))
 			return ret;
 		return finish_mkwrite_fault(vmf);
 	}
@@ -2440,7 +2440,8 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		tmp = do_page_mkwrite(vmf);
 		if (unlikely(!tmp || (tmp &
-				      (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
+				      (VM_FAULT_ERROR | VM_FAULT_RETRY |
+				       VM_FAULT_NOPAGE)))) {
 			put_page(vmf->page);
 			return tmp;
 		}
@@ -3472,7 +3473,8 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 		unlock_page(vmf->page);
 		tmp = do_page_mkwrite(vmf);
 		if (unlikely(!tmp ||
-				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
+				(tmp & (VM_FAULT_ERROR | VM_FAULT_RETRY |
+					VM_FAULT_NOPAGE)))) {
 			put_page(vmf->page);
 			return tmp;
 		}
-- 
2.19.0.rc1

