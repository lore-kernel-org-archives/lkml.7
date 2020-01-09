Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8969C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56562072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgAIKgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:36:11 -0500
Received: from mga07.intel.com ([134.134.136.100]:49342 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730240AbgAIKgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:36:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 02:36:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="234564575"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Jan 2020 02:36:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 295E514B; Thu,  9 Jan 2020 12:36:01 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] lib/test_bitmap: Correct test data offsets for 32-bit
Date:   Thu,  9 Jan 2020 12:36:00 +0200
Message-Id: <20200109103601.45929-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit platform the size of long is only 32 bits which makes wrong offset
in the array of 64 bit size.

Calculate offset based on BITS_PER_LONG.

Fixes: 30544ed5de43 ("lib/bitmap: introduce bitmap_replace() helper")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rename step -> nlongs to avoid confusion with a macro (Yury)
 lib/test_bitmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 5cb35a734462..707b0389db35 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -275,22 +275,23 @@ static void __init test_copy(void)
 static void __init test_replace(void)
 {
 	unsigned int nbits = 64;
+	unsigned int nlongs = DIV_ROUND_UP(nbits, BITS_PER_LONG);
 	DECLARE_BITMAP(bmap, 1024);
 
 	bitmap_zero(bmap, 1024);
-	bitmap_replace(bmap, &exp2[0], &exp2[1], exp2_to_exp3_mask, nbits);
+	bitmap_replace(bmap, &exp2[0 * nlongs], &exp2[1 * nlongs], exp2_to_exp3_mask, nbits);
 	expect_eq_bitmap(bmap, exp3_0_1, nbits);
 
 	bitmap_zero(bmap, 1024);
-	bitmap_replace(bmap, &exp2[1], &exp2[0], exp2_to_exp3_mask, nbits);
+	bitmap_replace(bmap, &exp2[1 * nlongs], &exp2[0 * nlongs], exp2_to_exp3_mask, nbits);
 	expect_eq_bitmap(bmap, exp3_1_0, nbits);
 
 	bitmap_fill(bmap, 1024);
-	bitmap_replace(bmap, &exp2[0], &exp2[1], exp2_to_exp3_mask, nbits);
+	bitmap_replace(bmap, &exp2[0 * nlongs], &exp2[1 * nlongs], exp2_to_exp3_mask, nbits);
 	expect_eq_bitmap(bmap, exp3_0_1, nbits);
 
 	bitmap_fill(bmap, 1024);
-	bitmap_replace(bmap, &exp2[1], &exp2[0], exp2_to_exp3_mask, nbits);
+	bitmap_replace(bmap, &exp2[1 * nlongs], &exp2[0 * nlongs], exp2_to_exp3_mask, nbits);
 	expect_eq_bitmap(bmap, exp3_1_0, nbits);
 }
 
-- 
2.24.1

