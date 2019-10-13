Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36178ECE58C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 22:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04670206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 22:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TqhTskvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfJMWL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 18:11:59 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19224 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbfJMWL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 18:11:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da3a1380000>; Sun, 13 Oct 2019 15:12:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 13 Oct 2019 15:11:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 13 Oct 2019 15:11:57 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 13 Oct
 2019 22:11:57 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 13 Oct 2019 22:11:57 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da3a12d0000>; Sun, 13 Oct 2019 15:11:57 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] mm/gup: fix a misnamed "write" argument: should be "flags"
Date:   Sun, 13 Oct 2019 15:11:55 -0700
Message-ID: <20191013221155.382378-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191013221155.382378-1-jhubbard@nvidia.com>
References: <20191013221155.382378-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571004728; bh=WvC9p7B1I7T0T1ViThnwbfWhcufWg8au1RywF6q4NR8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=TqhTskvUWIw5h0Uwn5dHqWLwDgQoicuWVI0OswL+BlA4Rq3/Vdyr0GfSJTXIEGW7N
         zaomaeTD4fgV0TdiilQ2wUxuKZJdhvAdluYeXEyOntU8YCiOd6CbV/sqeVAGcJYSBD
         MY3P3u152E0TxZgbcmkEnVK8vVfsp4Kj0XVPXRCK6FxvL5HEmvqigmbJbPfiWlriaD
         jOTbngVDt2CDrAGOMGkaCLqYH4RTKCI6wFd7Bbgjk0jfNCDgqNLwnXch7DBzXVrv9D
         F6qoHbzJTQftVQSGJNSnKi92BjdOEaR70Be0H7AkqevP44fjVNf9h6DkiIKdOxgaaj
         PqffY/Y6xBEaQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In several routines, the "flags" argument is incorrectly
named "write". Change it to "flags".

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

Cc: Christoph Hellwig <hch@lst.de>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 23a9f9c9d377..0438221d8c53 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1973,7 +1973,8 @@ static unsigned long hugepte_addr_end(unsigned long a=
ddr, unsigned long end,
 }
=20
 static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
-		       unsigned long end, int write, struct page **pages, int *nr)
+		       unsigned long end, int flags, struct page **pages,
+		       int *nr)
 {
 	unsigned long pte_end;
 	struct page *head, *page;
@@ -2023,7 +2024,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz,=
 unsigned long addr,
 }
=20
 static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
-		unsigned int pdshift, unsigned long end, int write,
+		unsigned int pdshift, unsigned long end, int flags,
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
+		unsigned int pdshift, unsigned long end, int flags,
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

