Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85999C388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B8E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfI3M3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:29:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:53876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730498AbfI3M3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:29:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8F02AFE8;
        Mon, 30 Sep 2019 12:29:28 +0000 (UTC)
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
Subject: [PATCH v2 2/3] mm, page_owner: decouple freeing stack trace from debug_pagealloc
Date:   Mon, 30 Sep 2019 14:29:15 +0200
Message-Id: <20190930122916.14969-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930122916.14969-1-vbabka@suse.cz>
References: <20190930122916.14969-1-vbabka@suse.cz>
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
freeing stack trace saving should be also possible to be enabled separately.

This patch therefore introduces a new kernel parameter page_owner_free to
enable the functionality in addition to the existing page_owner parameter.
The free stack saving is thus enabled in these cases:
1) booting with page_owner=on and debug_pagealloc=on
2) booting a KASAN kernel with page_owner=on
3) booting with page_owner=on and page_owner_free=on

To minimize runtime CPU and memory overhead when not boot-time enabled, the
patch introduces a new static key and struct page_ext_operations.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=203967

Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Suggested-by: Walter Wu <walter-zh.wu@mediatek.com>
Suggested-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++
 Documentation/dev-tools/kasan.rst             |  3 +
 include/linux/page_owner.h                    |  1 +
 mm/page_ext.c                                 |  1 +
 mm/page_owner.c                               | 90 +++++++++++++------
 5 files changed, 78 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 944e03e29f65..14dcb66e3457 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3237,6 +3237,14 @@
 			we can turn it on.
 			on: enable the feature
 
+	page_owner_free=
+			[KNL] When enabled together with page_owner, store also
+			the stack of who frees a page, for error page dump
+			purposes. This is also implicitly enabled by
+			debug_pagealloc=on or KASAN, so only page_owner=on is
+			sufficient in those cases.
+			on: enable the feature
+
 	page_poison=	[KNL] Boot-time parameter changing the state of
 			poisoning on the buddy allocator, available with
 			CONFIG_PAGE_POISONING=y.
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
 
diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 8679ccd722e8..0888dd70cc61 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -7,6 +7,7 @@
 #ifdef CONFIG_PAGE_OWNER
 extern struct static_key_false page_owner_inited;
 extern struct page_ext_operations page_owner_ops;
