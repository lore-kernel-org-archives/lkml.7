Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C07C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9475820727
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfKRIUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:20:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:5970 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfKRIUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:20:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 00:20:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,319,1569308400"; 
   d="scan'208";a="236838843"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2019 00:20:23 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 1/2] mm/memory-failure.c: PageHuge is handled at the beginning of memory_failure
Date:   Mon, 18 Nov 2019 16:20:02 +0800
Message-Id: <20191118082003.26240-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PageHuge is handled by memory_failure_hugetlb(), so this case could be
removed.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/memory-failure.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3151c87dff73..392ac277b17d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1359,10 +1359,7 @@ int memory_failure(unsigned long pfn, int flags)
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
2.17.1

