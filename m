Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF969C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F95E24FBD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfFCPvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:51:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53784 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbfFCPvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC5D31715;
        Mon,  3 Jun 2019 08:51:40 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DDC33F246;
        Mon,  3 Jun 2019 08:51:37 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        David Kershner <david.kershner@unisys.com>
Subject: [RFC PATCH 27/57] drivers: Unify the match prototype for bus_find_device with class_find_device
Date:   Mon,  3 Jun 2019 16:49:53 +0100
Message-Id: <1559577023-558-28-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have iterators for devices by bus and class, with a supplied
"match" function to do the comparison. However, both of the helper
function have slightly different prototype for the "match" argument.

 int (*) (struct device *dev, void *data)  // bus_find_device
  vs
 int (*) (struct device *dev, const void *data) // class_find_device

Unify the prototype by promoting the match function to use that of
the class_find_device(). This will allow us to share the generic
match helpers with class_find_device() users.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sebastian Ott <sebott@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: David Kershner <david.kershner@unisys.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/powerpc/platforms/pseries/ibmebus.c |  4 ++--
 drivers/acpi/acpi_lpss.c                 |  4 ++--
 drivers/acpi/sleep.c                     |  2 +-
 drivers/acpi/utils.c                     |  4 ++--
 drivers/base/bus.c                       |  2 +-
 drivers/base/core.c                      | 10 +++++-----
 drivers/base/platform.c                  |  2 +-
 drivers/char/ipmi/ipmi_si_platform.c     |  2 +-
 drivers/firmware/efi/dev-path-parser.c   |  4 ++--
 drivers/hwtracing/coresight/coresight.c  |  6 +++---
 drivers/i2c/i2c-core-acpi.c              |  2 +-
 drivers/i2c/i2c-core-of.c                |  2 +-
 drivers/iio/inkern.c                     |  2 +-
 drivers/net/ethernet/ti/cpsw-phy-sel.c   |  4 ++--
 drivers/net/ethernet/ti/davinci_emac.c   |  2 +-
 drivers/net/ethernet/toshiba/tc35815.c   |  4 ++--
 drivers/pci/probe.c                      |  2 +-
 drivers/pci/search.c                     |  4 ++--
 drivers/s390/cio/css.c                   |  4 ++--
 drivers/s390/cio/device.c                |  4 ++--
 drivers/s390/crypto/ap_bus.c             |  4 ++--
 drivers/scsi/scsi_proc.c                 |  2 +-
 drivers/thunderbolt/switch.c             |  4 ++--
 drivers/usb/core/usb.c                   |  4 ++--
 drivers/usb/phy/phy-am335x-control.c     |  4 ++--
 drivers/usb/phy/phy-isp1301.c            |  4 ++--
 drivers/visorbus/visorbus_main.c         |  4 ++--
 include/linux/device.h                   | 13 ++++++-------
 28 files changed, 54 insertions(+), 55 deletions(-)

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
index a34decc..fcf4386 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -454,7 +454,7 @@ static int acpi_pm_prepare(void)
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
index 229e83ee..abe32b6 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -324,7 +324,7 @@ EXPORT_SYMBOL_GPL(bus_for_each_dev);
  */
 struct device *bus_find_device(struct bus_type *bus,
 			       struct device *start, void *data,
-			       int (*match)(struct device *dev, void *data))
+			       int (*match)(struct device *dev, const void *data))
 {
 	struct klist_iter i;
 	struct device *dev;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 88fa037..731baac 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3329,31 +3329,31 @@ void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
 }
 EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
 
-int device_match_of_node(struct device *dev, void *np)
+int device_match_of_node(struct device *dev, const void *np)
 {
 	return dev->of_node == np;
 }
 EXPORT_SYMBOL_GPL(device_match_of_node);
 
-int device_match_acpi_dev(struct device *dev, void *adev)
+int device_match_acpi_dev(struct device *dev, const void *adev)
 {
 	return ACPI_COMPANION(dev) == adev;
 }
 EXPORT_SYMBOL(device_match_acpi_dev);
 
-int device_match_fwnode(struct device *dev, void *fwnode)
+int device_match_fwnode(struct device *dev, const void *fwnode)
 {
 	return dev_fwnode(dev) == fwnode;
 }
 EXPORT_SYMBOL_GPL(device_match_fwnode);
 
-int device_match_devt(struct device *dev, void *pdevt)
+int device_match_devt(struct device *dev, const void *pdevt)
 {
 	return dev->devt == *(dev_t *)pdevt;
 }
 EXPORT_SYMBOL_GPL(device_match_devt);
 
-int device_match_name(struct device *dev, void *name)
+int device_match_name(struct device *dev, const void *name)
 {
 	return sysfs_streq(dev_name(dev), name);
 }
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index daca44f..55ce86f 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1207,7 +1207,7 @@ struct device *platform_find_device_by_driver(struct device *start,
 					      const struct device_driver *drv)
 {
 	return bus_find_device(&platform_bus_type, start, (void *)drv,
-			       (int (*)(struct device *, void *))platform_match);
+			       (int (*)(struct device *, const void *))platform_match);
 }
 EXPORT_SYMBOL_GPL(platform_find_device_by_driver);
 
diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index ff82353..99233f3 100644
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
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 37ccd67..8231a0e 100644
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
diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index e28165b..cd6ff7a 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -318,7 +318,7 @@ u32 i2c_acpi_find_bus_speed(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(i2c_acpi_find_bus_speed);
 
-static int i2c_acpi_find_match_adapter(struct device *dev, void *data)
+static int i2c_acpi_find_match_adapter(struct device *dev, const void *data)
 {
 	struct i2c_adapter *adapter = i2c_verify_adapter(dev);
 
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index b0b3fe1..e7f84d8 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -112,7 +112,7 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
 	of_node_put(bus);
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
index aea5029..7b8488d 100644
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
+	const struct subchannel_id *schid = data;
 
 	sch = to_subchannel(dev);
 	return schid_equal(&sch->schid, schid);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 1540229..6ca9a3a 100644
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
+	const struct ccw_dev_id *dev_id = data;
 
 	return ccw_dev_id_is_equal(&cdev->private->dev_id, dev_id);
 }
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index b9fc502..e440682 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1365,7 +1365,7 @@ static int __match_card_device_with_id(struct device *dev, void *data)
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
index b4a9cd2..e8d1267 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -163,18 +163,17 @@ void subsys_dev_iter_init(struct subsys_dev_iter *iter,
 struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter);
 void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
 
-int device_match_of_node(struct device *dev, void *np);
-int device_match_acpi_dev(struct device *dev, void *adev);
-int device_match_fwnode(struct device *dev, void *fwnode);
-int device_match_devt(struct device *dev, void *pdevt);
-int device_match_name(struct device *dev, void *name);
+int device_match_of_node(struct device *dev, const void *np);
+int device_match_acpi_dev(struct device *dev, const void *adev);
+int device_match_fwnode(struct device *dev, const void *fwnode);
+int device_match_devt(struct device *dev, const void *pdevt);
+int device_match_name(struct device *dev, const void *name);
 
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
 struct device *bus_find_device(struct bus_type *bus, struct device *start,
 			       void *data,
-			       int (*match)(struct device *dev, void *data));
-
+			       int (*match)(struct device *dev, const void *data));
 /**
  * bus_find_device_by_name - device iterator for locating a particular device
  * of a specific name.
-- 
2.7.4

