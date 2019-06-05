Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C9C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E8420866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfFENmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:42:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:51941 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbfFENmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:42:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 06:42:36 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2019 06:42:33 -0700
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
Subject: [PATCH 07/14] ASoC: Intel: Skylake: Add function to cleanup debugfs interface
Date:   Wed,  5 Jun 2019 15:45:49 +0200
Message-Id: <20190605134556.10322-8-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
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
index 5d7ac2ee7a3c..e81c3dafc0d0 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -259,3 +259,12 @@ struct skl_debug *skl_debugfs_init(struct skl *skl)
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
index 85f8bb6687dc..d2e269867a44 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -164,6 +164,7 @@ struct skl_module_cfg;
 
 #ifdef CONFIG_DEBUG_FS
 struct skl_debug *skl_debugfs_init(struct skl *skl);
+void skl_debugfs_exit(struct skl *skl);
 void skl_debug_init_module(struct skl_debug *d,
 			struct snd_soc_dapm_widget *w,
 			struct skl_module_cfg *mconfig);
@@ -172,6 +173,10 @@ static inline struct skl_debug *skl_debugfs_init(struct skl *skl)
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

