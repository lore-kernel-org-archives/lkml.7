Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDD5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BE4218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjVNMVrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfCUOoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:44:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43329 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfCUOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:44:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so4426749pfd.10;
        Thu, 21 Mar 2019 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pd7DZgFZHydc22jsnva6HCwIQ6qYSallrsNWhLPd39k=;
        b=rjVNMVrAZDzk6WalHOKZlusXykVZ74sm6Da1S3WemT13MtWwKW0ojyarUbnDoX9PAs
         x/Ug4Oo4BUhuxm20/g8Lw74Axo8oVLZYDjnc+HnGNfV3Hpc3f33DJogpHhKhW5Py1T8T
         UdIexXnKF+1jex93Knu1GMZ4YyAD//pJQ8GCf3nqBTeBUKvVe+uMDM0p847iOqiFC++P
         vXRXPPCagKrgtTAbZf0ZuBhHBVGfwarhqRTShpJPDSyXBbDGdRcHtwit1xUdMAznsPfp
         Ok5WpD3EoydwuQU+04j74qLKpDew6ccsAmUm67590ksFaRZSn7LfTR6SiBrnhZjIMA8A
         cK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pd7DZgFZHydc22jsnva6HCwIQ6qYSallrsNWhLPd39k=;
        b=l+esABcq76rBxa0uDwHveI86JtKNmfmfLB2Ytmx3aXmlmTsl2PR+iurgC2dk7EfIEr
         9zbzu6VrWDScbz5ckQIUkTirJCVzJ5jdBAp3Iu0luzpJsk0F9kKzxxqTQ2QWIyNIlZmi
         ZzYljjsk/axgbn4ETMxhYVoqHVmFcfzu73CtZqW5+zRu08sZwBmD6aOmt3kcitBs/Feo
         c8h25GW3czdYRW97jdh4XHhXolclF+BQlCB6ylj0AQGI1IVmrDr51Myd+eA2c326bVrG
         C6Kl0hSa222FkVHrJIIBpYqK6PYXC846y2/qc2YZGWdicsXyusUUQyGWUCegXTE7GmT+
         SyDw==
X-Gm-Message-State: APjAAAXh9j3xUM1s7v+VITbZuKs7DrL2Z4dS1rYYeR6AVKMV+bHv+sOf
        8zOnS80DwlDStQvXTUD09S3a5AXAFLSJkg==
X-Google-Smtp-Source: APXvYqyJMUU8zjwTSKzJyUIa1TV3n+P/VwdL+aNnTUBgQUAfLAud/bKMoD2SI866CEivnAB3Plsg2g==
X-Received: by 2002:a62:4414:: with SMTP id r20mr3663491pfa.37.1553179446705;
        Thu, 21 Mar 2019 07:44:06 -0700 (PDT)
Received: from GuoGuo-OMEN.lan ([107.151.139.128])
        by smtp.gmail.com with ESMTPSA id f4sm6158811pgq.94.2019.03.21.07.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 07:44:06 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] MIPS: ralink: fix cpu clock of mt7621 and add dt clk devices
Date:   Thu, 21 Mar 2019 22:42:51 +0800
Message-Id: <20190321144251.28313-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a long time the mt7621 uses a fixed cpu clock which causes a problem
if the cpu frequency is not 880MHz.

This patch fixes the cpu clock calculation and adds the cpu/bus clkdev
which will be used in dts.

Signed-off-by: Weijie Gao <hackpascal@gmail.com>

Ported from OpenWrt:
c7ca224299 ramips: fix cpu clock of mt7621 and add dt clk devices

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---

Change since v1:
 Correctly fix the following checkpatch.pl warning:
 WARNING: Missing a blank line after declarations
 #137: FILE: arch/mips/ralink/mt7621.c:146:
 +	u32 xtal_clk, cpu_clk, bus_clk;
 +	const static u32 prediv_tbl[] = {0, 1, 2, 2};

 arch/mips/include/asm/mach-ralink/mt7621.h |  20 ++++
 arch/mips/ralink/mt7621.c                  | 102 ++++++++++++++-------
 arch/mips/ralink/timer-gic.c               |   4 +-
 3 files changed, 93 insertions(+), 33 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/mt7621.h b/arch/mips/include/asm/mach-ralink/mt7621.h
