Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4348BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107DA218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfCPDvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:51:43 -0400
Received: from mx.sdf.org ([205.166.94.20]:60526 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfCPDvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:51:42 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2G3pHtl018228
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 16 Mar 2019 03:51:17 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2G3pHq1016177;
        Sat, 16 Mar 2019 03:51:17 GMT
Message-Id: <f24f932df3a7fa1973c1084154f1cea596bcf341.1552704199.git.lkml@sdf.org>
In-Reply-To: <cover.1552704199.git.lkml@sdf.org>
References: <cover.1552704199.git.lkml@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Thu, 21 Feb 2019 06:30:28 +0000
Subject: [PATCH v2 1/5] lib/sort: Make swap functions more generic
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

Rather than having special-case swap functions for 4- and 8-byte objects,
special-case aligned multiples of 4 or 8 bytes.  This speeds up most
users of sort() by avoiding fallback to the byte copy loop.

Despite what commit ca96ab859ab4 ("lib/sort: Add 64 bit swap function")
claims, very few users of sort() sort pointers (or pointer-sized
objects); most sort structures containing at least two words.
(E.g. drivers/acpi/fan.c:acpi_fan_get_fps() sorts an array of 40-byte
struct acpi_fan_fps.)

The functions also got renamed to reflect the fact that they support
multiple words.  In the great tradition of bikeshedding, the names were
by far the most contentious issue during review of this patch series.

x86-64 code size 872 -> 886 bytes (+14)

Signed-off-by: George Spelvin <lkml@sdf.org>
Acked-by: Andrey Abramov <st5pub@yandex.ru>
Feedback-from: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Feedback-from: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Feedback-from: Geert Uytterhoeven <geert@linux-m68k.org>
---
 lib/sort.c | 135 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 105 insertions(+), 30 deletions(-)

diff --git a/lib/sort.c b/lib/sort.c
index d6b7a202b0b6..ec79eac85e21 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -11,35 +11,108 @@
 #include <linux/export.h>
 #include <linux/sort.h>
 
-static int alignment_ok(const void *base, int align)
+/**
+ * is_aligned - is this pointer & size okay for word-wide copying?
+ * @base: pointer to data
+ * @size: size of each element
+ * @align: required aignment (typically 4 or 8)
+ *
+ * Returns true if elements can be copied using word loads and stores.
+ * The size must be a multiple of the alignment, and the base address must
+ * be if we do not have CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
+ *
+ * For some reason, gcc doesn't know to optimize "if (a & mask || b & mask)"
+ * to "if ((a | b) & mask)", so we do that by hand.
+ */
+__attribute_const__ __always_inline
+static bool is_aligned(const void *base, size_t size, unsigned char align)
 {
-	return IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ||
-		((unsigned long)base & (align - 1)) == 0;
+	unsigned char lsbits = (unsigned char)size;
+
+	(void)base;
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	lsbits |= (unsigned char)(uintptr_t)base;
+#endif
+	return (lsbits & (align - 1)) == 0;
 }
 
-static void u32_swap(void *a, void *b, int size)
+/**
+ * swap_words_32 - swap two elements in 32-bit chunks
+ * @a, @b: pointers to the elements
+ * @size: element size (must be a multiple of 4)
+ *
+ * Exchange the two objects in memory.  This exploits base+index addressing,
+ * which basically all CPUs have, to minimize loop overhead computations.
+ *
+ * For some reason, on x86 gcc 7.3.0 adds a redundant test of n at the
+ * bottom of the loop, even though the zero flag is stil valid from the
+ * subtract (since the intervening mov instructions don't alter the flags).
+ * Gcc 8.1.0 doesn't have that problem.
+ */
+static void swap_words_32(void *a, void *b, int size)
 {
-	u32 t = *(u32 *)a;
-	*(u32 *)a = *(u32 *)b;
-	*(u32 *)b = t;
-}
-
-static void u64_swap(void *a, void *b, int size)
-{
-	u64 t = *(u64 *)a;
-	*(u64 *)a = *(u64 *)b;
-	*(u64 *)b = t;
-}
-
-static void generic_swap(void *a, void *b, int size)
-{
-	char t;
+	size_t n = (unsigned int)size;
 
 	do {
-		t = *(char *)a;
-		*(char *)a++ = *(char *)b;
-		*(char *)b++ = t;
-	} while (--size > 0);
+		u32 t = *(u32 *)(a + (n -= 4));
+		*(u32 *)(a + n) = *(u32 *)(b + n);
+		*(u32 *)(b + n) = t;
+	} while (n);
+}
+
+/**
+ * swap_words_64 - swap two elements in 64-bit chunks
+ * @a, @b: pointers to the elements
+ * @size: element size (must be a multiple of 8)
+ *
+ * Exchange the two objects in memory.  This exploits base+index
+ * addressing, which basically all CPUs have, to minimize loop overhead
+ * computations.
+ *
+ * We'd like to use 64-bit loads if possible.  If they're not, emulating
+ * one requires base+index+4 addressing which x86 has but most other
+ * processors do not.  If CONFIG_64BIT, we definitely have 64-bit loads,
+ * but it's possible to have 64-bit loads without 64-bit pointers (e.g.
+ * x32 ABI).  Are there any cases the kernel needs to worry about?
+ */
+static void swap_words_64(void *a, void *b, int size)
+{
+	size_t n = (unsigned int)size;
+
+	do {
+#ifdef CONFIG_64BIT
+		u64 t = *(u64 *)(a + (n -= 8));
+		*(u64 *)(a + n) = *(u64 *)(b + n);
+		*(u64 *)(b + n) = t;
+#else
+		/* Use two 32-bit transfers to avoid base+index+4 addressing */
+		u32 t = *(u32 *)(a + (n -= 4));
+		*(u32 *)(a + n) = *(u32 *)(b + n);
+		*(u32 *)(b + n) = t;
+
+		t = *(u32 *)(a + (n -= 4));
+		*(u32 *)(a + n) = *(u32 *)(b + n);
+		*(u32 *)(b + n) = t;
+#endif
+	} while (n);
+}
+
+/**
+ * swap_bytes - swap two elements a byte at a time
+ * @a, @b: pointers to the elements
+ * @size: element size
+ *
+ * This is the fallback if alignment doesn't allow using larger chunks.
+ */
+static void swap_bytes(void *a, void *b, int size)
+{
+	size_t n = (unsigned int)size;
+
+	do {
+		char t = ((char *)a)[--n];
+		((char *)a)[n] = ((char *)b)[n];
+		((char *)b)[n] = t;
+	} while (n);
 }
 
 /**
@@ -50,8 +123,10 @@ static void generic_swap(void *a, void *b, int size)
  * @cmp_func: pointer to comparison function
  * @swap_func: pointer to swap function or NULL
  *
- * This function does a heapsort on the given array. You may provide a
- * swap_func function optimized to your element type.
+ * This function does a heapsort on the given array.  You may provide
+ * a swap_func function if you need to do something more than a memory
+ * copy (e.g. fix up pointers or auxiliary data), but the built-in swap
+ * isn't usually a bottleneck.
  *
  * Sorting time is O(n log n) both on average and worst-case. While
  * qsort is about 20% faster on average, it suffers from exploitable
@@ -67,12 +142,12 @@ void sort(void *base, size_t num, size_t size,
 	int i = (num/2 - 1) * size, n = num * size, c, r;
 
 	if (!swap_func) {
-		if (size == 4 && alignment_ok(base, 4))
-			swap_func = u32_swap;
-		else if (size == 8 && alignment_ok(base, 8))
-			swap_func = u64_swap;
+		if (is_aligned(base, size, 8))
+			swap_func = swap_words_64;
+		else if (is_aligned(base, size, 4))
+			swap_func = swap_words_32;
 		else
-			swap_func = generic_swap;
+			swap_func = swap_bytes;
 	}
 
 	/* heapify */
-- 
2.20.1

