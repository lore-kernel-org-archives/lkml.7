Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE39C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8342183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfFNRyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:54:54 -0400
Received: from foss.arm.com ([217.140.110.172]:39274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbfFNRyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:54:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A7183EF;
        Fri, 14 Jun 2019 10:54:51 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F9683F718;
        Fri, 14 Jun 2019 10:54:47 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andreas Noever <andreas.noever@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Corey Minyard <minyard@acm.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Kershner <david.kershner@unisys.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Airlie <airlied@linux.ie>,
        Felipe Balbi <balbi@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Cameron <jic23@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Jamet <michael.jamet@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 04/28] bus_find_device: Unify the match callback with class_find_device
Date:   Fri, 14 Jun 2019 18:53:59 +0100
Message-Id: <1560534863-15115-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an arbitrary difference between the prototypes of
bus_find_device() and class_find_device() preventing their callers
from passing the same pair of data and match() arguments to both of
them, which is the const qualifier used in the prototype of
class_find_device().  If that qualifier is also used in the
bus_find_device() prototype, it will be possible to pass the same
match() callback function to both bus_find_device() and
class_find_device(), which will allow some optimizations to be made in
order to avoid code duplication going forward.  Also with that, constify
the "data" parameter as it is passed as a const to the match function.

For this reason, change the prototype of bus_find_device() to match
the prototype of class_find_device() and adjust its callers to use the
const qualifier in accordance with the new prototype of it.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Corey Minyard <minyard@acm.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Kershner <david.kershner@unisys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sebastian Ott <sebott@linux.ibm.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: rafael@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Corey Minyard <minyard@acm.org>
Acked-by: David Kershner <david.kershner@unisys.com>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v1:
  - Removed staging/core and mfd/syscon changes as they have been
    dealt with in other ways. Otherwise remains unchanged
  - Fix warnings on s390 build
---
 arch/powerpc/platforms/pseries/ibmebus.c           | 4 ++--
 drivers/acpi/acpi_lpss.c                           | 4 ++--
 drivers/acpi/sleep.c                               | 2 +-
 drivers/acpi/utils.c                               | 4 ++--
 drivers/base/bus.c                                 | 6 +++---
 drivers/base/devcon.c                              | 2 +-
 drivers/char/ipmi/ipmi_si_platform.c               | 2 +-
 drivers/firmware/efi/dev-path-parser.c             | 4 ++--
 drivers/gpu/drm/drm_mipi_dsi.c                     | 2 +-
 drivers/hwtracing/coresight/coresight.c            | 6 +++---
 drivers/hwtracing/coresight/of_coresight.c         | 2 +-
 drivers/hwtracing/intel_th/core.c                  | 5 ++---
 drivers/i2c/i2c-core-acpi.c                        | 4 ++--
 drivers/i2c/i2c-core-of.c                          | 4 ++--
 drivers/iio/inkern.c                               | 2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c | 2 +-
 drivers/net/ethernet/ti/cpsw-phy-sel.c             | 4 ++--
 drivers/net/ethernet/ti/davinci_emac.c             | 2 +-
 drivers/net/ethernet/toshiba/tc35815.c             | 4 ++--
 drivers/nvmem/core.c                               | 2 +-
 drivers/of/of_mdio.c                               | 2 +-
 drivers/of/platform.c                              | 2 +-
 drivers/pci/probe.c                                | 2 +-
 drivers/pci/search.c                               | 4 ++--
 drivers/s390/cio/css.c                             | 4 ++--
 drivers/s390/cio/device.c                          | 4 ++--
 drivers/s390/cio/scm.c                             | 4 ++--
 drivers/s390/crypto/ap_bus.c                       | 8 ++++----
 drivers/scsi/scsi_proc.c                           | 2 +-
 drivers/spi/spi.c                                  | 4 ++--
 drivers/thunderbolt/switch.c                       | 4 ++--
 drivers/usb/core/devio.c                           | 4 ++--
 drivers/usb/core/usb.c                             | 4 ++--
 drivers/usb/phy/phy-am335x-control.c               | 4 ++--
 drivers/usb/phy/phy-isp1301.c                      | 4 ++--
 drivers/visorbus/visorbus_main.c                   | 4 ++--
 include/linux/device.h                             | 4 ++--
 sound/soc/rockchip/rk3399_gru_sound.c              | 2 +-
 39 files changed, 67 insertions(+), 68 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index 84e8ec4..b91eb09 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -147,13 +147,13 @@ static const struct dma_map_ops ibmebus_dma_ops = {
 	.unmap_page         = ibmebus_unmap_page,
 };
 
