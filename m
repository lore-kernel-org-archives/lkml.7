Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EBAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9B8217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfEVLZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 07:25:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55126 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfEVLZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 07:25:56 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E5254260D66;
        Wed, 22 May 2019 12:25:54 +0100 (BST)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     George Spelvin <lkml@sdf.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Abramov <st5pub@yandex.ru>, kernel@collabora.com,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH] lib/sort: Add the sort_r() variant
Date:   Wed, 22 May 2019 13:25:50 +0200
Message-Id: <20190522112550.31814-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users might need extra context to compare 2 elements. This patch
adds the sort_r() which is similar to the qsort_r() variant of qsort().

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Hello,

A few more details about this patch.

Even though I post it as a standalone patch, I do intend to use it in
a real driver (v4l2 driver), just didn't want to have it burried in a
huge patch series.

Note that sort() and sort_r() are now implemented as wrappers around
do_sort() so that most of the code can be shared. I initially went for
a solution that implemented sort() as a wrapper around sort_r() (which
basically contained the do_sort() logic without the cmp_func arg)
but realized this was adding one extra indirect call (the compare func
wrapper), which I know are being chased.

There's another option, but I'm pretty sure other people already
considered it and thought it was not a good idea as it would make
the code size grow: move the code to sort.h as inline funcs/macros so
that the compiler can optimize things out and replace the indirect
cmp_func() calls by direct ones. I just tried it, and it makes my .o
file grow by 576 bytes, given that we currently have 122 users of
this function, that makes the kernel code grow by ~70k (that's kind
of a max estimate since not all users will be compiled in).

Please let me know if you think we shouldn't expose the sort_r() func
and I'll just implement a private version in my driver.

Regards,

Boris
---
 include/linux/sort.h |  5 +++
 lib/sort.c           | 85 ++++++++++++++++++++++++++++++++------------
 2 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/include/linux/sort.h b/include/linux/sort.h
index 2b99a5dd073d..61b96d0ebc44 100644
--- a/include/linux/sort.h
+++ b/include/linux/sort.h
@@ -4,6 +4,11 @@
 
 #include <linux/types.h>
 
+void sort_r(void *base, size_t num, size_t size,
+	    int (*cmp)(const void *, const void *, const void *),
+	    void (*swap)(void *, void *, int),
+	    const void *priv);
+
 void sort(void *base, size_t num, size_t size,
 	  int (*cmp)(const void *, const void *),
 	  void (*swap)(void *, void *, int));
diff --git a/lib/sort.c b/lib/sort.c
index 50855ea8c262..5db5602e52ee 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -167,27 +167,21 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
 	return i / 2;
 }
 
-/**
- * sort - sort an array of elements
- * @base: pointer to data to sort
- * @num: number of elements
- * @size: size of each element
- * @cmp_func: pointer to comparison function
- * @swap_func: pointer to swap function or NULL
- *
- * This function does a heapsort on the given array.  You may provide
- * a swap_func function if you need to do something more than a memory
- * copy (e.g. fix up pointers or auxiliary data), but the built-in swap
- * avoids a slow retpoline and so is significantly faster.
- *
- * Sorting time is O(n log n) both on average and worst-case. While
- * quicksort is slightly faster on average, it suffers from exploitable
- * O(n*n) worst-case behavior and extra memory requirements that make
- * it less suitable for kernel use.
- */
-void sort(void *base, size_t num, size_t size,
-	  int (*cmp_func)(const void *, const void *),
-	  void (*swap_func)(void *, void *, int size))
+static int do_cmp(int (*cmp_func_r)(const void *, const void *, const void *),
+		  int (*cmp_func)(const void *, const void *),
+		  const void *a, const void *b, const void *priv)
+{
+	if (cmp_func)
+		return cmp_func(a, b);
+
+	return cmp_func_r(a, b, priv);
+}
+
+static void do_sort(void *base, size_t num, size_t size,
+		    int (*cmp_func_r)(const void *, const void *, const void *),
+		    int (*cmp_func)(const void *, const void *),
+		    void (*swap_func)(void *, void *, int size),
+		    const void *priv)
 {
 	/* pre-scale counters for performance */
 	size_t n = num * size, a = (num/2) * size;
@@ -235,12 +229,12 @@ void sort(void *base, size_t num, size_t size,
 		 * average, 3/4 worst-case.)
 		 */
 		for (b = a; c = 2*b + size, (d = c + size) < n;)
-			b = cmp_func(base + c, base + d) >= 0 ? c : d;
+			b = do_cmp(cmp_func_r, cmp_func, base + c, base + d, priv) >= 0 ? c : d;
 		if (d == n)	/* Special case last leaf with no sibling */
 			b = c;
 
 		/* Now backtrack from "b" to the correct location for "a" */
-		while (b != a && cmp_func(base + a, base + b) >= 0)
+		while (b != a && do_cmp(cmp_func_r, cmp_func, base + a, base + b, priv) >= 0)
 			b = parent(b, lsbit, size);
 		c = b;			/* Where "a" belongs */
 		while (b != a) {	/* Shift it into place */
@@ -249,4 +243,49 @@ void sort(void *base, size_t num, size_t size,
 		}
 	}
 }
+
+/**
+ * sort - sort an array of elements
+ * @base: pointer to data to sort
+ * @num: number of elements
+ * @size: size of each element
+ * @cmp_func: pointer to comparison function
+ * @swap_func: pointer to swap function or NULL
+ *
+ * This function does a heapsort on the given array. You may provide a
+ * swap_func function optimized to your element type.
+ *
+ * Sorting time is O(n log n) both on average and worst-case. While
+ * qsort is about 20% faster on average, it suffers from exploitable
+ * O(n*n) worst-case behavior and extra memory requirements that make
+ * it less suitable for kernel use.
+ */
+void sort(void *base, size_t num, size_t size,
+	  int (*cmp_func)(const void *, const void *),
+	  void (*swap_func)(void *, void *, int size))
+{
+	return do_sort(base, num, size, NULL, cmp_func, swap_func, NULL);
+}
 EXPORT_SYMBOL(sort);
+
+/**
+ * sort_r - sort an array of elements
+ * @base: pointer to data to sort
+ * @num: number of elements
+ * @size: size of each element
+ * @cmp_func: pointer to comparison function
+ * @swap_func: pointer to swap function or NULL
+ * @priv: private data passed to the compare function
+ *
+ * Same as sort() except it takes an extra private argument and pass it back
+ * to the compare function. Particularly useful when some extra context is
+ * needed to do the comparison.
+ */
+void sort_r(void *base, size_t num, size_t size,
+	    int (*cmp_func)(const void *, const void *, const void *),
+	    void (*swap_func)(void *, void *, int size),
+	    const void *priv)
+{
+	return do_sort(base, num, size, cmp_func, NULL, swap_func, priv);
+}
+EXPORT_SYMBOL(sort_r);
-- 
2.20.1

