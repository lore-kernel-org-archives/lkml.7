Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A38C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826702192D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfCWOcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:32:03 -0400
Received: from asrmicro.com ([210.13.118.86]:45431 "EHLO spam.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbfCWOcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:32:02 -0400
Received: from spam.asrmicro.com (localhost [127.0.0.2] (may be forged))
        by spam.asrmicro.com with ESMTP id x2NE7ITB031491;
        Sat, 23 Mar 2019 22:07:18 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123])
        by spam.asrmicro.com with ESMTP id x2NE6x2l031451;
        Sat, 23 Mar 2019 22:06:59 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from localhost (10.1.170.171) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Sat, 23 Mar 2019 22:08:36
 +0800
From:   qiaozhou <qiaozhou@asrmicro.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     Qiao Zhou <qiaozhou@asrmicro.com>
Subject: [PATCH] clk: asr: clock driver support for ASR AquilaC Soc
Date:   Sat, 23 Mar 2019 22:08:35 +0800
Message-ID: <1553350115-2614-1-git-send-email-qiaozhou@asrmicro.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.170.171]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
X-DNSRBL: 
X-MAIL: spam.asrmicro.com x2NE6x2l031451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiao Zhou <qiaozhou@asrmicro.com>

add clock driver support for ASR AquilaC SoC.

We add clk-gate, clk-mix, and clk-pll drivers:
1. clk-gate driver is for regisers which have different enable/disable bits
to control gating.
2. clk-mix driver is for registers which request to set div and mux
bits at the same time.
3. clk-pll driver is for pll configuration.

Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
---
 drivers/clk/Kconfig           |   1 +
 drivers/clk/Makefile          |   1 +
 drivers/clk/asr/Kconfig       |  17 ++
 drivers/clk/asr/Makefile      |   6 +
 drivers/clk/asr/clk-aquilac.c | 595 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/asr/clk-gate.c    | 151 ++++++++++
 drivers/clk/asr/clk-mix.c     | 393 ++++++++++++++++++++++++++
 drivers/clk/asr/clk-pll.c     | 642 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/asr/clk-pll.h     |  91 ++++++
 drivers/clk/asr/clk.c         | 222 +++++++++++++++
 drivers/clk/asr/clk.h         | 235 ++++++++++++++++
 11 files changed, 2354 insertions(+)
 create mode 100644 drivers/clk/asr/Kconfig
 create mode 100644 drivers/clk/asr/Makefile
 create mode 100644 drivers/clk/asr/clk-aquilac.c
 create mode 100644 drivers/clk/asr/clk-gate.c
 create mode 100644 drivers/clk/asr/clk-mix.c
 create mode 100644 drivers/clk/asr/clk-pll.c
 create mode 100644 drivers/clk/asr/clk-pll.h
 create mode 100644 drivers/clk/asr/clk.c
 create mode 100644 drivers/clk/asr/clk.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e705aab..0ea9f74 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -315,5 +315,6 @@ source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
 source "drivers/clk/uniphier/Kconfig"
 source "drivers/clk/zynqmp/Kconfig"
+source "drivers/clk/asr/Kconfig"
 
 endmenu
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 1db1336..a88b3b9 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -112,3 +112,4 @@ endif
 obj-$(CONFIG_ARCH_ZX)			+= zte/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
 obj-$(CONFIG_COMMON_CLK_ZYNQMP)         += zynqmp/
