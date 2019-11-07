Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70A3C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E55C222C6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdbGDG/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfKGURJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:17:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46619 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfKGURI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:17:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id b3so4498041wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Eh1A+XBqcPZEFBnh+HgUCyw+82+aoc7YA8bWZyx/XU=;
        b=HdbGDG/bD9rfLuXChKqfIL0GLBdwAQkoeEUR08XO5vmvDP4d9n5jwJzBtM5nafVUXy
         IbxdQZMZkDC143pI38WUWa9gkoPM4Ct8HTsfcpCvJyXbPWy6b1amMm4RNAayLLmuWkCF
         ot/OuCxCp8MppEtlxsnDIRm0zBzr2Y3olP1hj3Cfuhfe83eyDO1jtOrMhJgItBHinr5L
         NNo8Jeg3Xsvw+g9kiTxfMp/D1kolWj04wOkYmWlZHv4bo6wUkwhs7rp1K3ce/3oKRlrN
         cSVTDjamow1Jbjv7k3iY237zJd4PIhhBdAypb7a7ki5+2AsUX8w0g22P+oMjeBuyTZyv
         65xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Eh1A+XBqcPZEFBnh+HgUCyw+82+aoc7YA8bWZyx/XU=;
        b=FOTc12yb3CcdTvk8bsuUsNPcxvI4WAXwnT1IkDenUrbS2HoVVbmd4MciUu95nY98tP
         g9+ZeSx2abtkHJAr5cs0kby3ywRqMSuVBy/68dRVRGliL1ZeYGc1WTomtQc3JwhnSCmy
         0rKGrJbIAXErVh7BIVBdTpJr60J7NsWzp1VracG/4iL78x9K+vQAKCTML3F1gjCxLRmh
         5PJbXn2peMsX4XkYoUGCs8aiuKytX29/32JnHf8ItJmNLVnK+9DIpF17WEfbmr8QUS3p
         uBufcGiE6sdRtS/YLPYhJg8JeDFiq+8AT7nc2z9rp4h8odILqpQZ35QWqHL1It9EyfoC
         z3Sw==
X-Gm-Message-State: APjAAAVsdpAWNfklcyMwQW2V2xGukRzP0OYOQyQW9T/aEVH+jUNA/y45
        Inmsg/7RLNoEw6uQKctiq11KtA==
X-Google-Smtp-Source: APXvYqxskYQg9q985hoq9WCm5QC668oyfjuHraw4eT/RktdibeQ6Rb2kp4vLE3njmdl9xUCiiFZ/Nw==
X-Received: by 2002:a5d:5262:: with SMTP id l2mr4768386wrc.113.1573157826508;
        Thu, 07 Nov 2019 12:17:06 -0800 (PST)
Received: from localhost.localdomain ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id d11sm3215162wrn.28.2019.11.07.12.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:17:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 01/10] ASoC: max98090: remove 24-bit format support if RJ is 0
Date:   Thu,  7 Nov 2019 20:16:53 +0000
Message-Id: <20191107201702.27023-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu-Hsuan Hsu <yuhsuan@chromium.org>

[ Upstream commit 5628c8979642a076f91ee86c3bae5ad251639af0 ]

The supported formats are S16_LE and S24_LE now. However, by datasheet
of max98090, S24_LE is only supported when it is in the right justified
mode. We should remove 24-bit format if it is not in that mode to avoid
triggering error.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Change-Id: I68110cd295e9cd1c692bbd3cc3fbc247d92759a0
---
 sound/soc/codecs/max98090.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 607f68597c21..25565f364af8 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1847,6 +1847,21 @@ static const int dmic_comp[6][6] = {
 	{7, 8, 3, 3, 3, 3}
 };
 
+static int max98090_dai_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct max98090_priv *max98090 = snd_soc_component_get_drvdata(component);
+	unsigned int fmt = max98090->dai_fmt;
+
+	/* Remove 24-bit format support if it is not in right justified mode. */
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_RIGHT_J) {
+		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+		snd_pcm_hw_constraint_msbits(substream->runtime, 0, 16, 16);
+	}
+	return 0;
+}
+
 static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
@@ -2274,6 +2289,7 @@ EXPORT_SYMBOL_GPL(max98090_mic_detect);
 #define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
 static struct snd_soc_dai_ops max98090_dai_ops = {
+	.startup = max98090_dai_startup,
 	.set_sysclk = max98090_dai_set_sysclk,
 	.set_fmt = max98090_dai_set_fmt,
 	.set_tdm_slot = max98090_set_tdm_slot,
-- 
2.24.0

