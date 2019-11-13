Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2E2C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0725721A49
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QW5UZ5vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKMAGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:06:55 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10750 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKMAGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:06:55 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcb48e70000>; Tue, 12 Nov 2019 16:05:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Nov 2019 16:06:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 16:06:54 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 00:06:54 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 00:06:54 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Nov 2019 00:06:54 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dcb491e0001>; Tue, 12 Nov 2019 16:06:54 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] mm/debug: PageAnon() is true for PageKsm() pages
Date:   Tue, 12 Nov 2019 16:06:51 -0800
Message-ID: <20191113000651.20677-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573603559; bh=/wOVdRHSsqeIyfwUzfQw6fH/HHReWgDJ07fiGrrlSU0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=QW5UZ5vxpjFz9atav5kX9c9+UyPG525LYT+G5Wz4q3+G5kxkZrDJOxQ/a3PVIJ0OJ
         IxK7aOZD8qlXZonGpeXWc6aidXd+DnvD422Rc5dsKYi7mfL17QUyXQ2WhmSOY5FOkJ
         XbREHVfeG5u80+U6ssxTODbcUFuQtXwOb4TcvfygE/JT3qaUfbpxIsw1bTkveRPAfL
         yvxWGT7fVQCmV2vz488FCHkwsxqU4gRoWQuTMTN7ORqVUojLc0EijQUlngWVL6LJWJ
         FfjayWo1gdGlJ3f1K9EgUD0VBlz9Jgch538SVTEuziDeeBHimJ4QOP7ZTRb0T13rc1
         zGJBvh4L/c53Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PageAnon() and PageKsm() use the low two bits of the page->mapping pointer
to indicate the page type. PageAnon() only checks the LSB while PageKsm()
checks the least significant 2 bits are equal to 3. Therefore, PageAnon()
is true for KSM pages.
__dump_page() incorrectly will never print "ksm" because it checks
PageAnon() first. Fix this by checking PageKsm() first.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/debug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index 772d4cf0691f..0461df1207cb 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -77,10 +77,10 @@ void __dump_page(struct page *page, const char *reason)
 		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
 			page, page_ref_count(page), mapcount,
 			page->mapping, page_to_pgoff(page));
-	if (PageAnon(page))
-		pr_warn("anon flags: %#lx(%pGp)\n", page->flags, &page->flags);
-	else if (PageKsm(page))
+	if (PageKsm(page))
 		pr_warn("ksm flags: %#lx(%pGp)\n", page->flags, &page->flags);
+	else if (PageAnon(page))
+		pr_warn("anon flags: %#lx(%pGp)\n", page->flags, &page->flags);
 	else if (mapping) {
 		if (mapping->host && mapping->host->i_dentry.first) {
 			struct dentry *dentry;
--=20
2.20.1

