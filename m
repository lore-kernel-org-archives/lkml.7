Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3B2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E867D20840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ayg2KJ50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbfCFJKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:10:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45293 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfCFJKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:10:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id v21so8065588pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 01:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wJOxMdrzk+4rw4ckkL08w9H5f7Ws6Ifi6+PYlrU/tu8=;
        b=ayg2KJ50bSe3ONjBVv6a41O2KKNtLE4IYgKzHSlVOOZ7x0HtLSTKQeKdFgmVAyjMl4
         LhlT4BDZr/5b+WDGLfyjXH1QV0utAd0EPaVtRu+MxNarvox+4uJehsFCdhJOpWi/Sm/D
         r23aBSeLnUE+k/vvyXNk+IE+hLatrR1iIiYmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wJOxMdrzk+4rw4ckkL08w9H5f7Ws6Ifi6+PYlrU/tu8=;
        b=P0Mu/DcpXX8SZjRG2YWSclI4cFcnYw1aBkPvfXohn/6igaA5dka6ixx7h3vswjX0/k
         r7FzHzuaPi3KmQtKQrPYroAEtRBe4f60ksPHxpV6VYTPqErR/R7CqVxbPK6bVZijZz/M
         h2aA9TZnjh2jG/lWmPCLsyT2ki42Ia3Y8vuWTrvpafGs2IlgmQ889zRrYTtJsHsGFgOH
         5lt3yBGpROu0m0fmvNPJrrdtMZQLcpjEX3baA8L68xGQIKqD9nMC4tAj2AcOcbYVzoHH
         /Zlr7/4I1bXKS1cOi++tLiC6TB921RM07gkSj8Z1RWqUCnRA6ygnzZtkwFoY8VTR2BAm
         0T9Q==
X-Gm-Message-State: APjAAAW0IqJ1ErLenfVqnl7Tiy4ryQJZvqa5WLTiMqo3cL1Pkj30M5rj
        miYN7AZ9dqWmJ7UzUbBT15yiZg==
X-Google-Smtp-Source: APXvYqy3GUfcFcA+X45DUSEQSPjHmusKp3XjYJ6EugpfkOZ7uAOeg53Y0jL2JIjD1VrIiEGT/0f7NQ==
X-Received: by 2002:a63:f806:: with SMTP id n6mr5332503pgh.19.1551863405373;
        Wed, 06 Mar 2019 01:10:05 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id h65sm1603710pgc.93.2019.03.06.01.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 01:10:04 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Garlic Tseng <garlic.tseng@mediatek.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] ASoC: mediatek: Reduce repititive code on mtk_regmap_update_bits.
Date:   Wed,  6 Mar 2019 17:09:03 +0800
Message-Id: <20190306090922.117634-3-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
In-Reply-To: <20190306090922.117634-1-pihsun@chromium.org>
References: <20190306090922.117634-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the signature of mtk_regmap_update_bits to also take a shift, and
warn when reg >= 0 but shift < 0. This reduce the code repetition
on the calling side, and prevent future UBSAN warning when some of the
xxx_shift and xxx_reg are both set to -1.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 46 +++++++++-------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index 3830e582e188..fded11d14cde 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -18,11 +18,11 @@
 
 static int mtk_regmap_update_bits(struct regmap *map, int reg,
 			   unsigned int mask,
-			   unsigned int val)
+			   unsigned int val, int shift)
 {
-	if (reg < 0)
+	if (reg < 0 || WARN_ON_ONCE(shift < 0))
 		return 0;
-	return regmap_update_bits(map, reg, mask, val);
+	return regmap_update_bits(map, reg, mask << shift, val << shift);
 }
 
 static int mtk_regmap_write(struct regmap *map, int reg, unsigned int val)
@@ -49,8 +49,7 @@ int mtk_afe_fe_startup(struct snd_pcm_substream *substream,
 				   SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 16);
 	/* enable agent */
 	mtk_regmap_update_bits(afe->regmap, memif->data->agent_disable_reg,
-			       1 << memif->data->agent_disable_shift,
-			       0 << memif->data->agent_disable_shift);
+			       1, 0, memif->data->agent_disable_shift);
 
 	snd_soc_set_runtime_hwparams(substream, mtk_afe_hardware);
 
