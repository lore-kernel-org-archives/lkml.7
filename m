Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768B8C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C5420729
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfKNSSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:18:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:36355 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbfKNSSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 10:18:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="195123622"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
  by orsmga007.jf.intel.com with ESMTP; 14 Nov 2019 10:18:07 -0800
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
Subject: [PATCH v3 22/22] soundwire: intel: pm_runtime idle scheduling
Date:   Thu, 14 Nov 2019 12:17:02 -0600
Message-Id: <20191114181702.22254-23-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
References: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirk and pm_runtime idle scheduling to let the Master suspend if
no Slaves become attached. This can happen when a link is not marked
as disabled and has devices exposed in the DSDT, if the power is
controlled by sideband means or the link includes a pluggable
connector.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index b114e9a72fdc..f0077f58c4bf 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -29,8 +29,9 @@
  * flags reused in each byte, with master0 using the ls-byte, etc.
  */
 
-#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME BIT(0)
-#define SDW_INTEL_MASTER_DISABLE_CLOCK_STOP BIT(1)
+#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME		BIT(0)
+#define SDW_INTEL_MASTER_DISABLE_CLOCK_STOP		BIT(1)
+#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE	BIT(2)
 
 static int md_flags;
 module_param_named(sdw_md_flags, md_flags, int, 0444);
@@ -1329,6 +1330,22 @@ static int intel_master_startup(struct sdw_master_device *md)
 		pm_runtime_enable(&md->dev);
 	}
 
+	/*
+	 * Slave devices have an pm_runtime of 'Unsupported' until
+	 * they report as ATTACHED. If they don't, e.g. because there
+	 * are no Slave devices populated or if the power-on is
+	 * delayed or dependent on a power switch, the Master will
+	 * remain active and prevent its parent from suspending.
+	 *
+	 * Conditionally force the pm_runtime core to re-evaluate the
+	 * Master status in the absence of any Slave activity. A quirk
+	 * is provided to e.g. deal with Slaves that may be powered on
+	 * with a delay. A more complete solution would require the
+	 * definition of Master properties.
+	 */
+	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
+		pm_runtime_idle(&md->dev);
+
 	return 0;
 
 err_interrupt:
@@ -1443,6 +1460,7 @@ static int intel_resume(struct device *dev)
 	struct sdw_master_device *md = to_sdw_master_device(dev);
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	int link_flags;
 	int ret;
 
 	if (cdns->bus.prop.hw_disabled) {
@@ -1463,6 +1481,10 @@ static int intel_resume(struct device *dev)
 		pm_runtime_enable(dev);
 
 		md->pm_runtime_suspended = false;
+
+		link_flags = md_flags >> (sdw->cdns.bus.link_id * 8);
+		if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
+			pm_runtime_idle(&md->dev);
 	}
 
 	ret = intel_init(sdw);
-- 
2.20.1

