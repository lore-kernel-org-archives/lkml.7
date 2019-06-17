Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9DBC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9309D2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfFQLe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:34:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:54390 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfFQLey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:34:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 04:34:54 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2019 04:34:51 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2 01/11] ASoC: Intel: Skylake: Initialize lists before access so they are safe to use
Date:   Mon, 17 Jun 2019 13:36:34 +0200
Message-Id: <20190617113644.25621-2-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If skl_probe_work() was not run driver ends up dereferencing NULL
pointer when operating on lists in skl_platform_unregister().
To fix this initialize lists in skl_create(). Also run
cancel_work_sync() before all cleanup functions, so we don't end up
unnecessarily running probe work.

Easily reproducible with:
while true; do modprobe snd_soc_skl; rmmod snd_soc_skl; done
(with the assumption that relevant drivers are added to blacklist on
system boot)

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 3 ---
 sound/soc/intel/skylake/skl.c     | 5 ++++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 8b7232d3ffee..489ecef311ad 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1477,9 +1477,6 @@ int skl_platform_register(struct device *dev)
 	struct hdac_bus *bus = dev_get_drvdata(dev);
 	struct skl *skl = bus_to_skl(bus);
 
-	INIT_LIST_HEAD(&skl->ppl_list);
-	INIT_LIST_HEAD(&skl->bind_list);
-
 	skl->dais = kmemdup(skl_platform_dai, sizeof(skl_platform_dai),
 			    GFP_KERNEL);
 	if (!skl->dais) {
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index fc79401cd474..cae97c65eef8 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -430,7 +430,6 @@ static int skl_free(struct hdac_bus *bus)
 
 	snd_hdac_ext_bus_exit(bus);
 
-	cancel_work_sync(&skl->probe_work);
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
 		snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
 		snd_hdac_i915_exit(bus);
@@ -859,6 +858,9 @@ static int skl_create(struct pci_dev *pci,
 	hbus = skl_to_hbus(skl);
 	bus = skl_to_bus(skl);
 
+	INIT_LIST_HEAD(&skl->ppl_list);
+	INIT_LIST_HEAD(&skl->bind_list);
+
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC)
 	ext_ops = snd_soc_hdac_hda_get_ops();
 #endif
@@ -1108,6 +1110,7 @@ static void skl_remove(struct pci_dev *pci)
 	struct hdac_bus *bus = pci_get_drvdata(pci);
 	struct skl *skl = bus_to_skl(bus);
 
+	cancel_work_sync(&skl->probe_work);
 	release_firmware(skl->tplg);
 
 	pm_runtime_get_noresume(&pci->dev);
-- 
2.17.1