@@ -105,8 +104,7 @@ void mtk_afe_fe_shutdown(struct snd_pcm_substream *substream,
 	irq_id = memif->irq_usage;
 
 	mtk_regmap_update_bits(afe->regmap, memif->data->agent_disable_reg,
-			       1 << memif->data->agent_disable_shift,
-			       1 << memif->data->agent_disable_shift);
+			       1, 1, memif->data->agent_disable_shift);
 
 	if (!memif->const_irq) {
 		mtk_dynamic_irq_release(afe, irq_id);
@@ -144,16 +142,14 @@ int mtk_afe_fe_hw_params(struct snd_pcm_substream *substream,
 
 	/* set MSB to 33-bit */
 	mtk_regmap_update_bits(afe->regmap, memif->data->msb_reg,
-			       1 << memif->data->msb_shift,
-			       msb_at_bit33 << memif->data->msb_shift);
+			       1, msb_at_bit33, memif->data->msb_shift);
 
 	/* set channel */
 	if (memif->data->mono_shift >= 0) {
 		unsigned int mono = (params_channels(params) == 1) ? 1 : 0;
 
 		mtk_regmap_update_bits(afe->regmap, memif->data->mono_reg,
-				       1 << memif->data->mono_shift,
-				       mono << memif->data->mono_shift);
+				       1, mono, memif->data->mono_shift);
 	}
 
 	/* set rate */
@@ -166,8 +162,8 @@ int mtk_afe_fe_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	mtk_regmap_update_bits(afe->regmap, memif->data->fs_reg,
-			       memif->data->fs_maskbit << memif->data->fs_shift,
-			       fs << memif->data->fs_shift);
+			       memif->data->fs_maskbit, fs,
+			       memif->data->fs_shift);
 
 	return 0;
 }
@@ -199,14 +195,12 @@ int mtk_afe_fe_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_RESUME:
 		mtk_regmap_update_bits(afe->regmap,
 				       memif->data->enable_reg,
-				       1 << memif->data->enable_shift,
-				       1 << memif->data->enable_shift);
+				       1, 1, memif->data->enable_shift);
 
 		/* set irq counter */
 		mtk_regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
-				       irq_data->irq_cnt_maskbit
-				       << irq_data->irq_cnt_shift,
-				       counter << irq_data->irq_cnt_shift);
+				       irq_data->irq_cnt_maskbit, counter,
+				       irq_data->irq_cnt_shift);
 
 		/* set irq fs */
 		fs = afe->irq_fs(substream, runtime->rate);
@@ -215,24 +209,21 @@ int mtk_afe_fe_trigger(struct snd_pcm_substream *substream, int cmd,
 			return -EINVAL;
 
 		mtk_regmap_update_bits(afe->regmap, irq_data->irq_fs_reg,
-				       irq_data->irq_fs_maskbit
-				       << irq_data->irq_fs_shift,
-				       fs << irq_data->irq_fs_shift);
+				       irq_data->irq_fs_maskbit, fs,
+				       irq_data->irq_fs_shift);
 
 		/* enable interrupt */
 		mtk_regmap_update_bits(afe->regmap, irq_data->irq_en_reg,
-				       1 << irq_data->irq_en_shift,
-				       1 << irq_data->irq_en_shift);
+				       1, 1, irq_data->irq_en_shift);
 
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		mtk_regmap_update_bits(afe->regmap, memif->data->enable_reg,
-				       1 << memif->data->enable_shift, 0);
+				       1, 0, memif->data->enable_shift);
 		/* disable interrupt */
 		mtk_regmap_update_bits(afe->regmap, irq_data->irq_en_reg,
-				       1 << irq_data->irq_en_shift,
-				       0 << irq_data->irq_en_shift);
+				       1, 0, irq_data->irq_en_shift);
 		/* and clear pending IRQ */
 		mtk_regmap_write(afe->regmap, irq_data->irq_clr_reg,
 				 1 << irq_data->irq_clr_shift);
@@ -269,8 +260,7 @@ int mtk_afe_fe_prepare(struct snd_pcm_substream *substream,
 	}
 
 	mtk_regmap_update_bits(afe->regmap, memif->data->hd_reg,
-			       1 << memif->data->hd_shift,
-			       hd_audio << memif->data->hd_shift);
+			       1, hd_audio, memif->data->hd_shift);
 
 	return 0;
 }
-- 
2.21.0.352.gf09ad66450-goog

