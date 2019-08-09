Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1D9C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A806520C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405997AbfHIIlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:41:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:29946 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfHIIlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:41:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 01:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="193349073"
Received: from smielczx-ws.igk.intel.com ([10.237.93.152])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2019 01:41:09 -0700
From:   Szymon Mielczarek <szymonx.mielczarek@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Szymon Mielczarek <szymonx.mielczarek@linux.intel.com>
Subject: [RFC PATCH] ASoC: dapm: Invalidate only paths reachable for a given stream
Date:   Fri,  9 Aug 2019 10:40:34 +0200
Message-Id: <20190809084034.26220-1-szymonx.mielczarek@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By resetting the cached number of endpoints for all card's widgets we may
overwrite previously cached values for other streams. The situation may
happen especially when running streams simultaneously.

Signed-off-by: Szymon Mielczarek <szymonx.mielczarek@linux.intel.com>
---
 sound/soc/soc-dapm.c | 50 ++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d09bdca63c62..10819b3e0b98 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1128,6 +1128,34 @@ static int dapm_widget_list_create(struct snd_soc_dapm_widget_list **list,
 	return 0;
 }
 
+/*
+ * Recursively reset the cached number of inputs or outputs for the specified
+ * widget and all widgets that can be reached via incoming or outcoming paths
+ * from the widget.
+ */
+static void invalidate_paths_ep(struct snd_soc_dapm_widget *widget,
+	enum snd_soc_dapm_direction dir)
+{
+	enum snd_soc_dapm_direction rdir = SND_SOC_DAPM_DIR_REVERSE(dir);
+	struct snd_soc_dapm_path *path;
+
+	widget->endpoints[dir] = -1;
+
+	snd_soc_dapm_widget_for_each_path(widget, rdir, path) {
+		if (path->weak || path->is_supply)
+			continue;
+
+		if (path->walking)
+			return;
+
+		if (path->connect) {
+			path->walking = 1;
+			invalidate_paths_ep(path->node[dir], dir);
+			path->walking = 0;
+		}
+	}
+}
+
 /*
  * Common implementation for is_connected_output_ep() and
  * is_connected_input_ep(). The function is inlined since the combined size of
@@ -1257,21 +1285,17 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
-	/*
-	 * For is_connected_{output,input}_ep fully discover the graph we need
-	 * to reset the cached number of inputs and outputs.
-	 */
-	list_for_each_entry(w, &card->widgets, list) {
-		w->endpoints[SND_SOC_DAPM_DIR_IN] = -1;
-		w->endpoints[SND_SOC_DAPM_DIR_OUT] = -1;
-	}
-
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		paths = is_connected_output_ep(dai->playback_widget, &widgets,
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		w = dai->playback_widget;
+		invalidate_paths_ep(w, SND_SOC_DAPM_DIR_OUT);
+		paths = is_connected_output_ep(w, &widgets,
 				custom_stop_condition);
-	else
-		paths = is_connected_input_ep(dai->capture_widget, &widgets,
+	} else {
+		w = dai->capture_widget;
+		invalidate_paths_ep(w, SND_SOC_DAPM_DIR_IN);
+		paths = is_connected_input_ep(w, &widgets,
 				custom_stop_condition);
+	}
 
 	/* Drop starting point */
 	list_del(widgets.next);
-- 
2.17.1

