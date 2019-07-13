Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043A4C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 03:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9752217D4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 03:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfGMDs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 23:48:26 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:23684 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbfGMDsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 23:48:24 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 9220ADD60F5720B25519;
        Sat, 13 Jul 2019 11:48:21 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x6D3m9QF091066;
        Sat, 13 Jul 2019 11:48:09 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019071311485264-2322081 ;
          Sat, 13 Jul 2019 11:48:52 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     krzk@kernel.org
Cc:     sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 1/2] ASoC: samsung: odroid: fix an use-after-free issue for codec
Date:   Sat, 13 Jul 2019 11:46:14 +0800
Message-Id: <1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562989575-33785-1-git-send-email-wen.yang99@zte.com.cn>
References: <1562989575-33785-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-13 11:48:52,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-13 11:48:16,
        Serialize complete at 2019-07-13 11:48:16
X-MAIL: mse-fl1.zte.com.cn x6D3m9QF091066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The codec variable is still being used after the of_node_put() call,
which may result in use-after-free.

Fixes: bc3cf17b575a ("ASoC: samsung: odroid: Add support for secondary CPU DAI")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/samsung/odroid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index dfb6e46..64ebe89 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -284,9 +284,8 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	}
 
 	of_node_put(cpu);
-	of_node_put(codec);
 	if (ret < 0)
-		return ret;
+		goto err_put_node;
 
 	ret = snd_soc_of_get_dai_link_codecs(dev, codec, codec_link);
 	if (ret < 0)
@@ -317,6 +316,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 		goto err_put_clk_i2s;
 	}
 
+	of_node_put(codec);
 	return 0;
 
 err_put_clk_i2s:
@@ -326,6 +326,8 @@ static int odroid_audio_probe(struct platform_device *pdev)
 err_put_cpu_dai:
 	of_node_put(cpu_dai);
 	snd_soc_of_put_dai_link_codecs(codec_link);
+err_put_node:
+	of_node_put(codec);
 	return ret;
 }
 
-- 
2.9.5

