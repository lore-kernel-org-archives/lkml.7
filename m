Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCDCC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8409A2189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kuNrmdut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbfGXX1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:27:15 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15286 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbfGXX1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:27:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d38e9520000>; Wed, 24 Jul 2019 16:27:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 24 Jul 2019 16:27:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 24 Jul 2019 16:27:13 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jul
 2019 23:27:08 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 24 Jul 2019 23:27:08 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d38e94b0000>; Wed, 24 Jul 2019 16:27:07 -0700
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
Subject: [PATCH v3 1/3] mm: document zone device struct page field usage
Date:   Wed, 24 Jul 2019 16:26:58 -0700
Message-ID: <20190724232700.23327-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724232700.23327-1-rcampbell@nvidia.com>
References: <20190724232700.23327-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564010834; bh=R7tBXQO9rPgjXDqjGz3N+EME0mRb0btVdpzxMZ8l/ZM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=kuNrmdutQu8OtJz0LkyZEgZtbgpSB31azxVA6IxHVhWwyekrrPMk35utH++IUUR0V
         ySZRHjTnQuRxkH0mSRZr0lRX8zjcwQo3cSTXfApyuOpwqFkqCoCiNAHnUNbMP3YhOs
         fvYiGYGvu8V9As7306izV/f8A7DsPZU0zIOSCCJa6mCtyaXg6gIRyFnjjzs13WYPWA
         +RuZoYfW0QBPbXhlmlgRYiiMtwtonS/EbKE7Gq9TxQbZtH0EPUSzQ1XJO4Adpk0SXl
         Wr32U6NJLVw+CC1G77WQ4pgNY01eGesQd/e/J1j5Yk22sCMPNUCHDfJLKSuGCaJAHh
         /9ROeBw+Xc+CA==
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

Add comments to struct page and remove the unused "_zd_pad_1" field
to make this more clear.

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
 include/linux/mm_types.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3a37a89eb7a7..6a7a1083b6fb 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -159,7 +159,16 @@ struct page {
 			/** @pgmap: Points to the hosting device page map. */
 			struct dev_pagemap *pgmap;
 			void *zone_device_data;
-			unsigned long _zd_pad_1;	/* uses mapping */
+			/*
+			 * ZONE_DEVICE private pages are counted as being
+			 * mapped so the next 3 words hold the mapping, index,
+			 * and private fields from the source anonymous or
+			 * page cache page while the page is migrated to device
+			 * private memory.
+			 * ZONE_DEVICE MEMORY_DEVICE_FS_DAX pages also
+			 * use the mapping, index, and private fields when
+			 * pmem backed DAX files are mapped.
+			 */
 		};
=20
 		/** @rcu_head: You can use this to free a page by RCU. */
--=20
2.20.1

