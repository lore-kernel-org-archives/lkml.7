Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCF3C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09F22342E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfH3WRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:17:10 -0400
Received: from shell.v3.sk ([90.176.6.54]:56368 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbfH3WQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:16:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0829DD875F;
        Sat, 31 Aug 2019 00:09:03 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id I8nv5gzTJ_PE; Sat, 31 Aug 2019 00:08:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A620DD87ED;
        Sat, 31 Aug 2019 00:08:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ekOHPVBEkIA8; Sat, 31 Aug 2019 00:08:01 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3DBA8D87EF;
        Sat, 31 Aug 2019 00:07:52 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     "To : Olof Johansson" <olof@lixom.net>
Cc:     "Cc : Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 11/16] ARM: mmp: add support for MMP3 SoC
Date:   Sat, 31 Aug 2019 00:07:38 +0200
Message-Id: <20190830220743.439670-12-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830220743.439670-1-lkundrak@v3.sk>
References: <20190830220743.439670-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to MMP2, which this patch is based on. Known differencies from MM=
P2
are:

* Two PJ4B cores instead of one PJ4
* Tauros 3 L2 cache controller instead of Tauros 2
* A GIC interrupt controller optionally used instead of the MMP one
* A TWD local timer
* Different USB2 PHY
* A USB3 SS controller
* More interrupt muxes

Hard to tell what else is different, because documentation is not
available.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Add CONFIG_COMMON_CLK_MMP2 to streamline the Makefile rule a tiny bit.

 arch/arm/mach-mmp/Kconfig   | 22 ++++++++++++++++++++--
 arch/arm/mach-mmp/Makefile  |  1 +
 arch/arm/mach-mmp/cputype.h | 27 +++++++++++++++++++++++++++
 arch/arm/mach-mmp/mmp3.c    | 29 +++++++++++++++++++++++++++++
 arch/arm/mach-mmp/time.c    |  3 ++-
 drivers/clk/Kconfig         |  5 +++++
 drivers/clk/mmp/Makefile    |  2 +-
 7 files changed, 85 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-mmp/mmp3.c

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 0440109e973b9..b58a03b18bdef 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_MMP
-	bool "Marvell PXA168/910/MMP2"
+	bool "Marvell PXA168/910/MMP2/MMP3"
 	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
 	select GPIO_PXA
 	select GPIOLIB
 	select PINCTRL
 	select PLAT_PXA
 	help
-	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
+	  Support for Marvell's PXA168/PXA910(MMP), MMP2, and MMP3 processor li=
nes.
=20
 if ARCH_MMP
=20
@@ -129,6 +129,24 @@ config MACH_MMP2_DT
 	  Include support for Marvell MMP2 based platforms using
 	  the device tree.
=20
+config MACH_MMP3_DT
+	bool "Support MMP3 (ARMv7) platforms"
+	depends on ARCH_MULTI_V7
+	select ARM_GIC
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select CACHE_L2X0
+	select PINCTRL
+	select PINCTRL_SINGLE
+	select ARCH_HAS_RESET_CONTROLLER
+	select CPU_PJ4B
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM && OF
+	help
+	  Say 'Y' here if you want to include support for platforms
+	  with Marvell MMP3 processor, also known as PXA2128 or
+	  Armada 620.
+
 endmenu
=20
 config CPU_PXA168
diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 8f267c7bc6e86..322c1c97dc900 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -34,5 +34,6 @@ obj-$(CONFIG_MACH_FLINT)	+=3D flint.o
 obj-$(CONFIG_MACH_MARVELL_JASPER) +=3D jasper.o
 obj-$(CONFIG_MACH_MMP_DT)	+=3D mmp-dt.o
 obj-$(CONFIG_MACH_MMP2_DT)	+=3D mmp2-dt.o
+obj-$(CONFIG_MACH_MMP3_DT)	+=3D mmp3.o
 obj-$(CONFIG_MACH_TETON_BGA)	+=3D teton_bga.o
 obj-$(CONFIG_MACH_GPLUGD)	+=3D gplugd.o
diff --git a/arch/arm/mach-mmp/cputype.h b/arch/arm/mach-mmp/cputype.h
index a96abcf521b4b..c3ec88983e940 100644
--- a/arch/arm/mach-mmp/cputype.h
+++ b/arch/arm/mach-mmp/cputype.h
@@ -18,6 +18,8 @@
  * MMP2	     Z0	   0x560f5811   0x00F00410
  * MMP2      Z1    0x560f5811   0x00E00410
  * MMP2      A0    0x560f5811   0x00A0A610
+ * MMP3      A0    0x562f5842   0x00A02128
+ * MMP3      B0    0x562f5842   0x00B02128
  */
=20
 extern unsigned int mmp_chip_id;
@@ -55,4 +57,29 @@ static inline int cpu_is_mmp2(void)
 #define cpu_is_mmp2()	(0)
 #endif
=20
+#ifdef CONFIG_MACH_MMP3_DT
+static inline int cpu_is_mmp3(void)
+{
+	return (((read_cpuid_id() >> 8) & 0xff) =3D=3D 0x58) &&
+		((mmp_chip_id & 0xffff) =3D=3D 0x2128);
+}
+
+static inline int cpu_is_mmp3_a0(void)
+{
+	return (cpu_is_mmp3() &&
+		((mmp_chip_id & 0x00ff0000) =3D=3D 0x00a00000));
+}
+
+static inline int cpu_is_mmp3_b0(void)
+{
+	return (cpu_is_mmp3() &&
+		((mmp_chip_id & 0x00ff0000) =3D=3D 0x00b00000));
+}
+
+#else
+#define cpu_is_mmp3()		(0)
+#define cpu_is_mmp3_a0()	(0)
+#define cpu_is_mmp3_b0()	(0)
+#endif
+
 #endif /* __ASM_MACH_CPUTYPE_H */
diff --git a/arch/arm/mach-mmp/mmp3.c b/arch/arm/mach-mmp/mmp3.c
new file mode 100644
index 0000000000000..b0e86964f302a
--- /dev/null
+++ b/arch/arm/mach-mmp/mmp3.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Marvell MMP3 aka PXA2128 aka 88AP2128 support
+ *
+ *  Copyright (C) 2019 Lubomir Rintel <lkundrak@v3.sk>
+ */
+
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/of_platform.h>
+#include <linux/clk-provider.h>
+#include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#include "common.h"
+
+static const char *const mmp3_dt_board_compat[] __initconst =3D {
+	"marvell,mmp3",
+	NULL,
+};
+
+DT_MACHINE_START(MMP2_DT, "Marvell MMP3")
+	.map_io		=3D mmp2_map_io,
+	.dt_compat	=3D mmp3_dt_board_compat,
+	.l2c_aux_val	=3D 1 << L310_AUX_CTRL_FWA_SHIFT |
+			  L310_AUX_CTRL_DATA_PREFETCH |
+			  L310_AUX_CTRL_INSTR_PREFETCH,
+	.l2c_aux_mask	=3D 0xc20fffff,
+MACHINE_END
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 3f6fd0be00512..8f4cacbf640e9 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -155,7 +155,8 @@ static void __init timer_config(void)
=20
 	__raw_writel(0x0, mmp_timer_base + TMR_CER); /* disable */
=20
-	ccr &=3D (cpu_is_mmp2()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
+	ccr &=3D (cpu_is_mmp2() || cpu_is_mmp3()) ?
+		(TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
 		(TMR_CCR_CS_0(3) | TMR_CCR_CS_1(3));
 	__raw_writel(ccr, mmp_timer_base + TMR_CCR);
=20
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 801fa1cd03217..8bb2ac83a1fcc 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -301,6 +301,11 @@ config COMMON_CLK_STM32H7
 	---help---
 	  Support for stm32h7 SoC family clocks
=20
+config COMMON_CLK_MMP2
+	def_bool COMMON_CLK && (MACH_MMP2_DT || MACH_MMP3_DT)
+	help
+	  Support for Marvell MMP2 and MMP3 SoC clocks
+
 config COMMON_CLK_BD718XX
 	tristate "Clock driver for ROHM BD718x7 PMIC"
 	depends on MFD_ROHM_BD718XX || MFD_ROHM_BD70528
diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index 7bc7ac69391e3..acc141adf087c 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -8,7 +8,7 @@ obj-y +=3D clk-apbc.o clk-apmu.o clk-frac.o clk-mix.o clk=
-gate.o clk.o
 obj-$(CONFIG_RESET_CONTROLLER) +=3D reset.o
=20
 obj-$(CONFIG_MACH_MMP_DT) +=3D clk-of-pxa168.o clk-of-pxa910.o
-obj-$(CONFIG_MACH_MMP2_DT) +=3D clk-of-mmp2.o
+obj-$(CONFIG_COMMON_CLK_MMP2) +=3D clk-of-mmp2.o
=20
 obj-$(CONFIG_CPU_PXA168) +=3D clk-pxa168.o
 obj-$(CONFIG_CPU_PXA910) +=3D clk-pxa910.o
--=20
2.21.0

