Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B631C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0999D21925
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F+Jh8WoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbfJNSqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:46:44 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12699 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731507AbfJNSqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:46:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da4c2930001>; Mon, 14 Oct 2019 11:46:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 14 Oct 2019 11:46:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 14 Oct 2019 11:46:41 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Oct
 2019 18:46:40 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 14 Oct 2019 18:46:41 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da4c2900003>; Mon, 14 Oct 2019 11:46:40 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        kbuild test robot <lkp@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/2] mm/gup: fix a misnamed "write" argument, and a related bug
Date:   Mon, 14 Oct 2019 11:46:39 -0700
Message-ID: <20191014184639.1512873-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014184639.1512873-1-jhubbard@nvidia.com>
References: <20191014184639.1512873-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571078803; bh=skAqYRFCTEBaQBD0vznLHEXuI8b4CNYHQBQAfVdjZLE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=F+Jh8WoVbLh4BP2uRlLg/lpa7hRTJwIR4UVAG0JOWt3OhDukegfSL1+0nhZ2Tjr8u
         kwMC9Z5xV+4IyqEYvGtWMi8NM4+iO6qwyJn6cQRtB8FuHfPTqwMdJPICrB0GSEmnE1
         upns7fy41N12jeX5vQAwBPSMsZrectB2D1sRKeXRQ5X1l5B5iyZPccAE4AIqNyv2Yl
         FiV/fWKyijg/uxtWfY1nRguEx8OQiMbveltK93po9qwuN1Y0TER+2WFy7RBdMdnYpd
         E7zvscD+UqgY+BOVWfWdOAp9WfIM4tlfzUVnBFVY9yot1Br6vkXY+uzdP5AnbhM1gZ
         hpU4zjElW6RSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In several routines, the "flags" argument is incorrectly
named "write". Change it to "flags".

Also, in one place, the misnaming led to an actual bug:
"flags & FOLL_WRITE" is required, rather than just "flags".
(That problem was flagged by krobot, in v1 of this patch.)

Also, change the flags argument from int, to unsigned int.

You can see that this was a simple oversight, because the
calling code passes "flags" to the fifth argument:

gup_pgd_range():
    ...
    if (!gup_huge_pd(__hugepd(pgd_val(pgd)), addr,
		    PGDIR_SHIFT, next, flags, pages, nr))

...which, until this patch, the callees referred to as "write".

Also, change two lines to avoid checkpatch line length
complaints, and another line to fix another oversight
that checkpatch called out: missing "int" on pdshift.

Fixes: b798bec4741b ("mm/gup: change write parameter to flags in fast walk"=
)
Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 23a9f9c9d377..8f236a335ae9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1973,7 +1973,8 @@ static unsigned long hugepte_addr_end(unsigned long a=
ddr, unsigned long end,
 }
=20
 static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
-		       unsigned long end, int write, struct page **pages, int *nr)
+		       unsigned long end, unsigned int flags,
+		       struct page **pages, int *nr)
 {
 	unsigned long pte_end;
 	struct page *head, *page;
@@ -1986,7 +1987,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz,=
 unsigned long addr,
=20
 	pte =3D READ_ONCE(*ptep);
=20
-	if (!pte_access_permitted(pte, write))
+	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 		return 0;
=20
 	/* hugepages are never "special" */
@@ -2023,7 +2024,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz,=
 unsigned long addr,
 }
=20
 static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
-		unsigned int pdshift, unsigned long end, int write,
+		unsigned int pdshift, unsigned long end, unsigned int flags,
 		struct page **pages, int *nr)
 {
 	pte_t *ptep;
@@ -2033,7 +2034,7 @@ static int gup_huge_pd(hugepd_t hugepd, unsigned long=
 addr,
 	ptep =3D hugepte_offset(hugepd, addr, pdshift);
 	do {
 		next =3D hugepte_addr_end(addr, end, sz);
-		if (!gup_hugepte(ptep, sz, addr, end, write, pages, nr))
+		if (!gup_hugepte(ptep, sz, addr, end, flags, pages, nr))
 			return 0;
 	} while (ptep++, addr =3D next, addr !=3D end);
=20
@@ -2041,7 +2042,7 @@ static int gup_huge_pd(hugepd_t hugepd, unsigned long=
 addr,
 }
 #else
 static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
-		unsigned pdshift, unsigned long end, int write,
+		unsigned int pdshift, unsigned long end, unsigned int flags,
 		struct page **pages, int *nr)
 {
 	return 0;
@@ -2049,7 +2050,8 @@ static inline int gup_huge_pd(hugepd_t hugepd, unsign=
ed long addr,
 #endif /* CONFIG_ARCH_HAS_HUGEPD */
=20
 static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages, int *nr)
+			unsigned long end, unsigned int flags,
+			struct page **pages, int *nr)
 {
 	struct page *head, *page;
 	int refs;
--=20
2.23.0

