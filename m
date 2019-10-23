Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83BBCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7502064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406034AbfJWVPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:15:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:45612 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732586AbfJWVPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:15:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="373003416"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by orsmga005.jf.intel.com with ESMTP; 23 Oct 2019 14:15:28 -0700
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
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>
Subject: [PATCH 1/5] ASoC: SOF: Intel: add SoundWire configuration interface
Date:   Wed, 23 Oct 2019 16:15:00 -0500
Message-Id: <20191023211504.32675-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023211504.32675-1-pierre-louis.bossart@linux.intel.com>
References: <20191023211504.32675-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SoundWire core supports the multi-step initialization,
call the relevant APIs.

The actual hardware enablement can be done in two places, ideally we'd
want to startup the SoundWire IP as soon as possible (while still
taking power rail dependencies into account)

However when suspend/resume is implemented, the DSP device will be
resumed first, and only when the DSP firmware is downloaded/booted
would the SoundWire child devices be resumed, so there are only
marginal benefits in starting the IP earlier for the first probe.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-loader.c |  13 ++++
 sound/soc/sof/intel/hda.c        | 121 ++++++++++++++++++++++++++++++-
 sound/soc/sof/intel/hda.h        |  44 +++++++++++
 3 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index b1783360fe10..2f5cd2c1ea3c 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -397,6 +397,19 @@ int hda_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 /* post fw run operations */
 int hda_dsp_post_fw_run(struct snd_sof_dev *sdev)
 {
+	int ret;
+
+	if (sdev->first_boot) {
+		ret = hda_sdw_startup(sdev);
+		if (ret < 0) {
+			dev_err(sdev->dev,
+				"error: could not startup SoundWire links\n");
+			return ret;
+		}
+	}
+
+	hda_sdw_int_enable(sdev, true);
+
 	/* re-enable clock gating and power gating */
 	return hda_dsp_ctrl_clock_power_gating(sdev, true);
 }
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 103f4273c4d3..7e36f3bd6b39 100644
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
@@ -34,6 +36,98 @@
 
 #define EXCEPT_MAX_HDR_SIZE	0x400
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
+
+void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
+{
+	sdw_intel_enable_irq(sdev->bar[HDA_DSP_BAR], enable);
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
+
+	hdev = sdev->pdata->hw_pdata;
+
+	return sdw_intel_startup(hdev->sdw);
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
@@ -337,11 +431,11 @@ static const char *fixup_tplg_name(struct snd_sof_dev *sdev,
 static int hda_init_caps(struct snd_sof_dev *sdev)
 {
 	struct hdac_bus *bus = sof_to_bus(sdev);
+	struct snd_sof_pdata *pdata = sdev->pdata;
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	struct hdac_ext_link *hlink;
 	struct snd_soc_acpi_mach_params *mach_params;
 	struct snd_soc_acpi_mach *hda_mach;
-	struct snd_sof_pdata *pdata = sdev->pdata;
 	struct snd_soc_acpi_mach *mach;
 	const char *tplg_filename;
 	const char *idisp_str;
@@ -350,6 +444,8 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	int codec_num = 0;
 	int i;
 #endif
+	struct sof_intel_hda_dev *hdev = pdata->hw_pdata;
+	u32 link_mask;
 	int ret = 0;
 
 	device_disable_async_suspend(bus->dev);
@@ -378,6 +474,27 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
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
@@ -682,6 +799,8 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 	snd_hdac_ext_bus_device_remove(bus);
 #endif
 
+	hda_sdw_exit(sdev);
+
 	if (!IS_ERR_OR_NULL(hda->dmic_dev))
 		platform_device_unregister(hda->dmic_dev);
 
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 0e7c366b8f71..e63630f5c547 100644
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
@@ -408,6 +410,12 @@ struct sof_intel_hda_dev {
 
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
@@ -598,6 +606,42 @@ int hda_dsp_trace_init(struct snd_sof_dev *sdev, u32 *stream_tag);
 int hda_dsp_trace_release(struct snd_sof_dev *sdev);
 int hda_dsp_trace_trigger(struct snd_sof_dev *sdev, int cmd);
 
+/*
+ * SoundWire support
+ */
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
+
+int hda_sdw_startup(struct snd_sof_dev *sdev);
+void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable);
+
+#else
+
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
+
+static inline void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
+{
+}
+
+#endif
+
 /* common dai driver */
 extern struct snd_soc_dai_driver skl_dai[];
 
-- 
2.20.1

