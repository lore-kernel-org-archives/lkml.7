Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D89C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD52218EA
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfCPDvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:51:49 -0400
Received: from ol.sdf.org ([205.166.94.20]:60545 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbfCPDvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:51:40 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2G3pIl6022123
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 16 Mar 2019 03:51:18 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2G3pIWD017178;
        Sat, 16 Mar 2019 03:51:18 GMT
Message-Id: <d10c5d4b393a1847f32f5b26f4bbaa2857140e1e.1552704199.git.lkml@sdf.org>
In-Reply-To: <cover.1552704199.git.lkml@sdf.org>
References: <cover.1552704199.git.lkml@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Thu, 21 Feb 2019 08:21:42 +0000
Subject: [PATCH v2 3/5] lib/sort: Avoid indirect calls to built-in swap
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

Similar to what's being done in the net code, this takes advantage of
the fact that most invocations use only a few common swap functions, and
replaces indirect calls to them with (highly predictable) conditional
branches.  (The downside, of course, is that if you *do* use a custom
swap function, there are a few extra predicted branches on the code path.)

This actually *shrinks* the x86-64 code, because it inlines the various
swap functions inside do_swap, eliding function prologues & epilogues.

x86-64 code size 767 -> 703 bytes (-64)

Signed-off-by: George Spelvin <lkml@sdf.org>
Acked-by: Andrey Abramov <st5pub@yandex.ru>
---
 lib/sort.c | 51 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/lib/sort.c b/lib/sort.c
index 0d24d0c5c0fc..50855ea8c262 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -54,10 +54,8 @@ static bool is_aligned(const void *base, size_t size, unsigned char align)
  * subtract (since the intervening mov instructions don't alter the flags).
  * Gcc 8.1.0 doesn't have that problem.
  */
-static void swap_words_32(void *a, void *b, int size)
+static void swap_words_32(void *a, void *b, size_t n)
 {
-	size_t n = (unsigned int)size;
-
 	do {
 		u32 t = *(u32 *)(a + (n -= 4));
 		*(u32 *)(a + n) = *(u32 *)(b + n);
@@ -80,10 +78,8 @@ static void swap_words_32(void *a, void *b, int size)
  * but it's possible to have 64-bit loads without 64-bit pointers (e.g.
  * x32 ABI).  Are there any cases the kernel needs to worry about?
  */
-static void swap_words_64(void *a, void *b, int size)
+static void swap_words_64(void *a, void *b, size_t n)
 {
-	size_t n = (unsigned int)size;
-
 	do {
 #ifdef CONFIG_64BIT
 		u64 t = *(u64 *)(a + (n -= 8));
@@ -109,10 +105,8 @@ static void swap_words_64(void *a, void *b, int size)
  *
  * This is the fallback if alignment doesn't allow using larger chunks.
  */
-static void swap_bytes(void *a, void *b, int size)
+static void swap_bytes(void *a, void *b, size_t n)
 {
-	size_t n = (unsigned int)size;
-
 	do {
 		char t = ((char *)a)[--n];
 		((char *)a)[n] = ((char *)b)[n];
@@ -120,6 +114,33 @@ static void swap_bytes(void *a, void *b, int size)
 	} while (n);
 }
 
+typedef void (*swap_func_t)(void *a, void *b, int size);
+
+/*
+ * The values are arbitrary as long as they can't be confused with
+ * a pointer, but small integers make for the smallest compare
+ * instructions.
+ */
+#define SWAP_WORDS_64 (swap_func_t)0
+#define SWAP_WORDS_32 (swap_func_t)1
+#define SWAP_BYTES    (swap_func_t)2
+
+/*
+ * The function pointer is last to make tail calls most efficient if the
+ * compiler decides not to inline this function.
+ */
+static void do_swap(void *a, void *b, size_t size, swap_func_t swap_func)
+{
+	if (swap_func == SWAP_WORDS_64)
+		swap_words_64(a, b, size);
+	else if (swap_func == SWAP_WORDS_32)
+		swap_words_32(a, b, size);
+	else if (swap_func == SWAP_BYTES)
+		swap_bytes(a, b, size);
+	else
+		swap_func(a, b, (int)size);
+}
+
 /**
  * parent - given the offset of the child, find the offset of the parent.
  * @i: the offset of the heap element whose parent is sought.  Non-zero.
@@ -157,7 +178,7 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
  * This function does a heapsort on the given array.  You may provide
  * a swap_func function if you need to do something more than a memory
  * copy (e.g. fix up pointers or auxiliary data), but the built-in swap
- * isn't usually a bottleneck.
+ * avoids a slow retpoline and so is significantly faster.
  *
  * Sorting time is O(n log n) both on average and worst-case. While
  * quicksort is slightly faster on average, it suffers from exploitable
@@ -177,11 +198,11 @@ void sort(void *base, size_t num, size_t size,
 
 	if (!swap_func) {
 		if (is_aligned(base, size, 8))
-			swap_func = swap_words_64;
+			swap_func = SWAP_WORDS_64;
 		else if (is_aligned(base, size, 4))
-			swap_func = swap_words_32;
+			swap_func = SWAP_WORDS_32;
 		else
-			swap_func = swap_bytes;
+			swap_func = SWAP_BYTES;
 	}
 
 	/*
@@ -197,7 +218,7 @@ void sort(void *base, size_t num, size_t size,
 		if (a)			/* Building heap: sift down --a */
 			a -= size;
 		else if (n -= size)	/* Sorting: Extract root to --n */
-			swap_func(base, base + n, size);
+			do_swap(base, base + n, size, swap_func);
 		else			/* Sort complete */
 			break;
 
@@ -224,7 +245,7 @@ void sort(void *base, size_t num, size_t size,
 		c = b;			/* Where "a" belongs */
 		while (b != a) {	/* Shift it into place */
 			b = parent(b, lsbit, size);
-			swap_func(base + b, base + c, size);
+			do_swap(base + b, base + c, size, swap_func);
 		}
 	}
 }
-- 
2.20.1

