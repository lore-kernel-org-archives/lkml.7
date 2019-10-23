Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE0DCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AEA2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407649AbfJWVqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:46:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:39636 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391240AbfJWVqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:46:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:46:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="196908110"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 14:46:11 -0700
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
Subject: [PATCH 01/18] soundwire: intel/cadence: fix timeouts in MSI mode
Date:   Wed, 23 Oct 2019 16:45:44 -0500
Message-Id: <20191023214601.883-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023214601.883-1-pierre-louis.bossart@linux.intel.com>
References: <20191023214601.883-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

The existing code uses one pair of interrupt handler/thread per link
but at the hardware level the interrupt is shared. This works fine for
legacy PCI interrupts, but leads to timeouts in MSI (Message-Signaled
Interrupt) mode, likely due to edges being lost.

This patch unifies interrupt handling for all links with a single
threaded IRQ handler. The handler is simplified to the bare minimum of
detecting a SoundWire interrupt, and the thread takes care of dealing
with interrupt sources. This partition follows the model used for the
SOF IPC on HDaudio platforms, where similar timeout issues were
noticed and doing all the interrupt handling/clearing in the thread
improved reliability/stability.

Validation results with 4 links active in parallel show a night-and-day
improvement with no timeouts noticed even during stress tests. Latency
and quality of service are not affected by the change - mostly because
events on a SoundWire link are throttled by the bus frame rate
(typically 8..48kHz).

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c  | 17 ++++++-----
 drivers/soundwire/cadence_master.h  |  4 +++
 drivers/soundwire/intel.c           | 17 +----------
 drivers/soundwire/intel.h           |  2 ++
 drivers/soundwire/intel_init.c      | 45 ++++++++++++++++++++++++++++-
 include/linux/soundwire/sdw_intel.h |  2 ++
 6 files changed, 62 insertions(+), 25 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index fed21e2b2277..362fb6e49bfe 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -17,6 +17,7 @@
 #include <linux/soundwire/sdw.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <linux/workqueue.h>
 #include "bus.h"
 #include "cadence_master.h"
 
@@ -745,7 +746,7 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 			     CDNS_MCP_INT_SLAVE_MASK, 0);
 
 		int_status &= ~CDNS_MCP_INT_SLAVE_MASK;
-		ret = IRQ_WAKE_THREAD;
+		schedule_work(&cdns->work);
 	}
 
 	cdns_writel(cdns, CDNS_MCP_INTSTAT, int_status);
@@ -754,13 +755,14 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 EXPORT_SYMBOL(sdw_cdns_irq);
 
 /**
- * sdw_cdns_thread() - Cadence irq thread handler
- * @irq: irq number
- * @dev_id: irq context
+ * To update slave status in a work since we will need to handle
+ * other interrupts eg. CDNS_MCP_INT_RX_WL during the update slave
+ * process.
  */
-irqreturn_t sdw_cdns_thread(int irq, void *dev_id)
+static void cdns_update_slave_status_work(struct work_struct *work)
 {
-	struct sdw_cdns *cdns = dev_id;
+	struct sdw_cdns *cdns =
+		container_of(work, struct sdw_cdns, work);
 	u32 slave0, slave1;
 
 	dev_dbg_ratelimited(cdns->dev, "Slave status change\n");
@@ -777,9 +779,7 @@ irqreturn_t sdw_cdns_thread(int irq, void *dev_id)
 	cdns_updatel(cdns, CDNS_MCP_INTMASK,
 		     CDNS_MCP_INT_SLAVE_MASK, CDNS_MCP_INT_SLAVE_MASK);
 
-	return IRQ_HANDLED;
 }
-EXPORT_SYMBOL(sdw_cdns_thread);
 
 /*
  * init routines
@@ -1187,6 +1187,7 @@ int sdw_cdns_probe(struct sdw_cdns *cdns)
 	init_completion(&cdns->tx_complete);
 	cdns->bus.port_ops = &cdns_port_ops;
 
+	INIT_WORK(&cdns->work, cdns_update_slave_status_work);
 	return 0;
 }
 EXPORT_SYMBOL(sdw_cdns_probe);
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 001457cbe5ad..0f108fd31fd9 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -126,6 +126,10 @@ struct sdw_cdns {
 
 	bool link_up;
 	unsigned int msg_count;
+
+	struct work_struct work;
+
+	struct list_head list;
 };
 
 #define bus_to_cdns(_bus) container_of(_bus, struct sdw_cdns, bus)
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index cad1c0b64ee3..c918a26d0772 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1095,6 +1095,7 @@ static int intel_master_probe(struct sdw_master_device *md, void *link_ctx)
 	sdw->cdns.msg_count = 0;
 	sdw->cdns.bus.dev = &md->dev;
 	sdw->cdns.bus.link_id = md->link_id;
+	sdw->link_res->cdns = &sdw->cdns;
 
 	sdw_cdns_probe(&sdw->cdns);
 
@@ -1119,21 +1120,7 @@ static int intel_master_probe(struct sdw_master_device *md, void *link_ctx)
 		return 0;
 	}
 
-	/* Acquire IRQ */
-	ret = request_threaded_irq(sdw->link_res->irq,
-				   sdw_cdns_irq, sdw_cdns_thread,
-				   IRQF_SHARED, KBUILD_MODNAME, &sdw->cdns);
-	if (ret < 0) {
-		dev_err(sdw->cdns.dev, "unable to grab IRQ %d, disabling device\n",
-			sdw->link_res->irq);
-		goto err_init;
-	}
-
 	return 0;
