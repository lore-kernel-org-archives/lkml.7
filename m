Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E23C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4843120640
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391493AbfIYNJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 09:09:33 -0400
Received: from foss.arm.com ([217.140.110.172]:49008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388199AbfIYNJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:09:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42D981570;
        Wed, 25 Sep 2019 06:09:32 -0700 (PDT)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 23B543F59C;
        Wed, 25 Sep 2019 06:09:31 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        ndesaulniers@google.com, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] arm64: Allow disabling of the compat vDSO
Date:   Wed, 25 Sep 2019 14:09:26 +0100
Message-Id: <20190925130926.50674-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compat vDSO building requires a cross-compiler than produces AArch32
binaries, defined via CONFIG_CROSS_COMPILE_COMPAT_VDSO or the
CROSS_COMPILE_COMPAT environment variable. If none of these is defined,
building the kernel always prints a warning as there is no way to
deselect the compat vDSO.

Add an arm64 Kconfig entry to allow the deselection of the compat vDSO.
In addition, make it an EXPERT option, default n, until other issues
with the compat vDSO are solved (64-bit only kernel headers included in
user-space vDSO code, CC_IS_CLANG irrelevant to CROSS_COMPILE_COMPAT).

Fixes: bfe801ebe84f ("arm64: vdso: Enable vDSO compat support")
Cc: Will Deacon <will@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

It looks like you can't really win with the current compat vDSO logic.
You either don't have a compat cross-compiler and you get a Makefile
warning or you have one and a get a compiler warning (or failure)
because of the 64-bit kernel headers included in 32-bit user-space code.

"depends on BROKEN" for ARM64_COMPAT_VDSO also work for me instead of
EXPERT. I'll leave it up to Will to decide but I'd like at least this
patch in -rc2 (even better if everything else is fixed before the final
5.4).

Suggestions for future improvements of the compat vDSO handling:

- replace the CROSS_COMPILE_COMPAT prefix with a full COMPATCC; maybe
  check that it indeed produces 32-bit code

- check whether COMPATCC is clang or not rather than CC_IS_CLANG, which
  only checks the native compiler

- clean up the headers includes; vDSO should not include kernel-only
  headers that may even contain code patched at run-time

 arch/arm64/Kconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 866e05882799..83a9a78085c6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -110,7 +110,6 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT)
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
@@ -1185,6 +1184,15 @@ config KUSER_HELPERS
 	  Say N here only if you are absolutely certain that you do not
 	  need these helpers; otherwise, the safe option is to say Y.
 
+config ARM64_COMPAT_VDSO
+	bool "Enable the 32-bit vDSO" if EXPERT
+	depends on !CPU_BIG_ENDIAN
+	select GENERIC_COMPAT_VDSO
+	help
+	  Enable the vDSO support for 32-bit applications. You would
+	  need to set the 32-bit cross-compiler prefix in
+	  CONFIG_CROSS_COMPILE_COMPAT_VDSO or the CROSS_COMPILE_COMPAT
+	  environment variable.
 
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
