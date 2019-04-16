Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FCAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C8B20872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XlrbG0dS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbfDPRFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:05:52 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44177 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbfDPRFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:05:51 -0400
Received: by mail-qk1-f196.google.com with SMTP id y5so12589347qkc.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtR+JxYWE/z/6y97hZH4+xI4vSK6w0v5+dVQRinH+Z0=;
        b=XlrbG0dSXQaKCqJ6oDXPnysHRJQlRGQzQ/8QsS2sCiPWRvfggPR5oqp1pbLA/61dO4
         28Jj6vdq97OzDEme/JlulXC2o+Oam0CH6Pn4H2FdvPTfqNf7aDlFuuga6NzdBtU4xaos
         q2ZUvP/czfBCE3d2X7EginnTov2XVyHW0SbV9EJ6n5i7wi9H1eBJBn0f6oh3Jntk/WjZ
         +pdbvyF5c4HG0mqYb+ztmuDjKuk6U1OKA13ynsSv6/7dUHTnlOjeY+bRDQLUG4xioaWi
         KCNkrKA6RwayZlzbXhNhPJnHwRsQwEy3y1y2nD0uW6xIVsAqoKwv2+1WVt1ZA54kFKxJ
         3hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtR+JxYWE/z/6y97hZH4+xI4vSK6w0v5+dVQRinH+Z0=;
        b=euPbCJ23YNGxXHW4XEvNjs1dwoCadIawKX3FCcIV3Y6pai8EWhxTapTm/QHlHPZDD6
         9KjWxFZTwpbx6a1c386DgumjrX6nQzpPG9a0QK72TxyPOEJDcZTxohOLd3WqRD84N/0j
         zkuN6oa882eTV/fdj8ceMfT09wHQRLrIVT9gPez0GlE9PDCpxB5gv9G3Imm1x0TC8MDs
         7nw2mrbLq9UeWClw1ya/wnFiTQchq4JJXJYjtiA6yPKaSa7+SyPzrZ/iqkvBDh5pwXP/
         7oJmEg//Xe8L7hjHcvz+WIgAQnpLCXpTpLew7EjfYG5Ze2JoT+AsxJz0lm4hERWnsoj8
         hA/Q==
X-Gm-Message-State: APjAAAWFj5sI4qv6fWL1kLo3GpwuIJiu9aRC6I1RoT4zL+t3nM106eml
        Ff9Op1asVevF+S1SBTi9LIazBw==
X-Google-Smtp-Source: APXvYqznAuQo6d6nHKCse/naTQKiOVz5utoPPkz+iRwwqaHCeR/aqn8tE2Mx1uKby3JEv87St1QuMw==
X-Received: by 2002:a37:4757:: with SMTP id u84mr56641076qka.275.1555434350060;
        Tue, 16 Apr 2019 10:05:50 -0700 (PDT)
Received: from ovpn-120-81.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d205sm28157637qkg.66.2019.04.16.10.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:05:49 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4] mm/hotplug: treat CMA pages as unmovable
Date:   Tue, 16 Apr 2019 13:05:10 -0400
Message-Id: <20190416170510.20048-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

has_unmovable_pages() is used by allocating CMA and gigantic pages as
well as the memory hotplug. The later doesn't know how to offline CMA
pool properly now, but if an unused (free) CMA page is encountered, then
has_unmovable_pages() happily considers it as a free memory and
propagates this up the call chain. Memory offlining code then frees the
page without a proper CMA tear down which leads to an accounting issues.
Moreover if the same memory range is onlined again then the memory never
gets back to the CMA pool.

State after memory offline:
 # grep cma /proc/vmstat
 nr_free_cma 205824

 # cat /sys/kernel/debug/cma/cma-kvm_cma/count
 209920

Also, kmemleak still think those memory address are reserved below but
have already been used by the buddy allocator after onlining. This patch
fixes the situation by treating CMA pageblocks as unmovable except when
has_unmovable_pages() is called as part of CMA allocation.

