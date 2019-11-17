Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574C8C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 07:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A99020740
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 07:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfKQHVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 02:21:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:40748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbfKQHVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 02:21:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA4DFB22C;
        Sun, 17 Nov 2019 07:21:19 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 2/8] ARM: Prepare Realtek RTD1195
Date:   Sun, 17 Nov 2019 08:21:03 +0100
Message-Id: <20191117072109.20402-3-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191117072109.20402-1-afaerber@suse.de>
References: <20191117072109.20402-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce ARCH_REALTEK Kconfig option also for 32-bit Arm.

Override the text offset to cope with boot ROM occupying first 0xa800
bytes and further reservations up to 0xf4000 (compare Device Tree).

Add a custom machine_desc to enforce memory carveout for I/O registers.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2 -> v3:
 * Fixed r-bus size in .reserve from 0x100000 to 0x70000 (James)
 
 v1 -> v2:
 * Dropped selection of COMMON_CLK (Arnd)
 * Dropped selection of AMBA, SCU, TWD
 * Added comment about text offset to distinguish from HTC comment above
 * Added machine_desc with .reserve to exclude peripheral spaces (Rob)
 
 arch/arm/Kconfig                |  2 ++
 arch/arm/Makefile               |  3 +++
 arch/arm/mach-realtek/Kconfig   | 11 +++++++++++
 arch/arm/mach-realtek/Makefile  |  2 ++
 arch/arm/mach-realtek/rtd1195.c | 37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 55 insertions(+)
 create mode 100644 arch/arm/mach-realtek/Kconfig
 create mode 100644 arch/arm/mach-realtek/Makefile
 create mode 100644 arch/arm/mach-realtek/rtd1195.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9771b56e79f1..cd37b5e9f86d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -699,6 +699,8 @@ source "arch/arm/mach-qcom/Kconfig"
 
 source "arch/arm/mach-rda/Kconfig"
 
+source "arch/arm/mach-realtek/Kconfig"
+
 source "arch/arm/mach-realview/Kconfig"
 
 source "arch/arm/mach-rockchip/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index db857d07114f..16d41efea7f2 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -148,6 +148,8 @@ head-y		:= arch/arm/kernel/head$(MMUEXT).o
 textofs-y	:= 0x00008000
 # We don't want the htc bootloader to corrupt kernel during resume
 textofs-$(CONFIG_PM_H1940)      := 0x00108000
+# RTD1195 has Boot ROM at start of address space
+textofs-$(CONFIG_ARCH_REALTEK)  := 0x00108000
 # SA1111 DMA bug: we don't want the kernel to live in precious DMA-able memory
 ifeq ($(CONFIG_ARCH_SA1100),y)
 textofs-$(CONFIG_SA1111) := 0x00208000
@@ -207,6 +209,7 @@ machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
 machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_QCOM)		+= qcom
 machine-$(CONFIG_ARCH_RDA)		+= rda
+machine-$(CONFIG_ARCH_REALTEK)		+= realtek
 machine-$(CONFIG_ARCH_REALVIEW)		+= realview
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_RPC)		+= rpc
diff --git a/arch/arm/mach-realtek/Kconfig b/arch/arm/mach-realtek/Kconfig
new file mode 100644
index 000000000000..19fdcf093fd1
--- /dev/null
+++ b/arch/arm/mach-realtek/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+menuconfig ARCH_REALTEK
+	bool "Realtek SoCs"
+	depends on ARCH_MULTI_V7
+	select ARM_GIC
+	select ARM_GLOBAL_TIMER
+	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
+	select GENERIC_IRQ_CHIP
+	select RESET_CONTROLLER
+	help
+	  This enables support for the Realtek RTD1195 SoC family.
diff --git a/arch/arm/mach-realtek/Makefile b/arch/arm/mach-realtek/Makefile
new file mode 100644
index 000000000000..5382d5bbdd3c
--- /dev/null
+++ b/arch/arm/mach-realtek/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+obj-y += rtd1195.o
diff --git a/arch/arm/mach-realtek/rtd1195.c b/arch/arm/mach-realtek/rtd1195.c
new file mode 100644
index 000000000000..b31a4066be87
--- /dev/null
+++ b/arch/arm/mach-realtek/rtd1195.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Realtek RTD1195
+ *
+ * Copyright (c) 2017-2019 Andreas Färber
+ */
+
+#include <linux/memblock.h>
+#include <asm/mach/arch.h>
+
+static void __init rtd1195_memblock_remove(phys_addr_t base, phys_addr_t size)
+{
+	int ret;
+
+	ret = memblock_remove(base, size);
+	if (ret)
+		pr_err("Failed to remove memblock %pa (%d)\n", &base, ret);
+}
+
+static void __init rtd1195_reserve(void)
+{
+	/* Exclude peripheral register spaces from RAM */
+	rtd1195_memblock_remove(0x18000000, 0x00070000);
+	rtd1195_memblock_remove(0x18100000, 0x01000000);
+}
+
+static const char *const rtd1195_dt_compat[] __initconst = {
+	"realtek,rtd1195",
+	NULL
+};
+
+DT_MACHINE_START(rtd1195, "Realtek RTD1195")
+	.dt_compat = rtd1195_dt_compat,
+	.reserve = rtd1195_reserve,
+	.l2c_aux_val = 0x0,
+	.l2c_aux_mask = ~0x0,
+MACHINE_END
-- 
2.16.4

