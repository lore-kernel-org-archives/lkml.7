Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECF3C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E558C22CD5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dDhXdZ0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfGZA5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 20:57:25 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11343 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfGZA5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:57:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3a4feb0000>; Thu, 25 Jul 2019 17:57:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 17:57:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Jul 2019 17:57:14 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jul
 2019 00:57:13 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jul
 2019 00:57:08 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jul 2019 00:57:08 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d3a4fe40001>; Thu, 25 Jul 2019 17:57:08 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 6/7] mm/hmm: remove hugetlbfs check in hmm_vma_walk_pmd
Date:   Thu, 25 Jul 2019 17:56:49 -0700
Message-ID: <20190726005650.2566-7-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726005650.2566-1-rcampbell@nvidia.com>
References: <20190726005650.2566-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564102635; bh=D2MJs2fZHD43Md8ZpV6DlNuTDZTSVoq5UF6AxcLBY88=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=dDhXdZ0fq+/bJJsVQCR7FJrU8TlXvz2itR9WvHA+D+zGwHRjQv48omdl45RnxXmpB
         lVwB46LJQ7I1jmYZq8f2HDTONx4QL6yNAHgoDlCDzhsrayuWPJZUlqCiHsvrejtQAo
         IzffaEtC6GLs+mrZgw+/TfanZcDKiKjQzJg6UcKUCcQzs0xxBR7vdmXnZdWx1QuO65
         lsl3wTSKpIjNMBnruP2rDqPtA1oWApYCh1VuHm12T+FlHh0ONlL8rrfRqIuenKDf4H
         l85a/V9vbnHfXJYcg4Hz8fOoowAC4ZLQH9YSs7dtBwWkS9sagT3o5JY0D0Y19kfUqB
         dfO9F2MBE+xGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walk_page_range() will only call hmm_vma_walk_hugetlb_entry() for
hugetlbfs pages and doesn't call hmm_vma_walk_pmd() in this case.
Therefore, it is safe to remove the check for vma->vm_flags & VM_HUGETLB
in hmm_vma_walk_pmd().

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 838cd1d50497..29f322ca5d58 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -630,9 +630,6 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	if (pmd_none(pmd))
 		return hmm_vma_walk_hole(start, end, walk);
=20
-	if (pmd_huge(pmd) && (range->vma->vm_flags & VM_HUGETLB))
-		return hmm_pfns_bad(start, end, walk);
-
 	if (thp_migration_supported() && is_pmd_migration_entry(pmd)) {
 		bool fault, write_fault;
 		unsigned long npages;
--=20
2.20.1

