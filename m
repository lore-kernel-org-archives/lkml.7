Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4E0C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E29220866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfFENmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:42:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:51941 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbfFENm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:42:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 06:42:28 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2019 06:42:25 -0700
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
        <amadeuszx.slawinski@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 04/14] ASoC: compress: Fix memory leak from snd_soc_new_compress
Date:   Wed,  5 Jun 2019 15:45:46 +0200
Message-Id: <20190605134556.10322-5-amadeuszx.slawinski@linux.intel.com>
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

Change kzalloc to devm_kzalloc, so compr gets automatically freed when
it's no longer needed.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-compress.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 03d5b9ccd3fc..ddef4ff677ce 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -896,16 +896,14 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	else
 		direction = SND_COMPRESS_CAPTURE;
 
-	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
+	compr = devm_kzalloc(rtd->card->dev, sizeof(*compr), GFP_KERNEL);
 	if (!compr)
 		return -ENOMEM;
 
 	compr->ops = devm_kzalloc(rtd->card->dev, sizeof(soc_compr_ops),
 				  GFP_KERNEL);
-	if (!compr->ops) {
-		ret = -ENOMEM;
-		goto compr_err;
-	}
+	if (!compr->ops)
+		return -ENOMEM;
 
 	if (rtd->dai_link->dynamic) {
 		snprintf(new_name, sizeof(new_name), "(%s)",
@@ -918,7 +916,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 			dev_err(rtd->card->dev,
 				"Compress ASoC: can't create compressed for %s: %d\n",
 				rtd->dai_link->name, ret);
-			goto compr_err;
+			return ret;
 		}
 
 		rtd->pcm = be_pcm;
@@ -954,7 +952,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 		dev_err(component->dev,
 			"Compress ASoC: can't create compress for codec %s: %d\n",
 			component->name, ret);
-		goto compr_err;
+		return ret;
 	}
 
 	/* DAPM dai link stream work */
@@ -965,10 +963,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 
 	dev_info(rtd->card->dev, "Compress ASoC: %s <-> %s mapping ok\n",
 		 codec_dai->name, cpu_dai->name);
-	return ret;
 
-compr_err:
-	kfree(compr);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_new_compress);
-- 
2.17.1

