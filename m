Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B39C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459F6222C1
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391051AbfIZBbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:31:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45682 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389841AbfIZBbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:31:47 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E03C41A08E8;
        Thu, 26 Sep 2019 03:31:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 219CA1A008E;
        Thu, 26 Sep 2019 03:31:39 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D9BD64030E;
        Thu, 26 Sep 2019 09:31:30 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lars@metafoo.de
Subject: [PATCH V5 3/4] ASoC: pcm_dmaengine: Extract snd_dmaengine_pcm_refine_runtime_hwparams
Date:   Thu, 26 Sep 2019 09:29:50 +0800
Message-Id: <d728f65194e9978cbec4132b522d4fed420d704a.1569387932.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1569387932.git.shengjiu.wang@nxp.com>
References: <cover.1569387932.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1569387932.git.shengjiu.wang@nxp.com>
References: <cover.1569387932.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When set the runtime hardware parameters, we may need to query
the capability of DMA to complete the parameters.

This patch is to Extract this operation from
dmaengine_pcm_set_runtime_hwparams function to a separate function
snd_dmaengine_pcm_refine_runtime_hwparams, that other components
which need this feature can call this function.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 include/sound/dmaengine_pcm.h         |  5 ++
 sound/core/pcm_dmaengine.c            | 83 +++++++++++++++++++++++++++
 sound/soc/soc-generic-dmaengine-pcm.c | 61 ++------------------
 3 files changed, 94 insertions(+), 55 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index c679f6116580..b65220685920 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -83,6 +83,11 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
 	const struct snd_dmaengine_dai_dma_data *dma_data,
 	struct dma_slave_config *config);
 
+int snd_dmaengine_pcm_refine_runtime_hwparams(
+	struct snd_pcm_substream *substream,
+	struct snd_dmaengine_dai_dma_data *dma_data,
+	struct snd_pcm_hardware *hw,
+	struct dma_chan *chan);
 
 /*
  * Try to request the DMA channel using compat_request_channel or
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 89a05926ac73..5749a8a49784 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -369,4 +369,87 @@ int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close_release_chan);
 
+/**
+ * snd_dmaengine_pcm_refine_runtime_hwparams - Refine runtime hw params
+ * @substream: PCM substream
+ * @dma_data: DAI DMA data
+ * @hw: PCM hw params
+ * @chan: DMA channel to use for data transfers
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * This function will query DMA capability, then refine the pcm hardware
+ * parameters.
+ */
+int snd_dmaengine_pcm_refine_runtime_hwparams(
+	struct snd_pcm_substream *substream,
+	struct snd_dmaengine_dai_dma_data *dma_data,
+	struct snd_pcm_hardware *hw,
+	struct dma_chan *chan)
+{
+	struct dma_slave_caps dma_caps;
+	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	snd_pcm_format_t i;
+	int ret = 0;
+
+	if (!hw || !chan || !dma_data)
+		return -EINVAL;
+
+	ret = dma_get_slave_caps(chan, &dma_caps);
+	if (ret == 0) {
+		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
+			hw->info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
+		if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
+			hw->info |= SNDRV_PCM_INFO_BATCH;
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			addr_widths = dma_caps.dst_addr_widths;
+		else
+			addr_widths = dma_caps.src_addr_widths;
+	}
+
+	/*
+	 * If SND_DMAENGINE_PCM_DAI_FLAG_PACK is set keep
+	 * hw.formats set to 0, meaning no restrictions are in place.
+	 * In this case it's the responsibility of the DAI driver to
+	 * provide the supported format information.
+	 */
+	if (!(dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK))
+		/*
+		 * Prepare formats mask for valid/allowed sample types. If the
+		 * dma does not have support for the given physical word size,
+		 * it needs to be masked out so user space can not use the
+		 * format which produces corrupted audio.
+		 * In case the dma driver does not implement the slave_caps the
+		 * default assumption is that it supports 1, 2 and 4 bytes
+		 * widths.
+		 */
+		for (i = SNDRV_PCM_FORMAT_FIRST; i <= SNDRV_PCM_FORMAT_LAST; i++) {
+			int bits = snd_pcm_format_physical_width(i);
+
+			/*
+			 * Enable only samples with DMA supported physical
+			 * widths
+			 */
+			switch (bits) {
+			case 8:
+			case 16:
+			case 24:
+			case 32:
+			case 64:
+				if (addr_widths & (1 << (bits / 8)))
+					hw->formats |= pcm_format_to_bits(i);
+				break;
+			default:
+				/* Unsupported types */
+				break;
+			}
+		}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_refine_runtime_hwparams);
+
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 748f5f641002..b9f147eaf7c4 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -118,12 +118,7 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 	struct device *dma_dev = dmaengine_dma_dev(pcm, substream);
 	struct dma_chan *chan = pcm->chan[substream->stream];
 	struct snd_dmaengine_dai_dma_data *dma_data;
-	struct dma_slave_caps dma_caps;
 	struct snd_pcm_hardware hw;
-	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	snd_pcm_format_t i;
 	int ret;
 
 	if (pcm->config && pcm->config->pcm_hardware)
@@ -145,56 +140,12 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
 		hw.info |= SNDRV_PCM_INFO_BATCH;
 
-	ret = dma_get_slave_caps(chan, &dma_caps);
-	if (ret == 0) {
-		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
-			hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
-		if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
-			hw.info |= SNDRV_PCM_INFO_BATCH;
-
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			addr_widths = dma_caps.dst_addr_widths;
-		else
-			addr_widths = dma_caps.src_addr_widths;
-	}
-
-	/*
-	 * If SND_DMAENGINE_PCM_DAI_FLAG_PACK is set keep
-	 * hw.formats set to 0, meaning no restrictions are in place.
-	 * In this case it's the responsibility of the DAI driver to
-	 * provide the supported format information.
-	 */
-	if (!(dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK))
-		/*
-		 * Prepare formats mask for valid/allowed sample types. If the
-		 * dma does not have support for the given physical word size,
-		 * it needs to be masked out so user space can not use the
-		 * format which produces corrupted audio.
-		 * In case the dma driver does not implement the slave_caps the
-		 * default assumption is that it supports 1, 2 and 4 bytes
-		 * widths.
-		 */
-		for (i = SNDRV_PCM_FORMAT_FIRST; i <= SNDRV_PCM_FORMAT_LAST; i++) {
-			int bits = snd_pcm_format_physical_width(i);
-
-			/*
-			 * Enable only samples with DMA supported physical
-			 * widths
-			 */
-			switch (bits) {
-			case 8:
-			case 16:
-			case 24:
-			case 32:
-			case 64:
-				if (addr_widths & (1 << (bits / 8)))
-					hw.formats |= pcm_format_to_bits(i);
-				break;
-			default:
-				/* Unsupported types */
-				break;
-			}
-		}
+	ret = snd_dmaengine_pcm_refine_runtime_hwparams(substream,
+							dma_data,
+							&hw,
+							chan);
+	if (ret)
+		return ret;
 
 	return snd_soc_set_runtime_hwparams(substream, &hw);
 }
-- 
2.21.0

