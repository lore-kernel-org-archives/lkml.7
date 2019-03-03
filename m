Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFD6C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 08:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8E4204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 08:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfCCIWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 03:22:14 -0500
Received: from smtprz15.163.net ([106.3.154.248]:56466 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725923AbfCCIWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 03:22:14 -0500
Received: from 172.25.16.148 (unknown [172.25.16.148])
        by freemail01.tom.com (Postfix) with ESMTP id DB65E1C81A29
        for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2019 13:00:13 +0800 (CST)
Received: from 172.25.16.90 (HELO smtp.tom.com) ([172.25.16.90])
          by localhost (TOM SMTP Server) with SMTP ID -206394238
          for <linux-kernel@vger.kernel.org>;
          Sun, 03 Mar 2019 13:00:13 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail01.tom.com (Postfix) with ESMTP id 25A2A1C81A26
        for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2019 13:00:13 +0800 (CST)
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 19F7F1000E33
        for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2019 13:00:13 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PimPz40B2Qgn for <linux-kernel@vger.kernel.org>;
        Sun,  3 Mar 2019 13:00:12 +0800 (CST)
Received: from localhost (unknown [110.184.153.41])
        by antispam1.tom.com (Postfix) with ESMTPA id C24C51000E2C;
        Sun,  3 Mar 2019 13:00:11 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] ext4: do prefetchw while the page pointer has been updated
Date:   Sun,  3 Mar 2019 13:00:07 +0800
Message-Id: <1551589207-3774-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pages is not NULL, prefetchw(&page->flags) always works on
the last consumed page. This might do little improvment for handling
current page. It is better to do prefetchw while the page pointer
has just been updated.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 fs/ext4/readpage.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 6aa282e..0b68dbe 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -126,14 +126,17 @@ int ext4_mpage_readpages(struct address_space *mapping,
 		int fully_mapped = 1;
 		unsigned first_hole = blocks_per_page;
 
-		prefetchw(&page->flags);
 		if (pages) {
 			page = lru_to_page(pages);
+
+			prefetchw(&page->flags);
 			list_del(&page->lru);
 			if (add_to_page_cache_lru(page, mapping, page->index,
 				  readahead_gfp_mask(mapping)))
 				goto next_page;
-		}
+		} else
+			prefetchw(&page->flags);
+
 
 		if (page_has_buffers(page))
 			goto confused;
-- 
1.9.1

