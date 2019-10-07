Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6691DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E6521655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfJGJSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 05:18:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:44508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727290AbfJGJSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:18:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41809AE5E;
        Mon,  7 Oct 2019 09:18:34 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Qian Cai <cai@lca.pw>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH v3 2/3] mm, page_owner: decouple freeing stack trace from debug_pagealloc
Date:   Mon,  7 Oct 2019 11:18:07 +0200
Message-Id: <20191007091808.7096-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007091808.7096-1-vbabka@suse.cz>
References: <20191007091808.7096-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 8974558f49a6 ("mm, page_owner, debug_pagealloc: save and dump
freeing stack trace") enhanced page_owner to also store freeing stack trace,
when debug_pagealloc is also enabled. KASAN would also like to do this [1] to
improve error reports to debug e.g. UAF issues. Kirill has suggested that the
freeing stack trace saving should be also possible to be enabled separately
from KASAN or debug_pagealloc, i.e. with an extra boot option. Qian argued that
we have enough options already, and avoiding the extra overhead is not worth
the complications in the case of a debugging option. Kirill noted that the
extra stack handle in struct page_owner requires 0.1% of memory.

This patch therefore enables free stack saving whenever page_owner is enabled,
regardless of whether debug_pagealloc or KASAN is also enabled. KASAN kernels
booted with page_owner=on will thus benefit from the improved error reports.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=203967

Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Suggested-by: Walter Wu <walter-zh.wu@mediatek.com>
Suggested-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Qian Cai <cai@lca.pw>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 Documentation/dev-tools/kasan.rst |  3 +++
 mm/page_owner.c                   | 28 +++++++---------------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index b72d07d70239..525296121d89 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -41,6 +41,9 @@ smaller binary while the latter is 1.1 - 2 times faster.
 Both KASAN modes work with both SLUB and SLAB memory allocators.
 For better bug detection and nicer reporting, enable CONFIG_STACKTRACE.
 
+To augment reports with last allocation and freeing stack of the physical page,
+it is recommended to enable also CONFIG_PAGE_OWNER and boot with page_owner=on.
+
 To disable instrumentation for specific files or directories, add a line
 similar to the following to the respective kernel Makefile:
 
diff --git a/mm/page_owner.c b/mm/page_owner.c
index d3cf5d336ccf..de1916ac3e24 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -24,12 +24,10 @@ struct page_owner {
 	short last_migrate_reason;
 	gfp_t gfp_mask;
 	depot_stack_handle_t handle;
-#ifdef CONFIG_DEBUG_PAGEALLOC
 	depot_stack_handle_t free_handle;
-#endif
 };
 
-static bool page_owner_disabled = true;
+static bool page_owner_enabled = false;
 DEFINE_STATIC_KEY_FALSE(page_owner_inited);
 
 static depot_stack_handle_t dummy_handle;
@@ -44,7 +42,7 @@ static int __init early_page_owner_param(char *buf)
 		return -EINVAL;
 
 	if (strcmp(buf, "on") == 0)
-		page_owner_disabled = false;
+		page_owner_enabled = true;
 
 	return 0;
 }
@@ -52,10 +50,7 @@ early_param("page_owner", early_page_owner_param);
 
 static bool need_page_owner(void)
 {
-	if (page_owner_disabled)
-		return false;
-
-	return true;
+	return page_owner_enabled;
 }
 
 static __always_inline depot_stack_handle_t create_dummy_stack(void)
@@ -84,7 +79,7 @@ static noinline void register_early_stack(void)
 
 static void init_page_owner(void)
 {
-	if (page_owner_disabled)
+	if (!page_owner_enabled)
 		return;
 
 	register_dummy_stack();
@@ -148,25 +143,18 @@ void __reset_page_owner(struct page *page, unsigned int order)
 {
 	int i;
 	struct page_ext *page_ext;
-#ifdef CONFIG_DEBUG_PAGEALLOC
 	depot_stack_handle_t handle = 0;
 	struct page_owner *page_owner;
 
-	if (debug_pagealloc_enabled())
-		handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
-#endif
+	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
 
 	page_ext = lookup_page_ext(page);
 	if (unlikely(!page_ext))
 		return;
 	for (i = 0; i < (1 << order); i++) {
 		__clear_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags);
-#ifdef CONFIG_DEBUG_PAGEALLOC
-		if (debug_pagealloc_enabled()) {
-			page_owner = get_page_owner(page_ext);
-			page_owner->free_handle = handle;
-		}
-#endif
+		page_owner = get_page_owner(page_ext);
+		page_owner->free_handle = handle;
 		page_ext = page_ext_next(page_ext);
 	}
 }
@@ -450,7 +438,6 @@ void __dump_page_owner(struct page *page)
 		stack_trace_print(entries, nr_entries, 0);
 	}
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
 	handle = READ_ONCE(page_owner->free_handle);
 	if (!handle) {
 		pr_alert("page_owner free stack trace missing\n");
@@ -459,7 +446,6 @@ void __dump_page_owner(struct page *page)
 		pr_alert("page last free stack trace:\n");
 		stack_trace_print(entries, nr_entries, 0);
 	}
-#endif
 
 	if (page_owner->last_migrate_reason != -1)
 		pr_alert("page has been migrated, last migrate reason: %s\n",
-- 
2.23.0

