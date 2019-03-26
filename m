Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5076DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DF820830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfCZJCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:02:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfCZJCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:02:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0B9C89C31;
        Tue, 26 Mar 2019 09:02:48 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46BBC8387A;
        Tue, 26 Mar 2019 09:02:43 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        rppt@linux.ibm.com, osalvador@suse.de, willy@infradead.org,
        william.kucharski@oracle.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 3/4] mm/sparse: Rename function related to section memmap allocation/free
Date:   Tue, 26 Mar 2019 17:02:26 +0800
Message-Id: <20190326090227.3059-4-bhe@redhat.com>
In-Reply-To: <20190326090227.3059-1-bhe@redhat.com>
References: <20190326090227.3059-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 26 Mar 2019 09:02:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are used to allocate/free section memmap, have nothing
to do with kmalloc/free during the handling. Rename them to remove
the confusion.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/sparse.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index f4f34d69131e..68a89d133fa7 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -590,13 +590,13 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-static inline struct page *kmalloc_section_memmap(unsigned long pnum, int nid,
+static inline struct page *alloc_section_memmap(unsigned long pnum, int nid,
 		struct vmem_altmap *altmap)
 {
 	/* This will make the necessary allocations eventually. */
 	return sparse_mem_map_populate(pnum, nid, altmap);
 }
-static void __kfree_section_memmap(struct page *memmap,
+static void __free_section_memmap(struct page *memmap,
 		struct vmem_altmap *altmap)
 {
 	unsigned long start = (unsigned long)memmap;
@@ -614,7 +614,7 @@ static void free_map_bootmem(struct page *memmap)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 #else
-static struct page *__kmalloc_section_memmap(void)
+static struct page *__alloc_section_memmap(void)
 {
 	struct page *page, *ret;
 	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
@@ -635,13 +635,13 @@ static struct page *__kmalloc_section_memmap(void)
 	return ret;
 }
 
-static inline struct page *kmalloc_section_memmap(unsigned long pnum, int nid,
+static inline struct page *alloc_section_memmap(unsigned long pnum, int nid,
 		struct vmem_altmap *altmap)
 {
-	return __kmalloc_section_memmap();
+	return __alloc_section_memmap();
 }
 
-static void __kfree_section_memmap(struct page *memmap,
+static void __free_section_memmap(struct page *memmap,
 		struct vmem_altmap *altmap)
 {
 	if (is_vmalloc_addr(memmap))
@@ -722,7 +722,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 	usemap = __kmalloc_section_usemap();
 	if (!usemap)
 		return -ENOMEM;
-	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
+	memmap = alloc_section_memmap(section_nr, nid, altmap);
 	if (!memmap) {
 		kfree(usemap);
 		return  -ENOMEM;
@@ -786,7 +786,7 @@ static void free_section_usemap(struct page *memmap, unsigned long *usemap,
 	if (PageSlab(usemap_page) || PageCompound(usemap_page)) {
 		kfree(usemap);
 		if (memmap)
-			__kfree_section_memmap(memmap, altmap);
+			__free_section_memmap(memmap, altmap);
 		return;
 	}
 
-- 
2.17.2

