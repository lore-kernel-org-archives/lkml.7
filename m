Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368E2C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F042186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XEXD8+Mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbfGSTHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:07:05 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11160 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfGSTHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:07:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3214d80000>; Fri, 19 Jul 2019 12:07:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 19 Jul 2019 12:07:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 19 Jul 2019 12:07:03 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Jul
 2019 19:07:03 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Jul
 2019 19:07:00 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 19 Jul 2019 19:07:00 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d3214d40003>; Fri, 19 Jul 2019 12:07:00 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>,
        Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] mm: document zone device struct page reserved fields
Date:   Fri, 19 Jul 2019 12:06:47 -0700
Message-ID: <20190719190649.30096-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719190649.30096-1-rcampbell@nvidia.com>
References: <20190719190649.30096-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563563224; bh=n97TMr2JNhrSZ7vCgIqLLYdPmnZDRy5pEGPbgjYfhkI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=XEXD8+MpeZa8W8p+pE1zOfZ44fRxNZfhiDWMcWxGdu0UuRY6HiaEZ343XnQhe8G9l
         plFxe13YRg7+09Pz3X/2r5ztqQ7vDggzGl7dYEf2qZhHAFEEIdiXXDfJIM11GZaBXD
         8Sn/eycEEMOXvMVmcYByNs3x4Hgc294+XGXs2WN7VREX6SoSERQlIZ2kWAFpsBezK1
         2qPKW/Tai815rjsLCrsQlfRNce4ANwWohy9W95HfonwFgt6rH/hFQ5j/SDdTFdiNVN
         fyGTBqmwrAFuong+CNyxx6UPxHoDak9BCXrLSaPipZ+8bknLhdkw5Dh6BPDewv6qoB
         LscjOGnASY84g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct page for ZONE_DEVICE private pages uses the reserved fields when
anonymous pages are migrated to device private memory. This is so
the page->mapping and page->index fields are preserved and the page can
be migrated back to system memory.
Document this in comments so it is more clear.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
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
 include/linux/mm_types.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3a37a89eb7a7..d6ea74e20306 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -159,7 +159,14 @@ struct page {
 			/** @pgmap: Points to the hosting device page map. */
 			struct dev_pagemap *pgmap;
 			void *zone_device_data;
-			unsigned long _zd_pad_1;	/* uses mapping */
+			/*
+			 * The following fields are used to hold the source
+			 * page anonymous mapping information while it is
+			 * migrated to device memory. See migrate_page().
+			 */
+			unsigned long _zd_pad_1;	/* aliases mapping */
+			unsigned long _zd_pad_2;	/* aliases index */
+			unsigned long _zd_pad_3;	/* aliases private */
 		};
=20
 		/** @rcu_head: You can use this to free a page by RCU. */
--=20
2.20.1

