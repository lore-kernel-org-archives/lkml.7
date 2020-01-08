Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DFEC33CA3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3ED2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgAHSqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:46:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:44440 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbgAHSqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:46:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 10:46:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; 
   d="scan'208";a="216036480"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 08 Jan 2020 10:46:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 57558149; Wed,  8 Jan 2020 20:46:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] lib/test_bitmap: Fix address space when test user buffer
Date:   Wed,  8 Jan 2020 20:46:11 +0200
Message-Id: <20200108184611.7065-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108184611.7065-1-andriy.shevchenko@linux.intel.com>
References: <20200108184611.7065-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force address space to avoid the following warning:

lib/test_bitmap.c:461:53: warning: incorrect type in argument 1 (different address spaces)
lib/test_bitmap.c:461:53:    expected char const [noderef] <asn:1> *ubuf
lib/test_bitmap.c:461:53:    got char const *in

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_bitmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index af522577a76e..8d3154457ff8 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -458,7 +458,8 @@ static void __init __test_bitmap_parse(int is_user)
 
 			set_fs(KERNEL_DS);
 			time = ktime_get();
-			err = bitmap_parse_user(test.in, len, bmap, test.nbits);
+			err = bitmap_parse_user((__force const char __user *)test.in, len,
+						bmap, test.nbits);
 			time = ktime_get() - time;
 			set_fs(orig_fs);
 		} else {
-- 
2.24.1

