Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B124AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A43214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfH0ONJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:13:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:10800 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbfH0ONG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:13:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 07:13:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="264282475"
Received: from xxx.igk.intel.com ([10.237.93.170])
  by orsmga001.jf.intel.com with ESMTP; 27 Aug 2019 07:13:03 -0700
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
Subject: [PATCH 5/6] ASoC: Intel: Skylake: Release topology when we are done with it
Date:   Tue, 27 Aug 2019 16:17:11 +0200
Message-Id: <20190827141712.21015-6-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
References: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently topology is kept in memory while driver is running. It's
unnecessary, as it's only needed during parsing.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 20 ++++++++++----------
 sound/soc/intel/skylake/skl.h          |  1 -
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ae5c75d03fdc..69cd7a81bf2a 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3579,23 +3579,25 @@ int skl_tplg_init(struct snd_soc_component *component, struct hdac_bus *bus)
 	 * The complete tplg for SKL is loaded as index 0, we don't use
 	 * any other index
 	 */
-	ret = snd_soc_tplg_component_load(component,
-					&skl_tplg_ops, fw, 0);
+	ret = snd_soc_tplg_component_load(component, &skl_tplg_ops, fw, 0);
 	if (ret < 0) {
 		dev_err(bus->dev, "tplg component load failed%d\n", ret);
-		release_firmware(fw);
-		return -EINVAL;
+		goto err;
 	}
 
-	skl->tplg = fw;
 	ret = skl_tplg_create_pipe_widget_list(component);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		dev_err(bus->dev, "tplg create pipe widget list failed%d\n",
+				ret);
+		goto err;
+	}
 
 	list_for_each_entry(ppl, &skl->ppl_list, node)
 		skl_tplg_set_pipe_type(skl, ppl->pipe);
 
-	return 0;
+err:
+	release_firmware(fw);
+	return ret;
 }
 
 void skl_tplg_exit(struct snd_soc_component *component, struct hdac_bus *bus)
@@ -3609,6 +3611,4 @@ void skl_tplg_exit(struct snd_soc_component *component, struct hdac_bus *bus)
 
 	/* clean up topology */
 	snd_soc_tplg_component_remove(component, SND_SOC_TPLG_INDEX_ALL);
-
-	release_firmware(skl->tplg);
 }
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index f8c714153610..2bfbf59277c4 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -75,7 +75,6 @@ struct skl_dev {
 	const char *fw_name;
 	char tplg_name[64];
 	unsigned short pci_id;
-	const struct firmware *tplg;
 
 	int supend_active;
 
-- 
2.17.1

