Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9C1CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE2E2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407542AbfJWV33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:29:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:24158 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392587AbfJWV2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:28:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="399541184"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2019 14:28:44 -0700
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
Subject: [PATCH 05/14] soundwire: intel: rename res field as link_res
Date:   Wed, 23 Oct 2019 16:28:14 -0500
Message-Id: <20191023212823.608-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are too many fields called 'res' so add prefix to make it easier
to track what the structures are.

Pure rename, no functionality change

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 0371d3d5501a..64f97bb1a135 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -103,7 +103,7 @@ enum intel_pdi_type {
 struct sdw_intel {
 	struct sdw_cdns cdns;
 	int instance;
-	struct sdw_intel_link_res *res;
+	struct sdw_intel_link_res *link_res;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 #endif
@@ -193,8 +193,8 @@ static ssize_t intel_sprintf(void __iomem *mem, bool l,
 static int intel_reg_show(struct seq_file *s_file, void *data)
 {
 	struct sdw_intel *sdw = s_file->private;
-	void __iomem *s = sdw->res->shim;
-	void __iomem *a = sdw->res->alh;
+	void __iomem *s = sdw->link_res->shim;
+	void __iomem *a = sdw->link_res->alh;
 	char *buf;
 	ssize_t ret;
 	int i, j;
@@ -289,7 +289,7 @@ static void intel_debugfs_exit(struct sdw_intel *sdw) {}
 static int intel_link_power_up(struct sdw_intel *sdw)
 {
 	unsigned int link_id = sdw->instance;
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	int spa_mask, cpa_mask;
 	int link_control, ret;
 
@@ -309,7 +309,7 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 
 static int intel_shim_init(struct sdw_intel *sdw)
 {
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
 	int sync_reg, ret;
 	u16 ioctl = 0, act = 0;
@@ -370,7 +370,7 @@ static int intel_shim_init(struct sdw_intel *sdw)
 static void intel_pdi_init(struct sdw_intel *sdw,
 			   struct sdw_cdns_stream_config *config)
 {
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
 	int pcm_cap, pdm_cap;
 
@@ -404,7 +404,7 @@ static void intel_pdi_init(struct sdw_intel *sdw,
 static int
 intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num, bool pcm)
 {
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
 	int count;
 
@@ -476,7 +476,7 @@ static int intel_pdi_ch_update(struct sdw_intel *sdw)
 static void
 intel_pdi_shim_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 {
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
 	int pdi_conf = 0;
 
@@ -508,7 +508,7 @@ intel_pdi_shim_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 static void
 intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 {
-	void __iomem *alh = sdw->res->alh;
+	void __iomem *alh = sdw->link_res->alh;
 	unsigned int link_id = sdw->instance;
 	unsigned int conf;
 
@@ -535,7 +535,7 @@ static int intel_params_stream(struct sdw_intel *sdw,
 			       struct snd_pcm_hw_params *hw_params,
 			       int link_id, int alh_stream_id)
 {
-	struct sdw_intel_link_res *res = sdw->res;
+	struct sdw_intel_link_res *res = sdw->link_res;
 	struct sdw_intel_stream_params_data params_data;
 
 	params_data.substream = substream;
@@ -558,7 +558,7 @@ static int intel_pre_bank_switch(struct sdw_bus *bus)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	int sync_reg;
 
 	/* Write to register only for multi-link */
@@ -577,7 +577,7 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	int sync_reg, ret;
 
 	/* Write to register only for multi-link */
@@ -934,9 +934,9 @@ static int intel_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sdw->instance = pdev->id;
-	sdw->res = dev_get_platdata(&pdev->dev);
+	sdw->link_res = dev_get_platdata(&pdev->dev);
 	sdw->cdns.dev = &pdev->dev;
-	sdw->cdns.registers = sdw->res->registers;
+	sdw->cdns.registers = sdw->link_res->registers;
 	sdw->cdns.instance = sdw->instance;
 	sdw->cdns.msg_count = 0;
 	sdw->cdns.bus.dev = &pdev->dev;
@@ -976,11 +976,12 @@ static int intel_probe(struct platform_device *pdev)
 	intel_pdi_ch_update(sdw);
 
 	/* Acquire IRQ */
-	ret = request_threaded_irq(sdw->res->irq, sdw_cdns_irq, sdw_cdns_thread,
+	ret = request_threaded_irq(sdw->link_res->irq,
+				   sdw_cdns_irq, sdw_cdns_thread,
 				   IRQF_SHARED, KBUILD_MODNAME, &sdw->cdns);
 	if (ret < 0) {
 		dev_err(sdw->cdns.dev, "unable to grab IRQ %d, disabling device\n",
-			sdw->res->irq);
+			sdw->link_res->irq);
 		goto err_init;
 	}
 
@@ -1010,7 +1011,7 @@ static int intel_probe(struct platform_device *pdev)
 
 err_interrupt:
 	sdw_cdns_enable_interrupt(&sdw->cdns, false);
-	free_irq(sdw->res->irq, sdw);
+	free_irq(sdw->link_res->irq, sdw);
 err_init:
 	sdw_delete_bus_master(&sdw->cdns.bus);
 	return ret;
@@ -1025,7 +1026,7 @@ static int intel_remove(struct platform_device *pdev)
 	if (!sdw->cdns.bus.prop.hw_disabled) {
 		intel_debugfs_exit(sdw);
 		sdw_cdns_enable_interrupt(&sdw->cdns, false);
-		free_irq(sdw->res->irq, sdw);
+		free_irq(sdw->link_res->irq, sdw);
 		snd_soc_unregister_component(sdw->cdns.dev);
 	}
 	sdw_delete_bus_master(&sdw->cdns.bus);
-- 
2.20.1

