Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07001C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA915218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfCPDvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:51:40 -0400
Received: from mx.sdf.org ([205.166.94.20]:60532 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfCPDvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:51:40 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2G3pH4T023006
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 16 Mar 2019 03:51:18 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2G3pHxH012638;
        Sat, 16 Mar 2019 03:51:17 GMT
Message-Id: <2de8348635a1a421a72620677898c7fd5bd4b19d.1552704199.git.lkml@sdf.org>
In-Reply-To: <cover.1552704199.git.lkml@sdf.org>
References: <cover.1552704199.git.lkml@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Thu, 21 Feb 2019 08:21:42 +0000
Subject: [PATCH v2 2/5] lib/sort: Use more efficient bottom-up heapsort variant
To:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     George Spelvin <lkml@sdf.org>, Andrey Abramov <st5pub@yandex.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Don Mullis <don.mullis@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses fewer comparisons than the previous code (approaching half
as many for large random inputs), but produces identical results;
it actually performs the exact same series of swap operations.

Specifically, it reduces the average number of compares from
2*n*log2(n) - 3*n + o(n)  to  n*log2(n) + 0.37*n + o(n).

This is still 1.63*n worse than glibc qsort() which manages
n*log2(n) - 1.26*n, but at least the leading coefficient is correct.

Standard heapsort, when sifting down, performs two comparisons
per level: one to find the greater child, and a second to see
if the current node should be exchanged with that child.

Bottom-up heapsort observes that it's better to postpone the second
comparison and search for the leaf where -infinity would be sent
to, then search back *up* for the current node's destination.

Since sifting down usually proceeds to the leaf level (that's where
half the nodes are), this does O(1) second comparisons rather
than log2(n).  That saves a lot of (expensive since Spectre)
indirect function calls.

The one time it's worse than the previous code is if there are
large numbers of duplicate keys, when the top-down algorithm is
O(n) and bottom-up is O(n log n).  For distinct keys, it's provably
always better, doing 1.5*n*log2(n) + O(n) in the worst case.

(The code is not significantly more complex.  This patch also
merges the heap-building and -extracting sift-down loops,
resulting in a net code size savings.)

x86-64 code size 885 -> 767 bytes (-118)

(I see the checkpatch complaint about "else if (n -= size)".
The alternative is significantly uglier.)

Signed-off-by: George Spelvin <lkml@sdf.org>
Acked-by: Andrey Abramov <st5pub@yandex.ru>
---
 lib/sort.c | 110 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 30 deletions(-)

diff --git a/lib/sort.c b/lib/sort.c
index ec79eac85e21..0d24d0c5c0fc 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -1,8 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * A fast, small, non-recursive O(nlog n) sort for the Linux kernel
+ * A fast, small, non-recursive O(n log n) sort for the Linux kernel
  *
- * Jan 23 2005  Matt Mackall <mpm@selenic.com>
+ * This performs n*log2(n) + 0.37*n + o(n) comparisons on average,
+ * and 1.5*n*log2(n) + O(n) in the (very contrived) worst case.
+ *
+ * Glibc qsort() manages n*log2(n) - 1.26*n for random inputs (1.63*n
+ * better) at the expense of stack usage and much larger code to avoid
+ * quicksort's O(n^2) worst case.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -15,7 +20,7 @@
  * is_aligned - is this pointer & size okay for word-wide copying?
  * @base: pointer to data
  * @size: size of each element
- * @align: required aignment (typically 4 or 8)
+ * @align: required alignment (typically 4 or 8)
  *
  * Returns true if elements can be copied using word loads and stores.
  * The size must be a multiple of the alignment, and the base address must
@@ -115,6 +120,32 @@ static void swap_bytes(void *a, void *b, int size)
 	} while (n);
 }
 
