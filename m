Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77561C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4544D21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8zECAIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgABEbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:31:21 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34987 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgABEbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:31:16 -0500
Received: by mail-qt1-f194.google.com with SMTP id e12so34036397qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 20:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8lcbTjb7RzesPV6CyvOVYzseKqx/51O78xcB0b8zyM4=;
        b=V8zECAIjfVG9QXYOgy3fd57wSQNnu3Dpg7aF9l32xTQI2UI7jXSuerYm4yoar5F+dO
         Bk5UxfQ+aFfwor7+2zohugcsLK3X4IawQn09qlnbM9h2LK3GmKmnuhrhOGBniHx1Kw9P
         KGBaHQTQpEHsbURG/vCmgZUa9ar5S5uz2CpOmoqjLaAHAEz6bOv7W57pmmJm4TTRVR5H
         YvWGFP+2aS40FU+q/XGBN+gKENHCH8nhxnjUYNLGRkfjbUkipM1loKo2TmczQESs5fBk
         J6eJg0196wL1KLcNXjmOes6q5HOpJV0RaR/MP31Ln+iOYT9aphc+UlyR860f8TY+ap4t
         4auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8lcbTjb7RzesPV6CyvOVYzseKqx/51O78xcB0b8zyM4=;
        b=kivniEIRdA+V+THtaEVPCq7/aD73rOCsoKUhmsLIB5KxTLHDXfqdG6tao+qj4J8sjf
         5Fb53CKVvF/1DLaL8mMNLsDluM+YhoSYcRFySapFWui1JdSAjMqa++uNti+7iu3K7xBg
         JA2uIVcGPr6lP9U9uK2zLdQXFZWrJmQU9vjGUWUNaEwefWkTRFuaQgNLjBplYrw1B+dS
         vwgzqXEqdzh0xeAHEV6ry+KK5HZVDMRXIYgknkf7+lhJm2sji+BL+DUoxPBWbrcCibSh
         dPhQ2FUJd/E6rv2GTGx9ru8ToZyeiLJcjpck9LvgouScVqiO8DhpFBY9YxHGsORUuSGh
         Edwg==
X-Gm-Message-State: APjAAAXkSfzTp4xrYuVoDkTBNOttZMNV7mp3sa258tFFTTPiDw4DeiL5
        haouY5PeJ/BXS6XdQNSNBhI=
X-Google-Smtp-Source: APXvYqyV5UGjoUi1BUJDGXNhJn5lyXbZlbC/mhFHY7L+JXoBAV5q1zGuli6SCiHpscR0zb2SAxXiWg==
X-Received: by 2002:ac8:3490:: with SMTP id w16mr57578435qtb.56.1577939475199;
        Wed, 01 Jan 2020 20:31:15 -0800 (PST)
Received: from yury-thinkpad.dhcp.amer.jpmchase.net ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id 16sm14876857qkj.77.2020.01.01.20.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 20:31:14 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 3/7] lib: add test for bitmap_parse()
Date:   Wed,  1 Jan 2020 20:30:27 -0800
Message-Id: <20200102043031.30357-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200102043031.30357-1-yury.norov@gmail.com>
References: <20200102043031.30357-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yury Norov <yury.norov@gmail.com>

The test is derived from bitmap_parselist()
NO_LEN is reserved for use in following patches.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index e14a15ac250b4..830c9b195e405 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -294,7 +294,8 @@ static void __init test_replace(void)
 	expect_eq_bitmap(bmap, exp3_1_0, nbits);
 }
 
-#define PARSE_TIME 0x1
+#define PARSE_TIME	0x1
+#define NO_LEN		0x2
 
 struct test_bitmap_parselist{
 	const int errno;
@@ -400,6 +401,85 @@ static void __init __test_bitmap_parselist(int is_user)
 	}
 }
 
