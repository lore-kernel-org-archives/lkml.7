Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343D8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD74218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfDENv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:51:26 -0400
Received: from outbound-smtp06.blacknight.com ([81.17.249.39]:52986 "EHLO
        outbound-smtp06.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731045AbfDENvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:51:24 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id 7349D98C8E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2019 13:51:21 +0000 (UTC)
Received: (qmail 28399 invoked from network); 5 Apr 2019 13:51:21 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPA; 5 Apr 2019 13:51:21 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] mm/compaction.c: correct zone boundary handling when resetting pageblock skip hints
Date:   Fri,  5 Apr 2019 14:51:19 +0100
Message-Id: <20190405135120.27532-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190405135120.27532-1-mgorman@techsingularity.net>
References: <20190405135120.27532-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mikhail Gavrilo reported the following bug being triggered in a Fedora
kernel based on 5.1-rc1 but it is relevant to a vanilla kernel.

 kernel: page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
 kernel: ------------[ cut here ]------------
 kernel: kernel BUG at include/linux/mm.h:1021!
 kernel: invalid opcode: 0000 [#1] SMP NOPTI
 kernel: CPU: 6 PID: 116 Comm: kswapd0 Tainted: G         C        5.1.0-0.rc1.git1.3.fc31.x86_64 #1
 kernel: Hardware name: System manufacturer System Product Name/ROG STRIX X470-I GAMING, BIOS 1201 12/07/2018
 kernel: RIP: 0010:__reset_isolation_pfn+0x244/0x2b0
 kernel: Code: fe 06 e8 0f 8e fc ff 44 0f b6 4c 24 04 48 85 c0 0f 85 dc fe ff ff e9 68 fe ff ff 48 c7 c6 58 b7 2e 8c 4c 89 ff e8 0c 75 00 00 <0f> 0b 48 c7 c6 58 b7 2e 8c e8 fe 74 00 00 0f 0b 48 89 fa 41 b8 01
 kernel: RSP: 0018:ffff9e2d03f0fde8 EFLAGS: 00010246
 kernel: RAX: 0000000000000034 RBX: 000000000081f380 RCX: ffff8cffbddd6c20
 kernel: RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff8cffbddd6c20
 kernel: RBP: 0000000000000001 R08: 0000009898b94613 R09: 0000000000000000
 kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000100000
 kernel: R13: 0000000000100000 R14: 0000000000000001 R15: ffffca7de07ce000
 kernel: FS:  0000000000000000(0000) GS:ffff8cffbdc00000(0000) knlGS:0000000000000000
 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: CR2: 00007fc1670e9000 CR3: 00000007f5276000 CR4: 00000000003406e0
 kernel: Call Trace:
 kernel:  __reset_isolation_suitable+0x62/0x120
 kernel:  reset_isolation_suitable+0x3b/0x40
 kernel:  kswapd+0x147/0x540
 kernel:  ? finish_wait+0x90/0x90
 kernel:  kthread+0x108/0x140
 kernel:  ? balance_pgdat+0x560/0x560
 kernel:  ? kthread_park+0x90/0x90
 kernel:  ret_from_fork+0x27/0x50

He bisected it down to e332f741a8dd ("mm, compaction: be selective about
what pageblocks to clear skip hints").  The problem is that the patch in
question was sloppy with respect to the handling of zone boundaries.  In
some instances, it was possible for PFNs outside of a zone to be examined
and if those were not properly initialised or poisoned then it would
trigger the VM_BUG_ON.  This patch corrects the zone boundary issues when
resetting pageblock skip hints and Mikhail reported that the bug did not
trigger after 30 hours of testing.

Link: http://lkml.kernel.org/r/20190327085424.GL3189@techsingularity.net
Fixes: e332f741a8dd ("mm, compaction: be selective about what pageblocks to clear skip hints")
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index f171a83707ce..b4930bf93c8a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -242,6 +242,7 @@ __reset_isolation_pfn(struct zone *zone, unsigned long pfn, bool check_source,
 							bool check_target)
 {
 	struct page *page = pfn_to_online_page(pfn);
+	struct page *block_page;
 	struct page *end_page;
 	unsigned long block_pfn;
 
@@ -267,20 +268,26 @@ __reset_isolation_pfn(struct zone *zone, unsigned long pfn, bool check_source,
 	    get_pageblock_migratetype(page) != MIGRATE_MOVABLE)
 		return false;
 
+	/* Ensure the start of the pageblock or zone is online and valid */
+	block_pfn = pageblock_start_pfn(pfn);
+	block_page = pfn_to_online_page(max(block_pfn, zone->zone_start_pfn));
+	if (block_page) {
+		page = block_page;
+		pfn = block_pfn;
+	}
+
+	/* Ensure the end of the pageblock or zone is online and valid */
+	block_pfn += pageblock_nr_pages;
+	block_pfn = min(block_pfn, zone_end_pfn(zone) - 1);
+	end_page = pfn_to_online_page(block_pfn);
+	if (!end_page)
+		return false;
+
 	/*
 	 * Only clear the hint if a sample indicates there is either a
 	 * free page or an LRU page in the block. One or other condition
 	 * is necessary for the block to be a migration source/target.
 	 */
-	block_pfn = pageblock_start_pfn(pfn);
-	pfn = max(block_pfn, zone->zone_start_pfn);
-	page = pfn_to_page(pfn);
-	if (zone != page_zone(page))
-		return false;
-	pfn = block_pfn + pageblock_nr_pages;
-	pfn = min(pfn, zone_end_pfn(zone));
-	end_page = pfn_to_page(pfn);
-
 	do {
 		if (pfn_valid_within(pfn)) {
 			if (check_source && PageLRU(page)) {
@@ -309,7 +316,7 @@ __reset_isolation_pfn(struct zone *zone, unsigned long pfn, bool check_source,
 static void __reset_isolation_suitable(struct zone *zone)
 {
 	unsigned long migrate_pfn = zone->zone_start_pfn;
-	unsigned long free_pfn = zone_end_pfn(zone);
+	unsigned long free_pfn = zone_end_pfn(zone) - 1;
 	unsigned long reset_migrate = free_pfn;
 	unsigned long reset_free = migrate_pfn;
 	bool source_set = false;
-- 
2.16.4

