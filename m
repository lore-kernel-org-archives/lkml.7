Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8995C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BE820733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xA6/rKgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfKOWeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:34:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41335 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfKOWeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:34:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id d29so5617295plj.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f67vg1P6cp56FC+gFomHmc7P3PWgRttseTI8GzuDMDw=;
        b=xA6/rKgNfSpMNx7U2CIf58R0lskOLg3y9hYciTIt8ZD92F0abPfnJuNWvlOArEOELy
         Eg1q0mG7cr3zITCHPC3sYPPWPZpvKqTpZpqj0CiwzgBAHOv+44QxulLsvWlnsWu4gd8H
         iEOqm1GqavhvEBS16eTYSVDgdfFhUlNs4E2uzERBdCZlfSInyLMACfvujQG9qO/qlK0o
         Uxl2r/sRt1TU1QCCi/KATL4JehE2IfKdKDi6Uc6qegftMBClBcB7jv9K0QwVPVRGR5/u
         9OJPcNqlrci4gxNVVvGbQUOYbTYXj8dLUk0yvBsQPmQBCW0m6Up7CMw0HPCnXfY/E4wQ
         KWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f67vg1P6cp56FC+gFomHmc7P3PWgRttseTI8GzuDMDw=;
        b=S6ca+tCzqGQEeWJLCkvCC+vpgs9ykT1Z9M0CcWweuisXc/vy6y7CvLs+O+aCuwIeaV
         74pVwIhzT/CLC3Lv0QTbyFT3jAMARLOqyqO5/bRcohD0l/JVDeFTR0RoKVrMyC2hC11q
         rDdcfLTssGfti/5jnWAOfVys3VVLdU1LCu9KurD+qbwejbOOrj/KAFU7isiF6hv6gXsi
         pmv6wuurK1y5encADCvr5MFR0sdMPrtj+WhStP60eUW635oXpeUVgQiJIBuv1KjvJa1k
         +AUke4U0ExasSA6EsR1V8U2ho/0wgSUZh+Wr6rWCbjFfDgB+nVo/6oV/CAfWcLMVqhp4
         mBfg==
X-Gm-Message-State: APjAAAViooSd+eAYJgd0QySCsvWFJT2twuZUepBpKAZr+IzjKva4zwVk
        cuw18w7MLeggQ6v4KnONgmN+X06uy+o=
X-Google-Smtp-Source: APXvYqy5gmuKV2XPYe0CJ9Tar06N04Tv6DzHZfUu5lOREsiiyK0PNj9Ybul3RHjzrkIoJm7yH+3w2A==
X-Received: by 2002:a17:902:ff14:: with SMTP id f20mr17167605plj.225.1573857250463;
        Fri, 15 Nov 2019 14:34:10 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:34:09 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 15/20] ASoC: stm32: i2s: fix dma configuration
Date:   Fri, 15 Nov 2019 15:33:51 -0700
Message-Id: <20191115223356.27675-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olivier Moysan <olivier.moysan@st.com>

commit 1ac2bd16448997d9ec01922423486e1e85535eda upstream

DMA configuration is not balanced on start/stop.
Move DMA configuration to trigger callback.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 sound/soc/stm/stm32_i2s.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 6d0bf78d114d..449bb7049a28 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -488,7 +488,7 @@ static int stm32_i2s_configure(struct snd_soc_dai *cpu_dai,
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
 	int format = params_width(params);
-	u32 cfgr, cfgr_mask, cfg1, cfg1_mask;
+	u32 cfgr, cfgr_mask, cfg1;
 	unsigned int fthlv;
 	int ret;
 
@@ -529,15 +529,11 @@ static int stm32_i2s_configure(struct snd_soc_dai *cpu_dai,
 	if (ret < 0)
 		return ret;
 
-	cfg1 = I2S_CFG1_RXDMAEN | I2S_CFG1_TXDMAEN;
-	cfg1_mask = cfg1;
-
 	fthlv = STM32_I2S_FIFO_SIZE * I2S_FIFO_TH_ONE_QUARTER / 4;
-	cfg1 |= I2S_CFG1_FTHVL_SET(fthlv - 1);
-	cfg1_mask |= I2S_CFG1_FTHVL_MASK;
+	cfg1 = I2S_CFG1_FTHVL_SET(fthlv - 1);
 
 	return regmap_update_bits(i2s->regmap, STM32_I2S_CFG1_REG,
-				  cfg1_mask, cfg1);
+				  I2S_CFG1_FTHVL_MASK, cfg1);
 }
 
 static int stm32_i2s_startup(struct snd_pcm_substream *substream,
@@ -589,6 +585,10 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		/* Enable i2s */
 		dev_dbg(cpu_dai->dev, "start I2S\n");
 
+		cfg1_mask = I2S_CFG1_RXDMAEN | I2S_CFG1_TXDMAEN;
+		regmap_update_bits(i2s->regmap, STM32_I2S_CFG1_REG,
+				   cfg1_mask, cfg1_mask);
+
 		ret = regmap_update_bits(i2s->regmap, STM32_I2S_CR1_REG,
 					 I2S_CR1_SPE, I2S_CR1_SPE);
 		if (ret < 0) {
-- 
2.17.1

