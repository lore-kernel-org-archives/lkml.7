Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48AFC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B9620679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfG2XYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 19:24:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:25700 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfG2XYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 19:24:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 16:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,324,1559545200"; 
   d="scan'208";a="346810144"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga005.jf.intel.com with ESMTP; 29 Jul 2019 16:24:30 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     akpm@linux-foundation.org, urezki@gmail.com
Cc:     dave.hansen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 1/1] mm/vmalloc.c: Fix percpu free VM area search criteria
Date:   Mon, 29 Jul 2019 16:21:39 -0700
Message-Id: <20190729232139.91131-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Recent changes to the vmalloc code by Commit 68ad4a330433
("mm/vmalloc.c: keep track of free blocks for vmap allocation") can
cause spurious percpu allocation failures. These, in turn, can result in
panic()s in the slub code. One such possible panic was reported by
Dave Hansen in following link https://lkml.org/lkml/2019/6/19/939.
Another related panic observed is,

 RIP: 0033:0x7f46f7441b9b
 Call Trace:
  dump_stack+0x61/0x80
  pcpu_alloc.cold.30+0x22/0x4f
  mem_cgroup_css_alloc+0x110/0x650
  cgroup_apply_control_enable+0x133/0x330
  cgroup_mkdir+0x41b/0x500
  kernfs_iop_mkdir+0x5a/0x90
  vfs_mkdir+0x102/0x1b0
  do_mkdirat+0x7d/0xf0
  do_syscall_64+0x5b/0x180
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

VMALLOC memory manager divides the entire VMALLOC space (VMALLOC_START
to VMALLOC_END) into multiple VM areas (struct vm_areas), and it mainly
uses two lists (vmap_area_list & free_vmap_area_list) to track the used
and free VM areas in VMALLOC space. And pcpu_get_vm_areas(offsets[],
sizes[], nr_vms, align) function is used for allocating congruent VM
areas for percpu memory allocator. In order to not conflict with VMALLOC
users, pcpu_get_vm_areas allocates VM areas near the end of the VMALLOC
space. So the search for free vm_area for the given requirement starts
near VMALLOC_END and moves upwards towards VMALLOC_START.

Prior to commit 68ad4a330433, the search for free vm_area in
pcpu_get_vm_areas() involves following two main steps.

Step 1:
    Find a aligned "base" adress near VMALLOC_END.
    va = free vm area near VMALLOC_END
Step 2:
    Loop through number of requested vm_areas and check,
        Step 2.1:
           if (base < VMALLOC_START)
              1. fail with error
        Step 2.2:
           // end is offsets[area] + sizes[area]
           if (base + end > va->vm_end)
               1. Move the base downwards and repeat Step 2
        Step 2.3:
           if (base + start < va->vm_start)
              1. Move to previous free vm_area node, find aligned
                 base address and repeat Step 2

But Commit 68ad4a330433 removed Step 2.2 and modified Step 2.3 as below:

        Step 2.3:
           if (base + start < va->vm_start || base + end > va->vm_end)
              1. Move to previous free vm_area node, find aligned
                 base address and repeat Step 2

Above change is the root cause of spurious percpu memory allocation
failures. For example, consider a case where a relatively large vm_area
(~ 30 TB) was ignored in free vm_area search because it did not pass the
base + end  < vm->vm_end boundary check. Ignoring such large free
vm_area's would lead to not finding free vm_area within boundary of
VMALLOC_start to VMALLOC_END which in turn leads to allocation failures.

So modify the search algorithm to include Step 2.2.

Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 mm/vmalloc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4fa8d84599b0..1faa45a38c08 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3269,10 +3269,20 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 		if (va == NULL)
 			goto overflow;
 
+		/*
+		 * If required width exeeds current VA block, move
+		 * base downwards and then recheck.
+		 */
+		if (base + end > va->va_end) {
+			base = pvm_determine_end_from_reverse(&va, align) - end;
+			term_area = area;
+			continue;
+		}
+
 		/*
 		 * If this VA does not fit, move base downwards and recheck.
 		 */
-		if (base + start < va->va_start || base + end > va->va_end) {
+		if (base + start < va->va_start) {
 			va = node_to_va(rb_prev(&va->rb_node));
 			base = pvm_determine_end_from_reverse(&va, align) - end;
 			term_area = area;
-- 
2.21.0

