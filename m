Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1EEC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BB827A8E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfFCOfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:35:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:54842 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728988AbfFCOfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:35:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F19ADADDA;
        Mon,  3 Jun 2019 14:35:11 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/3] mm, debug_pagelloc: use static keys to enable debugging
Date:   Mon,  3 Jun 2019 16:34:49 +0200
Message-Id: <20190603143451.27353-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603143451.27353-1-vbabka@suse.cz>
References: <20190603143451.27353-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_PAGEALLOC has been redesigned by 031bc5743f15
("mm/debug-pagealloc: make debug-pagealloc boottime configurable") to allow
being always enabled in a distro kernel, but only perform its expensive
functionality when booted with debug_pagelloc=on. We can further reduce
the overhead when not boot-enabled (including page allocator fast paths) using
static keys. This patch introduces one for debug_pagealloc core functionality,
and another for the optional guard page functionality (enabled by booting with
debug_guardpage_minorder=X).

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/mm.h | 15 +++++++++++----
 mm/page_alloc.c    | 23 +++++++++++++++++------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0e8834ac32b7..c71ed22769f3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2685,11 +2685,18 @@ static inline void kernel_poison_pages(struct page *page, int numpages,
 					int enable) { }
 #endif
 
-extern bool _debug_pagealloc_enabled;
+#ifdef CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
+DECLARE_STATIC_KEY_TRUE(_debug_pagealloc_enabled);
+#else
+DECLARE_STATIC_KEY_FALSE(_debug_pagealloc_enabled);
+#endif
 
 static inline bool debug_pagealloc_enabled(void)
 {
-	return IS_ENABLED(CONFIG_DEBUG_PAGEALLOC) && _debug_pagealloc_enabled;
+	if (!IS_ENABLED(CONFIG_DEBUG_PAGEALLOC))
+		return false;
+
+	return static_branch_unlikely(&_debug_pagealloc_enabled);
 }
 
 #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
@@ -2843,7 +2850,7 @@ extern struct page_ext_operations debug_guardpage_ops;
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 extern unsigned int _debug_guardpage_minorder;
-extern bool _debug_guardpage_enabled;
+DECLARE_STATIC_KEY_FALSE(_debug_guardpage_enabled);
 
 static inline unsigned int debug_guardpage_minorder(void)
 {
@@ -2852,7 +2859,7 @@ static inline unsigned int debug_guardpage_minorder(void)
 
 static inline bool debug_guardpage_enabled(void)
 {
-	return _debug_guardpage_enabled;
+	return static_branch_unlikely(&_debug_guardpage_enabled);
 }
 
 static inline bool page_is_guard(struct page *page)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d66bc8abe0af..639f1f9e74c5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -646,16 +646,27 @@ void prep_compound_page(struct page *page, unsigned int order)
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 unsigned int _debug_guardpage_minorder;
-bool _debug_pagealloc_enabled __read_mostly
-			= IS_ENABLED(CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT);
+
+#ifdef CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
+DEFINE_STATIC_KEY_TRUE(_debug_pagealloc_enabled);
+#else
+DEFINE_STATIC_KEY_FALSE(_debug_pagealloc_enabled);
+#endif
 EXPORT_SYMBOL(_debug_pagealloc_enabled);
-bool _debug_guardpage_enabled __read_mostly;
+
+DEFINE_STATIC_KEY_FALSE(_debug_guardpage_enabled);
 
 static int __init early_debug_pagealloc(char *buf)
 {
-	if (!buf)
+	bool enable = false;
+
+	if (kstrtobool(buf, &enable))
 		return -EINVAL;
-	return kstrtobool(buf, &_debug_pagealloc_enabled);
+
+	if (enable)
+		static_branch_enable(&_debug_pagealloc_enabled);
+
+	return 0;
 }
 early_param("debug_pagealloc", early_debug_pagealloc);
 
@@ -679,7 +690,7 @@ static void init_debug_guardpage(void)
 	if (!debug_guardpage_minorder())
 		return;
 
-	_debug_guardpage_enabled = true;
+	static_branch_enable(&_debug_guardpage_enabled);
 }
 
 struct page_ext_operations debug_guardpage_ops = {
-- 
2.21.0

