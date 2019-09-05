Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E532AC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D522173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeHnue+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbfIEFs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 01:48:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32975 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfIEFs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:48:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so778870pgn.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 22:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g1c0uKqcl2Uqys8hPkg4arH8tc4L0iWbYLMHcFcpz44=;
        b=CeHnue+XdE3z8T/pA2jTkiHC37W/Lr+ByNfl0cUmH2n7oEC0sX86vGn1OobsUdOX7I
         RIIU4DpVMt7LNgZ/JrmxPyeCpcIuLA05gcLYoi0iyKDBz8O5gdMeVoZSH/IXehoE+zIt
         zAjWTTAZ4x0siE6+8EMh63n/maNsRVvEWM1l3SqKiuiHU5xSB5d4Gc1fgTYGGN2z38qX
         7HGCeYLt4s/30CR4y9emxzALhTF+jCeW8InHl7p1tAXB4ejPES6sTcmryXt/6N8GWVuc
         9E9xG7ZheVjUg4kJwW24iUy6oXwuQww4Z15ZDv9esSS8tj+hqEDSsT8AwUjAs2TJq4Ho
         sDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g1c0uKqcl2Uqys8hPkg4arH8tc4L0iWbYLMHcFcpz44=;
        b=LrREIPVho6IcyDKxmfKLQhIGxWuSOKj3B917oeDzUFERD3XxvvbAo3rIO2zDPxImbO
         5mjCDU69irzTAbEjCnGweOz+TB92mk7RCax2P51WY1OO+NwPvQo6e77dB1EHncUcKI2N
         aas+uo5BH0mnZEAuRPxqNR2cQnDLCVbP0ZB2JRV82uZuaPL/z4wm5L/HwIwGZ3gt21Jw
         63xFPRDRlyN1h6F49s3za5klVQQZSYqXjzaFq7jKTouq366mI2vSTzRSYQ8VAxhoe00x
         Xb1drv4/n6rMiB2tINbJozlWfrovJ6SugIe9PtH4Jr91JOrDC3J5NDWS5s5APKxdyOVv
         dSvw==
X-Gm-Message-State: APjAAAVsWHHRoG70op/N3ou4WeY8K8qlgC4BTDhZbSc8xqZzCTywPmd0
        Y0z13YW/fB+8kXWb6+FSV2Q=
X-Google-Smtp-Source: APXvYqw9l30xKKHJt2RD4rDY7PBqvH0nNaPlKgiSXdlhGFBiuNDjRG595n1zw2C8LyCvKuYnZlPgKw==
X-Received: by 2002:a62:e216:: with SMTP id a22mr1690845pfi.249.1567662536413;
        Wed, 04 Sep 2019 22:48:56 -0700 (PDT)
Received: from localhost.localdomain ([49.216.8.243])
        by smtp.gmail.com with ESMTPSA id k31sm847472pjb.14.2019.09.04.22.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 22:48:55 -0700 (PDT)
From:   jamestai.sky@gmail.com
X-Google-Original-From: james.tai@realtek.com
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        Thierry Reding <treding@nvidia.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Rob Herring <robh@kernel.org>, CY_Huang <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>,
        "james.tai" <james.tai@realtek.com>
Subject: [PATCH] ARM: Add support for Realtek SOC
Date:   Thu,  5 Sep 2019 13:46:47 +0800
Message-Id: <20190905054647.1235-1-james.tai@realtek.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james.tai" <james.tai@realtek.com>

This patch adds the basic machine file for
the Realtek RTD16XX platform.

Signed-off-by: james.tai <james.tai@realtek.com>
---
 arch/arm/Kconfig                |  2 +
 arch/arm/Makefile               |  2 +
 arch/arm/mach-realtek/Kconfig   | 32 ++++++++++++
 arch/arm/mach-realtek/Makefile  |  3 ++
 arch/arm/mach-realtek/platsmp.c | 91 +++++++++++++++++++++++++++++++++
 arch/arm/mach-realtek/platsmp.h |  7 +++
 arch/arm/mach-realtek/realtek.c | 78 ++++++++++++++++++++++++++++
 7 files changed, 215 insertions(+)
 create mode 100644 arch/arm/mach-realtek/Kconfig
 create mode 100644 arch/arm/mach-realtek/Makefile
 create mode 100644 arch/arm/mach-realtek/platsmp.c
 create mode 100644 arch/arm/mach-realtek/platsmp.h
 create mode 100644 arch/arm/mach-realtek/realtek.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 33b00579beff..c7c9a3662eb7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -836,6 +836,8 @@ source "arch/arm/mach-zx/Kconfig"
 
 source "arch/arm/mach-zynq/Kconfig"
 
