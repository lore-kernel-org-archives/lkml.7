Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A66EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BC5205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfH0HPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:15:14 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:46330 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725811AbfH0HPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:15:13 -0400
X-IronPort-AV: E=Sophos;i="5.64,436,1559491200"; 
   d="scan'208";a="74331670"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Aug 2019 15:04:59 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 137304CE086C;
        Tue, 27 Aug 2019 15:04:48 +0800 (CST)
Received: from TSAO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 27 Aug 2019 15:05:01 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
Subject: [PATCH] x86/cpufeature: drop *_MASK_CEHCK
Date:   Tue, 27 Aug 2019 15:05:50 +0800
Message-ID: <20190827070550.15988-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 137304CE086C.AE53D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are wrappers of BUILD_BUG_ON_ZERO(NCAPINTS != n), which is already
present in corresponding *_MASK_BIT_SET. And fill the missing period in
head comments by the way.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 arch/x86/include/asm/cpufeature.h        | 2 --
 arch/x86/include/asm/disabled-features.h | 1 -
 arch/x86/include/asm/required-features.h | 3 +--
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 58acda503817..232ffb88039c 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -81,7 +81,6 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 16, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 17, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
-	   REQUIRED_MASK_CHECK					  ||	\
 	   BUILD_BUG_ON_ZERO(NCAPINTS != 19))
 
 #define DISABLED_MASK_BIT_SET(feature_bit)				\
@@ -104,7 +103,6 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 16, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 17, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
-	   DISABLED_MASK_CHECK					  ||	\
 	   BUILD_BUG_ON_ZERO(NCAPINTS != 19))
 
 #define cpu_has(c, bit)							\
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index a5ea841cc6d2..8a2eafa86739 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -84,6 +84,5 @@
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index 6847d85400a8..cb98b66d3e81 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_X86_REQUIRED_FEATURES_H
 #define _ASM_X86_REQUIRED_FEATURES_H
 
-/* Define minimum CPUID feature set for kernel These bits are checked
+/* Define minimum CPUID feature set for kernel. These bits are checked
    really early to actually display a visible error message before the
    kernel dies.  Make sure to assign features to the proper mask!
 
@@ -101,6 +101,5 @@
 #define REQUIRED_MASK16	0
 #define REQUIRED_MASK17	0
 #define REQUIRED_MASK18	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
-- 
2.17.0



