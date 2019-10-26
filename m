Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0893CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7B821655
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AH3K6poc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfJZUOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:14:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41417 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfJZUOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:14:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id x4so4782693lfn.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eBkUoj+J/kngcmUcIHcy7+E24LcdxiGwsIMFwwr6nM=;
        b=AH3K6pocluyk0frTDK6rSLT4xdb08wtlWsY1v6gxMTasQtRmCbG0L+zEmy1o4jFA5d
         Dj8vfLwiP4MUdcD8cGRGcxMoWBcAsXhP9GfRIzTu2AJL6uevrmqBTTbLG4TsXyOoGJzW
         MxVLewzSaVBx+qYGO5Y+DQaa0E0zqLx86755j+aXJa2OHaXNpL5b7Jos3oyBAbJAiXch
         r0NlvJh7N2zJDj6iQtdssXAIvcX1bQsoJOqzMqPCJcd8UegMH4H0Xgmbqgb9jR3jzGVR
         PkZiQvLEBZQ/kv0uvcYmaiZplU8UQc/I+0AZbiW7zKO1rRCj/e1SpWiQ+hN/GEtG6l7a
         6gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eBkUoj+J/kngcmUcIHcy7+E24LcdxiGwsIMFwwr6nM=;
        b=Px9NxMXS5ufFaB/SVJsfY4snUsvI7vCU0rrVS3uRcNXApQy53cQr8r8S0m0Jm98bRa
         NBQlF+bYD+N0ffwVwFPeIpn+1Ii3ICJwff0s8ryJrhfOWYkYJtv57J31I1fBaDAo/u/J
         K+gw5LGKcnGEZHZDEOnEXE6GaFUIZUfkC359iaY9Ku8YghCouK8TN4cfLeA1gSwr+Jbz
         cxPDaMGHlwlUKABzh+ggPfq/Fz2UnSBKXeSYkVzvW8abEfqET11bnrAEjYWg6WeptAUH
         mqn4UFqXGJh/ujhVeEgQLl4tLaoYiw9540yUJhse6Sk0DAF0lrA0/Pe0nu7/p4yX/3Bc
         gUUg==
X-Gm-Message-State: APjAAAXAaXAIBMDzRi5mbA0VhF7YJn6jyxyZLsOcPDK+OLLStM4A+bep
        C486f9OOHMqv6xYDNz9EdOJKVA==
X-Google-Smtp-Source: APXvYqz+v3Q1HTmT56zPWDJBP2D077HXIIJ5PBUrhQrDEJwNuqyde9isO5wsZVtMpe1pKwf6MnUDBQ==
X-Received: by 2002:a19:3845:: with SMTP id d5mr6398417lfj.162.1572120842605;
        Sat, 26 Oct 2019 13:14:02 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id r1sm2641069ljk.83.2019.10.26.13.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 13:14:01 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2] mfd: db8500-prcmu: Support U8420-sysclk firmware
Date:   Sat, 26 Oct 2019 22:13:57 +0200
Message-Id: <20191026201357.28925-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a distinct version of the Ux500 U8420 variant
with "sysclk", as can be seen from the vendor code that
didn't make it upstream, this firmware lacks the
ULPPLL (ultra-low power phase locked loop) which in
effect means that the timer clock is instead wired to
the 32768 Hz always-on clock.

This has some repercussions when enabling the timer
clock as the code as it stands will disable the timer
clock on these platforms (lacking the so-called
"doze mode") and obtaining the wrong rate of the timer
clock.

The timer frequency is of course needed very early in
the boot, and as a consequence, we need to shuffle
around the early PRCMU init code: whereas in the past
we did not need to look up the PRCMU firmware version
in the early init, but now we need to know the version
before the core system timers are registered so we
restructure the platform callbacks to the PRCMU so as
not to take any arguments and instead look up the
resources it needs directly from the device tree
when initializing.

As we do not yet support any platforms using this
firmware it is not a regression, but as PostmarketOS
is starting to support products with this firmware we
need to fix this up.

The low rate of 32kHz also makes the MTU timer unsuitable
as delay timer but this needs to be fixed in a separate
patch.

Cc: arm@kernel.org
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Change the style of the ULPPLL check function (more
  compact)
- Fix a missing of_node_put() by actually returning
  with -ENODEV on error.

