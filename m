Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D732C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266A6216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564579058;
	bh=2N0684HTv95KKehklVxHq6DXS/I8WDSxRdv2AOlq4D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TLGH4CHLoYH/Tp7n21zQL2+glkq03Et3WjGlUl7IDW5ycJCsy84imT5ppkGbbWSiY
	 FekV9VE3tWw37PqY6PeoiJD/K1ptQFuhLUb0pC+iSUxz14RYNSJjjG6HDAg05oBVfT
	 A+iKIqqsprU56Y6os/dl0ctkXwxUYcqVHGbkS32s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfGaNRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfGaNRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:17:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D42D1208C3;
        Wed, 31 Jul 2019 13:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564579055;
        bh=2N0684HTv95KKehklVxHq6DXS/I8WDSxRdv2AOlq4D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/ZF9x1QBM+357qoGsgHV4h1NrNBK61dejrM8gXIaLR8Di+ACpJYhdhQ9PsH0R48G
         QzaC+dtY/QXTmVFc80dNuiOvMZk7iS0tlYvsB0GB0Zzw7BSbyS3va35/iyul5Zlaz1
         sMdMYUxXZdkA+xL3O1QaA3ZY4u7NFE84aiqJdKTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v2 2/3] ASoC: core: no need to check return value of debugfs_create functions
Date:   Wed, 31 Jul 2019 15:17:15 +0200
Message-Id: <20190731131716.9764-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731131716.9764-1-gregkh@linuxfoundation.org>
References: <20190731131716.9764-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Also, there is no need to store the individual debugfs file name, just
remove the whole directory all at once, saving a local variable.

Note, the soc-pcm "state" file has now moved to a subdirectory, as it is
only a good idea to save the dentries for debugfs directories, not
individual files, as the individual file debugfs functions are changing
to not return a dentry.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: rebase on 5.3-rc1
    change Subject line to match the subsystem better
    rework based on debugfs core now reporting errors.

 include/sound/soc.h  |  1 -
 sound/soc/soc-core.c | 43 ++++++-------------------------------------
 sound/soc/soc-dapm.c | 30 ++++--------------------------
 sound/soc/soc-pcm.c  | 14 ++++----------
 4 files changed, 14 insertions(+), 74 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4e8071269639..084d6d2268c6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1224,7 +1224,6 @@ struct snd_soc_card {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_card_root;
-	struct dentry *debugfs_pop_time;
 #endif
 	u32 pop_time;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fd6eaae6c0ed..d0d916537818 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -165,13 +165,6 @@ static void soc_init_component_debugfs(struct snd_soc_component *component)
 				component->card->debugfs_card_root);
 	}
 
-	if (IS_ERR(component->debugfs_root)) {
-		dev_warn(component->dev,
-			"ASoC: Failed to create component debugfs directory: %ld\n",
-			PTR_ERR(component->debugfs_root));
-		return;
-	}
-
 	snd_soc_dapm_debugfs_init(snd_soc_component_get_dapm(component),
 		component->debugfs_root);
 }
@@ -215,32 +208,15 @@ DEFINE_SHOW_ATTRIBUTE(component_list);
 
 static void soc_init_card_debugfs(struct snd_soc_card *card)
 {
-	if (!snd_soc_debugfs_root)
-		return;
-
 	card->debugfs_card_root = debugfs_create_dir(card->name,
 						     snd_soc_debugfs_root);
-	if (IS_ERR(card->debugfs_card_root)) {
-		dev_warn(card->dev,
-			 "ASoC: Failed to create card debugfs directory: %ld\n",
-			 PTR_ERR(card->debugfs_card_root));
-		card->debugfs_card_root = NULL;
-		return;
-	}
 
-	card->debugfs_pop_time = debugfs_create_u32("dapm_pop_time", 0644,
-						    card->debugfs_card_root,
-						    &card->pop_time);
-	if (IS_ERR(card->debugfs_pop_time))
-		dev_warn(card->dev,
-			 "ASoC: Failed to create pop time debugfs file: %ld\n",
-			 PTR_ERR(card->debugfs_pop_time));
+	debugfs_create_u32("dapm_pop_time", 0644, card->debugfs_card_root,
+			   &card->pop_time);
 }
 
 static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 {
-	if (!card->debugfs_card_root)
-		return;
 	debugfs_remove_recursive(card->debugfs_card_root);
 	card->debugfs_card_root = NULL;
 }
