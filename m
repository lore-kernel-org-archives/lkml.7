Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A281C04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02DB21783
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfEAP6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 11:58:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:25560 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfEAP6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:58:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 08:58:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,418,1549958400"; 
   d="scan'208";a="296115733"
Received: from modiarvi-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.134.211])
  by orsmga004.jf.intel.com with ESMTP; 01 May 2019 08:58:34 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v4 15/22] soundwire: intel: fix alignment issues
Date:   Wed,  1 May 2019 10:57:38 -0500
Message-Id: <20190501155745.21806-16-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use Linux style

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 59 +++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 70ca27ccad85..56d6c1dda0ff 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -236,7 +236,7 @@ static int intel_shim_init(struct sdw_intel *sdw)
 	/* Set SyncCPU bit */
 	sync_reg |= SDW_SHIM_SYNC_SYNCCPU;
 	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
-				SDW_SHIM_SYNC_SYNCCPU);
+			      SDW_SHIM_SYNC_SYNCCPU);
 	if (ret < 0)
 		dev_err(sdw->cdns.dev, "Failed to set sync period: %d", ret);
 
@@ -247,7 +247,7 @@ static int intel_shim_init(struct sdw_intel *sdw)
  * PDI routines
  */
 static void intel_pdi_init(struct sdw_intel *sdw,
-			struct sdw_cdns_stream_config *config)
+			   struct sdw_cdns_stream_config *config)
 {
 	void __iomem *shim = sdw->res->shim;
 	unsigned int link_id = sdw->instance;
@@ -296,9 +296,9 @@ intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num, bool pcm)
 }
 
 static int intel_pdi_get_ch_update(struct sdw_intel *sdw,
-				struct sdw_cdns_pdi *pdi,
-				unsigned int num_pdi,
-				unsigned int *num_ch, bool pcm)
+				   struct sdw_cdns_pdi *pdi,
+				   unsigned int num_pdi,
+				   unsigned int *num_ch, bool pcm)
 {
 	int i, ch_count = 0;
 
@@ -313,16 +313,16 @@ static int intel_pdi_get_ch_update(struct sdw_intel *sdw,
 }
 
 static int intel_pdi_stream_ch_update(struct sdw_intel *sdw,
-				struct sdw_cdns_streams *stream, bool pcm)
+				      struct sdw_cdns_streams *stream, bool pcm)
 {
 	intel_pdi_get_ch_update(sdw, stream->bd, stream->num_bd,
-			&stream->num_ch_bd, pcm);
+				&stream->num_ch_bd, pcm);
 
 	intel_pdi_get_ch_update(sdw, stream->in, stream->num_in,
-			&stream->num_ch_in, pcm);
+				&stream->num_ch_in, pcm);
 
 	intel_pdi_get_ch_update(sdw, stream->out, stream->num_out,
-			&stream->num_ch_out, pcm);
+				&stream->num_ch_out, pcm);
 
 	return 0;
 }
@@ -387,9 +387,9 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 }
 
 static int intel_config_stream(struct sdw_intel *sdw,
-			struct snd_pcm_substream *substream,
-			struct snd_soc_dai *dai,
-			struct snd_pcm_hw_params *hw_params, int link_id)
+			       struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai,
+			       struct snd_pcm_hw_params *hw_params, int link_id)
 {
 	if (sdw->res->ops && sdw->res->ops->config_stream)
 		return sdw->res->ops->config_stream(sdw->res->arg,
@@ -454,7 +454,7 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 	sync_reg |= SDW_SHIM_SYNC_SYNCGO;
 
 	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
-					SDW_SHIM_SYNC_SYNCGO);
+			      SDW_SHIM_SYNC_SYNCGO);
 	if (ret < 0)
 		dev_err(sdw->cdns.dev, "Post bank switch failed: %d", ret);
 
