Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DA3C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E4C214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbfIPVnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:43:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:28422 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbfIPVnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:43:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 14:43:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="198480010"
Received: from dgitin-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.142.45])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2019 14:43:37 -0700
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
        Keyon Jie <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [RFC PATCH 04/12] ASoC: SOF: Intel: add SoundWire configuration interface
Date:   Mon, 16 Sep 2019 16:42:43 -0500
Message-Id: <20190916214251.13130-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
References: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SoundWire core supports the multi-step initialization,
call the relevant APIs.

The actual hardware enablement can be done in two places, ideally we'd
want to startup the IP as soon as possible but we need to work-out
additional hardware dependencies in corner cases. For the time being
the default is to startup the IP after the firmware is downloaded.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-loader.c |   9 ++
 sound/soc/sof/intel/hda.c        | 155 +++++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda.h        |  36 +++++++
 3 files changed, 200 insertions(+)

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 65c2af3fcaab..5f9f3eb26daa 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -378,6 +378,15 @@ int hda_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 /* post fw run operations */
 int hda_dsp_post_fw_run(struct snd_sof_dev *sdev)
 {
+#ifndef SOUNDWIRE_POWER_FIRST
+	int ret;
+
+	ret = hda_sdw_startup(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: could not startup SoundWire links\n");
+		return ret;
+	}
+#endif
 	/* re-enable clock gating and power gating */
 	return hda_dsp_ctrl_clock_power_gating(sdev, true);
 }
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 06e84679087b..d129d5c68f5e 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -18,7 +18,9 @@
 #include <sound/hdaudio_ext.h>
 #include <sound/hda_register.h>
 
+#include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/soundwire/sdw_intel.h>
 #include <sound/intel-nhlt.h>
 #include <sound/sof.h>
 #include <sound/sof/xtensa.h>
@@ -37,6 +39,114 @@
 
 #define EXCEPT_MAX_HDR_SIZE	0x400
 
