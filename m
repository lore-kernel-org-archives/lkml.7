Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D26C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 23:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4442084F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 23:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nS5cBo7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfENXvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 19:51:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47404 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbfENXvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 19:51:18 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4ENhWmv001629
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 16:51:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=O7eBrs0cmRrFsnBiCjlPOjGDWGcxOa5jMCEdxURKIS8=;
 b=nS5cBo7ZXbIbW8vKlx1+2CYmEYbH/oukpPAEDPubpR6q6i6Kmz3pt45EkxkZ7GSqbzZu
 P8S1VqFOtaBkglV9zxTsxNw/5rFS0/BS6JglBD+487wPVRGDPfweYpl1cbATdH47RDSn
 PwPBysBeuv/hXDcbOdZ1G0FUwCEP1g+e2jw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sg3k1gvtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 16:51:17 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 14 May 2019 16:51:16 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id E085912084F48; Tue, 14 May 2019 16:51:15 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] mm: refactor __vunmap() to avoid duplicated call to find_vm_area()
Date:   Tue, 14 May 2019 16:51:10 -0700
Message-ID: <20190514235111.2817276-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__vunmap() calls find_vm_area() twice without an obvious reason:
first directly to get the area pointer, second indirectly by calling
vm_remove_mappings()->remove_vm_area(), which is again searching
for the area.

To remove this redundancy, let's split remove_vm_area() into
__remove_vm_area(struct vmap_area *), which performs the actual area
removal, and remove_vm_area(const void *addr) wrapper, which can
be used everywhere, where it has been used before. Let's pass
a pointer to the vm_area instead of vm_struct to vm_remove_mappings(),
so it can pass it to __remove_vm_area() and avoid the redundant area
lookup.

On my test setup, I've got 5-10% speed up on vfree()'ing 1000000
of 4-pages vmalloc blocks.

Perf report before:
  29.44%  cat      [kernel.kallsyms]  [k] free_unref_page
  11.88%  cat      [kernel.kallsyms]  [k] find_vmap_area
   9.28%  cat      [kernel.kallsyms]  [k] __free_pages
   7.44%  cat      [kernel.kallsyms]  [k] __slab_free
   7.28%  cat      [kernel.kallsyms]  [k] vunmap_page_range
   4.56%  cat      [kernel.kallsyms]  [k] __vunmap
   3.64%  cat      [kernel.kallsyms]  [k] __purge_vmap_area_lazy
   3.04%  cat      [kernel.kallsyms]  [k] __free_vmap_area

Perf report after:
  32.41%  cat      [kernel.kallsyms]  [k] free_unref_page
   7.79%  cat      [kernel.kallsyms]  [k] find_vmap_area
   7.40%  cat      [kernel.kallsyms]  [k] __slab_free
   7.31%  cat      [kernel.kallsyms]  [k] vunmap_page_range
   6.84%  cat      [kernel.kallsyms]  [k] __free_pages
   6.01%  cat      [kernel.kallsyms]  [k] __vunmap
   3.98%  cat      [kernel.kallsyms]  [k] smp_call_function_single
   3.81%  cat      [kernel.kallsyms]  [k] __purge_vmap_area_lazy
   2.77%  cat      [kernel.kallsyms]  [k] __free_vmap_area

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
 mm/vmalloc.c | 52 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c42872ed82ac..8d4907865614 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2075,6 +2075,22 @@ struct vm_struct *find_vm_area(const void *addr)
 	return NULL;
 }
 
+static struct vm_struct *__remove_vm_area(struct vmap_area *va)
+{
+	struct vm_struct *vm = va->vm;
+
+	spin_lock(&vmap_area_lock);
+	va->vm = NULL;
+	va->flags &= ~VM_VM_AREA;
+	va->flags |= VM_LAZY_FREE;
+	spin_unlock(&vmap_area_lock);
+
+	kasan_free_shadow(vm);
+	free_unmap_vmap_area(va);
+
+	return vm;
+}
+
 /**
  * remove_vm_area - find and remove a continuous kernel virtual area
  * @addr:	    base address
@@ -2087,26 +2103,14 @@ struct vm_struct *find_vm_area(const void *addr)
  */
 struct vm_struct *remove_vm_area(const void *addr)
 {
+	struct vm_struct *vm = NULL;
 	struct vmap_area *va;
 
-	might_sleep();
-
 	va = find_vmap_area((unsigned long)addr);
-	if (va && va->flags & VM_VM_AREA) {
-		struct vm_struct *vm = va->vm;
-
-		spin_lock(&vmap_area_lock);
-		va->vm = NULL;
-		va->flags &= ~VM_VM_AREA;
-		va->flags |= VM_LAZY_FREE;
-		spin_unlock(&vmap_area_lock);
-
-		kasan_free_shadow(vm);
-		free_unmap_vmap_area(va);
+	if (va && va->flags & VM_VM_AREA)
+		vm = __remove_vm_area(va);
 
-		return vm;
-	}
-	return NULL;
+	return vm;
 }
 
 static inline void set_area_direct_map(const struct vm_struct *area,
@@ -2119,9 +2123,10 @@ static inline void set_area_direct_map(const struct vm_struct *area,
 			set_direct_map(area->pages[i]);
 }
 
-/* Handle removing and resetting vm mappings related to the vm_struct. */
-static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
+/* Handle removing and resetting vm mappings related to the va->vm vm_struct. */
+static void vm_remove_mappings(struct vmap_area *va, int deallocate_pages)
 {
+	struct vm_struct *area = va->vm;
 	unsigned long addr = (unsigned long)area->addr;
 	unsigned long start = ULONG_MAX, end = 0;
 	int flush_reset = area->flags & VM_FLUSH_RESET_PERMS;
@@ -2138,7 +2143,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 		set_memory_rw(addr, area->nr_pages);
 	}
 
-	remove_vm_area(area->addr);
+	__remove_vm_area(va);
 
 	/* If this is not VM_FLUSH_RESET_PERMS memory, no need for the below. */
 	if (!flush_reset)
@@ -2178,6 +2183,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 static void __vunmap(const void *addr, int deallocate_pages)
 {
 	struct vm_struct *area;
+	struct vmap_area *va;
 
 	if (!addr)
 		return;
@@ -2186,17 +2192,18 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			addr))
 		return;
 
-	area = find_vm_area(addr);
-	if (unlikely(!area)) {
+	va = find_vmap_area((unsigned long)addr);
+	if (unlikely(!va || !(va->flags & VM_VM_AREA))) {
 		WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
 				addr);
 		return;
 	}
 
+	area = va->vm;
 	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
 	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
 
-	vm_remove_mappings(area, deallocate_pages);
+	vm_remove_mappings(va, deallocate_pages);
 
 	if (deallocate_pages) {
 		int i;
@@ -2212,7 +2219,6 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	}
 
 	kfree(area);
-	return;
 }
 
 static inline void __vfree_deferred(const void *addr)
-- 
2.20.1