Offlined Pages 4096
kmemleak: Cannot insert 0xc000201f7d040008 into the object search tree
(overlaps existing)
Call Trace:
[c00000003dc2faf0] [c000000000884b2c] dump_stack+0xb0/0xf4 (unreliable)
[c00000003dc2fb30] [c000000000424fb4] create_object+0x344/0x380
[c00000003dc2fbf0] [c0000000003d178c] __kmalloc_node+0x3ec/0x860
[c00000003dc2fc90] [c000000000319078] kvmalloc_node+0x58/0x110
[c00000003dc2fcd0] [c000000000484d9c] seq_read+0x41c/0x620
[c00000003dc2fd60] [c0000000004472bc] __vfs_read+0x3c/0x70
[c00000003dc2fd80] [c0000000004473ac] vfs_read+0xbc/0x1a0
[c00000003dc2fdd0] [c00000000044783c] ksys_read+0x7c/0x140
[c00000003dc2fe20] [c00000000000b108] system_call+0x5c/0x70
kmemleak: Kernel memory leak detector disabled
kmemleak: Object 0xc000201cc8000000 (size 13757317120):
kmemleak:   comm "swapper/0", pid 0, jiffies 4294937297
kmemleak:   min_count = -1
kmemleak:   count = 0
kmemleak:   flags = 0x5
kmemleak:   checksum = 0
kmemleak:   backtrace:
     cma_declare_contiguous+0x2a4/0x3b0
     kvm_cma_reserve+0x11c/0x134
     setup_arch+0x300/0x3f8
     start_kernel+0x9c/0x6e8
     start_here_common+0x1c/0x4b0
kmemleak: Automatic memory scanning thread ended

Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v4: Use is_migrate_cma_page() and update the commit log per Vlastimil.
v3: Use a string pointer instead of an array per Michal.
v2: Borrow some commit log texts.
    Call dump_page() in the error path.

 mm/page_alloc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d96ca5bc555b..c6ce20aaf80b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8005,7 +8005,10 @@ void *__init alloc_large_system_hash(const char *tablename,
 bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 			 int migratetype, int flags)
 {
-	unsigned long pfn, iter, found;
+	unsigned long found;
+	unsigned long iter = 0;
+	unsigned long pfn = page_to_pfn(page);
+	const char *reason = "unmovable page";
 
 	/*
 	 * TODO we could make this much more efficient by not checking every
@@ -8015,17 +8018,20 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 	 * can still lead to having bootmem allocations in zone_movable.
 	 */
 
-	/*
-	 * CMA allocations (alloc_contig_range) really need to mark isolate
-	 * CMA pageblocks even when they are not movable in fact so consider
-	 * them movable here.
-	 */
-	if (is_migrate_cma(migratetype) &&
-			is_migrate_cma(get_pageblock_migratetype(page)))
-		return false;
+	if (is_migrate_cma_page(page)) {
+		/*
+		 * CMA allocations (alloc_contig_range) really need to mark
+		 * isolate CMA pageblocks even when they are not movable in fact
+		 * so consider them movable here.
+		 */
+		if (is_migrate_cma(migratetype))
+			return false;
+
+		reason = "CMA page";
+		goto unmovable;
+	}
 
-	pfn = page_to_pfn(page);
-	for (found = 0, iter = 0; iter < pageblock_nr_pages; iter++) {
+	for (found = 0; iter < pageblock_nr_pages; iter++) {
 		unsigned long check = pfn + iter;
 
 		if (!pfn_valid_within(check))
@@ -8105,7 +8111,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 unmovable:
 	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
 	if (flags & REPORT_FAILURE)
-		dump_page(pfn_to_page(pfn+iter), "unmovable page");
+		dump_page(pfn_to_page(pfn + iter), reason);
 	return true;
 }
 
-- 
2.20.1 (Apple Git-117)

