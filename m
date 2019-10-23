Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6079CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979B12084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392582AbfJWV2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:28:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:24157 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392559AbfJWV2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:28:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="399541162"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2019 14:28:38 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 02/14] soundwire: rename dev_to_sdw_dev macro
Date:   Wed, 23 Oct 2019 16:28:11 -0500
Message-Id: <20191023212823.608-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we want to introduce master devices, rename macro so that we
have consistency between slave and master device access, following the
Grey Bus example.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/regmap/regmap-sdw.c |  4 ++--
 drivers/soundwire/bus.c          |  2 +-
 drivers/soundwire/bus_type.c     | 11 ++++++-----
 drivers/soundwire/slave.c        |  2 +-
 include/linux/soundwire/sdw.h    |  3 ++-
 5 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index 50a66382d87d..d1fc0c22180a 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -10,7 +10,7 @@
 static int regmap_sdw_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct device *dev = context;
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_slave *slave = to_sdw_slave_device(dev);
 
 	return sdw_write(slave, reg, val);
 }
@@ -18,7 +18,7 @@ static int regmap_sdw_write(void *context, unsigned int reg, unsigned int val)
 static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct device *dev = context;
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_slave *slave = to_sdw_slave_device(dev);
 	int read;
 
 	read = sdw_read(slave, reg);
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index be5d437058ed..4b22ee996a65 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -110,7 +110,7 @@ EXPORT_SYMBOL(sdw_add_bus_master);
 
 static int sdw_delete_slave(struct device *dev, void *data)
 {
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_slave *slave = to_sdw_slave_device(dev);
 	struct sdw_bus *bus = slave->bus;
 
 	sdw_slave_debugfs_exit(slave);
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 370b94752662..c0585bcc8a41 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -33,7 +33,7 @@ sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
 
 static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
 {
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_slave *slave = to_sdw_slave_device(dev);
 	struct sdw_driver *drv = drv_to_sdw_slave_driver(ddrv);
 
 	return !!sdw_get_device_id(slave, drv);
@@ -49,7 +49,7 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
 
 static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_slave *slave = to_sdw_slave_device(dev);
 	char modalias[32];
 
 	sdw_slave_modalias(slave, modalias, sizeof(modalias));
@@ -69,7 +69,7 @@ EXPORT_SYMBOL_GPL(sdw_bus_type);
 
 static int sdw_drv_probe(struct device *dev)
 {
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_slave *slave = to_sdw_slave_device(dev);
 	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
 	const struct sdw_device_id *id;
 	int ret;
@@ -115,8 +115,9 @@ static int sdw_drv_probe(struct device *dev)
 
 static int sdw_drv_remove(struct device *dev)
 {
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_slave *slave = to_sdw_slave_device(dev);
 	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
+
 	int ret = 0;
 
 	if (drv->remove)
@@ -129,7 +130,7 @@ static int sdw_drv_remove(struct device *dev)
 
 static void sdw_drv_shutdown(struct device *dev)
 {
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_slave *slave = to_sdw_slave_device(dev);
 	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
 
 	if (drv->shutdown)
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 19919975bb6d..48a513680db6 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -9,7 +9,7 @@
 
 static void sdw_slave_release(struct device *dev)
 {
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_slave *slave = to_sdw_slave_device(dev);
 
 	kfree(slave);
 }
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 0c4e59dfaca3..d6e5a0e42819 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -570,7 +570,8 @@ struct sdw_slave {
 	struct completion enumeration_complete;
 };
 
-#define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
+#define to_sdw_slave_device(d) \
+	container_of(d, struct sdw_slave, dev)
 
 struct sdw_driver {
 	const char *name;
-- 
2.20.1

