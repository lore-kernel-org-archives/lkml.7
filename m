Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54510C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3025E20862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbfEVTtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:49:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:47986 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731090AbfEVTrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:47:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 12:47:51 -0700
X-ExtLoop1: 1
Received: from cjpowell-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.154.39])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2019 12:47:50 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v2 03/15] soundwire: add port-related definitions
Date:   Wed, 22 May 2019 14:47:19 -0500
Message-Id: <20190522194732.25704-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow previous header files did not include definition for
sink/source, flow and grouping.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 53 +++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 35662d9c2c62..69ae680a5a21 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -41,6 +41,31 @@ struct sdw_slave;
 #define SDW_DAI_ID_RANGE_START		100
 #define SDW_DAI_ID_RANGE_END		200
 
+enum {
+	SDW_PORT_DIRN_SINK = 0,
+	SDW_PORT_DIRN_SOURCE,
+	SDW_PORT_DIRN_MAX,
+};
+
+/*
+ * constants for flow control, ports and transport
+ *
+ * these are bit masks as devices can have multiple capabilities
+ */
+
+/*
+ * flow modes for SDW port. These can be isochronous, tx controlled,
+ * rx controlled or async
+ */
+#define SDW_PORT_FLOW_MODE_ISOCH	0
+#define SDW_PORT_FLOW_MODE_TX_CNTRL	BIT(0)
+#define SDW_PORT_FLOW_MODE_RX_CNTRL	BIT(1)
+#define SDW_PORT_FLOW_MODE_ASYNC	GENMASK(1, 0)
+
+/* sample packaging for block. It can be per port or per channel */
+#define SDW_BLOCK_PACKG_PER_PORT	BIT(0)
+#define SDW_BLOCK_PACKG_PER_CH		BIT(1)
+
 /**
  * enum sdw_slave_status - Slave status
  * @SDW_SLAVE_UNATTACHED: Slave is not attached with the bus.
@@ -76,6 +101,14 @@ enum sdw_command_response {
 	SDW_CMD_FAIL_OTHER = 4,
 };
 
+/* block group count enum */
+enum sdw_dpn_grouping {
+	SDW_BLK_GRP_CNT_1 = 0,
+	SDW_BLK_GRP_CNT_2 = 1,
+	SDW_BLK_GRP_CNT_3 = 2,
+	SDW_BLK_GRP_CNT_4 = 3,
+};
+
 /**
  * enum sdw_stream_type: data stream type
  *
@@ -100,6 +133,26 @@ enum sdw_data_direction {
 	SDW_DATA_DIR_TX = 1,
 };
 
+/**
+ * enum sdw_port_data_mode: Data Port mode
+ *
+ * @SDW_PORT_DATA_MODE_NORMAL: Normal data mode where audio data is received
+ * and transmitted.
+ * @SDW_PORT_DATA_MODE_STATIC_1: Simple test mode which uses static value of
+ * logic 1. The encoding will result in signal transitions at every bitslot
+ * owned by this Port
+ * @SDW_PORT_DATA_MODE_STATIC_0: Simple test mode which uses static value of
+ * logic 0. The encoding will result in no signal transitions
+ * @SDW_PORT_DATA_MODE_PRBS: Test mode which uses a PRBS generator to produce
+ * a pseudo random data pattern that is transferred
+ */
+enum sdw_port_data_mode {
+	SDW_PORT_DATA_MODE_NORMAL = 0,
+	SDW_PORT_DATA_MODE_STATIC_1 = 1,
+	SDW_PORT_DATA_MODE_STATIC_0 = 2,
+	SDW_PORT_DATA_MODE_PRBS = 3,
+};
+
 /*
  * SDW properties, defined in MIPI DisCo spec v1.0
  */
-- 
2.20.1

