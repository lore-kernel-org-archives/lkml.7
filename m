Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABB8C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8770D214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfEMJOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:14:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:48372 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbfEMJOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:14:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 02:14:32 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2019 02:14:31 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2] ALSA: hda: Fix race between creating and refreshing sysfs entries
Date:   Mon, 13 May 2019 11:18:01 +0200
Message-Id: <20190513091801.985-1-amadeuszx.slawinski@linux.intel.com>
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

Changes since v1:
 - Moved mutexes around the callers
 - Added comments noting that functions should be called with mutex held

---
 include/sound/hdaudio.h | 1 +
 sound/hda/hdac_device.c | 7 +++++++
 sound/hda/hdac_sysfs.c  | 3 +++
 3 files changed, 11 insertions(+)

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
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 95b073ee4b32..4769f4c03e14 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -55,6 +55,7 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
 	codec->bus = bus;
 	codec->addr = addr;
 	codec->type = HDA_DEV_CORE;
+	mutex_init(&codec->widget_lock);
 	pm_runtime_set_active(&codec->dev);
 	pm_runtime_get_noresume(&codec->dev);
 	atomic_set(&codec->in_pm, 0);
@@ -141,7 +142,9 @@ int snd_hdac_device_register(struct hdac_device *codec)
 	err = device_add(&codec->dev);
 	if (err < 0)
 		return err;
+	mutex_lock(&codec->widget_lock);
 	err = hda_widget_sysfs_init(codec);
+	mutex_unlock(&codec->widget_lock);
 	if (err < 0) {
 		device_del(&codec->dev);
 		return err;
@@ -158,7 +161,9 @@ EXPORT_SYMBOL_GPL(snd_hdac_device_register);
 void snd_hdac_device_unregister(struct hdac_device *codec)
 {
 	if (device_is_registered(&codec->dev)) {
+		mutex_lock(&codec->widget_lock);
 		hda_widget_sysfs_exit(codec);
+		mutex_unlock(&codec->widget_lock);
 		device_del(&codec->dev);
 		snd_hdac_bus_remove_device(codec->bus, codec);
 	}
@@ -404,7 +409,9 @@ int snd_hdac_refresh_widgets(struct hdac_device *codec, bool sysfs)
 	}
 
 	if (sysfs) {
+		mutex_lock(&codec->widget_lock);
 		err = hda_widget_sysfs_reinit(codec, start_nid, nums);
+		mutex_unlock(&codec->widget_lock);
 		if (err < 0)
 			return err;
 	}
diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index fb2aa344981e..909d5ef1179c 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -395,6 +395,7 @@ static int widget_tree_create(struct hdac_device *codec)
 	return 0;
 }
 
+/* call with codec->widget_lock held */
 int hda_widget_sysfs_init(struct hdac_device *codec)
 {
 	int err;
@@ -411,11 +412,13 @@ int hda_widget_sysfs_init(struct hdac_device *codec)
 	return 0;
 }
 
+/* call with codec->widget_lock held */
 void hda_widget_sysfs_exit(struct hdac_device *codec)
 {
 	widget_tree_free(codec);
 }
 
+/* call with codec->widget_lock held */
 int hda_widget_sysfs_reinit(struct hdac_device *codec,
 			    hda_nid_t start_nid, int num_nodes)
 {
-- 
2.17.1

