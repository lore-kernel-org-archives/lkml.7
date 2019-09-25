Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF19C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7372146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437339AbfIYOb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:31:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:39390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437232AbfIYObX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:31:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E0FFAE89;
        Wed, 25 Sep 2019 14:31:19 +0000 (UTC)
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
Subject: [PATCH 2/3] mm, debug, kasan: save and dump freeing stack trace for kasan
Date:   Wed, 25 Sep 2019 16:30:55 +0200
Message-Id: <20190925143056.25853-7-vbabka@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925143056.25853-1-vbabka@suse.cz>
References: <20190925143056.25853-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 8974558f49a6 ("mm, page_owner, debug_pagealloc: save and dump
freeing stack trace") enhanced page_owner to also store freeing stack trace,
when debug_pagealloc is also enabled. KASAN would also like to do this [1] to
improve error reports to debug e.g. UAF issues. This patch therefore introduces
a helper config option PAGE_OWNER_FREE_STACK, which is enabled when PAGE_OWNER
and either of DEBUG_PAGEALLOC or KASAN is enabled. Boot-time, the free stack
saving is enabled when booting a KASAN kernel with page_owner=on, or non-KASAN
kernel with debug_pagealloc=on and page_owner=on.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=203967

Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Suggested-by: Walter Wu <walter-zh.wu@mediatek.com>
Suggested-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 Documentation/dev-tools/kasan.rst |  4 ++++
 mm/Kconfig.debug                  |  4 ++++
 mm/page_owner.c                   | 31 ++++++++++++++++++-------------
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index b72d07d70239..434e605030e9 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -41,6 +41,10 @@ smaller binary while the latter is 1.1 - 2 times faster.
 Both KASAN modes work with both SLUB and SLAB memory allocators.
 For better bug detection and nicer reporting, enable CONFIG_STACKTRACE.
 
+To augment reports with last allocation and freeing stack of the physical
+page, it is recommended to configure kernel also with CONFIG_PAGE_OWNER = y
+and boot with page_owner=on.
+
 To disable instrumentation for specific files or directories, add a line
 similar to the following to the respective kernel Makefile:
 
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 327b3ebf23bf..1ea247da3322 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -62,6 +62,10 @@ config PAGE_OWNER
 
 	  If unsure, say N.
 
+config PAGE_OWNER_FREE_STACK
+	def_bool KASAN || DEBUG_PAGEALLOC
+	depends on PAGE_OWNER
+
 config PAGE_POISONING
 	bool "Poison pages after freeing"
 	select PAGE_POISONING_NO_SANITY if HIBERNATION
diff --git a/mm/page_owner.c b/mm/page_owner.c
index d3cf5d336ccf..f3aeec78822f 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -24,13 +24,14 @@ struct page_owner {
 	short last_migrate_reason;
 	gfp_t gfp_mask;
 	depot_stack_handle_t handle;
-#ifdef CONFIG_DEBUG_PAGEALLOC
+#ifdef CONFIG_PAGE_OWNER_FREE_STACK
 	depot_stack_handle_t free_handle;
 #endif
 };
 
 static bool page_owner_disabled = true;
 DEFINE_STATIC_KEY_FALSE(page_owner_inited);
+static DEFINE_STATIC_KEY_FALSE(page_owner_free_stack);
 
 static depot_stack_handle_t dummy_handle;
 static depot_stack_handle_t failure_handle;
@@ -91,6 +92,8 @@ static void init_page_owner(void)
 	register_failure_stack();
 	register_early_stack();
 	static_branch_enable(&page_owner_inited);
+	if (IS_ENABLED(CONFIG_KASAN) || debug_pagealloc_enabled())
+		static_branch_enable(&page_owner_free_stack);
 	init_early_allocated_pages();
 }
 
@@ -148,11 +151,11 @@ void __reset_page_owner(struct page *page, unsigned int order)
 {
 	int i;
 	struct page_ext *page_ext;
-#ifdef CONFIG_DEBUG_PAGEALLOC
+#ifdef CONFIG_PAGE_OWNER_FREE_STACK
 	depot_stack_handle_t handle = 0;
 	struct page_owner *page_owner;
 
-	if (debug_pagealloc_enabled())
+	if (static_branch_unlikely(&page_owner_free_stack))
 		handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
 #endif
 
@@ -161,8 +164,8 @@ void __reset_page_owner(struct page *page, unsigned int order)
 		return;
 	for (i = 0; i < (1 << order); i++) {
 		__clear_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags);
-#ifdef CONFIG_DEBUG_PAGEALLOC
-		if (debug_pagealloc_enabled()) {
+#ifdef CONFIG_PAGE_OWNER_FREE_STACK
+		if (static_branch_unlikely(&page_owner_free_stack)) {
 			page_owner = get_page_owner(page_ext);
 			page_owner->free_handle = handle;
 		}
@@ -450,14 +453,16 @@ void __dump_page_owner(struct page *page)
 		stack_trace_print(entries, nr_entries, 0);
 	}
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
-	handle = READ_ONCE(page_owner->free_handle);
-	if (!handle) {
-		pr_alert("page_owner free stack trace missing\n");
-	} else {
-		nr_entries = stack_depot_fetch(handle, &entries);
-		pr_alert("page last free stack trace:\n");
-		stack_trace_print(entries, nr_entries, 0);
+#ifdef CONFIG_PAGE_OWNER_FREE_STACK
+	if (static_branch_unlikely(&page_owner_free_stack)) {
+		handle = READ_ONCE(page_owner->free_handle);
+		if (!handle) {
+			pr_alert("page_owner free stack trace missing\n");
+		} else {
+			nr_entries = stack_depot_fetch(handle, &entries);
+			pr_alert("page last free stack trace:\n");
+			stack_trace_print(entries, nr_entries, 0);
+		}
 	}
 #endif
 
-- 
2.23.0

