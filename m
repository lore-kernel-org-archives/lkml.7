Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1997CCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E926321906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407718AbfJWVqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:46:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:39636 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407692AbfJWVq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:46:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="196908190"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 14:46:27 -0700
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
Subject: [PATCH 08/18] soundwire: intel: reset pm_runtime status during system resume
Date:   Wed, 23 Oct 2019 16:45:51 -0500
Message-Id: <20191023214601.883-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023214601.883-1-pierre-louis.bossart@linux.intel.com>
References: <20191023214601.883-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system resume does the entire bus re-initialization and brings it
to full-power. If the device was pm_runtime suspended, there is no
need to run the pm_runtime resume sequence after the system runtime.

Follow the documentation from runtime_pm.rst, and conditionally
disable, set_active and re-enable the device on system resume.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c     | 30 ++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 650581348732..c3cd7d2d5a34 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1298,6 +1298,7 @@ static int intel_master_remove(struct sdw_master_device *md)
 
 static int intel_suspend(struct device *dev)
 {
+	struct sdw_master_device *md = to_sdw_master_device(dev);
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	int ret;
@@ -1308,6 +1309,20 @@ static int intel_suspend(struct device *dev)
 		return 0;
 	}
 
+	if (pm_runtime_status_suspended(dev)) {
+		dev_dbg(dev,
+			"%s: pm_runtime status: suspended\n",
+			__func__);
+
+		/*
+		 * keep track of the state for the system resume, where
+		 * we will need to reset the pm_runtime status to active
+		 */
+		md->pm_runtime_suspended = true;
+
+		return 0;
+	}
+
 	ret = sdw_cdns_enable_interrupt(cdns, false);
 	if (ret < 0) {
 		dev_err(dev, "cannot disable interrupts on suspend\n");
@@ -1356,6 +1371,7 @@ static int intel_suspend_runtime(struct device *dev)
 
 static int intel_resume(struct device *dev)
 {
+	struct sdw_master_device *md = to_sdw_master_device(dev);
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	int ret;
@@ -1366,6 +1382,20 @@ static int intel_resume(struct device *dev)
 		return 0;
 	}
 
+	if (md->pm_runtime_suspended) {
+		dev_dbg(dev,
+			"%s: pm_runtime status was suspended, forcing active\n",
+			__func__);
+
+		/* follow required sequence from runtime_pm.rst */
+		pm_runtime_disable(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_enable(dev);
+
+		md->pm_runtime_suspended = false;
+	}
+
 	ret = intel_init(sdw);
 	if (ret) {
 		dev_err(dev, "%s failed: %d", __func__, ret);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index d756e41c9466..1950d2b467bd 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -577,6 +577,7 @@ struct sdw_master_device {
 	struct device dev;
 	int link_id;
 	struct sdw_md_driver *driver;
+	bool pm_runtime_suspended;
 	void *pdata; /* core does not touch */
 };
 
-- 
2.20.1