index a672e06fa5fd..b8a8834164c8 100644
--- a/arch/mips/include/asm/mach-ralink/mt7621.h
+++ b/arch/mips/include/asm/mach-ralink/mt7621.h
@@ -19,6 +19,10 @@
 #define SYSC_REG_CHIP_REV		0x0c
 #define SYSC_REG_SYSTEM_CONFIG0		0x10
 #define SYSC_REG_SYSTEM_CONFIG1		0x14
+#define SYSC_REG_CLKCFG0		0x2c
+#define SYSC_REG_CUR_CLK_STS		0x44
+
+#define MEMC_REG_CPU_PLL		0x648
 
 #define CHIP_REV_PKG_MASK		0x1
 #define CHIP_REV_PKG_SHIFT		16
@@ -26,6 +30,22 @@
 #define CHIP_REV_VER_SHIFT		8
 #define CHIP_REV_ECO_MASK		0xf
 
+#define XTAL_MODE_SEL_MASK		0x7
+#define XTAL_MODE_SEL_SHIFT		6
+
+#define CPU_CLK_SEL_MASK		0x3
+#define CPU_CLK_SEL_SHIFT		30
+
+#define CUR_CPU_FDIV_MASK		0x1f
+#define CUR_CPU_FDIV_SHIFT		8
+#define CUR_CPU_FFRAC_MASK		0x1f
+#define CUR_CPU_FFRAC_SHIFT		0
+
+#define CPU_PLL_PREDIV_MASK		0x3
+#define CPU_PLL_PREDIV_SHIFT		12
+#define CPU_PLL_FBDIV_MASK		0x7f
+#define CPU_PLL_FBDIV_SHIFT		4
+
 #define MT7621_DRAM_BASE                0x0
 #define MT7621_DDR2_SIZE_MIN		32
 #define MT7621_DDR2_SIZE_MAX		256
diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index d2718de60b9b..6828eefb0a85 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -9,22 +9,22 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <dt-bindings/clock/mt7621-clk.h>
 
 #include <asm/mipsregs.h>
 #include <asm/smp-ops.h>
 #include <asm/mips-cps.h>
 #include <asm/mach-ralink/ralink_regs.h>
 #include <asm/mach-ralink/mt7621.h>
+#include <asm/time.h>
 
 #include <pinmux.h>
 
 #include "common.h"
 
-#define SYSC_REG_SYSCFG		0x10
-#define SYSC_REG_CPLL_CLKCFG0	0x2c
-#define SYSC_REG_CUR_CLK_STS	0x44
-#define CPU_CLK_SEL		(BIT(30) | BIT(31))
-
 #define MT7621_GPIO_MODE_UART1		1
 #define MT7621_GPIO_MODE_I2C		2
 #define MT7621_GPIO_MODE_UART3_MASK	0x3
@@ -110,49 +110,89 @@ static struct rt2880_pmx_group mt7621_pinmux_data[] = {
 	{ 0 }
 };
 
+static struct clk *clks[MT7621_CLK_MAX];
+static struct clk_onecell_data clk_data = {
+	.clks = clks,
+	.clk_num = ARRAY_SIZE(clks),
+};
+
 phys_addr_t mips_cpc_default_phys_base(void)
 {
 	panic("Cannot detect cpc address");
 }
 
+static struct clk *__init mt7621_add_sys_clkdev(
+	const char *id, unsigned long rate)
+{
+	struct clk *clk;
+	int err;
+
+	clk = clk_register_fixed_rate(NULL, id, NULL, 0, rate);
+	if (IS_ERR(clk))
+		panic("failed to allocate %s clock structure", id);
+
+	err = clk_register_clkdev(clk, id, NULL);
+	if (err)
+		panic("unable to register %s clock device", id);
+
+	return clk;
+}
+
 void __init ralink_clk_init(void)
 {
-	int cpu_fdiv = 0;
-	int cpu_ffrac = 0;
-	int fbdiv = 0;
-	u32 clk_sts, syscfg;
-	u8 clk_sel = 0, xtal_mode;
-	u32 cpu_clk;
+	const static u32 prediv_tbl[] = {0, 1, 2, 2};
+	u32 syscfg, xtal_sel, clkcfg, clk_sel, curclk, ffiv, ffrac;
+	u32 pll, prediv, fbdiv;
+	u32 xtal_clk, cpu_clk, bus_clk;
+
+	syscfg = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG0);
+	xtal_sel = (syscfg >> XTAL_MODE_SEL_SHIFT) & XTAL_MODE_SEL_MASK;
 
