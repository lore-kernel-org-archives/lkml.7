Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B63EC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A6F216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q9RJWtgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFZVWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:22:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46044 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZVWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:22:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so61462pfq.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CIHEr6pS5Yaz5tj/cecHQfeHv+bLX+kAKCJatdVo7Hc=;
        b=Q9RJWtgYJVX/wG4BhsG7WvOXfYW3HXB4ved5h9VXrgtI6gkTj5Bm76LfrzLe+t6Wo1
         4wr+yXnjIDT5FgZiyBhSH6XYqw2Nz9Gif8SE/ZPDjhADl9PWFrhWrFX/AAVPm7cE8fGT
         mlJxbnUCOnNWGaMu01qinLedTAMS786MzHwkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CIHEr6pS5Yaz5tj/cecHQfeHv+bLX+kAKCJatdVo7Hc=;
        b=E0kkdGmF3ZsxPjuYGPygSNw8VRqzpmC0tr0zG/cQfEAM67qDAz+169xzE0uDGktJRS
         YGdliD/kK8aSAuGcTOscDk7OA23YIM/NvmwC0i0dQGApqcipfhPSo4ptEm0Vqmbcr5Wk
         mx1DubGBZvycVcsIcdWWu2AI14jXm68G0bm3cxewrpo6jiMSS2wREHe56hq0X1BfDn4j
         2Mi4WlDwWaXYa1saO7tZzoyG3wtR9eNYqap2+76wulK3hjlioIRKy90qV9FwCtPdxuzK
         Tq1GY4F0whM+tEImgD1FjjjkYRWMwrF3QApFu3YH8ayHtYC/tK6uvNvnZH4Xs18bFa/A
         pzCw==
X-Gm-Message-State: APjAAAVotzd1ybs78Dy4U14QhoKt5uB33XYxBQIyWhpvLSosOb7H13EU
        eTAGBOBWe6eQg0NtC0A/1o0POQ==
X-Google-Smtp-Source: APXvYqx250n1zZ/0STWhLJjOX1YUjpfVkyfh0hEXV5CrbhPg0iU5VnEooYk15KlqzNZzC4v9rCB/Sg==
X-Received: by 2002:a63:6155:: with SMTP id v82mr79009pgb.304.1561584170430;
        Wed, 26 Jun 2019 14:22:50 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id h6sm170323pfn.79.2019.06.26.14.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 14:22:49 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/2] ALSA: hda: Use correct start/count for sysfs init
Date:   Wed, 26 Jun 2019 14:22:20 -0700
Message-Id: <20190626212220.239897-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626212220.239897-1-evgreen@chromium.org>
References: <20190626212220.239897-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The normal flow through the widget sysfs codepath is that
snd_hdac_refresh_widgets() is called once without the sysfs bool set
to set up codec->num_nodes and friends, then another time with the
bool set to actually allocate all the sysfs widgets. However, during
the first time allocation, hda_widget_sysfs_reinit() ignores the new
num_nodes passed in via parameter and just calls hda_widget_sysfs_init(),
using whatever was in codec->num_nodes before the update. This is not
correct in cases where num_nodes changes. Here's an example:

Sometime earlier:
snd_hdac_refresh_widgets(hdac, false)
  sets codec->num_nodes to 2, widgets is still not allocated

Now:
snd_hdac_refresh_widgets(hdac, true)
  hda_widget_sysfs_reinit(num_nodes=7)
    hda_widget_sysfs_init()
      widget_tree_create()
        alloc(codec->num_nodes) // this is still 2
  codec->num_nodes = 7

Pass num_nodes and start_nid down into widget_tree_create() so that
the right number of nodes are allocated in all cases.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v2: None

 sound/hda/hdac_device.c |  2 +-
 sound/hda/hdac_sysfs.c  | 14 ++++++++------
 sound/hda/local.h       |  3 ++-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index ff3420c5cdc8..b06a698c88a1 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -144,7 +144,7 @@ int snd_hdac_device_register(struct hdac_device *codec)
 	if (err < 0)
 		return err;
 	mutex_lock(&codec->widget_lock);
-	err = hda_widget_sysfs_init(codec);
+	err = hda_widget_sysfs_init(codec, codec->start_nid, codec->num_nodes);
 	mutex_unlock(&codec->widget_lock);
 	if (err < 0) {
 		device_del(&codec->dev);
diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index 400ca262e2f8..41aa4b98162a 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -358,7 +358,8 @@ static int add_widget_node(struct kobject *parent, hda_nid_t nid,
 	return 0;
 }
 
-static int widget_tree_create(struct hdac_device *codec)
+static int widget_tree_create(struct hdac_device *codec,
+			      hda_nid_t start_nid, int num_nodes)
 {
 	struct hdac_widget_tree *tree;
 	int i, err;
@@ -372,12 +373,12 @@ static int widget_tree_create(struct hdac_device *codec)
 	if (!tree->root)
 		return -ENOMEM;
 
-	tree->nodes = kcalloc(codec->num_nodes + 1, sizeof(*tree->nodes),
+	tree->nodes = kcalloc(num_nodes + 1, sizeof(*tree->nodes),
 			      GFP_KERNEL);
 	if (!tree->nodes)
 		return -ENOMEM;
 
-	for (i = 0, nid = codec->start_nid; i < codec->num_nodes; i++, nid++) {
+	for (i = 0, nid = start_nid; i < num_nodes; i++, nid++) {
 		err = add_widget_node(tree->root, nid, &widget_node_group,
 				      &tree->nodes[i]);
 		if (err < 0)
@@ -396,14 +397,15 @@ static int widget_tree_create(struct hdac_device *codec)
 }
 
 /* call with codec->widget_lock held */
-int hda_widget_sysfs_init(struct hdac_device *codec)
+int hda_widget_sysfs_init(struct hdac_device *codec,
+			  hda_nid_t start_nid, int num_nodes)
 {
 	int err;
 
 	if (codec->widgets)
 		return 0; /* already created */
 
-	err = widget_tree_create(codec);
+	err = widget_tree_create(codec, start_nid, num_nodes);
 	if (err < 0) {
 		widget_tree_free(codec);
 		return err;
@@ -428,7 +430,7 @@ int hda_widget_sysfs_reinit(struct hdac_device *codec,
 	int i;
 
 	if (!codec->widgets)
-		return hda_widget_sysfs_init(codec);
+		return hda_widget_sysfs_init(codec, start_nid, num_nodes);
 
 	tree = kmemdup(codec->widgets, sizeof(*tree), GFP_KERNEL);
 	if (!tree)
diff --git a/sound/hda/local.h b/sound/hda/local.h
index 877631e39373..8936120ab4d9 100644
--- a/sound/hda/local.h
+++ b/sound/hda/local.h
@@ -28,7 +28,8 @@ static inline unsigned int get_wcaps_channels(u32 wcaps)
 }
 
 extern const struct attribute_group *hdac_dev_attr_groups[];
-int hda_widget_sysfs_init(struct hdac_device *codec);
+int hda_widget_sysfs_init(struct hdac_device *codec,
+			  hda_nid_t start_nid, int num_nodes);
 int hda_widget_sysfs_reinit(struct hdac_device *codec, hda_nid_t start_nid,
 			    int num_nodes);
 void hda_widget_sysfs_exit(struct hdac_device *codec);
-- 
2.20.1

