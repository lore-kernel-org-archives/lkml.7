Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5EFC76196
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A672184E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TRCk27Tt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389114AbfGQAPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 20:15:45 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11600 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfGQAPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:15:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2e68b40000>; Tue, 16 Jul 2019 17:15:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 16 Jul 2019 17:15:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 16 Jul 2019 17:15:41 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 17 Jul
 2019 00:15:38 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 17 Jul 2019 00:15:38 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d2e68aa0003>; Tue, 16 Jul 2019 17:15:38 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Subject: [PATCH 2/3] mm/hmm: fix ZONE_DEVICE anon page mapping reuse
Date:   Tue, 16 Jul 2019 17:14:45 -0700
Message-ID: <20190717001446.12351-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717001446.12351-1-rcampbell@nvidia.com>
References: <20190717001446.12351-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563322548; bh=xvR8iX2outgELqejVmTcMhX9RlYLy+wU1js0WKyDum8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=TRCk27TtRrVv4ByDmKeCrqvJNp6+08H/etGBrEm50CH2SOXfZYymRmojCkvp8tLa6
         H24TZFPuMsdO5jijygFy328uG5wNmKsxJMZir8gAsUoeMTM1BKQGEV8NBWZSheafK/
         1S/5Im8uAHIvUgtRm1EwNzfrk7IV6HonA8TEYRmmBQ2vyc8BFuVHI6uvlLQaEQfw0v
         XMqf8AqOwJrQxQ9pw5ESS5F/4G13BCIKLFjGjLccKaQ2cKaJzvx7FfBQi37zgSgXYP
         Ci17HzuHtXsMwYZDJqiTmYa54GJSGJ9gco+U/XzjJcosLSDUgG8c6QBed9JHo23xEJ
         cUx2MNq/WejeQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a ZONE_DEVICE private page is freed, the page->mapping field can be
set. If this page is reused as an anonymous page, the previous value can
prevent the page from being inserted into the CPU's anon rmap table.
For example, when migrating a pte_none() page to device memory:
  migrate_vma(ops, vma, start, end, src, dst, private)
    migrate_vma_collect()
      src[] =3D MIGRATE_PFN_MIGRATE
    migrate_vma_prepare()
      /* no page to lock or isolate so OK */
    migrate_vma_unmap()
      /* no page to unmap so OK */
    ops->alloc_and_copy()
      /* driver allocates ZONE_DEVICE page for dst[] */
    migrate_vma_pages()
      migrate_vma_insert_page()
        page_add_new_anon_rmap()
          __page_set_anon_rmap()
            /* This check sees the page's stale mapping field */
            if (PageAnon(page))
              return
            /* page->mapping is not updated */

The result is that the migration appears to succeed but a subsequent CPU
fault will be unable to migrate the page back to system memory or worse.

Clear the page->mapping field when freeing the ZONE_DEVICE page so stale
pointer data doesn't affect future page use.

Fixes: b7a523109fb5c9d2d6dd ("mm: don't clear ->mapping in hmm_devmem_free"=
)
Cc: stable@vger.kernel.org
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Jan Kara <jack@suse.cz>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
---
 kernel/memremap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index bea6f887adad..238ae5d0ae8a 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -408,6 +408,10 @@ void __put_devmap_managed_page(struct page *page)
=20
 		mem_cgroup_uncharge(page);
=20
+		/* Clear anonymous page mapping to prevent stale pointers */
+		if (is_device_private_page(page))
+			page->mapping =3D NULL;
+
 		page->pgmap->ops->page_free(page);
 	} else if (!count)
 		__put_page(page);
--=20
2.20.1

