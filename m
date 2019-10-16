Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94FBECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F7A2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbfJPWxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:53:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:40499 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbfJPWx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 18:53:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 15:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,305,1566889200"; 
   d="scan'208";a="199097059"
Received: from xiaoboma-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.214.50])
  by orsmga003.jf.intel.com with ESMTP; 16 Oct 2019 15:53:27 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1iKsAY-0003HH-1Q; Thu, 17 Oct 2019 06:53:26 +0800
Date:   Thu, 17 Oct 2019 06:53:26 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: trivial mark_page_accessed() cleanup
Message-ID: <20191016225326.GB12497@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids duplicated PageReferenced() calls.
No behavior change.

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
  mm/swap.c | 14 +++++++++-----
  1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 38a52b9..c55720c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -373,9 +373,15 @@ void mark_page_accessed(struct page *page)
  	page = compound_head(page);
  	inc_node_page_state(page, NR_ACCESSED);
  
-	if (!PageActive(page) && !PageUnevictable(page) &&
-			PageReferenced(page)) {
-
+	if (!PageReferenced(page)) {
+		SetPageReferenced(page);
+	} else if (PageUnevictable(page)) {
+		/*
+		 * Unevictable pages are on the "LRU_UNEVICTABLE" list. But,
+		 * this list is never rotated or maintained, so marking an
+		 * evictable page accessed has no effect.
+		 */
+	} else if (!PageActive(page)) {
  		/*
  		 * If the page is on the LRU, queue it for activation via
  		 * activate_page_pvecs. Otherwise, assume the page is on a
@@ -389,8 +395,6 @@ void mark_page_accessed(struct page *page)
  		ClearPageReferenced(page);
  		if (page_is_file_cache(page))
  			workingset_activation(page);
-	} else if (!PageReferenced(page)) {
-		SetPageReferenced(page);
  	}
  	if (page_is_idle(page))
  		clear_page_idle(page);
-- 
2.7.4

