Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB8C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5996B2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfKNSVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:21:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:36344 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfKNSRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:17:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 10:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="195123378"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
  by orsmga007.jf.intel.com with ESMTP; 14 Nov 2019 10:17:30 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v3 02/22] soundwire: bus: fix race condition with probe_complete signaling
Date:   Thu, 14 Nov 2019 12:16:42 -0600
Message-Id: <20191114181702.22254-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
References: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver probe takes care of basic initialization and is invoked
when a Slave becomes attached, after a match between the Slave DevID
registers and ACPI/DT entries.

The update_status callback is invoked when a Slave state changes,
e.g. when it is assigned a non-zero Device Number and it reports with
an ATTACHED/ALERT state.

The state change detection is usually hardware-based and based on the
SoundWire frame rate (e.g. double-digit microseconds) while the probe
is a pure software operation, which may involve a kernel module
load. In corner cases, it's possible that the state changes before the
probe completes.

This patch suggests the use of wait_for_completion to avoid races on
startup, so that the update_status callback does not rely on invalid
pointers/data structures.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c      | 25 ++++++++++++++++++++++---
 drivers/soundwire/bus.h      |  1 +
 drivers/soundwire/bus_type.c |  5 +++++
 drivers/soundwire/slave.c    |  2 ++
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 4b22ee996a65..d99acbc614c6 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -961,10 +961,29 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 static int sdw_update_slave_status(struct sdw_slave *slave,
 				   enum sdw_slave_status status)
 {
-	if (slave->ops && slave->ops->update_status)
-		return slave->ops->update_status(slave, status);
+	unsigned long time;
 
-	return 0;
+	if (!slave->probed) {
+		/*
+		 * the slave status update is typically handled in an
+		 * interrupt thread, which can race with the driver
+		 * probe, e.g. when a module needs to be loaded.
+		 *
+		 * make sure the probe is complete before updating
+		 * status.
+		 */
+		time = wait_for_completion_timeout(&slave->probe_complete,
+				msecs_to_jiffies(DEFAULT_PROBE_TIMEOUT));
+		if (!time) {
+			dev_err(&slave->dev, "Probe not complete, timed out\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	if (!slave->ops || !slave->ops->update_status)
+		return 0;
+
+	return slave->ops->update_status(slave, status);
 }
 
 /**
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index be01a5f3d00b..93e7bbab0938 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -5,6 +5,7 @@
 #define __SDW_BUS_H
 
 #define DEFAULT_BANK_SWITCH_TIMEOUT 3000
+#define DEFAULT_PROBE_TIMEOUT       2000
 
 int sdw_uevent(struct device *dev, struct kobj_uevent_env *env);
 
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index df1271f6db61..c9dbc98ac028 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -120,6 +120,11 @@ static int sdw_slave_drv_probe(struct device *dev)
 	slave->bus->clk_stop_timeout = max_t(u32, slave->bus->clk_stop_timeout,
 					     slave->prop.clk_stop_timeout);
 
+	slave->probed = true;
+	complete(&slave->probe_complete);
+
+	dev_dbg(dev, "probe complete\n");
+
 	return 0;
 }
 
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 014c3ece1f17..15ac89ecae01 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -53,6 +53,8 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	slave->bus = bus;
 	slave->status = SDW_SLAVE_UNATTACHED;
 	slave->dev_num = 0;
+	init_completion(&slave->probe_complete);
+	slave->probed = false;
 
 	mutex_lock(&bus->bus_lock);
 	list_add_tail(&slave->node, &bus->slaves);
-- 
2.20.1

