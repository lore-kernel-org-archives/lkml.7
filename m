Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCD5C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F3D204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfDSTN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:13:26 -0400
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:34332 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbfDSTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:13:25 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 71F761C1CA1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 10:43:37 +0100 (IST)
Received: (qmail 17638 invoked from network); 19 Apr 2019 09:43:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Apr 2019 09:43:37 -0000
Date:   Fri, 19 Apr 2019 10:43:35 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: Do not boost watermarks to avoid fragmentation for the
 DISCONTIG memory model
Message-ID: <20190419094335.GJ18914@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka reported that 1c30844d2dfe ("mm: reclaim small amounts
of memory when an external fragmentation event occurs") "broke" memory
management on parisc. The machine is not NUMA but the DISCONTIG model
creates three pgdats even though it's a UMA machine for the following
ranges

        0) Start 0x0000000000000000 End 0x000000003fffffff Size   1024 MB
        1) Start 0x0000000100000000 End 0x00000001bfdfffff Size   3070 MB
        2) Start 0x0000004040000000 End 0x00000040ffffffff Size   3072 MB

From his own report

	With the patch 1c30844d2, the kernel will incorrectly reclaim the
	first zone when it fills up, ignoring the fact that there are two
	completely free zones. Basiscally, it limits cache size to 1GiB.

	For example, if I run:
	# dd if=/dev/sda of=/dev/null bs=1M count=2048

	- with the proper kernel, there should be "Buffers - 2GiB"
	when this command finishes. With the patch 1c30844d2, buffers
	will consume just 1GiB or slightly more, because the kernel was
	incorrectly reclaiming them.

The page allocator and reclaim makes assumptions that pgdats really
represent NUMA nodes and zones represent ranges and makes decisions
on that basis. Watermark boosting for small pgdats leads to unexpected
results even though this would have behaved reasonably on SPARSEMEM.

DISCONTIG is essentially deprecated and even parisc plans to move to
SPARSEMEM so there is no need to be fancy, this patch simply disables
watermark boosting by default on DISCONTIGMEM.

Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Tested-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 Documentation/sysctl/vm.txt | 16 ++++++++--------
 mm/page_alloc.c             | 13 +++++++++++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
index 6af24cdb25cc..3f13d8599337 100644
--- a/Documentation/sysctl/vm.txt
+++ b/Documentation/sysctl/vm.txt
@@ -866,14 +866,14 @@ The intent is that compaction has less work to do in the future and to
 increase the success rate of future high-order allocations such as SLUB
 allocations, THP and hugetlbfs pages.
 
-To make it sensible with respect to the watermark_scale_factor parameter,
-the unit is in fractions of 10,000. The default value of 15,000 means
-that up to 150% of the high watermark will be reclaimed in the event of
-a pageblock being mixed due to fragmentation. The level of reclaim is
-determined by the number of fragmentation events that occurred in the
-recent past. If this value is smaller than a pageblock then a pageblocks
-worth of pages will be reclaimed (e.g.  2MB on 64-bit x86). A boost factor
-of 0 will disable the feature.
+To make it sensible with respect to the watermark_scale_factor
+parameter, the unit is in fractions of 10,000. The default value of
+15,000 on !DISCONTIGMEM configurations means that up to 150% of the high
+watermark will be reclaimed in the event of a pageblock being mixed due
+to fragmentation. The level of reclaim is determined by the number of
+fragmentation events that occurred in the recent past. If this value is
+smaller than a pageblock then a pageblocks worth of pages will be reclaimed
+(e.g.  2MB on 64-bit x86). A boost factor of 0 will disable the feature.
 
 =============================================================
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cfaba3889fa2..86c3806f1070 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -266,7 +266,20 @@ compound_page_dtor * const compound_page_dtors[] = {
 
 int min_free_kbytes = 1024;
 int user_min_free_kbytes = -1;
+#ifdef CONFIG_DISCONTIGMEM
+/*
+ * DiscontigMem defines memory ranges as separate pg_data_t even if the ranges
+ * are not on separate NUMA nodes. Functionally this works but with
+ * watermark_boost_factor, it can reclaim prematurely as the ranges can be
+ * quite small. By default, do not boost watermarks on discontigmem as in
+ * many cases very high-order allocations like THP are likely to be
+ * unsupported and the premature reclaim offsets the advantage of long-term
+ * fragmentation avoidance.
+ */
+int watermark_boost_factor __read_mostly;
+#else
 int watermark_boost_factor __read_mostly = 15000;
+#endif
 int watermark_scale_factor = 10;
 
 static unsigned long nr_kernel_pages __initdata;
