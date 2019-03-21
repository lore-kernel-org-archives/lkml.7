Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FAEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E620B218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfCUWBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:01:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:53197 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfCUWA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:00:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="216357234"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2019 15:00:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 2101930214C; Thu, 21 Mar 2019 15:00:23 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 04/17] init: Add __noreorder and mark initcalls __noreorder
Date:   Thu, 21 Mar 2019 14:59:56 -0700
Message-Id: <20190321220009.29334-5-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321220009.29334-1-andi@firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

gcc 5 has a new no_reorder attribute that prevents top level
reordering only for that symbol.

Kernels don't like any reordering of initcalls between files, as several
initcalls depend on each other.

Add a __noreorder wrapper for the no_reorder attribute and use
it for initcalls.

LTO previously needed to use -fno-toplevel-reordering to prevent boot
failures, but with noreorder this is not needed.

I believe the patch is useful even without LTO because it clearly
documents this dependency in the source.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 include/linux/compiler_attributes.h | 11 +++++++++++
 include/linux/init.h                |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 6b318efd8a74..1c44ef9034bb 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -39,6 +39,7 @@
 # define __GCC4_has_attribute___externally_visible__  1
 # define __GCC4_has_attribute___noclone__             1
 # define __GCC4_has_attribute___nonstring__           0
+# define __GCC4_has_attribute___no_reorder__          0
 # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
 #endif
 
@@ -253,4 +254,14 @@
  */
 #define __weak                          __attribute__((__weak__))
 
+/*
+ * https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes
+ */
+
+#if __has_attribute(__no_reorder__)
+#define __noreorder			__attribute__((no_reorder))
+#else
+#define __noreorder
+#endif
+
 #endif /* __LINUX_COMPILER_ATTRIBUTES_H */
diff --git a/include/linux/init.h b/include/linux/init.h
index 5255069f5a9f..49d032916604 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -190,7 +190,7 @@ extern bool initcall_debug;
 	    ".previous					\n");
 #else
 #define ___define_initcall(fn, id, __sec) \
-	static initcall_t __initcall_##fn##id __used \
+	static initcall_t __initcall_##fn##id __used __noreorder \
 		__attribute__((__section__(#__sec ".init"))) = fn;
 #endif
 
-- 
2.20.1

