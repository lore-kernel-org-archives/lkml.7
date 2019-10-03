Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D360C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BDD218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfJCJeI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:34:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33993 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbfJCJeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:34:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFxUa-0003BP-N9; Thu, 03 Oct 2019 11:33:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4506B1C03A8;
        Thu,  3 Oct 2019 11:33:48 +0200 (CEST)
Date:   Thu, 03 Oct 2019 09:33:48 -0000
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/math-emu: Limit MATH_EMULATION to 486SX compatibles
Cc:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bill Metzenthen <billm@melbpc.org.au>,
        Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191001142344.1274185-2-arnd@arndb.de>
References: <20191001142344.1274185-2-arnd@arndb.de>
MIME-Version: 1.0
Message-ID: <157009522819.9978.18343591541373350129.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     87d6021b814353d7b353afcc3698ffe49de7d4ec
Gitweb:        https://git.kernel.org/tip/87d6021b814353d7b353afcc3698ffe49de7d4ec
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 01 Oct 2019 16:23:35 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 03 Oct 2019 10:51:17 +02:00

x86/math-emu: Limit MATH_EMULATION to 486SX compatibles

The FPU emulation code is old and fragile in places, try to limit its
use to builds for CPUs that actually use it. As far as I can tell,
this is only true for i486sx compatibles, including the Cyrix 486SLC,
AMD Am486SX and ÉLAN SC410, UMC U5S amd DM&P VortexSX86, all of which
were relatively short-lived and got replaced with i486DX compatible
processors soon after introduction, though some of the embedded versions
remained available much longer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bill Metzenthen <billm@melbpc.org.au>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191001142344.1274185-2-arnd@arndb.de
---
 arch/x86/Kconfig              |  2 +-
 arch/x86/Kconfig.cpu          | 25 ++++++++++++++++---------
 arch/x86/Makefile_32.cpu      |  1 +
 arch/x86/include/asm/module.h |  2 ++
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d6e1faa..91c22ee 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1751,7 +1751,7 @@ config X86_RESERVE_LOW
 config MATH_EMULATION
 	bool
 	depends on MODIFY_LDT_SYSCALL
-	prompt "Math emulation" if X86_32
+	prompt "Math emulation" if X86_32 && (M486SX || MELAN)
 	---help---
 	  Linux can emulate a math coprocessor (used for floating point
 	  operations) if you don't have one. 486DX and Pentium processors have
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 8e29c99..af9c967 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -50,12 +50,19 @@ choice
 	  See each option's help text for additional details. If you don't know
 	  what to do, choose "486".
 
+config M486SX
+	bool "486SX"
+	depends on X86_32
+	---help---
+	  Select this for an 486-class CPU without an FPU such as
+	  AMD/Cyrix/IBM/Intel SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5S.
+
 config M486
-	bool "486"
+	bool "486DX"
 	depends on X86_32
 	---help---
 	  Select this for an 486-class CPU such as AMD/Cyrix/IBM/Intel
-	  486DX/DX2/DX4 or SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or U5S.
+	  486DX/DX2/DX4 and UMC U5D.
 
 config M586
 	bool "586/K5/5x86/6x86/6x86MX"
@@ -312,20 +319,20 @@ config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4 || MPSC
 	default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
-	default "4" if MELAN || M486 || MGEODEGX1
+	default "4" if MELAN || M486SX || M486 || MGEODEGX1
 	default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
 
 config X86_F00F_BUG
 	def_bool y
-	depends on M586MMX || M586TSC || M586 || M486
+	depends on M586MMX || M586TSC || M586 || M486SX || M486
 
 config X86_INVD_BUG
 	def_bool y
-	depends on M486
+	depends on M486SX || M486
 
 config X86_ALIGNMENT_16
 	def_bool y
-	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2 || MGEODEGX1
+	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MELAN || MK6 || M586MMX || M586TSC || M586 || M486SX || M486 || MVIAC3_2 || MGEODEGX1
 
 config X86_INTEL_USERCOPY
 	def_bool y
@@ -378,7 +385,7 @@ config X86_MINIMUM_CPU_FAMILY
 
 config X86_DEBUGCTLMSR
 	def_bool y
-	depends on !(MK6 || MWINCHIPC6 || MWINCHIP3D || MCYRIXIII || M586MMX || M586TSC || M586 || M486) && !UML
+	depends on !(MK6 || MWINCHIPC6 || MWINCHIP3D || MCYRIXIII || M586MMX || M586TSC || M586 || M486SX || M486) && !UML
 
 menuconfig PROCESSOR_SELECT
 	bool "Supported processor vendors" if EXPERT
@@ -402,7 +409,7 @@ config CPU_SUP_INTEL
 config CPU_SUP_CYRIX_32
 	default y
 	bool "Support Cyrix processors" if PROCESSOR_SELECT
-	depends on M486 || M586 || M586TSC || M586MMX || (EXPERT && !64BIT)
+	depends on M486SX || M486 || M586 || M586TSC || M586MMX || (EXPERT && !64BIT)
 	---help---
 	  This enables detection, tunings and quirks for Cyrix processors
 
@@ -470,7 +477,7 @@ config CPU_SUP_TRANSMETA_32
 config CPU_SUP_UMC_32
 	default y
 	bool "Support UMC processors" if PROCESSOR_SELECT
-	depends on M486 || (EXPERT && !64BIT)
+	depends on M486SX || M486 || (EXPERT && !64BIT)
 	---help---
 	  This enables detection, tunings and quirks for UMC processors
 
diff --git a/arch/x86/Makefile_32.cpu b/arch/x86/Makefile_32.cpu
index 1f5faf8..cd30567 100644
--- a/arch/x86/Makefile_32.cpu
+++ b/arch/x86/Makefile_32.cpu
@@ -10,6 +10,7 @@ else
 tune		= $(call cc-option,-mcpu=$(1),$(2))
 endif
 
+cflags-$(CONFIG_M486SX)		+= -march=i486
 cflags-$(CONFIG_M486)		+= -march=i486
 cflags-$(CONFIG_M586)		+= -march=i586
 cflags-$(CONFIG_M586TSC)	+= -march=i586
diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index 7948a17..c215d27 100644
--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -15,6 +15,8 @@ struct mod_arch_specific {
 
 #ifdef CONFIG_X86_64
 /* X86_64 does not define MODULE_PROC_FAMILY */
+#elif defined CONFIG_M486SX
+#define MODULE_PROC_FAMILY "486SX "
 #elif defined CONFIG_M486
 #define MODULE_PROC_FAMILY "486 "
 #elif defined CONFIG_M586
