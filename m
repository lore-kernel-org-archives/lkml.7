Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52450C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2961021911
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IhtEE+3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfGXX1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:27:24 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3101 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfGXX1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:27:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d38e95f0002>; Wed, 24 Jul 2019 16:27:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 24 Jul 2019 16:27:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 24 Jul 2019 16:27:20 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jul
 2019 23:27:20 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jul
 2019 23:27:15 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 24 Jul 2019 23:27:16 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d38e9530000>; Wed, 24 Jul 2019 16:27:15 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        John Hubbard <jhubbard@nvidia.com>, <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 3/3] mm/hmm: Fix bad subpage pointer in try_to_unmap_one
Date:   Wed, 24 Jul 2019 16:27:00 -0700
Message-ID: <20190724232700.23327-4-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724232700.23327-1-rcampbell@nvidia.com>
References: <20190724232700.23327-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564010847; bh=aE9jvpYovWbAuB2E+N8tRNTGgKOEO3ZSK7JOHwBAVAQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=IhtEE+3R5QhqFa2KEziinP9eneZiPUTOmHuX3Sno5dk2gEzneBtRMuE8WEt2lHLaE
         AbaDZ5iX+QdPmQeebfejcPvuZ4D41S1xhiA4BLii6pTJSgMWdXUcWW5CrPQsupLeco
         WBFf8AmzolDvoi5goY2JR1CweNtxSz6XR7Uv3XX+852s/f3+eqUPQ8jEJVd0GHsU6l
         vxxT9YQ/FXsRyf5nVged5cLxXEImsR4cR31dJ1aHACQ5222keRwpvpiR+DC0o1NuR1
         aTwHQdshh/APUALxv1ugMrYoF3O96zNWbpTodlMK2Kie1c1L6Vmuk5NhiwgwJp1xYB
         K6yWPNzPEp/LA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When migrating an anonymous private page to a ZONE_DEVICE private page,
the source page->mapping and page->index fields are copied to the
destination ZONE_DEVICE struct page and the page_mapcount() is increased.
This is so rmap_walk() can be used to unmap and migrate the page back to
system memory. However, try_to_unmap_one() computes the subpage pointer
from a swap pte which computes an invalid page pointer and a kernel panic
results such as:

BUG: unable to handle page fault for address: ffffea1fffffffc8

Currently, only single pages can be migrated to device private memory so
no subpage computation is needed and it can be set to "page".

Fixes: a5430dda8a3a1c ("mm/migrate: support un-addressable ZONE_DEVICE page=
 in migration")
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/rmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index e5dfe2ae6b0d..003377e24232 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1475,7 +1475,15 @@ static bool try_to_unmap_one(struct page *page, stru=
ct vm_area_struct *vma,
 			/*
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
+			 *
+			 * The assignment to subpage above was computed from a
+			 * swap PTE which results in an invalid pointer.
+			 * Since only PAGE_SIZE pages can currently be
+			 * migrated, just set it to page. This will need to be
+			 * changed when hugepage migrations to device private
+			 * memory are supported.
 			 */
+			subpage =3D page;
 			goto discard;
 		}
=20
--=20
2.20.1

