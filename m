Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44DF21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfCOIfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:35:13 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:51790 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfCOIfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:35:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 66062184E1;
        Fri, 15 Mar 2019 09:35:09 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id wPRZ9UvIVLX0; Fri, 15 Mar 2019 09:35:02 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 82E47184E2;
        Fri, 15 Mar 2019 09:35:02 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EA9A1E0BA;
        Fri, 15 Mar 2019 09:35:02 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41AA81E0B7;
        Fri, 15 Mar 2019 09:35:02 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Fri, 15 Mar 2019 09:35:02 +0100 (CET)
Received: from pc32929-1845.se.axis.com (pc32929-1845.se.axis.com [10.88.129.17])
        by thoth.se.axis.com (Postfix) with ESMTP id 32DCB311F;
        Fri, 15 Mar 2019 09:35:02 +0100 (CET)
Received: by pc32929-1845.se.axis.com (Postfix, from userid 20456)
        id 2C359409C8; Fri, 15 Mar 2019 09:35:02 +0100 (CET)
From:   Lars Persson <lars.persson@axis.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: migrate: add missing flush_dcache_page for non-mapped page migrate
Date:   Fri, 15 Mar 2019 09:35:02 +0100
Message-Id: <20190315083502.11849-1-larper@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our MIPS 1004Kc SoCs were seeing random userspace crashes with SIGILL
and SIGSEGV that could not be traced back to a userspace code
bug. They had all the magic signs of an I/D cache coherency issue.

Now recently we noticed that the /proc/sys/vm/compact_memory interface
was quite efficient at provoking this class of userspace crashes.

Studying the code in mm/migrate.c there is a distinction made between
migrating a page that is mapped at the instant of migration and one
that is not mapped. Our problem turned out to be the non-mapped pages.

For the non-mapped page the code performs a copy of the page content
and all relevant meta-data of the page without doing the required
D-cache maintenance. This leaves dirty data in the D-cache of the CPU
and on the 1004K cores this data is not visible to the I-cache. A
subsequent page-fault that triggers a mapping of the page will happily
serve the process with potentially stale code.

What about ARM then, this bug should have seen greater exposure? Well
ARM became immune to this flaw back in 2010, see commit c01778001a4f
("ARM: 6379/1: Assume new page cache pages have dirty D-cache").

My proposed fix moves the D-cache maintenance inside move_to_new_page
to make it common for both cases.

Cc: stable@vger.kernel.org
Fixes: 97ee0524614 ("flush cache before installing new page at migraton")
Reviewed-by: Paul Burton <paul.burton@mips.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Lars Persson <larper@axis.com>
---
v2: Added a Fixes footer and CC for stable. No functional change.
---
 mm/migrate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ac6f4939bb59..663a5449367a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -248,10 +248,8 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 				pte = swp_entry_to_pte(entry);
 			} else if (is_device_public_page(new)) {
 				pte = pte_mkdevmap(pte);
-				flush_dcache_page(new);
 			}
-		} else
-			flush_dcache_page(new);
+		}
 
 #ifdef CONFIG_HUGETLB_PAGE
 		if (PageHuge(new)) {
@@ -995,6 +993,13 @@ static int move_to_new_page(struct page *newpage, struct page *page,
 		 */
 		if (!PageMappingFlags(page))
 			page->mapping = NULL;
+
+		if (unlikely(is_zone_device_page(newpage))) {
+			if (is_device_public_page(newpage))
+				flush_dcache_page(newpage);
+		} else
+			flush_dcache_page(newpage);
+
 	}
 out:
 	return rc;
-- 
2.11.0