+source "arch/arm/mach-realtek/Kconfig"
+
 # ARMv7-M architecture
 config ARCH_EFM32
 	bool "Energy Micro efm32"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c3624ca6c0bc..1f0926449d47 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -148,6 +148,7 @@ endif
 textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
 textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
 textofs-$(CONFIG_ARCH_MESON) := 0x00208000
+textofs-$(CONFIG_ARCH_REALTEK) := 0x00208000
 textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 
 # Machine directory name.  This list is sorted alphanumerically
@@ -225,6 +226,7 @@ machine-$(CONFIG_ARCH_VT8500)		+= vt8500
 machine-$(CONFIG_ARCH_W90X900)		+= w90x900
 machine-$(CONFIG_ARCH_ZX)		+= zx
 machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
+machine-$(CONFIG_ARCH_REALTEK)		+= realtek
 machine-$(CONFIG_PLAT_SPEAR)		+= spear
 
 # Platform directory name.  This list is sorted alphanumerically
diff --git a/arch/arm/mach-realtek/Kconfig b/arch/arm/mach-realtek/Kconfig
new file mode 100644
index 000000000000..a8269964dbdb
--- /dev/null
+++ b/arch/arm/mach-realtek/Kconfig
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menuconfig ARCH_REALTEK
+	bool "Realtek SoCs"
+	select ARM_GLOBAL_TIMER
+	select CLKDEV_LOOKUP
+	select HAVE_SMP
+	select HAVE_MACH_CLKDEV
+	select GENERIC_CLOCKEVENTS
+	select HAVE_SCHED_CLOCK
+	select ARCH_HAS_CPUFREQ
+	select CLKSRC_OF
+	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	select PINCTRL
+	select COMMON_CLK
+	select ARCH_HAS_BARRIERS
+	select SPARSE_IRQ
+	select PM_OPP
+	select ARM_HAS_SG_CHAIN
+	select ARM_PATCH_PHYS_VIRT
+	select AUTO_ZRELADDR
+	select MIGHT_HAVE_PCI
+	select MULTI_IRQ_HANDLER
+	select PCI_DOMAINS if PCI
+	select USE_OF
+
+config ARCH_RTD16XX
+	bool "Enable support for RTD1619"
+	depends on ARCH_REALTEK
+	select ARM_GIC_V3
+	select ARM_PSCI
diff --git a/arch/arm/mach-realtek/Makefile b/arch/arm/mach-realtek/Makefile
new file mode 100644
index 000000000000..9cdc1f1f2917
--- /dev/null
+++ b/arch/arm/mach-realtek/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ARCH_REALTEK) += realtek.o
+obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-realtek/platsmp.c b/arch/arm/mach-realtek/platsmp.c
new file mode 100644
index 000000000000..5c4368fe1520
--- /dev/null
+++ b/arch/arm/mach-realtek/platsmp.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2019 Realtek Semiconductor Corp.
+ */
+
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/io.h>
+#include <linux/memory.h>
+#include <linux/smp.h>
+#include <linux/of.h>
+#include <linux/arm-smccc.h>
+#include <asm/smp_plat.h>
+#include <asm/cacheflush.h>
+#include <asm/cp15.h>
+#include <asm/barrier.h>
+
+#define BL31_CMD 0x8400ff04
+#define BL31_DAT 0x00001619
+#define CPUID 28
+#define CORE_PWRDN_EN 0x1
+
+#define CPUPWRCTLR __ACCESS_CP15(c15, 0, c2, 7)
+
+static u32 __iomem *cpu_release_virt;
+
+static int rtk_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long entry_pa = __pa_symbol(secondary_startup);
+
+	writel_relaxed(entry_pa | (cpu << CPUID), cpu_release_virt);
+
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	return 0;
+}
+
+void rtk_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *np;
+	u32 release_phys;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+
+		np = of_get_cpu_node(cpu, NULL);
+		if (!np)
+			continue;
+
+		if (of_property_read_u32(np, "cpu-release-addr", &release_phys))
+			continue;
+
+		cpu_release_virt = ioremap(release_phys, sizeof(u32));
+
+		set_cpu_present(cpu, true);
+	}
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+static void rtk_cpu_die(unsigned int cpu)
+{
+	struct arm_smccc_res res;
+	unsigned int cpu_pwr_ctrl;
+
+	writel_relaxed(0x0, cpu_release_virt);
+
+	/* notify BL31 cpu hotplug */
+	arm_smccc_smc(BL31_CMD, BL31_DAT, 0, 0, 0, 0, 0, 0, &res);
+	v7_exit_coherency_flush(louis);
+
+	cpu_pwr_ctrl = read_sysreg(CPUPWRCTLR);
+	cpu_pwr_ctrl |= CORE_PWRDN_EN;
+	write_sysreg(cpu_pwr_ctrl, CPUPWRCTLR);
+
+	dsb(sy);
+
+	for (;;)
+		wfi();
+}
+#endif
+
+struct smp_operations rtk_smp_ops __initdata = {
+	.smp_prepare_cpus = rtk_prepare_cpus,
+	.smp_boot_secondary = rtk_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die = rtk_cpu_die,
+#endif
+};
diff --git a/arch/arm/mach-realtek/platsmp.h b/arch/arm/mach-realtek/platsmp.h
new file mode 100644
index 000000000000..9c411d097c14
--- /dev/null
+++ b/arch/arm/mach-realtek/platsmp.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Copyright (c) 2019 Realtek Semiconductor Corp.
+ */
+
+extern struct smp_operations rtk_smp_ops;
diff --git a/arch/arm/mach-realtek/realtek.c b/arch/arm/mach-realtek/realtek.c
new file mode 100644
index 000000000000..d248e19f4c1d
--- /dev/null
+++ b/arch/arm/mach-realtek/realtek.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2019 Realtek Semiconductor Corp.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+#include <linux/memblock.h>
+#include <linux/delay.h>
+#include <linux/clockchips.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/system_misc.h>
+#include <asm/system_info.h>
+
+#include "platsmp.h"
+
+#define RBUS_BASE_PHYS (0x98000000)
+#define RBUS_BASE_VIRT (0xfe000000)
+#define RBUS_BASE_SIZE (0x00100000)
+
+static struct map_desc rtk_io_desc[] __initdata = {
+	{
+		.virtual = (unsigned long) IOMEM(RBUS_BASE_VIRT),
+		.pfn = __phys_to_pfn(RBUS_BASE_PHYS),
+		.length = RBUS_BASE_SIZE,
+		.type = MT_DEVICE,
+	},
+};
+
+void __init rtk_map_io(void)
+{
+	debug_ll_io_init();
+	iotable_init(rtk_io_desc, ARRAY_SIZE(rtk_io_desc));
+}
+
+static void __init rtk_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static void __init rtk_timer_init(void)
+{
+#ifdef CONFIG_COMMON_CLK
+	of_clk_init(NULL);
+#endif
+	timer_probe();
+	tick_setup_hrtimer_broadcast();
+}
+
+bool __init rtk_smp_init_ops(void)
+{
+	smp_set_ops(smp_ops(rtk_smp_ops));
+
+	return true;
+}
+
+static const char *const rtd16xx_board_dt_compat[] = {
+	"realtek,rtd1619",
+	NULL,
+};
+
+DT_MACHINE_START(RTD16XX, "Realtek rtd16xx platform")
+	.map_io = rtk_map_io,
+	.init_machine = rtk_dt_init,
+	.init_time = rtk_timer_init,
+	.dt_compat = rtd16xx_board_dt_compat,
+	.smp = smp_ops(rtk_smp_ops),
+	.smp_init = smp_init_ops(rtk_smp_init_ops),
+MACHINE_END
-- 
2.17.1

