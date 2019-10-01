Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7349FC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4981921920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388959AbfJAOZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:25:03 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfJAOZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:25:03 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MCsDe-1iO4WF0e6C-008vED; Tue, 01 Oct 2019 16:24:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bill Metzenthen <billm@melbpc.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86: math-emu: limit MATH_EMULATION to 486SX compatibles
Date:   Tue,  1 Oct 2019 16:23:35 +0200
Message-Id: <20191001142344.1274185-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191001142344.1274185-1-arnd@arndb.de>
References: <20191001142344.1274185-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ypUbhs24V+XDzIu8RtxHkCDPsF9qgK2C2OcUaDTHYWX5qFZsDYX
 khdE+20BTsiQ/YldiJRPY7Uf5GP9VsST/YO0vGbYp5MC0yez+6jvokDzo3EenKPd/uyL0jf
 DI+LSXgleU8KGdPMSrsQ/D3qi0BKiiW829fkhIC7xVauaqgCmTC0QSaLtMT0VEyaEqaoB1e
 +03+Uwz6ejUUa7WfFA+GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZU0EJxA0134=:mlj8N0pWTv4KLis9kqC4Xe
 2s/A2zwEm3a8OJDTTB8qw1kV+7Qhd+AboSNmUNBKrkvLK3vjSI6fsOcGxShrOE07LnNa18cR4
 fCETauDHyfkafu+tiRRywa+5COSa6nYNjIDzhOW3dJBdxv1vGCd3KADWujAU+gaqroKinBhHY
 zlDXYYeCc/nmLeHfSag0CWyhRkvaybsxYiIY5cKvprSud8HzVVrt+qMwJPP+VC8xm4AOE7OAP
 cCr/vpAUPUTp9Q3zAQpRADzBkiTIaU/WSVMJNR5W4zfUJQJKN6lAjUmmE7PMjRVeTGW9I+HgU
 F9Fwz9iUYecIe8QHOt0jcN7fGIyljlxhA0bnVZBFI8icBZIN6qi2ahNzTYs6M82nPXL1SoY7c
 8IQP7ZZuf2Bbb84haJyVwyJbjTrRULj/04lehBsvMkuywvqUvlytS28lfkguIQECSvZ9DfFx4
 zSXWEVHHnc4reh1x9B0WWiiASp8GluY5x55qdZpKXksDUX/wjCRIRBVWp+Kggehu6gCKo0ZFM
 E7w+AjLIrPmoVKcNLUiYvsGKCzF8aeAMDrnYnEx2Qz0t0Ho/mILXGMR4MWPpo+/afcgY/1ORI
 tEd9zgB59K06qhTuKa1HkWetEpko3QKyW+XaKCTj2mtIyD3L4wUKH9wmbECPk6a1b39h7A67B
 qhDScZX6TpeTtaXVucTlwT9tDGiDSiHokYSgH52ASwCmaRzF4sN/qTfNOtpeLfmzztiNVSqGy
 w8S/aTIjXu++MDuOyExUfVNyZkiXDyTCtPNdanPBy9SgtE5GX5pknUGr9RFE8UN9N9JpGRkYL
 vo3l6wbO2o1vVE44/gEQGwTvSoSFnJglUY18e/0W7Axs4bvI5J6ByvS4yuZCNy6AP4pVz/CMb
 ZVKAfBBilyme7ERrtTCg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fpu emulation code is old and fragile in places, try to limit its
use to builds for CPUs that actually use it. As far as I can tell,
this is only true for i486sx compatibles, including the Cyrix 486SLC,
AMD Am486SX and ÉLAN SC410, UMC U5S amd DM&P VortexSX86, all of which
were relatively short-lived and got replaced with i486DX compatible
processors soon after introduction, though the some of the embedded
versions remained available much longer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig              |  2 +-
 arch/x86/Kconfig.cpu          | 25 ++++++++++++++++---------
 arch/x86/Makefile_32.cpu      |  1 +
 arch/x86/include/asm/module.h |  2 ++
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f4d9d1e55e5c..77b02387bd0c 100644
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
index 228705a1232a..5f7bff9885a1 100644
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
@@ -313,20 +320,20 @@ config X86_L1_CACHE_SHIFT
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
@@ -379,7 +386,7 @@ config X86_MINIMUM_CPU_FAMILY
 
 config X86_DEBUGCTLMSR
 	def_bool y
-	depends on !(MK6 || MWINCHIPC6 || MWINCHIP3D || MCYRIXIII || M586MMX || M586TSC || M586 || M486) && !UML
+	depends on !(MK6 || MWINCHIPC6 || MWINCHIP3D || MCYRIXIII || M586MMX || M586TSC || M586 || M486SX || M486) && !UML
 
 menuconfig PROCESSOR_SELECT
 	bool "Supported processor vendors" if EXPERT
@@ -403,7 +410,7 @@ config CPU_SUP_INTEL
 config CPU_SUP_CYRIX_32
 	default y
 	bool "Support Cyrix processors" if PROCESSOR_SELECT
-	depends on M486 || M586 || M586TSC || M586MMX || (EXPERT && !64BIT)
+	depends on M486SX || M486 || M586 || M586TSC || M586MMX || (EXPERT && !64BIT)
 	---help---
 	  This enables detection, tunings and quirks for Cyrix processors
 
@@ -471,7 +478,7 @@ config CPU_SUP_TRANSMETA_32
 config CPU_SUP_UMC_32
 	default y
 	bool "Support UMC processors" if PROCESSOR_SELECT
-	depends on M486 || (EXPERT && !64BIT)
+	depends on M486SX || M486 || (EXPERT && !64BIT)
 	---help---
 	  This enables detection, tunings and quirks for UMC processors
 
diff --git a/arch/x86/Makefile_32.cpu b/arch/x86/Makefile_32.cpu
index 1f5faf8606b4..cd3056759880 100644
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
index 7948a17febb4..c215d2762488 100644
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
-- 
2.20.0

