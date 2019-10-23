Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6417FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4231B21906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392569AbfJWV2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:28:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:24145 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733169AbfJWV2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:28:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="399541156"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2019 14:28:36 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 01/14] soundwire: renames to prepare support for master drivers/devices
Date:   Wed, 23 Oct 2019 16:28:10 -0500
Message-Id: <20191023212823.608-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clearer references to sdw_slave_driver for internal macros

No change for sdw_driver and module_sdw_driver to avoid compatibility
issues with existing codec devices

No functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus_type.c       | 21 +++++++++++----------
 include/linux/soundwire/sdw_type.h | 18 ++++++++++--------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 4a465f55039f..370b94752662 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -34,7 +34,7 @@ sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
 static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-	struct sdw_driver *drv = drv_to_sdw_driver(ddrv);
+	struct sdw_driver *drv = drv_to_sdw_slave_driver(ddrv);
 
 	return !!sdw_get_device_id(slave, drv);
 }
@@ -70,7 +70,7 @@ EXPORT_SYMBOL_GPL(sdw_bus_type);
 static int sdw_drv_probe(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
+	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
 	const struct sdw_device_id *id;
 	int ret;
 
@@ -116,7 +116,7 @@ static int sdw_drv_probe(struct device *dev)
 static int sdw_drv_remove(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
+	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
 	int ret = 0;
 
 	if (drv->remove)
@@ -130,20 +130,21 @@ static int sdw_drv_remove(struct device *dev)
 static void sdw_drv_shutdown(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
+	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
 
 	if (drv->shutdown)
 		drv->shutdown(slave);
 }
 
 /**
- * __sdw_register_driver() - register a SoundWire Slave driver
+ * __sdw_register_slave_driver() - register a SoundWire Slave driver
  * @drv: driver to register
  * @owner: owning module/driver
  *
  * Return: zero on success, else a negative error code.
  */
-int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
+int __sdw_register_slave_driver(struct sdw_driver *drv,
+				struct module *owner)
 {
 	drv->driver.bus = &sdw_bus_type;
 
@@ -164,17 +165,17 @@ int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
 
 	return driver_register(&drv->driver);
 }
-EXPORT_SYMBOL_GPL(__sdw_register_driver);
+EXPORT_SYMBOL_GPL(__sdw_register_slave_driver);
 
 /**
- * sdw_unregister_driver() - unregisters the SoundWire Slave driver
+ * sdw_unregister_slave_driver() - unregisters the SoundWire Slave driver
  * @drv: driver to unregister
  */
-void sdw_unregister_driver(struct sdw_driver *drv)
+void sdw_unregister_slave_driver(struct sdw_driver *drv)
 {
 	driver_unregister(&drv->driver);
 }
-EXPORT_SYMBOL_GPL(sdw_unregister_driver);
+EXPORT_SYMBOL_GPL(sdw_unregister_slave_driver);
 
 static int __init sdw_bus_init(void)
 {
diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index aaa7f4267c14..abaa21278152 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -6,13 +6,15 @@
 
 extern struct bus_type sdw_bus_type;
 
-#define drv_to_sdw_driver(_drv) container_of(_drv, struct sdw_driver, driver)
+#define drv_to_sdw_slave_driver(_drv) \
+	container_of(_drv, struct sdw_driver, driver)
 
-#define sdw_register_driver(drv) \
-	__sdw_register_driver(drv, THIS_MODULE)
+#define sdw_register_slave_driver(drv) \
+	__sdw_register_slave_driver(drv, THIS_MODULE)
 
-int __sdw_register_driver(struct sdw_driver *drv, struct module *owner);
-void sdw_unregister_driver(struct sdw_driver *drv);
+int __sdw_register_slave_driver(struct sdw_driver *drv,
+				struct module *owner);
+void sdw_unregister_slave_driver(struct sdw_driver *drv);
 
 int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
 
@@ -24,7 +26,7 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
  * module init/exit. This eliminates a lot of boilerplate. Each module may only
  * use this macro once, and calling it replaces module_init() and module_exit()
  */
-#define module_sdw_driver(__sdw_driver) \
-	module_driver(__sdw_driver, sdw_register_driver, \
-			sdw_unregister_driver)
+#define module_sdw_driver(__sdw_slave_driver) \
+	module_driver(__sdw_slave_driver, sdw_register_slave_driver, \
+			sdw_unregister_slave_driver)
 #endif /* __SOUNDWIRE_TYPES_H */
-- 
2.20.1

