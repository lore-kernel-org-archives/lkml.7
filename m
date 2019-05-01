Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690EDC04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C412177B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExnR1mIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfEABGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 21:06:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42478 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfEABGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 21:06:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id x15so7544845pln.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 18:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vEvrESLY1kvSnyot0lNAgBCsAXp1aYi5WKmvME2dO/E=;
        b=ExnR1mIY7fFcwRuaLabXH5X1Fl6/wQrEMGtr6lKOviCBth9Mc/01bgRyc+ocxjdzrd
         PGiZLglIKr/qcWHXjf/m4eIkj944kjzM4b1I0mya3yGRSAppPH3zqz4gAVe+LYN5ckdr
         pdeQj36f4uw5dPMxzGP0zsMVQevBtmw22IluMZCsA26XerR1vNRINsjpx1nbZKI698Pp
         0GdRCGM2lTjbWvZLsgPCEF86pLqH4k/x8MOrOdpckFRqIyoVXN8aAaijQKoBuaBQ0MRy
         NLnH3pzrrMHxmDfejRt3/IIA58Eo9UGREnf5DXm+z/Gt1U8ReSGMg5xT/EPL/9CK8aKT
         ch3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vEvrESLY1kvSnyot0lNAgBCsAXp1aYi5WKmvME2dO/E=;
        b=TUfcVKGnjYJ8R5eHygFcLLtEPI3/evJJ1G7geXaj1c+boHx+6CEQjba4VuR/mk8+ni
         VfLTqzNvcCKZ1znWOFsb6++kXFdV/Y8mS2/brPcGwthRLZ9nO/yq4YV9xB51PDOedZWl
         OkjgtKVs4CNN8cceBFV80dG2bKTyhjDQlEEN2Mw/bY6jppCRnU415t1oMkhJt9f4b+1K
         ojbpSuHLyyzxR6n668c7fE+X7gEwiTPVHXUKZSs5ns+qmtHFxlc6BbVVB+ufhKJ5lkbm
         4BC5MwhUWik6WfEejf2YQ7wyvqK5VqpQ3kGH7L9urdmZL17a5rdJsPZK2bH/551Ci2td
         uIuQ==
X-Gm-Message-State: APjAAAUdkLIh9UZPqhJjx+3rzgtodFeQCtK4NH1QvMGPYQbav3uCetnm
        PsMNYhAeYViQLoM6sfxy4fE=
X-Google-Smtp-Source: APXvYqyPbi9I+gAuP+DEHi1E3rsw4fJDB7DY/YlV/65HlL/YhtMzz8by2LcWgzgrmSLgw3mOmcefPg==
X-Received: by 2002:a17:902:3324:: with SMTP id a33mr9528195plc.18.1556672809027;
        Tue, 30 Apr 2019 18:06:49 -0700 (PDT)
Received: from localhost ([2601:640:7:332f:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id p18sm22089644pff.173.2019.04.30.18.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 18:06:48 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
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
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 3/7] lib: add test for bitmap_parse()
Date:   Tue, 30 Apr 2019 18:06:32 -0700
Message-Id: <20190501010636.30595-4-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501010636.30595-1-ynorov@marvell.com>
References: <20190501010636.30595-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test is derived from bitmap_parselist()
NO_LEN is reserved for use in following patches.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/test_bitmap.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index d3a501f2a81a..731e107d811a 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -205,7 +205,8 @@ static void __init test_copy(void)
 	expect_eq_pbl("0-108,128-1023", bmap2, 1024);
 }
 
-#define PARSE_TIME 0x1
+#define PARSE_TIME	0x1
+#define NO_LEN		0x2
 
 struct test_bitmap_parselist{
 	const int errno;
@@ -328,6 +329,85 @@ static void __init __test_bitmap_parselist(int is_user)
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
@@ -338,6 +418,16 @@ static void __init test_bitmap_parselist_user(void)
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
 #define EXP_BYTES	(sizeof(exp) * 8)
 
 static void __init test_bitmap_arr32(void)
@@ -409,6 +499,8 @@ static void __init selftest(void)
 	test_fill_set();
 	test_copy();
 	test_bitmap_arr32();
+	test_bitmap_parse();
+	test_bitmap_parse_user();
 	test_bitmap_parselist();
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
-- 
2.17.1

