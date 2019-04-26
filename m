Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C18BC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655A6206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfDZHH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:07:57 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:20750 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfDZHH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:07:56 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 43D1C18A20C5FBA130EA;
        Fri, 26 Apr 2019 15:07:54 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x3Q77mA5066340;
        Fri, 26 Apr 2019 15:07:48 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019042615082405-9648437 ;
          Fri, 26 Apr 2019 15:08:24 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3] ARM: rockchip: fix a leaked reference by adding missing of_node_put
Date:   Fri, 26 Apr 2019 15:08:08 +0800
Message-Id: <1556262488-21072-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-26 15:08:24,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-26 15:07:31,
        Serialize complete at 2019-04-26 15:07:31
X-MAIL: mse-fl1.zte.com.cn x3Q77mA5066340
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./arch/arm/mach-rockchip/pm.c:269:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 259, but without a corresponding object release within this function.
./arch/arm/mach-rockchip/pm.c:275:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 259, but without a corresponding object release within this function
./arch/arm/mach-rockchip/platsmp.c:281:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 272, but without a corresponding object release within this function.
./arch/arm/mach-rockchip/platsmp.c:285:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 272, but without a corresponding object release within this function.
./arch/arm/mach-rockchip/platsmp.c:289:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 272, but without a corresponding object release within this function.
./arch/arm/mach-rockchip/platsmp.c:303:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 294, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Suggested-by: Heiko Stuebner <heiko@sntech.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
v2: add a missing space between "adding" and "missing"
v3: just add a regular of_node_put 

 arch/arm/mach-rockchip/platsmp.c | 12 ++++++++++--
 arch/arm/mach-rockchip/pm.c      |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 4675d92..afd1514 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -278,19 +278,25 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 	sram_base_addr = of_iomap(node, 0);
 	if (!sram_base_addr) {
 		pr_err("%s: could not map sram registers\n", __func__);
+		of_node_put(node);
 		return;
 	}
 
-	if (has_pmu && rockchip_smp_prepare_pmu())
+	if (has_pmu && rockchip_smp_prepare_pmu()) {
+		of_node_put(node);
 		return;
+	}
 
 	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
-		if (rockchip_smp_prepare_sram(node))
+		if (rockchip_smp_prepare_sram(node)) {
+			of_node_put(node);
 			return;
+		}
 
 		/* enable the SCU power domain */
 		pmu_set_power_domain(PMU_PWRDN_SCU, true);
 
+		of_node_put(node);
 		node = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 		if (!node) {
 			pr_err("%s: missing scu\n", __func__);
@@ -300,6 +306,7 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 		scu_base_addr = of_iomap(node, 0);
 		if (!scu_base_addr) {
 			pr_err("%s: could not map scu registers\n", __func__);
+			of_node_put(node);
 			return;
 		}
 
@@ -318,6 +325,7 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 		asm ("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
 		ncores = ((l2ctlr >> 24) & 0x3) + 1;
 	}
+	of_node_put(node);
 
 	/* Make sure that all cores except the first are really off */
 	for (i = 1; i < ncores; i++)
diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
index 065b09e..4a4f914 100644
--- a/arch/arm/mach-rockchip/pm.c
+++ b/arch/arm/mach-rockchip/pm.c
@@ -266,12 +266,14 @@ static int __init rk3288_suspend_init(struct device_node *np)
 	rk3288_bootram_base = of_iomap(sram_np, 0);
 	if (!rk3288_bootram_base) {
 		pr_err("%s: could not map bootram base\n", __func__);
+		of_node_put(sram_np);
 		return -ENOMEM;
 	}
 
 	ret = of_address_to_resource(sram_np, 0, &res);
 	if (ret) {
 		pr_err("%s: could not get bootram phy addr\n", __func__);
+		of_node_put(sram_np);
 		return ret;
 	}
 	rk3288_bootram_phy = res.start;
-- 
2.9.5

