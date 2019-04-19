Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01C0C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DE9222CC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PydnGSji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfDSSWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:22:03 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:53132 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfDSSV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:21:57 -0400
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-09.nifty.com with ESMTP id x3J9nuad030524;
        Fri, 19 Apr 2019 18:49:57 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x3J9mDiW012304;
        Fri, 19 Apr 2019 18:48:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x3J9mDiW012304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555667311;
        bh=DZH3ndX+jwPMXyZB1kQ4OHEY2QeZuXlzmLdAIaBcM6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PydnGSjiKyIo14J4fAKaV6koaZeZ0EuTcw4Tq4V8uwNBifRf97/8NMU4AZxYotm6W
         h/czkyZ7MDVZ2xZhy6Byuv6Z4Ztq0jvEL+1rHQtL3Fe/LMX4RBELdDA3ZegwXjdj4m
         UqJDwhBzKD/pptPsi5aw/KnB/EONfPoQF8eebdfHJaMgBG170Y/dNM8a4ryp4EVyLX
         Js9Op5+csNk9r2v3z6G8n18zKMuFlHT/YDZazi9Kv9zGOPV9qNMg9QJWzNAvml8NMc
         aNwXmMoinYdq9Px4fC8i7300TKOZmLWc7fLIBYNhAM/kMZlHf9tWKsM00pZIZMM8B/
         CMFiRyUCM3+HA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 11/11] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
Date:   Fri, 19 Apr 2019 18:47:54 +0900
Message-Id: <20190419094754.24667-12-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190419094754.24667-1-yamada.masahiro@socionext.com>
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.

The idea is obviously arch-agnostic. This commit moves the config
entry from arch/x86/Kconfig.debug to lib/Kconfig.debug so that all
architectures can benefit from it.

This can make a huge difference in kernel image size especially when
CONFIG_OPTIMIZE_FOR_SIZE is enabled.

For example, I got 3.5% smaller arm64 kernel for v5.1-rc1.

  dec       file
  18983424  arch/arm64/boot/Image.before
  18321920  arch/arm64/boot/Image.after

This also slightly improves the "Kernel hacking" Kconfig menu as
e61aca5158a8 ("Merge branch 'kconfig-diet' from Dave Hansen') suggested;
this config option would be a good fit in the "compiler option" menu.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - split into a separate patch

 arch/x86/Kconfig               |  3 ---
 arch/x86/Kconfig.debug         | 14 --------------
 include/linux/compiler_types.h |  3 +--
 lib/Kconfig.debug              | 14 ++++++++++++++
 4 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ad92419be19..9e93d109a6cb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -310,9 +310,6 @@ config ZONE_DMA32
 config AUDIT_ARCH
 	def_bool y if X86_64
 
-config ARCH_SUPPORTS_OPTIMIZED_INLINING
-	def_bool y
-
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	def_bool y
 
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 15d0fbe27872..f730680dc818 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -266,20 +266,6 @@ config CPA_DEBUG
 	---help---
 	  Do change_page_attr() self-tests every 30 seconds.
 
-config OPTIMIZE_INLINING
-	bool "Allow gcc to uninline functions marked 'inline'"
-	---help---
-	  This option determines if the kernel forces gcc to inline the functions
-	  developers have marked 'inline'. Doing so takes away freedom from gcc to
-	  do what it thinks is best, which is desirable for the gcc 3.x series of
-	  compilers. The gcc 4.x series have a rewritten inlining algorithm and
-	  enabling this option will generate a smaller kernel there. Hopefully
-	  this algorithm is so good that allowing gcc 4.x and above to make the
-	  decision will become the default in the future. Until then this option
-	  is there to test gcc for this.
-
-	  If unsure, say N.
-
 config DEBUG_ENTRY
 	bool "Debug low-level entry code"
 	depends on DEBUG_KERNEL
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index ba814f18cb4c..19e58b9138a0 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -140,8 +140,7 @@ struct ftrace_likely_data {
  * Do not use __always_inline here, since currently it expands to inline again
  * (which would break users of __always_inline).
  */
-#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
-	!defined(CONFIG_OPTIMIZE_INLINING)
+#if !defined(CONFIG_OPTIMIZE_INLINING)
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
 	__maybe_unused notrace
 #else
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d9e81779e37..f8f284f46c85 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -310,6 +310,20 @@ config HEADERS_CHECK
 	  exported to $(INSTALL_HDR_PATH) (usually 'usr/include' in
 	  your build tree), to make sure they're suitable.
 
+config OPTIMIZE_INLINING
+	bool "Allow compiler to uninline functions marked 'inline'"
+	help
+	  This option determines if the kernel forces gcc to inline the functions
+	  developers have marked 'inline'. Doing so takes away freedom from gcc to
+	  do what it thinks is best, which is desirable for the gcc 3.x series of
+	  compilers. The gcc 4.x series have a rewritten inlining algorithm and
+	  enabling this option will generate a smaller kernel there. Hopefully
+	  this algorithm is so good that allowing gcc 4.x and above to make the
+	  decision will become the default in the future. Until then this option
+	  is there to test gcc for this.
+
+	  If unsure, say N.
+
 config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
 	help
-- 
2.17.1

