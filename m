Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB62C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0F72084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfFQLfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:35:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:54390 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbfFQLfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:35:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 04:35:06 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2019 04:35:04 -0700
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
Subject: [PATCH v2 06/11] ASoC: Intel: Skylake: Add function to cleanup debugfs interface
Date:   Mon, 17 Jun 2019 13:36:39 +0200
Message-Id: <20190617113644.25621-7-amadeuszx.slawinski@linux.intel.com>
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

Currently debugfs has no cleanup function. Add skl_debufs_exit function
so we can clean after ourselves properly.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/skylake/skl-debug.c | 9 +++++++++
 sound/soc/intel/skylake/skl.h       | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index 69cbe9eb026b..b9b4a72a4334 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -251,3 +251,12 @@ struct skl_debug *skl_debugfs_init(struct skl *skl)
 	debugfs_remove_recursive(d->fs);
 	return NULL;
 }
+
+void skl_debugfs_exit(struct skl *skl)
+{
+	struct skl_debug *d = skl->debugfs;
+
+	debugfs_remove_recursive(d->fs);
+
+	d = NULL;
+}
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index e7870ec81a9b..6fab1a2e133a 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -155,6 +155,7 @@ struct skl_module_cfg;
 
 #ifdef CONFIG_DEBUG_FS
 struct skl_debug *skl_debugfs_init(struct skl *skl);
+void skl_debugfs_exit(struct skl *skl);
 void skl_debug_init_module(struct skl_debug *d,
 			struct snd_soc_dapm_widget *w,
 			struct skl_module_cfg *mconfig);
@@ -163,6 +164,10 @@ static inline struct skl_debug *skl_debugfs_init(struct skl *skl)
 {
 	return NULL;
 }
+
+static inline void skl_debugfs_exit(struct skl *skl)
+{}
+
 static inline void skl_debug_init_module(struct skl_debug *d,
 					 struct snd_soc_dapm_widget *w,
 					 struct skl_module_cfg *mconfig)
-- 
2.17.1

