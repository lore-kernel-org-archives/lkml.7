Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CC6CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2B72080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfKAH6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:58:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:16169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfKAH6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:58:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 00:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="225962463"
Received: from yhuang-dev.sh.intel.com ([10.239.159.29])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2019 00:58:22 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: [RFC 01/10] autonuma: Fix watermark checking in migrate_balanced_pgdat()
Date:   Fri,  1 Nov 2019 15:57:18 +0800
Message-Id: <20191101075727.26683-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101075727.26683-1-ying.huang@intel.com>
References: <20191101075727.26683-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

When zone_watermark_ok() is called in migrate_balanced_pgdat() to
check migration target node, the parameter classzone_idx (for
requested zone) is specified as 0 (ZONE_DMA).  But when allocating
memory for autonuma in alloc_misplaced_dst_page(), the requested zone
from GFP flags is ZONE_MOVABLE.  That is, the requested zone is
different.  The size of lowmem_reserve for the different requested
zone is different.  And this may cause some issues.

For example, in the zoneinfo of a test machine as below,

Node 0, zone    DMA32
  pages free     61592
        min      29
        low      454
        high     879
        spanned  1044480
        present  442306
        managed  425921
        protection: (0, 0, 62457, 62457, 62457)

The free page number of ZONE_DMA32 is greater than "high watermark +
lowmem_reserve[ZONE_DMA]", but less than "high watermark +
lowmem_reserve[ZONE_MOVABLE]".  And because __alloc_pages_node() in
alloc_misplaced_dst_page() requests ZONE_MOVABLE, the
zone_watermark_ok() on ZONE_DMA32 in migrate_balanced_pgdat() may
always return true.  So, autonuma may not stop even when memory
pressure in node 0 is heavy.

To fix the issue, ZONE_MOVABLE is used as parameter to call
zone_watermark_ok() in migrate_balanced_pgdat().  This makes it same
as requested zone in alloc_misplaced_dst_page().  So that
migrate_balanced_pgdat() returns false when memory pressure is heavy.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 513107baccd3..8f06bd37d927 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1954,7 +1954,7 @@ static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
 		if (!zone_watermark_ok(zone, 0,
 				       high_wmark_pages(zone) +
 				       nr_migrate_pages,
-				       0, 0))
+				       ZONE_MOVABLE, 0))
 			continue;
 		return true;
 	}
-- 
2.23.0

