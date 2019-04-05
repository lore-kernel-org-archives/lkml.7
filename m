Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75349C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E3E20651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c94HTVll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbfDERce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:32:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41302 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731796AbfDERc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:32:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so3643250pfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mYUpIIgZ0H9qtTouQbGg/8MEoj4PdB57RttYqWy+ilU=;
        b=c94HTVllxAU+BlWxyFoh60rSLhCb4ukwMQxwnRnhfLU9xCdxuhEWDSXmOOL4JHHHnE
         JZ+nbVGCT0//BdbBCqTa2Jp0I59/hl0klob+twCXlTxaGDnvWX0dkPXVIp11DPQMXpK+
         hLQ0os5VBGTXf+cfqpht8DYPExTx3/vgIrr1vlKu01L0W8rg29FG3U4uKYFmt5YFAA3h
         foy5NEyQynd9k7/mYkSGamgQlfzeLBj9LQr2ZiThHkO03GQa/5+Wi8fNreB4/CsUiyPd
         pxs8eL6zjhLlfyGnIAIgM7q5giNwEAJR89zt88gv2PavYTwKJhT9qIRhCN4nL1dO1Uct
         hVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mYUpIIgZ0H9qtTouQbGg/8MEoj4PdB57RttYqWy+ilU=;
        b=jj5o5BzCRI3fCjSPdxAWSbC6hXRki74/8YVKNC8AeuhSAHaPLmw8s9USZMZMDYoBkF
         u2AgK95Xjo9jNGLZ9SMmW21MiLEHTqrm+xxD1lXzWHmJP6l32kZ13R54DCgpUoA1fi+9
         CTQeodNqDJMjGYwHfe11pMTwV3rDvOvmaZbAat4BFlhTzyHa8+Ead3DHmM5KhKAo1vCA
         DguVnxI3jPGHLAizjujXzruMuOUXgNS23ObkCnkZ9g09608MmuZ9fvCzreNn0ZkTvyjj
         HNmNFpU/rk8xDv1Ixfeed720x8XgIJMUJFDs+fmCecfFeWPP9jxLYLsn2Mud+IXtSH2x
         DW6w==
X-Gm-Message-State: APjAAAVUI/H/PoJ2ceoFAatAiyh58Be8FlvfNluWDTMnzC070FQkTGjO
        ACuln0vbEA0AheR+1Uxv4x0=
X-Google-Smtp-Source: APXvYqzKlwXZ+Xd5lM3d3F3be/V9ewVGHHh7Kn4z8xsuhaq1lCbofBcz5eX+XDK2Fz1gPDnpbkUgfA==
X-Received: by 2002:a62:19c3:: with SMTP id 186mr14131377pfz.172.1554485547845;
        Fri, 05 Apr 2019 10:32:27 -0700 (PDT)
Received: from localhost ([169.229.22.206])
        by smtp.gmail.com with ESMTPSA id 75sm39573894pfr.55.2019.04.05.10.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:32:27 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] lib/test_bitmap: add tests for bitmap_parselist_user
Date:   Fri,  5 Apr 2019 20:32:11 +0300
Message-Id: <20190405173211.11373-6-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405173211.11373-1-ynorov@marvell.com>
References: <20190405173211.11373-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate existing bitmap_parselist() tests to bitmap_parselist_user().

Signed-off-by: Yury Norov <ynorov@marvell.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

