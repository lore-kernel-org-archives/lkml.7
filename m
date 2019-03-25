Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E845FC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2A92087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K19JcWsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfCYGCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:02:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32924 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfCYGCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:02:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so5738903pgk.0;
        Sun, 24 Mar 2019 23:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0Kkp+Q1g48qFmEIxNbX8Si8M5iMlqRk5DRd5visCZQ=;
        b=K19JcWsHru69/+JRSlGqp3B/5LztIKApPQ5qeczawd17eLLZm8xx3TOD7oyw+N2Cys
         0eZEsSNXBSqoZEZb0gebw9rYuGzkBaoGTqe3KibF1fgw4sJa3MjBEBMEGcqWUN0TAAWJ
         gvUYcJsqMHINydviLMcByLM5sYr4FxTz4qwKUq4d9/iA2VipNNly1i2tef6gEv6QrCvt
         bJDpp0UQhmvbN0RmiIPAcDgV5+UAfzGxbqytdM73AKFCXiHZyssF4pYXufy8gvV0gFt2
         pC/vPyuCfcgLoQHx6rTryLo9dRa1tqcgBvcaoyxnW942GFZ3wNFSMlg7XBNBNsvYw8jJ
         dsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0Kkp+Q1g48qFmEIxNbX8Si8M5iMlqRk5DRd5visCZQ=;
        b=CIc7dy+1QWT7Eq2L66Nf4EavGutcn1uLHQXKkJorINZvbCzYPAs3UG6NP1W0hpBDHc
         oe3hutftARK+3uaYK3CQwimduQaeWyizg6YHF9rE73l9opDffIcrBEjQNF4sy7KOV+fD
         tEykkCSZcaC3/joWJEryUFElm5QxHa9G9/MTECkaLn+oQ4seiU/z2qzlhzkyMHx8/AJD
         yvH5K7CNj5BhgoDby/vF94QjCniLlpNH/4tjHTJYWjP6nt2+2dOmr0BvB+BK6WNB3cUy
         rF5WjfGIyDmVYTu6eDps+nfNcX9+ei7IQWxKWNFGNjBJ6z9Qga5sqV5Y7woTNzfIvrZY
         cfMQ==
X-Gm-Message-State: APjAAAWKBrR8pUOGEO5Tz9MhD4T8vcwBQE1Z3lXMNa7JPqUugG7x32pg
        LBBOAhDAs8VEir0odhl2k+Y=
X-Google-Smtp-Source: APXvYqwebddJln7MTdN4Umod2UvaujF1PygARHgSMbYGPz0slKRd3drAsDSWfNavDz7GqDq2EWBGKQ==
X-Received: by 2002:aa7:9219:: with SMTP id 25mr22949965pfo.205.1553493754906;
        Sun, 24 Mar 2019 23:02:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:e068:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id u4sm16965798pgp.59.2019.03.24.23.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:02:34 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v11 02/11] lib/test_bitmap.c: Add for_each_set_clump8 test cases
Date:   Mon, 25 Mar 2019 15:03:30 +0900
Message-Id: <1cc0950e1e68270918da157b979dcbc32eedfd59.1553492741.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553492741.git.vilhelm.gray@gmail.com>
References: <cover.1553492741.git.vilhelm.gray@gmail.com>
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
 lib/find_bit.c    |  2 +-
 lib/test_bitmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/lib/find_bit.c b/lib/find_bit.c
index c2af1f013ea2..1b6f8a6f1957 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -258,7 +258,7 @@ void bitmap_set_value8(unsigned long *const bitmap, const unsigned int size,
 	const unsigned int offset = start % BITS_PER_LONG;
 	const unsigned int low_width = (offset + 8 > BITS_PER_LONG) ?
 				       BITS_PER_LONG - offset : 8;
-	const unsigned long low_mask = GENMASK(offset + low_width - 1, offset);
+	const unsigned long low_mask = GENMASK(low_width - 1, 0) << offset;
 	const unsigned int high_width = 8 - low_width;
 	const unsigned long high_mask = GENMASK(high_width - 1, 0);
 
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

