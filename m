Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105EAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48B0216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxJzsLiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfK1Quj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35811 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfK1QuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id q13so13386441pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wD+KHeFwNIT1Ivtv7WYTanJVrN7dwD/1vKpe+xiraBg=;
        b=XxJzsLiKI5MPczc6OehjYgyBmdMq1rBlV4V+Ha6DjUUuQDc58zxRJ15aB+Flz2aYMS
         /2fsKbeii5vSFGyYLFyJL0ieaEG1MHCsh/SccclxbtTiOnqYmeL3m7skNy5lBQvJOuOT
         m+rX2LH9zpUQ7UCKhfMObYPSO4Z60lL4f3A9/vOxeL99JNhzPvuuT+Z8eWysovrGetzS
         8K5SG/rBLI4MDRNqWPudwHilN9b2NSGyWWr9rMZOFPKx1eX691hk+wXM1nql2Rvzn7NL
         DqT5nYp8ugOe+SrQ/msGWXnfK/LlZqTDFIAy0jA5CwthjBn12uB0UtN/h0ka68rAPhJq
         JFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wD+KHeFwNIT1Ivtv7WYTanJVrN7dwD/1vKpe+xiraBg=;
        b=gltvwI0OAHqspMKRMn0pUnWydq/qAyn5dybgaKKtnhynLQ1HHUeYjYS+y7Wv2hVLkG
         U59Ya4Rrlq2RxRvhdDZje9gxdgMtnrIWypTq/mqoA6lD/kLTA0Km87GZIIcOR6ABS69P
         e1knUsZ8Bpe1v2nnjeh6iXLn3q3Vb54KAIeKXk37f5UxF77njUbHwKmvpDUwzvgV96to
         Q7RgfMEU500rKDPt/RMYTn4lG8vmo+BY3Es4YsyN5WeTQASaOStAmuVjuj+whrTswpsk
         dpdWOOWsFFYVxf7uxIX9QT43Zy2PVu/i0zpo1gQ81l2TmntFRAhmE09V4LZZj1vocAHj
         nddw==
X-Gm-Message-State: APjAAAWEABB3PRWQk2ka2cF0XLqqXOi4318MgjqA6G4fNqKRo7JBpJsg
        LjHdpBU0EFGG/FQI3WksscNPJM+bMkI=
X-Google-Smtp-Source: APXvYqxS0HAt+GN5cRfQFCDZXmck4pldUrQ2zjv5oJleqUtgJvq5m2IQPbX/dTwWRbfK5ghbhPf7iw==
X-Received: by 2002:aa7:828c:: with SMTP id s12mr52785777pfm.166.1574959816244;
        Thu, 28 Nov 2019 08:50:16 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:15 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 13/17] ASoC: stm32: i2s: fix dma configuration
Date:   Thu, 28 Nov 2019 09:49:58 -0700
Message-Id: <20191128165002.6234-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
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
Cc: stable <stable@vger.kernel.org> # 4.19
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

