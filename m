Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899A1ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9A5222BD
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440109AbfJQOVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:21:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:40512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440095AbfJQOVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:21:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D41EB470;
        Thu, 17 Oct 2019 14:21:32 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 01/16] mm,hwpoison: cleanup unused PageHuge() check
Date:   Thu, 17 Oct 2019 16:21:08 +0200
Message-Id: <20191017142123.24245-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191017142123.24245-1-osalvador@suse.de>
References: <20191017142123.24245-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Drop the PageHuge check since memory_failure forks into memory_failure_hugetlb()
for hugetlb pages.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/memory-failure.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 05c8c6df25e6..2cbadb58c7df 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1345,10 +1345,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * page_remove_rmap() in try_to_unmap_one(). So to determine page status
 	 * correctly, we save a copy of the page flags at this time.
 	 */
-	if (PageHuge(p))
-		page_flags = hpage->flags;
-	else
-		page_flags = p->flags;
+	page_flags = p->flags;
 
 	/*
 	 * unpoison always clear PG_hwpoison inside page lock
-- 
2.12.3

