Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7DDC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3C820851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfCIDVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 22:21:45 -0500
Received: from mx.sdf.org ([205.166.94.20]:51593 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfCIDVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 22:21:45 -0500
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Mar 2019 22:20:48 EST
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x293CYeS024266
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 9 Mar 2019 03:12:34 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x293CY3N022442;
        Sat, 9 Mar 2019 03:12:34 GMT
Message-Id: <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>
In-Reply-To: <cover.1552097842.git.lkml@sdf.org>
References: <cover.1552097842.git.lkml@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Thu, 21 Feb 2019 06:30:28 +0000
Subject: [PATCH 1/5] lib/sort: Make swap functions more generic
To:     linux-kernel@vger.kernel.org
Cc:     George Spelvin <lkml@sdf.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Abramov <st5pub@yandex.ru>,
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

Rather than u32_swap and u64_swap working on 4- and 8-byte objects
directly, let them handle any multiple of 4 or 8 bytes.  This speeds
up most users of sort() by avoiding fallback to the byte copy loop.

Despite what commit ca96ab859ab4 ("lib/sort: Add 64 bit swap function")
claims, very few users of sort() sort pointers (or pointer-sized
objects); most sort structures containing at least two words.
(E.g. drivers/acpi/fan.c:acpi_fan_get_fps() sorts an array of 40-byte
struct acpi_fan_fps.)

x86-64 code size 872 -> 885 bytes (+8)

Signed-off-by: George Spelvin <lkml@sdf.org>
---
 lib/sort.c | 117 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 21 deletions(-)

diff --git a/lib/sort.c b/lib/sort.c
index d6b7a202b0b6..dff2ab2e196e 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -11,35 +11,110 @@
 #include <linux/export.h>
 #include <linux/sort.h>
 
-static int alignment_ok(const void *base, int align)
+/**
+ * alignment_ok - is this pointer & size okay for word-wide copying?
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
+static bool __attribute_const__
+alignment_ok(const void *base, size_t size, unsigned int align)
 {
-	return IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ||
-		((unsigned long)base & (align - 1)) == 0;
+	unsigned int lsbits = (unsigned int)size;
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	(void)base;
+#else
+	lsbits |= (unsigned int)(size_t)base;
+#endif
+	lsbits &= align - 1;
+	return lsbits == 0;
 }
 
+/**
+ * u32_swap - swap two elements in 32-bit chunks
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
 static void u32_swap(void *a, void *b, int size)
 {
-	u32 t = *(u32 *)a;
-	*(u32 *)a = *(u32 *)b;
-	*(u32 *)b = t;
+	size_t n = size;
+
+	do {
+		u32 t = *(u32 *)(a + (n -= 4));
+		*(u32 *)(a + n) = *(u32 *)(b + n);
+		*(u32 *)(b + n) = t;
+	} while (n);
 }
 
+/**
+ * u64_swap - swap two elements in 64-bit chunks
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
+
 static void u64_swap(void *a, void *b, int size)
 {
-	u64 t = *(u64 *)a;
-	*(u64 *)a = *(u64 *)b;
-	*(u64 *)b = t;
-}
-
-static void generic_swap(void *a, void *b, int size)
-{
-	char t;
+	size_t n = size;
 
 	do {
-		t = *(char *)a;
-		*(char *)a++ = *(char *)b;
-		*(char *)b++ = t;
-	} while (--size > 0);
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
+ * generic_swap - swap two elements a byte at a time
+ * @a, @b: pointers to the elements
+ * @size: element size
+ *
+ * This is the fallback if alignment doesn't allow using larger chunks.
+ */
+static void generic_swap(void *a, void *b, int size)
+{
+	size_t n = size;
+
+	do {
+		char t = ((char *)a)[--n];
+		((char *)a)[n] = ((char *)b)[n];
+		((char *)b)[n] = t;
+	} while (n);
 }
 
 /**
@@ -67,10 +142,10 @@ void sort(void *base, size_t num, size_t size,
 	int i = (num/2 - 1) * size, n = num * size, c, r;
 
 	if (!swap_func) {
-		if (size == 4 && alignment_ok(base, 4))
-			swap_func = u32_swap;
-		else if (size == 8 && alignment_ok(base, 8))
+		if (alignment_ok(base, size, 8))
 			swap_func = u64_swap;
+		else if (alignment_ok(base, size, 4))
+			swap_func = u32_swap;
 		else
 			swap_func = generic_swap;
 	}
-- 
2.20.1

