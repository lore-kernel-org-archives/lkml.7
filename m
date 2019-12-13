Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD64EC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A8D22527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbfLMFFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:05:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:58713 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732048AbfLMFEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:04:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 21:04:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,308,1571727600"; 
   d="scan'208";a="208340753"
Received: from vbagrodi-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.130.70])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2019 21:04:35 -0800
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
Subject: [PATCH v4 10/15] soundwire: register master device driver
Date:   Thu, 12 Dec 2019 23:04:04 -0600
Message-Id: <20191213050409.12776-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

While we don't have a matching function, setting an device driver is
still necessary for ASoC to register DAI components as well as power
management.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c      |  6 ++++++
 drivers/soundwire/intel_init.c | 10 ++++++++++
 drivers/soundwire/master.c     |  1 +
 include/linux/soundwire/sdw.h  |  1 +
 4 files changed, 18 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index ba3bc410d816..adf06833af74 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -17,6 +17,7 @@
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_intel.h>
+#include <linux/soundwire/sdw_type.h>
 #include "cadence_master.h"
 #include "bus.h"
 #include "intel.h"
@@ -1059,6 +1060,11 @@ static int intel_master_remove(struct sdw_master_device *md)
 }
 
 struct sdw_md_driver intel_sdw_driver = {
+	.driver = {
+		.name = "intel-sdw",
+		.owner = THIS_MODULE,
+		.bus = &sdw_bus_type,
+	},
 	.probe = intel_master_probe,
 	.startup = intel_master_startup,
 	.remove = intel_master_remove,
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 42f7ae034bea..a30d95ee71b7 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -146,6 +146,7 @@ static struct sdw_intel_ctx
 	struct sdw_master_device *md;
 	u32 link_mask;
 	int count;
+	int err;
 	int i;
 
 	if (!res)
@@ -176,6 +177,12 @@ static struct sdw_intel_ctx
 	link = ctx->links;
 	link_mask = ctx->link_mask;
 
+	err = driver_register(&intel_sdw_driver.driver);
+	if (err) {
+		dev_err(&adev->dev, "failed to register sdw master driver\n");
+		goto register_err;
+	}
+
 	/* Create SDW Master devices */
 	for (i = 0; i < count; i++, link++) {
 		if (link_mask && !(link_mask & BIT(i)))
@@ -209,6 +216,8 @@ static struct sdw_intel_ctx
 err:
 	sdw_intel_cleanup(ctx);
 link_err:
+	driver_unregister(&intel_sdw_driver.driver);
+register_err:
 	kfree(ctx);
 	return NULL;
 }
@@ -350,6 +359,7 @@ EXPORT_SYMBOL(sdw_intel_startup);
 void sdw_intel_exit(struct sdw_intel_ctx *ctx)
 {
 	sdw_intel_cleanup(ctx);
+	driver_unregister(&intel_sdw_driver.driver);
 	kfree(ctx);
 }
 EXPORT_SYMBOL(sdw_intel_exit);
diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index 6210098c892b..44f70ea67ae3 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -46,6 +46,7 @@ struct sdw_master_device *sdw_md_add(struct sdw_md_driver *driver,
 	md->dev.type = &sdw_md_type;
 	md->dev.dma_mask = md->dev.parent->dma_mask;
 	dev_set_name(&md->dev, "sdw-master-%d", md->link_id);
+	md->dev.driver = &driver->driver;
 
 	ret = device_register(&md->dev);
 	if (ret) {
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index af0a72e7afdf..d22950b1a5d9 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -627,6 +627,7 @@ struct sdw_md_driver {
 	 */
 	int (*autonomous_clock_stop_enable)(struct sdw_master_device *md,
 					    bool state);
+	struct device_driver driver;
 };
 
 #define SDW_SLAVE_ENTRY(_mfg_id, _part_id, _drv_data) \
-- 
2.20.1

