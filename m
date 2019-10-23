Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C07CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F374221A4A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391974AbfJWVHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:07:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:7010 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391934AbfJWVHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:07:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:07:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="201260317"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by orsmga003.jf.intel.com with ESMTP; 23 Oct 2019 14:07:11 -0700
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
Subject: [PATCH 4/4] soundwire: intel: update stream callbacks for hwparams/free stream operations
Date:   Wed, 23 Oct 2019 16:06:57 -0500
Message-Id: <20191023210657.32440-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023210657.32440-1-pierre-louis.bossart@linux.intel.com>
References: <20191023210657.32440-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@linux.intel.com>

Rename 'config_stream' as 'params_stream' to be closer to ALSA/ASoC
concepts.

Add a 'free_stream' callback in case any resources allocated in the
'params_stream' stage need to be released.

Define structures for callbacks, mainly to allow for extensions as
needed.

Add the link_id and alh_stream_id parameters which are needed to align
with firmware IPC needs.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c           | 20 ++++++++++++------
 drivers/soundwire/intel.h           |  4 ++--
 drivers/soundwire/intel_init.c      |  1 +
 include/linux/soundwire/sdw_intel.h | 32 +++++++++++++++++++++++++----
 4 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index acdec12d748d..10ff03d3a9e5 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -523,17 +523,24 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 	intel_writel(alh, SDW_ALH_STRMZCFG(pdi->intel_alh_id), conf);
 }
 
-static int intel_config_stream(struct sdw_intel *sdw,
+static int intel_params_stream(struct sdw_intel *sdw,
 			       struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai,
-			       struct snd_pcm_hw_params *hw_params, int link_id)
+			       struct snd_pcm_hw_params *hw_params,
+			       int link_id, int alh_stream_id)
 {
 	struct sdw_intel_link_res *res = sdw->res;
+	struct sdw_intel_stream_params_data params_data;
 
-	if (res->ops && res->ops->config_stream && res->arg)
-		return res->ops->config_stream(res->arg,
-				substream, dai, hw_params, link_id);
+	params_data.substream = substream;
+	params_data.dai = dai;
+	params_data.hw_params = hw_params;
+	params_data.link_id = link_id;
+	params_data.alh_stream_id = alh_stream_id;
 
+	if (res->ops && res->ops->params_stream && res->dev)
+		return res->ops->params_stream(res->dev,
+					       &params_data);
 	return -EIO;
 }
 
@@ -648,7 +655,8 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 
 
 	/* Inform DSP about PDI stream number */
-	ret = intel_config_stream(sdw, substream, dai, params,
+	ret = intel_params_stream(sdw, substream, dai, params,
+				  sdw->instance,
 				  pdi->intel_alh_id);
 	if (ret)
 		goto error;
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index e4cc1d3804ff..38b7c125fb10 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -14,7 +14,7 @@
  * @alh: ALH (Audio Link Hub) pointer
  * @irq: Interrupt line
  * @ops: Shim callback ops
- * @arg: Shim callback ops argument
+ * @dev: device implementing hw_params and free callbacks
  */
 struct sdw_intel_link_res {
 	struct platform_device *pdev;
@@ -24,7 +24,7 @@ struct sdw_intel_link_res {
 	void __iomem *alh;
 	int irq;
 	const struct sdw_intel_ops *ops;
-	void *arg;
+	struct device *dev;
 };
 
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index f8ae199094d3..6bc167c83b47 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -119,6 +119,7 @@ static struct sdw_intel_ctx
 		link->alh = res->mmio_base + SDW_ALH_BASE;
 
 		link->ops = res->ops;
+		link->dev = res->dev;
 
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 2cb653299731..36e2b522a749 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -4,15 +4,39 @@
 #ifndef __SDW_INTEL_H
 #define __SDW_INTEL_H
 
+/**
+ * struct sdw_intel_stream_params_data: configuration passed during
+ * the @params_stream callback, e.g. for interaction with DSP
+ * firmware.
+ */
+struct sdw_intel_stream_params_data {
+	struct snd_pcm_substream *substream;
+	struct snd_soc_dai *dai;
+	struct snd_pcm_hw_params *hw_params;
+	int link_id;
+	int alh_stream_id;
+};
+
+/**
+ * struct sdw_intel_stream_free_data: configuration passed during
+ * the @free_stream callback, e.g. for interaction with DSP
+ * firmware.
+ */
+struct sdw_intel_stream_free_data {
+	struct snd_pcm_substream *substream;
+	struct snd_soc_dai *dai;
+	int link_id;
+};
+
 /**
  * struct sdw_intel_ops: Intel audio driver callback ops
  *
- * @config_stream: configure the stream with the hw_params
- * the first argument containing the context is mandatory
  */
 struct sdw_intel_ops {
-	int (*config_stream)(void *arg, void *substream,
-			     void *dai, void *hw_params, int stream_num);
+	int (*params_stream)(struct device *dev,
+			     struct sdw_intel_stream_params_data *params_data);
+	int (*free_stream)(struct device *dev,
+			   struct sdw_intel_stream_free_data *free_data);
 };
 
 /**
-- 
2.20.1