-static int ibmebus_match_path(struct device *dev, void *data)
+static int ibmebus_match_path(struct device *dev, const void *data)
 {
 	struct device_node *dn = to_platform_device(dev)->dev.of_node;
 	return (of_find_node_by_path(data) == dn);
 }
 
-static int ibmebus_match_node(struct device *dev, void *data)
+static int ibmebus_match_node(struct device *dev, const void *data)
 {
 	return to_platform_device(dev)->dev.of_node == data;
 }
diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index cf76860..dc2ca78 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -511,10 +511,10 @@ struct hid_uid {
 	const char *uid;
 };
 
-static int match_hid_uid(struct device *dev, void *data)
+static int match_hid_uid(struct device *dev, const void *data)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	struct hid_uid *id = data;
+	const struct hid_uid *id = data;
 
 	if (!adev)
 		return 0;
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 8ff08e5..cd11070 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -452,7 +452,7 @@ static int acpi_pm_prepare(void)
 	return error;
 }
 
-static int find_powerf_dev(struct device *dev, void *data)
+static int find_powerf_dev(struct device *dev, const void *data)
 {
 	struct acpi_device *device = to_acpi_device(dev);
 	const char *hid = acpi_device_hid(device);
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 1391b63..e3974a8 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -730,10 +730,10 @@ struct acpi_dev_match_info {
 	s64 hrv;
 };
 
-static int acpi_dev_match_cb(struct device *dev, void *data)
+static int acpi_dev_match_cb(struct device *dev, const void *data)
 {
 	struct acpi_device *adev = to_acpi_device(dev);
-	struct acpi_dev_match_info *match = data;
+	const struct acpi_dev_match_info *match = data;
 	unsigned long long hrv;
 	acpi_status status;
 
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 0a58e96..df3cac7 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -323,8 +323,8 @@ EXPORT_SYMBOL_GPL(bus_for_each_dev);
  * return to the caller and not iterate over any more devices.
  */
 struct device *bus_find_device(struct bus_type *bus,
-			       struct device *start, void *data,
-			       int (*match)(struct device *dev, void *data))
+			       struct device *start, const void *data,
+			       int (*match)(struct device *dev, const void *data))
 {
 	struct klist_iter i;
 	struct device *dev;
@@ -342,7 +342,7 @@ struct device *bus_find_device(struct bus_type *bus,
 }
 EXPORT_SYMBOL_GPL(bus_find_device);
 
-static int match_name(struct device *dev, void *data)
+static int match_name(struct device *dev, const void *data)
 {
 	const char *name = data;
 
diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 04db9ae..ac026d5 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -107,7 +107,7 @@ static struct bus_type *generic_match_buses[] = {
 	NULL,
 };
 
-static int device_fwnode_match(struct device *dev, void *fwnode)
+static int device_fwnode_match(struct device *dev, const void *fwnode)
 {
 	return dev_fwnode(dev) == fwnode;
 }
diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index f2a91c4..fd94c42 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -426,7 +426,7 @@ static int ipmi_remove(struct platform_device *pdev)
 	return ipmi_si_remove_by_dev(&pdev->dev);
 }
 
-static int pdev_match_name(struct device *dev, void *data)
+static int pdev_match_name(struct device *dev, const void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	const char *name = data;
diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
index 85ec99f..2012338 100644
--- a/drivers/firmware/efi/dev-path-parser.c
+++ b/drivers/firmware/efi/dev-path-parser.c
@@ -17,9 +17,9 @@ struct acpi_hid_uid {
 	char uid[11]; /* UINT_MAX + null byte */
 };
 
-static int __init match_acpi_dev(struct device *dev, void *data)
+static int __init match_acpi_dev(struct device *dev, const void *data)
 {
-	struct acpi_hid_uid hid_uid = *(struct acpi_hid_uid *)data;
+	struct acpi_hid_uid hid_uid = *(const struct acpi_hid_uid *)data;
 	struct acpi_device *adev = to_acpi_device(dev);
 
 	if (acpi_match_device_ids(adev, hid_uid.hid))
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 80b7550..ad19df0 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -93,7 +93,7 @@ static struct bus_type mipi_dsi_bus_type = {
 	.pm = &mipi_dsi_device_pm_ops,
 };
 
-static int of_device_match(struct device *dev, void *data)
+static int of_device_match(struct device *dev, const void *data)
 {
 	return dev->of_node == data;
 }
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 4b13028..b67ab6a 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -498,9 +498,9 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
 	return csdev;
 }
 
-static int coresight_enabled_sink(struct device *dev, void *data)
+static int coresight_enabled_sink(struct device *dev, const void *data)
 {
-	bool *reset = data;
+	const bool *reset = data;
 	struct coresight_device *csdev = to_coresight_device(dev);
 
 	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
@@ -544,7 +544,7 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
 	return dev ? to_coresight_device(dev) : NULL;
 }
 
-static int coresight_sink_by_id(struct device *dev, void *data)
+static int coresight_sink_by_id(struct device *dev, const void *data)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 	unsigned long hash;
diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 7045930..3fc200e 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -18,7 +18,7 @@
 #include <asm/smp_plat.h>
 
 
-static int of_dev_node_match(struct device *dev, void *data)
+static int of_dev_node_match(struct device *dev, const void *data)
 {
 	return dev->of_node == data;
 }
diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 033dce5..5592289 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -789,10 +789,9 @@ static int intel_th_populate(struct intel_th *th)
 	return 0;
 }
 
-static int match_devt(struct device *dev, void *data)
+static int match_devt(struct device *dev, const void *data)
 {
-	dev_t devt = (dev_t)(unsigned long)data;
-
+	dev_t devt = (dev_t)(unsigned long)(void *)data;
 	return dev->devt == devt;
 }
 
diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index d840955..8af35f11 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -318,7 +318,7 @@ u32 i2c_acpi_find_bus_speed(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(i2c_acpi_find_bus_speed);
 
-static int i2c_acpi_find_match_adapter(struct device *dev, void *data)
+static int i2c_acpi_find_match_adapter(struct device *dev, const void *data)
 {
 	struct i2c_adapter *adapter = i2c_verify_adapter(dev);
 
@@ -328,7 +328,7 @@ static int i2c_acpi_find_match_adapter(struct device *dev, void *data)
 	return ACPI_HANDLE(dev) == (acpi_handle)data;
 }
 
-static int i2c_acpi_find_match_device(struct device *dev, void *data)
+static int i2c_acpi_find_match_device(struct device *dev, const void *data)
 {
 	return ACPI_COMPANION(dev) == data;
 }
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 406e5f6..2eb59a2 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -112,12 +112,12 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
 	of_node_put(bus);
 }
 
-static int of_dev_node_match(struct device *dev, void *data)
+static int of_dev_node_match(struct device *dev, const void *data)
 {
 	return dev->of_node == data;
 }
 
-static int of_dev_or_parent_node_match(struct device *dev, void *data)
+static int of_dev_or_parent_node_match(struct device *dev, const void *data)
 {
 	if (dev->of_node == data)
 		return 1;
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 4a5eff3..c46fb59 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -93,7 +93,7 @@ static const struct iio_chan_spec
 
 #ifdef CONFIG_OF
 
-static int iio_dev_node_match(struct device *dev, void *data)
+static int iio_dev_node_match(struct device *dev, const void *data)
 {
 	return dev->of_node == data && dev->type == &iio_device_type;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index e068a02..3afd3e9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4498,7 +4498,7 @@ static const struct acpi_device_id hns_roce_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, hns_roce_acpi_match);
 
-static int hns_roce_node_match(struct device *dev, void *fwnode)
+static int hns_roce_node_match(struct device *dev, const void *fwnode)
 {
 	return dev->fwnode == fwnode;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
index 09c16d8..bb6586d 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
@@ -754,7 +754,7 @@ struct dsaf_misc_op *hns_misc_op_get(struct dsaf_device *dsaf_dev)
 	return (void *)misc_op;
 }
 
-static int hns_dsaf_dev_match(struct device *dev, void *fwnode)
+static int hns_dsaf_dev_match(struct device *dev, const void *fwnode)
 {
 	return dev->fwnode == fwnode;
 }
diff --git a/drivers/net/ethernet/ti/cpsw-phy-sel.c b/drivers/net/ethernet/ti/cpsw-phy-sel.c
index 48e0924..4e184ee 100644
--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -151,9 +151,9 @@ static void cpsw_gmii_sel_dra7xx(struct cpsw_phy_sel_priv *priv,
 }
 
 static struct platform_driver cpsw_phy_sel_driver;
-static int match(struct device *dev, void *data)
+static int match(struct device *dev, const void *data)
 {
-	struct device_node *node = (struct device_node *)data;
+	const struct device_node *node = (const struct device_node *)data;
 	return dev->of_node == node &&
 		dev->driver == &cpsw_phy_sel_driver.driver;
 }
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 4bf65ca..57d131a 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1371,7 +1371,7 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
 		return -EOPNOTSUPP;
 }
 
-static int match_first_device(struct device *dev, void *data)
+static int match_first_device(struct device *dev, const void *data)
 {
 	if (dev->parent && dev->parent->of_node)
 		return of_device_is_compatible(dev->parent->of_node,
diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net/ethernet/toshiba/tc35815.c
index c50a977..8479a44 100644
--- a/drivers/net/ethernet/toshiba/tc35815.c
+++ b/drivers/net/ethernet/toshiba/tc35815.c
@@ -694,10 +694,10 @@ static int tc_mii_init(struct net_device *dev)
  * should provide a "tc35815-mac" device with a MAC address in its
  * platform_data.
  */
-static int tc35815_mac_match(struct device *dev, void *data)
+static int tc35815_mac_match(struct device *dev, const void *data)
 {
 	struct platform_device *plat_dev = to_platform_device(dev);
-	struct pci_dev *pci_dev = data;
+	const struct pci_dev *pci_dev = data;
 	unsigned int id = pci_dev->irq;
 	return !strcmp(plat_dev->name, "tc35815-mac") && plat_dev->id == id;
 }
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index c7892c3..ac5d945 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -76,7 +76,7 @@ static struct bus_type nvmem_bus_type = {
 	.name		= "nvmem",
 };
 
-static int of_nvmem_match(struct device *dev, void *nvmem_np)
+static int of_nvmem_match(struct device *dev, const void *nvmem_np)
 {
 	return dev->of_node == nvmem_np;
 }
diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 3b67896..44f5349 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -281,7 +281,7 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 EXPORT_SYMBOL(of_mdiobus_register);
 
 /* Helper function for of_phy_find_device */
-static int of_phy_match(struct device *dev, void *phy_np)
+static int of_phy_match(struct device *dev, const void *phy_np)
 {
 	return dev->of_node == phy_np;
 }
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 04ad312..008d79e 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -37,7 +37,7 @@ static const struct of_device_id of_skipped_node_table[] = {
 	{} /* Empty terminated list */
 };
 
-static int of_dev_node_match(struct device *dev, void *data)
+static int of_dev_node_match(struct device *dev, const void *data)
 {
 	return dev->of_node == data;
 }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0e8e2c1..f9ef7ad 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -64,7 +64,7 @@ static struct resource *get_pci_domain_busn_res(int domain_nr)
 	return &r->res;
 }
 
-static int find_anything(struct device *dev, void *data)
+static int find_anything(struct device *dev, const void *data)
 {
 	return 1;
 }
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 5c79226..7f4e658 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -236,10 +236,10 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
 }
 EXPORT_SYMBOL(pci_get_domain_bus_and_slot);
 
-static int match_pci_dev_by_id(struct device *dev, void *data)
+static int match_pci_dev_by_id(struct device *dev, const void *data)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_device_id *id = data;
+	const struct pci_device_id *id = data;
 
 	if (pci_match_one_device(id, pdev))
 		return 1;
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index aea5029..a2c9783 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -434,10 +434,10 @@ static int css_probe_device(struct subchannel_id schid, struct schib *schib)
 }
 
 static int
-check_subchannel(struct device * dev, void * data)
+check_subchannel(struct device *dev, const void *data)
 {
 	struct subchannel *sch;
-	struct subchannel_id *schid = data;
+	struct subchannel_id *schid = (void *)data;
 
 	sch = to_subchannel(dev);
 	return schid_equal(&sch->schid, schid);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 1540229..d32f373 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -642,10 +642,10 @@ static int ccw_device_add(struct ccw_device *cdev)
 	return device_add(dev);
 }
 
-static int match_dev_id(struct device *dev, void *data)
+static int match_dev_id(struct device *dev, const void *data)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
-	struct ccw_dev_id *dev_id = data;
+	struct ccw_dev_id *dev_id = (void *)data;
 
 	return ccw_dev_id_is_equal(&cdev->private->dev_id, dev_id);
 }
