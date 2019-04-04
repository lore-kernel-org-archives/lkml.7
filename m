Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBF7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B4A214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="SvhL/4Py";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJu+qrR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfDDCKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:10:07 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59387 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbfDDCJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:09:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CA0F722A3B;
        Wed,  3 Apr 2019 22:01:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 22:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=wKf/HaqlNMzdp
        lmWVUVv2uQOEaqupeioEqpo1cew5Lw=; b=SvhL/4PyiHIT2BO3xP9K8uRh4ljRG
        ZPijSt7CNCgrO/LaKjf49+BmticX/iJkRnZpHKW9D3KLRNpf9lAylwKVFFm32dn+
        +uv3CBXZWQjj4NFRUVbYTrMVrzNL0DLd4w+wpEv7ZyQB3X4Y5oJ6zd6O0s1P3E+U
        McpWk2Bqgrgb9ci0c8AXi+kitUg7XaCUzziiWmsrrJgbrKmBh9fygfLMzoDG/OLM
        FywVTT6tu7PLjL8SBeFekRrqEvJJn2Ar//CE4+oNw+SLsp1pWOSb31LbeU1vcqck
        /6/zxHmyUBO8xRdgEOkRqBXO65RK0sLfSOM11jFWHbxvUi817jgOEHktw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=wKf/HaqlNMzdplmWVUVv2uQOEaqupeioEqpo1cew5Lw=; b=PJu+qrR3
        v7NmlvIjDSv6zd8YKIW71Hg5az/BRBlW9T4Zq4z8dcawQEas8L7s7E5FF8EZ08ai
        FIaqaZPAOIVBNWcDTshbxK7aOoic8THiPnjzb9QsHLbV3pFljBWDHlz75TdNKx5x
        ihuIW4a7KFz9mn2Bz/XlWCNbwF8HWdN7u0H7hPWu4DkInEdt6sx1/35MVopCmH+o
        ekb/hdToj4XpfYfO40wj8JufzH+/XieJKy6RydkwG70V9lPQtm87MAiRBkYV6kKf
        xebYrY5QijV+ZzuRZ7pHIBt/5UXgbPiErPP3DxmjMBxjGmLgZmUkGbTUmnb8iyMD
        lh8YtYCOOPRhbg==
X-ME-Sender: <xms:hGWlXASW_IyN_ftsSnnV9pz-qZd8LZEjAxG-cZZt6fFW-brzpXHPkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggdehudculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddt
    necuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucfkph
    epvdduiedrvddvkedrudduvddrvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdr
    higrnhesshgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgepudeg
X-ME-Proxy: <xmx:hGWlXCBtKFvp3LrTRl-kyegsZSBB1I3PScOAdbLkn9Ko6-PwetLsMA>
    <xmx:hGWlXI0jbD2R_UFa99ORXxYGKQXP-k2E-VBxNnMkAhIW77ydxPLtcA>
    <xmx:hGWlXIXa9mn3YoDZC5UtTLU35SLwO0_iAkUidgsUI4ZrRdi5xE9lDg>
    <xmx:hGWlXLZ7inH-A1ThZRIbxjzWR-eh9X4cAz5Eeds8b3iJbqFF5C_6Sg>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 94A6710319;
        Wed,  3 Apr 2019 22:01:38 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Javier Cabezas <jcabezas@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 15/25] exchange pages: exchange anonymous page and file-backed page.
Date:   Wed,  3 Apr 2019 19:00:36 -0700
Message-Id: <20190404020046.32741-16-zi.yan@sent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404020046.32741-1-zi.yan@sent.com>
References: <20190404020046.32741-1-zi.yan@sent.com>
Reply-To: ziy@nvidia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

This is only done for the basic exchange pages, because we might
need to lock multiple files when doing concurrent exchange pages,
which could cause deadlocks easily.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/exchange.c | 284 ++++++++++++++++++++++++++++++++++++++++++++++------------
 mm/internal.h |   9 ++
 mm/migrate.c  |   6 +-
 3 files changed, 241 insertions(+), 58 deletions(-)

diff --git a/mm/exchange.c b/mm/exchange.c
index bbada58..555a72c 100644
--- a/mm/exchange.c
+++ b/mm/exchange.c
@@ -20,6 +20,8 @@
 #include <linux/memcontrol.h>
 #include <linux/balloon_compaction.h>
 #include <linux/buffer_head.h>
