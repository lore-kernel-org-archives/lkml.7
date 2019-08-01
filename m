Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB85C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A77D20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388676AbfHAT3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:29:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:41185 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388609AbfHAT3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:29:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 12:29:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="372714254"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2019 12:29:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C2366F3; Thu,  1 Aug 2019 22:29:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 1/2] kernel.h: Update comment about simple_strto<foo>() functions
Date:   Thu,  1 Aug 2019 22:29:03 +0300
Message-Id: <20190801192904.41087-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were discussions in the past about use cases for
simple_strto<foo>() functions and, in some rare cases,
they have a benefit over kstrto<foo>() ones.

Update a comment to reduce confusion about special use cases.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: modify comment to be more precise (Petr)
 include/linux/kernel.h | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 4fa360a13c1e..60a9529ee740 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -334,8 +334,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
- * be checked.
+ * Used as a replacement for the simple_strtoull. Return code must be checked.
 */
 static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
 {
@@ -363,8 +362,7 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
- * be checked.
+ * Used as a replacement for the simple_strtoull. Return code must be checked.
  */
 static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
 {
@@ -440,7 +438,18 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
 	return kstrtoint_from_user(s, count, base, res);
 }
 
-/* Obsolete, do not use.  Use kstrto<foo> instead */
+/*
+ * Use kstrto<foo> instead.
+ *
+ * NOTE: simple_strto<foo> does not check for the range overflow and,
+ *	 depending on the input, may give interesting results.
+ *
+ * Use these functions if and only if you cannot use kstrto<foo>, because
+ * the conversion ends on the first non-digit character, which may be far
+ * beyond the supported range. It might be useful to parse the strings like
+ * 10x50 or 12:21 without altering original string or temporary buffer in use.
+ * Keep in mind above caveat.
+ */
 
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
 extern long simple_strtol(const char *,char **,unsigned int);
-- 
2.20.1

