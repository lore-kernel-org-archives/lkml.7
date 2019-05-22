Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD4CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EA820856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbfEVTs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:48:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:47986 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387938AbfEVTsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:48:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 12:48:02 -0700
X-ExtLoop1: 1
Received: from cjpowell-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.154.39])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2019 12:48:00 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v2 10/15] soundwire: cadence_master: use rate_limited dynamic debug
Date:   Wed, 22 May 2019 14:47:26 -0500
Message-Id: <20190522194732.25704-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When commands start failing, e.g. due to a bad electrical connection
or bus conflicts, the dmesg log is flooded. This should not happen for
production devices but it's quite frequent when bringing-up a new
platform.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 682789bb8ab3..6f4184f5256c 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -236,19 +236,19 @@ cdns_fill_msg_resp(struct sdw_cdns *cdns,
 	for (i = 0; i < count; i++) {
 		if (!(cdns->response_buf[i] & CDNS_MCP_RESP_ACK)) {
 			no_ack = 1;
-			dev_dbg(cdns->dev, "Msg Ack not received\n");
+			dev_dbg_ratelimited(cdns->dev, "Msg Ack not received\n");
 			if (cdns->response_buf[i] & CDNS_MCP_RESP_NACK) {
 				nack = 1;
-				dev_err(cdns->dev, "Msg NACK received\n");
+				dev_err_ratelimited(cdns->dev, "Msg NACK received\n");
 			}
 		}
 	}
 
 	if (nack) {
-		dev_err(cdns->dev, "Msg NACKed for Slave %d\n", msg->dev_num);
+		dev_err_ratelimited(cdns->dev, "Msg NACKed for Slave %d\n", msg->dev_num);
 		return SDW_CMD_FAIL;
 	} else if (no_ack) {
-		dev_dbg(cdns->dev, "Msg ignored for Slave %d\n", msg->dev_num);
+		dev_dbg_ratelimited(cdns->dev, "Msg ignored for Slave %d\n", msg->dev_num);
 		return SDW_CMD_IGNORED;
 	}
 
@@ -356,12 +356,12 @@ cdns_program_scp_addr(struct sdw_cdns *cdns, struct sdw_msg *msg)
 
 	/* For NACK, NO ack, don't return err if we are in Broadcast mode */
 	if (nack) {
-		dev_err(cdns->dev,
-			"SCP_addrpage NACKed for Slave %d\n", msg->dev_num);
+		dev_err_ratelimited(cdns->dev,
+				    "SCP_addrpage NACKed for Slave %d\n", msg->dev_num);
 		return SDW_CMD_FAIL;
 	} else if (no_ack) {
-		dev_dbg(cdns->dev,
-			"SCP_addrpage ignored for Slave %d\n", msg->dev_num);
+		dev_dbg_ratelimited(cdns->dev,
+				    "SCP_addrpage ignored for Slave %d\n", msg->dev_num);
 		return SDW_CMD_IGNORED;
 	}
 
@@ -524,9 +524,9 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 
 		/* first check if Slave reported multiple status */
 		if (set_status > 1) {
-			dev_warn(cdns->dev,
-				 "Slave reported multiple Status: %d\n",
-				 status[i]);
+			dev_warn_ratelimited(cdns->dev,
+					     "Slave reported multiple Status: %d\n",
+					     status[i]);
 			/*
 			 * TODO: we need to reread the status here by
 			 * issuing a PING cmd
@@ -612,7 +612,7 @@ irqreturn_t sdw_cdns_thread(int irq, void *dev_id)
 	struct sdw_cdns *cdns = dev_id;
 	u32 slave0, slave1;
 
-	dev_dbg(cdns->dev, "Slave status change\n");
+	dev_dbg_ratelimited(cdns->dev, "Slave status change\n");
 
 	slave0 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT0);
 	slave1 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT1);
-- 
2.20.1

