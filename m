Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FAFC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606F521850
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="h8ViET5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389087AbfGQAPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 20:15:41 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17076 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfGQAPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:15:40 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2e68a90000>; Tue, 16 Jul 2019 17:15:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 16 Jul 2019 17:15:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 16 Jul 2019 17:15:39 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 17 Jul
 2019 00:15:39 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 17 Jul
 2019 00:15:35 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 17 Jul 2019 00:15:34 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d2e68a60000>; Tue, 16 Jul 2019 17:15:34 -0700
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
Date:   Tue, 16 Jul 2019 17:14:44 -0700
Message-ID: <20190717001446.12351-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717001446.12351-1-rcampbell@nvidia.com>
References: <20190717001446.12351-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563322537; bh=n97TMr2JNhrSZ7vCgIqLLYdPmnZDRy5pEGPbgjYfhkI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=h8ViET5nQwShosN/h1iEpWwaV7U1MHGQpL145RrpAfBB7pb/hc+UNknepxfXQ+2/i
         J+K60wFo6SunE78IG0A0ZSAQQeHwH/iXCHjF1/BHYLCYl3qTA94/TYq7La3Xwhx6OP
         gIEoMP9B+YfuGPWfz589qTOokW9//Lnvs9yq4U6FNVX3dULjF7MDdxO3WjRTLpsJsk
         tWfbqPbketRhICohw8wN/hPjyiSo5iFqWRtGTPq5HVuEdlwUaI8dNzNaW/yvih5paC
         odsBDvIHPlG1zU/ocufSij+Hmh0IUQJWk1lLgIl95Wsxl/xkTE8AzjnLcE1crREseF
         Cd6FZowRbWTkw==
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

