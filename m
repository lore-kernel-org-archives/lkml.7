Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B9BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C927D20729
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKNSR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:17:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:36355 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbfKNSRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:17:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 10:17:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="195123523"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
  by orsmga007.jf.intel.com with ESMTP; 14 Nov 2019 10:17:52 -0800
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
Subject: [PATCH v3 14/22] soundwire: bus: fix race condition by tracking UNATTACHED transition
Date:   Thu, 14 Nov 2019 12:16:54 -0600
Message-Id: <20191114181702.22254-15-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
References: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous patches, we added enumeration_ and initialization_complete
fields to avoid race conditions. When streaming restarts, the Master
first resumes, then requests all Slaves to renumerate/reinitialized,
and then the Slave devices resume.

Intel validation exposed a corner case where the Slave device may
transition to D3 when streaming stops, but streaming restarts before
the Master transitions to D3. In that case, the Slave status was not
cleared as UNATTACHED, and the wait_for_completion will time out.

The proposed solution is that when the Master clears the Slave(s)
status, the reason for the Slave(s) becoming unattached is
memorized. When the slave resumes, it can check if a Master-initiated
re-enumeration and initialization takes place and skip the
wait_for_completion() if there is no reason to wait.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c   |  5 ++++-
 drivers/soundwire/bus.h   |  8 +++++++-
 drivers/soundwire/intel.c | 16 ++++++++++++----
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 329f35a40649..ddc3042e15e0 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1154,7 +1154,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 }
 EXPORT_SYMBOL(sdw_handle_slave_status);
 
-void sdw_clear_slave_status(struct sdw_bus *bus)
+void sdw_clear_slave_status(struct sdw_bus *bus, u32 request)
 {
 	struct sdw_slave *slave;
 	int i;
@@ -1174,6 +1174,9 @@ void sdw_clear_slave_status(struct sdw_bus *bus)
 
 		if (slave->status != SDW_SLAVE_UNATTACHED)
 			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
+
+		/* keep track of request, used in pm_runtime resume */
+		slave->unattach_request = request;
 	}
 }
 EXPORT_SYMBOL(sdw_clear_slave_status);
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 4e6fb5d2f5cc..ee362472003a 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -167,6 +167,12 @@ sdw_update(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
 	return sdw_write(slave, addr, tmp);
 }
 
-void sdw_clear_slave_status(struct sdw_bus *bus);
+/*
+ * At the moment we only track Master-initiated hw_reset.
+ * Additional fields can be added as needed
+ */
+#define SDW_UNATTACH_REQUEST_MASTER_RESET	BIT(0)
+
+void sdw_clear_slave_status(struct sdw_bus *bus, u32 request);
 
 #endif /* __SDW_BUS_H */
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index e3741c3afe1c..69b0c8f65ad8 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1402,8 +1402,12 @@ static int intel_resume(struct device *dev)
 		return ret;
 	}
 
-	/* make sure all Slaves are tagged as UNATTACHED */
-	sdw_clear_slave_status(&sdw->cdns.bus);
+	/*
+	 * make sure all Slaves are tagged as UNATTACHED and provide
+	 * reason for reinitialization
+	 */
+	sdw_clear_slave_status(&sdw->cdns.bus,
+			       SDW_UNATTACH_REQUEST_MASTER_RESET);
 
 	ret = sdw_cdns_enable_interrupt(cdns, true);
 	if (ret < 0) {
@@ -1438,8 +1442,12 @@ static int intel_resume_runtime(struct device *dev)
 		return ret;
 	}
 
-	/* make sure all Slaves are tagged as UNATTACHED */
-	sdw_clear_slave_status(&sdw->cdns.bus);
+	/*
+	 * make sure all Slaves are tagged as UNATTACHED and provide
+	 * reason for reinitialization
+	 */
+	sdw_clear_slave_status(&sdw->cdns.bus,
+			       SDW_UNATTACH_REQUEST_MASTER_RESET);
 
 	ret = sdw_cdns_enable_interrupt(cdns, true);
 	if (ret < 0) {
-- 
2.20.1

