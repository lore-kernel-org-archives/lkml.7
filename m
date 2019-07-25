Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7C7C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0AE229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfGYXl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:41:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:51850 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfGYXlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874850"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:53 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 35/40] soundwire: intel: export helper to exit reset
Date:   Thu, 25 Jul 2019 18:40:27 -0500
Message-Id: <20190725234032.21152-36-pierre-louis.bossart@linux.intel.com>
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
 drivers/soundwire/cadence_master.c | 9 +++++++--
 drivers/soundwire/cadence_master.h | 1 +
 drivers/soundwire/intel.c          | 4 ++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 4a189e487830..f486fe15fb46 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -780,7 +780,11 @@ EXPORT_SYMBOL(sdw_cdns_thread);
  * init routines
  */
 
-static int do_reset(struct sdw_cdns *cdns)
+/**
+ * sdw_cdns_exit_reset() - Program reset parameters and start bus operations
+ * @cdns: Cadence instance
+ */
+int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
 {
 	int ret;
 
@@ -804,6 +808,7 @@ static int do_reset(struct sdw_cdns *cdns)
 
 	return ret;
 }
+EXPORT_SYMBOL(sdw_cdns_exit_reset);
 
 /**
  * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
@@ -839,7 +844,7 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 
 	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
 
-	return do_reset(cdns);
+	return 0;
 }
 EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
 
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index de97bc22acb7..2b551f9226f3 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -161,6 +161,7 @@ irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
 int sdw_cdns_init(struct sdw_cdns *cdns);
 int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 		      struct sdw_cdns_stream_config config);
+int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
 
 void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index a976480d6f36..9ebe38e4d979 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1112,6 +1112,8 @@ static int intel_probe(struct platform_device *pdev)
 
 	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
 
+	ret = sdw_cdns_exit_reset(&sdw->cdns);
+
 	/* Register DAIs */
 	ret = intel_register_dai(sdw);
 	if (ret) {
@@ -1199,6 +1201,8 @@ static int intel_resume(struct device *dev)
 
 	sdw_cdns_enable_interrupt(&sdw->cdns);
 
+	ret = sdw_cdns_exit_reset(&sdw->cdns);
+
 	return ret;
 }
 
-- 
2.20.1

