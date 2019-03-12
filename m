Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9741BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D998217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410769;
	bh=hLaWlVsuAh0znPBY48G+g7wiurrKU1mTPuMTG06PcVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bBsfkGmlLRxuTYjCm7pc1TtDJy31jVEpSPwNf1wNo0d4VpkQ+0z32Ouf79Y0Ipxqu
	 zx45o6P+ckvkqDtY8RO1+wYbJWd/3uT7GlwM5/cHzBcxeKnmXRCq2JqQUJv6DpNO4y
	 JgYj7x4eimnltooSE8eQ9i55AXsKbOrm+pGiA4A4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfCLRMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbfCLRMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:25 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 495052087C;
        Tue, 12 Mar 2019 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410744;
        bh=hLaWlVsuAh0znPBY48G+g7wiurrKU1mTPuMTG06PcVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RnPcOl7OqzkjoWNqkzswvfv79QwIOKZDHSDIyDqUNeU1bw32ye8Jv8lDIqGb2+LiD
         faCTlQI++5PaShhbQ5NKO8uTdmqBWPBXs+bCVrPUWPTGyMMPMpdM+ReoTr7we8zww+
         f+SweybdgypX+ORrJM2OMqS+VhMVpKUvAu6z8ltU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        rong.a.chen@intel.com, Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 070/171] mm, memory_hotplug: fix off-by-one in is_pageblock_removable
Date:   Tue, 12 Mar 2019 10:07:30 -0700
Message-Id: <20190312170354.178141177@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 891cb2a72d821f930a39d5900cb7a3aa752c1d5b ]

Rong Chen has reported the following boot crash:

    PGD 0 P4D 0
    Oops: 0000 [#1] PREEMPT SMP PTI
    CPU: 1 PID: 239 Comm: udevd Not tainted 5.0.0-rc4-00149-gefad4e4 #1
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
    RIP: 0010:page_mapping+0x12/0x80
    Code: 5d c3 48 89 df e8 0e ad 02 00 85 c0 75 da 89 e8 5b 5d c3 0f 1f 44 00 00 53 48 89 fb 48 8b 43 08 48 8d 50 ff a8 01 48 0f 45 da <48> 8b 53 08 48 8d 42 ff 83 e2 01 48 0f 44 c3 48 83 38 ff 74 2f 48
    RSP: 0018:ffff88801fa87cd8 EFLAGS: 00010202
    RAX: ffffffffffffffff RBX: fffffffffffffffe RCX: 000000000000000a
    RDX: fffffffffffffffe RSI: ffffffff820b9a20 RDI: ffff88801e5c0000
    RBP: 6db6db6db6db6db7 R08: ffff88801e8bb000 R09: 0000000001b64d13
    R10: ffff88801fa87cf8 R11: 0000000000000001 R12: ffff88801e640000
    R13: ffffffff820b9a20 R14: ffff88801f145258 R15: 0000000000000001
    FS:  00007fb2079817c0(0000) GS:ffff88801dd00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000000000000006 CR3: 000000001fa82000 CR4: 00000000000006a0
    Call Trace:
     __dump_page+0x14/0x2c0
     is_mem_section_removable+0x24c/0x2c0
     removable_show+0x87/0xa0
     dev_attr_show+0x25/0x60
     sysfs_kf_seq_show+0xba/0x110
     seq_read+0x196/0x3f0
     __vfs_read+0x34/0x180
     vfs_read+0xa0/0x150
     ksys_read+0x44/0xb0
     do_syscall_64+0x5e/0x4a0
     entry_SYSCALL_64_after_hwframe+0x49/0xbe

and bisected it down to commit efad4e475c31 ("mm, memory_hotplug:
is_mem_section_removable do not pass the end of a zone").

The reason for the crash is that the mapping is garbage for poisoned
(uninitialized) page.  This shouldn't happen as all pages in the zone's
boundary should be initialized.

Later debugging revealed that the actual problem is an off-by-one when
evaluating the end_page.  'start_pfn + nr_pages' resp 'zone_end_pfn'
refers to a pfn after the range and as such it might belong to a
differen memory section.

This along with CONFIG_SPARSEMEM then makes the loop condition
completely bogus because a pointer arithmetic doesn't work for pages
from two different sections in that memory model.

Fix the issue by reworking is_pageblock_removable to be pfn based and
only use struct page where necessary.  This makes the code slightly
easier to follow and we will remove the problematic pointer arithmetic
completely.

Link: http://lkml.kernel.org/r/20190218181544.14616-1-mhocko@kernel.org
Fixes: efad4e475c31 ("mm, memory_hotplug: is_mem_section_removable do not pass the end of a zone")
Signed-off-by: Michal Hocko <mhocko@suse.com>
Reported-by: <rong.a.chen@intel.com>
Tested-by: <rong.a.chen@intel.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory_hotplug.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 488aa11495d2..cb201163666f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1189,11 +1189,13 @@ static inline int pageblock_free(struct page *page)
 	return PageBuddy(page) && page_order(page) >= pageblock_order;
 }
 
-/* Return the start of the next active pageblock after a given page */
-static struct page *next_active_pageblock(struct page *page)
+/* Return the pfn of the start of the next active pageblock after a given pfn */
+static unsigned long next_active_pageblock(unsigned long pfn)
 {
+	struct page *page = pfn_to_page(pfn);
+
 	/* Ensure the starting page is pageblock-aligned */
-	BUG_ON(page_to_pfn(page) & (pageblock_nr_pages - 1));
+	BUG_ON(pfn & (pageblock_nr_pages - 1));
 
 	/* If the entire pageblock is free, move to the end of free page */
 	if (pageblock_free(page)) {
@@ -1201,16 +1203,16 @@ static struct page *next_active_pageblock(struct page *page)
 		/* be careful. we don't have locks, page_order can be changed.*/
 		order = page_order(page);
 		if ((order < MAX_ORDER) && (order >= pageblock_order))
-			return page + (1 << order);
+			return pfn + (1 << order);
 	}
 
-	return page + pageblock_nr_pages;
+	return pfn + pageblock_nr_pages;
 }
 
-static bool is_pageblock_removable_nolock(struct page *page)
+static bool is_pageblock_removable_nolock(unsigned long pfn)
 {
+	struct page *page = pfn_to_page(pfn);
 	struct zone *zone;
-	unsigned long pfn;
 
 	/*
 	 * We have to be careful here because we are iterating over memory
@@ -1233,13 +1235,14 @@ static bool is_pageblock_removable_nolock(struct page *page)
 /* Checks if this range of memory is likely to be hot-removable. */
 bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
 {
-	struct page *page = pfn_to_page(start_pfn);
-	unsigned long end_pfn = min(start_pfn + nr_pages, zone_end_pfn(page_zone(page)));
-	struct page *end_page = pfn_to_page(end_pfn);
+	unsigned long end_pfn, pfn;
+
+	end_pfn = min(start_pfn + nr_pages,
+			zone_end_pfn(page_zone(pfn_to_page(start_pfn))));
 
 	/* Check the starting page of each pageblock within the range */
-	for (; page < end_page; page = next_active_pageblock(page)) {
-		if (!is_pageblock_removable_nolock(page))
+	for (pfn = start_pfn; pfn < end_pfn; pfn = next_active_pageblock(pfn)) {
+		if (!is_pageblock_removable_nolock(pfn))
 			return false;
 		cond_resched();
 	}
-- 
2.19.1



