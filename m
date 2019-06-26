Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F30C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC316208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WlFb+XcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfFZVWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:22:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36868 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZVWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:22:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so81082pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dEZUtEk4Wr+4uxHPyA7rQK9pE3KfX4I0BusWmU//o/Y=;
        b=WlFb+XcFK/WW24W9BaFlFf8pYRdZUjLAudlL9bHKJBO9g8ODeas3KvAuOA9xW4zWE0
         ZcDvk07jLU8hkd3wuHatwQh5+O+YKkI97qomvROXoPtqUuwHSONDTEjEouoyRDaJPOo/
         ar02aygC8rSm0ZiCs/bEK+ruuZAomniz7GTdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dEZUtEk4Wr+4uxHPyA7rQK9pE3KfX4I0BusWmU//o/Y=;
        b=agBcT/sGc0QLpwadcgnPO/m76nTuPrNcThQRP16CXdwv+kCmZaHpF8g/pr8I+NAZ8g
         lDILTe5evEEhB9YhlAcyKlyViXQRzRoBB0f/8r/fFblHD4ATc+TKlQaDS6QQItu+mX7f
         ndJeDj8RHpvKvFrHU4E4GpecuFZbIropEFYA31xlPyM2OLg7sar9Lr9mFD32PMpl+pYP
         Z5joeMYFSSMt6SCFs8GcPwzvVpk3C7PyowHhTrKn2WCuv1mkGILJa/rns8oaHbZMp7P6
         mwv5WlTBfXyJdH3861aq1GQJQnw72uXL0uto6hC6878/QiTFmbql6NaqPsuUWL2+14ab
         6CQQ==
X-Gm-Message-State: APjAAAWNmj9RJH0I3i7QzFsv8NbJ0+CXB0NENrGTnFTbOjJfLAS0hI0h
        i9lAVaVL/rQ4E14rlf7LiJ+MGg==
X-Google-Smtp-Source: APXvYqwjeDGgN9CC2QLmMm598fKAAPZtXYp0rQllm/ojsEZvV+uu/iI8Ar3zaJWldFR99/jYBi0PCQ==
X-Received: by 2002:a63:6b07:: with SMTP id g7mr43019pgc.325.1561584166923;
        Wed, 26 Jun 2019 14:22:46 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id h6sm170323pfn.79.2019.06.26.14.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 14:22:46 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/2] ALSA: hda: Fix widget_mutex incomplete protection
Date:   Wed, 26 Jun 2019 14:22:19 -0700
Message-Id: <20190626212220.239897-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626212220.239897-1-evgreen@chromium.org>
References: <20190626212220.239897-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The widget_mutex was introduced to serialize callers to
hda_widget_sysfs_{re}init. However, its protection of the sysfs widget array
is incomplete. For example, it is acquired around the call to
hda_widget_sysfs_reinit(), which actually creates the new array, but isn't
still acquired when codec->num_nodes and codec->start_nid is updated. So
the lock ensures one thread sets up the new array at a time, but doesn't
ensure which thread's value will end up in codec->num_nodes. If a larger
num_nodes wins but a smaller array was set up, the next call to
refresh_widgets() will touch free memory as it iterates over codec->num_nodes
that aren't there.

The widget_lock really protects both the tree as well as codec->num_nodes,
start_nid, and end_nid, so make sure it's held across that update. It should
also be held during snd_hdac_get_sub_nodes(), so that a very old read from that
function doesn't end up clobbering a later update.

While in there, move the exit mutex call inside the function. This moves the
mutex closer to the data structure it protects and removes a requirement of
acquiring the somewhat internal widget_lock before calling sysfs_exit.

Fixes: ed180abba7f1 ("ALSA: hda: Fix race between creating and refreshing sysfs entries")

Signed-off-by: Evan Green <evgreen@chromium.org>

---

Changes in v2:
- Introduced widget_mutex relocation

 sound/hda/hdac_device.c | 19 +++++++++++++------
 sound/hda/hdac_sysfs.c  |  4 ++--
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 6907dbefd08c..ff3420c5cdc8 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -162,9 +162,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_device_register);
 void snd_hdac_device_unregister(struct hdac_device *codec)
 {
 	if (device_is_registered(&codec->dev)) {
-		mutex_lock(&codec->widget_lock);
 		hda_widget_sysfs_exit(codec);
-		mutex_unlock(&codec->widget_lock);
 		device_del(&codec->dev);
 		snd_hdac_bus_remove_device(codec->bus, codec);
 	}
@@ -402,25 +400,34 @@ int snd_hdac_refresh_widgets(struct hdac_device *codec, bool sysfs)
 	hda_nid_t start_nid;
 	int nums, err;
 
+	/*
+	 * Serialize against multiple threads trying to update the sysfs
+	 * widgets array.
+	 */
+	mutex_lock(&codec->widget_lock);
 	nums = snd_hdac_get_sub_nodes(codec, codec->afg, &start_nid);
 	if (!start_nid || nums <= 0 || nums >= 0xff) {
 		dev_err(&codec->dev, "cannot read sub nodes for FG 0x%02x\n",
 			codec->afg);
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock;
 	}
 
 	if (sysfs) {
-		mutex_lock(&codec->widget_lock);
 		err = hda_widget_sysfs_reinit(codec, start_nid, nums);
-		mutex_unlock(&codec->widget_lock);
 		if (err < 0)
-			return err;
+			goto unlock;
 	}
 
 	codec->num_nodes = nums;
 	codec->start_nid = start_nid;
 	codec->end_nid = start_nid + nums;
+	mutex_unlock(&codec->widget_lock);
 	return 0;
+
+unlock:
+	mutex_unlock(&codec->widget_lock);
+	return err;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_refresh_widgets);
 
diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index 909d5ef1179c..400ca262e2f8 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -412,13 +412,13 @@ int hda_widget_sysfs_init(struct hdac_device *codec)
 	return 0;
 }
 
-/* call with codec->widget_lock held */
 void hda_widget_sysfs_exit(struct hdac_device *codec)
 {
+	mutex_lock(&codec->widget_lock);
 	widget_tree_free(codec);
+	mutex_unlock(&codec->widget_lock);
 }
 
-/* call with codec->widget_lock held */
 int hda_widget_sysfs_reinit(struct hdac_device *codec,
 			    hda_nid_t start_nid, int num_nodes)
 {
-- 
2.20.1

