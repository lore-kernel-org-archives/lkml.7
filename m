Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E37C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847A120896
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfEJMSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 08:18:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:46346 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfEJMSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:18:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 05:18:13 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by orsmga004.jf.intel.com with ESMTP; 10 May 2019 05:18:11 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH] ALSA: hda: Fix race between creating and refreshing sysfs entries
Date:   Fri, 10 May 2019 14:21:41 +0200
Message-Id: <20190510122141.8802-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hda_widget_sysfs_reinit() can free underlying codec->widgets structure
on which widget_tree_create() operates. Add locking to prevent such
issues from happening.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=110382
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 include/sound/hdaudio.h   |  1 +
 sound/hda/hdac_sysfs.c    | 22 +++++++++++++++++++---
 sound/pci/hda/hda_codec.c |  2 ++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 45f944d57982..85835d0c33cc 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -81,6 +81,7 @@ struct hdac_device {
 	atomic_t in_pm;		/* suspend/resume being performed */
 
 	/* sysfs */
+	struct mutex widget_lock;
 	struct hdac_widget_tree *widgets;
 
 	/* regmap */
diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index fb2aa344981e..5352e5db814c 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -399,21 +399,28 @@ int hda_widget_sysfs_init(struct hdac_device *codec)
 {
 	int err;
 
-	if (codec->widgets)
+	mutex_lock(&codec->widget_lock);
+	if (codec->widgets) {
+		mutex_unlock(&codec->widget_lock);
 		return 0; /* already created */
+	}
 
 	err = widget_tree_create(codec);
 	if (err < 0) {
 		widget_tree_free(codec);
+		mutex_unlock(&codec->widget_lock);
 		return err;
 	}
 
+	mutex_unlock(&codec->widget_lock);
 	return 0;
 }
 
 void hda_widget_sysfs_exit(struct hdac_device *codec)
 {
+	mutex_lock(&codec->widget_lock);
 	widget_tree_free(codec);
+	mutex_unlock(&codec->widget_lock);
 }
 
 int hda_widget_sysfs_reinit(struct hdac_device *codec,
@@ -424,16 +431,23 @@ int hda_widget_sysfs_reinit(struct hdac_device *codec,
 	hda_nid_t nid;
 	int i;
 
-	if (!codec->widgets)
+	mutex_lock(&codec->widget_lock);
+
+	if (!codec->widgets) {
+		mutex_unlock(&codec->widget_lock);
 		return hda_widget_sysfs_init(codec);
+	}
 
 	tree = kmemdup(codec->widgets, sizeof(*tree), GFP_KERNEL);
-	if (!tree)
+	if (!tree) {
+		mutex_unlock(&codec->widget_lock);
 		return -ENOMEM;
+	}
 
 	tree->nodes = kcalloc(num_nodes + 1, sizeof(*tree->nodes), GFP_KERNEL);
 	if (!tree->nodes) {
 		kfree(tree);
+		mutex_unlock(&codec->widget_lock);
 		return -ENOMEM;
 	}
 
@@ -460,5 +474,7 @@ int hda_widget_sysfs_reinit(struct hdac_device *codec,
 	codec->widgets = tree;
 
 	kobject_uevent(tree->root, KOBJ_CHANGE);
+
+	mutex_unlock(&codec->widget_lock);
 	return 0;
 }
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 701a69d856f5..a5746df5c94b 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -870,6 +870,8 @@ static int snd_hda_codec_device_init(struct hda_bus *bus, struct snd_card *card,
 	if (!codec)
 		return -ENOMEM;
 
+	mutex_init(&codec->widget_lock);
+
 	sprintf(name, "hdaudioC%dD%d", card->number, codec_addr);
 	err = snd_hdac_device_init(&codec->core, &bus->core, name, codec_addr);
 	if (err < 0) {
-- 
2.17.1