+static const unsigned long parse_test[] __initconst = {
+	BITMAP_FROM_U64(0),
+	BITMAP_FROM_U64(1),
+	BITMAP_FROM_U64(0xdeadbeef),
+	BITMAP_FROM_U64(0x100000000ULL),
+};
+
+static const unsigned long parse_test2[] __initconst = {
+	BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0xdeadbeef),
+	BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0xbaadf00ddeadbeef),
+	BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0x0badf00ddeadbeef),
+};
+
+static const struct test_bitmap_parselist parse_tests[] __initconst = {
+	{0, "0",			&parse_test[0 * step], 32, 0},
+	{0, "1",			&parse_test[1 * step], 32, 0},
+	{0, "deadbeef",			&parse_test[2 * step], 32, 0},
+	{0, "1,0",			&parse_test[3 * step], 33, 0},
+
+	{0, "deadbeef,1,0",		&parse_test2[0 * 2 * step], 96, 0},
+	{0, "baadf00d,deadbeef,1,0",	&parse_test2[1 * 2 * step], 128, 0},
+	{0, "badf00d,deadbeef,1,0",	&parse_test2[2 * 2 * step], 124, 0},
+
+	{-EINVAL,    "goodfood,deadbeef,1,0",	NULL, 128, 0},
+	{-EOVERFLOW, "3,0",			NULL, 33, 0},
+	{-EOVERFLOW, "123badf00d,deadbeef,1,0",	NULL, 128, 0},
+	{-EOVERFLOW, "badf00d,deadbeef,1,0",	NULL, 90, 0},
+	{-EOVERFLOW, "fbadf00d,deadbeef,1,0",	NULL, 95, 0},
+	{-EOVERFLOW, "badf00d,deadbeef,1,0",	NULL, 100, 0},
+};
+
+static void __init __test_bitmap_parse(int is_user)
+{
+	int i;
+	int err;
+	ktime_t time;
+	DECLARE_BITMAP(bmap, 2048);
+	char *mode = is_user ? "_user"  : "";
+
+	for (i = 0; i < ARRAY_SIZE(parse_tests); i++) {
+		struct test_bitmap_parselist test = parse_tests[i];
+
+		if (is_user) {
+			size_t len = strlen(test.in);
+			mm_segment_t orig_fs = get_fs();
+
+			set_fs(KERNEL_DS);
+			time = ktime_get();
+			err = bitmap_parse_user(test.in, len, bmap, test.nbits);
+			time = ktime_get() - time;
+			set_fs(orig_fs);
+		} else {
+			size_t len = test.flags & NO_LEN ?
+				UINT_MAX : strlen(test.in);
+			time = ktime_get();
+			err = bitmap_parse(test.in, len, bmap, test.nbits);
+			time = ktime_get() - time;
+		}
+
+		if (err != test.errno) {
+			pr_err("parse%s: %d: input is %s, errno is %d, expected %d\n",
+					mode, i, test.in, err, test.errno);
+			continue;
+		}
+
+		if (!err && test.expected
+			 && !__bitmap_equal(bmap, test.expected, test.nbits)) {
+			pr_err("parse%s: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
+					mode, i, test.in, bmap[0],
+					*test.expected);
+			continue;
+		}
+
+		if (test.flags & PARSE_TIME)
+			pr_err("parse%s: %d: input is '%s' OK, Time: %llu\n",
+					mode, i, test.in, time);
+	}
+}
+
 static void __init test_bitmap_parselist(void)
 {
 	__test_bitmap_parselist(0);
@@ -410,6 +490,16 @@ static void __init test_bitmap_parselist_user(void)
 	__test_bitmap_parselist(1);
 }
 
+static void __init test_bitmap_parse(void)
+{
+	__test_bitmap_parse(0);
+}
+
+static void __init test_bitmap_parse_user(void)
+{
+	__test_bitmap_parse(1);
+}
+
 #define EXP1_IN_BITS	(sizeof(exp1) * 8)
 
 static void __init test_bitmap_arr32(void)
@@ -515,6 +605,8 @@ static void __init selftest(void)
 	test_copy();
 	test_replace();
 	test_bitmap_arr32();
+	test_bitmap_parse();
+	test_bitmap_parse_user();
 	test_bitmap_parselist();
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
-- 
2.20.1

