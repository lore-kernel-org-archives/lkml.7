Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BCCC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B490F27930
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfFCPwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:52:10 -0400
Received: from foss.arm.com ([217.140.101.70]:54008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbfFCPwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B88AE169E;
        Mon,  3 Jun 2019 08:52:08 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A2103F246;
        Mon,  3 Jun 2019 08:52:06 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [RFC PATCH 45/57] drivers: driver_find_device: Unify the match function
Date:   Mon,  3 Jun 2019 16:50:11 +0100
Message-Id: <1559577023-558-46-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify the match function parameter for driver_find_device
with that of the {bus,class}_find_device helpers, to allow
us to reuse the generic helpers.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Sebastian Ott <sebott@linux.ibm.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Nehal Shah <nehal-bakulchandra.shah@amd.com>
Cc: Shyam Sundar S K <shyam-sundar.s-k@amd.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/amba/tegra-ahb.c             | 4 ++--
 drivers/base/driver.c                | 2 +-
 drivers/char/ipmi/ipmi_msghandler.c  | 8 ++++----
 drivers/gpu/drm/tegra/dc.c           | 4 ++--
 drivers/i2c/busses/i2c-amd-mp2-pci.c | 2 +-
 drivers/iommu/arm-smmu-v3.c          | 2 +-
 drivers/iommu/arm-smmu.c             | 2 +-
 drivers/mfd/altera-sysmgr.c          | 4 ++--
 drivers/mfd/syscon.c                 | 2 +-
 drivers/s390/cio/ccwgroup.c          | 2 +-
 drivers/s390/cio/chsc_sch.c          | 2 +-
 drivers/s390/cio/device.c            | 2 +-
 include/linux/device.h               | 2 +-
 13 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index 3751d81..42175a6 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -143,10 +143,10 @@ static inline void gizmo_writel(struct tegra_ahb *ahb, u32 value, u32 offset)
 }
 
 #ifdef CONFIG_TEGRA_IOMMU_SMMU
-static int tegra_ahb_match_by_smmu(struct device *dev, void *data)
+static int tegra_ahb_match_by_smmu(struct device *dev, const void *data)
 {
 	struct tegra_ahb *ahb = dev_get_drvdata(dev);
-	struct device_node *dn = data;
+	const struct device_node *dn = data;
 
 	return (ahb->dev->of_node == dn) ? 1 : 0;
 }
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 857c8f1..a10e9da 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -74,7 +74,7 @@ EXPORT_SYMBOL_GPL(driver_for_each_device);
  */
 struct device *driver_find_device(struct device_driver *drv,
 				  struct device *start, void *data,
-				  int (*match)(struct device *dev, void *data))
+				  int (*match)(struct device *dev, const void *data))
 {
 	struct klist_iter i;
 	struct device *dev;
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 1dc1074..6707659 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2819,9 +2819,9 @@ static const struct device_type bmc_device_type = {
 	.groups		= bmc_dev_attr_groups,
 };
 
-static int __find_bmc_guid(struct device *dev, void *data)
+static int __find_bmc_guid(struct device *dev, const void *data)
 {
-	guid_t *guid = data;
+	const guid_t *guid = data;
 	struct bmc_device *bmc;
 	int rv;
 
@@ -2857,9 +2857,9 @@ struct prod_dev_id {
 	unsigned char device_id;
 };
 
-static int __find_bmc_prod_dev_id(struct device *dev, void *data)
+static int __find_bmc_prod_dev_id(struct device *dev, const void *data)
 {
-	struct prod_dev_id *cid = data;
+	const struct prod_dev_id *cid = data;
 	struct bmc_device *bmc;
 	int rv;
 
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 607a6ea1..52109a6 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2375,10 +2375,10 @@ static int tegra_dc_parse_dt(struct tegra_dc *dc)
 	return 0;
 }
 
-static int tegra_dc_match_by_pipe(struct device *dev, void *data)
+static int tegra_dc_match_by_pipe(struct device *dev, const void *data)
 {
 	struct tegra_dc *dc = dev_get_drvdata(dev);
-	unsigned int pipe = (unsigned long)data;
+	unsigned int pipe = (unsigned long)(void *)data;
 
 	return dc->pipe == pipe;
 }
diff --git a/drivers/i2c/busses/i2c-amd-mp2-pci.c b/drivers/i2c/busses/i2c-amd-mp2-pci.c
index 455e1f3..c7fe3b4 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-pci.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-pci.c
@@ -457,7 +457,7 @@ static struct pci_driver amd_mp2_pci_driver = {
 };
 module_pci_driver(amd_mp2_pci_driver);
 
-static int amd_mp2_device_match(struct device *dev, void *data)
+static int amd_mp2_device_match(struct device *dev, const void *data)
 {
 	return 1;
 }
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4d5a694..d787856 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2023,7 +2023,7 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 
 static struct platform_driver arm_smmu_driver;
 
-static int arm_smmu_match_node(struct device *dev, void *data)
+static int arm_smmu_match_node(struct device *dev, const void *data)
 {
 	return dev->fwnode == data;
 }
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5e54cc0..4ce429b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1431,7 +1431,7 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	}
 }
 
