Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775A2C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524B7214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfIPVo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:44:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:63041 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbfIPVo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:44:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 14:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="198480213"
Received: from dgitin-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.142.45])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2019 14:44:25 -0700
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
Subject: [RFC PATCH 12/12] ASoC: SOF: Intel: hda: initial SoundWire machine driver autodetect
Date:   Mon, 16 Sep 2019 16:42:51 -0500
Message-Id: <20190916214251.13130-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
References: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now we have a limited number of machine driver configurations, and
we can detect them based on the link configuration returned after
checking hardware and firmware (BIOS) configurations.

It's likely that in the future we will need to check for _ADR match as
well, which can easily be done by extending the acpi_info structure.

There is a chance that in extreme cases where the BIOS contains too
much information we would need to detect which Slave devices actually
report as 'attached'. This would be more accurate than static
table-based solutions, but it also introduces timing dependencies
since we don't know when those devices might become attached, so will
only be only be looked at if we see limitations with static methods
and the usual quirks based e.g. on DMI information.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 58 +++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 02291e1de1fc..ebd78ee8dfb7 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -523,12 +523,12 @@ static const char *fixup_tplg_name(struct snd_sof_dev *sdev,
 static int hda_init_caps(struct snd_sof_dev *sdev)
 {
 	struct hdac_bus *bus = sof_to_bus(sdev);
+	struct snd_soc_acpi_mach *mach;
+	struct snd_sof_pdata *pdata = sdev->pdata;
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	struct hdac_ext_link *hlink;
-	struct snd_soc_acpi_mach_params *mach_params;
 	struct snd_soc_acpi_mach *hda_mach;
-	struct snd_sof_pdata *pdata = sdev->pdata;
-	struct snd_soc_acpi_mach *mach;
+	struct snd_soc_acpi_mach_params *mach_params;
 	const char *tplg_filename;
 	const char *idisp_str;
 	const char *dmic_str;
@@ -536,7 +536,7 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	int codec_num = 0;
 	int i;
 #endif
-	struct sof_intel_hda_dev *hdev;
+	struct sof_intel_hda_dev *hdev = pdata->hw_pdata;
 	u32 link_mask;
 	int ret = 0;
 
@@ -574,19 +574,49 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	}
 
 	link_mask = hdev->info.link_mask;
-	if (!link_mask) {
-		/*
-		 * probe/allocated SoundWire resources.
-		 * The hardware configuration takes place in hda_sdw_startup
-		 * after power rails are enabled.
-		 */
-		ret = hda_sdw_probe(sdev);
-		if (ret < 0) {
-			dev_err(sdev->dev, "error: SoundWire probe error\n");
-			return ret;
+	if (!link_mask)
+		goto skip_soundwire;
+
+	/*
+	 * probe/allocate SoundWire resources.
+	 * The hardware configuration takes place in hda_sdw_startup
+	 * after power rails are enabled.
+	 * It's entirely possible to have a mix of I2S/DMIC/SoundWire
+	 * devices, so we allocate the resources in all cases.
+	 */
+	ret = hda_sdw_probe(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: SoundWire probe error\n");
+		return ret;
+	}
+
+	/*
+	 * Select SoundWire machine driver if needed using the
+	 * alternate tables. This case deals with SoundWire-only
+	 * machines, for mixed cases with I2C/I2S the detection relies
+	 * on the HID list.
+	 */
+	if (!pdata->machine) {
+		mach = pdata->desc->alt_machines;
+		while (mach && mach->link_mask && mach->link_mask != link_mask)
+			mach++;
+		if (mach && mach->link_mask) {
+			dev_dbg(bus->dev,
+				"SoundWire machine driver %s topology %s\n",
+				mach->drv_name,
+				mach->sof_tplg_filename);
+			pdata->machine = mach;
+			mach->mach_params.platform = dev_name(sdev->dev);
+			pdata->fw_filename = mach->sof_fw_filename;
+			pdata->tplg_filename = mach->sof_tplg_filename;
+		} else {
+			dev_info(sdev->dev,
+				 "No SoundWire machine driver found\n");
 		}
 	}
 
+skip_soundwire:
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	if (bus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(bus);
-- 
2.20.1

