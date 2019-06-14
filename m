Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7431FC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AFB2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfFNRzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:55:50 -0400
Received: from foss.arm.com ([217.140.110.172]:39682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbfFNRz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 318493EF;
        Fri, 14 Jun 2019 10:55:26 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49C813F718;
        Fri, 14 Jun 2019 10:55:25 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Lee Jones <lee.jones@linaro.org>,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH v2 23/28] drivers: Introduce driver_find_device_by_of_node() helper
Date:   Fri, 14 Jun 2019 18:54:18 +0100
Message-Id: <1560534863-15115-24-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper to driver_find_device() to search for a device
by the of_node pointer, reusing the generic match function.
Also convert the existing users to make use of the new helper.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Thor Thayer <thor.thayer@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/amba/tegra-ahb.c    | 11 +----------
 drivers/mfd/altera-sysmgr.c | 14 ++------------
 include/linux/device.h      | 13 +++++++++++++
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index aa64eec..57d3b2e 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -134,22 +134,13 @@ static inline void gizmo_writel(struct tegra_ahb *ahb, u32 value, u32 offset)
 }
 
 #ifdef CONFIG_TEGRA_IOMMU_SMMU
-static int tegra_ahb_match_by_smmu(struct device *dev, const void *data)
-{
-	struct tegra_ahb *ahb = dev_get_drvdata(dev);
-	const struct device_node *dn = data;
-
-	return (ahb->dev->of_node == dn) ? 1 : 0;
-}
-
 int tegra_ahb_enable_smmu(struct device_node *dn)
 {
 	struct device *dev;
 	u32 val;
 	struct tegra_ahb *ahb;
 
-	dev = driver_find_device(&tegra_ahb_driver.driver, NULL, dn,
-				 tegra_ahb_match_by_smmu);
+	dev = driver_find_device_by_of_node(&tegra_ahb_driver.driver, dn);
 	if (!dev)
 		return -EPROBE_DEFER;
 	ahb = dev_get_drvdata(dev);
diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 2ee14d8..d2a13a5 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -88,16 +88,6 @@ static struct regmap_config altr_sysmgr_regmap_cfg = {
 };
 
 /**
- * sysmgr_match_phandle
- * Matching function used by driver_find_device().
- * Return: True if match is found, otherwise false.
- */
-static int sysmgr_match_phandle(struct device *dev, const void *data)
-{
-	return dev->of_node == (const struct device_node *)data;
-}
-
-/**
  * altr_sysmgr_regmap_lookup_by_phandle
  * Find the sysmgr previous configured in probe() and return regmap property.
  * Return: regmap if found or error if not found.
@@ -117,8 +107,8 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 	if (!sysmgr_np)
 		return ERR_PTR(-ENODEV);
 
-	dev = driver_find_device(&altr_sysmgr_driver.driver, NULL,
-				 (void *)sysmgr_np, sysmgr_match_phandle);
+	dev = driver_find_device_by_of_node(&altr_sysmgr_driver.driver,
+					    (void *)sysmgr_np);
 	of_node_put(sysmgr_np);
 	if (!dev)
 		return ERR_PTR(-EPROBE_DEFER);
diff --git a/include/linux/device.h b/include/linux/device.h
index 0d3958e..f929671 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -437,6 +437,19 @@ static inline struct device *driver_find_device_by_name(struct device_driver *dr
 	return driver_find_device(drv, NULL, name, device_match_name);
 }
 
+/**
+ * driver_find_device_by_of_node- device iterator for locating a particular device
+ * by of_node pointer.
+ * @driver: the driver we're iterating
+ * @np: of_node pointer to match.
+ */
+static inline struct device *
+driver_find_device_by_of_node(struct device_driver *drv,
+			      const struct device_node *np)
+{
+	return driver_find_device(drv, NULL, np, device_match_of_node);
+}
+
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 
-- 
2.7.4