-static int arm_smmu_match_node(struct device *dev, void *data)
+static int arm_smmu_match_node(struct device *dev, const void *data)
 {
 	return dev->fwnode == data;
 }
diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 8976f82..2ee14d8 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -92,9 +92,9 @@ static struct regmap_config altr_sysmgr_regmap_cfg = {
  * Matching function used by driver_find_device().
  * Return: True if match is found, otherwise false.
  */
-static int sysmgr_match_phandle(struct device *dev, void *data)
+static int sysmgr_match_phandle(struct device *dev, const void *data)
 {
-	return dev->of_node == (struct device_node *)data;
+	return dev->of_node == (const struct device_node *)data;
 }
 
 /**
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 8ce1e41..4f39ba5 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -190,7 +190,7 @@ struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_compatible);
 
-static int syscon_match_pdevname(struct device *dev, void *data)
+static int syscon_match_pdevname(struct device *dev, const void *data)
 {
 	return !strcmp(dev_name(dev), (const char *)data);
 }
diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index a006945..c554f16 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -606,7 +606,7 @@ void ccwgroup_driver_unregister(struct ccwgroup_driver *cdriver)
 }
 EXPORT_SYMBOL(ccwgroup_driver_unregister);
 
-static int __ccwgroupdev_check_busid(struct device *dev, void *id)
+static int __ccwgroupdev_check_busid(struct device *dev, const void *id)
 {
 	char *bus_id = id;
 
diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 8d9f366..8f080d3 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -203,7 +203,7 @@ static void chsc_cleanup_sch_driver(void)
 
 static DEFINE_SPINLOCK(chsc_lock);
 
-static int chsc_subchannel_match_next_free(struct device *dev, void *data)
+static int chsc_subchannel_match_next_free(struct device *dev, const void *data)
 {
 	struct subchannel *sch = to_subchannel(dev);
 
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 6ca9a3a..a5c2765 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1653,7 +1653,7 @@ EXPORT_SYMBOL_GPL(ccw_device_force_console);
  * get ccw_device matching the busid, but only if owned by cdrv
  */
 static int
-__ccwdev_check_busid(struct device *dev, void *id)
+__ccwdev_check_busid(struct device *dev, const void *id)
 {
 	char *bus_id;
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 1945c3d..52d59d5 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -399,7 +399,7 @@ extern int __must_check driver_for_each_device(struct device_driver *drv,
 							 void *));
 struct device *driver_find_device(struct device_driver *drv,
 				  struct device *start, void *data,
-				  int (*match)(struct device *dev, void *data));
+				  int (*match)(struct device *dev, const void *data));
 
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
-- 
2.7.4

