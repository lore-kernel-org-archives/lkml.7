Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F94CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 07:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C892206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 07:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfI2Htj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 03:49:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:8411 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfI2Hti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 03:49:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2019 00:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,562,1559545200"; 
   d="scan'208";a="193826523"
Received: from zhangjun-desktop.sh.intel.com ([10.239.154.83])
  by orsmga003.jf.intel.com with ESMTP; 29 Sep 2019 00:49:28 -0700
From:   jun.zhang@intel.com
To:     labbott@redhat.com, sumit.semwal@linaro.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io
Cc:     devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        zhang jun <jun.zhang@intel.com>, he@vger.kernel.org,
        bo <bo.he@intel.com>, Bai@vger.kernel.org,
        Jie A <jie.a.bai@intel.com>
Subject: [PATCH] ion_system_heap: support X86 archtecture
Date:   Sun, 29 Sep 2019 15:28:41 +0800
Message-Id: <20190929072841.14848-1-jun.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang jun <jun.zhang@intel.com>

we see tons of warning like:
[   45.846872] x86/PAT: NDK MediaCodec_:3753 map pfn RAM range req
write-combining for [mem 0x1e7a80000-0x1e7a87fff], got write-back
[   45.848827] x86/PAT: .vorbis.decoder:4088 map pfn RAM range req
write-combining for [mem 0x1e7a58000-0x1e7a58fff], got write-back
[   45.848875] x86/PAT: NDK MediaCodec_:3753 map pfn RAM range req
write-combining for [mem 0x1e7a48000-0x1e7a4ffff], got write-back
[   45.849403] x86/PAT: .vorbis.decoder:4088 map pfn RAM range
req write-combining for [mem 0x1e7a70000-0x1e7a70fff], got write-back

check the kernel Documentation/x86/pat.txt, it says:
A. Exporting pages to users with remap_pfn_range, io_remap_pfn_range,
vm_insert_pfn
Drivers wanting to export some pages to userspace do it by using
mmap interface and a combination of
1) pgprot_noncached()
2) io_remap_pfn_range() or remap_pfn_range() or vm_insert_pfn()
With PAT support, a new API pgprot_writecombine is being added.
So, drivers can continue to use the above sequence, with either
pgprot_noncached() or pgprot_writecombine() in step 1, followed by step 2.

In addition, step 2 internally tracks the region as UC or WC in
memtype list in order to ensure no conflicting mapping.

Note that this set of APIs only works with IO (non RAM) regions.
If driver ants to export a RAM region, it has to do set_memory_uc() or
set_memory_wc() as step 0 above and also track the usage of those pages
and use set_memory_wb() before the page is freed to free pool.

the fix follow the pat document, do set_memory_wc() as step 0 and
use the set_memory_wb() before the page is freed.

Signed-off-by: he, bo <bo.he@intel.com>
Signed-off-by: zhang jun <jun.zhang@intel.com>
Signed-off-by: Bai, Jie A <jie.a.bai@intel.com>
---
 drivers/staging/android/ion/ion_system_heap.c | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index b83a1d16bd89..d298b8194820 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -13,6 +13,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <asm/set_memory.h>
 
 #include "ion.h"
 
@@ -134,6 +135,13 @@ static int ion_system_heap_allocate(struct ion_heap *heap,
 	sg = table->sgl;
 	list_for_each_entry_safe(page, tmp_page, &pages, lru) {
 		sg_set_page(sg, page, page_size(page), 0);
+
+#ifdef CONFIG_X86
+	if (!(buffer->flags & ION_FLAG_CACHED))
+		set_memory_wc((unsigned long)page_address(sg_page(sg)),
+			      PAGE_ALIGN(sg->length) >> PAGE_SHIFT);
+#endif
+
 		sg = sg_next(sg);
 		list_del(&page->lru);
 	}
@@ -162,8 +170,15 @@ static void ion_system_heap_free(struct ion_buffer *buffer)
 	if (!(buffer->private_flags & ION_PRIV_FLAG_SHRINKER_FREE))
 		ion_heap_buffer_zero(buffer);
 
-	for_each_sg(table->sgl, sg, table->nents, i)
+	for_each_sg(table->sgl, sg, table->nents, i) {
+#ifdef CONFIG_X86
+		if (!(buffer->flags & ION_FLAG_CACHED))
+			set_memory_wb((unsigned long)page_address(sg_page(sg)),
+				      PAGE_ALIGN(sg->length) >> PAGE_SHIFT);
+#endif
+
 		free_buffer_page(sys_heap, buffer, sg_page(sg));
+	}
 	sg_free_table(table);
 	kfree(table);
 }
@@ -316,6 +331,12 @@ static int ion_system_contig_heap_allocate(struct ion_heap *heap,
 
 	buffer->sg_table = table;
 
+#ifdef CONFIG_X86
+	if (!(buffer->flags & ION_FLAG_CACHED))
+		set_memory_wc((unsigned long)page_address(page),
+			      PAGE_ALIGN(len) >> PAGE_SHIFT);
+#endif
+
 	return 0;
 
 free_table:
@@ -334,6 +355,11 @@ static void ion_system_contig_heap_free(struct ion_buffer *buffer)
 	unsigned long pages = PAGE_ALIGN(buffer->size) >> PAGE_SHIFT;
 	unsigned long i;
 
+#ifdef CONFIG_X86
+	if (!(buffer->flags & ION_FLAG_CACHED))
+		set_memory_wb((unsigned long)page_address(page), pages);
+#endif
+
 	for (i = 0; i < pages; i++)
 		__free_page(page + i);
 	sg_free_table(table);
-- 
2.17.1