-	if ((rt_sysc_r32(SYSC_REG_CPLL_CLKCFG0) & CPU_CLK_SEL) != 0)
-		clk_sel = 1;
+	clkcfg = rt_sysc_r32(SYSC_REG_CLKCFG0);
+	clk_sel = (clkcfg >> CPU_CLK_SEL_SHIFT) & CPU_CLK_SEL_MASK;
+
+	curclk = rt_sysc_r32(SYSC_REG_CUR_CLK_STS);
+	ffiv = (curclk >> CUR_CPU_FDIV_SHIFT) & CUR_CPU_FDIV_MASK;
+	ffrac = (curclk >> CUR_CPU_FFRAC_SHIFT) & CUR_CPU_FFRAC_MASK;
+
+	if (xtal_sel <= 2)
+		xtal_clk = 20 * 1000 * 1000;
+	else if (xtal_sel <= 5)
+		xtal_clk = 40 * 1000 * 1000;
+	else
+		xtal_clk = 25 * 1000 * 1000;
 
 	switch (clk_sel) {
 	case 0:
-		clk_sts = rt_sysc_r32(SYSC_REG_CUR_CLK_STS);
-		cpu_fdiv = ((clk_sts >> 8) & 0x1F);
-		cpu_ffrac = (clk_sts & 0x1F);
-		cpu_clk = (500 * cpu_ffrac / cpu_fdiv) * 1000 * 1000;
+		cpu_clk = 500 * 1000 * 1000;
 		break;
-
 	case 1:
-		fbdiv = ((rt_sysc_r32(0x648) >> 4) & 0x7F) + 1;
-		syscfg = rt_sysc_r32(SYSC_REG_SYSCFG);
-		xtal_mode = (syscfg >> 6) & 0x7;
-		if (xtal_mode >= 6) {
-			/* 25Mhz Xtal */
-			cpu_clk = 25 * fbdiv * 1000 * 1000;
-		} else if (xtal_mode >= 3) {
-			/* 40Mhz Xtal */
-			cpu_clk = 40 * fbdiv * 1000 * 1000;
-		} else {
-			/* 20Mhz Xtal */
-			cpu_clk = 20 * fbdiv * 1000 * 1000;
-		}
+		pll = rt_memc_r32(MEMC_REG_CPU_PLL);
+		fbdiv = (pll >> CPU_PLL_FBDIV_SHIFT) & CPU_PLL_FBDIV_MASK;
+		prediv = (pll >> CPU_PLL_PREDIV_SHIFT) & CPU_PLL_PREDIV_MASK;
+		cpu_clk = ((fbdiv + 1) * xtal_clk) >> prediv_tbl[prediv];
 		break;
+	default:
+		cpu_clk = xtal_clk;
 	}
+
+	cpu_clk = cpu_clk / ffiv * ffrac;
+	bus_clk = cpu_clk / 4;
+
+	clks[MT7621_CLK_CPU] = mt7621_add_sys_clkdev("cpu", cpu_clk);
+	clks[MT7621_CLK_BUS] = mt7621_add_sys_clkdev("bus", bus_clk);
+
+	pr_info("CPU Clock: %dMHz\n", cpu_clk / 1000000);
+	mips_hpt_frequency = cpu_clk / 2;
 }
 
+static void __init mt7621_clocks_init_dt(struct device_node *np)
+{
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+}
+
+CLK_OF_DECLARE(mt7621_clk, "mediatek,mt7621-pll", mt7621_clocks_init_dt);
+
 void __init ralink_of_remap(void)
 {
 	rt_sysc_membase = plat_of_remap_node("mtk,mt7621-sysc");
diff --git a/arch/mips/ralink/timer-gic.c b/arch/mips/ralink/timer-gic.c
index b5f07d21fcf2..4fed842ae8eb 100644
--- a/arch/mips/ralink/timer-gic.c
+++ b/arch/mips/ralink/timer-gic.c
@@ -11,14 +11,14 @@
 
 #include <linux/of.h>
 #include <linux/clk-provider.h>
-#include <linux/clocksource.h>
+#include <asm/time.h>
 
 #include "common.h"
 
 void __init plat_time_init(void)
 {
 	ralink_of_remap();
-
+	ralink_clk_init();
 	of_clk_init(NULL);
 	timer_probe();
 }
-- 
2.21.0