diff --git a/drivers/s390/cio/scm.c b/drivers/s390/cio/scm.c
index 6bca1d5..9f26d43 100644
--- a/drivers/s390/cio/scm.c
+++ b/drivers/s390/cio/scm.c
@@ -174,10 +174,10 @@ static void scmdev_update(struct scm_device *scmdev, struct sale *sale)
 		kobject_uevent(&scmdev->dev.kobj, KOBJ_CHANGE);
 }
 
-static int check_address(struct device *dev, void *data)
+static int check_address(struct device *dev, const void *data)
 {
 	struct scm_device *scmdev = to_scm_dev(dev);
-	struct sale *sale = data;
+	const struct sale *sale = data;
 
 	return scmdev->address == sale->sa;
 }
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index b9fc502..b7902b6 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1356,16 +1356,16 @@ static int ap_get_compatible_type(ap_qid_t qid, int rawtype, unsigned int func)
  * Helper function to be used with bus_find_dev
  * matches for the card device with the given id
  */
-static int __match_card_device_with_id(struct device *dev, void *data)
+static int __match_card_device_with_id(struct device *dev, const void *data)
 {
-	return is_card_dev(dev) && to_ap_card(dev)->id == (int)(long) data;
+	return is_card_dev(dev) && to_ap_card(dev)->id == (int)(long)(void *) data;
 }
 
 /*
  * Helper function to be used with bus_find_dev
  * matches for the queue device with a given qid
  */
