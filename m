Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AC9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD468216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqAF6te9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfK1Qu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35297 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfK1QuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id s10so11812168plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j3tKRddo0sP/VNAlHyU3woPmGtLiTh7D/WlbKBjTt+o=;
        b=rqAF6te9rthxTZcjJVMOHReLi4Ieoi1PglEBAato0h+n0Nte51no34MOFzYYTnECH7
         tjTEGEoyXtjxOY9bbCX1BEZbD1S9gXhuEU3FurHraYK6FfyuLO2wnwN9spCkBk1vBXG9
         oZ4ydp3GGO82nT0eUUczi+ThQKTSsyUmPY7YYKA2BdQO6VZoTO/RVjfC0I2Q6ktbxPhR
         IEN+Bl8Shj2G6ap1l4T2tFQAzKaxwz7/BHTdJMeslUFTaoUgFxR0BgMbPmzl4tX/My7l
         LLEm4c7IOb6zdU2ScOJxnZH96HtYv9IiHEGbJg/rew3s66cM6VfHq2DSxyfGyg1jzfeZ
         JZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j3tKRddo0sP/VNAlHyU3woPmGtLiTh7D/WlbKBjTt+o=;
        b=p/FXi/0Wf/b7gPZG/CuAlxVGO19j5t7wjdFBtuHNMoYrGRoVxtHoofewnpFBSDP8ir
         wTtgNpc4PkANFd15IuL3D6SlGApYOvzGPfGpQjshfkSH4SPoNPG7cgpHxk4ApPcIX/vr
         0Q86RoVvcLh2SXkguKmaulSgO1G1fXUm9cjFeopTBxrp7NoSeqoAjXEYJ0tyap5pacMy
         tDKvJxOimg27Q70eI1zGUNPW7/ofJqTgnprEIJvqL1aSxXdPyqvKW2oe7gaqkzJxO9kx
         jOTJUrClrDvIOH/sRJv02BEHcAE+VLBKekWwEiMS2y1jp+/aIWAvBcIdk+ckB36X3K1U
         wAoQ==
X-Gm-Message-State: APjAAAVEjbozlE+3fnQBPY32J0k1AVy/DVQKLA4q8kyxEig8TuEA2a+Q
        hGc8pR/JblUKLo0wi/olNhJ1UhmVEjk=
X-Google-Smtp-Source: APXvYqw6bnbkAyEs9nANIBldH4r+0Epb9o9R/X8vZKnvryS9C7Bs7E5j0NZVw8WMZoHllLJCzCi41A==
X-Received: by 2002:a17:902:ff0e:: with SMTP id f14mr10621260plj.3.1574959818336;
        Thu, 28 Nov 2019 08:50:18 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:17 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 15/17] ASoC: stm32: i2s: fix IRQ clearing
Date:   Thu, 28 Nov 2019 09:50:00 -0700
Message-Id: <20191128165002.6234-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olivier Moysan <olivier.moysan@st.com>

commit 8ba3c5215d69c09f5c39783ff3b78347769822ad upstream

Because of regmap cache, interrupts may not be cleared
as expected.
Declare IFCR register as write only and make writings
to IFCR register unconditional.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 sound/soc/stm/stm32_i2s.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 004d83091505..aa2b1196171a 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -246,8 +246,8 @@ static irqreturn_t stm32_i2s_isr(int irq, void *devid)
 		return IRQ_NONE;
 	}
 
-	regmap_update_bits(i2s->regmap, STM32_I2S_IFCR_REG,
-			   I2S_IFCR_MASK, flags);
+	regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
+			  I2S_IFCR_MASK, flags);
 
 	if (flags & I2S_SR_OVR) {
 		dev_dbg(&pdev->dev, "Overrun\n");
@@ -276,7 +276,6 @@ static bool stm32_i2s_readable_reg(struct device *dev, unsigned int reg)
 	case STM32_I2S_CFG2_REG:
 	case STM32_I2S_IER_REG:
 	case STM32_I2S_SR_REG:
-	case STM32_I2S_IFCR_REG:
 	case STM32_I2S_TXDR_REG:
 	case STM32_I2S_RXDR_REG:
 	case STM32_I2S_CGFR_REG:
@@ -547,8 +546,8 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 	i2s->refcount++;
 	spin_unlock(&i2s->lock_fd);
 
-	return regmap_update_bits(i2s->regmap, STM32_I2S_IFCR_REG,
-				  I2S_IFCR_MASK, I2S_IFCR_MASK);
+	return regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
+				 I2S_IFCR_MASK, I2S_IFCR_MASK);
 }
 
 static int stm32_i2s_hw_params(struct snd_pcm_substream *substream,
@@ -603,8 +602,8 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			return ret;
 		}
 
-		regmap_update_bits(i2s->regmap, STM32_I2S_IFCR_REG,
-				   I2S_IFCR_MASK, I2S_IFCR_MASK);
+		regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
+				  I2S_IFCR_MASK, I2S_IFCR_MASK);
 
 		if (playback_flg) {
 			ier = I2S_IER_UDRIE;
-- 
2.17.1

