Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CA3C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E0720836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg2kb3Sy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfCCHsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 02:48:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38120 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfCCHsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 02:48:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id n125so965548pfn.5;
        Sat, 02 Mar 2019 23:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ElsNjzQ7K98lI/bHz/nS5DIDC37ffsppngWHxCUh4y8=;
        b=Pg2kb3SyiFiHaFONBSKyoKCSYn7k0JkY9T1bWjWkklQDuMf7SeigsW9psZ0MXIdi0o
         OIjXZv3fYQ/Ned1bAUGm6ZmxS2HgRyHUikRiaL2i5+EuW2s1G7iQUAH+2fKJj5hhHW2b
         oXEnxot/6EFeD5V/BpKdXCN+bDX3f36684GL654E0rOJqZ/IukC/xTI3ve8ElTjKg5pY
         pvcE71lkFAXer8x8c9B+KU6KYARhGjUuPp6yjelZyUh8NBStcprLtne1/NOPSFB3Gstn
         IKuVYH1uBrArLWTwbucdd8FvOOACQ5GvwG15V2BCugcj8A+OUjv2j14psCvQkvUSv+ER
         rOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ElsNjzQ7K98lI/bHz/nS5DIDC37ffsppngWHxCUh4y8=;
        b=rdXPNiKhR7rUV86of6uitz4hYnSKV+sim6utz68uckOH0K48EuvyVpDUNglIjj0Vkn
         V0waY8JUduHF0Q2BHvdRSiFAF1CF3zac/WbyXXB+OR3zMLuxIJRriB7Nn7sxxV0cU43U
         Up/UweAvMKV534oQeyLzzSAIVsNuwvm5taqzRSHoHKXa57Fo0qXjAV0QWo2+mwVTkay6
         ndKok2uCkw+XLBNenr9aNa2bOUn4UyyE8XzlXEKsCLIkaJ6KfjyiAa9nYNOEIfNjkxHY
         KaBPyoTQdateOYCC02V8zyijh1Y47Ac1gywptyrTu+TuREFZXEQBKnoTg+E4lIIZf/VY
         T3BQ==
X-Gm-Message-State: APjAAAVEuRo1pv0T41JOFUv8LPjKHCYR/ETecVwRtE7vnzG5nb2Ss+1o
        96hQXkdjI6tMqs7WlmGLJ74=
X-Google-Smtp-Source: APXvYqwSltqoEw9JKp+yIsusA5L0KKE4BlpoSKKUPKWyfM62T0xKFe79n2gcx85OxQve/J1AyinmKA==
X-Received: by 2002:a63:d49:: with SMTP id 9mr12937777pgn.27.1551599285644;
        Sat, 02 Mar 2019 23:48:05 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:3b5c:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id b7sm4572950pfi.36.2019.03.02.23.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 23:48:05 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v9 2/9] lib/test_bitmap.c: Add for_each_set_clump8 test cases
Date:   Sun,  3 Mar 2019 16:48:54 +0900
Message-Id: <f56e40abde2464392de971c43fdd68396d03c84d.1551598603.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551598603.git.vilhelm.gray@gmail.com>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
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

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 lib/test_bitmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6cd7d0740005..66ddb3fb98cb 100644
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
+	0x28,	/* 3 bits set across 4-bit boundary */
+	0x28,	/* Repeated clump */
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
+	bitmap_set(bits, 8, 1);		/* 0x02 */
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

