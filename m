Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC14C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC1C206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfLQVDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:03:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:15620 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbfLQVD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:03:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 13:03:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="240560973"
Received: from smcdonal-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.83.42])
  by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2019 13:03:26 -0800
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
Subject: [PATCH v5 06/17] soundwire: add support for sdw_slave_type
Date:   Tue, 17 Dec 2019 15:03:03 -0600
Message-Id: <20191217210314.20410-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the existing SoundWire code, the bus does not have any explicit
representation for Master Devices - only SoundWire Slaves are exposed.

In SoundWire, the Master Device provides the clock, synchronization
information and command/control channels. When multiple links are
supported, a Controller may expose more than one Master Device; they
are typically embedded inside a larger audio cluster (be it in an
SOC/chipset or an external audio codec), and we need to describe it
using the Linux device and driver model.  This will allow for
configuration functions to account for external dependencies such as
power rails, clock sources or wake-up mechanisms. This transition will
also allow for better sysfs support without the reference count issues
mentioned in the initial reviews.

In this patch, we first convert the existing code to use an explicit
sdw_slave_type and add error checks if this type is not set.

In follow-up patches we can add support for the sdw_master_type.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus_type.c       | 23 ++++++++++++++++++-----
 drivers/soundwire/slave.c          |  7 ++++++-
 include/linux/soundwire/sdw_type.h |  6 ++++++
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 9a0fd3ee1014..9719680a1e48 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -49,13 +49,26 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
 
 static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	struct sdw_slave *slave = to_sdw_slave_device(dev);
+	struct sdw_slave *slave;
 	char modalias[32];
 
-	sdw_slave_modalias(slave, modalias, sizeof(modalias));
-
-	if (add_uevent_var(env, "MODALIAS=%s", modalias))
-		return -ENOMEM;
+	if (is_sdw_slave(dev)) {
+		slave = to_sdw_slave_device(dev);
+
+		sdw_slave_modalias(slave, modalias, sizeof(modalias));
+
+		if (add_uevent_var(env, "MODALIAS=%s", modalias))
+			return -ENOMEM;
+	} else {
+		/*
+		 * We only need to handle uevents for the Slave device
+		 * type. This error cannot happen unless the .uevent
+		 * callback is set to use this function for a
+		 * different device type (e.g. Master or Monitor)
+		 */
+		dev_err(dev, "uevent for unknown Soundwire type\n");
+		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 48a513680db6..c87267f12a3b 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -14,6 +14,11 @@ static void sdw_slave_release(struct device *dev)
 	kfree(slave);
 }
 
+struct device_type sdw_slave_type = {
+	.name =		"sdw_slave",
+	.release =	sdw_slave_release,
+};
+
 static int sdw_slave_add(struct sdw_bus *bus,
 			 struct sdw_slave_id *id, struct fwnode_handle *fwnode)
 {
@@ -41,9 +46,9 @@ static int sdw_slave_add(struct sdw_bus *bus,
 			     id->class_id, id->unique_id);
 	}
 
-	slave->dev.release = sdw_slave_release;
 	slave->dev.bus = &sdw_bus_type;
 	slave->dev.of_node = of_node_get(to_of_node(fwnode));
+	slave->dev.type = &sdw_slave_type;
 	slave->bus = bus;
 	slave->status = SDW_SLAVE_UNATTACHED;
 	slave->dev_num = 0;
diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index 7d4bc6a979bf..c681b3426478 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -5,6 +5,12 @@
 #define __SOUNDWIRE_TYPES_H
 
 extern struct bus_type sdw_bus_type;
+extern struct device_type sdw_slave_type;
+
+static inline int is_sdw_slave(const struct device *dev)
+{
+	return dev->type == &sdw_slave_type;
+}
 
 #define to_sdw_slave_driver(_drv) \
 	container_of(_drv, struct sdw_driver, driver)
-- 
2.20.1

