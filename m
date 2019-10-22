Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC22CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69D0206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbfJVR33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:29:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:50509 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732509AbfJVR31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:29:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 10:29:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,217,1569308400"; 
   d="scan'208";a="372605617"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Oct 2019 10:29:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D8EE3311; Tue, 22 Oct 2019 20:29:23 +0300 (EEST)
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
Subject: [PATCH v2 02/11] lib/test_bitmap: Undefine macros after use
Date:   Tue, 22 Oct 2019 20:29:13 +0300
Message-Id: <20191022172922.61232-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022172922.61232-1-andriy.shevchenko@linux.intel.com>
References: <20191022172922.61232-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to keep step and ptest macros defined in entire file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_bitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 09aa29a6b562..d2fa94e45a46 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -311,6 +311,8 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "a-31:10/1", NULL, 8, 0},
 	{-EINVAL, "0-31:a/1", NULL, 8, 0},
 	{-EINVAL, "0-\n", NULL, 8, 0},
+
+#undef step
 };
 
 static void __init __test_bitmap_parselist(int is_user)
@@ -357,6 +359,8 @@ static void __init __test_bitmap_parselist(int is_user)
 		if (ptest.flags & PARSE_TIME)
 			pr_err("parselist%s: %d: input is '%s' OK, Time: %llu\n",
 					mode, i, ptest.in, time);
+
+#undef ptest
 	}
 }
 
-- 
2.23.0

