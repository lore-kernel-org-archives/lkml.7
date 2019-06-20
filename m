Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A67C48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0130A2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbfFTQIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:08:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:47012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731511AbfFTQIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:08:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 979FEAF2B;
        Thu, 20 Jun 2019 16:08:23 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH] mm: fix regression with deferred struct page init
Date:   Thu, 20 Jun 2019 18:08:21 +0200
Message-Id: <20190620160821.4210-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0e56acae4b4dd4a9 ("mm: initialize MAX_ORDER_NR_PAGES at a time
instead of doing larger sections") is causing a regression on some
systems when the kernel is booted as Xen dom0.

The system will just hang in early boot.

Reason is an endless loop in get_page_from_freelist() in case the first
zone looked at has no free memory. deferred_grow_zone() is always
returning true due to the following code snipplet:

  /* If the zone is empty somebody else may have cleared out the zone */
  if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
                                           first_deferred_pfn)) {
          pgdat->first_deferred_pfn = ULONG_MAX;
          pgdat_resize_unlock(pgdat, &flags);
          return true;
  }

This in turn results in the loop as get_page_from_freelist() is
assuming forward progress can be made by doing some more struct page
initialization.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Fixes: 0e56acae4b4dd4a9 ("mm: initialize MAX_ORDER_NR_PAGES at a time instead of doing larger sections")
Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d66bc8abe0af..8e3bc949ebcc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1826,7 +1826,8 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
 						 first_deferred_pfn)) {
 		pgdat->first_deferred_pfn = ULONG_MAX;
 		pgdat_resize_unlock(pgdat, &flags);
-		return true;
+		/* Retry only once. */
+		return first_deferred_pfn != ULONG_MAX;
 	}
 
 	/*
-- 
2.16.4

