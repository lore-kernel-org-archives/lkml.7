Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4782BC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272FA208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfFQLfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:35:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:54390 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbfFQLfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:35:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 04:35:10 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2019 04:35:06 -0700
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
Subject: [PATCH v2 07/11] ASoC: Intel: Skylake: Properly cleanup on component removal
Date:   Mon, 17 Jun 2019 13:36:40 +0200
Message-Id: <20190617113644.25621-8-amadeuszx.slawinski@linux.intel.com>
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

When we remove component we need to reverse things which were done on
init, this consists of topology cleanup, lists cleanup and releasing
firmware.

Currently cleanup handlers are put in wrong places or otherwise missing.
So add proper component cleanup function and perform cleanups in it.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c      |  8 ++++++--
 sound/soc/intel/skylake/skl-topology.c | 15 +++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |  2 ++
 sound/soc/intel/skylake/skl.c          |  2 --
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 5e3421cc0feb..af479e9c8d0b 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1450,8 +1450,12 @@ static int skl_platform_soc_probe(struct snd_soc_component *component)
 
 static void skl_pcm_remove(struct snd_soc_component *component)
 {
-	/* remove topology */
-	snd_soc_tplg_component_remove(component, SND_SOC_TPLG_INDEX_ALL);
+	struct hdac_bus *bus = dev_get_drvdata(component->dev);
+	struct skl *skl = bus_to_skl(bus);
+
+	skl_tplg_exit(component, bus);
+
+	skl_debugfs_exit(skl);
 }
 
 static const struct snd_soc_component_driver skl_component  = {
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 44f3b29a7210..3964262109ac 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3748,3 +3748,18 @@ int skl_tplg_init(struct snd_soc_component *component, struct hdac_bus *bus)
 
 	return 0;
 }
+
+void skl_tplg_exit(struct snd_soc_component *component, struct hdac_bus *bus)
+{
+	struct skl *skl = bus_to_skl(bus);
+	struct skl_pipeline *ppl, *tmp;
+
+	if (!list_empty(&skl->ppl_list))
+		list_for_each_entry_safe(ppl, tmp, &skl->ppl_list, node)
+			list_del(&ppl->node);
+
+	/* clean up topology */
+	snd_soc_tplg_component_remove(component, SND_SOC_TPLG_INDEX_ALL);
+
+	release_firmware(skl->tplg);
+}
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index b66e3a728853..a8ecb615d24b 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -462,6 +462,8 @@ void skl_tplg_set_be_dmic_config(struct snd_soc_dai *dai,
 	struct skl_pipe_params *params, int stream);
 int skl_tplg_init(struct snd_soc_component *component,
 				struct hdac_bus *ebus);
+void skl_tplg_exit(struct snd_soc_component *component,
+				struct hdac_bus *bus);
 struct skl_module_cfg *skl_tplg_fe_get_cpr_module(
 		struct snd_soc_dai *dai, int stream);
 int skl_tplg_update_pipe_params(struct device *dev,
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index cae97c65eef8..7e093fb13c92 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1111,14 +1111,12 @@ static void skl_remove(struct pci_dev *pci)
 	struct skl *skl = bus_to_skl(bus);
 
 	cancel_work_sync(&skl->probe_work);
-	release_firmware(skl->tplg);
 
 	pm_runtime_get_noresume(&pci->dev);
 
 	/* codec removal, invoke bus_device_remove */
 	snd_hdac_ext_bus_device_remove(bus);
 
-	skl->debugfs = NULL;
 	skl_platform_unregister(&pci->dev);
 	skl_free_dsp(skl);
 	skl_machine_device_unregister(skl);
-- 
2.17.1

