Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B633C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245D72070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ry4LB9xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCMLCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:02:55 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19077 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMLCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:02:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c88e3500001>; Wed, 13 Mar 2019 04:02:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 04:02:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Mar 2019 04:02:52 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 11:02:51 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 11:02:51 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c88e3560001>; Wed, 13 Mar 2019 04:02:51 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <will.deacon@arm.com>,
        <catalin.marinas@arm.com>, <heiko@sntech.de>,
        <horms+renesas@verge.net.au>, <maxime.ripard@bootlin.com>,
        <andy.gross@linaro.org>, <olof@lixom.net>,
        <bjorn.andersson@linaro.org>, <jagan@amarulasolutions.com>,
        <enric.balletbo@collabora.com>, <stefan.wahren@i2se.com>,
        <ezequiel@collabora.com>, <marc.w.gonzalez@free.fr>,
        <christoffer.dall@arm.com>, <drjones@redhat.com>,
        <julien.thierry@arm.com>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 2/5] irqchip/gic: allow gic-pm driver to be used as module
Date:   Wed, 13 Mar 2019 16:32:33 +0530
Message-ID: <1552474956-25513-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552474956-25513-1-git-send-email-spujar@nvidia.com>
References: <1552474956-25513-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552474960; bh=3g7lYYBEFS+Yhcv9M0fGLejT2kT7qJA+aJ6YK4BdXZ4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=Ry4LB9xgHf+u4jOzFMZusRtXnDUjsCHne8HmLEHf7WQZ7lc7gSz5vTpH0d3IRRtm5
         vhn44Ldi8eTLTwbBzAafmxZh3L23o+Xoyyd7rKSucnwj/dyZcWTWI4qD4bLf3PO3AK
         abuRpizLM+Znm6R40612Oe0cxK1iX2vuGhjaZzEEttiCqjZtaaq0sgvpvygYg0dlb4
         7SBNGAzq3j5vhH02mhI0cjfvz8f3ImFjoDNfdJLniWOS75zv4wa6hWuqxQ94+Zvm1Z
         Gi3Z5AyrNUaFz6HDf7JhxsMqNk4j3/QSlgfL+xgcSnv9wBj+dQ1j5fDK8qQFlqjHn0
         lCAmm+7X7eZew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use irq-gic-pm driver as module following changes are made.

1. config ARM_GIC_PM is changed to tristate to allow it to be built as
   module.

2. following functions are exported from irq-gic driver.
   * gic_of_init_child()
   * gic_cpu_save()
   * gic_dist_save()
   * gic_cpu_restore()
   * gic_dist_restore()

3. MODULE_LICENSE is added to make sure driver load is successful, else
   it fails to resolve required symbols. The 'builtin_platform_driver' is
   replaced with 'module_platform_driver' to allow driver removal, else it
   complains that device or resource is busy.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/irqchip/Kconfig      | 2 +-
 drivers/irqchip/irq-gic-pm.c | 3 ++-
 drivers/irqchip/irq-gic.c    | 6 ++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5438abb..8b5ce12 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -12,7 +12,7 @@ config ARM_GIC
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config ARM_GIC_PM
-	bool
+	tristate "ARM GIC with PM support"
 	depends on PM
 	select ARM_GIC
 	select PM_CLK
diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
index 56a785f..cde9714 100644
--- a/drivers/irqchip/irq-gic-pm.c
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -195,4 +195,5 @@ static struct platform_driver gic_driver = {
 	}
 };
 
-builtin_platform_driver(gic_driver);
+module_platform_driver(gic_driver);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index f88018b..b3ad7ed 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -600,6 +600,7 @@ void gic_dist_save(struct gic_chip_data *gic)
 		gic->saved_spi_active[i] =
 			readl_relaxed(dist_base + GIC_DIST_ACTIVE_SET + i * 4);
 }
+EXPORT_SYMBOL_GPL(gic_dist_save);
 
 /*
  * Restores the GIC distributor registers during resume or when coming out of
@@ -653,6 +654,7 @@ void gic_dist_restore(struct gic_chip_data *gic)
 
 	writel_relaxed(GICD_ENABLE, dist_base + GIC_DIST_CTRL);
 }
+EXPORT_SYMBOL_GPL(gic_dist_restore);
 
 void gic_cpu_save(struct gic_chip_data *gic)
 {
@@ -683,6 +685,7 @@ void gic_cpu_save(struct gic_chip_data *gic)
 		ptr[i] = readl_relaxed(dist_base + GIC_DIST_CONFIG + i * 4);
 
 }
+EXPORT_SYMBOL_GPL(gic_cpu_save);
 
 void gic_cpu_restore(struct gic_chip_data *gic)
 {
@@ -725,6 +728,7 @@ void gic_cpu_restore(struct gic_chip_data *gic)
 	writel_relaxed(GICC_INT_PRI_THRESHOLD, cpu_base + GIC_CPU_PRIMASK);
 	gic_cpu_if_up(gic);
 }
+EXPORT_SYMBOL_GPL(gic_cpu_restore);
 
 static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
 {
@@ -1410,6 +1414,7 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(gic_of_init_child);
 
 static void __init gic_of_setup_kvm_info(struct device_node *node)
 {
@@ -1496,6 +1501,7 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq)
 {
 	return -ENOTSUPP;
 }
+EXPORT_SYMBOL_GPL(gic_of_init_child);
 #endif
 
 #ifdef CONFIG_ACPI
-- 
2.7.4