+#include <linux/fs.h> /* buffer_migrate_page  */
+#include <linux/backing-dev.h>
 
 
 #include "internal.h"
@@ -147,8 +149,6 @@ static void exchange_page_flags(struct page *to_page, struct page *from_page)
 	from_page_flags.page_is_idle = page_is_idle(from_page);
 	clear_page_idle(from_page);
 	from_page_flags.page_swapcache = PageSwapCache(from_page);
-	from_page_flags.page_private = PagePrivate(from_page);
-	ClearPagePrivate(from_page);
 	from_page_flags.page_writeback = test_clear_page_writeback(from_page);
 
 
@@ -170,8 +170,6 @@ static void exchange_page_flags(struct page *to_page, struct page *from_page)
 	to_page_flags.page_is_idle = page_is_idle(to_page);
 	clear_page_idle(to_page);
 	to_page_flags.page_swapcache = PageSwapCache(to_page);
-	to_page_flags.page_private = PagePrivate(to_page);
-	ClearPagePrivate(to_page);
 	to_page_flags.page_writeback = test_clear_page_writeback(to_page);
 
 	/* set to_page */
@@ -268,18 +266,22 @@ static void exchange_page_flags(struct page *to_page, struct page *from_page)
 static int exchange_page_move_mapping(struct address_space *to_mapping,
 			struct address_space *from_mapping,
 			struct page *to_page, struct page *from_page,
+			struct buffer_head *to_head, struct buffer_head *from_head,
 			enum migrate_mode mode,
 			int to_extra_count, int from_extra_count)
 {
-	int to_expected_count = 1 + to_extra_count,
-		from_expected_count = 1 + from_extra_count;
-	unsigned long from_page_index = page_index(from_page),
-				  to_page_index = page_index(to_page);
+	int to_expected_count = expected_page_refs(to_mapping, to_page) + to_extra_count,
+		from_expected_count = expected_page_refs(from_mapping, from_page) + from_extra_count;
+	unsigned long from_page_index = from_page->index;
+	unsigned long to_page_index = to_page->index;
 	int to_swapbacked = PageSwapBacked(to_page),
 		from_swapbacked = PageSwapBacked(from_page);
-	struct address_space *to_mapping_value = to_page->mapping,
-						 *from_mapping_value = from_page->mapping;
+	struct address_space *to_mapping_value = to_page->mapping;
+	struct address_space *from_mapping_value = from_page->mapping;
 
+	VM_BUG_ON_PAGE(to_mapping != page_mapping(to_page), to_page);
+	VM_BUG_ON_PAGE(from_mapping != page_mapping(from_page), from_page);
+	VM_BUG_ON(PageCompound(from_page) != PageCompound(to_page));
 
 	if (!to_mapping) {
 		/* Anonymous page without mapping */
@@ -293,26 +295,125 @@ static int exchange_page_move_mapping(struct address_space *to_mapping,
 			return -EAGAIN;
 	}
 
-	/*
-	 * Now we know that no one else is looking at the page:
-	 * no turning back from here.
-	 */
-	/* from_page  */
-	from_page->index = to_page_index;
-	from_page->mapping = to_mapping_value;
+	/* both are anonymous pages  */
+	if (!from_mapping && !to_mapping) {
+		/* from_page  */
+		from_page->index = to_page_index;
+		from_page->mapping = to_mapping_value;
+
+		ClearPageSwapBacked(from_page);
+		if (to_swapbacked)
+			SetPageSwapBacked(from_page);
+
+
+		/* to_page  */
+		to_page->index = from_page_index;
+		to_page->mapping = from_mapping_value;
+
+		ClearPageSwapBacked(to_page);
+		if (from_swapbacked)
+			SetPageSwapBacked(to_page);
+	} else if (!from_mapping && to_mapping) {
+		/* from is anonymous, to is file-backed  */
+		XA_STATE(to_xas, &to_mapping->i_pages, page_index(to_page));
+		struct zone *from_zone, *to_zone;
+		int dirty;
+
+		from_zone = page_zone(from_page);
+		to_zone = page_zone(to_page);
+
+		xas_lock_irq(&to_xas);
+
+		if (page_count(to_page) != to_expected_count ||
+			xas_load(&to_xas) != to_page) {
+			xas_unlock_irq(&to_xas);
+			return -EAGAIN;
+		}
+
+		if (!page_ref_freeze(to_page, to_expected_count)) {
+			xas_unlock_irq(&to_xas);
+			pr_debug("cannot freeze page count\n");
+			return -EAGAIN;
+		}
+
+		if (!page_ref_freeze(from_page, from_expected_count)) {
+			page_ref_unfreeze(to_page, to_expected_count);
+			xas_unlock_irq(&to_xas);
+
+			return -EAGAIN;
+		}
+		/*
+		 * Now we know that no one else is looking at the page:
+		 * no turning back from here.
+		 */
+		ClearPageSwapBacked(from_page);
+		ClearPageSwapBacked(to_page);
+
+		/* from_page  */
+		from_page->index = to_page_index;
+		from_page->mapping = to_mapping_value;
+		/* to_page  */
+		to_page->index = from_page_index;
+		to_page->mapping = from_mapping_value;
+
+		if (to_swapbacked)
+			__SetPageSwapBacked(from_page);
+		else
+			VM_BUG_ON_PAGE(PageSwapCache(to_page), to_page);
 
-	ClearPageSwapBacked(from_page);
-	if (to_swapbacked)
-		SetPageSwapBacked(from_page);
+		if (from_swapbacked)
+			__SetPageSwapBacked(to_page);
+		else
+			VM_BUG_ON_PAGE(PageSwapCache(from_page), from_page);
 
+		dirty = PageDirty(to_page);
 
-	/* to_page  */
-	to_page->index = from_page_index;
-	to_page->mapping = from_mapping_value;
+		xas_store(&to_xas, from_page);
+		if (PageTransHuge(to_page)) {
+			int i;
+			for (i = 1; i < HPAGE_PMD_NR; i++) {
+				xas_next(&to_xas);
+				xas_store(&to_xas, from_page + i);
+			}
+		}
+
+		/* move cache reference */
+		page_ref_unfreeze(to_page, to_expected_count - hpage_nr_pages(to_page));
+		page_ref_unfreeze(from_page, from_expected_count + hpage_nr_pages(from_page));
+
+		xas_unlock(&to_xas);
+
+		/*
+		 * If moved to a different zone then also account
+		 * the page for that zone. Other VM counters will be
+		 * taken care of when we establish references to the
+		 * new page and drop references to the old page.
+		 *
+		 * Note that anonymous pages are accounted for
+		 * via NR_FILE_PAGES and NR_ANON_MAPPED if they
+		 * are mapped to swap space.
+		 */
+		if (to_zone != from_zone) {
+			__dec_node_state(to_zone->zone_pgdat, NR_FILE_PAGES);
+			__inc_node_state(from_zone->zone_pgdat, NR_FILE_PAGES);
+			if (PageSwapBacked(to_page) && !PageSwapCache(to_page)) {
+				__dec_node_state(to_zone->zone_pgdat, NR_SHMEM);
+				__inc_node_state(from_zone->zone_pgdat, NR_SHMEM);
+			}
+			if (dirty && mapping_cap_account_dirty(to_mapping)) {
+				__dec_node_state(to_zone->zone_pgdat, NR_FILE_DIRTY);
+				__dec_zone_state(to_zone, NR_ZONE_WRITE_PENDING);
+				__inc_node_state(from_zone->zone_pgdat, NR_FILE_DIRTY);
+				__inc_zone_state(from_zone, NR_ZONE_WRITE_PENDING);
+			}
+		}
+		local_irq_enable();
 
-	ClearPageSwapBacked(to_page);
-	if (from_swapbacked)
-		SetPageSwapBacked(to_page);
+	} else {
+		/* from is file-backed to is anonymous: fold this to the case above */
+		/* both are file-backed  */
+		VM_BUG_ON(1);
+	}
 
 	return MIGRATEPAGE_SUCCESS;
 }
@@ -322,6 +423,7 @@ static int exchange_from_to_pages(struct page *to_page, struct page *from_page,
 {
 	int rc = -EBUSY;
 	struct address_space *to_page_mapping, *from_page_mapping;
+	struct buffer_head *to_head = NULL, *to_bh = NULL;
 
 	VM_BUG_ON_PAGE(!PageLocked(from_page), from_page);
 	VM_BUG_ON_PAGE(!PageLocked(to_page), to_page);
@@ -330,15 +432,71 @@ static int exchange_from_to_pages(struct page *to_page, struct page *from_page,
 	to_page_mapping = page_mapping(to_page);
 	from_page_mapping = page_mapping(from_page);
 
+	/* from_page has to be anonymous page  */
 	BUG_ON(from_page_mapping);
-	BUG_ON(to_page_mapping);
-
 	BUG_ON(PageWriteback(from_page));
+	/* writeback has to finish */
 	BUG_ON(PageWriteback(to_page));
 
-	/* actual page mapping exchange */
-	rc = exchange_page_move_mapping(to_page_mapping, from_page_mapping,
-						to_page, from_page, mode, 0, 0);
+	/* to_page is anonymous  */
+	if (!to_page_mapping) {
+exchange_mappings:
+		/* actual page mapping exchange */
+		rc = exchange_page_move_mapping(to_page_mapping, from_page_mapping,
+							to_page, from_page, NULL, NULL, mode, 0, 0);
+	} else {
+		if (to_page_mapping->a_ops->migratepage == buffer_migrate_page) {
+			if (!page_has_buffers(to_page))
+				goto exchange_mappings;
+
+			to_head = page_buffers(to_page);
+
+			rc = exchange_page_move_mapping(to_page_mapping,
+					from_page_mapping, to_page, from_page,
+					to_head, NULL, mode, 0, 0);
+
+			if (rc != MIGRATEPAGE_SUCCESS)
+				return rc;
+
+			/*
+			 * In the async case, migrate_page_move_mapping locked the buffers
+			 * with an IRQ-safe spinlock held. In the sync case, the buffers
+			 * need to be locked now
+			 */
+			if ((mode & MIGRATE_MODE_MASK) != MIGRATE_ASYNC)
+				BUG_ON(!buffer_migrate_lock_buffers(to_head, mode));
+
+			ClearPagePrivate(to_page);
+			set_page_private(from_page, page_private(to_page));
+			set_page_private(to_page, 0);
+			/* transfer private page count  */
+			put_page(to_page);
+			get_page(from_page);
+
+			to_bh = to_head;
+			do {
+				set_bh_page(to_bh, from_page, bh_offset(to_bh));
+				to_bh = to_bh->b_this_page;
+
+			} while (to_bh != to_head);
+
+			SetPagePrivate(from_page);
+
+			to_bh = to_head;
+		} else if (!to_page_mapping->a_ops->migratepage) {
+			/* fallback_migrate_page  */
+			if (PageDirty(to_page)) {
+				if ((mode & MIGRATE_MODE_MASK) != MIGRATE_SYNC)
+					return -EBUSY;
+				return writeout(to_page_mapping, to_page);
+			}
+			if (page_has_private(to_page) &&
+				!try_to_release_page(to_page, GFP_KERNEL))
+				return -EAGAIN;
+
+			goto exchange_mappings;
+		}
+	}
 	/* actual page data exchange  */
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
@@ -356,8 +514,28 @@ static int exchange_from_to_pages(struct page *to_page, struct page *from_page,
 		rc = 0;
 	}
 
+	/*
+	 * 1. buffer_migrate_page:
+	 *   private flag should be transferred from to_page to from_page
+	 *
+	 * 2. anon<->anon, fallback_migrate_page:
+	 *   both have none private flags or to_page's is cleared.
+	 * */
+	VM_BUG_ON(!((page_has_private(from_page) && !page_has_private(to_page)) ||
+				(!page_has_private(from_page) && !page_has_private(to_page))));
+
 	exchange_page_flags(to_page, from_page);
 
+	if (to_bh) {
+		VM_BUG_ON(to_bh != to_head);
+		do {
+			unlock_buffer(to_bh);
+			put_bh(to_bh);
+			to_bh = to_bh->b_this_page;
+
+		} while (to_bh != to_head);
+	}
+
 	return rc;
 }
 
@@ -369,34 +547,12 @@ static int unmap_and_exchange(struct page *from_page, struct page *to_page,
 	pgoff_t from_index, to_index;
 	struct anon_vma *from_anon_vma = NULL, *to_anon_vma = NULL;
 
-	/* from_page lock down  */
 	if (!trylock_page(from_page)) {
 		if ((mode & MIGRATE_MODE_MASK) == MIGRATE_ASYNC)
 			goto out;
-
 		lock_page(from_page);
 	}
 
-	BUG_ON(PageWriteback(from_page));
-
-	/*
-	 * By try_to_unmap(), page->mapcount goes down to 0 here. In this case,
-	 * we cannot notice that anon_vma is freed while we migrates a page.
-	 * This get_anon_vma() delays freeing anon_vma pointer until the end
-	 * of migration. File cache pages are no problem because of page_lock()
-	 * File Caches may use write_page() or lock_page() in migration, then,
-	 * just care Anon page here.
-	 *
-	 * Only page_get_anon_vma() understands the subtleties of
-	 * getting a hold on an anon_vma from outside one of its mms.
-	 * But if we cannot get anon_vma, then we won't need it anyway,
-	 * because that implies that the anon page is no longer mapped
-	 * (and cannot be remapped so long as we hold the page lock).
-	 */
-	if (PageAnon(from_page) && !PageKsm(from_page))
-		from_anon_vma = page_get_anon_vma(from_page);
-
-	/* to_page lock down  */
 	if (!trylock_page(to_page)) {
 		if ((mode & MIGRATE_MODE_MASK) == MIGRATE_ASYNC)
 			goto out_unlock;
@@ -404,7 +560,22 @@ static int unmap_and_exchange(struct page *from_page, struct page *to_page,
 		lock_page(to_page);
 	}
 
-	BUG_ON(PageWriteback(to_page));
+	/* from_page is supposed to be an anonymous page */
+	VM_BUG_ON_PAGE(PageWriteback(from_page), from_page);
+
+	if (PageWriteback(to_page)) {
+		/*
+		 * Only in the case of a full synchronous migration is it
+		 * necessary to wait for PageWriteback. In the async case,
+		 * the retry loop is too short and in the sync-light case,
+		 * the overhead of stalling is too much
+		 */
+		if ((mode & MIGRATE_MODE_MASK) != MIGRATE_SYNC) {
+			rc = -EBUSY;
+			goto out_unlock;
+		}
+		wait_on_page_writeback(to_page);
+	}
 
 	/*
 	 * By try_to_unmap(), page->mapcount goes down to 0 here. In this case,
@@ -420,6 +591,9 @@ static int unmap_and_exchange(struct page *from_page, struct page *to_page,
 	 * because that implies that the anon page is no longer mapped
 	 * (and cannot be remapped so long as we hold the page lock).
 	 */
+	if (PageAnon(from_page) && !PageKsm(from_page))
+		from_anon_vma = page_get_anon_vma(from_page);
+
 	if (PageAnon(to_page) && !PageKsm(to_page))
 		to_anon_vma = page_get_anon_vma(to_page);
 
@@ -753,7 +927,7 @@ static int exchange_page_mapping_concur(struct list_head *unmapped_list_ptr,
 
 		/* actual page mapping exchange */
 		rc = exchange_page_move_mapping(to_page_mapping, from_page_mapping,
-							to_page, from_page, mode, 0, 0);
+							to_page, from_page, NULL, NULL, mode, 0, 0);
 
 		if (rc) {
 			if (one_pair->from_page_was_mapped)
diff --git a/mm/internal.h b/mm/internal.h
index a039459..cf63bf6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -566,4 +566,13 @@ extern int exchange_page_mthread(struct page *to, struct page *from,
 extern int exchange_page_lists_mthread(struct page **to,
 						  struct page **from, 
 						  int nr_pages);
+
+extern int exchange_two_pages(struct page *page1, struct page *page2);
+
+bool buffer_migrate_lock_buffers(struct buffer_head *head,
+							enum migrate_mode mode);
+int writeout(struct address_space *mapping, struct page *page);
+int expected_page_refs(struct address_space *mapping, struct page *page);
+
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/migrate.c b/mm/migrate.c
index ad02797..a0ca817 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -385,7 +385,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 }
 #endif
 
-static int expected_page_refs(struct address_space *mapping, struct page *page)
+int expected_page_refs(struct address_space *mapping, struct page *page)
 {
 	int expected_count = 1;
 
@@ -732,7 +732,7 @@ EXPORT_SYMBOL(migrate_page);
 
 #ifdef CONFIG_BLOCK
 /* Returns true if all buffers are successfully locked */
-static bool buffer_migrate_lock_buffers(struct buffer_head *head,
+bool buffer_migrate_lock_buffers(struct buffer_head *head,
 							enum migrate_mode mode)
 {
 	struct buffer_head *bh = head;
@@ -880,7 +880,7 @@ int buffer_migrate_page_norefs(struct address_space *mapping,
 /*
  * Writeback a page to clean the dirty state
  */
-static int writeout(struct address_space *mapping, struct page *page)
+int writeout(struct address_space *mapping, struct page *page)
 {
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
-- 
2.7.4

