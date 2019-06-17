Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F9CC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30AD2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfFQLfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:35:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:54390 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbfFQLfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:35:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 04:35:20 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2019 04:35:18 -0700
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
Subject: [PATCH v2 11/11] ASoC: topology: Consolidate and fix asoc_tplg_dapm_widget_*_create flow
Date:   Mon, 17 Jun 2019 13:36:44 +0200
Message-Id: <20190617113644.25621-12-amadeuszx.slawinski@linux.intel.com>
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

There are a few soc_tplg_dapm_widget_*_create functions with similar
content, but slightly different flow, unify their flow and make sure
that we go to error handler and free memory in case of failure.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-topology.c | 77 ++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 42 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index a926c2afbe05..fc1f1d6f9e92 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1310,14 +1310,15 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 
 	for (i = 0; i < num_kcontrols; i++) {
 		mc = (struct snd_soc_tplg_mixer_control *)tplg->pos;
-		sm = kzalloc(sizeof(*sm), GFP_KERNEL);
-		if (sm == NULL)
-			goto err;
 
 		/* validate kcontrol */
 		if (strnlen(mc->hdr.name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
 			SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
-			goto err_str;
+			goto err_sm;
+
+		sm = kzalloc(sizeof(*sm), GFP_KERNEL);
+		if (sm == NULL)
+			goto err_sm;
 
 		tplg->pos += (sizeof(struct snd_soc_tplg_mixer_control) +
 			      le32_to_cpu(mc->priv.size));
@@ -1327,7 +1328,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 
 		kc[i].name = kstrdup(mc->hdr.name, GFP_KERNEL);
 		if (kc[i].name == NULL)
-			goto err_str;
+			goto err_sm;
 		kc[i].private_value = (long)sm;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = mc->hdr.access;
@@ -1353,8 +1354,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 		err = soc_tplg_kcontrol_bind_io(&mc->hdr, &kc[i], tplg);
 		if (err) {
 			soc_control_err(tplg, &mc->hdr, mc->hdr.name);
-			kfree(sm);
-			continue;
+			goto err_sm;
 		}
 
 		/* create any TLV data */
@@ -1367,20 +1367,19 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 			dev_err(tplg->dev, "ASoC: failed to init %s\n",
 				mc->hdr.name);
 			soc_tplg_free_tlv(tplg, &kc[i]);
-			kfree(sm);
-			continue;
+			goto err_sm;
 		}
 	}
 	return kc;
 
-err_str:
-	kfree(sm);
-err:
-	for (--i; i >= 0; i--) {
-		kfree((void *)kc[i].private_value);
+err_sm:
+	for (; i >= 0; i--) {
+		sm = (struct soc_mixer_control *)kc[i].private_value;
+		kfree(sm);
 		kfree(kc[i].name);
 	}
 	kfree(kc);
+
 	return NULL;
 }
 
@@ -1401,11 +1400,11 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 		/* validate kcontrol */
 		if (strnlen(ec->hdr.name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
 			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
-			goto err;
+			goto err_se;
 
 		se = kzalloc(sizeof(*se), GFP_KERNEL);
 		if (se == NULL)
-			goto err;
+			goto err_se;
 
 		tplg->pos += (sizeof(struct snd_soc_tplg_enum_control) +
 				ec->priv.size);
@@ -1414,10 +1413,8 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 			ec->hdr.name);
 
 		kc[i].name = kstrdup(ec->hdr.name, GFP_KERNEL);
-		if (kc[i].name == NULL) {
-			kfree(se);
+		if (kc[i].name == NULL)
 			goto err_se;
-		}
 		kc[i].private_value = (long)se;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = ec->hdr.access;
@@ -1482,44 +1479,43 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 	for (; i >= 0; i--) {
 		/* free values and texts */
 		se = (struct soc_enum *)kc[i].private_value;
-		if (!se)
-			continue;
 
-		soc_tplg_denum_remove_values(se);
-		soc_tplg_denum_remove_texts(se);
+		if (se) {
+			soc_tplg_denum_remove_values(se);
+			soc_tplg_denum_remove_texts(se);
+		}
 
 		kfree(se);
 		kfree(kc[i].name);
 	}
-err:
 	kfree(kc);
 
 	return NULL;
 }
 
 static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
-	struct soc_tplg *tplg, int count)
+	struct soc_tplg *tplg, int num_kcontrols)
 {
 	struct snd_soc_tplg_bytes_control *be;
-	struct soc_bytes_ext  *sbe;
+	struct soc_bytes_ext *sbe;
 	struct snd_kcontrol_new *kc;
 	int i, err;
 
-	kc = kcalloc(count, sizeof(*kc), GFP_KERNEL);
+	kc = kcalloc(num_kcontrols, sizeof(*kc), GFP_KERNEL);
 	if (!kc)
 		return NULL;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < num_kcontrols; i++) {
 		be = (struct snd_soc_tplg_bytes_control *)tplg->pos;
 
 		/* validate kcontrol */
 		if (strnlen(be->hdr.name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
 			SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
-			goto err;
+			goto err_sbe;
 
 		sbe = kzalloc(sizeof(*sbe), GFP_KERNEL);
 		if (sbe == NULL)
-			goto err;
+			goto err_sbe;
 
 		tplg->pos += (sizeof(struct snd_soc_tplg_bytes_control) +
 			      le32_to_cpu(be->priv.size));
@@ -1529,10 +1525,8 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 			be->hdr.name, be->hdr.access);
 
 		kc[i].name = kstrdup(be->hdr.name, GFP_KERNEL);
-		if (kc[i].name == NULL) {
-			kfree(sbe);
-			goto err;
-		}
+		if (kc[i].name == NULL)
+			goto err_sbe;
 		kc[i].private_value = (long)sbe;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = be->hdr.access;
@@ -1544,8 +1538,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 		err = soc_tplg_kcontrol_bind_io(&be->hdr, &kc[i], tplg);
 		if (err) {
 			soc_control_err(tplg, &be->hdr, be->hdr.name);
-			kfree(sbe);
-			continue;
+			goto err_sbe;
 		}
 
 		/* pass control to driver for optional further init */
@@ -1554,20 +1547,20 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 		if (err < 0) {
 			dev_err(tplg->dev, "ASoC: failed to init %s\n",
 				be->hdr.name);
-			kfree(sbe);
-			continue;
+			goto err_sbe;
 		}
 	}
 
 	return kc;
 
-err:
-	for (--i; i >= 0; i--) {
-		kfree((void *)kc[i].private_value);
+err_sbe:
+	for (; i >= 0; i--) {
+		sbe = (struct soc_bytes_ext *)kc[i].private_value;
+		kfree(sbe);
 		kfree(kc[i].name);
 	}
-
 	kfree(kc);
+
 	return NULL;
 }
 
-- 
2.17.1

