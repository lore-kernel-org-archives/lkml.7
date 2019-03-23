Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4788AC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5E32192D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ON5G8EVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfCWPww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 11:52:52 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52058 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCWPwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 11:52:50 -0400
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::3e6])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9BED15C011D;
        Sat, 23 Mar 2019 16:52:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1553356366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=7ZIwm7I13HUFOXu7BTiXTpP0ZLyV3mvblCn0a6HfVbE=;
        b=ON5G8EVfgTH1aMoLQcBcuv91/5G3nkav1rePx9+pat3O7gogEcBXOwX3IA3sIM90iNwkmS
        WHQn0KRPqaLfwgM5VeaZoZCZIor6lqdKeobXAFhXBdyMdXw1qKNFIk52L4EOiwy3jWFn2X
        uCPEoHk2rJE598BXSRs8kbaWh9yBrqY=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     arnd@arndb.de, ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        nicolas.pitre@linaro.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        kgene@kernel.org, krzk@kernel.org, robh@kernel.org,
        ssantosh@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        tony@atomide.com, marc.w.gonzalez@free.fr, mans@mansr.com,
        ndesaulniers@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/3] ARM: use arch_extension directive instead of arch argument
Date:   Sat, 23 Mar 2019 16:52:56 +0100
Message-Id: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LLVM Target parser currently does not allow to specify the security
extension as part of -march (see also LLVM Bug 40186 [0]). When trying
to use Clang with LLVM's integrated assembler, this leads to a build
errors such as this:
  clang-8: error: the clang compiler does not support '-Wa,-march=armv7-a+sec'

Use ".arch_extension sec" to enable the security extension in a more
portable fasion.

Note that this is technically not exactly the same as the old code
checked for availabilty of the security extension by calling as-instr.
However, there are already other sites which use ".arch_extension sec"
unconditionally, hence de-facto we need an assembler capable of
".arch_extension sec" already today (arch/arm/mm/proc-v7.S). The
arch extension "sec" is available since binutils 2.21 according to
its documentation [1].

[0] https://bugs.llvm.org/show_bug.cgi?id=40186
[1] https://sourceware.org/binutils/docs-2.21/as/ARM-Options.html

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-bcm/Makefile         | 3 ---
 arch/arm/mach-bcm/bcm_kona_smc.c   | 2 --
 arch/arm/mach-exynos/Makefile      | 4 ----
 arch/arm/mach-exynos/exynos-smc.S  | 2 +-
 arch/arm/mach-exynos/sleep.S       | 2 +-
 arch/arm/mach-highbank/Makefile    | 3 ---
 arch/arm/mach-highbank/smc.S       | 2 +-
 arch/arm/mach-keystone/Makefile    | 3 ---
 arch/arm/mach-keystone/smc.S       | 1 +
 arch/arm/mach-omap2/Makefile       | 8 --------
 arch/arm/mach-omap2/omap-headsmp.S | 1 +
 arch/arm/mach-omap2/omap-smc.S     | 2 +-
 arch/arm/mach-omap2/sleep34xx.S    | 1 +
 arch/arm/mach-omap2/sleep43xx.S    | 1 +
 arch/arm/mach-omap2/sleep44xx.S    | 1 +
 arch/arm/mach-tango/Makefile       | 3 ---
 arch/arm/mach-tango/smc.S          | 1 +
 17 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 8fd23b263c60..b59c813b1af4 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -40,9 +40,6 @@ obj-$(CONFIG_ARCH_BCM_MOBILE_L2_CACHE) += kona_l2_cache.o
 
 # Support for secure monitor traps
 obj-$(CONFIG_ARCH_BCM_MOBILE_SMC) += bcm_kona_smc.o
-ifeq ($(call as-instr,.arch_extension sec,as_has_sec),as_has_sec)
-CFLAGS_bcm_kona_smc.o		+= -Wa,-march=armv7-a+sec -DREQUIRES_SEC
-endif
 
 # BCM2835
 obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
index a55a7ecf146a..541e850a736c 100644
--- a/arch/arm/mach-bcm/bcm_kona_smc.c
+++ b/arch/arm/mach-bcm/bcm_kona_smc.c
@@ -125,9 +125,7 @@ static int bcm_kona_do_smc(u32 service_id, u32 buffer_phys)
 		__asmeq("%2", "r4")
 		__asmeq("%3", "r5")
 		__asmeq("%4", "r6")
