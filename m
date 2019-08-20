Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BFCC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3205214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfHTOxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:53:14 -0400
Received: from mail.windriver.com ([147.11.1.11]:44478 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfHTOxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:53:13 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x7KErC6p000952
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 20 Aug 2019 07:53:12 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Tue, 20 Aug 2019 07:53:12 -0700
From:   <zhe.he@windriver.com>
To:     <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH] modules: page-align module section allocations only for arches supporting strict module rwx
Date:   Tue, 20 Aug 2019 22:53:10 +0800
Message-ID: <1566312790-253213-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

We should keep the case of "#define debug_align(X) (X)" for all arches
without CONFIG_HAS_STRICT_MODULE_RWX ability, which would save people, who
are sensitive to system size, a lot of memory when using modules,
especially for embedded systems. This is also the intention of the
original #ifdef... statement and still valid for now.

Note that this still keeps the effect of the fix of the following commit,
38f054d549a8 ("modules: always page-align module section allocations"),
since when CONFIG_ARCH_HAS_STRICT_MODULE_RWX is enabled, module pages are
aligned.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
This patch is based on the top of modules-next tree, 38f054d549a8.

 kernel/module.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index cd8df51..9ee9342 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -64,9 +64,14 @@
 
 /*
  * Modules' sections will be aligned on page boundaries
- * to ensure complete separation of code and data
+ * to ensure complete separation of code and data, but
+ * only when CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
  */
+#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
 # define debug_align(X) ALIGN(X, PAGE_SIZE)
+#else
+# define debug_align(X) (X)
+#endif
 
 /* If this is set, the section belongs in the init part of the module */
 #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
-- 
2.7.4