+/**
+ * parent - given the offset of the child, find the offset of the parent.
+ * @i: the offset of the heap element whose parent is sought.  Non-zero.
+ * @lsbit: a precomputed 1-bit mask, equal to "size & -size"
+ * @size: size of each element
+ *
+ * In terms of array indexes, the parent of element j = @i/@size is simply
+ * (j-1)/2.  But when working in byte offsets, we can't use implicit
+ * truncation of integer divides.
+ *
+ * Fortunately, we only need one bit of the quotient, not the full divide.
+ * @size has a least significant bit.  That bit will be clear if @i is
+ * an even multiple of @size, and set if it's an odd multiple.
+ *
+ * Logically, we're doing "if (i & lsbit) i -= size;", but since the
+ * branch is unpredictable, it's done with a bit of clever branch-free
+ * code instead.
+ */
+__attribute_const__ __always_inline
+static size_t parent(size_t i, unsigned int lsbit, size_t size)
+{
+	i -= size;
+	i -= size & -(i & lsbit);
+	return i / 2;
+}
+
 /**
  * sort - sort an array of elements
  * @base: pointer to data to sort
@@ -129,17 +160,20 @@ static void swap_bytes(void *a, void *b, int size)
  * isn't usually a bottleneck.
  *
  * Sorting time is O(n log n) both on average and worst-case. While
- * qsort is about 20% faster on average, it suffers from exploitable
+ * quicksort is slightly faster on average, it suffers from exploitable
  * O(n*n) worst-case behavior and extra memory requirements that make
  * it less suitable for kernel use.
  */
-
 void sort(void *base, size_t num, size_t size,
 	  int (*cmp_func)(const void *, const void *),
 	  void (*swap_func)(void *, void *, int size))
 {
 	/* pre-scale counters for performance */
-	int i = (num/2 - 1) * size, n = num * size, c, r;
+	size_t n = num * size, a = (num/2) * size;
+	const unsigned int lsbit = size & -size;  /* Used to find parent */
+
+	if (!a)		/* num < 2 || size == 0 */
+		return;
 
 	if (!swap_func) {
 		if (is_aligned(base, size, 8))
@@ -150,32 +184,48 @@ void sort(void *base, size_t num, size_t size,
 			swap_func = swap_bytes;
 	}
 
-	/* heapify */
-	for ( ; i >= 0; i -= size) {
-		for (r = i; r * 2 + size < n; r  = c) {
-			c = r * 2 + size;
-			if (c < n - size &&
-					cmp_func(base + c, base + c + size) < 0)
-				c += size;
-			if (cmp_func(base + r, base + c) >= 0)
-				break;
-			swap_func(base + r, base + c, size);
-		}
-	}
+	/*
+	 * Loop invariants:
+	 * 1. elements [a,n) satisfy the heap property (compare greater than
+	 *    all of their children),
+	 * 2. elements [n,num*size) are sorted, and
+	 * 3. a <= b <= c <= d <= n (whenever they are valid).
+	 */
+	for (;;) {
+		size_t b, c, d;
 
-	/* sort */
-	for (i = n - size; i > 0; i -= size) {
-		swap_func(base, base + i, size);
-		for (r = 0; r * 2 + size < i; r = c) {
-			c = r * 2 + size;
-			if (c < i - size &&
-					cmp_func(base + c, base + c + size) < 0)
-				c += size;
-			if (cmp_func(base + r, base + c) >= 0)
-				break;
-			swap_func(base + r, base + c, size);
+		if (a)			/* Building heap: sift down --a */
+			a -= size;
+		else if (n -= size)	/* Sorting: Extract root to --n */
+			swap_func(base, base + n, size);
+		else			/* Sort complete */
+			break;
+
+		/*
+		 * Sift element at "a" down into heap.  This is the
+		 * "bottom-up" variant, which significantly reduces
+		 * calls to cmp_func(): we find the sift-down path all
+		 * the way to the leaves (one compare per level), then
+		 * backtrack to find where to insert the target element.
+		 *
+		 * Because elements tend to sift down close to the leaves,
+		 * this uses fewer compares than doing two per level
+		 * on the way down.  (A bit more than half as many on
+		 * average, 3/4 worst-case.)
+		 */
+		for (b = a; c = 2*b + size, (d = c + size) < n;)
+			b = cmp_func(base + c, base + d) >= 0 ? c : d;
+		if (d == n)	/* Special case last leaf with no sibling */
+			b = c;
+
+		/* Now backtrack from "b" to the correct location for "a" */
+		while (b != a && cmp_func(base + a, base + b) >= 0)
+			b = parent(b, lsbit, size);
+		c = b;			/* Where "a" belongs */
+		while (b != a) {	/* Shift it into place */
+			b = parent(b, lsbit, size);
+			swap_func(base + b, base + c, size);
 		}
 	}
 }
-
 EXPORT_SYMBOL(sort);
-- 
2.20.1

