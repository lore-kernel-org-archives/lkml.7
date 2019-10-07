Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C654FC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31FF20684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfJGN5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:57:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:11566 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGN5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:57:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 06:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="197395111"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Oct 2019 06:57:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 274BA14E; Mon,  7 Oct 2019 16:56:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        George Spelvin <lkml@sdf.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] lib/sort: Move swap, cmp and cmp_r function types for wider use
Date:   Mon,  7 Oct 2019 16:56:54 +0300
Message-Id: <20191007135656.37734-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function types for swap, cmp and cmp_r functions are already
being in use by modules.

Move them to types.h that everybody in kernel will be able to use
generic types instead of custom ones.

This adds more sense to the comment in bsearch() later on.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/sort.h  |  8 ++++----
 include/linux/types.h |  5 +++++
 lib/sort.c            | 15 +++++----------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/sort.h b/include/linux/sort.h
index 61b96d0ebc44..b5898725fe9d 100644
--- a/include/linux/sort.h
+++ b/include/linux/sort.h
@@ -5,12 +5,12 @@
 #include <linux/types.h>
 
 void sort_r(void *base, size_t num, size_t size,
-	    int (*cmp)(const void *, const void *, const void *),
-	    void (*swap)(void *, void *, int),
+	    cmp_r_func_t cmp_func,
+	    swap_func_t swap_func,
 	    const void *priv);
 
 void sort(void *base, size_t num, size_t size,
-	  int (*cmp)(const void *, const void *),
-	  void (*swap)(void *, void *, int));
+	  cmp_func_t cmp_func,
+	  swap_func_t swap_func);
 
 #endif
diff --git a/include/linux/types.h b/include/linux/types.h
index 05030f608be3..85c0e7b18153 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -225,5 +225,10 @@ struct callback_head {
 typedef void (*rcu_callback_t)(struct rcu_head *head);
 typedef void (*call_rcu_func_t)(struct rcu_head *head, rcu_callback_t func);
 
+typedef void (*swap_func_t)(void *a, void *b, int size);
+
+typedef int (*cmp_r_func_t)(const void *a, const void *b, const void *priv);
+typedef int (*cmp_func_t)(const void *a, const void *b);
+
 #endif /*  __ASSEMBLY__ */
 #endif /* _LINUX_TYPES_H */
diff --git a/lib/sort.c b/lib/sort.c
index d54cf97e9548..3ad454411997 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -117,8 +117,6 @@ static void swap_bytes(void *a, void *b, size_t n)
 	} while (n);
 }
 
-typedef void (*swap_func_t)(void *a, void *b, int size);
-
 /*
  * The values are arbitrary as long as they can't be confused with
  * a pointer, but small integers make for the smallest compare
@@ -144,12 +142,9 @@ static void do_swap(void *a, void *b, size_t size, swap_func_t swap_func)
 		swap_func(a, b, (int)size);
 }
 
-typedef int (*cmp_func_t)(const void *, const void *);
-typedef int (*cmp_r_func_t)(const void *, const void *, const void *);
 #define _CMP_WRAPPER ((cmp_r_func_t)0L)
 
-static int do_cmp(const void *a, const void *b,
-		  cmp_r_func_t cmp, const void *priv)
+static int do_cmp(const void *a, const void *b, cmp_r_func_t cmp, const void *priv)
 {
 	if (cmp == _CMP_WRAPPER)
 		return ((cmp_func_t)(priv))(a, b);
@@ -202,8 +197,8 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
  * it less suitable for kernel use.
  */
 void sort_r(void *base, size_t num, size_t size,
-	    int (*cmp_func)(const void *, const void *, const void *),
-	    void (*swap_func)(void *, void *, int size),
+	    cmp_r_func_t cmp_func,
+	    swap_func_t swap_func,
 	    const void *priv)
 {
 	/* pre-scale counters for performance */
@@ -269,8 +264,8 @@ void sort_r(void *base, size_t num, size_t size,
 EXPORT_SYMBOL(sort_r);
 
 void sort(void *base, size_t num, size_t size,
-	  int (*cmp_func)(const void *, const void *),
-	  void (*swap_func)(void *, void *, int size))
+	  cmp_func_t cmp_func,
+	  swap_func_t swap_func)
 {
 	return sort_r(base, num, size, _CMP_WRAPPER, swap_func, cmp_func);
 }
-- 
2.23.0

