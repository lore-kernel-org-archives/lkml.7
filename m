Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81745C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D332184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="a92HKbAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKLB1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:27:02 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1829 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLB1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:27:01 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dca0a260000>; Mon, 11 Nov 2019 17:25:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 11 Nov 2019 17:27:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 11 Nov 2019 17:27:00 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 01:27:00 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Nov 2019 01:27:00 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dca0a640000>; Mon, 11 Nov 2019 17:27:00 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v3] mm/debug: __dump_page() prints an extra line
Date:   Mon, 11 Nov 2019 17:26:08 -0800
Message-ID: <20191112012608.16926-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573521959; bh=I5xB11rrp8fPbhCiJFAnSXNFj55ZuC8o7ZE2GAxtZGU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=a92HKbAOP3nKGfHbxIEuwLrOHWs8Hlk3ehHU09ssO3UNq7fvWj0ctZQ1u38Jt48HD
         iyXj1ufarJCpvqJSO5x7VzEhSCMcOqknH/mkcjT8Z8dlWzBNqP8qNmafV/FExmrnVj
         ctKkVyWh7Ri1VDOM6N+7zfIx9XdhLfVyXb9USW6AoOPVj5eHnYAq0WAth9+juBDIow
         OB2tSvb5mMTxANORkmQoKDl+vA7Nq29PuPZQbPJR2Td4ue7zEFzavjTm2fvKpqF4Gx
         B4sfryucVSJJP9K3PAPrxtZQSv7H6Q5+rc9SwRB/apauFlzbo783oOtwvHXM9QmxHQ
         LBW6HkzAj7E3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dumping struct page information, __dump_page() prints the page type
with a trailing blank followed by the page flags on a separate line:

anon
flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)

It looks like the intent was to use pr_cont() for printing "flags:"
but pr_cont() usage is discouraged so fix this by extending the format
to include the flags into a single line:

anon flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)

If the page is file backed, the name might be long so use two lines:

shmem_aops name:"dev/zero"
flags: 0x10000000008000c(uptodate|dirty|swapbacked)

Eliminate pr_conf() usage as well for appending compound_mapcount.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/debug.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index 8345bb6e4769..772d4cf0691f 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -67,28 +67,31 @@ void __dump_page(struct page *page, const char *reason)
 	 */
 	mapcount =3D PageSlab(page) ? 0 : page_mapcount(page);
=20
-	pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx",
-		  page, page_ref_count(page), mapcount,
-		  page->mapping, page_to_pgoff(page));
 	if (PageCompound(page))
-		pr_cont(" compound_mapcount: %d", compound_mapcount(page));
-	pr_cont("\n");
+		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
+			"index:%#lx compound_mapcount: %d\n",
+			page, page_ref_count(page), mapcount,
+			page->mapping, page_to_pgoff(page),
+			compound_mapcount(page));
+	else
+		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
+			page, page_ref_count(page), mapcount,
+			page->mapping, page_to_pgoff(page));
 	if (PageAnon(page))
-		pr_warn("anon ");
+		pr_warn("anon flags: %#lx(%pGp)\n", page->flags, &page->flags);
 	else if (PageKsm(page))
-		pr_warn("ksm ");
+		pr_warn("ksm flags: %#lx(%pGp)\n", page->flags, &page->flags);
 	else if (mapping) {
-		pr_warn("%ps ", mapping->a_ops);
 		if (mapping->host && mapping->host->i_dentry.first) {
 			struct dentry *dentry;
 			dentry =3D container_of(mapping->host->i_dentry.first, struct dentry, d=
_u.d_alias);
-			pr_warn("name:\"%pd\" ", dentry);
-		}
+			pr_warn("%ps name:\"%pd\"\n", mapping->a_ops, dentry);
+		} else
+			pr_warn("%ps\n", mapping->a_ops);
+		pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
 	}
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) !=3D __NR_PAGEFLAGS + 1);
=20
-	pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
-
 hex_only:
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
--=20
2.20.1

