Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1213CC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF12D2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kOm0J+Kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfDSWiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:38:04 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5390 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfDSWiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:38:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cba4dc80000>; Fri, 19 Apr 2019 15:38:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 19 Apr 2019 15:38:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 19 Apr 2019 15:38:03 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Apr
 2019 22:38:03 +0000
From:   <rcampbell@nvidia.com>
To:     <linux-mm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/hmm: Fix initial PFN for hugetlbfs pages
Date:   Fri, 19 Apr 2019 15:37:37 -0700
Message-ID: <20190419223737.32111-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555713480; bh=CfvcO8vti3twykYANcJx0ucggxeHBxOuIW3oPk1HmoU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=kOm0J+KgvDsPnBZeSkNYUddnrw3GrVqFzCacV1dt8vP42r+Y6gsj6V9tpSVvRjGTW
         VB2ijDvwWXCcmZeoTeEWHDnTAfjvcl9LZ1JfxnSDNkqhzo+hssgI39Aw7h4x5PBC1J
         U26+ZSkNNF3G/Ol88gOvGDS5XlKQvQlc1QB1Kesc59DaNpx5O9DxGdVu5uGnPXSwO9
         cbeQQjFvAZkbyuJ+dP/Df+FC68qquvmDNtX5t4Dj7zULYRe3Be3eWf1Wb5HAOIFlya
         Fshk5mw9Z6U201bTFUF9uYcTkVxxZpUOBNgBljSkJkDIU6XScASiJpSQtocR7TTFSb
         7jwIqZbEd9hug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

The mmotm patch [1] adds hugetlbfs support for HMM but the initial
PFN used to fill the HMM range->pfns[] array doesn't properly
compute the starting PFN offset.
This can be tested by running test-hugetlbfs-read from [2].

Fix the PFN offset by adjusting the page offset by the device's
page size.

Andrew, this should probably be squashed into Jerome's patch.

[1] https://marc.info/?l=3Dlinux-mm&m=3D155432003506068&w=3D2
("mm/hmm: mirror hugetlbfs (snapshoting, faulting and DMA mapping)")
[2] https://gitlab.freedesktop.org/glisse/svm-cl-tests

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index def451a56c3e..fcf8e4fb5770 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -868,7 +868,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsig=
ned long hmask,
 		goto unlock;
 	}
=20
-	pfn =3D pte_pfn(entry) + (start & mask);
+	pfn =3D pte_pfn(entry) + ((start & mask) >> range->page_shift);
 	for (; addr < end; addr +=3D size, i++, pfn +=3D pfn_inc)
 		range->pfns[i] =3D hmm_device_entry_from_pfn(range, pfn) |
 				 cpu_flags;
--=20
2.20.1

