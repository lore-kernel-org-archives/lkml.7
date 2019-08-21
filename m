Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B45C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194712332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfHUURv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:17:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:4116 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729467AbfHUURu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:17:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 13:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="186344150"
Received: from smasango-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.139.100])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Aug 2019 13:17:46 -0700
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
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH 2/5] ASoC: SOF: Intel: hda: add helper to initialize SoundWire IP
Date:   Wed, 21 Aug 2019 15:17:17 -0500
Message-Id: <20190821201720.17768-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper calls the SoundWire initializations and sets the resource
structure defined as an interface with the platform driver. The
resource deals with PCI base address, interrupts and the callback for
the stream configuration.

The interrupts are gated/ungated at the top-level with the
ADSPIPC2.SNDW field

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 63 +++++++++++++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda.h |  1 +
 2 files changed, 64 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index c72e9a09eee1..a968890d0754 100644
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
@@ -35,6 +37,67 @@
 #define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
 #define IS_CNL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9dc8)
 
+#if IS_ENABLED(CONFIG_SOUNDWIRE_INTEL)
+
+static void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
+{
+	if (enable)
+		snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR,
+					HDA_DSP_REG_ADSPIC2,
+					HDA_DSP_ADSPIC2_SNDW,
+					HDA_DSP_ADSPIC2_SNDW);
+	else
+		snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR,
+					HDA_DSP_REG_ADSPIC2,
+					HDA_DSP_ADSPIC2_SNDW,
+					0);
+}
+
+static int hda_sdw_init(struct snd_sof_dev *sdev)
+{
+	acpi_handle handle;
+	struct sdw_intel_res res;
+
+	handle = ACPI_HANDLE(sdev->dev);
+
+	memset(&res, 0, sizeof(res));
+
+	res.mmio_base = sdev->bar[HDA_DSP_BAR];
+	res.irq = sdev->ipc_irq;
+	res.parent = sdev->dev;
+
+	hda_sdw_int_enable(sdev, true);
+
+	sdev->sdw = sdw_intel_init(handle, &res);
+	if (!sdev->sdw) {
+		dev_err(sdev->dev, "SDW Init failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int hda_sdw_exit(struct snd_sof_dev *sdev)
+{
+	hda_sdw_int_enable(sdev, false);
+
+	if (sdev->sdw)
+		sdw_intel_exit(sdev->sdw);
+
+	return 0;
+}
+#else
+static int hda_sdw_init(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static int hda_sdw_exit(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+#endif
+
 /*
  * Debug
  */
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 5591841a1b6f..c8f93317aeb4 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -211,6 +211,7 @@
 
 #define HDA_DSP_ADSPIC_IPC			1
 #define HDA_DSP_ADSPIS_IPC			1
+#define HDA_DSP_ADSPIC2_SNDW			BIT(5)
 
 /* Intel HD Audio General DSP Registers */
 #define HDA_DSP_GEN_BASE		0x0
-- 
2.20.1