ARM SoC folks: as this mostly affects the MFD subsystems
I think it'd be best if Lee can merge it, I do not
plan any other changes to the ARM core files that the
patch touches.
---
 arch/arm/mach-ux500/cpu-db8500.c |  2 +-
 drivers/mfd/db8500-prcmu.c       | 63 ++++++++++++++++++++++----------
 include/linux/mfd/db8500-prcmu.h |  4 +-
 include/linux/mfd/dbx500-prcmu.h |  7 ++--
 4 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 3875027ef8fc..e929aaa744c0 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -84,6 +84,7 @@ static void __init ux500_init_irq(void)
 	struct resource r;
 
 	irqchip_init();
+	prcmu_early_init();
 	np = of_find_compatible_node(NULL, NULL, "stericsson,db8500-prcmu");
 	of_address_to_resource(np, 0, &r);
 	of_node_put(np);
@@ -91,7 +92,6 @@ static void __init ux500_init_irq(void)
 		pr_err("could not find PRCMU base resource\n");
 		return;
 	}
-	prcmu_early_init(r.start, r.end-r.start);
 	ux500_pm_init(r.start, r.end-r.start);
 
 	/* Unlock before init */
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 9df365a15303..5d7d0edbeca3 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -27,6 +27,7 @@
 #include <linux/bitops.h>
 #include <linux/fs.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
@@ -668,6 +669,14 @@ struct prcmu_fw_version *prcmu_get_fw_version(void)
 	return fw_info.valid ? &fw_info.version : NULL;
 }
 
