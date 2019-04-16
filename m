Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E208C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA0C20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etlVQz91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfDPGiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:38:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39764 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbfDPGiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:38:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so9817873pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 23:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LfPCNil5kQZuhNGWdpX4xBorbAaKIujW0CAWO19o0sA=;
        b=etlVQz91znh+y2UaXn/E5hm6jGNpbZdIuVbvpUmXBsV79MbK1tldQk3fYHuqMxP7tK
         tRLdz/bZy7GtvttJGc+CPcFbOtZy4/8vN/Sr3DJGA4Y6bkVVtEHVtlt4vr+yymMuj0SS
         5PCO/BYXhD4YLqHPUC2hqcZ4DVyx8mSCk75DZnLbc59eaRjOByjS1gjUoBlCHqhFJlwe
         NSJiq7XtcYxiZ4cGc6xfiSGP3zSBdlAdGzyapIPadI9u1WUMuX8NbuMPxWoCYQkbl9xa
         NAiKny4lIeHmq0XlfjgLVVusR4dASFNnZxxYIcaTPxSDGGTJIzJVkwsSYzkDk8Ffni5B
         ui8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LfPCNil5kQZuhNGWdpX4xBorbAaKIujW0CAWO19o0sA=;
        b=k+IERgoWziiZXKMJqFmW34AnAeWRBzPEZ0eDD+cmaRW32tyMLE/XKkAkAYmdGM/pK5
         5RNY3YldKhqYt+PZz+gK1jfsScEnjE6WbyDYCTTa1z+9wNq3BpK9hl/A2q68sqQAR+1v
         Z522Ru1BH+c6FRO4kmiwsRy3pQpEmtKjeXQBL7RgfU4uItCwF1/96v9TMV+U/NjiSrWH
         QxHNc9eoMGyCuIduJyT5qK3n1pUh+nYakdNOHaHP+C4HeprKDVC74Mitq5MsY/6rqW41
         dxa/5BJ6QcjslmG7BIxMrTifA/XBIpibkpdZ50b5QiEhCCL/bv3dsXC6mz+cyvwohyW/
         Yrhw==
X-Gm-Message-State: APjAAAXsfa4y1UPvtxUNMi+2BJbBYRQ7bjyYa1JZkvaDUwIU7wQDwIev
        nEc4j/ZRRXmKIDxhoEylsUg=
X-Google-Smtp-Source: APXvYqyMQD84vQ/gPdOUgUJUE6HxKGhXQ0f94ka2v9GWykyo8o97jVRGEctJGhp36gg1foEKnXKjnw==
X-Received: by 2002:a63:79c3:: with SMTP id u186mr72274958pgc.20.1555396693892;
        Mon, 15 Apr 2019 23:38:13 -0700 (PDT)
Received: from localhost ([2601:648:8303:5c60:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id b72sm94432559pga.86.2019.04.15.23.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 23:38:13 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] lib/test_bitmap: add tests for bitmap_parselist_user
Date:   Mon, 15 Apr 2019 23:38:01 -0700
Message-Id: <20190416063801.20134-6-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416063801.20134-1-ynorov@marvell.com>
References: <20190416063801.20134-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <ynorov@marvell.com>

Propagate existing bitmap_parselist() tests to bitmap_parselist_user().

Signed-off-by: Yury Norov <ynorov@marvell.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_bitmap.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6640a82ad44b..d3a501f2a81a 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -11,6 +11,7 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 
 #include "../tools/testing/selftests/kselftest_module.h"
 
@@ -280,39 +281,63 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
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
@@ -385,6 +410,7 @@ static void __init selftest(void)
 	test_copy();
 	test_bitmap_arr32();
 	test_bitmap_parselist();
+	test_bitmap_parselist_user();
 	test_mem_optimisations();
 }
 
-- 
2.17.1

