Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EA0C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9794321849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PQexChhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbfGSTaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:30:10 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12017 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbfGSTaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:30:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d321a3f0000>; Fri, 19 Jul 2019 12:30:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 19 Jul 2019 12:30:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 19 Jul 2019 12:30:07 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Jul
 2019 19:30:03 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 19 Jul 2019 19:30:03 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d321a3b000b>; Fri, 19 Jul 2019 12:30:03 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 1/3] mm: document zone device struct page field usage
Date:   Fri, 19 Jul 2019 12:29:53 -0700
Message-ID: <20190719192955.30462-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719192955.30462-1-rcampbell@nvidia.com>
References: <20190719192955.30462-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563564608; bh=5BzlDT+tWQDH/Xg8OWZLql9VCG1Bt/EFc4+GdPSo8lc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=PQexChhBZx3+OWZZ6A+wrhywrKQby9FhOWY5qduhs3ASzwzTGT5/e+pR4+/0KGzdu
         zc8xUGQTFKV/eGaRb3lqi32sg+IiQX2anYnS2PocFFF5W2OhNynMmfZuXm9iI+f0JL
         WB2FhbKiTQMV/TXeGZcU0LIVz4FwdypJ88fXi61dgUV+Oss+CYgNHRCpRN7u0Vs0op
         50S4AqXNU97o0O36Y4EHqNSij20fLwUfZQ8hH3LzoXyI0+w1dg8aQGg13GvjJQSXXp
         aTksokvD/6cJAU4uRYdMCJe3hyLMENdviYEtmb9w+0e7IrM0fgMbp/3zzRZFk7HtLW
         8KBOIAdX0ZUpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct page for ZONE_DEVICE private pages uses the page->mapping and
and page->index fields while the source anonymous pages are migrated to
device private memory. This is so rmap_walk() can find the page when
migrating the ZONE_DEVICE private page back to system memory.
ZONE_DEVICE pmem backed fsdax pages also use the page->mapping and
page->index fields when files are mapped into a process address space.

Restructure struct page and add comments to make this more clear.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/mm_types.h | 42 +++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3a37a89eb7a7..f6c52e44d40c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -76,13 +76,35 @@ struct page {
 	 * avoid collision and false-positive PageTail().
 	 */
 	union {
-		struct {	/* Page cache and anonymous pages */
-			/**
-			 * @lru: Pageout list, eg. active_list protected by
-			 * pgdat->lru_lock.  Sometimes used as a generic list
-			 * by the page owner.
-			 */
-			struct list_head lru;
+		struct {	/* Page cache, anonymous, ZONE_DEVICE pages */
+			union {
+				/**
+				 * @lru: Pageout list, e.g., active_list
+				 * protected by pgdat->lru_lock. Sometimes
+				 * used as a generic list by the page owner.
+				 */
+				struct list_head lru;
+				/**
+				 * ZONE_DEVICE pages are never on the lru
+				 * list so they reuse the list space.
+				 * ZONE_DEVICE private pages are counted as
+				 * being mapped so the @mapping and @index
+				 * fields are used while the page is migrated
+				 * to device private memory.
+				 * ZONE_DEVICE MEMORY_DEVICE_FS_DAX pages also
+				 * use the @mapping and @index fields when pmem
+				 * backed DAX files are mapped.
+				 */
+				struct {
+					/**
+					 * @pgmap: Points to the hosting
+					 * device page map.
+					 */
+					struct dev_pagemap *pgmap;
+					/** @zone_device_data: opaque data. */
+					void *zone_device_data;
+				};
+			};
 			/* See page-flags.h for PAGE_MAPPING_FLAGS */
 			struct address_space *mapping;
 			pgoff_t index;		/* Our offset within mapping. */
@@ -155,12 +177,6 @@ struct page {
 			spinlock_t ptl;
 #endif
 		};
-		struct {	/* ZONE_DEVICE pages */
-			/** @pgmap: Points to the hosting device page map. */
-			struct dev_pagemap *pgmap;
-			void *zone_device_data;
-			unsigned long _zd_pad_1;	/* uses mapping */
-		};
=20
 		/** @rcu_head: You can use this to free a page by RCU. */
 		struct rcu_head rcu_head;
--=20
2.20.1

