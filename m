Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F868C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184632339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfHUUSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:18:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:5740 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbfHUUSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:18:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 13:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="186344211"
Received: from smasango-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.139.100])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Aug 2019 13:18:04 -0700
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
        YueHaibing <yuehaibing@huawei.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC PATCH 4/5] ASoC: SOF: Intel: hda: add SoundWire stream config/free callbacks
Date:   Wed, 21 Aug 2019 15:17:19 -0500
Message-Id: <20190821201720.17768-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
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
 sound/soc/sof/intel/hda.c | 66 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index e754058e3679..1e84ea9e6fce 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -53,6 +53,70 @@ static void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
 					0);
 }
 
+static int sdw_config_stream(void *arg, void *s, void *dai,
+			     void *params, int link_id, int alh_stream_id)
+{
+	struct snd_sof_dev *sdev = arg;
+	struct snd_soc_dai *d = dai;
+	struct sof_ipc_dai_config config;
+	struct sof_ipc_reply reply;
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
+static int sdw_free_stream(void *arg, void *s, void *dai, int link_id)
+{
+	struct snd_sof_dev *sdev = arg;
+	struct snd_soc_dai *d = dai;
+	struct sof_ipc_dai_config config;
+	struct sof_ipc_reply reply;
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
+	.config_stream = sdw_config_stream,
+	.free_stream = sdw_free_stream,
+};
+
 static int hda_sdw_init(struct snd_sof_dev *sdev)
 {
 	acpi_handle handle;
@@ -67,6 +131,8 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
 	res.mmio_base = sdev->bar[HDA_DSP_BAR];
 	res.irq = sdev->ipc_irq;
 	res.parent = sdev->dev;
+	res.ops = &sdw_callback;
+	res.arg = sdev;
 
 	sdw = sdw_intel_init(handle, &res);
 	if (!sdw) {
-- 
2.20.1

