Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299ACCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09615206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbfJVR3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:29:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:50509 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388145AbfJVR3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:29:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 10:29:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,217,1569308400"; 
   d="scan'208";a="372605633"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Oct 2019 10:29:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0A16240F; Tue, 22 Oct 2019 20:29:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 05/11] lib/test_bitmap: Move exp1 and exp2 upper for others to use
Date:   Tue, 22 Oct 2019 20:29:16 +0300
Message-Id: <20191022172922.61232-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022172922.61232-1-andriy.shevchenko@linux.intel.com>
References: <20191022172922.61232-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some test cases may re-use predefined exp1 and exp2 bitmaps.
Move them upper in the file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_bitmap.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6b70166ac960..449d0882b488 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -21,6 +21,26 @@ static unsigned failed_tests __initdata;
 
 static char pbl_buffer[PAGE_SIZE] __initdata;
 
+static const unsigned long exp1[] __initconst = {
+	BITMAP_FROM_U64(1),
+	BITMAP_FROM_U64(2),
+	BITMAP_FROM_U64(0x0000ffff),
+	BITMAP_FROM_U64(0xffff0000),
+	BITMAP_FROM_U64(0x55555555),
+	BITMAP_FROM_U64(0xaaaaaaaa),
+	BITMAP_FROM_U64(0x11111111),
+	BITMAP_FROM_U64(0x22222222),
+	BITMAP_FROM_U64(0xffffffff),
+	BITMAP_FROM_U64(0xfffffffe),
+	BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0xffffffff77777777ULL),
+	BITMAP_FROM_U64(0),
+};
+
+static const unsigned long exp2[] __initconst = {
+	BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0xffffffff77777777ULL),
+};
 
 static bool __init
 __check_eq_uint(const char *srcfile, unsigned int line,
@@ -247,27 +267,6 @@ struct test_bitmap_parselist{
 	const int flags;
 };
 
-static const unsigned long exp1[] __initconst = {
-	BITMAP_FROM_U64(1),
-	BITMAP_FROM_U64(2),
-	BITMAP_FROM_U64(0x0000ffff),
-	BITMAP_FROM_U64(0xffff0000),
-	BITMAP_FROM_U64(0x55555555),
-	BITMAP_FROM_U64(0xaaaaaaaa),
-	BITMAP_FROM_U64(0x11111111),
-	BITMAP_FROM_U64(0x22222222),
-	BITMAP_FROM_U64(0xffffffff),
-	BITMAP_FROM_U64(0xfffffffe),
-	BITMAP_FROM_U64(0x3333333311111111ULL),
-	BITMAP_FROM_U64(0xffffffff77777777ULL),
-	BITMAP_FROM_U64(0),
-};
-
-static const unsigned long exp2[] __initconst = {
-	BITMAP_FROM_U64(0x3333333311111111ULL),
-	BITMAP_FROM_U64(0xffffffff77777777ULL)
-};
-
 static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 #define step (sizeof(u64) / sizeof(unsigned long))
 
-- 
2.23.0

