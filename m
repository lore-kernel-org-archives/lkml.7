Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59320C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F2120727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfKNSSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:18:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfKNSS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C82C2088F;
        Thu, 14 Nov 2019 18:18:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhL-0001Ah-8q; Thu, 14 Nov 2019 13:18:27 -0500
Message-Id: <20191114181827.152115842@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:18:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [for-next][PATCH 26/33] lib/bsearch: Use generic type for comparator function
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Comparator function type, cmp_func_t, is defined in the types.h,
use it in bsearch() and, thus, add more sense to the corresponding
comment in the code.

Link: http://lkml.kernel.org/r/20191007135656.37734-2-andriy.shevchenko@linux.intel.com

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/bsearch.h | 2 +-
 lib/bsearch.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bsearch.h b/include/linux/bsearch.h
index 62b1eb348858..8ed53d7524ea 100644
--- a/include/linux/bsearch.h
+++ b/include/linux/bsearch.h
@@ -5,6 +5,6 @@
 #include <linux/types.h>
 
 void *bsearch(const void *key, const void *base, size_t num, size_t size,
-	      int (*cmp)(const void *key, const void *elt));
+	      cmp_func_t cmp);
 
 #endif /* _LINUX_BSEARCH_H */
diff --git a/lib/bsearch.c b/lib/bsearch.c
index 8baa83968162..8b3aae5ae77a 100644
--- a/lib/bsearch.c
+++ b/lib/bsearch.c
@@ -29,7 +29,7 @@
  * the same comparison function for both sort() and bsearch().
  */
 void *bsearch(const void *key, const void *base, size_t num, size_t size,
-	      int (*cmp)(const void *key, const void *elt))
+	      cmp_func_t cmp)
 {
 	const char *pivot;
 	int result;
-- 
2.23.0


