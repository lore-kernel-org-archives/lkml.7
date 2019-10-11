Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6087C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66A720679
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfJKOGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:06:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbfJKOGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:06:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DB19307C829;
        Fri, 11 Oct 2019 14:06:46 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-27.ams2.redhat.com [10.36.117.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBF8B5D721;
        Fri, 11 Oct 2019 14:06:38 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] mm/page_owner: Don't access uninitialized memmaps when reading /proc/pagetypeinfo
Date:   Fri, 11 Oct 2019 16:06:38 +0200
Message-Id: <20191011140638.8160-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 11 Oct 2019 14:06:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

Uninitialized memmaps contain garbage and in the worst case trigger
kernel BUGs, especially with CONFIG_PAGE_POISONING. They should not get
touched.

For example, when not onlining a memory block that is spanned by a zone
and reading /proc/pagetypeinfo with CONFIG_DEBUG_VM_PGFLAGS and
CONFIG_PAGE_POISONING, we can trigger a kernel BUG:

:/# echo 1 > /sys/devices/system/memory/memory40/online
:/# echo 1 > /sys/devices/system/memory/memory42/online
:/# cat /proc/pagetypeinfo > test.file
  [   42.489856] page:fffff2c585200000 is uninitialized and poisoned
  [   42.489861] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
  [   42.492235] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
  [   42.493501] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
  [   42.494533] There is not page extension available.
  [   42.495358] ------------[ cut here ]------------
  [   42.496163] kernel BUG at include/linux/mm.h:1107!
  [   42.497069] invalid opcode: 0000 [#1] SMP NOPTI

Please not that this change does not affect ZONE_DEVICE, because
pagetypeinfo_showmixedcount_print() is called from
mm/vmstat.c:pagetypeinfo_showmixedcount() only for populated zones, and
ZONE_DEVICE is never populated (zone->present_pages always 0).

Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online") # visible after d0dc12e86b319
Signed-off-by: Qian Cai <cai@lca.pw>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Miles Chen <miles.chen@mediatek.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ move check to outer loop, add comment, rephrase description ]
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Cai asked me to follow up on:
	[PATCH] mm/page_owner: fix a crash after memory offline

---
 mm/page_owner.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index dee931184788..7d149211f6be 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -284,7 +284,8 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 	 * not matter as the mixed block count will still be correct
 	 */
 	for (; pfn < end_pfn; ) {
-		if (!pfn_valid(pfn)) {
+		page = pfn_to_online_page(pfn);
+		if (!page) {
 			pfn = ALIGN(pfn + 1, MAX_ORDER_NR_PAGES);
 			continue;
 		}
@@ -292,13 +293,13 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 		block_end_pfn = ALIGN(pfn + 1, pageblock_nr_pages);
 		block_end_pfn = min(block_end_pfn, end_pfn);
 
-		page = pfn_to_page(pfn);
 		pageblock_mt = get_pageblock_migratetype(page);
 
 		for (; pfn < block_end_pfn; pfn++) {
 			if (!pfn_valid_within(pfn))
 				continue;
 
+			/* The pageblock is online, no need to recheck. */
 			page = pfn_to_page(pfn);
 
 			if (page_zone(page) != zone)
-- 
2.21.0

