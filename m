Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36410C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F5F218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfFSQix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:38:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:12523 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfFSQix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:38:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 09:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="358246562"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jun 2019 09:38:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F18A814B; Wed, 19 Jun 2019 19:38:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] kernel.h: Update comment about simple_strto<foo>() functions
Date:   Wed, 19 Jun 2019 19:38:42 +0300
Message-Id: <20190619163843.26918-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were discussions in the past about use cases for
simple_strto<foo>() functions and in some rare cases they have a benefit
on kstrto<foo>() ones.

Update a comment to reduce confusing about special use cases.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kernel.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 74b1ee9027f5..e156b8b41d05 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -331,8 +331,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
- * be checked.
+ * Used as a replacement for the simple_strtoull. Return code must be checked.
 */
 static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
 {
@@ -360,8 +359,7 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
- * be checked.
+ * Used as a replacement for the simple_strtoull. Return code must be checked.
  */
 static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
 {
@@ -437,7 +435,15 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
 	return kstrtoint_from_user(s, count, base, res);
 }
 
-/* Obsolete, do not use.  Use kstrto<foo> instead */
+/*
+ * Use kstrto<foo> instead.
+ *
+ * NOTE: The simple_strto<foo> does not check for overflow and,
+ *	 depending on the input, may give interesting results.
+ *
+ * Use these functions if and only if the code will need in place
+ * conversion and otherwise looks very ugly. Keep in mind above caveat.
+ */
 
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
 extern long simple_strtol(const char *,char **,unsigned int);
-- 
2.20.1

