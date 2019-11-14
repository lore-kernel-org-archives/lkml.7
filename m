Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6698EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497FC2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKNSRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:17:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:36355 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfKNSRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:17:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 10:17:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="195123499"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
  by orsmga007.jf.intel.com with ESMTP; 14 Nov 2019 10:17:49 -0800
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
Subject: [PATCH v3 12/22] soundwire: bus: fix race condition with enumeration_complete signaling
Date:   Thu, 14 Nov 2019 12:16:52 -0600
Message-Id: <20191114181702.22254-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
References: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the signaling needed for Slave drivers to wait until
the enumeration completes so that race conditions when issuing
read/write commands are avoided. The calls for wait_for_completion()
will be added in codec drivers in follow-up patches.

The order between init_completion() and complete() is deterministic,
the Slave is marked as UNATTACHED either during a Master-initiated
HardReset, or when the hardware detects the Slave no longer reports as
ATTACHED.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c   | 19 +++++++++++++++++++
 drivers/soundwire/slave.c |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 9f03a915a09a..e34b5ed534b3 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -637,6 +637,25 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 				    enum sdw_slave_status status)
 {
 	mutex_lock(&slave->bus->bus_lock);
+
+	dev_vdbg(&slave->dev,
+		 "%s: changing status slave %d status %d new status %d\n",
+		 __func__, slave->dev_num, slave->status, status);
+
+	if (status == SDW_SLAVE_UNATTACHED) {
+		dev_dbg(&slave->dev,
+			"%s: initializing completion for Slave %d\n",
+			__func__, slave->dev_num);
+
+		init_completion(&slave->enumeration_complete);
+
+	} else if (status == SDW_SLAVE_ATTACHED) {
+		dev_dbg(&slave->dev,
+			"%s: signaling completion for Slave %d\n",
+			__func__, slave->dev_num);
+
+		complete(&slave->enumeration_complete);
+	}
 	slave->status = status;
 	mutex_unlock(&slave->bus->bus_lock);
 }
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 15ac89ecae01..76fdfbd8b50d 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -52,6 +52,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	slave->dev.type = &sdw_slave_type;
 	slave->bus = bus;
 	slave->status = SDW_SLAVE_UNATTACHED;
+	init_completion(&slave->enumeration_complete);
 	slave->dev_num = 0;
 	init_completion(&slave->probe_complete);
 	slave->probed = false;
-- 
2.20.1

