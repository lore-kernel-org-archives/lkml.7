Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A66CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7B720693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTqUtj30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCNM3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:29:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45756 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfCNM3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:29:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id v21so3710815pfm.12;
        Thu, 14 Mar 2019 05:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=voPjJIpaEIENDSX5D22rQL6GtMzeJ5e93HyvmN9lrck=;
        b=pTqUtj30cxrD+gvouv7l3w0sFX0bU95MZfqL2IhBnTFd3ZXuG/F5ODVBg9kgA9QzHs
         r3mDBmiOdL+UC7yLlhKjBcQ36z0WatAFhJT2WDUW9Ync2XxWNO3qNODGTvVMlbhOOXpj
         lefjWJGy+IWcFMkn6iVeqNNz5N+0ijmh/LpNpFp97+yrMMq7gZ+OwYHQJNm3lzvfByRj
         Mh0Fjho/B5rZRA/iSHmM5FyRH+snx0QBJjNfgzqxiv5mjFlQj3tnpez3VKh0d6z3rzE8
         RNt/AhoyDOsoSHal0yMP+L9rQ2hK6bRHJ38L63OkIDRR9fgMUXTT+9kbS3Ezmq7LFXrw
         hecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=voPjJIpaEIENDSX5D22rQL6GtMzeJ5e93HyvmN9lrck=;
        b=RU6504IS+mCvfOkir/B14U6rT9LUJ85WE59XchOaYUzUMuS9OJ7hz/9GPPqoN3nqyC
         YASnBS/NYPUvlqJi7q7OW2zzrIYowB+ETrQbwMdYekAZTp9xbQvaNUnf4icuAQzK3FMm
         2V8g5sphKJXyoF6ai65Y007rCLr88jcs8KkJjtUx0mOIQ+kUUlbKDCNsKhP4DEZN5EtC
         ddbfzq4/eHTf8UQx6nBI3Dlbsh88/KnH6tCSNWw3p0FKyUOifjZ6zwfqKbiHjjBjYUXl
         h3NzKVEZCYKPxfEtlScQrb8ZER+pnG85XfM5vrEHKbFcq4KTYhB+9Lv/8J1iBmn+2v6Q
         xJTw==
X-Gm-Message-State: APjAAAVIq7Xqo9I3rlS3fW5PB3iUR5fbWZ9bwITa3Eas3HGc9W6NGZI1
        d1MMLg8H9si1tlfa1mQmP20=
X-Google-Smtp-Source: APXvYqy5UvtD/Kf3+GFJlYe8rHPF7gTdnvCaAjrNRw0ivGvgRMuD2mN3+AT9okFrXWaVOTJwEpNVnQ==
X-Received: by 2002:a63:da58:: with SMTP id l24mr9806796pgj.167.1552566571813;
        Thu, 14 Mar 2019 05:29:31 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a4:3974:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id k189sm13888301pgk.21.2019.03.14.05.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:29:31 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v10 02/10] lib/test_bitmap.c: Add for_each_set_clump8 test cases
Date:   Thu, 14 Mar 2019 21:30:24 +0900
Message-Id: <d8b1d019aeca402eea7caf24614e9ce0a604cfc9.1552566114.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1552566113.git.vilhelm.gray@gmail.com>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of the for_each_set_clump8 macro warrants test cases to
verify the implementation. This patch adds test case checks for whether
an out-of-bounds clump index is returned, a zero clump is returned, or
the returned clump value differs from the expected clump value.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 lib/test_bitmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6cd7d0740005..8d1f268069c1 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -88,6 +88,36 @@ __check_eq_u32_array(const char *srcfile, unsigned int line,
 	return true;
 }
 
+static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
+				    const unsigned int offset,
+				    const unsigned int size,
+				    const unsigned char *const clump_exp,
+				    const unsigned long *const clump)
+{
+	unsigned long exp;
+
+	if (offset >= size) {
+		pr_warn("[%s:%u] bit offset for clump out-of-bounds: expected less than %u, got %u\n",
+			srcfile, line, size, offset);
+		return false;
+	}
+
+	exp = clump_exp[offset / 8];
+	if (!exp) {
+		pr_warn("[%s:%u] bit offset for zero clump: expected nonzero clump, got bit offset %u with clump value 0",
+			srcfile, line, offset);
+		return false;
+	}
+
+	if (*clump != exp) {
+		pr_warn("[%s:%u] expected clump value of 0x%lX, got clump value of 0x%lX",
+			srcfile, line, exp, *clump);
+		return false;
+	}
+
+	return true;
+}
+
 #define __expect_eq(suffix, ...)					\
 	({								\
 		int result = 0;						\
@@ -104,6 +134,7 @@ __check_eq_u32_array(const char *srcfile, unsigned int line,
 #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
+#define expect_eq_clump8(...)		__expect_eq(clump8, ##__VA_ARGS__)
 
 static void __init test_zero_clear(void)
 {
@@ -361,6 +392,39 @@ static void noinline __init test_mem_optimisations(void)
 	}
 }
 
+static const unsigned char clump_exp[] __initconst = {
+	0x01,	/* 1 bit set */
+	0x02,	/* non-edge 1 bit set */
+	0x00,	/* zero bits set */
+	0x38,	/* 3 bits set across 4-bit boundary */
+	0x38,	/* Repeated clump */
+	0x0F,	/* 4 bits set */
+	0xFF,	/* all bits set */
+	0x05,	/* non-adjacent 2 bits set */
+};
+
+static void __init test_for_each_set_clump8(void)
+{
+#define CLUMP_EXP_NUMBITS 64
+	DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS);
+	unsigned int start;
+	unsigned long clump;
+
+	/* set bitmap to test case */
+	bitmap_zero(bits, CLUMP_EXP_NUMBITS);
+	bitmap_set(bits, 0, 1);		/* 0x01 */
+	bitmap_set(bits, 9, 1);		/* 0x02 */
+	bitmap_set(bits, 27, 3);	/* 0x28 */
+	bitmap_set(bits, 35, 3);	/* 0x28 */
+	bitmap_set(bits, 40, 4);	/* 0x0F */
+	bitmap_set(bits, 48, 8);	/* 0xFF */
+	bitmap_set(bits, 56, 1);	/* 0x05 - part 1 */
+	bitmap_set(bits, 58, 1);	/* 0x05 - part 2 */
+
+	for_each_set_clump8(start, clump, bits, CLUMP_EXP_NUMBITS)
+		expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
+}
+
 static int __init test_bitmap_init(void)
 {
 	test_zero_clear();
@@ -369,6 +433,7 @@ static int __init test_bitmap_init(void)
 	test_bitmap_arr32();
 	test_bitmap_parselist();
 	test_mem_optimisations();
+	test_for_each_set_clump8();
 
 	if (failed_tests == 0)
 		pr_info("all %u tests passed\n", total_tests);
-- 
2.21.0

