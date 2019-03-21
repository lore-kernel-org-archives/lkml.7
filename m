Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEAA21917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfCUWAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:00:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:53197 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbfCUWA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:00:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="216357235"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2019 15:00:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 293D030214C; Thu, 21 Mar 2019 15:00:23 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 05/17] Use C version for SYSCALL_ALIAS
Date:   Thu, 21 Mar 2019 14:59:57 -0700
Message-Id: <20190321220009.29334-6-andi@firstfloor.org>
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

LTO doesn't like the assembler aliasing used for SYSCALL_ALIAS.
Replace it with C aliasing. Also mark the only users visible.

This gives cleaner and nicer code, so is useful even without
LTO.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/syscall_wrapper.h | 1 +
 include/linux/linkage.h                | 6 ++----
 kernel/time/posix-stubs.c              | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index e046a405743d..6f7a73da8437 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -52,6 +52,7 @@
 	SYSCALL_METADATA(_##sname, 0);				\
 	asmlinkage long __x64_sys_##sname(void);		\
 	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);	\
+	asmlinkage long __ia32_sys_##sname(void);		\
 	SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);	\
 	asmlinkage long __x64_sys_##sname(void)
 
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 7e020782ade2..5fc9ecd55bda 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -30,10 +30,8 @@
 #endif
 
 #ifndef SYSCALL_ALIAS
-#define SYSCALL_ALIAS(alias, name) asm(			\
-	".globl " __stringify(alias) "\n\t"		\
-	".set   " __stringify(alias) ","		\
-		  __stringify(name))
+#define SYSCALL_ALIAS(a, name) \
+	__visible typeof(a) a __attribute__((alias(__stringify(name))))
 #endif
 
 #define __page_aligned_data	__section(.data..page_aligned) __aligned(PAGE_SIZE)
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 67df65f887ac..4777892bee82 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -21,7 +21,7 @@
 #include <asm/syscall_wrapper.h>
 #endif
 
-asmlinkage long sys_ni_posix_timers(void)
+__visible asmlinkage long sys_ni_posix_timers(void)
 {
 	pr_err_once("process %d (%s) attempted a POSIX timer syscall "
 		    "while CONFIG_POSIX_TIMERS is not set\n",
-- 
2.20.1