-static int __match_queue_device_with_qid(struct device *dev, void *data)
+static int __match_queue_device_with_qid(struct device *dev, const void *data)
 {
 	return is_queue_dev(dev) && to_ap_queue(dev)->qid == (int)(long) data;
 }
@@ -1374,7 +1374,7 @@ static int __match_queue_device_with_qid(struct device *dev, void *data)
  * Helper function to be used with bus_find_dev
  * matches any queue device with given queue id
  */
-static int __match_queue_device_with_queue_id(struct device *dev, void *data)
+static int __match_queue_device_with_queue_id(struct device *dev, const void *data)
 {
 	return is_queue_dev(dev)
 		&& AP_QID_QUEUE(to_ap_queue(dev)->qid) == (int)(long) data;
diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index 7f0ceb6..c074631 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -372,7 +372,7 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	return err;
 }
 
-static int always_match(struct device *dev, void *data)
+static int always_match(struct device *dev, const void *data)
 {
 	return 1;
 }
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e75944..3da1121 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3538,7 +3538,7 @@ EXPORT_SYMBOL_GPL(spi_write_then_read);
 /*-------------------------------------------------------------------------*/
 
 #if IS_ENABLED(CONFIG_OF)
-static int __spi_of_device_match(struct device *dev, void *data)
+static int __spi_of_device_match(struct device *dev, const void *data)
 {
 	return dev->of_node == data;
 }
