Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFBAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C531C21787
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdfKOwx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfK1Quc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46129 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfK1QuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id k20so7341936pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ve1daf/mMGyyV9VtqaD9VZ+drFrdziUeyzqFEa1bEX8=;
        b=QdfKOwx2OJabOfCqE3mEGZgTrv2/gWtfc9aPsAegxShDlcJFxfod9xbR8qUpaUSrKA
         lN+swYwLnlgLgrSviR4JWJihJonMpuhy7wXqHAnmUInK0mv8323jJHcCIE4QGYw2lsZH
         q8oKAydylvf86RpUa4wuc+K76Mk8Yr0z0Bp0mJmTZlYpbNQelJuy2w772CJ365QXJ0hK
         sJQROf9qRH30ngnifsT6wcvVfOsqo0OHmynT5HckidI/ew0Z7ofqawUkSOMQO/qEzAcp
         C1v01meXvQFJRnBwVFxCG2S+pRY6T9NkCdPIOWPZspbfiwTUWLVf5twPkpqtU/z0nBQI
         nIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ve1daf/mMGyyV9VtqaD9VZ+drFrdziUeyzqFEa1bEX8=;
        b=UAnEfE6FnZ3FuniphjCOKucm3Oo24yN2EHjQt9HyOOoaj8Y6NhZyYUqtuFIx7HFtOL
         2Ol07gtDNIhKGg6SoeTCjddBOQ5TwEvaLPfHOA+aUT4BZjkUqw2VMtZmwbL3/d7jKSHH
         Toto+ph0SSrQ2T5KuXtY277nUgQ8wdFK/paSssQmBZEUuXSgJuETMH+znvCCDFZBhwPA
         3VKbXw2/TJlXipaH1K4Ir8wQRAFOODFzZy9AeVb6WiQEeD4x39KMDGZzQJOhFtRzj86v
         5U7FIBOLQ4M9FpAGxKFk21R5PTMCjq9POYJ6U2vS+zxHxVRxng7L4Ds++7g2AIpFQx+w
         ATTQ==
X-Gm-Message-State: APjAAAXXaM10q2gmlCJ9ygmRGugU1uyXUbmOGSKr18c2ah+Xm6zEvuSP
        +zYbsuqSjarPaGMqYAOvCoLK6w==
X-Google-Smtp-Source: APXvYqwF9EpUID9uoRJaTP7XOptfqBdu8zh2mx1l+skezdxU/+nVZEZ0krSH/BIt3st7U3Is4b6ZnQ==
X-Received: by 2002:a17:902:b181:: with SMTP id s1mr10698227plr.62.1574959820186;
        Thu, 28 Nov 2019 08:50:20 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:19 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 17/17] dmaengine: stm32-dma: check whether length is aligned on FIFO threshold
Date:   Thu, 28 Nov 2019 09:50:02 -0700
Message-Id: <20191128165002.6234-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

commit cc832dc8e32785a730ba07c3a357e17c201a5df8 upstream

When a period length is not multiple of FIFO some data may be stuck
within FIFO.

Burst/FIFO Threshold/Period or buffer length check has to be hardened

In any case DMA will grant any request from client but will degraded
any parameters whether awkward.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/dma/stm32-dma.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 379e8d534e61..4903a408fc14 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -308,20 +308,12 @@ static bool stm32_dma_fifo_threshold_is_allowed(u32 burst, u32 threshold,
 
 static bool stm32_dma_is_burst_possible(u32 buf_len, u32 threshold)
 {
-	switch (threshold) {
-	case STM32_DMA_FIFO_THRESHOLD_FULL:
-		if (buf_len >= STM32_DMA_MAX_BURST)
-			return true;
-		else
-			return false;
-	case STM32_DMA_FIFO_THRESHOLD_HALFFULL:
-		if (buf_len >= STM32_DMA_MAX_BURST / 2)
-			return true;
-		else
-			return false;
-	default:
-		return false;
-	}
+	/*
+	 * Buffer or period length has to be aligned on FIFO depth.
+	 * Otherwise bytes may be stuck within FIFO at buffer or period
+	 * length.
+	 */
+	return ((buf_len % ((threshold + 1) * 4)) == 0);
 }
 
 static u32 stm32_dma_get_best_burst(u32 buf_len, u32 max_burst, u32 threshold,
-- 
2.17.1