+#if IS_ENABLED(CONFIG_SOUNDWIRE_INTEL)
+
+static void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
+{
+	if (enable) {
+		snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR,
+					HDA_DSP_REG_ADSPIC2,
+					HDA_DSP_ADSPIC2_SNDW,
+					HDA_DSP_ADSPIC2_SNDW);
+	} else {
+		snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR,
+					HDA_DSP_REG_ADSPIC2,
+					HDA_DSP_ADSPIC2_SNDW,
+					0);
+	}
+}
+
+static int hda_sdw_acpi_scan(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hdev;
+	acpi_handle handle;
+	int ret;
+
+	handle = ACPI_HANDLE(sdev->dev);
+
+	/* save ACPI info for the probe step */
+	hdev = sdev->pdata->hw_pdata;
+
+	ret = sdw_intel_acpi_scan(handle, &hdev->info);
+	if (ret < 0) {
+		dev_err(sdev->dev, "%s failed\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hda_sdw_probe(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hdev;
+	struct sdw_intel_res res;
+	acpi_handle handle;
+	void *sdw;
+
+	handle = ACPI_HANDLE(sdev->dev);
+
+	hdev = sdev->pdata->hw_pdata;
+
+	memset(&res, 0, sizeof(res));
+
+	res.mmio_base = sdev->bar[HDA_DSP_BAR];
+	res.irq = sdev->ipc_irq;
+	res.handle = hdev->info.handle;
+	res.parent = sdev->dev;
+
+	/*
+	 * ops and arg fields are not populated for now,
+	 * they will be needed when the DAI callbacks are
+	 * provided
+	 */
+
+	/* we could filter links here if needed, e.g for quirks */
+	res.count = hdev->info.count;
+	res.link_mask = hdev->info.link_mask;
+
+	sdw = sdw_intel_probe(&res);
+	if (!sdw) {
+		dev_err(sdev->dev, "error: SoundWire probe failed\n");
+		return -EINVAL;
+	}
+
+	/* save context */
+	hdev->sdw = sdw;
+
+	return 0;
+}
+
+int hda_sdw_startup(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hdev;
+	int ret;
+
+	hdev = sdev->pdata->hw_pdata;
+
+	ret = sdw_intel_startup(hdev->sdw);
+	if (ret < 0)
+		return ret;
+	hda_sdw_int_enable(sdev, true);
+
+	return ret;
+}
+
+static int hda_sdw_exit(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hdev;
+
+	hdev = sdev->pdata->hw_pdata;
+
+	hda_sdw_int_enable(sdev, false);
+
+	if (hdev->sdw)
+		sdw_intel_exit(hdev->sdw);
+	hdev->sdw = NULL;
+
+	return 0;
+}
+#endif
+
 /*
  * Debug
  */
@@ -356,6 +466,8 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	int codec_num = 0;
 	int i;
 #endif
+	struct sof_intel_hda_dev *hdev;
+	u32 link_mask;
 	int ret = 0;
 
 	device_disable_async_suspend(bus->dev);
@@ -384,6 +496,27 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 		return ret;
 	}
 
+	/* scan SoundWire capabilities exposed by DSDT */
+	ret = hda_sdw_acpi_scan(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: SoundWire ACPI scan error\n");
+		return ret;
+	}
+
+	link_mask = hdev->info.link_mask;
+	if (!link_mask) {
+		/*
+		 * probe/allocated SoundWire resources.
+		 * The hardware configuration takes place in hda_sdw_startup
+		 * after power rails are enabled.
+		 */
+		ret = hda_sdw_probe(sdev);
+		if (ret < 0) {
+			dev_err(sdev->dev, "error: SoundWire probe error\n");
+			return ret;
+		}
+	}
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	if (bus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(bus);
@@ -657,8 +790,28 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 	/* set default mailbox offset for FW ready message */
 	sdev->dsp_box.offset = HDA_DSP_MBOX_UPLINK_OFFSET;
 
+#ifdef SOUNDWIRE_POWER_FIRST
+	/* need to power-up core before setting-up capabilities */
+	ret = hda_dsp_core_power_up(sdev, HDA_DSP_CORE_MASK(0));
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: could not power-up DSP subsystem\n");
+		goto sdw_exit;
+	}
+
+	ret = hda_sdw_startup(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: could not startup SoundWire links\n");
+		goto core_power_down;
+	}
+#endif
 	return 0;
 
+#ifdef SOUNDWIRE_POWER_FIRST
+core_power_down:
+	hda_dsp_core_power_down(sdev, HDA_DSP_CORE_MASK(0));
+sdw_exit:
+	hda_sdw_exit(sdev);
+#endif
 free_ipc_irq:
 	free_irq(sdev->ipc_irq, sdev);
 free_hda_irq:
@@ -688,6 +841,8 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 	snd_hdac_ext_bus_device_remove(bus);
 #endif
 
+	hda_sdw_exit(sdev);
+
 	if (!IS_ERR_OR_NULL(hda->dmic_dev))
 		platform_device_unregister(hda->dmic_dev);
 
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 7a2ff8b3d8a4..ff93e8eb145c 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -11,6 +11,8 @@
 #ifndef __SOF_INTEL_HDA_H
 #define __SOF_INTEL_HDA_H
 
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_intel.h>
 #include <sound/hda_codec.h>
 #include <sound/hdaudio_ext.h>
 #include "shim.h"
@@ -218,6 +220,7 @@
 
 #define HDA_DSP_ADSPIC_IPC			1
 #define HDA_DSP_ADSPIS_IPC			1
+#define HDA_DSP_ADSPIC2_SNDW			BIT(5)
 
 /* Intel HD Audio General DSP Registers */
 #define HDA_DSP_GEN_BASE		0x0
@@ -405,6 +408,12 @@ struct sof_intel_hda_dev {
 
 	/* DMIC device */
 	struct platform_device *dmic_dev;
+
+	/* ACPI information stored between scan and probe steps */
+	struct sdw_intel_acpi_info info;
+
+	/* sdw context allocated by SoundWire driver */
+	struct sdw_intel_ctx *sdw;
 };
 
 static inline struct hdac_bus *sof_to_bus(struct snd_sof_dev *s)
@@ -595,6 +604,33 @@ int hda_dsp_trace_init(struct snd_sof_dev *sdev, u32 *stream_tag);
 int hda_dsp_trace_release(struct snd_sof_dev *sdev);
 int hda_dsp_trace_trigger(struct snd_sof_dev *sdev, int cmd);
 
+/*
+ * SoundWire support
+ */
+#if IS_ENABLED(CONFIG_SOUNDWIRE_INTEL)
+int hda_sdw_startup(struct snd_sof_dev *sdev);
+#else
+static inline int hda_sdw_acpi_scan(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static inline int hda_sdw_probe(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static inline int hda_sdw_startup(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static inline int hda_sdw_exit(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+#endif
+
 /* common dai driver */
 extern struct snd_soc_dai_driver skl_dai[];
 
-- 
2.20.1

