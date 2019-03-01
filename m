Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A80B2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbfCAMuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:50:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:25314 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfCAMuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:50:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 04:50:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,427,1544515200"; 
   d="scan'208";a="151149153"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2019 04:50:08 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, jani.nikula@intel.com,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH] log2: make is_power_of_2() integer constant expression when possible
Date:   Fri,  1 Mar 2019 14:52:07 +0200
Message-Id: <20190301125207.30973-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While is_power_of_2() is an inline function and likely gets optimized
for compile time constant arguments, it still doesn't produce an integer
constant expression that could be used in, say, static data
initialization or case labels.

Make is_power_of_2() an integer constant expression when possible,
otherwise using the inline function to avoid multiple evaluation of the
parameter.

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

---

The alternative would be to define both a function and a macro version
of is_power_of_2(), and let the callers decide what to use.
---
 include/linux/log2.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index 2af7f77866d0..035932f52aeb 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -37,6 +37,14 @@ int __ilog2_u64(u64 n)
 }
 #endif
 
+#define __IS_POWER_OF_2(__n) ((__n) != 0 && (((__n) & ((__n) - 1)) == 0))
+
+static inline __attribute__((const))
+bool __is_power_of_2(unsigned long n)
+{
+	return __IS_POWER_OF_2(n);
+}
+
 /**
  * is_power_of_2() - check if a value is a power of two
  * @n: the value to check
@@ -45,11 +53,8 @@ int __ilog2_u64(u64 n)
  * *not* considered a power of two.
  * Return: true if @n is a power of 2, otherwise false.
  */
-static inline __attribute__((const))
-bool is_power_of_2(unsigned long n)
-{
-	return (n != 0 && ((n & (n - 1)) == 0));
-}
+#define is_power_of_2(n) \
+	__builtin_choose_expr(__builtin_constant_p(n), __IS_POWER_OF_2(n), __is_power_of_2(n))
 
 /**
  * __roundup_pow_of_two() - round up to nearest power of two
-- 
2.20.1