@@ -466,7 +466,7 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
  */
 
 static struct sdw_cdns_port *intel_alloc_port(struct sdw_intel *sdw,
-				u32 ch, u32 dir, bool pcm)
+					      u32 ch, u32 dir, bool pcm)
 {
 	struct sdw_cdns *cdns = &sdw->cdns;
 	struct sdw_cdns_port *port = NULL;
@@ -526,8 +526,8 @@ static void intel_port_cleanup(struct sdw_cdns_dma_data *dma)
 }
 
 static int intel_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params,
-				struct snd_soc_dai *dai)
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
@@ -575,7 +575,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	/* Inform DSP about PDI stream number */
 	for (i = 0; i < dma->nr_ports; i++) {
 		ret = intel_config_stream(sdw, substream, dai, params,
-				dma->port[i]->pdi->intel_alh_id);
+					  dma->port[i]->pdi->intel_alh_id);
 		if (ret)
 			goto port_error;
 	}
@@ -605,7 +605,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = sdw_stream_add_master(&cdns->bus, &sconfig,
-				pconfig, dma->nr_ports, dma->stream);
+				    pconfig, dma->nr_ports, dma->stream);
 	if (ret) {
 		dev_err(cdns->dev, "add master to stream failed:%d", ret);
 		goto stream_error;
@@ -636,7 +636,7 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	ret = sdw_stream_remove_master(&cdns->bus, dma->stream);
 	if (ret < 0)
 		dev_err(dai->dev, "remove master from stream %s failed: %d",
-							dma->stream->name, ret);
+			dma->stream->name, ret);
 
 	intel_port_cleanup(dma);
 	kfree(dma->port);
@@ -644,13 +644,13 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 }
 
 static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
-					void *stream, int direction)
+				    void *stream, int direction)
 {
 	return cdns_set_sdw_stream(dai, stream, true, direction);
 }
 
 static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
-					void *stream, int direction)
+				    void *stream, int direction)
 {
 	return cdns_set_sdw_stream(dai, stream, false, direction);
 }
@@ -674,9 +674,9 @@ static const struct snd_soc_component_driver dai_component = {
 };
 
 static int intel_create_dai(struct sdw_cdns *cdns,
-			struct snd_soc_dai_driver *dais,
-			enum intel_pdi_type type,
-			u32 num, u32 off, u32 max_ch, bool pcm)
+			    struct snd_soc_dai_driver *dais,
+			    enum intel_pdi_type type,
+			    u32 num, u32 off, u32 max_ch, bool pcm)
 {
 	int i;
 
@@ -686,7 +686,7 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 	 /* TODO: Read supported rates/formats from hardware */
 	for (i = off; i < (off + num); i++) {
 		dais[i].name = kasprintf(GFP_KERNEL, "SDW%d Pin%d",
-					cdns->instance, i);
+					 cdns->instance, i);
 		if (!dais[i].name)
 			return -ENOMEM;
 
@@ -787,7 +787,7 @@ static int intel_register_dai(struct sdw_intel *sdw)
 		return ret;
 
 	return snd_soc_register_component(cdns->dev, &dai_component,
-				dais, num_dai);
+					  dais, num_dai);
 }
 
 static int intel_prop_read(struct sdw_bus *bus)
@@ -873,12 +873,11 @@ static int intel_probe(struct platform_device *pdev)
 	intel_pdi_ch_update(sdw);
 
 	/* Acquire IRQ */
-	ret = request_threaded_irq(sdw->res->irq, sdw_cdns_irq,
-			sdw_cdns_thread, IRQF_SHARED, KBUILD_MODNAME,
-			&sdw->cdns);
+	ret = request_threaded_irq(sdw->res->irq, sdw_cdns_irq, sdw_cdns_thread,
+				   IRQF_SHARED, KBUILD_MODNAME, &sdw->cdns);
 	if (ret < 0) {
 		dev_err(sdw->cdns.dev, "unable to grab IRQ %d, disabling device\n",
-				sdw->res->irq);
+			sdw->res->irq);
 		goto err_init;
 	}
 
-- 
2.17.1