-
-err_init:
-	sdw_delete_bus_master(&sdw->cdns.bus);
-	return ret;
 }
 
 static int intel_master_startup(struct sdw_master_device *md)
@@ -1190,7 +1177,6 @@ static int intel_master_startup(struct sdw_master_device *md)
 err_interrupt:
 	sdw_cdns_enable_interrupt(&sdw->cdns, false);
 err_init:
-	free_irq(sdw->link_res->irq, sdw);
 	sdw_delete_bus_master(&sdw->cdns.bus);
 	return ret;
 }
@@ -1204,7 +1190,6 @@ static int intel_master_remove(struct sdw_master_device *md)
 	if (!sdw->cdns.bus.prop.hw_disabled) {
 		intel_debugfs_exit(sdw);
 		sdw_cdns_enable_interrupt(&sdw->cdns, false);
-		free_irq(sdw->link_res->irq, sdw);
 		snd_soc_unregister_component(sdw->cdns.dev);
 	}
 	sdw_delete_bus_master(&sdw->cdns.bus);
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index cfab2f00214d..2ae4fa748686 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -25,6 +25,8 @@ struct sdw_intel_link_res {
 	int irq;
 	const struct sdw_intel_ops *ops;
 	struct device *dev;
+	struct sdw_cdns *cdns;
+	struct list_head list;
 };
 
 #define SDW_INTEL_QUIRK_MASK_BUS_DISABLE      BIT(1)
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 14ffe9ce2929..ed2a83989c72 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -11,8 +11,10 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_intel.h>
+#include "cadence_master.h"
 #include "intel.h"
 
 #define SDW_LINK_TYPE		4 /* from Intel ACPI documentation */
@@ -161,6 +163,32 @@ void sdw_intel_enable_irq(void __iomem *mmio_base, bool enable)
 }
 EXPORT_SYMBOL(sdw_intel_enable_irq);
 
+static irqreturn_t sdw_intel_irq(int irq, void *dev_id)
+{
+	struct sdw_intel_ctx *ctx = dev_id;
+	u32 int_status;
+
+	int_status = readl(ctx->mmio_base + HDA_DSP_REG_ADSPIS2);
+	if (int_status & HDA_DSP_REG_ADSPIC2_SNDW) {
+		sdw_intel_enable_irq(ctx->mmio_base, false);
+		return IRQ_WAKE_THREAD;
+	}
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t sdw_intel_thread(int irq, void *dev_id)
+{
+	struct sdw_intel_ctx *ctx = dev_id;
+	struct sdw_intel_link_res *link;
+
+	list_for_each_entry(link, &ctx->link_list, list)
+		sdw_cdns_irq(irq, link->cdns);
+
+	sdw_intel_enable_irq(ctx->mmio_base, true);
+	return IRQ_HANDLED;
+}
+
 static struct sdw_intel_ctx
 *sdw_intel_probe_controller(struct sdw_intel_res *res)
 {
@@ -171,6 +199,7 @@ static struct sdw_intel_ctx
 	u32 link_mask;
 	int count;
 	int i;
+	int ret;
 
 	if (!res)
 		return NULL;
@@ -196,10 +225,13 @@ static struct sdw_intel_ctx
 	ctx->mmio_base = res->mmio_base;
 	ctx->link_mask = res->link_mask;
 	ctx->handle = res->handle;
+	ctx->irq = res->irq;
 
 	link = ctx->links;
 	link_mask = ctx->link_mask;
 
+	INIT_LIST_HEAD(&ctx->link_list);
+
 	/* Create SDW Master devices */
 	for (i = 0; i < count; i++, link++) {
 		if (link_mask && !(link_mask & BIT(i)))
@@ -220,12 +252,22 @@ static struct sdw_intel_ctx
 			+ (SDW_LINK_SIZE * i);
 		link->shim = res->mmio_base + SDW_SHIM_BASE;
 		link->alh = res->mmio_base + SDW_ALH_BASE;
-		link->irq = res->irq;
 		link->ops = res->ops;
 		link->dev = res->dev;
 
 		/* let the SoundWire master driver to its probe */
 		md->driver->probe(md, link);
+
+		list_add_tail(&link->list, &ctx->link_list);
+	}
+
+	ret = request_threaded_irq(ctx->irq,
+				   sdw_intel_irq, sdw_intel_thread,
+				   IRQF_SHARED, KBUILD_MODNAME, ctx);
+	if (ret < 0) {
+		dev_err(&adev->dev, "unable to grab IRQ %d, disabling device\n",
+			res->irq);
+		goto err;
 	}
 
 	return ctx;
@@ -373,6 +415,7 @@ EXPORT_SYMBOL(sdw_intel_startup);
  */
 void sdw_intel_exit(struct sdw_intel_ctx *ctx)
 {
+	free_irq(ctx->irq, ctx);
 	sdw_intel_cleanup(ctx);
 	kfree(ctx);
 }
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 36e2b522a749..373947003cea 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -94,7 +94,9 @@ struct sdw_intel_ctx {
 	void __iomem *mmio_base;
 	u32 link_mask;
 	acpi_handle handle;
+	int irq;
 	struct sdw_intel_link_res *links;
+	struct list_head link_list;
 };
 
 /*
-- 
2.20.1