-#ifdef REQUIRES_SEC
 		".arch_extension sec\n"
-#endif
 		"	smc    #0\n"
 		: "=r" (ip), "=r" (r0)
 		: "r" (r4), "r" (r5), "r" (r6)
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index cd00c82a1add..44de9f36fd1b 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -14,9 +14,5 @@ obj-$(CONFIG_PM_SLEEP)		+= suspend.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
-plus_sec := $(call as-instr,.arch_extension sec,+sec)
-AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
-AFLAGS_sleep.o			:=-Wa,-march=armv7-a$(plus_sec)
-
 obj-$(CONFIG_EXYNOS5420_MCPM)	+= mcpm-exynos.o
 CFLAGS_mcpm-exynos.o		+= -march=armv7-a
diff --git a/arch/arm/mach-exynos/exynos-smc.S b/arch/arm/mach-exynos/exynos-smc.S
index d259532ba937..392f8ba351f4 100644
--- a/arch/arm/mach-exynos/exynos-smc.S
+++ b/arch/arm/mach-exynos/exynos-smc.S
@@ -10,7 +10,7 @@
 /*
  * Function signature: void exynos_smc(u32 cmd, u32 arg1, u32 arg2, u32 arg3)
  */
-
+	.arch_extension sec
 ENTRY(exynos_smc)
 	stmfd	sp!, {r4-r11, lr}
 	dsb
diff --git a/arch/arm/mach-exynos/sleep.S b/arch/arm/mach-exynos/sleep.S
index 2783c3a0c06a..6e3207d486b4 100644
--- a/arch/arm/mach-exynos/sleep.S
+++ b/arch/arm/mach-exynos/sleep.S
@@ -44,7 +44,7 @@ ENTRY(exynos_cpu_resume)
 ENDPROC(exynos_cpu_resume)
 
 	.align
-
+	.arch_extension sec
 ENTRY(exynos_cpu_resume_ns)
 	mrc	p15, 0, r0, c0, c0, 0
 	ldr	r1, =CPU_MASK
diff --git a/arch/arm/mach-highbank/Makefile b/arch/arm/mach-highbank/Makefile
index 55840f414d3e..e7741b883d13 100644
--- a/arch/arm/mach-highbank/Makefile
+++ b/arch/arm/mach-highbank/Makefile
@@ -1,6 +1,3 @@
 obj-y					:= highbank.o system.o smc.o
 
-plus_sec := $(call as-instr,.arch_extension sec,+sec)
-AFLAGS_smc.o				:=-Wa,-march=armv7-a$(plus_sec)
-
 obj-$(CONFIG_PM_SLEEP)			+= pm.o
diff --git a/arch/arm/mach-highbank/smc.S b/arch/arm/mach-highbank/smc.S
index 407d17baaaa9..c53d6e37bb30 100644
--- a/arch/arm/mach-highbank/smc.S
+++ b/arch/arm/mach-highbank/smc.S
@@ -16,7 +16,7 @@
  * the monitor API number.
  * Function signature : void highbank_smc1(u32 fn, u32 arg)
  */
-
+	.arch_extension sec
 ENTRY(highbank_smc1)
 	stmfd   sp!, {r4-r11, lr}
 	mov	r12, r0
diff --git a/arch/arm/mach-keystone/Makefile b/arch/arm/mach-keystone/Makefile
index f8b0dccac8dc..739b38be5696 100644
--- a/arch/arm/mach-keystone/Makefile
+++ b/arch/arm/mach-keystone/Makefile
@@ -1,9 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y					:= keystone.o smc.o
 
-plus_sec := $(call as-instr,.arch_extension sec,+sec)
-AFLAGS_smc.o				:=-Wa,-march=armv7-a$(plus_sec)
-
 obj-$(CONFIG_SMP)			+= platsmp.o
 
 # PM domain driver for Keystone SOCs
diff --git a/arch/arm/mach-keystone/smc.S b/arch/arm/mach-keystone/smc.S
index d15de8179fab..b105a465bc16 100644
--- a/arch/arm/mach-keystone/smc.S
+++ b/arch/arm/mach-keystone/smc.S
@@ -21,6 +21,7 @@
  *
  * Return: Non zero value on failure
  */
