Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0552186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbfCAI5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:57:51 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:60906 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733163AbfCAI5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:57:50 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id CC1E3FB4494B3BFFA1CA;
        Fri,  1 Mar 2019 16:57:16 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x218v7wO086910;
        Fri, 1 Mar 2019 16:57:07 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019030116574621-2498999 ;
          Fri, 1 Mar 2019 16:57:46 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     liviu.dudau@arm.com
Cc:     sudeep.holla@arm.com, lorenzo.pieralisi@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kgene@kernel.org, krzk@kernel.org,
        linux-samsung-soc@vger.kernel.org, michal.simek@xilinx.com,
        afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        dinguyen@kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linus.walleij@linaro.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        openbmc@lists.ozlabs.org, xuwei5@hisilicon.com,
        maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, horms@verge.net.au, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, wang.yi59@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 07/15] ARM: rockchip: fix a leaked reference by addingmissing of_node_put
Date:   Fri, 1 Mar 2019 16:56:48 +0800
Message-Id: <1551430616-42014-7-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-01 16:57:46,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-01 16:56:52,
        Serialize complete at 2019-03-01 16:56:52
X-MAIL: mse01.zte.com.cn x218v7wO086910
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
./arch/arm/mach-rockchip/platsmp.c:280:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 271, but without a corresponding object release within this function.
./arch/arm/mach-rockchip/platsmp.c:284:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 271, but without a corresponding object release within this function.
./arch/arm/mach-rockchip/platsmp.c:288:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 271, but without a corresponding object release within this function.
./arch/arm/mach-rockchip/platsmp.c:302:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 293, but without a corresponding object release within this function.
./arch/arm/mach-rockchip/platsmp.c:250:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.
./arch/arm/mach-rockchip/platsmp.c:260:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.
./arch/arm/mach-rockchip/platsmp.c:263:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/mach-rockchip/platsmp.c | 12 ++++++++----
 arch/arm/mach-rockchip/pm.c      | 11 ++++++-----
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 51984a4..f93d64e 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -277,19 +277,20 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 	sram_base_addr = of_iomap(node, 0);
 	if (!sram_base_addr) {
 		pr_err("%s: could not map sram registers\n", __func__);
-		return;
+		goto out_put_node;
 	}
 
 	if (has_pmu && rockchip_smp_prepare_pmu())
-		return;
+		goto out_put_node;
 
 	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
 		if (rockchip_smp_prepare_sram(node))
-			return;
+			goto out_put_node;
 
 		/* enable the SCU power domain */
 		pmu_set_power_domain(PMU_PWRDN_SCU, true);
 
+		of_node_put(node);
 		node = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 		if (!node) {
 			pr_err("%s: missing scu\n", __func__);
@@ -299,7 +300,7 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 		scu_base_addr = of_iomap(node, 0);
 		if (!scu_base_addr) {
 			pr_err("%s: could not map scu registers\n", __func__);
-			return;
+			goto out_put_node;
 		}
 
 		/*
@@ -321,6 +322,9 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 	/* Make sure that all cores except the first are really off */
 	for (i = 1; i < ncores; i++)
 		pmu_set_power_domain(0 + i, false);
+
+out_put_node:
+	of_node_put(node);
 }
 
 static void __init rk3036_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
index 0592534..43a16c9 100644
--- a/arch/arm/mach-rockchip/pm.c
+++ b/arch/arm/mach-rockchip/pm.c
@@ -266,25 +266,26 @@ static int rk3288_suspend_init(struct device_node *np)
 	rk3288_bootram_base = of_iomap(sram_np, 0);
 	if (!rk3288_bootram_base) {
 		pr_err("%s: could not map bootram base\n", __func__);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_put_node;
 	}
 
 	ret = of_address_to_resource(sram_np, 0, &res);
 	if (ret) {
 		pr_err("%s: could not get bootram phy addr\n", __func__);
-		return ret;
+		goto out_put_node;
 	}
 	rk3288_bootram_phy = res.start;
 
-	of_node_put(sram_np);
-
 	rk3288_config_bootdata();
 
 	/* copy resume code and data to bootsram */
 	memcpy(rk3288_bootram_base, rockchip_slp_cpu_resume,
 	       rk3288_bootram_sz);
 
-	return 0;
+out_put_node:
+	of_node_put(sram_np);
+	return ret;
 }
 
 static const struct platform_suspend_ops rk3288_suspend_ops = {
-- 
2.9.5

