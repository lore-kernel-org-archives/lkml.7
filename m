Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D41C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E500420665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfFYHxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:53:14 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:51793 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbfFYHxK (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 25 Jun 2019 03:53:10 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 25 Jun 2019 09:53:09 +0200
Received: from suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Tue, 25 Jun 2019 08:52:34 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@soleen.com, Jonathan.Cameron@huawei.com,
        david@redhat.com, anshuman.khandual@arm.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 3/5] mm,memory_hotplug: Introduce Vmemmap page helpers
Date:   Tue, 25 Jun 2019 09:52:25 +0200
Message-Id: <20190625075227.15193-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190625075227.15193-1-osalvador@suse.de>
References: <20190625075227.15193-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a set of functions for Vmemmap pages.
Set of functions:

- {Set,Clear,Check} Vmemmap flag
- Given a vmemmap page, get its vmemmap-head
- Get #nr of vmemmap pages taking into account the current position
  of the page

These functions will be used for the code handling Vmemmap pages.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/page-flags.h | 34 ++++++++++++++++++++++++++++++++++
 mm/util.c                  |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b848517da64c..a8b9b57162b3 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -466,6 +466,40 @@ static __always_inline int __PageMovable(struct page *page)
 				PAGE_MAPPING_MOVABLE;
 }
 
+#define VMEMMAP_PAGE		(~PAGE_MAPPING_FLAGS)
+static __always_inline int PageVmemmap(struct page *page)
+{
+	return PageReserved(page) && (unsigned long)page->mapping == VMEMMAP_PAGE;
+}
+
+static __always_inline int __PageVmemmap(struct page *page)
+{
+	return (unsigned long)page->mapping == VMEMMAP_PAGE;
+}
+
+static __always_inline void __ClearPageVmemmap(struct page *page)
+{
+	__ClearPageReserved(page);
+	page->mapping = NULL;
+}
+
+static __always_inline void __SetPageVmemmap(struct page *page)
+{
+	__SetPageReserved(page);
+	page->mapping = (void *)VMEMMAP_PAGE;
+}
+
+static __always_inline struct page *vmemmap_get_head(struct page *page)
+{
+	return (struct page *)page->freelist;
+}
+
+static __always_inline unsigned long get_nr_vmemmap_pages(struct page *page)
+{
+	struct page *head = vmemmap_get_head(page);
+	return head->private - (page - head);
+}
+
 #ifdef CONFIG_KSM
 /*
  * A KSM page is one of those write-protected "shared pages" or "merged pages"
diff --git a/mm/util.c b/mm/util.c
index 021648a8a3a3..5e20563cdef6 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -607,6 +607,8 @@ struct address_space *page_mapping(struct page *page)
 	mapping = page->mapping;
 	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
 		return NULL;
+	if ((unsigned long)mapping == VMEMMAP_PAGE)
+		return NULL;
 
 	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
 }
-- 
2.12.3

