Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEE6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0FD20659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Z5ZYSy1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKKW4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:56:05 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7162 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKW4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:56:04 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc9e7070000>; Mon, 11 Nov 2019 14:56:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Nov 2019 14:56:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Nov 2019 14:56:04 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Nov
 2019 22:56:04 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 11 Nov 2019 22:56:03 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dc9e7030003>; Mon, 11 Nov 2019 14:56:03 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2] mm/debug: __dump_page() prints an extra line
Date:   Mon, 11 Nov 2019 14:55:59 -0800
Message-ID: <20191111225559.19657-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573512967; bh=gpbb9yB97W1L8rR4vN87iKDSDQkjImhoYao2rBS6+Mw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=Z5ZYSy1nHz1eY4sGkYtLaCtuJA3ry0YzeYlFWOzyYpPHEidBitOo17CKqi6UIEoPp
         0Mjd8dzxO2I23H0BMkbEsR4aQh9bIa+QUI88c5V6PBVtAHz6faMitIfSOjSuw4zNY6
         z0QVol6ej4CE0pVCsS2tzZ8+CPuSTU4k4Agp2puQKmdRqrHy40K+6LIo2c0q8ayo4O
         yatovKD+lDwQ4zhAkUNILSoTsDizLZKgUHdKBmNgaf65TM2YW9pume3cJGaoNg5Chq
         w+uZAr+WhbM6sFDoSmiLYYL3KMv287K4YLnG8UgrOIDX6ReeJzD4+ptD2ZpreH4A4f
         9twKWT5MEv4mg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dumping struct page information, __dump_page() prints the page type
with a trailing blank followed by the page flags on a separate line:

anon
flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)

Fix this by using pr_cont() instead of pr_warn() to get a single line:

anon flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

v1 -> v2:
Oops, fix the subject line.

 mm/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/debug.c b/mm/debug.c
index 8345bb6e4769..752c78721ea0 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -87,7 +87,7 @@ void __dump_page(struct page *page, const char *reason)
 	}
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) !=3D __NR_PAGEFLAGS + 1);
=20
-	pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
+	pr_cont("flags: %#lx(%pGp)\n", page->flags, &page->flags);
=20
 hex_only:
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
--=20
2.20.1

