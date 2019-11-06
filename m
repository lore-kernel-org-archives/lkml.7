Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5972C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931CA2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbfKFTWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:22:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:50594 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729435AbfKFTWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:22:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:22:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="403835074"
Received: from vidhipat-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.33.70])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2019 11:22:31 -0800
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
Subject: [PATCH v2 02/19] soundwire: fix race between driver probe and update_status callback
Date:   Wed,  6 Nov 2019 13:22:06 -0600
Message-Id: <20191106192223.6003-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106192223.6003-1-pierre-louis.bossart@linux.intel.com>
References: <20191106192223.6003-1-pierre-louis.bossart@linux.intel.com>
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

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c      | 24 +++++++++++++++++++++---
 drivers/soundwire/bus.h      |  1 +
 drivers/soundwire/bus_type.c |  5 +++++
 drivers/soundwire/slave.c    |  2 ++
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 4b22ee996a65..903aee258800 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -961,10 +961,28 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 static int sdw_update_slave_status(struct sdw_slave *slave,
 				   enum sdw_slave_status status)
 {
-	if (slave->ops && slave->ops->update_status)
-		return slave->ops->update_status(slave, status);
+	unsigned long time;
 
-	return 0;
+	if (!slave->ops || !slave->ops->update_status)
+		return 0;
+
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
+	return slave->ops->update_status(slave, status);
 }
 
 /**
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index cb482da914da..acb8d11a4c84 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -5,6 +5,7 @@
 #define __SDW_BUS_H
 
 #define DEFAULT_BANK_SWITCH_TIMEOUT 3000
+#define DEFAULT_PROBE_TIMEOUT       2000
 
 #if IS_ENABLED(CONFIG_ACPI)
 int sdw_acpi_find_slaves(struct sdw_bus *bus);
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index fd234f63bf2f..ac484384bd6e 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -118,6 +118,11 @@ static int sdw_slave_drv_probe(struct device *dev)
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
index c87267f12a3b..81b94cd3985e 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -52,6 +52,8 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	slave->bus = bus;
 	slave->status = SDW_SLAVE_UNATTACHED;
 	slave->dev_num = 0;
+	init_completion(&slave->probe_complete);
+	slave->probed = false;
 
 	mutex_lock(&bus->bus_lock);
 	list_add_tail(&slave->node, &bus->slaves);
-- 
2.20.1

