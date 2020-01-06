Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AAEC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D7F21744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326845;
	bh=5d0kv6mVsryuDV8YoMh8Ye38O4dNbjKKr6EewHzcn+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ar4OYien94mJvRLdzuvOxak7wQJ9whPHi5S7Dazu3OqbYlu8A6Lyib/XQfSlwRCbB
	 +MwxBTPFnoprc662NZ0EnHAaTM1j6oL9ZQnd/9BqlTH4HC9wx7HOLwjBTvsBWHI0zM
	 HRw945jBY1I+C8hECFVjytBFMGb19W9J+tQd79j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgAFQHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:07:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgAFQHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:07:22 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18902081E;
        Mon,  6 Jan 2020 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326841;
        bh=5d0kv6mVsryuDV8YoMh8Ye38O4dNbjKKr6EewHzcn+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xj9meeyC5hekilZbw8jdtBPO9A9CEk+3mXKfBmcN76K1X+QLNTNEwDtJuWRBFFP89
         0wIsHsfchd4x1kYtEsOunuGqsbSj54iP+05L0Cy3Vm5MEZ9h55934aqVGaUeUQ0e2M
         Mhhl9uGojfGERSQggxDEqOEbUwpAZwb4K4MpgpgU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/20] tools bitmap: Implement bitmap_equal() operation at bitmap API
Date:   Mon,  6 Jan 2020 13:06:46 -0300
Message-Id: <20200106160705.10899-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Extend tools bitmap API with bitmap_equal() implementation.

The implementation has been derived from the kernel.

Extend tools bitmap API with bitmap_free() implementation for symmetry
with bitmap_alloc() function.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/43757993-0b28-d8af-a6c7-ede12e3a6877@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/bitmap.h | 30 ++++++++++++++++++++++++++++++
 tools/lib/bitmap.c           | 15 +++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 05dca5c203f3..477a1cae513f 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -15,6 +15,8 @@ void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, int bits);
 int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int bits);
+int __bitmap_equal(const unsigned long *bitmap1,
+		   const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
@@ -123,6 +125,15 @@ static inline unsigned long *bitmap_alloc(int nbits)
 	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
 }
 
+/*
+ * bitmap_free - Free bitmap
+ * @bitmap: pointer to bitmap
+ */
+static inline void bitmap_free(unsigned long *bitmap)
+{
+	free(bitmap);
+}
+
 /*
  * bitmap_scnprintf - print bitmap list into buffer
  * @bitmap: bitmap
@@ -148,4 +159,23 @@ static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
 	return __bitmap_and(dst, src1, src2, nbits);
 }
 
+#ifdef __LITTLE_ENDIAN
+#define BITMAP_MEM_ALIGNMENT 8
+#else
+#define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
+#endif
+#define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
+#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
+
+static inline int bitmap_equal(const unsigned long *src1,
+			const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
+	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
+	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
+		return !memcmp(src1, src2, nbits / 8);
+	return __bitmap_equal(src1, src2, nbits);
+}
+
 #endif /* _PERF_BITOPS_H */
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 38494782be06..5043747ef6c5 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -71,3 +71,18 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 			   BITMAP_LAST_WORD_MASK(bits));
 	return result != 0;
 }
+
+int __bitmap_equal(const unsigned long *bitmap1,
+		const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		if (bitmap1[k] != bitmap2[k])
+			return 0;
+
+	if (bits % BITS_PER_LONG)
+		if ((bitmap1[k] ^ bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
+			return 0;
+
+	return 1;
+}
-- 
2.21.1

