Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD92C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54902072C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfKNSTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:19:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbfKNSS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB32C20885;
        Thu, 14 Nov 2019 18:18:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhL-0001AD-4E; Thu, 14 Nov 2019 13:18:27 -0500
Message-Id: <20191114181827.011662595@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [for-next][PATCH 25/33] lib/sort: Move swap, cmp and cmp_r function types for wider use
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The function types for swap, cmp and cmp_r functions are already
being in use by modules.

Move them to types.h that everybody in kernel will be able to use
generic types instead of custom ones.

This adds more sense to the comment in bsearch() later on.

Link: http://lkml.kernel.org/r/20191007135656.37734-1-andriy.shevchenko@linux.intel.com

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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


