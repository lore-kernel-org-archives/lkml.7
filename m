Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1D9C76196
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F4120644
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtECIzr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfGUV2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 17:28:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39428 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfGUV2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 17:28:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so12382071pfn.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 14:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsQfObxpPT22G9HCjIwsMUfH1Bg1tr5bJ5W5PapFwtE=;
        b=LtECIzr5H23HK0L5CJTEZkPtbBkgL4U6w+8LjYqlsUmY+ZM+PeMHMSDX+sytbaI2WT
         KHrxpyVq3+0Ib3hbFamwapCS8Bwu9lAb5iyKjik3ZW/IdlhEhqQERx6lDWlsk9in13cc
         QVNCL+6+z2e0Mb9EE03jfIuHGABwnteo2MAi3GB07YdfX2qYE7g7+aMqdrATswlD7eWH
         KcuEE7tyULOIsvmcPIi3pQzE7/7p4nQgwUMHP2C3FuZcDwoK65yBZLVWtRR3zluPmhW2
         i+rr41EPwDpZMBxAckFf8WpDr6EVUQZKqIE+4Ec0MIFPkN6fME6i0RsbhddMvGSzOoSG
         R3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsQfObxpPT22G9HCjIwsMUfH1Bg1tr5bJ5W5PapFwtE=;
        b=VnjD3sKGN2g9RdWGX3ObHyQ9Uaqbi4dU7X+DPRLZ52r8lJzVshvT//nGPKhkxugOqp
         o5E2u+Ra8dfv8Nh5yHknen+jOgeo02w9hlo18hJRtpYbxXC4b0rVVeta9Wzk+9FwIUHM
         +tIFtOA3cBBar8XnEgzh7Fxb8c+o1aB9XoAxdIUNLYkLVOn6mNTqYdcnImGraa4fNTyN
         kFHFoRltLs3ZR0aJaswmfKYR538kDrvuIJrXyXJh195Eo5BYL3FBN+CXs4ibEhye5eBy
         NCIk4kgXistCwIUOWfrQHJwU9Z6DxPWybTJeYPvariAdBzBdNQ/ehKbliShTdSnUcxYM
         ljpw==
X-Gm-Message-State: APjAAAXlNGeZhi+aSAzhqTIQGVkz82ikQ73iOpQ4+47OoDjt4T0YDygj
        h4/jECJLIf/dOTTZIyZI6Ks=
X-Google-Smtp-Source: APXvYqyzTT5gJ0yce87TpnJa4nd5pBzUIBqkpSl/ZiP0l5yFJSHe5QG7ndEjwChYbUh50nOPtmeVnw==
X-Received: by 2002:a65:6114:: with SMTP id z20mr69332983pgu.141.1563744516406;
        Sun, 21 Jul 2019 14:28:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:105:2ef8:a909:5e8d:6363:7009])
        by smtp.gmail.com with ESMTPSA id t9sm37970510pji.18.2019.07.21.14.28.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 14:28:36 -0700 (PDT)
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
Cc:     Yury Norov <yury.norov@gmail.com>, Yury Norov <ynorov@marvell.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 3/7] lib: add test for bitmap_parse()
Date:   Sun, 21 Jul 2019 14:27:49 -0700
Message-Id: <20190721212753.3287-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190721212753.3287-1-yury.norov@gmail.com>
References: <20190721212753.3287-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yury Norov <ynorov@marvell.com>

The test is derived from bitmap_parselist()
NO_LEN is reserved for use in following patches.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <ynorov@marvell.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 51a98f7ee79e6..e306d3da12019 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -206,7 +206,8 @@ static void __init test_copy(void)
 	expect_eq_pbl("0-108,128-1023", bmap2, 1024);
 }
 
-#define PARSE_TIME 0x1
+#define PARSE_TIME	0x1
+#define NO_LEN		0x2
 
 struct test_bitmap_parselist{
 	const int errno;
@@ -329,6 +330,85 @@ static void __init __test_bitmap_parselist(int is_user)
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
@@ -339,6 +419,16 @@ static void __init test_bitmap_parselist_user(void)
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
@@ -410,6 +500,8 @@ static void __init selftest(void)
 	test_fill_set();
 	test_copy();
 	test_bitmap_arr32();
+	test_bitmap_parse();
+	test_bitmap_parse_user();
 	test_bitmap_parselist();
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
-- 
2.20.1

