Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1371CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D0B2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391939AbfJWVHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:07:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:7010 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391757AbfJWVHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:07:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="201260311"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by orsmga003.jf.intel.com with ESMTP; 23 Oct 2019 14:07:09 -0700
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
Subject: [PATCH 3/4] soundwire: intel: update interfaces between ASoC and SoundWire
Date:   Wed, 23 Oct 2019 16:06:56 -0500
Message-Id: <20191023210657.32440-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023210657.32440-1-pierre-louis.bossart@linux.intel.com>
References: <20191023210657.32440-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose updated interfaces in sdw_intel.h, mainly to allow SoundWire
and ASoC parts to be merged separately once the header files are
shared between trees.

To avoid compilation issues, the conflicts in intel_init.c are blindly
removed. This would in theory prevent the code from working, but since
there are no users of the Intel Soundwire driver this has no
impact. Functionality will be restored when the removal of platform
devices is complete.

Support for SoundWire + SOF builds will only be provided once all the
required pieces are upstream.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.h           |  9 ++--
 drivers/soundwire/intel_init.c      | 30 +++---------
 include/linux/soundwire/sdw_intel.h | 71 +++++++++++++++++++++++++++--
 3 files changed, 79 insertions(+), 31 deletions(-)

diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index d923b6262330..e4cc1d3804ff 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -5,17 +5,20 @@
 #define __SDW_INTEL_LOCAL_H
 
 /**
- * struct sdw_intel_link_res - Soundwire link resources
+ * struct sdw_intel_link_res - Soundwire Intel link resource structure,
+ * typically populated by the controller driver.
+ * @pdev: platform_device
+ * @mmio_base: mmio base of SoundWire registers
  * @registers: Link IO registers base
  * @shim: Audio shim pointer
  * @alh: ALH (Audio Link Hub) pointer
  * @irq: Interrupt line
  * @ops: Shim callback ops
  * @arg: Shim callback ops argument
- *
- * This is set as pdata for each link instance.
  */
 struct sdw_intel_link_res {
+	struct platform_device *pdev;
+	void __iomem *mmio_base; /* not strictly needed, useful for debug */
 	void __iomem *registers;
 	void __iomem *shim;
 	void __iomem *alh;
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 2a2b4d8df462..f8ae199094d3 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -27,19 +27,9 @@ static int link_mask;
 module_param_named(sdw_link_mask, link_mask, int, 0444);
 MODULE_PARM_DESC(sdw_link_mask, "Intel link mask (one bit per link)");
 
-struct sdw_link_data {
-	struct sdw_intel_link_res res;
-	struct platform_device *pdev;
-};
-
-struct sdw_intel_ctx {
-	int count;
-	struct sdw_link_data *links;
-};
-
 static int sdw_intel_cleanup_pdev(struct sdw_intel_ctx *ctx)
 {
-	struct sdw_link_data *link = ctx->links;
+	struct sdw_intel_link_res *link = ctx->links;
 	int i;
 
 	if (!link)
@@ -62,7 +52,7 @@ static struct sdw_intel_ctx
 {
 	struct platform_device_info pdevinfo;
 	struct platform_device *pdev;
-	struct sdw_link_data *link;
+	struct sdw_intel_link_res *link;
 	struct sdw_intel_ctx *ctx;
 	struct acpi_device *adev;
 	int ret, i;
@@ -123,14 +113,12 @@ static struct sdw_intel_ctx
 			continue;
 		}
 
-		link->res.irq = res->irq;
-		link->res.registers = res->mmio_base + SDW_LINK_BASE
+		link->registers = res->mmio_base + SDW_LINK_BASE
 					+ (SDW_LINK_SIZE * i);
-		link->res.shim = res->mmio_base + SDW_SHIM_BASE;
-		link->res.alh = res->mmio_base + SDW_ALH_BASE;
+		link->shim = res->mmio_base + SDW_SHIM_BASE;
+		link->alh = res->mmio_base + SDW_ALH_BASE;
 
-		link->res.ops = res->ops;
-		link->res.arg = res->arg;
+		link->ops = res->ops;
 
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 
@@ -138,8 +126,6 @@ static struct sdw_intel_ctx
 		pdevinfo.name = "int-sdw";
 		pdevinfo.id = i;
 		pdevinfo.fwnode = acpi_fwnode_handle(adev);
-		pdevinfo.data = &link->res;
-		pdevinfo.size_data = sizeof(link->res);
 
 		pdev = platform_device_register_full(&pdevinfo);
 		if (IS_ERR(pdev)) {
@@ -224,10 +210,8 @@ EXPORT_SYMBOL(sdw_intel_init);
  *
  * Delete the controller instances created and cleanup
  */
-void sdw_intel_exit(void *arg)
+void sdw_intel_exit(struct sdw_intel_ctx *ctx)
 {
-	struct sdw_intel_ctx *ctx = arg;
-
 	sdw_intel_cleanup_pdev(ctx);
 	kfree(ctx);
 }
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index c9427cb6020b..2cb653299731 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -16,24 +16,85 @@ struct sdw_intel_ops {
 };
 
 /**
- * struct sdw_intel_res - Soundwire Intel resource structure
+ * struct sdw_intel_acpi_info - Soundwire Intel information found in ACPI tables
+ * @handle: ACPI controller handle
+ * @count: link count found with "sdw-master-count" property
+ * @link_mask: bit-wise mask listing links enabled by BIOS menu
+ *
+ * this structure could be expanded to e.g. provide all the _ADR
+ * information in case the link_mask is not sufficient to identify
+ * platform capabilities.
+ */
+struct sdw_intel_acpi_info {
+	acpi_handle handle;
+	int count;
+	u32 link_mask;
+};
+
+/**
+ * struct sdw_intel_res - Soundwire Intel global resource structure,
+ * typically populated by the DSP driver
+ *
+ * @count: link count (may be filtered by DSP driver)
  * @mmio_base: mmio base of SoundWire registers
  * @irq: interrupt number
  * @handle: ACPI parent handle
  * @parent: parent device
  * @ops: callback ops
- * @arg: callback arg
+ * @dev: device implementing hwparams and free callbacks
+ * @link_mask: bit-wise mask listing links selected by the DSP driver
  */
 struct sdw_intel_res {
+	int count;
 	void __iomem *mmio_base;
 	int irq;
 	acpi_handle handle;
 	struct device *parent;
 	const struct sdw_intel_ops *ops;
-	void *arg;
+	struct device *dev;
+	u32 link_mask;
 };
 
-void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res);
-void sdw_intel_exit(void *arg);
+struct sdw_intel_link_res;
+
+/**
+ * struct sdw_intel_ctx - context allocated by the controller
+ * driver probe
+ * @count: link count
+ * @mmio_base: mmio base of SoundWire registers, only used to check
+ * hardware capabilities after all power dependencies are settled.
+ * @arg: Shim callback ops argument
+ */
+struct sdw_intel_ctx {
+	int count;
+	void __iomem *mmio_base;
+	u32 link_mask;
+	acpi_handle handle;
+	struct sdw_intel_link_res *links;
+};
+
+/*
+ * On Intel platforms, the SoundWire IP has dependencies on power
+ * rails shared with the DSP, and the initialization steps are split
+ * in three. First an ACPI scan to check what the firmware describes
+ * in DSDT tables, then an allocation step (with no hardware
+ * configuration but with all the relevant devices created) and last
+ * the actual hardware configuration. The final stage is a global
+ * interrupt enable which is controlled by the DSP driver. Splitting
+ * these phases helps simplify the boot flow and make early decisions
+ * on e.g. which machine driver to select (I2S mode, HDaudio or
+ * SoundWire).
+ */
+int sdw_intel_acpi_scan(acpi_handle *parent_handle,
+			struct sdw_intel_acpi_info *info);
+
+struct sdw_intel_ctx *
+sdw_intel_probe(struct sdw_intel_res *res);
+
+int sdw_intel_startup(struct sdw_intel_ctx *ctx);
+
+void sdw_intel_exit(struct sdw_intel_ctx *ctx);
+
+void sdw_intel_enable_irq(void __iomem *mmio_base, bool enable);
 
 #endif
-- 
2.20.1

