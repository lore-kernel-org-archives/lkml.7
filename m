Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FCAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ABC20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtoG598E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfCYVIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:08:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33803 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbfCYVIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:08:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so7194298pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5PHclHZKSkpOVEQ71tOTWZyHKtx1aXyaZkJRRxxKNEY=;
        b=PtoG598EqfAIKospNfzSXUSbAhZhTei6f/fsskmIgQNnYwMas7XpVCJz5KB2WHex2I
         QNyiEKaJ9ZqvFVdUTQ+0FQH7ZntKqzg39h5VIPIJ4m58tz1EYzM2R4K+bt9DgD/8tMPi
         FWCR+U1QD9MZphiBM+yfF2Hb7sgkn0ali9YwEzCD5+Z2tmc1CMNb9or7W/2c6umyMO4U
         oAvchvOlY+LTFRKq1C7mnK8W6E442EJsiN4gQormqdydDSZq5+PdunWXdeHUg5F5Rreq
         dFe2DPLsdJ6JaarbA0N/keC2GOKl1UkEfs+06CCTtn2HSY4BGUsTl6KDqUMdatrhAA3Y
         DqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5PHclHZKSkpOVEQ71tOTWZyHKtx1aXyaZkJRRxxKNEY=;
        b=h6b8mHm4eTNx+GDFzUQCLBmvzFmoqfl49ASY4RuYYtHkfPBhgrF+5YyepB0leuJXm7
         H25gGjf4QK909dyB5sjJgPhRuG5tBA3J/777v3T3Yo4K/udguK4DsxViy/d1U29oTWBV
         U5AsfEwpS0kDNp5UoyevQPym0h1q4FawhvJG0NkI2CwfakOI3Oyb8rY4KscUItb0gvZj
         BTSL+tbiK9RZtKNCaJzo6woi5eo0CoJTvkV8rnMUIVtwbP2I9+rz8NA53umaHXOMVeSU
         +6K9xfyMz058t5N5mDqP+TuBa7E8+8BzLLedsLNRZG4GtpNE/Z6kwYHjl7mzzH1D4wgf
         2Rlw==
X-Gm-Message-State: APjAAAXr/QRODJ4wexfjW77/K4y6BW8R5IxxcZ9rEA6iggUeyH43A2Ig
        1ZeWtq5SlL0HaWFhgT1cxIQ=
X-Google-Smtp-Source: APXvYqznLL1gE1tKASYSI5iA0zkQUOhM9uxYKfAX0eMjA/0DwcSHGsZxSdj6AbN/1JRFfjTVbUtOGA==
X-Received: by 2002:a63:6c43:: with SMTP id h64mr24591746pgc.22.1553548081144;
        Mon, 25 Mar 2019 14:08:01 -0700 (PDT)
Received: from localhost ([169.229.22.206])
        by smtp.gmail.com with ESMTPSA id m24sm18689803pgv.1.2019.03.25.14.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:08:00 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] lib/test_bitmap: add tests for bitmap_parselist_user
Date:   Tue, 26 Mar 2019 00:07:48 +0300
Message-Id: <20190325210748.6571-7-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325210748.6571-1-ynorov@marvell.com>
References: <20190325210748.6571-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate existing bitmap_parselist() tests to bitmap_parselist_user().

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/test_bitmap.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 709424a788ee..d4ecac0da160 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -11,6 +11,7 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 
 static unsigned total_tests __initdata;
 static unsigned failed_tests __initdata;
@@ -278,39 +279,63 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "0-\n", NULL, 8, 0},
 };
 
-static void __init test_bitmap_parselist(void)
+static void __init __test_bitmap_parselist(int is_user)
 {
 	int i;
 	int err;
 	ktime_t time;
 	DECLARE_BITMAP(bmap, 2048);
+	char *mode = is_user ? "_user"  : "";
 
 	for (i = 0; i < ARRAY_SIZE(parselist_tests); i++) {
 #define ptest parselist_tests[i]
 
-		time = ktime_get();
-		err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
-		time = ktime_get() - time;
+		if (is_user) {
+			mm_segment_t orig_fs = get_fs();
+			size_t len = strlen(ptest.in);
+
+			set_fs(KERNEL_DS);
+			time = ktime_get();
+			err = bitmap_parselist_user(ptest.in, len,
+						    bmap, ptest.nbits);
+			time = ktime_get() - time;
+			set_fs(orig_fs);
+		} else {
+			time = ktime_get();
+			err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
+			time = ktime_get() - time;
+		}
 
 		if (err != ptest.errno) {
-			pr_err("test %d: input is %s, errno is %d, expected %d\n",
-					i, ptest.in, err, ptest.errno);
+			pr_err("parselist%s: %d: input is %s, errno is %d, expected %d\n",
+					mode, i, ptest.in, err, ptest.errno);
 			continue;
 		}
 
 		if (!err && ptest.expected
 			 && !__bitmap_equal(bmap, ptest.expected, ptest.nbits)) {
-			pr_err("test %d: input is %s, result is 0x%lx, expected 0x%lx\n",
-					i, ptest.in, bmap[0], *ptest.expected);
+			pr_err("parselist%s: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
+					mode, i, ptest.in, bmap[0],
+					*ptest.expected);
 			continue;
 		}
 
 		if (ptest.flags & PARSE_TIME)
-			pr_err("test %d: input is '%s' OK, Time: %llu\n",
-					i, ptest.in, time);
+			pr_err("parselist%s: %d: input is '%s' OK, Time: %llu\n",
+					mode, i, ptest.in, time);
 	}
 }
 
+static void __init test_bitmap_parselist(void)
+{
+	__test_bitmap_parselist(0);
+}
+
+static void __init test_bitmap_parselist_user(void)
+{
+	__test_bitmap_parselist(1);
+}
+
 #define EXP_BYTES	(sizeof(exp) * 8)
 
 static void __init test_bitmap_arr32(void)
@@ -383,6 +408,7 @@ static int __init test_bitmap_init(void)
 	test_copy();
 	test_bitmap_arr32();
 	test_bitmap_parselist();
+	test_bitmap_parselist_user();
 	test_mem_optimisations();
 
 	if (failed_tests == 0)
-- 
2.17.1

