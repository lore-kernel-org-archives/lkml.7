Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16B5C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 12:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDE62133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 12:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pM1wbJTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfELMxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 08:53:39 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:25545 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfELMxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 08:53:38 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x4CCq3eT005954;
        Sun, 12 May 2019 21:52:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x4CCq3eT005954
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557665524;
        bh=u+xPaVz4tIL7LFuq2RerwT0d5S+67UExAoc/i1B3fLw=;
        h=From:To:Cc:Subject:Date:From;
        b=pM1wbJTa9bsV3kshrbPpP4RE0iTD+XLun3QXPATVk0lWaojkJoOYZuOxEGyczIVn4
         LJTFGLo0VeeEEHqdU10DuZ9AHZnDs2DZPxtBlT/7jv8jEVLM18tRAjD872A92hCXeI
         Q5InFVveJdEMByh4lg243PXhpjBEHg6TY/PHbw4Cd6a8rh8AQcz+ntBb9s/A6/yykX
         RqQu7BZ2w/+0snJe1TLVQaMcmXWILEcgLxcLqcfWiSSFfCDOSg51jtoFeCteegRTGb
         uWDOrJQceHeM/RYqVTvRcZr6QZYIElebdwUbvs6sUgM3eXC60WSL41pqBXVe5el9cb
         HbITLlvjNlqdw==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH] x86: disable CONFIG_GENERIC_HWEIGHT and remove __HAVE_ARCH_SW_HWEIGHT
Date:   Sun, 12 May 2019 21:52:01 +0900
Message-Id: <1557665521-17570-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/include/asm/arch_hweight.h uses __sw_hweight{32,64} as
alternatives, and they are implemented in arch/x86/lib/hweight.S

x86 does not rely on the generic C implementation lib/hweight.c
at all, so CONFIG_GENERIC_HWEIGHT should be disabled.

__HAVE_ARCH_SW_HWEIGHT is not necessary either.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Kconfig                    | 3 ---
 arch/x86/include/asm/arch_hweight.h | 2 --
 lib/hweight.c                       | 4 ----
 3 files changed, 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4725211..3692514 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -260,9 +260,6 @@ config GENERIC_BUG
 config GENERIC_BUG_RELATIVE_POINTERS
 	bool
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config ARCH_MAY_HAVE_PC_FDC
 	def_bool y
 	depends on ISA_DMA_API
diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index fc06935..ba88edd 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -12,8 +12,6 @@
 #define REG_OUT "a"
 #endif
 
-#define __HAVE_ARCH_SW_HWEIGHT
-
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
diff --git a/lib/hweight.c b/lib/hweight.c
index 7660d88..c94586b 100644
--- a/lib/hweight.c
+++ b/lib/hweight.c
@@ -10,7 +10,6 @@
  * The Hamming Weight of a number is the total number of bits set in it.
  */
 
-#ifndef __HAVE_ARCH_SW_HWEIGHT
 unsigned int __sw_hweight32(unsigned int w)
 {
 #ifdef CONFIG_ARCH_HAS_FAST_MULTIPLIER
@@ -27,7 +26,6 @@ unsigned int __sw_hweight32(unsigned int w)
 #endif
 }
 EXPORT_SYMBOL(__sw_hweight32);
-#endif
 
 unsigned int __sw_hweight16(unsigned int w)
 {
@@ -46,7 +44,6 @@ unsigned int __sw_hweight8(unsigned int w)
 }
 EXPORT_SYMBOL(__sw_hweight8);
 
-#ifndef __HAVE_ARCH_SW_HWEIGHT
 unsigned long __sw_hweight64(__u64 w)
 {
 #if BITS_PER_LONG == 32
@@ -69,4 +66,3 @@ unsigned long __sw_hweight64(__u64 w)
 #endif
 }
 EXPORT_SYMBOL(__sw_hweight64);
-#endif
-- 
2.7.4

