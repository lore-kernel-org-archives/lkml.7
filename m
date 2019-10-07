Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14729ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8DB20684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfJGN5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:57:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:1099 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGN5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:57:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 06:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="206415698"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Oct 2019 06:57:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 37339F9; Mon,  7 Oct 2019 16:57:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        George Spelvin <lkml@sdf.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] lib/bsearch: Use generic type for comparator function
Date:   Mon,  7 Oct 2019 16:56:55 +0300
Message-Id: <20191007135656.37734-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007135656.37734-1-andriy.shevchenko@linux.intel.com>
References: <20191007135656.37734-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comparator function type, cmp_func_t, is defined in the types.h,
use it in bsearch() and, thus, add more sense to the corresponding
comment in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