+obj-$(CONFIG_COMMON_CLK_ASR)		+= asr/
diff --git a/drivers/clk/asr/Kconfig b/drivers/clk/asr/Kconfig
new file mode 100644
index 0000000..ded68b5
--- /dev/null
+++ b/drivers/clk/asr/Kconfig
@@ -0,0 +1,17 @@
+config COMMON_CLK_ASR
+	bool "Support for ASR's clock controllers"
+	depends on OF
+	depends on ARCH_ASR || COMPILE_TEST
+	help
+	  Build the clock drivers for ASR8751C SoC. It contains clock-gate,
+	  clock-mix, clock-pll drivers which manages general gating, divider,
+	  mux, and pll enabling/disabling controls.
+	  Say Y if you want to support clock controls on ASR8751C SoCs
+
+config ASR_AQUILAC_CLK
+	bool "ASR AquilaC clock controller support"
+	depends on OF
+	depends on ARCH_ASR
+	depends on COMMON_CLK_ASR
+	help
+	  Build the clock driver for ASR8751C AquilaC development board.
diff --git a/drivers/clk/asr/Makefile b/drivers/clk/asr/Makefile
new file mode 100644
index 0000000..f6b9bd3
--- /dev/null
+++ b/drivers/clk/asr/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for asr specific clk
+#
+
+obj-$(CONFIG_COMMON_CLK_ASR) += clk-pll.o clk-gate.o clk-mix.o clk.o
+obj-$(CONFIG_ASR_AQUILAC_CLK) += clk-aquilac.o
diff --git a/drivers/clk/asr/clk-aquilac.c b/drivers/clk/asr/clk-aquilac.c
new file mode 100644
index 0000000..7274b60
--- /dev/null
+++ b/drivers/clk/asr/clk-aquilac.c
@@ -0,0 +1,595 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * clock driver file for asr AquilaC
+ *
+ * Copyright (C) 2019 ASR Microelectronics(Shanghai) Co., Ltd.
+ * Gang Wu <gangwu@asrmicro.com>
+ * Qiao	Zhou <qiaozhou@asrmicro.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/devfreq.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <dt-bindings/clock/asr8751c-clk.h>
+#include "clk.h"
+#include "clk-pll.h"
+
+/* APBC register offset for asr AquilaC */
+#define APBC_UART0			0x0
+#define APBC_UART1			0x4
+#define APBC_GPIO			0x8
+#define APBC_SSP0			0x1c
+#define APBC_IPC			0x24
+#define APBC_RTC			0x28
+#define APBC_TWSI0			0x2c
+#define APBC_KPC			0x30
+#define APBC_TIMERS			0x34
+#define APBC_AIB			0x3c
+#define APBC_SSP2			0x4c
+#define APBC_TWSI1			0x60
+#define APBC_THERMAL			0x6c
+#define APBC_UART2			0x78
+#define APBC_TWSI4			0x7c
+#define APBC_TWSI5			0x80
+#define APBC_TWSI6			0x84
+#define APBC_TWSI7			0x88
+#define APBC_TWSI8			0x8c
+
+#define MPMU_UART_PLL			0x14
+#define MPMU_WDTPCR			0x200
+
+#define APMU_SDH0			0x54
+#define APMU_SDH1			0x58
+#define APMU_SDH2			0xe0
+#define APMU_USB			0x5c
+#define APMU_DMA			0x64
+#define APMU_AES			0x68
+#define APMU_TRACE_CONFIG		0x108
+
+#define APB_SPARE_PLL1CR		0x100
+#define APB_SPARE_PLL2CR		0x104
+#define APB_SPARE_PLL3CR		0x108
+#define APB_SPARE_PLL4CR		0x124
+#define APB_SPARE_PLL5CR		0x114
+#define APB_SPARE_PLL6CR		0x13c
+#define APB_SPARE_PLL6CR2		0x140
+#define APB_SPARE_PLL7CR		0x148
+#define APB_SPARE_PLL7CR2		0x14c
+
+#define MPMU_PLL2CR			0x34
+#define MPMU_PLL3CR			0x1c
+#define MPMU_PLL4CR			0x50
+#define MPMU_PLL4CR			0x50
+#define MPMU_PLL5CR			0x4c
+#define MPMU_POSR			0x10
+#define POSR_PLL1_LOCK			(1 << 27)
+#define POSR_PLL2_LOCK			(1 << 28)
+#define POSR_PLL3_LOCK			(1 << 29)
+#define POSR_PLL4_LOCK			(1 << 30)
+#define POSR_PLL5_LOCK			(1 << 31)
+#define POSR_PLL6_LOCK			(1 << 31)
+#define POSR_PLL7_LOCK			(1 << 31)
+
+#define MPMU_ACGR			0x1024
+
+enum pll {
+	PLL2 = 0,
+	PLL3,
+	PLL4,
+	PLL5,
+	PLL6,
+	PLL7,
+	MAX_PLL_NUM,
+};
+
+struct plat_pll_info {
+	spinlock_t lock;
+	const char *vco_name;
+	/* clk flags */
+	unsigned long vco_flag;
+	unsigned long vcoclk_flag;
+	/* dt index */
+	unsigned int vcodtidx;
+};
+
+static struct asr_vco_params pllx_vco_params[MAX_PLL_NUM] __initdata = {
+	{
+		.vco_min = 600000000UL,
+		.vco_max = 2700000000UL,
+		.cr_off = MPMU_PLL2CR,
+		.swcr_off = APB_SPARE_PLL2CR,
+		.lock_off = MPMU_POSR,
+		.lock_enable_bit = POSR_PLL2_LOCK,
+	},
+	{
+		.vco_min = 600000000UL,
+		.vco_max = 2700000000UL,
+		.cr_off = MPMU_PLL3CR,
+		.swcr_off = APB_SPARE_PLL3CR,
+		.lock_off = MPMU_POSR,
+		.lock_enable_bit = POSR_PLL3_LOCK,
+	},
+	{
+		.vco_min = 600000000UL,
+		.vco_max = 2700000000UL,
+		.cr_off = MPMU_PLL4CR,
+		.swcr_off = APB_SPARE_PLL4CR,
+		.lock_off = MPMU_POSR,
+		.lock_enable_bit = POSR_PLL4_LOCK,
+	},
+	{
+		.vco_min = 600000000UL,
+		.vco_max = 2700000000UL,
+		.cr_off = MPMU_PLL5CR,
+		.swcr_off = APB_SPARE_PLL5CR,
+		.lock_off = MPMU_POSR,
+		.lock_enable_bit = POSR_PLL5_LOCK,
+	},
+	{
+		.vco_min = 600000000UL,
+		.vco_max = 2700000000UL,
+		.swcr_off = APB_SPARE_PLL6CR,
+		.swcr_off = APB_SPARE_PLL6CR2,
+		.lock_off = APB_SPARE_PLL6CR2,
+		.lock_enable_bit = POSR_PLL6_LOCK,
+	},
+	{
+		.vco_min = 600000000UL,
+		.vco_max = 2700000000UL,
+		.swcr_off = APB_SPARE_PLL7CR,
+		.swcr2_off = APB_SPARE_PLL7CR2,
+		.lock_off = APB_SPARE_PLL7CR2,
+		.lock_enable_bit = POSR_PLL7_LOCK,
+	},
+};
+
+static struct plat_pll_info pllx_platinfo[MAX_PLL_NUM] __initdata = {
+	{
+		.vco_name = "pll2_vco",
+		.vcoclk_flag = 0,
+		.vco_flag = ASR_PLL_FRAC_FEAT | ASR_PLL_SKIP_DEF_RATE,
+		.vcodtidx = ASR_CLK_PLL2_VCO,
+	},
+	{
+		.vco_name = "pll3_vco",
+		.vcoclk_flag = 0,
+		.vco_flag = ASR_PLL_FRAC_FEAT | ASR_PLL_SKIP_DEF_RATE,
+		.vcodtidx = ASR_CLK_PLL3_VCO,
+	},
+
+	{
+		.vco_name = "pll4_vco",
+		.vcoclk_flag = 0,
+		.vco_flag = ASR_PLL_FRAC_FEAT | ASR_PLL_SKIP_DEF_RATE,
+		.vcodtidx = ASR_CLK_PLL4_VCO,
+	},
+	{
+		.vco_name = "pll5_vco",
+		.vcoclk_flag = 0,
+		.vco_flag = ASR_PLL_FRAC_FEAT | ASR_PLL_SKIP_DEF_RATE,
+		.vcodtidx = ASR_CLK_PLL5_VCO,
+	},
+	{
+		.vco_name = "pll6_vco",
+		.vcoclk_flag = 0,
+		.vco_flag = ASR_PLL_FRAC_FEAT | ASR_PLL_REG_NEW | ASR_PLL_SKIP_DEF_RATE,
+		.vcodtidx = ASR_CLK_PLL6_VCO,
+	},
+	{
+		.vco_name = "pll7_vco",
+		.vcoclk_flag = 0,
+		.vco_flag = ASR_PLL_FRAC_FEAT | ASR_PLL_FRAC_AUDIO | ASR_PLL_REG_NEW | ASR_PLL_SKIP_DEF_RATE,
+		.vcodtidx = ASR_CLK_PLL7_VCO,
+	},
+};
+
+static DEFINE_SPINLOCK(pll1_lock);
+static DEFINE_SPINLOCK(pll2_lock);
+static DEFINE_SPINLOCK(pll3_lock);
+static DEFINE_SPINLOCK(pll4_lock);
+static DEFINE_SPINLOCK(pll5_lock);
+static DEFINE_SPINLOCK(pll6_lock);
+static DEFINE_SPINLOCK(pll7_lock);
+static DEFINE_SPINLOCK(pll1_lock_2);
+static DEFINE_SPINLOCK(uart0_lock);
+static DEFINE_SPINLOCK(uart1_lock);
+static DEFINE_SPINLOCK(uart2_lock);
+static DEFINE_SPINLOCK(timer0_lock);
+static DEFINE_SPINLOCK(sdh0_lock);
+static DEFINE_SPINLOCK(sdh1_lock);
+static DEFINE_SPINLOCK(sdh2_lock);
+
+static const char * const uart_parent[] = {"pll1_58p5", "uart_pll"};
+static const char * const aes_parent[] = {"pll1_208", "pll1_104"};
+static const char * const ssp_parent[] = {
+	"pll1_6p5", "pll1_13", "pll1_26", "pll1_52"};
+static const char * const timer_parent[] = {
+	"pll1_13", "clk32", "pll1_6p5", "vctcxo_3p25", "vctcxo_1"};
+static const char * const sdh_parent_names[] = {
+	"pll1_416", "pll1_624", "pll6_d2", "pll6_d4"};
+static const char * const keep_on_clocks_tbl[] = {
+	"dma_clk", "gpio_clk", "pll1_624", "pll1_26"};
+static unsigned long pll_rates[MAX_PLL_NUM] = {
+	2100 * MHZ, 1900 * MHZ, 1400 * MHZ, 1540 * MHZ,
+	1600 * MHZ, 1536 * MHZ};
+
+static struct asr_clk_mix_clk_table sdh_pptbl[] = {
+	{.rate = 200000000, .parent_index = 3, },
+	{.rate = 208000000, .parent_index = 0, },
+	{.rate = 312000000, .parent_index = 1, },
+	{.rate = 400000000, .parent_index = 3, },
+	{.rate = 800000000, .parent_index = 2, },
+};
+static struct asr_clk_mix_config sdh_mix_config = {
+	.reg_info = DEFINE_MIX_REG_INFO(3, 8, 2, 6, (0x1 << 11)),
+	.table = sdh_pptbl,
+	.table_size = ARRAY_SIZE(sdh_pptbl),
+};
+
+static struct asr_param_mux_clk apbc_mux_clks[] __initdata = {
+	{ASR_CLK_MUX_TIMER0,	"timer0_mux",	timer_parent,	ARRAY_SIZE(timer_parent),	CLK_SET_RATE_PARENT,	APBC_TIMERS,	4, 3, 0, &timer0_lock},
+	{ASR_CLK_MUX_UART0,	"uart0_mux",	uart_parent,	ARRAY_SIZE(uart_parent),	CLK_SET_RATE_PARENT,	APBC_UART0,	4, 3, 0, &uart0_lock},
+	{ASR_CLK_MUX_UART1,	"uart1_mux",	uart_parent,	ARRAY_SIZE(uart_parent),	CLK_SET_RATE_PARENT,	APBC_UART1,	4, 3, 0, &uart1_lock},
+	{ASR_CLK_MUX_UART2,	"uart2_mux",	uart_parent,	ARRAY_SIZE(uart_parent),	CLK_SET_RATE_PARENT,	APBC_UART2,	4, 3, 0, &uart2_lock},
+	{ASR_CLK_MUX_SSP0,	"ssp0_mux",	ssp_parent,	ARRAY_SIZE(ssp_parent),		CLK_SET_RATE_PARENT,	APBC_SSP0,	7, 3, 0, NULL},
+	{ASR_CLK_MUX_SSP2,	"ssp2_mux",	ssp_parent,	ARRAY_SIZE(ssp_parent),		CLK_SET_RATE_PARENT,	APBC_SSP2,	7, 3, 0, NULL},
+};
+
+static struct asr_param_mux_clk apmu_mux_clks[] __initdata = {
+	{ASR_CLK_MUX_AES,	"aes_mux",	aes_parent,	ARRAY_SIZE(aes_parent),		CLK_SET_RATE_PARENT,	APMU_AES,	6, 1, 0, NULL},
+};
+
+static struct asr_param_fixed_rate_clk fixed_rate_clks[] = {
+	{ASR_CLK_CLK32,		"clk32",		NULL,	0,	32768},
+	{ASR_CLK_VCTCXO,	"vctcxo",		NULL,	0,	26000000},
+	{ASR_CLK_VCTCXO_3P25M,	"vctcxo_3p25",		NULL,	0,	3250000},
+	{ASR_CLK_VCTCXO_1M,	"vctcxo_1",		NULL,	0,	1000000},
+	{ASR_CLK_PLL1_VCO,	"pll1_2496_vco",	NULL,	0,	2496000000},
+};
+
+/* general gate clk controlled by APB_SPARE based registers */
+static struct asr_param_general_gate_clk general_gate_clks[] __initdata = {
+	{ASR_CLK_PLL1_D1_2496,	"pll1_d1_2496",	"pll1_d1_2496_vco",	APB_SPARE_PLL1CR, 26, 0, &pll1_lock, 0},
+	{ASR_CLK_PLL1_D2_1248,	"pll1_d2_1248",	"pll1_d2_1248_vco",	APB_SPARE_PLL1CR, 27, 0, &pll1_lock, 0},
+	{ASR_CLK_PLL1_D3_832,	"pll1_d3_832",	"pll1_d3_832_vco",	APB_SPARE_PLL1CR, 28, 0, &pll1_lock, 0},
+	{ASR_CLK_PLL1_D4_624,	"pll1_d4_624",	"pll1_d4_624_vco",	APB_SPARE_PLL1CR, 29, 0, &pll1_lock, 0},
+	{ASR_CLK_PLL1_D5_499,	"pll1_d5_499",	"pll1_d5_499_vco",	APB_SPARE_PLL1CR, 30, 0, &pll1_lock, 0},
+
+	{ASR_CLK_PLL2_D1,	"pll2_d1",	"pll2_d1_vco",		APB_SPARE_PLL2CR, 26, 0, &pll2_lock},
+	{ASR_CLK_PLL2_D2,	"pll2_d2",	"pll2_d2_vco",		APB_SPARE_PLL2CR, 27, 0, &pll2_lock},
+	{ASR_CLK_PLL2_D3,	"pll2_d3",	"pll2_d3_vco",		APB_SPARE_PLL2CR, 28, 0, &pll2_lock},
+	{ASR_CLK_PLL2_D4,	"pll2_d4",	"pll2_d4_vco",		APB_SPARE_PLL2CR, 29, 0, &pll2_lock},
+	{ASR_CLK_PLL2_D5,	"pll2_d5",	"pll2_d5_vco",		APB_SPARE_PLL2CR, 30, 0, &pll2_lock},
+
+	{ASR_CLK_PLL3_D1,	"pll3_d1",	"pll3_d1_vco",		APB_SPARE_PLL3CR, 26, 0, &pll3_lock, CLK_SET_RATE_PARENT},
+	{ASR_CLK_PLL3_D2,	"pll3_d2",	"pll3_d2_vco",		APB_SPARE_PLL3CR, 27, 0, &pll3_lock, 0},
+	{ASR_CLK_PLL3_D3,	"pll3_d3",	"pll3_d3_vco",		APB_SPARE_PLL3CR, 28, 0, &pll3_lock, 0},
+	{ASR_CLK_PLL3_D4,	"pll3_d4",	"pll3_d4_vco",		APB_SPARE_PLL3CR, 29, 0, &pll3_lock, 0},
+	{ASR_CLK_PLL3_D5,	"pll3_d5",	"pll3_d5_vco",		APB_SPARE_PLL3CR, 30, 0, &pll3_lock, 0},
+	{ASR_CLK_PLL4_D1,	"pll4_d1",	"pll4_d1_vco",		APB_SPARE_PLL4CR, 26, 0, &pll4_lock, CLK_SET_RATE_PARENT},
+	{ASR_CLK_PLL4_D2,	"pll4_d2",	"pll4_d2_vco",		APB_SPARE_PLL4CR, 27, 0, &pll4_lock, 0},
+	{ASR_CLK_PLL4_D3,	"pll4_d3",	"pll4_d3_vco",		APB_SPARE_PLL4CR, 28, 0, &pll4_lock, 0},
+	{ASR_CLK_PLL4_D4,	"pll4_d4",	"pll4_d4_vco",		APB_SPARE_PLL4CR, 29, 0, &pll4_lock, 0},
+	{ASR_CLK_PLL4_D5,	"pll4_d5",	"pll4_d5_vco",		APB_SPARE_PLL4CR, 30, 0, &pll4_lock, 0},
+
+	{ASR_CLK_PLL5_D1,	"pll5_d1",	"pll5_d1_vco",		APB_SPARE_PLL5CR, 26, 0, &pll5_lock, CLK_SET_RATE_PARENT},
+	{ASR_CLK_PLL5_D2,	"pll5_d2",	"pll5_d2_vco",		APB_SPARE_PLL5CR, 27, 0, &pll5_lock},
+	{ASR_CLK_PLL5_D3,	"pll5_d3",	"pll5_d3_vco",		APB_SPARE_PLL5CR, 28, 0, &pll5_lock},
+	{ASR_CLK_PLL5_D4,	"pll5_d4",	"pll5_d4_vco",		APB_SPARE_PLL5CR, 29, 0, &pll5_lock},
+	{ASR_CLK_PLL5_D5,	"pll5_d5",	"pll5_d5_vco",		APB_SPARE_PLL5CR, 30, 0, &pll5_lock},
+
+	{ASR_CLK_PLL6_D1,	"pll6_d1",	"pll6_d1_vco",		APB_SPARE_PLL6CR, 26, 0, &pll6_lock},
+	{ASR_CLK_PLL6_D2,	"pll6_d2",	"pll6_d2_vco",		APB_SPARE_PLL6CR, 27, 0, &pll6_lock},
+	{ASR_CLK_PLL6_D3,	"pll6_d3",	"pll6_d3_vco",		APB_SPARE_PLL6CR, 28, 0, &pll6_lock},
+	{ASR_CLK_PLL6_D4,	"pll6_d4",	"pll6_d4_vco",		APB_SPARE_PLL6CR, 29, 0, &pll6_lock},
+	{ASR_CLK_PLL6_D5,	"pll6_d5",	"pll6_d5_vco",		APB_SPARE_PLL6CR, 30, 0, &pll6_lock},
+
+	{ASR_CLK_PLL7_D1,	"pll7_d1",	"pll7_d1_vco",		APB_SPARE_PLL7CR, 26, 0, &pll7_lock},
+	{ASR_CLK_PLL7_D2,	"pll7_d2",	"pll7_d2_vco",		APB_SPARE_PLL7CR, 27, 0, &pll7_lock},
+	{ASR_CLK_PLL7_D3,	"pll7_d3",	"pll7_d3_vco",		APB_SPARE_PLL7CR, 28, 0, &pll7_lock},
+	{ASR_CLK_PLL7_D4,	"pll7_d4",	"pll7_d4_vco",		APB_SPARE_PLL7CR, 29, 0, &pll7_lock},
+	{ASR_CLK_PLL7_D5,	"pll7_d5",	"pll7_d5_vco",		APB_SPARE_PLL7CR, 30, 0, &pll7_lock},
+};
+
+/* general gate clk controlld by MPMU_ACGR based registers */
+static struct asr_param_general_gate_clk general_gate_clks_2[] __initdata = {
+	{ASR_CLK_PLL1_499,	"pll1_499",	"pll1_d5_499",		MPMU_ACGR, 21,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_13_WDT,	"pll1_13_wdt",	"pll1_d192_13",		MPMU_ACGR, 19,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_249,	"pll1_249",	"pll1_d10_249",		MPMU_ACGR, 18,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_1248,	"pll1_1248",	"pll1_d2_1248",		MPMU_ACGR, 16,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_624,	"pll1_624",	"pll1_d4_624",		MPMU_ACGR, 15,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_832,	"pll1_832",	"pll1_d3_832",		MPMU_ACGR, 14,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_312,	"pll1_312",	"pll1_d8_312",		MPMU_ACGR, 13,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_104,	"pll1_104",	"pll1_d24_104",		MPMU_ACGR, 12,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_52,	"pll1_52",	"pll1_d48_52",		MPMU_ACGR, 11,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_48,	"pll1_48",	"pll1_d52_48",		MPMU_ACGR, 10,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_58P5,	"pll1_58p5",	"pll1_m3d128_58p5",	MPMU_ACGR, 8,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_52_2,	"pll1_52_2",	"pll1_d48_52",		MPMU_ACGR, 7,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_32,	"pll1_32",	"pll1_d78_32",		MPMU_ACGR, 6,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_208,	"pll1_208",	"pll1_d12_208",		MPMU_ACGR, 5,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_26,	"pll1_26",	"pll1_d96_26",		MPMU_ACGR, 4,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_13,	"pll1_13",	"pll1_d192_13",		MPMU_ACGR, 3,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_6P5,	"pll1_6p5",	"pll1_d384_6p5",	MPMU_ACGR, 2,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_78_UART,	"pll1_uart",	"pll1_d32_78",		MPMU_ACGR, 1,	0, &pll1_lock_2, 0},
+	{ASR_CLK_PLL1_416,	"pll1_416",	"pll1_d6_416",		MPMU_ACGR, 0,	0, &pll1_lock_2, 0},
+};
+
+/* gate clk: enable/disable/reset bits are different, APB based. */
+static struct asr_param_gate_clk apbc_gate_clks[] __initdata = {
+	{ASR_CLK_TWSI0,		"twsi0_clk",	"pll1_32",	CLK_SET_RATE_PARENT,	APBC_TWSI0,	0x7,	0x3,	0x0, 0,				NULL},
+	{ASR_CLK_GPIO,		"gpio_clk",	"vctcxo",	CLK_SET_RATE_PARENT,	APBC_GPIO,	0x7,	0x3,	0x0, 0,				NULL},
+	{ASR_CLK_IPC,		"ipc_clk",	NULL,		0,			APBC_IPC,	0x7,	0x3,	0x0, 0,				NULL},
+	{ASR_CLK_TIMER0,	"timer0_clk",	"timer0_mux",	CLK_SET_RATE_PARENT,	APBC_TIMERS,	0x7,	0x3,	0x0, 0,				&timer0_lock},
+	{ASR_CLK_AIB,		"aib_clk",	"vctcxo",	CLK_SET_RATE_PARENT,	APBC_AIB,	0x7,	0x3,	0x0, 0,				NULL},
+	{ASR_CLK_UART0,		"uart0_clk",	"uart0_mux",	CLK_SET_RATE_PARENT,	APBC_UART0,	0x7,	0x3,	0x0, 0,				&uart0_lock},
+	{ASR_CLK_UART1,		"uart1_clk",	"uart1_mux",	CLK_SET_RATE_PARENT,	APBC_UART1,	0x7,	0x3,	0x0, 0,				&uart1_lock},
+	{ASR_CLK_UART2,		"uart2_clk",	"uart2_mux",	CLK_SET_RATE_PARENT,	APBC_UART2,	0x7,	0x3,	0x0, 0,				&uart2_lock},
+	{ASR_CLK_KPC,		"kpc_clk",	"clk32",	CLK_SET_RATE_PARENT,	APBC_KPC,	0x7,	0x3,	0x0, ASR_CLK_GATE_NEED_DELAY,	NULL},
+	{ASR_CLK_RTC,		"rtc_clk",	"clk32",	CLK_SET_RATE_PARENT,	APBC_RTC,	0x87,	0x83,	0x0, ASR_CLK_GATE_NEED_DELAY,	NULL},
+	{ASR_CLK_TWSI1,		"twsi1_clk",	"pll1_32",	CLK_SET_RATE_PARENT,	APBC_TWSI1,	0x7,	0x3,	0x0, 0,				NULL},
+	{ASR_CLK_THERMAL,	"thermal_clk",	NULL,		0,			APBC_THERMAL,	0x7,	0x3,	0x0, 0,				NULL},
+	{ASR_CLK_TWSI4,		"twsi4_clk",	"pll1_32",	CLK_SET_RATE_PARENT,	APBC_TWSI4,	0x7,	0x3,	0x0, 0,				NULL},
+	{ASR_CLK_TWSI5,		"twsi5_clk",	"pll1_32",	CLK_SET_RATE_PARENT,	APBC_TWSI5,	0x7,	0x3,	0x0, 0,				NULL},
+	{ASR_CLK_TWSI6,		"twsi6_clk",	"pll1_32",	CLK_SET_RATE_PARENT,	APBC_TWSI6,	0x7,	0x3,	0x0, 0,				NULL},
+	{ASR_CLK_TWSI7,		"twsi7_clk",	"pll1_32",	CLK_SET_RATE_PARENT,	APBC_TWSI7,	0x7,	0x3,	0x0, 0,				NULL},
+	{ASR_CLK_TWSI8,		"twsi8_clk",	"pll1_32",	CLK_SET_RATE_PARENT,	APBC_TWSI8,	0x7,	0x3,	0x0, 0,				NULL},
+};
+
+/* gate clk: enable/disable/reset bits are different, APMU based. */
+static struct asr_param_gate_clk apmu_gate_clks[] __initdata = {
+	{ASR_CLK_DMA,		"dma_clk",	NULL,		0,	APMU_DMA,	0x9,	0x9,	0x0, 0,	NULL},
+	{ASR_CLK_USB,		"usb_clk",	NULL,		0,	APMU_USB,	0x3,	0x3,	0x0, 0,	NULL},
+	{ASR_CLK_SDH_AXI,	"sdh_axi_clk",	NULL,		0,	APMU_SDH0,	0x9,	0x9,	0x0, 0,	NULL},
+	{ASR_CLK_SDH0,		"sdh0_clk",	"sdh0_mix_clk",	0,	APMU_SDH0,	0x12,	0x12,	0x0, 0,	 &sdh0_lock},
+	{ASR_CLK_SDH1,		"sdh1_clk",	"sdh0_mix_clk",	0,	APMU_SDH1,	0x12,	0x12,	0x0, 0,	 &sdh1_lock},
+	{ASR_CLK_SDH2,		"sdh2_clk",	"sdh0_mix_clk",	0,	APMU_SDH2,	0x12,	0x12,	0x0, 0,	 &sdh2_lock},
+	{ASR_CLK_AES,		"aes_clk",	"aes_mux",	0,	APMU_AES,	0x30,	0x30,	0x0, 0,	NULL},
+};
+
+/* gate clk: enable/disable/reset bits are different, MPMU based. */
+static struct asr_param_gate_clk mpmu_gate_clks[] __initdata = {
+	{ASR_CLK_WDT,	"wdt_clk",	"pll1_26",	0,	MPMU_WDTPCR,	0x7,	0x3,	0x4, 0,	NULL},
+};
+
+/* fixed factor clk */
+static struct asr_param_fixed_factor_clk fixed_factor_clks[] __initdata = {
+	{ASR_CLK_PLL1_D1_2496_VCO,	"pll1_d1_2496_vco",	"pll1_2496_vco",	1, 1, 0},
+	{ASR_CLK_PLL1_D2_1248_VCO,	"pll1_d2_1248_vco",	"pll1_2496_vco",	1, 2, 0},
+	{ASR_CLK_PLL1_D3_832_VCO,	"pll1_d3_832_vco",	"pll1_2496_vco",	1, 3, 0},
+	{ASR_CLK_PLL1_D4_624_VCO,	"pll1_d4_624_vco",	"pll1_2496_vco",	1, 4, 0},
+	{ASR_CLK_PLL1_D5_499_VCO,	"pll1_d5_499_vco",	"pll1_2496_vco",	1, 5, 0},
+	{ASR_CLK_PLL1_D6_416,		"pll1_d6_416",		"pll1_d3_832",		1, 2, 0},
+	{ASR_CLK_PLL1_D8_312,		"pll1_d8_312",		"pll1_d4_624",		1, 2, 0},
+	{ASR_CLK_PLL1_D10_249,		"pll1_d10_249",		"pll1_d5_499",		1, 2, 0},
+	{ASR_CLK_PLL1_D12_208,		"pll1_d12_208",		"pll1_d3_832",		1, 4, 0},
+	{ASR_CLK_PLL1_D24_104,		"pll1_d24_104",		"pll1_d4_624",		1, 6, 0},
+	{ASR_CLK_PLL1_D32_78,		"pll1_d32_78",		"pll1_d4_624",		1, 8, 0},
+	{ASR_CLK_PLL1_D32_78_2,		"pll1_78",		"pll1_312",		1, 4, 0},
+	{ASR_CLK_PLL1_D48_52,		"pll1_d48_52",		"pll1_d4_624",		1, 12, 0},
+	{ASR_CLK_PLL1_D52_48,		"pll1_d52_48",		"pll1_d4_624",		1, 13, 0},
+	{ASR_CLK_PLL1_M3D128_58P5,	"pll1_m3d128_58p5",	"pll1_d4_624",		3, 32, 0},
+	{ASR_CLK_PLL1_D78_32,		"pll1_d78_32",		"pll1_d4_624",		2, 39, 0},
+	{ASR_CLK_PLL1_D96_26,		"pll1_d96_26",		"pll1_d4_624",		1, 24, 0},
+	{ASR_CLK_PLL1_D192_13,		"pll1_d192_13",		"pll1_d4_624",		1, 48, 0},
+	{ASR_CLK_PLL1_D384_6P5,		"pll1_d384_6p5",	"pll1_d4_624",		1, 96, 0},
+
+	{ASR_CLK_PLL2_D1_VCO,		"pll2_d1_vco",		"pll2_vco",		1, 1, 0},
+	{ASR_CLK_PLL2_D2_VCO,		"pll2_d2_vco",		"pll2_vco",		1, 2, 0},
+	{ASR_CLK_PLL2_D3_VCO,		"pll2_d3_vco",		"pll2_vco",		1, 3, 0},
+	{ASR_CLK_PLL2_D4_VCO,		"pll2_d4_vco",		"pll2_vco",		1, 4, 0},
+	{ASR_CLK_PLL2_D5_VCO,		"pll2_d5_vco",		"pll2_vco",		1, 5, 0},
+
+	{ASR_CLK_PLL3_D1_VCO,		"pll3_d1_vco",		"pll3_vco",		1, 1, CLK_SET_RATE_PARENT},
+	{ASR_CLK_PLL3_D2_VCO,		"pll3_d2_vco",		"pll3_vco",		1, 2, 0},
+	{ASR_CLK_PLL3_D3_VCO,		"pll3_d3_vco",		"pll3_vco",		1, 3, 0},
+	{ASR_CLK_PLL3_D4_VCO,		"pll3_d4_vco",		"pll3_vco",		1, 4, 0},
+	{ASR_CLK_PLL3_D5_VCO,		"pll3_d5_vco",		"pll3_vco",		1, 5, 0},
+
+	{ASR_CLK_PLL4_D1_VCO,		"pll4_d1_vco",		"pll4_vco",		1, 1, CLK_SET_RATE_PARENT},
+	{ASR_CLK_PLL4_D2_VCO,		"pll4_d2_vco",		"pll4_vco",		1, 2, 0},
+	{ASR_CLK_PLL4_D3_VCO,		"pll4_d3_vco",		"pll4_vco",		1, 3, 0},
+	{ASR_CLK_PLL4_D4_VCO,		"pll4_d4_vco",		"pll4_vco",		1, 4, 0},
+	{ASR_CLK_PLL4_D5_VCO,		"pll4_d5_vco",		"pll4_vco",		1, 5, 0},
+
+	{ASR_CLK_PLL5_D1_VCO,		"pll5_d1_vco",		"pll5_vco",		1, 1, CLK_SET_RATE_PARENT},
+	{ASR_CLK_PLL5_D2_VCO,		"pll5_d2_vco",		"pll5_vco",		1, 2, 0},
+	{ASR_CLK_PLL5_D3_VCO,		"pll5_d3_vco",		"pll5_vco",		1, 3, 0},
+	{ASR_CLK_PLL5_D4_VCO,		"pll5_d4_vco",		"pll5_vco",		1, 4, 0},
+	{ASR_CLK_PLL5_D5_VCO,		"pll5_d5_vco",		"pll5_vco",		1, 5, 0},
+
+	{ASR_CLK_PLL6_D1_VCO,		"pll6_d1_vco",		"pll6_vco",		1, 1, 0},
+	{ASR_CLK_PLL6_D2_VCO,		"pll6_d2_vco",		"pll6_vco",		1, 2, 0},
+	{ASR_CLK_PLL6_D3_VCO,		"pll6_d3_vco",		"pll6_vco",		1, 3, 0},
+	{ASR_CLK_PLL6_D4_VCO,		"pll6_d4_vco",		"pll6_vco",		1, 4, 0},
+	{ASR_CLK_PLL6_D5_VCO,		"pll6_d5_vco",		"pll6_vco",		1, 5, 0},
+
+	{ASR_CLK_PLL7_D1_VCO,		"pll7_d1_vco",		"pll7_vco",		1, 1, 0},
+	{ASR_CLK_PLL7_D2_VCO,		"pll7_d2_vco",		"pll7_vco",		1, 2, 0},
+	{ASR_CLK_PLL7_D3_VCO,		"pll7_d3_vco",		"pll7_vco",		1, 3, 0},
+	{ASR_CLK_PLL7_D4_VCO,		"pll7_d4_vco",		"pll7_vco",		1, 4, 0},
+	{ASR_CLK_PLL7_D5_VCO,		"pll7_d5_vco",		"pll7_vco",		1, 5, 0},
+};
+
+static void __init aquilac_general_clk_init(struct asr_clk_data *clock_data)
+{
+	struct clk *clk;
+	struct asr_clk_unit *unit = &clock_data->unit;
+
+	asr_register_fixed_rate_clks(unit, fixed_rate_clks,
+		ARRAY_SIZE(fixed_rate_clks));
+
+	clk = clk_register_fractional_divider(NULL, "uart_pll", "pll1_uart",
+		CLK_SET_RATE_PARENT,
+		clock_data->mpmu_base + MPMU_UART_PLL,
+		0, 13, 16, 13, 0, NULL);
+	asr_clk_add(unit, ASR_CLK_PLL1_78_UART, clk);
+
+	asr_register_general_gate_clks(unit, general_gate_clks,
+		clock_data->apbs_base, ARRAY_SIZE(general_gate_clks));
+
+	asr_register_general_gate_clks(unit, general_gate_clks_2,
+		clock_data->mpmu_base, ARRAY_SIZE(general_gate_clks_2));
+
+	asr_register_fixed_factor_clks(unit, fixed_factor_clks,
+		ARRAY_SIZE(fixed_factor_clks));
+}
+
+static void __init aquilac_pll_init(struct asr_clk_data *clock_data)
+{
+	struct clk *clk;
+	struct asr_clk_unit *unit = &clock_data->unit;
+	int idx;
+
+	for (idx = 0; idx < MAX_PLL_NUM; idx++) {
+		spin_lock_init(&pllx_platinfo[idx].lock);
+
+		pllx_vco_params[idx].pll_swcr = clock_data->apbs_base + pllx_vco_params[idx].swcr_off;
+		/* pll6/7 have different base of some regs */
+		if (idx < PLL6) {
+			pllx_vco_params[idx].cr_reg = clock_data->mpmu_base + pllx_vco_params[idx].cr_off;
+			pllx_vco_params[idx].lock_reg = clock_data->mpmu_base + pllx_vco_params[idx].lock_off;
+		} else {
+			pllx_vco_params[idx].pll_swcr2 = clock_data->apbs_base + pllx_vco_params[idx].swcr2_off;
+			pllx_vco_params[idx].lock_reg = clock_data->apbs_base + pllx_vco_params[idx].lock_off;
+		}
+
+		pllx_vco_params[idx].default_rate = pll_rates[idx];
+
+		clk = asr_clk_register_vco(pllx_platinfo[idx].vco_name,
+			0, pllx_platinfo[idx].vcoclk_flag, pllx_platinfo[idx].vco_flag,
+			&pllx_platinfo[idx].lock, &pllx_vco_params[idx]);
+		if (!__clk_is_enabled(clk))
+			clk_set_rate(clk, pllx_vco_params[idx].default_rate);
+		asr_clk_add(unit, pllx_platinfo[idx].vcodtidx, clk);
+	}
+}
+static void __init aquilac_periph_clk_init(struct asr_clk_data *clock_data)
+{
+	struct asr_clk_unit *unit = &clock_data->unit;
+
+	asr_register_mux_clks(unit, apbc_mux_clks, clock_data->apbc_base,
+		ARRAY_SIZE(apbc_mux_clks));
+
+	asr_register_mux_clks(unit, apmu_mux_clks, clock_data->apmu_base,
+		ARRAY_SIZE(apmu_mux_clks));
+
+	asr_register_gate_clks(unit, apbc_gate_clks, clock_data->apbc_base,
+		ARRAY_SIZE(apbc_gate_clks));
+
+	asr_register_gate_clks(unit, apmu_gate_clks, clock_data->apmu_base,
+		ARRAY_SIZE(apmu_gate_clks));
+
+	asr_register_gate_clks(unit, mpmu_gate_clks, clock_data->mpmu_base,
+		ARRAY_SIZE(mpmu_gate_clks));
+}
+
+static void __init aquilac_mix_clk_init(struct asr_clk_data *clock_data)
+{
+	sdh_mix_config.reg_info.reg_clk_ctrl = clock_data->apmu_base + APMU_SDH0;
+	asr_clk_register_mix(NULL, "sdh0_mix_clk",
+		(const char **)sdh_parent_names, ARRAY_SIZE(sdh_parent_names),
+		CLK_SET_RATE_PARENT,
+		&sdh_mix_config, &sdh0_lock);
+
+	sdh_mix_config.reg_info.reg_clk_ctrl = clock_data->apmu_base + APMU_SDH1;
+	asr_clk_register_mix(NULL, "sdh1_mix_clk",
+		(const char **)sdh_parent_names, ARRAY_SIZE(sdh_parent_names),
+		CLK_SET_RATE_PARENT,
+		&sdh_mix_config, &sdh1_lock);
+
+	sdh_mix_config.reg_info.reg_clk_ctrl = clock_data->apmu_base + APMU_SDH2;
+	asr_clk_register_mix(NULL, "sdh2_mix_clk",
+		(const char **)sdh_parent_names, ARRAY_SIZE(sdh_parent_names),
+		CLK_SET_RATE_PARENT,
+		&sdh_mix_config, &sdh2_lock);
+}
+
+static int __init aquilac_clk_of_iomap(struct device_node *np, struct asr_clk_data *acu)
+{
+	acu->mpmu_base = of_iomap(np, 0);
+	if (!acu->mpmu_base) {
+		pr_err("failed to map mpmu registers\n");
+		goto out;
+	}
+
+	acu->apmu_base = of_iomap(np, 1);
+	if (!acu->apmu_base) {
+		pr_err("failed to map apmu registers\n");
+		goto out;
+	}
+
+	acu->apbc_base = of_iomap(np, 2);
+	if (!acu->apbc_base) {
+		pr_err("failed to map apbc registers\n");
+		goto out;
+	}
+
+	acu->apbs_base = of_iomap(np, 3);
+	if (!acu->apbs_base) {
+		pr_err("failed to map apbs registers\n");
+		goto out;
+	}
+
+	acu->ciu_base = of_iomap(np, 4);
+	if (!acu->ciu_base) {
+		pr_err("failed to map ciu registers\n");
+		goto out;
+	}
+
+	acu->dciu_base = of_iomap(np, 5);
+	if (!acu->dciu_base) {
+		pr_err("failed to map dragon ciu registers\n");
+		goto out;
+	}
+
+	acu->ddrc_base = of_iomap(np, 6);
+	if (!acu->ddrc_base) {
+		pr_err("failed to map ddrc registers\n");
+		goto out;
+	}
+
+	return 0;
+out:
+	return -EINVAL;
+}
+
+static void __init aquilac_clk_init(struct device_node *np)
+{
+	int ret;
+	struct asr_clk_data *clock_data;
+
+	clock_data = kzalloc(sizeof(*clock_data), GFP_KERNEL);
+	if (!clock_data)
+		return;
+
+	ret = aquilac_clk_of_iomap(np, clock_data);
+	if (ret < 0)
+		goto out;
+
+	ret = asr_clk_init(np, &clock_data->unit, ASR_NR_CLKS);
+	if (ret < 0)
+		goto out;
+
+	aquilac_general_clk_init(clock_data);
+
+	aquilac_pll_init(clock_data);
+
+	aquilac_mix_clk_init(clock_data);
+
+	aquilac_periph_clk_init(clock_data);
+
+	asr_clks_enable((const char **)keep_on_clocks_tbl, ARRAY_SIZE(keep_on_clocks_tbl));
+
+	return;
+out:
+	kfree(clock_data);
+}
+CLK_OF_DECLARE(aquilac_clk, "asr,8751c-clock", aquilac_clk_init);
diff --git a/drivers/clk/asr/clk-gate.c b/drivers/clk/asr/clk-gate.c
new file mode 100644
index 0000000..4ba5587
--- /dev/null
+++ b/drivers/clk/asr/clk-gate.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * asr gate clock operation source file
+ *
+ * Copyright (C) 2019 ASR Microelectronics(Shanghai) Co., Ltd.
+ * Gang Wu <gangwu@asrmicro.com>
+ * Qiao Zhou <qiaozhou@asrmicro.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include "clk.h"
+
+#define to_clk_asr_gate(hw)	container_of(hw, struct asr_clk_gate, hw)
+
+#define TIMEOUT_LIMIT		20000
+#define DELAY_CYCLE		2000000
+
+static int asr_clk_gate_enable(struct clk_hw *hw)
+{
+	struct asr_clk_gate *gate = to_clk_asr_gate(hw);
+	unsigned long flags = 0;
+	unsigned long rate;
+	u32 tmp;
+	u32 val = 0;
+	int timeout_power = 1;
+
+	if (gate->lock)
+		spin_lock_irqsave(gate->lock, flags);
+
+	tmp = clk_readl(gate->reg);
+	tmp &= ~gate->mask;
+	tmp |= gate->val_enable;
+	clk_writel(tmp, gate->reg);
+
+	val = clk_readl(gate->reg);
+	while ((val & gate->mask) != gate->val_enable && (timeout_power < TIMEOUT_LIMIT)) {
+		udelay(timeout_power);
+		val = clk_readl(gate->reg);
+		timeout_power *= 10;
+	}
+
+	if (timeout_power > 1) {
+		if (val == tmp)
+			pr_err("write clk_gate %s timeout occur, read pass after %d us delay\n", clk_hw_get_name(hw), timeout_power);
+		else
+			panic("write clk_gate %s timeout after %d us!\n", clk_hw_get_name(hw), timeout_power);
+	}
+
+	if (gate->lock)
+		spin_unlock_irqrestore(gate->lock, flags);
+
+	if (gate->flags & ASR_CLK_GATE_NEED_DELAY) {
+		rate = clk_hw_get_rate(hw);
+		udelay(DIV_ROUND_UP(DELAY_CYCLE, rate));
+	}
+
+	return 0;
+}
+
+static void asr_clk_gate_disable(struct clk_hw *hw)
+{
+	struct asr_clk_gate *gate = to_clk_asr_gate(hw);
+	unsigned long flags = 0;
+	unsigned long rate;
+	u32 tmp;
+
+	if (gate->lock)
+		spin_lock_irqsave(gate->lock, flags);
+
+	tmp = clk_readl(gate->reg);
+	tmp &= ~gate->mask;
+	tmp |= gate->val_disable;
+	clk_writel(tmp, gate->reg);
+
+	if (gate->flags & ASR_CLK_GATE_NEED_DELAY) {
+		rate = clk_hw_get_rate(hw);
+		udelay(DIV_ROUND_UP(DELAY_CYCLE, rate));
+	}
+
+	if (gate->lock)
+		spin_unlock_irqrestore(gate->lock, flags);
+}
+
+static int asr_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct asr_clk_gate *gate = to_clk_asr_gate(hw);
+	unsigned long flags = 0;
+	u32 tmp;
+
+	if (gate->lock)
+		spin_lock_irqsave(gate->lock, flags);
+
+	tmp = clk_readl(gate->reg);
+
+	if (gate->lock)
+		spin_unlock_irqrestore(gate->lock, flags);
+
+	return (tmp & gate->mask) == gate->val_enable;
+}
+
+const struct clk_ops asr_clk_gate_ops = {
+	.enable = asr_clk_gate_enable,
+	.disable = asr_clk_gate_disable,
+	.is_enabled = asr_clk_gate_is_enabled,
+};
+
+struct clk *asr_clk_register_gate(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u32 mask, u32 val_enable, u32 val_disable,
+		unsigned long gate_flags, spinlock_t *lock)
+{
+	struct asr_clk_gate *gate;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* allocate the gate */
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &asr_clk_gate_ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	/* struct clk_gate assignments */
+	gate->reg = reg;
+	gate->mask = mask;
+	gate->val_enable = val_enable;
+	gate->val_disable = val_disable;
+	gate->flags = gate_flags;
+	gate->lock = lock;
+	gate->hw.init = &init;
+
+	clk = clk_register(dev, &gate->hw);
+
+	if (IS_ERR(clk))
+		kfree(gate);
+
+	return clk;
+}
diff --git a/drivers/clk/asr/clk-mix.c b/drivers/clk/asr/clk-mix.c
new file mode 100644
index 0000000..d099a41
--- /dev/null
+++ b/drivers/clk/asr/clk-mix.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * asr mix(div and mux) driver for asr-8751c
+ *
+ * Copyright (C) 2019 ASR Microelectronics(Shanghai) Co., Ltd.
+ * Gang Wu <gangwu@asrmicro.com>
+ * Qiao Zhou <qiaozhou@asrmicro.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include "clk.h"
+
+/*
+ * mux and div field can't be configured separately in two clocks.
+ */
+
+#define to_clk_mix(hw)	container_of(hw, struct asr_clk_mix, hw)
+
+static unsigned int _get_maxdiv(struct asr_clk_mix *mix)
+{
+	unsigned int div_mask = (1 << mix->reg_info.width_div) - 1;
+
+	if (mix->div_flags & CLK_DIVIDER_ONE_BASED)
+		return div_mask;
+	if (mix->div_flags & CLK_DIVIDER_POWER_OF_TWO)
+		return 1 << div_mask;
+
+	return div_mask + 1;
+}
+
+static unsigned int _get_div(struct asr_clk_mix *mix, unsigned int val)
+{
+
+	if (mix->div_flags & CLK_DIVIDER_ONE_BASED)
+		return val;
+	if (mix->div_flags & CLK_DIVIDER_POWER_OF_TWO)
+		return 1 << val;
+
+	return val + 1;
+}
+
+static unsigned int _get_div_val(struct asr_clk_mix *mix, unsigned int div)
+{
+	if (mix->div_flags & CLK_DIVIDER_ONE_BASED)
+		return div;
+	if (mix->div_flags & CLK_DIVIDER_POWER_OF_TWO)
+		return __ffs(div);
+
+	return div - 1;
+}
+
+static void _filter_clk_table(struct asr_clk_mix *mix,
+				struct asr_clk_mix_clk_table *table,
+				unsigned int table_size)
+{
+	int i;
+	struct asr_clk_mix_clk_table *item;
+	struct clk_hw *parent, *hw;
+	unsigned long parent_rate;
+
+	hw = &mix->hw;
+
+	for (i = 0; i < table_size; i++) {
+		item = &table[i];
+		parent = clk_hw_get_parent_by_index(hw, item->parent_index);
+		parent_rate = clk_hw_get_rate(parent);
+		if (parent_rate % item->rate) {
+			item->valid = 0;
+		} else {
+			item->divisor = parent_rate / item->rate;
+			item->valid = 1;
+		}
+	}
+}
+
+static int _set_rate(struct asr_clk_mix *mix, u32 mux_val, u32 div_val,
+			unsigned int change_mux, unsigned int change_div)
+{
+	struct asr_clk_mix_reg_info *ri = &mix->reg_info;
+	u8 width, shift;
+	u32 mux_div;
+	unsigned long flags = 0;
+
+	if (!change_mux && !change_div)
+		return -EINVAL;
+
+	if (mix->lock)
+		spin_lock_irqsave(mix->lock, flags);
+
+	mux_div = clk_readl(ri->reg_clk_ctrl);
+
+	if (change_div) {
+		width = ri->width_div;
+		shift = ri->shift_div;
+		mux_div &= ~ASR_CLK_BITS_MASK(width, shift);
+		mux_div |= ASR_CLK_BITS_SET_VAL(div_val, width, shift);
+	}
+
+	if (change_mux) {
+		width = ri->width_mux;
+		shift = ri->shift_mux;
+		mux_div &= ~ASR_CLK_BITS_MASK(width, shift);
+		mux_div |= ASR_CLK_BITS_SET_VAL(mux_val, width, shift);
+	}
+
+	clk_writel(mux_div, ri->reg_clk_ctrl);
+
+	if (mix->lock)
+		spin_unlock_irqrestore(mix->lock, flags);
+
+	return 0;
+}
+
+static int asr_clk_mix_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	struct asr_clk_mix *mix = to_clk_mix(hw);
+	struct asr_clk_mix_clk_table *item;
+	struct clk_hw *parent, *parent_best;
+	unsigned long parent_rate, mix_rate, mix_rate_best, parent_rate_best;
+	unsigned long gap, gap_best;
+	u32 div_val_max;
+	unsigned int div;
+	int i, j;
+
+	mix_rate_best = 0;
+	parent_rate_best = 0;
+	gap_best = ULONG_MAX;
+	parent_best = NULL;
+
+	if (mix->table) {
+		for (i = 0; i < mix->table_size; i++) {
+			item = &mix->table[i];
+			if (item->valid == 0)
+				continue;
+			parent = clk_hw_get_parent_by_index(hw,
+							item->parent_index);
+			parent_rate = clk_hw_get_rate(parent);
+			mix_rate = parent_rate / item->divisor;
+			gap = abs(mix_rate - req->rate);
+			if (parent_best == NULL || gap < gap_best) {
+				parent_best = parent;
+				parent_rate_best = parent_rate;
+				mix_rate_best = mix_rate;
+				gap_best = gap;
+				if (gap_best == 0)
+					goto found;
+			}
+		}
+	} else {
+		for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
+			parent = clk_hw_get_parent_by_index(hw, i);
+			parent_rate = clk_hw_get_rate(parent);
+			div_val_max = _get_maxdiv(mix);
+			for (j = 0; j < div_val_max; j++) {
+				div = _get_div(mix, j);
+				mix_rate = parent_rate / div;
+				gap = abs(mix_rate - req->rate);
+				if (parent_best == NULL || gap < gap_best) {
+					parent_best = parent;
+					parent_rate_best = parent_rate;
+					mix_rate_best = mix_rate;
+					gap_best = gap;
+					if (gap_best == 0)
+						goto found;
+				}
+			}
+		}
+	}
+
+found:
+	if (!parent_best)
+		return -EINVAL;
+
+	req->best_parent_rate = parent_rate_best;
+	req->best_parent_hw = parent_best;
+	req->rate = mix_rate_best;
+
+	return 0;
+}
+
+static int asr_clk_mix_set_rate_and_parent(struct clk_hw *hw,
+						unsigned long rate,
+						unsigned long parent_rate,
+						u8 index)
+{
+	struct asr_clk_mix *mix = to_clk_mix(hw);
+	unsigned int div;
+	u32 div_val;
+
+	div = parent_rate / rate;
+	div_val = _get_div_val(mix, div);
+
+	return _set_rate(mix, index, div_val, 1, 1);
+}
+
+static u8 asr_clk_mix_get_parent(struct clk_hw *hw)
+{
+	struct asr_clk_mix *mix = to_clk_mix(hw);
+	struct asr_clk_mix_reg_info *ri = &mix->reg_info;
+	unsigned long flags = 0;
+	u32 mux_div = 0;
+	u8 width, shift;
+	u32 mux_val;
+
+	if (mix->lock)
+		spin_lock_irqsave(mix->lock, flags);
+
+	mux_div = clk_readl(ri->reg_clk_ctrl);
+
+	if (mix->lock)
+		spin_unlock_irqrestore(mix->lock, flags);
+
+	width = mix->reg_info.width_mux;
+	shift = mix->reg_info.shift_mux;
+
+	mux_val = ASR_CLK_BITS_GET_VAL(mux_div, width, shift);
+
+	return mux_val;
+}
+
+static unsigned long asr_clk_mix_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct asr_clk_mix *mix = to_clk_mix(hw);
+	struct asr_clk_mix_reg_info *ri = &mix->reg_info;
+	unsigned long flags = 0;
+	u32 mux_div = 0;
+	u8 width, shift;
+	unsigned int div;
+
+	if (mix->lock)
+		spin_lock_irqsave(mix->lock, flags);
+
+	mux_div = clk_readl(ri->reg_clk_ctrl);
+
+	if (mix->lock)
+		spin_unlock_irqrestore(mix->lock, flags);
+
+	width = mix->reg_info.width_div;
+	shift = mix->reg_info.shift_div;
+
+	div = _get_div(mix, ASR_CLK_BITS_GET_VAL(mux_div, width, shift));
+
+	return parent_rate / div;
+}
+
+static int asr_clk_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct asr_clk_mix *mix = to_clk_mix(hw);
+	struct asr_clk_mix_clk_table *item;
+	int i;
+	u32 div_val, mux_val;
+
+	if (mix->table) {
+		for (i = 0; i < mix->table_size; i++) {
+			item = &mix->table[i];
+			if (item->valid == 0)
+				continue;
+			if (item->parent_index == index)
+				break;
+		}
+		if (i < mix->table_size) {
+			div_val = _get_div_val(mix, item->divisor);
+			mux_val = item->parent_index;
+		} else
+			return -EINVAL;
+	} else {
+		mux_val = index;
+		div_val = 0;
+	}
+
+	return _set_rate(mix, mux_val, div_val, 1, div_val ? 1 : 0);
+}
+
+static int asr_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long best_parent_rate)
+{
+	struct asr_clk_mix *mix = to_clk_mix(hw);
+	struct asr_clk_mix_clk_table *item;
+	unsigned long parent_rate;
+	unsigned int best_divisor;
+	struct clk_hw *parent;
+	int i;
+
+	best_divisor = best_parent_rate / rate;
+
+	if (mix->table) {
+		for (i = 0; i < mix->table_size; i++) {
+			item = &mix->table[i];
+			if (item->valid == 0)
+				continue;
+			parent = clk_hw_get_parent_by_index(hw,
+							item->parent_index);
+			parent_rate = clk_hw_get_rate(parent);
+			if (parent_rate == best_parent_rate
+				&& item->divisor == best_divisor)
+				break;
+		}
+		if (i < mix->table_size)
+			return _set_rate(mix, item->parent_index,
+					_get_div_val(mix, item->divisor),
+					1, 1);
+		else
+			return -EINVAL;
+	} else {
+		for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
+			parent = clk_hw_get_parent_by_index(hw, i);
+			parent_rate = clk_hw_get_rate(parent);
+			if (parent_rate == best_parent_rate)
+				break;
+		}
+		if (i < clk_hw_get_num_parents(hw))
+			return _set_rate(mix, i,
+					_get_div_val(mix, best_divisor), 1, 1);
+		else
+			return -EINVAL;
+	}
+}
+
+static void asr_clk_mix_init(struct clk_hw *hw)
+{
+	struct asr_clk_mix *mix = to_clk_mix(hw);
+
+	if (mix->table)
+		_filter_clk_table(mix, mix->table, mix->table_size);
+}
+
+const struct clk_ops asr_clk_mix_ops = {
+	.determine_rate = asr_clk_mix_determine_rate,
+	.set_rate_and_parent = asr_clk_mix_set_rate_and_parent,
+	.set_rate = asr_clk_set_rate,
+	.set_parent = asr_clk_set_parent,
+	.get_parent = asr_clk_mix_get_parent,
+	.recalc_rate = asr_clk_mix_recalc_rate,
+	.init = asr_clk_mix_init,
+};
+
+struct clk *asr_clk_register_mix(struct device *dev,
+					const char *name,
+					const char **parent_names,
+					u8 num_parents,
+					unsigned long flags,
+					struct asr_clk_mix_config *config,
+					spinlock_t *lock)
+{
+	struct asr_clk_mix *mix;
+	struct clk *clk;
+	struct clk_init_data init;
+	size_t table_bytes;
+
+	mix = kzalloc(sizeof(*mix), GFP_KERNEL);
+	if (!mix)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.flags = flags | CLK_GET_RATE_NOCACHE;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	init.ops = &asr_clk_mix_ops;
+
+	memcpy(&mix->reg_info, &config->reg_info, sizeof(config->reg_info));
+	if (config->table) {
+		table_bytes = sizeof(*config->table) * config->table_size;
+		mix->table = kmemdup(config->table,
+						table_bytes, GFP_KERNEL);
+		if (!mix->table) {
+			kfree(mix);
+			return ERR_PTR(-ENOMEM);
+		}
+		mix->table_size = config->table_size;
+	}
+
+	mix->lock = lock;
+	mix->hw.init = &init;
+
+	clk = clk_register(dev, &mix->hw);
+
+	if (IS_ERR(clk)) {
+		kfree(mix->table);
+		kfree(mix);
+	}
+
+	return clk;
+}
diff --git a/drivers/clk/asr/clk-pll.c b/drivers/clk/asr/clk-pll.c
new file mode 100644
index 0000000..2087fbb
--- /dev/null
+++ b/drivers/clk/asr/clk-pll.c
@@ -0,0 +1,642 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * clock pll driver file for asr-8751c
+ *
+ * Copyright (C) 2019 ASR Microelectronics(Shanghai) Co., Ltd.
+ * Kevin Liu <kevinliu@asrmicro.com>
+ * Qiao	Zhou <qiaozhou@asrmicro.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+#include "clk.h"
+#include "clk-pll.h"
+
+#define pll_readl_cr(p) clk_readl(p->params->cr_reg)
+#define pll_readl_pll_swcr(p) clk_readl(p->params->pll_swcr)
+#define pll_readl_pll_swcr2(p) clk_readl(p->params->pll_swcr2)
+#define pll_writel_cr(val, p) clk_writel(val, p->params->cr_reg)
+#define pll_writel_pll_swcr(val, p) clk_writel(val, p->params->pll_swcr)
+#define pll_writel_pll_swcr2(val, p) clk_writel(val, p->params->pll_swcr2)
+
+/* unified pllx_cr for pll2~5 */
+union pllx_cr {
+	struct {
+		unsigned int frcdiv:8;
+		unsigned int fbdiv:7;
+		unsigned int reserved:4;
+		unsigned int pu:1;
+		unsigned int reserved1:4;
+		unsigned int ssd:4;
+		unsigned int ssdx2:1;
+		unsigned int folock_en:1;
+		unsigned int ssmod:2;
+	} b;
+	unsigned int v;
+};
+
+/* unified pll SW control register for pll1~5 */
+union pllx_swcr {
+	struct {
+		unsigned int reserved:7;
+		unsigned int band_sel:1;
+		unsigned int pumpcur:2;
+		unsigned int falock_en:1;
+		unsigned int kvco:3;
+		unsigned int regvol:2;
+		unsigned int bypass:1;
+		unsigned int lockdly:3;
+		unsigned int folock_en:1;
+		unsigned int mod_sel:1;
+		unsigned int te_sel:2;
+		unsigned int at_en:1;
+		unsigned int dt_en:1;
+		unsigned int div1_en:1;
+		unsigned int div2_en:1;
+		unsigned int div3_en:1;
+		unsigned int div4_en:1;
+		unsigned int div5_en:1;
+		unsigned int clk_en:1;
+	} b;
+	unsigned int v;
+};
+
+/* pll SW control register for pll6/7 */
+union pllx_swcr_new {
+	struct {
+		unsigned int fbdiv:7;
+		unsigned int band_sel:1;
+		unsigned int pumpcur:2;
+		unsigned int falock_en:1;
+		unsigned int kvco:3;
+		unsigned int regvol:2;
+		unsigned int bypass:1;
+		unsigned int lockdly:3;
+		unsigned int folock_en:1;
+		unsigned int mod_sel:1;
+		unsigned int te_sel:2;
+		unsigned int at_en:1;
+		unsigned int dt_en:1;
+		unsigned int div1_en:1;
+		unsigned int div2_en:1;
+		unsigned int div3_en:1;
+		unsigned int div4_en:1;
+		unsigned int div5_en:1;
+		unsigned int pu:1;
+	} b;
+	unsigned int v;
+};
+
+/* pll SW control register2 for pll6 */
+union pllx_swcr2 {
+	struct {
+		unsigned int frcdiv:8;
+		unsigned int ssd:4;
+		unsigned int ssdx2:1;
+		unsigned int folock_en:1;
+		unsigned int ssmod:2;
+		unsigned int reserved:15;
+		unsigned int locked:1;
+	} b;
+	unsigned int v;
+};
+
+/* pll SW control register2 for pll7 */
+union pllx_swcr2_frac {
+	struct {
+		unsigned int frcdiv:24;
+		unsigned int reserved:7;
+		unsigned int locked:1;
+	} b;
+	unsigned int v;
+};
+
+static struct kvco_range kvco_rng_table[] = {
+	/* High band */
+	{2620, 2780, 0x7, 1},
+	{2470, 2620, 0x6, 1},
+	{2320, 2470, 0x5, 1},
+	{2140, 2320, 0x4, 1},
+	{1970, 2140, 0x3, 1},
+	{1820, 1970, 0x2, 1},
+	{1670, 1820, 0x1, 1},
+	{1510, 1670, 0x0, 1},
+	/* Low band - prefer high band */
+	{1600, 1760, 0x7, 0},
+	{1450, 1600, 0x6, 0},
+	{1300, 1450, 0x5, 0},
+	{1140, 1300, 0x4, 0},
+	{970, 1140, 0x3, 0},
+	{820, 970, 0x2, 0},
+	{680, 820, 0x1, 0},
+	{540, 680, 0x0, 0},
+};
+
+static int __pll_is_enabled(struct clk_hw *hw)
+{
+	struct clk_vco *vco = to_clk_vco(hw);
+	union pllx_cr pllx_cr;
+	union pllx_swcr_new pllx_swcr_new;
+	unsigned int enabled;
+
+	if (vco->flags & ASR_PLL_REG_NEW) {
+		pllx_swcr_new.v = pll_readl_pll_swcr(vco);
+		enabled = pllx_swcr_new.b.pu;
+	} else {
+		pllx_cr.v = pll_readl_cr(vco);
+		enabled = pllx_cr.b.pu;
+	}
+
+	return enabled;
+}
+
+static void __clk_vco_rate2reg(struct clk_vco *vco, unsigned long rate,
+			       unsigned int *kvco, unsigned int *band)
+{
+	int i, size;
+
+	size = ARRAY_SIZE(kvco_rng_table);
+
+	for (i = 0; i < size; i++) {
+		if (rate >= kvco_rng_table[i].vco_min &&
+		    rate <= kvco_rng_table[i].vco_max) {
+			*kvco = kvco_rng_table[i].kvco;
+			*band = kvco_rng_table[i].band;
+			return;
+		}
+	}
+	if (i == size)
+		panic("can't find correct vco\n");
+}
+
+/* frequency unit Mhz, return pll vco freq */
+static unsigned long __get_vco_freq(struct clk_hw *hw)
+{
+	unsigned int pllx_vco, pllxfrcd, pllxfbd;
+	unsigned long pllx_vco_l, rate;
+	struct clk_vco *vco = to_clk_vco(hw);
+	union pllx_cr pllx_cr;
+	union pllx_swcr_new pllx_swcr_new;
+	union pllx_swcr pllx_swcr;
+	union pllx_swcr2 pllx_swcr2;
+	union pllx_swcr2_frac pllx_swcr2_frac;
+	bool hiband;
+
+	if (vco->flags & ASR_PLL_REG_NEW) {
+		pllx_swcr_new.v = pll_readl_pll_swcr(vco);
+		pllxfbd = pllx_swcr_new.b.fbdiv & 0x7f;
+		if (vco->flags & ASR_PLL_FRAC_AUDIO) {
+			pllx_swcr2_frac.v = pll_readl_pll_swcr2(vco);
+			pllxfrcd = pllx_swcr2_frac.b.frcdiv & 0x3fffff;
+		} else {
+			pllx_swcr2.v = pll_readl_pll_swcr2(vco);
+			pllxfrcd = pllx_swcr2.b.frcdiv & 0xff;
+		}
+		hiband = !!pllx_swcr_new.b.band_sel;
+	} else {
+		pllx_cr.v = pll_readl_cr(vco);
+		pllxfrcd = pllx_cr.b.frcdiv & 0xff;
+		pllxfbd = pllx_cr.b.fbdiv & 0x7f;
+		pllx_swcr.v = pll_readl_pll_swcr(vco);
+		hiband = !!pllx_swcr.b.band_sel;
+	}
+
+	if (pllxfrcd) {
+		if (((vco->flags & ASR_PLL_REG_NEW) && (vco->flags & ASR_PLL_FRAC_AUDIO))) {
+			if (pllxfrcd <= (1 << 20)) {
+				pllx_vco_l = (unsigned long)pllxfbd * 26 * MHZ +
+						DIV_ROUND_UP((unsigned long)pllxfrcd * 26 * MHZ, (1 << 20));
+			} else if ((pllxfrcd >= (3 << 20)) && (pllxfbd >= 1)) {
+				pllx_vco_l = (unsigned long)pllxfbd * 26 * MHZ -
+						DIV_ROUND_UP(((1 << 22) - (unsigned long)pllxfrcd) * 26 * MHZ, (1 << 20));
+			} else {
+				pr_err("%s fraction divider %u is invalid\n", __clk_get_name(hw->clk), pllxfrcd);
+				panic("invalid fraction divider\n");
+			}
+			rate = DIV_ROUND_UP(pllx_vco_l, 50) * 50;
+		} else {
+			if (pllxfrcd <= (1 << 6)) {
+				pllx_vco = pllxfbd * 26 + DIV_ROUND_UP(pllxfrcd * 26, 64);
+			} else if ((pllxfrcd >= (3 << 6)) && (pllxfbd >= 1)) {
+				pllx_vco = pllxfbd * 26 + DIV_ROUND_UP(pllxfrcd * 26, 64) - 104;
+			} else {
+				pr_err("%s fraction divider %u is invalid\n", __clk_get_name(hw->clk), pllxfrcd);
+				panic("invalid fraction divider\n");
+			}
+			rate = pllx_vco * MHZ;
+		}
+	} else {
+		rate = 26 * MHZ * pllxfbd;
+	}
+
+	if (hiband)
+		rate = rate * 2;
+
+	return rate;
+}
+
+static void __pll_vco_cfg(struct clk_vco *vco)
+{
+	union pllx_swcr pllx_swcr;
+	union pllx_swcr_new pllx_swcr_new;
+
+	if (vco->flags & ASR_PLL_REG_NEW) {
+		pllx_swcr_new.v = pll_readl_pll_swcr(vco);
+		pllx_swcr_new.b.at_en = 0;
+		pllx_swcr_new.b.dt_en = 0;
+		pllx_swcr_new.b.te_sel = 0;
+		pllx_swcr_new.b.mod_sel = (vco->flags & ASR_PLL_FRAC_FEAT) ? 0 : 1;
+		pllx_swcr_new.b.folock_en = 0;
+		pllx_swcr_new.b.lockdly = 1;
+		pllx_swcr_new.b.bypass = 0;
+		pllx_swcr_new.b.regvol = 1;
+		pllx_swcr_new.b.falock_en = 1;
+		pllx_swcr_new.b.pumpcur = 1;
+		pll_writel_pll_swcr(pllx_swcr_new.v, vco);
+	} else {
+		pllx_swcr.v = pll_readl_pll_swcr(vco);
+		pllx_swcr.b.at_en = 0;
+		pllx_swcr.b.dt_en = 0;
+		pllx_swcr.b.te_sel = 0;
+		pllx_swcr.b.mod_sel = (vco->flags & ASR_PLL_FRAC_FEAT) ? 0 : 1;
+		pllx_swcr.b.folock_en = 0;
+		pllx_swcr.b.lockdly = 1;
+		pllx_swcr.b.bypass = 0;
+		pllx_swcr.b.regvol = 1;
+		pllx_swcr.b.falock_en = 1;
+		pllx_swcr.b.pumpcur = 1;
+		pll_writel_pll_swcr(pllx_swcr.v, vco);
+	}
+}
+
+/* FIXME: set preset parameters directly rather than compute from rate */
+static void enable_pll_ssc(struct clk_vco *vco)
+{
+	struct asr_vco_params *vco_params = vco->params;
+	union pllx_cr pllx_cr;
+	unsigned long flags;
+	union pllx_swcr2 pllx_swcr2;
+
+	spin_lock_irqsave(vco->lock, flags);
+	if (vco->flags & ASR_PLL_REG_NEW) {
+		pllx_swcr2.v = pll_readl_pll_swcr2(vco);
+		pllx_swcr2.b.ssd = vco_params->ssc_depth & 0xf;
+		pllx_swcr2.b.ssdx2 = vco_params->ssc_depx2_en ? 0x1 : 0x0;
+		pllx_swcr2.b.folock_en = vco_params->ssc_folock_en ? 0x1 : 0x0;
+		pllx_swcr2.b.ssmod = vco_params->ssc_mode & 0x3;
+		pll_writel_pll_swcr2(pllx_swcr2.v, vco);
+	} else {
+		pllx_cr.v = pll_readl_cr(vco);
+		/* SSC will be enabled if scc depth is not 0 */
+		pllx_cr.b.ssd = vco_params->ssc_depth & 0xf;
+		pllx_cr.b.ssdx2 = vco_params->ssc_depx2_en ? 0x1 : 0x0;
+		pllx_cr.b.folock_en = vco_params->ssc_folock_en ? 0x1 : 0x0;
+		pllx_cr.b.ssmod = vco_params->ssc_mode & 0x3;
+		pll_writel_cr(pllx_cr.v, vco);
+	}
+	spin_unlock_irqrestore(vco->lock, flags);
+}
+
+static void disable_pll_ssc(struct clk_vco *vco)
+{
+	struct asr_vco_params *vco_params = vco->params;
+	union pllx_cr pllx_cr;
+	unsigned long flags;
+	union pllx_swcr2 pllx_swcr2;
+
+	spin_lock_irqsave(vco->lock, flags);
+	if (vco->flags & ASR_PLL_REG_NEW) {
+		pllx_swcr2.v = pll_readl_pll_swcr2(vco);
+		pllx_swcr2.b.ssd = 0x0;
+		pllx_swcr2.b.ssdx2 = 0x0;
+		pllx_swcr2.b.folock_en = 0x0;
+		pllx_swcr2.b.ssmod = vco_params->ssc_mode & 0x3;
+		pll_writel_pll_swcr2(pllx_swcr2.v, vco);
+	} else {
+		pllx_cr.v = pll_readl_cr(vco);
+		/* SSC will be disabled if scc depth is 0 */
+		pllx_cr.b.ssd = 0x0;
+		pllx_cr.b.ssdx2 = 0x0;
+		pllx_cr.b.folock_en = 0x0;
+		pllx_cr.b.ssmod = 0x0;
+		pll_writel_cr(pllx_cr.v, vco);
+	}
+	spin_unlock_irqrestore(vco->lock, flags);
+}
+
+static void clk_pll_vco_init(struct clk_hw *hw)
+{
+	struct clk_vco *vco = to_clk_vco(hw);
+	unsigned long vco_rate;
+	unsigned int vco_rngl, vco_rngh, tmp;
+	struct asr_vco_params *params = vco->params;
+
+	if (!__pll_is_enabled(hw)) {
+		__pll_vco_cfg(vco);
+	} else {
+		vco_rate = __get_vco_freq(hw) / MHZ;
+		if (!(vco->flags & ASR_PLL_SKIP_DEF_RATE)) {
+			/* check whether vco is in the range of 2% our expectation */
+			tmp = params->default_rate / MHZ;
+			if (tmp != vco_rate) {
+				vco_rngh = tmp + tmp * 2 / 100;
+				vco_rngl = tmp - tmp * 2 / 100;
+				if (!((vco_rngl <= vco_rate) &&
+					 (vco_rate <= vco_rngh)))
+					panic("wrong vco_rate\n");
+			}
+		}
+		/* Make sure SSC is enabled if pll is on */
+		if (vco->flags & ASR_PLL_SSC_FEAT) {
+			enable_pll_ssc(vco);
+			params->ssc_enabled = true;
+		}
+		pr_debug("%s is enabled @ %lu\n", __clk_get_name(hw->clk), vco_rate * MHZ);
+	}
+}
+
+static int clk_pll_vco_enable(struct clk_hw *hw)
+{
+	unsigned int delaytime = 50;
+	unsigned long flags;
+	struct clk_vco *vco = to_clk_vco(hw);
+	struct asr_vco_params *params = vco->params;
+	union pllx_cr pllx_cr;
+	union pllx_swcr_new pllx_swcr_new;
+
+	if (__pll_is_enabled(hw))
+		return 0;
+
+	spin_lock_irqsave(vco->lock, flags);
+	if (vco->flags & ASR_PLL_REG_NEW) {
+		pllx_swcr_new.v = pll_readl_pll_swcr(vco);
+		pllx_swcr_new.b.pu = 1;
+		pll_writel_pll_swcr(pllx_swcr_new.v, vco);
+	} else {
+		pllx_cr.v = pll_readl_cr(vco);
+		pllx_cr.b.pu = 1;
+		pll_writel_cr(pllx_cr.v, vco);
+	}
+	spin_unlock_irqrestore(vco->lock, flags);
+
+	/* check lock status */
+	udelay(50);
+	while ((!(__raw_readl(params->lock_reg) & params->lock_enable_bit))
+	       && delaytime) {
+		udelay(5);
+		delaytime--;
+	}
+
+	/* PLL can't get to stable status in time on emulators or FPGA */
+	if (unlikely(!delaytime)) {
+		pr_err("%s enabling didn't get stable within 300us!!!\n", __clk_get_name(hw->clk));
+		return -EBUSY;
+	}
+
+	if (vco->flags & ASR_PLL_SSC_FEAT)
+		if (((vco->flags & ASR_PLL_SSC_AON) && !params->ssc_enabled)
+		    || !(vco->flags & ASR_PLL_SSC_AON)) {
+			enable_pll_ssc(vco);
+			params->ssc_enabled = true;
+		}
+
+	return 0;
+}
+
+static void clk_pll_vco_disable(struct clk_hw *hw)
+{
+	unsigned long flags;
+	struct clk_vco *vco = to_clk_vco(hw);
+	struct asr_vco_params *params = vco->params;
+	union pllx_cr pllx_cr;
+	union pllx_swcr_new pllx_swcr_new;
+
+	spin_lock_irqsave(vco->lock, flags);
+	if (vco->flags & ASR_PLL_REG_NEW) {
+		pllx_swcr_new.v = pll_readl_pll_swcr(vco);
+		pllx_swcr_new.b.pu = 0;
+		pll_writel_pll_swcr(pllx_swcr_new.v, vco);
+	} else {
+		pllx_cr.v = pll_readl_cr(vco);
+		pllx_cr.b.pu = 0;
+		pll_writel_cr(pllx_cr.v, vco);
+	}
+	spin_unlock_irqrestore(vco->lock, flags);
+
+	if ((vco->flags & ASR_PLL_SSC_FEAT) &&
+	    !(vco->flags & ASR_PLL_SSC_AON)) {
+		disable_pll_ssc(vco);
+		params->ssc_enabled = false;
+	}
+}
+
+/*
+ * pll rate change requires sequence:
+ * clock off -> change rate setting -> clock on
+ * This function doesn't really change rate, but cache the config
+ */
+static int clk_pll_vco_setrate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	unsigned int i, kvco = 0, band, fbd, frcd;
+	unsigned long flags;
+	unsigned long new_rate = rate, old_rate;
+	struct clk_vco *vco = to_clk_vco(hw);
+	struct asr_vco_params *params = vco->params;
+	union pllx_swcr pllx_swcr;
+	union pllx_swcr_new pllx_swcr_new;
+	union pllx_swcr2 pllx_swcr2;
+	union pllx_swcr2_frac pllx_swcr2_frac;
+	union pllx_cr pllx_cr;
+
+	old_rate = __get_vco_freq(hw);
+	/* setp 1: calculate fbd frcd kvco and band */
+	if (params->freq_table) {
+		for (i = 0; i < params->freq_table_size; i++) {
+			if (rate == params->freq_table[i].output_rate) {
+				kvco = params->freq_table[i].kvco;
+				band = params->freq_table[i].band;
+				frcd = params->freq_table[i].frcd;
+				fbd = params->freq_table[i].fbd;
+				break;
+			}
+		}
+		if (i == params->freq_table_size)
+			panic("can't find correct vco\n");
+	} else {
+		__clk_vco_rate2reg(vco, rate / MHZ, &kvco, &band);
+		if (band)
+			rate = rate / 2;
+		if (vco->flags & ASR_PLL_FRAC_AUDIO) {
+			/* Fraction audio PLL diviation is within 24Hz so round the rate by 50Hz */
+			if (rate % 50) {
+				rate = rate / 50 * 50;
+				pr_debug("%s Truncate the rate set for %s from %luHz to %luHz\n",
+					__func__, __clk_get_name(hw->clk), new_rate, band ? rate * 2 : rate);
+				new_rate = band ? (rate * 2) : rate;
+			}
+			fbd = rate / (26 * MHZ);
+			frcd = rate % (26 * MHZ);
+			if (frcd > 13 * MHZ) {
+				fbd++;
+				frcd = (3 << 20) + (unsigned long)frcd * (1 << 20) / (26 * MHZ);
+			} else {
+				frcd = (unsigned long)frcd * (1 << 20) / (26 * MHZ);
+			}
+		} else {
+			/* The other PLL diviation is within 1Mhz so round the rate by 1Mhz */
+			if (rate % MHZ) {
+				rate = rate / MHZ * MHZ;
+				pr_debug("%s Truncate the rate set for %s from %luHz to %luHz\n",
+					__func__, __clk_get_name(hw->clk), new_rate, band ? rate * 2 : rate);
+				new_rate = band ? (rate * 2) : rate;
+			}
+			rate /= MHZ;
+			fbd = rate / 26;
+			frcd = rate % 26;
+			if (frcd > 13) {
+				fbd++;
+				frcd = 192 + (frcd * 64 / 26);
+			} else {
+				frcd = frcd * 64 / 26;
+			}
+		}
+	}
+
+	spin_lock_irqsave(vco->lock, flags);
+	/* setp 2: set pll kvco/band and fbd/frcd setting */
+	if (vco->flags & ASR_PLL_REG_NEW) {
+		pllx_swcr_new.v = pll_readl_pll_swcr(vco);
+		pllx_swcr_new.b.kvco = kvco & 0x7;
+		pllx_swcr_new.b.band_sel = band & 0x1;
+		pllx_swcr_new.b.fbdiv = fbd & 0x7f;
+		pll_writel_pll_swcr(pllx_swcr_new.v, vco);
+		if (vco->flags & ASR_PLL_FRAC_AUDIO) {
+			pllx_swcr2_frac.v = pll_readl_pll_swcr2(vco);
+			pllx_swcr2_frac.b.frcdiv = frcd & 0x3fffff;
+			pll_writel_pll_swcr2(pllx_swcr2_frac.v, vco);
+		} else {
+			pllx_swcr2.v = pll_readl_pll_swcr2(vco);
+			pllx_swcr2.b.frcdiv = frcd & 0xff;
+			pll_writel_pll_swcr2(pllx_swcr2.v, vco);
+		}
+	} else {
+		pllx_swcr.v = pll_readl_pll_swcr(vco);
+		pllx_swcr.b.kvco = kvco & 0x7;
+		pllx_swcr.b.band_sel = band & 0x1;
+		pll_writel_pll_swcr(pllx_swcr.v, vco);
+		pllx_cr.v = pll_readl_cr(vco);
+		pllx_cr.b.frcdiv = frcd & 0xff;
+		pllx_cr.b.fbdiv = fbd & 0x7f;
+		pll_writel_cr(pllx_cr.v, vco);
+	}
+	spin_unlock_irqrestore(vco->lock, flags);
+
+	pr_debug("%s %s rate %lu->%lu!\n", __func__,
+		 __clk_get_name(hw->clk), old_rate, new_rate);
+	return 0;
+}
+
+static unsigned long clk_vco_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	return __get_vco_freq(hw);
+}
+
+static long clk_vco_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	struct clk_vco *vco = to_clk_vco(hw);
+	unsigned long max_rate = 0, new_rate = rate;
+	unsigned int i, band, kvco;
+	struct asr_vco_params *params = vco->params;
+
+	if (rate > params->vco_max || rate < params->vco_min) {
+		pr_err("%lu rate out of range!\n", rate);
+		return -EINVAL;
+	}
+
+	if (params->freq_table) {
+		for (i = 0; i < params->freq_table_size; i++) {
+			if (params->freq_table[i].output_rate <= rate) {
+				if (max_rate <
+				    params->freq_table[i].output_rate)
+					max_rate =
+					    params->freq_table[i].output_rate;
+			}
+		}
+	} else {
+		__clk_vco_rate2reg(vco, rate / MHZ, &kvco, &band);
+		if (band)
+			rate = rate / 2;
+		if (vco->flags & ASR_PLL_FRAC_AUDIO) {
+			/* Fraction audio PLL diviation is within 24Hz so round the rate by 50Hz */
+			if (rate % 50) {
+				rate = rate / 50 * 50;
+				pr_debug("%s Truncate the rate set for %s from %luHz to %luHz\n",
+					__func__, __clk_get_name(hw->clk), new_rate, band ? rate * 2 : rate);
+			}
+		} else {
+			/* The other PLL diviation is within 1Mhz so round the rate by 1Mhz */
+			if (rate % MHZ) {
+				rate = rate / MHZ * MHZ;
+				pr_debug("%s Truncate the rate set for %s from %luHz to %luHz\n",
+					__func__, __clk_get_name(hw->clk), new_rate, band ? rate * 2 : rate);
+			}
+		}
+		if (band)
+			max_rate = rate * 2;
+		else
+			max_rate = rate;
+	}
+	return max_rate;
+}
+
+static const struct clk_ops clk_vco_ops = {
+	.init = clk_pll_vco_init,
+	.enable = clk_pll_vco_enable,
+	.disable = clk_pll_vco_disable,
+	.set_rate = clk_pll_vco_setrate,
+	.recalc_rate = clk_vco_recalc_rate,
+	.round_rate = clk_vco_round_rate,
+	.is_enabled = __pll_is_enabled,
+};
+
+struct clk *asr_clk_register_vco(const char *name,
+				    const char *parent_name,
+				    unsigned long flags, u32 vco_flags,
+				    spinlock_t *lock,
+				    struct asr_vco_params *params)
+{
+	struct clk_vco *vco;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	vco = kzalloc(sizeof(*vco), GFP_KERNEL);
+	if (!vco)
+		return NULL;
+
+	init.name = name;
+	init.ops = &clk_vco_ops;
+	init.flags = flags | CLK_SET_RATE_GATE;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	vco->flags = vco_flags;
+	vco->lock = lock;
+	vco->hw.init = &init;
+	vco->params = params;
+
+	clk = clk_register(NULL, &vco->hw);
+	if (IS_ERR(clk))
+		kfree(vco);
+
+	return clk;
+}
diff --git a/drivers/clk/asr/clk-pll.h b/drivers/clk/asr/clk-pll.h
new file mode 100644
index 0000000..6c66540
--- /dev/null
+++ b/drivers/clk/asr/clk-pll.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASR_CLK_PLL_H
+#define __ASR_CLK_PLL_H
+
+/*
+ * struct kvco_range -store kvco and vrng for different frequency range
+ * @vco_min:	min frequency of vco
+ * @vco_max:	max frequency of vco
+ * @kvco:	kvco val for relevant frequency range
+ * @band:	high band or low band
+ */
+struct kvco_range {
+	int vco_min;
+	int vco_max;
+	u8 kvco;
+	u8 band;
+};
+
+struct asr_vco_freq_table {
+	unsigned long output_rate;
+	u16 frcd;
+	u16 fbd;
+	u8 kvco;
+	u8 band;
+};
+
+enum ssc_mode {
+	CENTER_SPREAD = 0x0,
+	UP_SPREAD = 0x1,
+	DOWN_SPREAD = 0x2,
+};
+
+struct asr_vco_params {
+	unsigned long vco_min;
+	unsigned long vco_max;
+	void __iomem *cr_reg;
+	void __iomem *pll_swcr;
+	void __iomem *pll_swcr2;
+	void __iomem *dpll_swcr;
+	void __iomem *dpll_swcr2;
+	void __iomem *dpll_ctrl;
+	void __iomem *lock_reg;
+	u32 cr_off;
+	u32 swcr_off;
+	u32 swcr2_off;
+	u32 lock_off;
+	u32 lock_enable_bit;
+	unsigned long default_rate;
+
+	struct asr_vco_freq_table *freq_table;
+	int freq_table_size;
+
+	/* SSC setting */
+	bool ssc_enabled;
+	enum ssc_mode ssc_mode;
+	unsigned int ssc_folock_en;
+	unsigned int ssc_depx2_en;
+	unsigned int ssc_depth;
+};
+
+struct clk_vco {
+	struct clk_hw hw;
+	spinlock_t *lock;
+	u32 flags;
+	struct asr_vco_params *params;
+};
+
+#define to_clk_vco(vco_hw) container_of(vco_hw, struct clk_vco, hw)
+
+/**
+ * VCO Flags:
+ */
+#define ASR_PLL_SSC_FEAT	BIT(0)
+#define ASR_PLL_SSC_AON		BIT(1)
+/*
+ * For specific pll such as pll3p, don't check default rate to support
+ * more boot up op.
+ */
+#define ASR_PLL_SKIP_DEF_RATE	BIT(2)
+#define ASR_PLL_FRAC_FEAT	BIT(3)
+#define ASR_PLL_REG_NEW		BIT(4)
+#define ASR_PLL_FRAC_AUDIO	BIT(5)
+#define ASR_PLL_REG_DDR		BIT(6)
+
+extern struct clk *asr_clk_register_vco(const char *name,
+					   const char *parent_name,
+					   unsigned long flags, u32 vco_flags,
+					   spinlock_t *lock,
+					   struct asr_vco_params *params);
+
+#endif
diff --git a/drivers/clk/asr/clk.c b/drivers/clk/asr/clk.c
new file mode 100644
index 0000000..6948fc2
--- /dev/null
+++ b/drivers/clk/asr/clk.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * asr clock operation source file
+ *
+ * Copyright (C) 2019 ASR Microelectronics(Shanghai) Co., Ltd.
+ * Gang Wu <gangwu@asrmicro.com>
+ * Qiao Zhou <qiaozhou@asrmicro.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/of_address.h>
+
+#include "clk.h"
+
+void asr_clks_enable(char **clk_table, int clk_table_size)
+{
+	int i;
+	struct clk *clk;
+
+	for (i = 0; i < clk_table_size; i++) {
+		clk = __clk_lookup(clk_table[i]);
+		if (!IS_ERR_OR_NULL(clk))
+			clk_prepare_enable(clk);
+		else
+			pr_err("%s : can't find clk %s\n", __func__,
+				clk_table[i]);
+	}
+}
+
+int asr_clk_init(struct device_node *np, struct asr_clk_unit *unit,
+		int nr_clks)
+{
+	static struct clk **clk_table;
+
+	clk_table = kcalloc(nr_clks, sizeof(struct clk *), GFP_KERNEL);
+	if (!clk_table)
+		return -ENOMEM;
+
+	unit->clk_table = clk_table;
+	unit->nr_clks = nr_clks;
+	unit->clk_data.clks = clk_table;
+	unit->clk_data.clk_num = nr_clks;
+	of_clk_add_provider(np, of_clk_src_onecell_get, &unit->clk_data);
+
+	return 0;
+}
+
+void asr_register_fixed_rate_clks(struct asr_clk_unit *unit,
+				struct asr_param_fixed_rate_clk *clks,
+				int size)
+{
+	int i;
+	struct clk *clk;
+
+	for (i = 0; i < size; i++) {
+		clk = clk_register_fixed_rate(NULL, clks[i].name,
+					clks[i].parent_name,
+					clks[i].flags,
+					clks[i].fixed_rate);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+		if (clks[i].id)
+			unit->clk_table[clks[i].id] = clk;
+	}
+}
+
+void asr_register_fixed_factor_clks(struct asr_clk_unit *unit,
+				struct asr_param_fixed_factor_clk *clks,
+				int size)
+{
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		clk = clk_register_fixed_factor(NULL, clks[i].name,
+						clks[i].parent_name,
+						clks[i].flags, clks[i].mult,
+						clks[i].div);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+		if (clks[i].id)
+			unit->clk_table[clks[i].id] = clk;
+	}
+}
+
+void asr_register_general_gate_clks(struct asr_clk_unit *unit,
+				struct asr_param_general_gate_clk *clks,
+				void __iomem *base, int size)
+{
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		clk = clk_register_gate(NULL, clks[i].name,
+					clks[i].parent_name,
+					clks[i].flags,
+					base + clks[i].offset,
+					clks[i].bit_idx,
+					clks[i].gate_flags,
+					clks[i].lock);
+
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+		if (clks[i].id)
+			unit->clk_table[clks[i].id] = clk;
+	}
+}
+
+void asr_register_gate_clks(struct asr_clk_unit *unit,
+			struct asr_param_gate_clk *clks,
+			void __iomem *base, int size)
+{
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		clk = asr_clk_register_gate(NULL, clks[i].name,
+					clks[i].parent_name,
+					clks[i].flags,
+					base + clks[i].offset,
+					clks[i].mask,
+					clks[i].val_enable,
+					clks[i].val_disable,
+					clks[i].gate_flags,
+					clks[i].lock);
+
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+		if (clks[i].id)
+			unit->clk_table[clks[i].id] = clk;
+	}
+}
+
+void asr_register_mux_clks(struct asr_clk_unit *unit,
+			struct asr_param_mux_clk *clks,
+			void __iomem *base, int size)
+{
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		clk = clk_register_mux(NULL, clks[i].name,
+					clks[i].parent_name,
+					clks[i].num_parents,
+					clks[i].flags,
+					base + clks[i].offset,
+					clks[i].shift,
+					clks[i].width,
+					clks[i].mux_flags,
+					clks[i].lock);
+
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+		if (clks[i].id)
+			unit->clk_table[clks[i].id] = clk;
+	}
+}
+
+void asr_register_div_clks(struct asr_clk_unit *unit,
+			struct asr_param_div_clk *clks,
+			void __iomem *base, int size)
+{
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		clk = clk_register_divider(NULL, clks[i].name,
+					clks[i].parent_name,
+					clks[i].flags,
+					base + clks[i].offset,
+					clks[i].shift,
+					clks[i].width,
+					clks[i].div_flags,
+					clks[i].lock);
+
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+		if (clks[i].id)
+			unit->clk_table[clks[i].id] = clk;
+	}
+}
+
+void asr_clk_add(struct asr_clk_unit *unit, unsigned int id,
+			struct clk *clk)
+{
+	if (IS_ERR_OR_NULL(clk)) {
+		pr_err("CLK %d has invalid pointer %p\n", id, clk);
+		return;
+	}
+	if (id > unit->nr_clks) {
+		pr_err("CLK %d is invalid\n", id);
+		return;
+	}
+
+	unit->clk_table[id] = clk;
+}
diff --git a/drivers/clk/asr/clk.h b/drivers/clk/asr/clk.h
new file mode 100644
index 0000000..abe39cc
--- /dev/null
+++ b/drivers/clk/asr/clk.h
@@ -0,0 +1,235 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * asr clock source file
+ *
+ * Copyright (C) 2019 ASR Microelectronics(Shanghai) Co., Ltd.
+ * Gang Wu <gangwu@asrmicro.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASR_CLK_H__
+#define __ASR_CLK_H__
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+
+#define APBC_NO_BUS_CTRL	BIT(0)
+#define APBC_POWER_CTRL		BIT(1)
+
+#define MHZ			(1000000UL)
+#define KHZ_TO_HZ		(1000)
+#define MHZ_TO_KHZ		(1000)
+
+/* Clock type "gate". ASR private gate */
+#define ASR_CLK_GATE_NEED_DELAY		BIT(0)
+
+/* Clock type "mix" */
+#define ASR_CLK_BITS_MASK(width, shift)			\
+		(((1 << (width)) - 1) << (shift))
+#define ASR_CLK_BITS_GET_VAL(data, width, shift)	\
+		((data & ASR_CLK_BITS_MASK(width, shift)) >> (shift))
+#define ASR_CLK_BITS_SET_VAL(val, width, shift)		\
+		(((val) << (shift)) & ASR_CLK_BITS_MASK(width, shift))
+
+enum {
+	ASR_CLK_MIX_TYPE_1REG_NOFC_V1,
+	ASR_CLK_MIX_TYPE_1REG_FC_V2,
+	ASR_CLK_MIX_TYPE_2REG_NOFC_V3,
+	ASR_CLK_MIX_TYPE_2REG_FC_V4,
+};
+
+/* The register layout */
+struct asr_clk_mix_reg_info {
+	void __iomem *reg_clk_ctrl;
+	void __iomem *reg_clk_sel;
+	void __iomem *reg_clk_xtc;
+	u8 width_div;
+	u8 shift_div;
+	u8 width_mux;
+	u8 shift_mux;
+	u32 bit_fc;
+};
+
+/* The suggested clock table from user. */
+struct asr_clk_mix_clk_table {
+	unsigned long rate;
+	u8 parent_index;
+	unsigned int divisor;
+	unsigned int valid;
+	unsigned int xtc;
+};
+
+struct asr_clk_mix_config {
+	struct asr_clk_mix_reg_info reg_info;
+	struct asr_clk_mix_clk_table *table;
+	unsigned int table_size;
+	struct clk_div_table *div_table;
+	unsigned long div_flags;
+	unsigned long mux_flags;
+};
+
+struct asr_clk_mix {
+	struct clk_hw hw;
+	struct asr_clk_mix_reg_info reg_info;
+	struct asr_clk_mix_clk_table *table;
+	struct clk_div_table *div_table;
+	unsigned int table_size;
+	unsigned long div_flags;
+	unsigned long mux_flags;
+	spinlock_t *lock;
+};
+
+extern struct clk *asr_clk_register_mix(struct device *dev,
+					const char *name,
+					const char **parent_names,
+					u8 num_parents,
+					unsigned long flags,
+					struct asr_clk_mix_config *config,
+					spinlock_t *lock);
+
+struct asr_clk_gate {
+	struct clk_hw hw;
+	void __iomem *reg;
+	u32 mask;
+	u32 val_enable;
+	u32 val_disable;
+	unsigned long flags;
+	spinlock_t *lock;
+};
+
+extern const struct clk_ops asr_clk_gate_ops;
+extern struct clk *asr_clk_register_gate(struct device *dev, const char *name,
+			const char *parent_name, unsigned long flags,
+			void __iomem *reg, u32 mask, u32 val_enable,
+			u32 val_disable, unsigned long gate_flags,
+			spinlock_t *lock);
+
+
+extern struct clk *asr_clk_register_pll2(const char *name,
+		const char *parent_name, unsigned long flags);
+extern struct clk *asr_clk_register_apbc(const char *name,
+		const char *parent_name, void __iomem *base,
+		unsigned int delay, unsigned long apbc_flags, spinlock_t *lock);
+extern struct clk *asr_clk_register_apmu(const char *name,
+		const char *parent_name, void __iomem *base, u32 enable_mask,
+		spinlock_t *lock);
+
+struct asr_clk_unit {
+	unsigned int nr_clks;
+	struct clk **clk_table;
+	struct clk_onecell_data clk_data;
+};
+
+struct asr_clk_data {
+	struct asr_clk_unit unit;
+	void __iomem *mpmu_base;
+	void __iomem *apmu_base;
+	void __iomem *apbc_base;
+	void __iomem *apbs_base;
+	void __iomem *ciu_base;
+	void __iomem *dciu_base;
+	void __iomem *ddrc_base;
+};
+
+struct asr_param_fixed_rate_clk {
+	unsigned int id;
+	char *name;
+	const char *parent_name;
+	unsigned long flags;
+	unsigned long fixed_rate;
+};
+void asr_register_fixed_rate_clks(struct asr_clk_unit *unit,
+				struct asr_param_fixed_rate_clk *clks,
+				int size);
+
+struct asr_param_fixed_factor_clk {
+	unsigned int id;
+	char *name;
+	const char *parent_name;
+	unsigned long mult;
+	unsigned long div;
+	unsigned long flags;
+};
+void asr_register_fixed_factor_clks(struct asr_clk_unit *unit,
+				struct asr_param_fixed_factor_clk *clks,
+				int size);
+
+struct asr_param_general_gate_clk {
+	unsigned int id;
+	const char *name;
+	const char *parent_name;
+	unsigned long offset;
+	u8 bit_idx;
+	unsigned long gate_flags;
+	spinlock_t *lock;
+	unsigned long flags;
+};
+void asr_register_general_gate_clks(struct asr_clk_unit *unit,
+				struct asr_param_general_gate_clk *clks,
+				void __iomem *base, int size);
+
+struct asr_param_gate_clk {
+	unsigned int id;
+	char *name;
+	const char *parent_name;
+	unsigned long flags;
+	unsigned long offset;
+	u32 mask;
+	u32 val_enable;
+	u32 val_disable;
+	unsigned long gate_flags;
+	spinlock_t *lock;
+};
+void asr_register_gate_clks(struct asr_clk_unit *unit,
+			struct asr_param_gate_clk *clks,
+			void __iomem *base, int size);
+
+struct asr_param_mux_clk {
+	unsigned int id;
+	char *name;
+	const char * const *parent_name;
+	u8 num_parents;
+	unsigned long flags;
+	unsigned long offset;
+	u8 shift;
+	u8 width;
+	unsigned long mux_flags;
+	spinlock_t *lock;
+};
+void asr_register_mux_clks(struct asr_clk_unit *unit,
+			struct asr_param_mux_clk *clks,
+			void __iomem *base, int size);
+
+struct asr_param_div_clk {
+	unsigned int id;
+	char *name;
+	const char *parent_name;
+	unsigned long flags;
+	unsigned long offset;
+	u8 shift;
+	u8 width;
+	unsigned long div_flags;
+	spinlock_t *lock;
+};
+void asr_register_div_clks(struct asr_clk_unit *unit,
+			struct asr_param_div_clk *clks,
+			void __iomem *base, int size);
+
+#define DEFINE_MIX_REG_INFO(w_d, s_d, w_m, s_m, fc)	\
+{									\
+	.width_div = (w_d),				\
+	.shift_div = (s_d),				\
+	.width_mux = (w_m),				\
+	.shift_mux = (s_m),				\
+	.bit_fc = (fc),					\
+}
+
+int asr_clk_init(struct device_node *np, struct asr_clk_unit *unit,
+		int nr_clks);
+void asr_clk_add(struct asr_clk_unit *unit, unsigned int id,
+		struct clk *clk);
+void asr_clks_enable(char **clk_table, int clk_table_size);
+#endif
-- 
2.7.4

