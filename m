Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1732CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDE42084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392647AbfJWV3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:29:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:24158 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436584AbfJWV3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:29:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="399541243"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2019 14:28:58 -0700
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
Subject: [PATCH 12/14] soundwire: intel: add sdw_stream_setup helper for .startup callback
Date:   Wed, 23 Oct 2019 16:28:21 -0500
Message-Id: <20191023212823.608-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@linux.intel.com>

The sdw stream is allocated and stored in dai to share the sdw runtime
information.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 65 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 862dde9a9b86..af24fa048add 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -615,6 +615,69 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
  * DAI routines
  */
 
+static int sdw_stream_setup(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sdw_stream_runtime *sdw_stream = NULL;
+	char *name;
+	int i, ret;
+
+	name = kzalloc(32, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		snprintf(name, 32, "%s-Playback", dai->name);
+	else
+		snprintf(name, 32, "%s-Capture", dai->name);
+
+	sdw_stream = sdw_alloc_stream(name);
+	if (!sdw_stream) {
+		dev_err(dai->dev, "alloc stream failed for DAI %s", dai->name);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	/* Set stream pointer on CPU DAI */
+	ret = snd_soc_dai_set_sdw_stream(dai, sdw_stream, substream->stream);
+	if (ret < 0) {
+		dev_err(dai->dev, "failed to set stream pointer on cpu dai %s",
+			dai->name);
+		goto release_stream;
+	}
+
+	/* Set stream pointer on all CODEC DAIs */
+	for (i = 0; i < rtd->num_codecs; i++) {
+		ret = snd_soc_dai_set_sdw_stream(rtd->codec_dais[i], sdw_stream,
+						 substream->stream);
+		if (ret < 0) {
+			dev_err(dai->dev, "failed to set stream pointer on codec dai %s",
+				rtd->codec_dais[i]->name);
+			goto release_stream;
+		}
+	}
+
+	return 0;
+
+release_stream:
+	sdw_release_stream(sdw_stream);
+error:
+	kfree(name);
+	return ret;
+}
+
+static int intel_startup(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
+{
+	/*
+	 * TODO: add pm_runtime support here, the startup callback
+	 * will make sure the IP is 'active'
+	 */
+
+	return sdw_stream_setup(substream, dai);
+}
+
 static int intel_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
@@ -794,6 +857,7 @@ static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
 }
 
 static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
+	.startup = intel_startup,
 	.hw_params = intel_hw_params,
 	.prepare = intel_prepare,
 	.trigger = intel_trigger,
@@ -803,6 +867,7 @@ static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 };
 
 static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
+	.startup = intel_startup,
 	.hw_params = intel_hw_params,
 	.prepare = intel_prepare,
 	.trigger = intel_trigger,
-- 
2.20.1