@@ -248,19 +224,12 @@ static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 static void snd_soc_debugfs_init(void)
 {
 	snd_soc_debugfs_root = debugfs_create_dir("asoc", NULL);
-	if (IS_ERR_OR_NULL(snd_soc_debugfs_root)) {
-		pr_warn("ASoC: Failed to create debugfs directory\n");
-		snd_soc_debugfs_root = NULL;
-		return;
-	}
 
-	if (!debugfs_create_file("dais", 0444, snd_soc_debugfs_root, NULL,
-				 &dai_list_fops))
-		pr_warn("ASoC: Failed to create DAI list debugfs file\n");
+	debugfs_create_file("dais", 0444, snd_soc_debugfs_root, NULL,
+			    &dai_list_fops);
 
-	if (!debugfs_create_file("components", 0444, snd_soc_debugfs_root, NULL,
-				 &component_list_fops))
-		pr_warn("ASoC: Failed to create component list debugfs file\n");
+	debugfs_create_file("components", 0444, snd_soc_debugfs_root, NULL,
+			    &component_list_fops);
 }
 
 static void snd_soc_debugfs_exit(void)
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f013b24c050a..1ec017aab829 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2154,50 +2154,28 @@ static const struct file_operations dapm_bias_fops = {
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 	struct dentry *parent)
 {
-	struct dentry *d;
-
 	if (!parent || IS_ERR(parent))
 		return;
 
 	dapm->debugfs_dapm = debugfs_create_dir("dapm", parent);
 
-	if (IS_ERR(dapm->debugfs_dapm)) {
-		dev_warn(dapm->dev,
-			 "ASoC: Failed to create DAPM debugfs directory %ld\n",
-			 PTR_ERR(dapm->debugfs_dapm));
-		return;
-	}
-
-	d = debugfs_create_file("bias_level", 0444,
-				dapm->debugfs_dapm, dapm,
-				&dapm_bias_fops);
-	if (IS_ERR(d))
-		dev_warn(dapm->dev,
-			 "ASoC: Failed to create bias level debugfs file: %ld\n",
-			 PTR_ERR(d));
+	debugfs_create_file("bias_level", 0444, dapm->debugfs_dapm, dapm,
+			    &dapm_bias_fops);
 }
 
 static void dapm_debugfs_add_widget(struct snd_soc_dapm_widget *w)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
-	struct dentry *d;
 
 	if (!dapm->debugfs_dapm || !w->name)
 		return;
 
-	d = debugfs_create_file(w->name, 0444,
-				dapm->debugfs_dapm, w,
-				&dapm_widget_power_fops);
-	if (IS_ERR(d))
-		dev_warn(w->dapm->dev,
-			 "ASoC: Failed to create %s debugfs file: %ld\n",
-			 w->name, PTR_ERR(d));
+	debugfs_create_file(w->name, 0444, dapm->debugfs_dapm, w,
+			    &dapm_widget_power_fops);
 }
 
 static void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
 {
-	if (!dapm->debugfs_dapm)
-		return;
 	debugfs_remove_recursive(dapm->debugfs_dapm);
 	dapm->debugfs_dapm = NULL;
 }
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 4878d22ebd8c..493429a90453 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1274,9 +1274,9 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 			stream ? "<-" : "->", be->dai_link->name);
 
 #ifdef CONFIG_DEBUG_FS
-	if (fe->debugfs_dpcm_root)
-		dpcm->debugfs_state = debugfs_create_u32(be->dai_link->name, 0644,
-				fe->debugfs_dpcm_root, &dpcm->state);
+	dpcm->debugfs_state = debugfs_create_dir(be->dai_link->name,
+						 fe->debugfs_dpcm_root);
+	debugfs_create_u32("state", 0644, dpcm->debugfs_state, &dpcm->state);
 #endif
 	return 1;
 }
@@ -1331,7 +1331,7 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 		dpcm_be_reparent(fe, dpcm->be, stream);
 
 #ifdef CONFIG_DEBUG_FS
-		debugfs_remove(dpcm->debugfs_state);
+		debugfs_remove_recursive(dpcm->debugfs_state);
 #endif
 		spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 		list_del(&dpcm->list_be);
@@ -3466,12 +3466,6 @@ void soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
 
 	rtd->debugfs_dpcm_root = debugfs_create_dir(rtd->dai_link->name,
 			rtd->card->debugfs_card_root);
-	if (!rtd->debugfs_dpcm_root) {
-		dev_dbg(rtd->dev,
-			 "ASoC: Failed to create dpcm debugfs directory %s\n",
-			 rtd->dai_link->name);
-		return;
-	}
 
 	debugfs_create_file("state", 0444, rtd->debugfs_dpcm_root,
 			    rtd, &dpcm_state_fops);
-- 
2.22.0

