Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDA3C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C0B2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfHUUSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:18:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:54887 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbfHUUSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:18:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 13:18:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="186344192"
Received: from smasango-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.139.100])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Aug 2019 13:17:57 -0700
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
        YueHaibing <yuehaibing@huawei.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH 3/5] ASoC: SOF: Intel: hda: add SoundWire IP support
Date:   Wed, 21 Aug 2019 15:17:18 -0500
Message-Id: <20190821201720.17768-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Core0 needs to be powered before the SoundWire IP is initialized.

Call sdw_intel_init/exit and store the context. We only have one
context, but depending on the hardware capabilities and BIOS settings
may enable multiple SoundWire links.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 40 +++++++++++++++++++++++++++++++++------
 sound/soc/sof/intel/hda.h |  5 +++++
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index a968890d0754..e754058e3679 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -57,6 +57,8 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
 {
 	acpi_handle handle;
 	struct sdw_intel_res res;
+	struct sof_intel_hda_dev *hdev;
+	void *sdw;
 
 	handle = ACPI_HANDLE(sdev->dev);
 
@@ -66,23 +68,32 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
 	res.irq = sdev->ipc_irq;
 	res.parent = sdev->dev;
 
-	hda_sdw_int_enable(sdev, true);
-
-	sdev->sdw = sdw_intel_init(handle, &res);
-	if (!sdev->sdw) {
+	sdw = sdw_intel_init(handle, &res);
+	if (!sdw) {
 		dev_err(sdev->dev, "SDW Init failed\n");
 		return -EIO;
 	}
 
+	hda_sdw_int_enable(sdev, true);
+
+	/* save context */
+	hdev = sdev->pdata->hw_pdata;
+	hdev->sdw = sdw;
+
 	return 0;
 }
 
 static int hda_sdw_exit(struct snd_sof_dev *sdev)
 {
+	struct sof_intel_hda_dev *hdev;
+
+	hdev = sdev->pdata->hw_pdata;
+
 	hda_sdw_int_enable(sdev, false);
 
-	if (sdev->sdw)
-		sdw_intel_exit(sdev->sdw);
+	if (hdev->sdw)
+		sdw_intel_exit(hdev->sdw);
+	hdev->sdw = NULL;
 
 	return 0;
 }
@@ -713,6 +724,21 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 	/* set default mailbox offset for FW ready message */
 	sdev->dsp_box.offset = HDA_DSP_MBOX_UPLINK_OFFSET;
 
+	/* need to power-up core before setting-up capabilities */
+	ret = hda_dsp_core_power_up(sdev, HDA_DSP_CORE_MASK(0));
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: could not power-up DSP subsystem\n");
+		goto free_ipc_irq;
+	}
+
+	/* initialize SoundWire capabilities */
+	ret = hda_sdw_init(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: SoundWire get caps error\n");
+		hda_dsp_core_power_down(sdev, HDA_DSP_CORE_MASK(0));
+		goto free_ipc_irq;
+	}
+
 	return 0;
 
 free_ipc_irq:
@@ -744,6 +770,8 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 	snd_hdac_ext_bus_device_remove(bus);
 #endif
 
+	hda_sdw_exit(sdev);
+
 	if (!IS_ERR_OR_NULL(hda->dmic_dev))
 		platform_device_unregister(hda->dmic_dev);
 
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index c8f93317aeb4..48e09b7daf0a 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -399,6 +399,11 @@ struct sof_intel_hda_dev {
 
 	/* DMIC device */
 	struct platform_device *dmic_dev;
+
+#if IS_ENABLED(CONFIG_SOUNDWIRE_INTEL)
+	/* sdw context */
+	void *sdw;
+#endif
 };
 
 static inline struct hdac_bus *sof_to_bus(struct snd_sof_dev *s)
-- 
2.20.1