+	.arch_extension        sec
 ENTRY(keystone_cpu_smc)
 	stmfd   sp!, {r4-r11, lr}
 	smc	#0
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 85d1b13c9215..f1d283995b31 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -41,11 +41,6 @@ obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-common) $(smp-y) sleep44xx.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(omap-4-5-common)
 obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-4-5-common) $(smp-y) sleep44xx.o
 
-plus_sec := $(call as-instr,.arch_extension sec,+sec)
-AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
-AFLAGS_omap-smc.o			:=-Wa,-march=armv7-a$(plus_sec)
-AFLAGS_sleep44xx.o			:=-Wa,-march=armv7-a$(plus_sec)
-
 # Functions loaded to SRAM
 obj-$(CONFIG_SOC_OMAP2420)		+= sram242x.o
 obj-$(CONFIG_SOC_OMAP2430)		+= sram243x.o
@@ -95,9 +90,6 @@ obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
 obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
-AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
-AFLAGS_sleep33xx.o			:=-Wa,-march=armv7-a$(plus_sec)
-AFLAGS_sleep43xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 
 endif
 
diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 4c6f14cf92a8..605b9fa9ba9b 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -58,6 +58,7 @@ ENDPROC(omap5_secondary_startup)
  * omap5_secondary_startup if the primary CPU was put into HYP mode by
  * the boot loader.
  */
+	.arch_extension sec
 ENTRY(omap5_secondary_hyp_startup)
 wait_2:	ldr	r2, =AUX_CORE_BOOT0_PA	@ read from AuxCoreBoot0
 	ldr	r0, [r2]
diff --git a/arch/arm/mach-omap2/omap-smc.S b/arch/arm/mach-omap2/omap-smc.S
index 72506e6cf9e7..b71a92eaffc9 100644
--- a/arch/arm/mach-omap2/omap-smc.S
+++ b/arch/arm/mach-omap2/omap-smc.S
@@ -23,7 +23,7 @@
  * link register "lr".
  * Function signature : void omap_smc1(u32 fn, u32 arg)
  */
-
+	.arch_extension sec
 ENTRY(omap_smc1)
 	stmfd   sp!, {r2-r12, lr}
 	mov	r12, r0
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 22daf4efed68..42a9bff8c53b 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -97,6 +97,7 @@ ENDPROC(enable_omap3630_toggle_l2_on_restore)
  *
  * r0 = physical address of the parameters
  */
+	.arch_extension sec
 ENTRY(save_secure_ram_context)
 	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
 	mov	r3, r0			@ physical address of parameters
diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
index 5b9343b58fc7..19d78d8a6bc9 100644
--- a/arch/arm/mach-omap2/sleep43xx.S
+++ b/arch/arm/mach-omap2/sleep43xx.S
@@ -56,6 +56,7 @@
 #define RTC_PMIC_EXT_WAKEUP_EN				BIT(0)
 
 	.arm
+	.arch_extension sec
 	.align 3
 
 ENTRY(am43xx_do_wfi)
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index 0cae3b070208..55afed959a9a 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -23,6 +23,7 @@
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PM)
 
+	.arch_extension sec
 .macro	DO_SMC
 	dsb
 	smc	#0
diff --git a/arch/arm/mach-tango/Makefile b/arch/arm/mach-tango/Makefile
index da6c633d3cc0..97cd04508fa1 100644
--- a/arch/arm/mach-tango/Makefile
+++ b/arch/arm/mach-tango/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-plus_sec := $(call as-instr,.arch_extension sec,+sec)
-AFLAGS_smc.o := -Wa,-march=armv7-a$(plus_sec)
-
 obj-y += setup.o smc.o
 obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_SUSPEND) += pm.o
diff --git a/arch/arm/mach-tango/smc.S b/arch/arm/mach-tango/smc.S
index 361a8dc89804..cf2d21e5226c 100644
--- a/arch/arm/mach-tango/smc.S
+++ b/arch/arm/mach-tango/smc.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/linkage.h>
 
+	.arch_extension sec
 ENTRY(tango_smc)
 	push	{lr}
 	mov	ip, r1
-- 
2.21.0

