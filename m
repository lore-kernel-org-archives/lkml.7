Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D8C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C484214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfIPVoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:44:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:23316 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbfIPVoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:44:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 14:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="198480178"
Received: from dgitin-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.142.45])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2019 14:44:13 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>
Subject: [RFC PATCH 11/12] ASoC: SOF: Intel: hda: add SoundWire stream config/free callbacks
Date:   Mon, 16 Sep 2019 16:42:50 -0500
Message-Id: <20190916214251.13130-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
References: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These callbacks are invoked when a matching hw_params/hw_free() DAI
operation takes place, and will result in IPC operations with the SOF
firmware.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 70 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index d129d5c68f5e..02291e1de1fc 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -41,6 +41,74 @@
 
 #if IS_ENABLED(CONFIG_SOUNDWIRE_INTEL)
 
+static int sdw_params_stream(struct device *dev,
+			     struct sdw_intel_stream_params_data *params_data)
+{
+	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
+	struct snd_soc_dai *d = params_data->dai;
+	struct sof_ipc_dai_config config;
+	struct sof_ipc_reply reply;
+	int link_id = params_data->link_id;
+	int alh_stream_id = params_data->alh_stream_id;
+	int ret;
+	u32 size = sizeof(config);
+
+	memset(&config, 0, size);
+	config.hdr.size = size;
+	config.hdr.cmd = SOF_IPC_GLB_DAI_MSG | SOF_IPC_DAI_CONFIG;
+	config.type = SOF_DAI_INTEL_ALH;
+	config.dai_index = (link_id << 8) | (d->id);
+	config.alh.stream_id = alh_stream_id;
+
+	/* send message to DSP */
+	ret = sof_ipc_tx_message(sdev->ipc,
+				 config.hdr.cmd, &config, size, &reply,
+				 sizeof(reply));
+	if (ret < 0) {
+		dev_err(sdev->dev,
+			"error: failed to set DAI hw_params for link %d dai->id %d ALH %d\n",
+			link_id, d->id, alh_stream_id);
+	}
+
+	return ret;
+}
+
+static int sdw_free_stream(struct device *dev,
+			   struct sdw_intel_stream_free_data *free_data)
+{
+	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
+	struct snd_soc_dai *d = free_data->dai;
+	struct sof_ipc_dai_config config;
+	struct sof_ipc_reply reply;
+	int link_id = free_data->link_id;
+	int ret;
+	u32 size = sizeof(config);
+
+	memset(&config, 0, size);
+	config.hdr.size = size;
+	config.hdr.cmd = SOF_IPC_GLB_DAI_MSG | SOF_IPC_DAI_CONFIG;
+	config.type = SOF_DAI_INTEL_ALH;
+	config.dai_index = (link_id << 8) | d->id;
+	config.alh.stream_id = 0xFFFF; /* invalid value on purpose */
+
+	/* send message to DSP */
+	ret = sof_ipc_tx_message(sdev->ipc,
+				 config.hdr.cmd, &config, size, &reply,
+				 sizeof(reply));
+	if (ret < 0) {
+		dev_err(sdev->dev,
+			"error: failed to free stream for link %d dai->id %d\n",
+			link_id, d->id);
+	}
+
+	return ret;
+}
+
+static const struct sdw_intel_ops sdw_callback = {
+	.params_stream = sdw_params_stream,
+	.free_stream = sdw_free_stream,
+};
+
 static void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
 {
 	if (enable) {
@@ -93,6 +161,8 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 	res.irq = sdev->ipc_irq;
 	res.handle = hdev->info.handle;
 	res.parent = sdev->dev;
+	res.ops = &sdw_callback;
+	res.dev = sdev->dev;
 
 	/*
 	 * ops and arg fields are not populated for now,
-- 
2.20.1

