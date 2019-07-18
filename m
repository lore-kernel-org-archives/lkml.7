Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5DBC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB722173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390331AbfGRDG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:06:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:49738 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390322AbfGRDGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:06:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 20:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,276,1559545200"; 
   d="scan'208";a="175892069"
Received: from devel-ww.sh.intel.com ([10.239.48.128])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2019 20:06:49 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, mst@redhat.com, xdeguillard@vmware.com,
        namit@vmware.com
Cc:     akpm@linux-foundation.org, pagupta@redhat.com, riel@surriel.com,
        dave.hansen@intel.com, david@redhat.com, konrad.wilk@oracle.com,
        yang.zhang.wz@gmail.com, nitesh@redhat.com, lcapitulino@redhat.com,
        aarcange@redhat.com, pbonzini@redhat.com,
        alexander.h.duyck@linux.intel.com, dan.j.williams@intel.com
Subject: [PATCH v1] mm/balloon_compaction: avoid duplicate page removal
Date:   Thu, 18 Jul 2019 10:23:30 +0800
Message-Id: <1563416610-11045-1-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 418a3ab1e778 (mm/balloon_compaction: List interfaces)

A #GP is reported in the guest when requesting balloon inflation via
virtio-balloon. The reason is that the virtio-balloon driver has
removed the page from its internal page list (via balloon_page_pop),
but balloon_page_enqueue_one also calls "list_del"  to do the removal.
So remove the list_del in balloon_page_enqueue_one, and have the callers
do the page removal from their own page lists.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 mm/balloon_compaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 83a7b61..1a5ddc4 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/balloon_compaction.h>
 
+/* Callers ensure that @page has been removed from its original list. */
 static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
 				     struct page *page)
 {
@@ -21,7 +22,6 @@ static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
 	 * memory corruption is possible and we should stop execution.
 	 */
 	BUG_ON(!trylock_page(page));
-	list_del(&page->lru);
 	balloon_page_insert(b_dev_info, page);
 	unlock_page(page);
 	__count_vm_event(BALLOON_INFLATE);
@@ -47,6 +47,7 @@ size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
 
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	list_for_each_entry_safe(page, tmp, pages, lru) {
+		list_del(&page->lru);
 		balloon_page_enqueue_one(b_dev_info, page);
 		n_pages++;
 	}
-- 
2.7.4

