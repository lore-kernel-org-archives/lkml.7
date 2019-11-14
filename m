Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED08C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B7B206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfKNAVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:21:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:16860 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfKNAVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:21:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 16:21:38 -0800
X-IronPort-AV: E=Sophos;i="5.68,302,1569308400"; 
   d="scan'208";a="198632833"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 16:21:38 -0800
Subject: [PATCH] mm: Cleanup __put_devmap_managed_page() vs ->page_free()
From:   Dan Williams <dan.j.williams@intel.com>
To:     jhubbard@nvidia.com
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Ira Weiny <ira.weiny@intel.com>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Wed, 13 Nov 2019 16:07:22 -0800
Message-ID: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the removal of the device-public infrastructure there are only 2
->page_free() call backs in the kernel. One of those is a device-private
callback in the nouveau driver, the other is a generic wakeup needed in
the DAX case. In the hopes that all ->page_free() callbacks can be
migrated to common core kernel functionality, move the device-private
specific actions in __put_devmap_managed_page() under the
is_device_private_page() conditional, including the ->page_free()
callback. For the other page types just open-code the generic wakeup.

Yes, the wakeup is only needed in the MEMORY_DEVICE_FSDAX case, but it
does no harm in the MEMORY_DEVICE_DEVDAX and MEMORY_DEVICE_PCI_P2PDMA
case.

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hi John,

This applies on top of today's linux-next and passes my nvdimm unit
tests. That testing noticed that devmap_managed_enable_get() needed a
small fixup as well.

 drivers/nvdimm/pmem.c |    6 ------
 mm/memremap.c         |   22 ++++++++++++----------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index f9f76f6ba07b..21db1ce8c0ae 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -338,13 +338,7 @@ static void pmem_release_disk(void *__pmem)
 	put_disk(pmem->disk);
 }
 
-static void pmem_pagemap_page_free(struct page *page)
-{
-	wake_up_var(&page->_refcount);
-}
-
 static const struct dev_pagemap_ops fsdax_pagemap_ops = {
-	.page_free		= pmem_pagemap_page_free,
 	.kill			= pmem_pagemap_kill,
 	.cleanup		= pmem_pagemap_cleanup,
 };
diff --git a/mm/memremap.c b/mm/memremap.c
index 022e78e68ea0..6e6f3d6fdb73 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -27,7 +27,8 @@ static void devmap_managed_enable_put(void)
 
 static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
 {
-	if (!pgmap->ops || !pgmap->ops->page_free) {
+	if (!pgmap->ops || (pgmap->type == MEMORY_DEVICE_PRIVATE
+				&& !pgmap->ops->page_free)) {
 		WARN(1, "Missing page_free method\n");
 		return -EINVAL;
 	}
@@ -449,12 +450,6 @@ void __put_devmap_managed_page(struct page *page)
 	 * holds a reference on the page.
 	 */
 	if (count == 1) {
-		/* Clear Active bit in case of parallel mark_page_accessed */
-		__ClearPageActive(page);
-		__ClearPageWaiters(page);
-
-		mem_cgroup_uncharge(page);
-
 		/*
 		 * When a device_private page is freed, the page->mapping field
 		 * may still contain a (stale) mapping value. For example, the
@@ -476,10 +471,17 @@ void __put_devmap_managed_page(struct page *page)
 		 * handled differently or not done at all, so there is no need
 		 * to clear page->mapping.
 		 */
-		if (is_device_private_page(page))
-			page->mapping = NULL;
+		if (is_device_private_page(page)) {
+			/* Clear Active bit in case of parallel mark_page_accessed */
+			__ClearPageActive(page);
+			__ClearPageWaiters(page);
 
-		page->pgmap->ops->page_free(page);
+			mem_cgroup_uncharge(page);
+
+			page->mapping = NULL;
+			page->pgmap->ops->page_free(page);
+		} else
+			wake_up_var(&page->_refcount);
 	} else if (!count)
 		__put_page(page);
 }

