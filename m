Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99994C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6202082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfCDKAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:00:16 -0500
Received: from mga07.intel.com ([134.134.136.100]:44085 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfCDKAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:00:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 02:00:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,439,1544515200"; 
   d="scan'208";a="128823305"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2019 02:00:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B455114E; Mon,  4 Mar 2019 12:00:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux@rasmusvillemoes.dk
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] lib/test_printf: Switch to bitmap_zalloc()
Date:   Mon,  4 Mar 2019 12:00:09 +0200
Message-Id: <20190304100009.65147-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_printf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 659b6cc0d483..e8206d8d2d08 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -481,14 +481,14 @@ static void __init
 large_bitmap(void)
 {
 	const int nbits = 1 << 16;
-	unsigned long *bits = kcalloc(BITS_TO_LONGS(nbits), sizeof(long), GFP_KERNEL);
+	unsigned long *bits = bitmap_zalloc(nbits, GFP_KERNEL);
 	if (!bits)
 		return;
 
 	bitmap_set(bits, 1, 20);
 	bitmap_set(bits, 60000, 15);
 	test("1-20,60000-60014", "%*pbl", nbits, bits);
-	kfree(bits);
+	bitmap_free(bits);
 }
 
 static void __init
-- 
2.20.1

