Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20453C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17A52067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbfKFTWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:22:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:50613 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732392AbfKFTWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:22:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:22:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="403835150"
Received: from vidhipat-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.33.70])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2019 11:22:47 -0800
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
Subject: [PATCH v2 13/19] soundwire: bus: add initialization_complete signaling
Date:   Wed,  6 Nov 2019 13:22:17 -0600
Message-Id: <20191106192223.6003-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106192223.6003-1-pierre-louis.bossart@linux.intel.com>
References: <20191106192223.6003-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_completion() is called when the Slave device becomes unattached,
as done with enumeration_complete.

The difference with the enumeration_complete case is that complete()
is signaled when the Slave device is fully initialized after the
.update_status() callback is called.

A Slave device driver can decide to wait on either of the two
complete() cases, depending on its initialization code and
requirements.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c   | 8 ++++++++
 drivers/soundwire/slave.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index b18110726273..93856747b934 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -648,6 +648,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 			__func__, slave->dev_num);
 
 		init_completion(&slave->enumeration_complete);
+		init_completion(&slave->initialization_complete);
 
 	} else if (status == SDW_SLAVE_ATTACHED) {
 		dev_dbg(&slave->dev,
@@ -1050,6 +1051,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 {
 	enum sdw_slave_status prev_status;
 	struct sdw_slave *slave;
+	bool attached_initializing;
 	int i, ret = 0;
 
 	/* first check if any Slaves fell off the bus */
@@ -1095,6 +1097,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		if (!slave)
 			continue;
 
+		attached_initializing = false;
+
 		switch (status[i]) {
 		case SDW_SLAVE_UNATTACHED:
 			if (slave->status == SDW_SLAVE_UNATTACHED)
@@ -1121,6 +1125,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 			if (prev_status == SDW_SLAVE_ALERT)
 				break;
 
+			attached_initializing = true;
+
 			ret = sdw_initialize_slave(slave);
 			if (ret)
 				dev_err(bus->dev,
@@ -1139,6 +1145,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		if (ret)
 			dev_err(slave->bus->dev,
 				"Update Slave status failed:%d\n", ret);
+		if (attached_initializing)
+			complete(&slave->initialization_complete);
 	}
 
 	return ret;
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 5c6c744e0713..543f4ddd9de0 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -52,6 +52,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	slave->bus = bus;
 	slave->status = SDW_SLAVE_UNATTACHED;
 	init_completion(&slave->enumeration_complete);
+	init_completion(&slave->initialization_complete);
 	slave->dev_num = 0;
 	init_completion(&slave->probe_complete);
 	slave->probed = false;
-- 
2.20.1