+extern struct page_ext_operations page_owner_free_ops;
 
 extern void __reset_page_owner(struct page *page, unsigned int order);
 extern void __set_page_owner(struct page *page,
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4ade843ff588..5724b637939a 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -61,6 +61,7 @@
 static struct page_ext_operations *page_ext_ops[] = {
 #ifdef CONFIG_PAGE_OWNER
 	&page_owner_ops,
+	&page_owner_free_ops,
 #endif
 #if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
 	&page_idle_ops,
diff --git a/mm/page_owner.c b/mm/page_owner.c
index d3cf5d336ccf..a668a735b9b6 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -24,13 +24,16 @@ struct page_owner {
 	short last_migrate_reason;
 	gfp_t gfp_mask;
 	depot_stack_handle_t handle;
-#ifdef CONFIG_DEBUG_PAGEALLOC
+};
+
+struct page_owner_free {
 	depot_stack_handle_t free_handle;
-#endif
 };
 
-static bool page_owner_disabled = true;
+static bool page_owner_enabled = false;
+static bool page_owner_free_enabled = false;
 DEFINE_STATIC_KEY_FALSE(page_owner_inited);
+static DEFINE_STATIC_KEY_FALSE(page_owner_free_stack);
 
 static depot_stack_handle_t dummy_handle;
 static depot_stack_handle_t failure_handle;
@@ -44,7 +47,7 @@ static int __init early_page_owner_param(char *buf)
 		return -EINVAL;
 
 	if (strcmp(buf, "on") == 0)
-		page_owner_disabled = false;
+		page_owner_enabled = true;
 
 	return 0;
 }
@@ -52,10 +55,30 @@ early_param("page_owner", early_page_owner_param);
 
 static bool need_page_owner(void)
 {
-	if (page_owner_disabled)
+	return page_owner_enabled;
+}
+
+static int __init early_page_owner_free_param(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+
+	if (strcmp(buf, "on") == 0)
+		page_owner_free_enabled = true;
+
+	return 0;
+}
+early_param("page_owner_free", early_page_owner_free_param);
+
+static bool need_page_owner_free(void) {
+
+	if (!page_owner_enabled)
 		return false;
 
-	return true;
+	if (IS_ENABLED(CONFIG_KASAN) || debug_pagealloc_enabled())
+		page_owner_free_enabled = true;
+
+	return page_owner_free_enabled;
 }
 
 static __always_inline depot_stack_handle_t create_dummy_stack(void)
@@ -84,7 +107,7 @@ static noinline void register_early_stack(void)
 
 static void init_page_owner(void)
 {
-	if (page_owner_disabled)
+	if (!page_owner_enabled)
 		return;
 
 	register_dummy_stack();
@@ -94,17 +117,36 @@ static void init_page_owner(void)
 	init_early_allocated_pages();
 }
 
+static void init_page_owner_free(void)
+{
+	if (!page_owner_enabled || !page_owner_free_enabled)
+		return;
+
+	static_branch_enable(&page_owner_free_stack);
+}
+
 struct page_ext_operations page_owner_ops = {
 	.size = sizeof(struct page_owner),
 	.need = need_page_owner,
 	.init = init_page_owner,
 };
 
+struct page_ext_operations page_owner_free_ops = {
+	.size = sizeof(struct page_owner_free),
+	.need = need_page_owner_free,
+	.init = init_page_owner_free,
+};
+
 static inline struct page_owner *get_page_owner(struct page_ext *page_ext)
 {
 	return (void *)page_ext + page_owner_ops.offset;
 }
 
+static inline struct page_owner_free *get_page_owner_free(struct page_ext *page_ext)
+{
+	return (void *)page_ext + page_owner_free_ops.offset;
+}
+
 static inline bool check_recursive_alloc(unsigned long *entries,
 					 unsigned int nr_entries,
 					 unsigned long ip)
@@ -148,25 +190,21 @@ void __reset_page_owner(struct page *page, unsigned int order)
 {
 	int i;
 	struct page_ext *page_ext;
-#ifdef CONFIG_DEBUG_PAGEALLOC
 	depot_stack_handle_t handle = 0;
-	struct page_owner *page_owner;
+	struct page_owner_free *page_owner_free;
 
-	if (debug_pagealloc_enabled())
+	if (static_branch_unlikely(&page_owner_free_stack))
 		handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
-#endif
 
 	page_ext = lookup_page_ext(page);
 	if (unlikely(!page_ext))
 		return;
 	for (i = 0; i < (1 << order); i++) {
 		__clear_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags);
-#ifdef CONFIG_DEBUG_PAGEALLOC
-		if (debug_pagealloc_enabled()) {
-			page_owner = get_page_owner(page_ext);
-			page_owner->free_handle = handle;
+		if (static_branch_unlikely(&page_owner_free_stack)) {
+			page_owner_free = get_page_owner_free(page_ext);
+			page_owner_free->free_handle = handle;
 		}
-#endif
 		page_ext = page_ext_next(page_ext);
 	}
 }
@@ -414,6 +452,7 @@ void __dump_page_owner(struct page *page)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
 	struct page_owner *page_owner;
+	struct page_owner_free *page_owner_free;
 	depot_stack_handle_t handle;
 	unsigned long *entries;
 	unsigned int nr_entries;
@@ -450,16 +489,17 @@ void __dump_page_owner(struct page *page)
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
+	if (static_branch_unlikely(&page_owner_free_stack)) {
+		page_owner_free = get_page_owner_free(page_ext);
+		handle = READ_ONCE(page_owner_free->free_handle);
+		if (!handle) {
+			pr_alert("page_owner free stack trace missing\n");
+		} else {
+			nr_entries = stack_depot_fetch(handle, &entries);
+			pr_alert("page last free stack trace:\n");
+			stack_trace_print(entries, nr_entries, 0);
+		}
 	}
-#endif
 
 	if (page_owner->last_migrate_reason != -1)
 		pr_alert("page has been migrated, last migrate reason: %s\n",
-- 
2.23.0

