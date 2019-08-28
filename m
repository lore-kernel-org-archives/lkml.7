Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFC3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE2C2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfH1GKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:10:09 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27076 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725951AbfH1GKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:10:08 -0400
X-IronPort-AV: E=Sophos;i="5.64,440,1559491200"; 
   d="scan'208";a="74432380"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Aug 2019 14:10:05 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 30B6C4CE086C;
        Wed, 28 Aug 2019 14:10:04 +0800 (CST)
Received: from TSAO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 28 Aug 2019 14:10:12 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH] x86/cpufeature: explicit comments for duplicate macro
Date:   Wed, 28 Aug 2019 14:11:00 +0800
Message-ID: <20190828061100.27032-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 30B6C4CE086C.AC5BC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Help people to understand the author's intent of apparent duplication of
BUILD_BUG_ON_ZERO(NCAPINTS != n), which is hard to detect by eyes.

CC: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
Tried my best to describe it accurately, in case of any inaccuracy, feel
free to rephrase.

 arch/x86/include/asm/cpufeature.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 58acda503817..e943174abf1e 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -61,6 +61,17 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 #define CHECK_BIT_IN_MASK_WORD(maskname, word, bit)	\
 	(((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
 
+/*
+ * REQUIRED_MASK_CHECK may seems duplicate, but actually has its reason to
+ * live here.
+ * New CPUID leaf added or feature bit adjustment would/may result in increase
+ * in NCAPINTS. When it does, two required-features.h and here need to be
+ * modified correspondingly. BUILD_BUG_ON_ZERO assures the modification to be
+ * carried out, checking NCAPINTS also reminds the additional lines for new
+ * word. But, required-features.h as a single header file, can't be compiled
+ * directly, that is why a wrapper is defined there and called here.
+ * Totally the same case for DISABLED_MASK_BIT_SET.
+ */
 #define REQUIRED_MASK_BIT_SET(feature_bit)		\
 	 ( CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  0, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  1, feature_bit) ||	\
-- 
2.17.0



