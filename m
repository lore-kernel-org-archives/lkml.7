Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1564EC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD29D2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JqxCSusY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgAGVMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:12:44 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18236 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbgAGVMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:12:40 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e14f4360003>; Tue, 07 Jan 2020 13:12:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 13:12:40 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 Jan 2020 13:12:40 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 21:12:39 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 21:12:35 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 7 Jan 2020 21:12:35 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e14f4430003>; Tue, 07 Jan 2020 13:12:35 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Bharata B Rao" <bharata@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 3/3] mm/migrate: add stable check in migrate_vma_insert_page()
Date:   Tue, 7 Jan 2020 13:12:08 -0800
Message-ID: <20200107211208.24595-4-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107211208.24595-1-rcampbell@nvidia.com>
References: <20200107211208.24595-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578431542; bh=SbysyzJHnYBvqFHWxRtcz1aHTD46JJxOWAetcbRONGU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=JqxCSusYZbOZF5MLOWLYoXTPFeP6maiJmWNu4RrJ42Y9os0rSCKYCZgIVPcHSrkmE
         sB9qsLaXQXzMz6fJU6HhUSDOKHhmKvJDaO6J0xMQBm5muZ607NdXMWqR9jp20Y8gI4
         V0mElE1/R4U7WMt/yHJIup4YHVnMpF3fDBqwv9csVsU/i9XVpTKRhRpdgyxBl10foh
         bCYR5ceFbh/DX1HukDYdNZOjJRPUikhnNq9c9mS1hDnxGF9qltbXAB6cmcKZ3ETNDJ
         OAvVXcXts/W8TkveXGbps1SKzxw/82idlXa/Y1H6/zWmgaR3XNu3KUDj1Xk50NSo9r
         u3PiLRW9bDAXA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

migrate_vma_insert_page() closely follows the code in:
  __handle_mm_fault()
    handle_pte_fault()
      do_anonymous_page()

Add a call to check_stable_address_space() after locking the page table
entry before inserting a ZONE_DEVICE private zero page mapping similar to
page faulting a new anonymous page.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/migrate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4b1a6d69afb5..403b82472d24 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -48,6 +48,7 @@
 #include <linux/page_owner.h>
 #include <linux/sched/mm.h>
 #include <linux/ptrace.h>
+#include <linux/oom.h>
=20
 #include <asm/tlbflush.h>
=20
@@ -2675,6 +2676,14 @@ int migrate_vma_setup(struct migrate_vma *args)
 }
 EXPORT_SYMBOL(migrate_vma_setup);
=20
+/*
+ * This code closely matches the code in:
+ *   __handle_mm_fault()
+ *     handle_pte_fault()
+ *       do_anonymous_page()
+ * to map in an anonymous zero page but the struct page will be a ZONE_DEV=
ICE
+ * private page.
+ */
 static void migrate_vma_insert_page(struct migrate_vma *migrate,
 				    unsigned long addr,
 				    struct page *page,
@@ -2755,6 +2764,9 @@ static void migrate_vma_insert_page(struct migrate_vm=
a *migrate,
=20
 	ptep =3D pte_offset_map_lock(mm, pmdp, addr, &ptl);
=20
+	if (check_stable_address_space(mm))
+		goto unlock_abort;
+
 	if (pte_present(*ptep)) {
 		unsigned long pfn =3D pte_pfn(*ptep);
=20
--=20
2.20.1

