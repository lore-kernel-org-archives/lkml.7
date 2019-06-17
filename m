Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60235C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E9C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfFQLfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:35:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:54390 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728308AbfFQLfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:35:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 04:35:17 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2019 04:35:15 -0700
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
Subject: [PATCH v2 10/11] ASoC: topology: Consolidate how dtexts and dvalues are freed
Date:   Mon, 17 Jun 2019 13:36:43 +0200
Message-Id: <20190617113644.25621-11-amadeuszx.slawinski@linux.intel.com>
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

Provide helper functions and use them to free dtexts and dvalues in
topology. This is followup cleanup after related changes in this area as
suggested in:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-topology.c | 41 +++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index b538412e4bcf..a926c2afbe05 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -86,6 +86,8 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 struct snd_soc_dapm_widget *
 snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 			 const struct snd_soc_dapm_widget *widget);
+static void soc_tplg_denum_remove_texts(struct soc_enum *se);
+static void soc_tplg_denum_remove_values(struct soc_enum *se);
 
 /* check we dont overflow the data for this control chunk */
 static int soc_tplg_check_elem_count(struct soc_tplg *tplg, size_t elem_size,
@@ -398,7 +400,6 @@ static void remove_enum(struct snd_soc_component *comp,
 {
 	struct snd_card *card = comp->card->snd_card;
 	struct soc_enum *se = container_of(dobj, struct soc_enum, dobj);
-	int i;
 
 	if (pass != SOC_TPLG_PASS_MIXER)
 		return;
@@ -409,10 +410,8 @@ static void remove_enum(struct snd_soc_component *comp,
 	snd_ctl_remove(card, dobj->control.kcontrol);
 	list_del(&dobj->list);
 
-	kfree(dobj->control.dvalues);
-	for (i = 0; i < se->items; i++)
-		kfree(dobj->control.dtexts[i]);
-	kfree(dobj->control.dtexts);
+	soc_tplg_denum_remove_values(se);
+	soc_tplg_denum_remove_texts(se);
 	kfree(se);
 }
 
@@ -480,15 +479,12 @@ static void remove_widget(struct snd_soc_component *comp,
 			struct snd_kcontrol *kcontrol = w->kcontrols[i];
 			struct soc_enum *se =
 				(struct soc_enum *)kcontrol->private_value;
-			int j;
 
 			snd_ctl_remove(card, kcontrol);
 
 			/* free enum kcontrol's dvalues and dtexts */
-			kfree(se->dobj.control.dvalues);
-			for (j = 0; j < se->items; j++)
-				kfree(se->dobj.control.dtexts[j]);
-			kfree(se->dobj.control.dtexts);
+			soc_tplg_denum_remove_values(se);
+			soc_tplg_denum_remove_texts(se);
 
 			kfree(se);
 			kfree(w->kcontrol_news[i].name);
@@ -956,14 +952,23 @@ static int soc_tplg_denum_create_texts(struct soc_enum *se,
 		}
 	}
 
+	se->items = le32_to_cpu(ec->items);
 	se->texts = (const char * const *)se->dobj.control.dtexts;
 	return 0;
 
 err:
+	se->items = i;
+	soc_tplg_denum_remove_texts(se);
+	return ret;
+}
+
+static inline void soc_tplg_denum_remove_texts(struct soc_enum *se)
+{
+	int i = se->items;
+
 	for (--i; i >= 0; i--)
 		kfree(se->dobj.control.dtexts[i]);
 	kfree(se->dobj.control.dtexts);
-	return ret;
 }
 
 static int soc_tplg_denum_create_values(struct soc_enum *se,
@@ -988,6 +993,11 @@ static int soc_tplg_denum_create_values(struct soc_enum *se,
 	return 0;
 }
 
+static inline void soc_tplg_denum_remove_values(struct soc_enum *se)
+{
+	kfree(se->dobj.control.dvalues);
+}
+
 static int soc_tplg_denum_create(struct soc_tplg *tplg, unsigned int count,
 	size_t size)
 {
@@ -1035,7 +1045,6 @@ static int soc_tplg_denum_create(struct soc_tplg *tplg, unsigned int count,
 		se->shift_r = tplc_chan_get_shift(tplg, ec->channel,
 			SNDRV_CHMAP_FL);
 
-		se->items = le32_to_cpu(ec->items);
 		se->mask = le32_to_cpu(ec->mask);
 		se->dobj.index = tplg->index;
 		se->dobj.type = SND_SOC_DOBJ_ENUM;
@@ -1381,7 +1390,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 	struct snd_kcontrol_new *kc;
 	struct snd_soc_tplg_enum_control *ec;
 	struct soc_enum *se;
-	int i, j, err;
+	int i, err;
 
 	kc = kcalloc(num_kcontrols, sizeof(*kc), GFP_KERNEL);
 	if (kc == NULL)
@@ -1476,10 +1485,8 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 		if (!se)
 			continue;
 
-		kfree(se->dobj.control.dvalues);
-		for (j = 0; j < ec->items; j++)
-			kfree(se->dobj.control.dtexts[j]);
-		kfree(se->dobj.control.dtexts);
+		soc_tplg_denum_remove_values(se);
+		soc_tplg_denum_remove_texts(se);
 
 		kfree(se);
 		kfree(kc[i].name);
-- 
2.17.1