+static bool prcmu_is_ulppll_disabled(void)
+{
+	struct prcmu_fw_version *ver;
+
+	ver = prcmu_get_fw_version();
+	return ver && ver->project == PRCMU_FW_PROJECT_U8420_SYSCLK;
+}
+
 bool prcmu_has_arm_maxopp(void)
 {
 	return (readb(tcdm_base + PRCM_AVS_VARM_MAX_OPP) &
@@ -1308,10 +1317,23 @@ static int request_sysclk(bool enable)
 
 static int request_timclk(bool enable)
 {
-	u32 val = (PRCM_TCR_DOZE_MODE | PRCM_TCR_TENSEL_MASK);
+	u32 val;
+
+	/*
+	 * On the U8420_CLKSEL firmware, the ULP (Ultra Low Power)
+	 * PLL is disabled so we cannot use doze mode, this will
+	 * stop the clock on this firmware.
+	 */
+	if (prcmu_is_ulppll_disabled())
+		val = 0;
+	else
+		val = (PRCM_TCR_DOZE_MODE | PRCM_TCR_TENSEL_MASK);
 
 	if (!enable)
-		val |= PRCM_TCR_STOP_TIMERS;
+		val |= PRCM_TCR_STOP_TIMERS |
+			PRCM_TCR_DOZE_MODE |
+			PRCM_TCR_TENSEL_MASK;
+
 	writel(val, PRCM_TCR);
 
 	return 0;
@@ -1615,7 +1637,8 @@ unsigned long prcmu_clock_rate(u8 clock)
 	if (clock < PRCMU_NUM_REG_CLOCKS)
 		return clock_rate(clock);
 	else if (clock == PRCMU_TIMCLK)
-		return ROOT_CLOCK_RATE / 16;
+		return prcmu_is_ulppll_disabled() ?
+			32768 : ROOT_CLOCK_RATE / 16;
 	else if (clock == PRCMU_SYSCLK)
 		return ROOT_CLOCK_RATE;
 	else if (clock == PRCMU_PLLSOC0)
@@ -2646,6 +2669,8 @@ static char *fw_project_name(u32 project)
 		return "U8520 MBL";
 	case PRCMU_FW_PROJECT_U8420:
 		return "U8420";
+	case PRCMU_FW_PROJECT_U8420_SYSCLK:
+		return "U8420-sysclk";
 	case PRCMU_FW_PROJECT_U9540:
 		return "U9540";
 	case PRCMU_FW_PROJECT_A9420:
@@ -2693,27 +2718,18 @@ static int db8500_irq_init(struct device_node *np)
 	return 0;
 }
 
-static void dbx500_fw_version_init(struct platform_device *pdev,
-			    u32 version_offset)
+static void dbx500_fw_version_init(struct device_node *np)
 {
-	struct resource *res;
 	void __iomem *tcpm_base;
 	u32 version;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "prcmu-tcpm");
-	if (!res) {
-		dev_err(&pdev->dev,
-			"Error: no prcmu tcpm memory region provided\n");
-		return;
-	}
-	tcpm_base = ioremap(res->start, resource_size(res));
+	tcpm_base = of_iomap(np, 1);
 	if (!tcpm_base) {
-		dev_err(&pdev->dev, "no prcmu tcpm mem region provided\n");
+		pr_err("no prcmu tcpm mem region provided\n");
 		return;
 	}
 
-	version = readl(tcpm_base + version_offset);
+	version = readl(tcpm_base + DB8500_PRCMU_FW_VERSION_OFFSET);
 	fw_info.version.project = (version & 0xFF);
 	fw_info.version.api_version = (version >> 8) & 0xFF;
 	fw_info.version.func_version = (version >> 16) & 0xFF;
@@ -2731,7 +2747,7 @@ static void dbx500_fw_version_init(struct platform_device *pdev,
 	iounmap(tcpm_base);
 }
 
-void __init db8500_prcmu_early_init(u32 phy_base, u32 size)
+void __init db8500_prcmu_early_init(void)
 {
 	/*
 	 * This is a temporary remap to bring up the clocks. It is
@@ -2740,9 +2756,17 @@ void __init db8500_prcmu_early_init(u32 phy_base, u32 size)
 	 * clock driver can probe independently. An early initcall will
 	 * still be needed, but it can be diverted into drivers/clk/ux500.
 	 */
-	prcmu_base = ioremap(phy_base, size);
-	if (!prcmu_base)
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "stericsson,db8500-prcmu");
+	prcmu_base = of_iomap(np, 0);
+	if (!prcmu_base) {
+		of_node_put(np);
 		pr_err("%s: ioremap() of prcmu registers failed!\n", __func__);
+		return -ENODEV;
+	}
+	dbx500_fw_version_init(np);
+	of_node_put(np);
 
 	spin_lock_init(&mb0_transfer.lock);
 	spin_lock_init(&mb0_transfer.dbb_irqs_lock);
@@ -3108,7 +3132,6 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	init_prcm_registers();
-	dbx500_fw_version_init(pdev, DB8500_PRCMU_FW_VERSION_OFFSET);
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "prcmu-tcdm");
 	if (!res) {
 		dev_err(&pdev->dev, "no prcmu tcdm region provided\n");
diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
index 813710aa2cfd..1fc75d2b4a38 100644
--- a/include/linux/mfd/db8500-prcmu.h
+++ b/include/linux/mfd/db8500-prcmu.h
@@ -489,7 +489,7 @@ struct prcmu_auto_pm_config {
 
 #ifdef CONFIG_MFD_DB8500_PRCMU
 
-void db8500_prcmu_early_init(u32 phy_base, u32 size);
+void db8500_prcmu_early_init(void);
 int prcmu_set_rc_a2p(enum romcode_write);
 enum romcode_read prcmu_get_rc_p2a(void);
 enum ap_pwrst prcmu_get_xp70_current_state(void);
@@ -546,7 +546,7 @@ void db8500_prcmu_write_masked(unsigned int reg, u32 mask, u32 value);
 
 #else /* !CONFIG_MFD_DB8500_PRCMU */
 
-static inline void db8500_prcmu_early_init(u32 phy_base, u32 size) {}
+static inline void db8500_prcmu_early_init(void) {}
 
 static inline int prcmu_set_rc_a2p(enum romcode_write code)
 {
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index 238401a50d0b..e2571040c7e8 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -190,6 +190,7 @@ enum ddr_pwrst {
 #define PRCMU_FW_PROJECT_U8500_MBL2	12 /* Customer specific */
 #define PRCMU_FW_PROJECT_U8520		13
 #define PRCMU_FW_PROJECT_U8420		14
+#define PRCMU_FW_PROJECT_U8420_SYSCLK	17
 #define PRCMU_FW_PROJECT_A9420		20
 /* [32..63] 9540 and derivatives */
 #define PRCMU_FW_PROJECT_U9540		32
@@ -211,9 +212,9 @@ struct prcmu_fw_version {
 
 #if defined(CONFIG_UX500_SOC_DB8500)
 
-static inline void prcmu_early_init(u32 phy_base, u32 size)
+static inline void prcmu_early_init(void)
 {
-	return db8500_prcmu_early_init(phy_base, size);
+	return db8500_prcmu_early_init();
 }
 
 static inline int prcmu_set_power_state(u8 state, bool keep_ulp_clk,
@@ -401,7 +402,7 @@ static inline int prcmu_config_a9wdog(u8 num, bool sleep_auto_off)
 }
 #else
 
-static inline void prcmu_early_init(u32 phy_base, u32 size) {}
+static inline void prcmu_early_init(void) {}
 
 static inline int prcmu_set_power_state(u8 state, bool keep_ulp_clk,
 	bool keep_ap_pll)
-- 
2.21.0

