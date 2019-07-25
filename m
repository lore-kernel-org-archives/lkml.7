Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B139DC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3AC22C7D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfGYXmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:42:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:51850 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfGYXl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874857"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:55 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 36/40] soundwire: intel: disable interrupts on suspend
Date:   Thu, 25 Jul 2019 18:40:28 -0500
Message-Id: <20190725234032.21152-37-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 42 +++++++++++++++++-------------
 drivers/soundwire/cadence_master.h |  2 +-
 drivers/soundwire/intel.c          |  6 +++--
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index f486fe15fb46..fa7230b0f200 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -814,33 +814,39 @@ EXPORT_SYMBOL(sdw_cdns_exit_reset);
  * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
  * @cdns: Cadence instance
  */
-int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
+int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
 {
 	u32 mask;
 
-	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
-		    CDNS_MCP_SLAVE_INTMASK0_MASK);
-	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
-		    CDNS_MCP_SLAVE_INTMASK1_MASK);
+	if (state) {
+		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
+			    CDNS_MCP_SLAVE_INTMASK0_MASK);
+		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
+			    CDNS_MCP_SLAVE_INTMASK1_MASK);
 
-	/* enable detection of slave state changes */
-	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
-		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
+		/* enable detection of slave state changes */
+		mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
+			CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
 
-	/* enable detection of bus issues */
-	mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
-		CDNS_MCP_INT_PARITY;
+		/* enable detection of bus issues */
+		mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
+			CDNS_MCP_INT_PARITY;
 
-	/* no detection of port interrupts for now */
+		/* no detection of port interrupts for now */
 
-	/* enable detection of RX fifo level */
-	mask |= CDNS_MCP_INT_RX_WL;
+		/* enable detection of RX fifo level */
+		mask |= CDNS_MCP_INT_RX_WL;
 
-	/* now enable all of the above */
-	mask |= CDNS_MCP_INT_IRQ;
+		/* now enable all of the above */
+		mask |= CDNS_MCP_INT_IRQ;
 
-	if (interrupt_mask) /* parameter override */
-		mask = interrupt_mask;
+		if (interrupt_mask) /* parameter override */
+			mask = interrupt_mask;
+	} else {
+		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0, 0);
+		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1, 0);
+		mask = 0;
+	}
 
 	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
 
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 2b551f9226f3..1a0ba36dd78f 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -162,7 +162,7 @@ int sdw_cdns_init(struct sdw_cdns *cdns);
 int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 		      struct sdw_cdns_stream_config config);
 int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
-int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
+int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state);
 
 void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
 
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 9ebe38e4d979..1192d5775484 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1110,7 +1110,7 @@ static int intel_probe(struct platform_device *pdev)
 		goto err_init;
 	}
 
-	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
+	ret = sdw_cdns_enable_interrupt(&sdw->cdns, true);
 
 	ret = sdw_cdns_exit_reset(&sdw->cdns);
 
@@ -1169,6 +1169,8 @@ static int intel_suspend(struct device *dev)
 		return 0;
 	}
 
+	sdw_cdns_enable_interrupt(&sdw->cdns, false);
+
 	ret = intel_link_power_down(sdw);
 	if (ret) {
 		dev_err(dev, "Link power down failed: %d", ret);
@@ -1199,7 +1201,7 @@ static int intel_resume(struct device *dev)
 		return ret;
 	}
 
-	sdw_cdns_enable_interrupt(&sdw->cdns);
+	sdw_cdns_enable_interrupt(&sdw->cdns, true);
 
 	ret = sdw_cdns_exit_reset(&sdw->cdns);
 
-- 
2.20.1