@@ -3639,7 +3639,7 @@ static int spi_acpi_controller_match(struct device *dev, const void *data)
 	return ACPI_COMPANION(dev->parent) == data;
 }
 
-static int spi_acpi_device_match(struct device *dev, void *data)
+static int spi_acpi_device_match(struct device *dev, const void *data)
 {
 	return ACPI_COMPANION(dev) == data;
 }
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index c1b0165..c9a7e4a 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1946,10 +1946,10 @@ struct tb_sw_lookup {
 	u64 route;
 };
 
-static int tb_switch_match(struct device *dev, void *data)
+static int tb_switch_match(struct device *dev, const void *data)
 {
 	struct tb_switch *sw = tb_to_switch(dev);
-	struct tb_sw_lookup *lookup = data;
+	const struct tb_sw_lookup *lookup = data;
 
 	if (!sw)
 		return 0;
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index fa783531..7bd7de7 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -947,9 +947,9 @@ static int parse_usbdevfs_streams(struct usb_dev_state *ps,
 	return ret;
 }
 
-static int match_devt(struct device *dev, void *data)
+static int match_devt(struct device *dev, const void *data)
 {
-	return dev->devt == (dev_t) (unsigned long) data;
+	return dev->devt == (dev_t)(unsigned long)(void *)data;
 }
 
 static struct usb_device *usbdev_lookup_by_devt(dev_t devt)
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 7fcb9f7..1678e30 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -325,9 +325,9 @@ struct find_interface_arg {
 	struct device_driver *drv;
 };
 
-static int __find_interface(struct device *dev, void *data)
+static int __find_interface(struct device *dev, const void *data)
 {
-	struct find_interface_arg *arg = data;
+	const struct find_interface_arg *arg = data;
 	struct usb_interface *intf;
 
 	if (!is_usb_interface(dev))
diff --git a/drivers/usb/phy/phy-am335x-control.c b/drivers/usb/phy/phy-am335x-control.c
index a3cb25c..d16dfc3 100644
--- a/drivers/usb/phy/phy-am335x-control.c
+++ b/drivers/usb/phy/phy-am335x-control.c
@@ -118,9 +118,9 @@ static const struct of_device_id omap_control_usb_id_table[] = {
 MODULE_DEVICE_TABLE(of, omap_control_usb_id_table);
 
 static struct platform_driver am335x_control_driver;
-static int match(struct device *dev, void *data)
+static int match(struct device *dev, const void *data)
 {
-	struct device_node *node = (struct device_node *)data;
+	const struct device_node *node = (const struct device_node *)data;
 	return dev->of_node == node &&
 		dev->driver == &am335x_control_driver.driver;
 }
diff --git a/drivers/usb/phy/phy-isp1301.c b/drivers/usb/phy/phy-isp1301.c
index 93b7d6a..6cf6fbd 100644
--- a/drivers/usb/phy/phy-isp1301.c
+++ b/drivers/usb/phy/phy-isp1301.c
@@ -142,9 +142,9 @@ static struct i2c_driver isp1301_driver = {
 
 module_i2c_driver(isp1301_driver);
 
-static int match(struct device *dev, void *data)
+static int match(struct device *dev, const void *data)
 {
-	struct device_node *node = (struct device_node *)data;
+	const struct device_node *node = (const struct device_node *)data;
 	return (dev->of_node == node) &&
 		(dev->driver == &isp1301_driver.driver);
 }
diff --git a/drivers/visorbus/visorbus_main.c b/drivers/visorbus/visorbus_main.c
index 0b2434c..152fd29 100644
--- a/drivers/visorbus/visorbus_main.c
+++ b/drivers/visorbus/visorbus_main.c
@@ -171,10 +171,10 @@ struct visor_busdev {
 	u32 dev_no;
 };
 
-static int match_visorbus_dev_by_id(struct device *dev, void *data)
+static int match_visorbus_dev_by_id(struct device *dev, const void *data)
 {
 	struct visor_device *vdev = to_visor_device(dev);
-	struct visor_busdev *id = data;
+	const struct visor_busdev *id = data;
 
 	if (vdev->chipset_bus_no == id->bus_no &&
 	    vdev->chipset_dev_no == id->dev_no)
diff --git a/include/linux/device.h b/include/linux/device.h
index e85264f..cbbdcadc 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -166,8 +166,8 @@ void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
 struct device *bus_find_device(struct bus_type *bus, struct device *start,
-			       void *data,
-			       int (*match)(struct device *dev, void *data));
+			       const void *data,
+			       int (*match)(struct device *dev, const void *data));
 struct device *bus_find_device_by_name(struct bus_type *bus,
 				       struct device *start,
 				       const char *name);
diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 3d0cc6e..c04c9ed 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -405,7 +405,7 @@ static const struct dailink_match_data dailink_match[] = {
 	},
 };
 
-static int of_dev_node_match(struct device *dev, void *data)
+static int of_dev_node_match(struct device *dev, const void *data)
 {
 	return dev->of_node == data;
 }
-- 
2.7.4

