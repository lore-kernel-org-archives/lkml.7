Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB663C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A694320851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sdf.org header.i=@sdf.org header.b="HSl6NL/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfCIDUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 22:20:54 -0500
Received: from mx.sdf.org ([205.166.94.20]:51593 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfCIDUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 22:20:49 -0500
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Mar 2019 22:20:48 EST
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x293Cs94014204
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 9 Mar 2019 03:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdf.org; s=default;
        t=1552101180; bh=brF9XphpbSn9Mfx8cikRhp0K28ZygSdXB66FqcMQuEg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc;
        b=HSl6NL/dkhLhRRXphh5mT3OeX38FC6w7bpj+Vvp9hZe+pYkKPT05VFC8HfnO5tWyS
         JF0KBmECxwe0V2oU0/k/6LSTLNShY45Ms2rgR3X9LR86ppMKtPMCzxx3svoxvA9rIO
         zRIl2PTeGk5C8DREGbHHgjCgpW4Nl/p1sqRJF7gQ=
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x293Cs1C027088;
        Sat, 9 Mar 2019 03:12:54 GMT
Message-Id: <a98fba2d48042fa5a2defca4ef694a35ee227510.1552097842.git.lkml@sdf.org>
In-Reply-To: <cover.1552097842.git.lkml@sdf.org>
References: <cover.1552097842.git.lkml@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Thu, 21 Feb 2019 08:21:42 +0000
Subject: [PATCH 3/5] lib/sort: Avoid indirect calls to built-in swap
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

Similar to what's being done in the net code, this takes advantage of
the fact that most invocations use only a few common swap functions, and
replaces indirect calls to them with (highly predictable) conditional
branches.  (The downside, of course, is that if you *do* use a custom
swap function, there are a few additional (highly predictable) conditional
branches on the code path.)

This actually *shrinks* the x86-64 code, because it inlines the various
swap functions inside do_swap, eliding function prologues & epilogues.

x86-64 code size 770 -> 709 bytes (-61)

Signed-off-by: George Spelvin <lkml@sdf.org>
---
 lib/sort.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/lib/sort.c b/lib/sort.c
index 2aef4631e7d3..226a8c7e4b9a 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -117,6 +117,33 @@ static void generic_swap(void *a, void *b, int size)
 	} while (n);
 }
 
+typedef void (*swap_func_t)(void *a, void *b, int size);
+
+/*
+ * The values are arbitrary as long as they can't be confused with
+ * a pointer, but small integers make for the smallest compare
+ * instructions.
+ */
+#define U64_SWAP (swap_func_t)0
+#define U32_SWAP (swap_func_t)1
+#define GENERIC_SWAP (swap_func_t)2
+
+/*
+ * The function pointer is last to make tail calls most efficient if the
+ * compiler decides not to inline this function.
+ */
+static void do_swap(void *a, void *b, int size, swap_func_t swap_func)
+{
+	if (swap_func == U64_SWAP)
+		u64_swap(a, b, size);
+	else if (swap_func == U32_SWAP)
+		u32_swap(a, b, size);
+	else if (swap_func == GENERIC_SWAP)
+		generic_swap(a, b, size);
+	else
+		swap_func(a, b, size);
+}
+
 /**
  * parent - given the offset of the child, find the offset of the parent.
  * @i: the offset of the heap element whose parent is sought.  Non-zero.
@@ -151,10 +178,10 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
  * @cmp_func: pointer to comparison function
  * @swap_func: pointer to swap function or NULL
  *
- * This function does a heapsort on the given array.  You may provide a
- * swap_func function if you need to do something more than a memory copy
- * (e.g. fix up pointers or auxiliary data), but the built-in swap isn't
- * usually a bottleneck.
+ * This function does a heapsort on the given array.  You may provide
+ * a swap_func function if you need to do something more than a memory
+ * copy (e.g. fix up pointers or auxiliary data), but the built-in swap
+ * avoids a slow retpoline and so is significantly faster.
  *
  * Sorting time is O(n log n) both on average and worst-case. While
  * qsort is about 20% faster on average, it suffers from exploitable
@@ -174,11 +201,11 @@ void sort(void *base, size_t num, size_t size,
 
 	if (!swap_func) {
 		if (alignment_ok(base, size, 8))
-			swap_func = u64_swap;
+			swap_func = U64_SWAP;
 		else if (alignment_ok(base, size, 4))
-			swap_func = u32_swap;
+			swap_func = U32_SWAP;
 		else
-			swap_func = generic_swap;
+			swap_func = GENERIC_SWAP;
 	}
 
 	/*
@@ -194,7 +221,7 @@ void sort(void *base, size_t num, size_t size,
 		if (a)			/* Building heap: sift down --a */
 			a -= size;
 		else if (n -= size)	/* Sorting: Extract root to --n */
-			swap_func(base, base + n, size);
+			do_swap(base, base + n, size, swap_func);
 		else			/* Sort complete */
 			break;
 
@@ -221,7 +248,7 @@ void sort(void *base, size_t num, size_t size,
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

