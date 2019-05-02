Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EECC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB332075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xHqWaiJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfEBMK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:10:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33240 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEBMK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:10:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id b188so3379717wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QoGRmL9hNOPY+eFMV8Hy2PltfqYDajcTCyiSgjQt9SQ=;
        b=xHqWaiJWsWUcZhoNbhOVBcJzfg9qdsYw5E2q3LjZu9iNGHbzEyPhLzBGVHZA6jT6KV
         6Rtgs1XdKNUB6RCaHd11VIf1KnAUz5OPdkXzXacvy50eQe18yccKyj01+YzaridlzwTR
         j7yeJj/hnwUDO0jx0ea4gdQcYrJ/KAoQO2Pjnva1wD9MOKFXhuutHa5Uu3hzUkodrTdz
         a9HxFjfRBg7jiXHRRJbabYEkCNeAHDm5+AsVkCyLloIF6V/QRsR00pUUqrvbtFiYGAmS
         i4i+68mRlvdS3nrxG4lfLl72/v6dL1ev8BRaeVLfeeNqIkXwtORNEzNtNF0Gh2UQobnY
         +lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QoGRmL9hNOPY+eFMV8Hy2PltfqYDajcTCyiSgjQt9SQ=;
        b=NxN2lwh9WKpni8lRzvZcRw8lFl/F4uaFHQL/TnqWf6myeeJIDoh1NghqgVzkHPfbhq
         ozeK87Cdzgo7sY9I/nZMxwcdcYGb2LxoxV+scZNqyc9hwVMCksrmpDvJ75DbprRKoClm
         lh+T4xXeDKBMOKEKPXQSboYNO2Auboqs8wv1/dowaCazke0OezSc4usQxJsbdBXMJ6qF
         nngHMpuVqSeh3pQqeRNzUoe7Lubw8gk7u4xXVAglSBjSwEWf6N4zgEydVbPnNoW6QjVW
         9PX/2VftapVwIJMuOFwbjxc2aeY/twuT95kSm6mlfOoQTa2bKw/DCANhTpGtiqv/U6rg
         TNdA==
X-Gm-Message-State: APjAAAXJ3UwGZP4c7UUjv4xfpTQm/l3jFLobN+eI4d43NAt1vKqTbN7G
        u+3bw/AxdNNXb7mYJF6n7UFsKQ==
X-Google-Smtp-Source: APXvYqzfD7lY9qYA6s3UXeqowSYnQbSJRYuX0+C/KKMF9ab6t31N4mkff3S6Ouo/4i4XI4ETpGxpDA==
X-Received: by 2002:a7b:c010:: with SMTP id c16mr2137167wmb.82.1556799054205;
        Thu, 02 May 2019 05:10:54 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-8-187.w90-86.abo.wanadoo.fr. [90.86.125.187])
        by smtp.gmail.com with ESMTPSA id u9sm3648348wmd.14.2019.05.02.05.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 05:10:53 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com, perex@perex.cz,
        tiwai@suse.com, kaichieh.chuang@mediatek.com,
        shunli.wang@mediatek.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/5] ASoC: mediatek: make agent_disable, msb & hd fields optional
Date:   Thu,  2 May 2019 14:10:37 +0200
Message-Id: <20190502121041.8045-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502121041.8045-1-fparent@baylibre.com>
References: <20190502121041.8045-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not every SoC have the following registers: agent_disable_reg,
msg_reg, and hd_reg. Make them optional in order to allow more
SoC to use the common DAI FE code.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 23 +++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index cf4978be062f..f39f5d8c4244 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -47,10 +47,13 @@ int mtk_afe_fe_startup(struct snd_pcm_substream *substream,
 
 	snd_pcm_hw_constraint_step(substream->runtime, 0,
 				   SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 16);
+
 	/* enable agent */
-	mtk_regmap_update_bits(afe->regmap, memif->data->agent_disable_reg,
-			       1 << memif->data->agent_disable_shift,
-			       0 << memif->data->agent_disable_shift);
+	if (memif->data->agent_disable_shift >= 0)
+		mtk_regmap_update_bits(afe->regmap,
+				       memif->data->agent_disable_reg,
+				       1 << memif->data->agent_disable_shift,
+				       0 << memif->data->agent_disable_shift);
 
 	snd_soc_set_runtime_hwparams(substream, mtk_afe_hardware);
 
@@ -143,9 +146,10 @@ int mtk_afe_fe_hw_params(struct snd_pcm_substream *substream,
 			 memif->phys_buf_addr + memif->buffer_size - 1);
 
 	/* set MSB to 33-bit */
-	mtk_regmap_update_bits(afe->regmap, memif->data->msb_reg,
-			       1 << memif->data->msb_shift,
-			       msb_at_bit33 << memif->data->msb_shift);
+	if (memif->data->msb_shift >= 0)
+		mtk_regmap_update_bits(afe->regmap, memif->data->msb_reg,
+				       1 << memif->data->msb_shift,
+				       msb_at_bit33 << memif->data->msb_shift);
 
 	/* set channel */
 	if (memif->data->mono_shift >= 0) {
@@ -269,9 +273,10 @@ int mtk_afe_fe_prepare(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	mtk_regmap_update_bits(afe->regmap, memif->data->hd_reg,
-			       1 << memif->data->hd_shift,
-			       hd_audio << memif->data->hd_shift);
+	if (memif->data->hd_shift >= 0)
+		mtk_regmap_update_bits(afe->regmap, memif->data->hd_reg,
+				       1 << memif->data->hd_shift,
+				       hd_audio << memif->data->hd_shift);
 
 	return 0;
 }
-- 
2.20.1

