Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071F2C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92B72077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfGYXlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:41:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:51850 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfGYXlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874833"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:50 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 33/40] soundwire: intel: Add basic power management support
Date:   Thu, 25 Jul 2019 18:40:25 -0500
Message-Id: <20190725234032.21152-34-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement suspend/resume capabilities (not runtime_pm for now)

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 102 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 215dc81cdf73..1477c35f616f 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <sound/pcm_params.h>
+#include <linux/pm_runtime.h>
 #include <sound/soc.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
@@ -278,6 +279,35 @@ static void intel_debugfs_exit(struct sdw_intel *sdw)
 /*
  * shim ops
  */
+static int intel_link_power_down(struct sdw_intel *sdw)
+{
+	int link_control, spa_mask, cpa_mask, ret;
+	unsigned int link_id = sdw->instance;
+	void __iomem *shim = sdw->res->shim;
+	u16 ioctl;
+
+	/* Glue logic */
+	ioctl = intel_readw(shim, SDW_SHIM_IOCTL(link_id));
+	ioctl |= SDW_SHIM_IOCTL_BKE;
+	ioctl |= SDW_SHIM_IOCTL_COE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	ioctl &= ~(SDW_SHIM_IOCTL_MIF);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	/* Link power down sequence */
+	link_control = intel_readl(shim, SDW_SHIM_LCTL);
+	spa_mask = ~(SDW_SHIM_LCTL_SPA << link_id);
+	cpa_mask = (SDW_SHIM_LCTL_CPA << link_id);
+	link_control &=  spa_mask;
+
+	ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+	if (ret < 0)
+		return ret;
+
+	sdw->cdns.link_up = false;
+	return 0;
+}
 
 static int intel_link_power_up(struct sdw_intel *sdw)
 {
@@ -300,6 +330,29 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 	return 0;
 }
 
+static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
+{
+	void __iomem *shim = sdw->res->shim;
+	unsigned int link_id = sdw->instance;
+	u16 wake_en, wake_sts;
+
+	if (wake_enable) {
+		/* Enable the wakeup */
+		intel_writew(shim, SDW_SHIM_WAKEEN,
+			     (SDW_SHIM_WAKEEN_ENABLE << link_id));
+	} else {
+		/* Disable the wake up interrupt */
+		wake_en = intel_readw(shim, SDW_SHIM_WAKEEN);
+		wake_en &= ~(SDW_SHIM_WAKEEN_ENABLE << link_id);
+		intel_writew(shim, SDW_SHIM_WAKEEN, wake_en);
+
+		/* Clear wake status */
+		wake_sts = intel_readw(shim, SDW_SHIM_WAKESTS);
+		wake_sts |= (SDW_SHIM_WAKEEN_ENABLE << link_id);
+		intel_writew(shim, SDW_SHIM_WAKESTS_STATUS, wake_sts);
+	}
+}
+
 static int intel_shim_init(struct sdw_intel *sdw)
 {
 	void __iomem *shim = sdw->res->shim;
@@ -1095,11 +1148,60 @@ static int intel_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * PM calls
+ */
+
+#ifdef CONFIG_PM
+
+static int intel_suspend(struct device *dev)
+{
+	struct sdw_intel *sdw;
+	int ret;
+
+	sdw = dev_get_drvdata(dev);
+
+	ret = intel_link_power_down(sdw);
+	if (ret) {
+		dev_err(dev, "Link power down failed: %d", ret);
+		return ret;
+	}
+
+	intel_shim_wake(sdw, false);
+
+	return 0;
+}
+
+static int intel_resume(struct device *dev)
+{
+	struct sdw_intel *sdw;
+	int ret;
+
+	sdw = dev_get_drvdata(dev);
+
+	ret = intel_init(sdw);
+	if (ret) {
+		dev_err(dev, "%s failed: %d", __func__, ret);
+		return ret;
+	}
+
+	sdw_cdns_enable_interrupt(&sdw->cdns);
+
+	return ret;
+}
+
+#endif
+
+static const struct dev_pm_ops intel_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
+};
+
 static struct platform_driver sdw_intel_drv = {
 	.probe = intel_probe,
 	.remove = intel_remove,
 	.driver = {
 		.name = "int-sdw",
+		.pm = &intel_pm,
 
 	},
 };
-- 
2.20.1

