Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6991AC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391FF224FE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nDTe8mCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbfI3UqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:46:12 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16170 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbfI3UqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:46:11 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d925dc40000>; Mon, 30 Sep 2019 12:55:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 30 Sep 2019 12:55:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 30 Sep 2019 12:55:40 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Sep
 2019 19:55:40 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 30 Sep 2019 19:55:40 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d925dbc0000>; Mon, 30 Sep 2019 12:55:40 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] mm/thp: make set_huge_zero_page() return void
Date:   Mon, 30 Sep 2019 12:55:28 -0700
Message-ID: <20190930195528.32553-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1569873348; bh=5H2qPyiWDn47uqy9zIJy1yaJpC2vjsTK5L+ez/p+EZU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=nDTe8mCyf7ivJABZxIQxgN9Ejhl/rQe7zR0VTSvcPw/K+jzPlmq9K/DY0JidJl41p
         BmzxlD1v+LyEOqAVBSTWDVza3cyvfCDZyzBQwLdh3jx0Ln1ecmZ4n583SP3oiw9wch
         Rs4TyF4bS7OpLQbbADfry5Ygno6sMPsjSx6PPEI8l5HusFr0zzS52wMK2J9C0jxxvN
         1PqIwWdU/rbUjTjDNEheKeiSfduVs/wg51T2z1/GckxhBz4/1OyeWMjNVnm+llMjwn
         lBjxCsLN4RZ/5lja7DiT8R6P9Pzu3ZJUNULM2pA+6FjM0reolqCYL89GUYfZLQYGtO
         3r+tu58B8w83g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value from set_huge_zero_page() is never checked so simplify
the code by making it return void.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/huge_memory.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c5cb6dcd6c69..6cf0ee65538d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -686,20 +686,18 @@ static inline gfp_t alloc_hugepage_direct_gfpmask(str=
uct vm_area_struct *vma)
 }
=20
 /* Caller must hold page table lock. */
-static bool set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
+static void set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
 		struct vm_area_struct *vma, unsigned long haddr, pmd_t *pmd,
 		struct page *zero_page)
 {
 	pmd_t entry;
-	if (!pmd_none(*pmd))
-		return false;
+
 	entry =3D mk_pmd(zero_page, vma->vm_page_prot);
 	entry =3D pmd_mkhuge(entry);
 	if (pgtable)
 		pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, haddr, pmd, entry);
 	mm_inc_nr_ptes(mm);
-	return true;
 }
=20
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
--=20
2.20.1

