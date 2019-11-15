Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3177CC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0685520733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuCYF29X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfKOWe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:34:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41347 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfKOWeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:34:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id d29so5617431plj.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FlA/WYoLeRABK4x8leOELB1KpW2VXeE/7KRkjFeheIs=;
        b=EuCYF29XK/mB/F3BxjT3sWX6z88YjtNqs+w5TNJQP6w08JiRou935ewYfWNAW/g3Eg
         FYlTO4DtoNdOTwlSxUFfeQtM32HB8UD4XiO9OLyVfO071D1lvVGMwJJWMxV7DW959l9H
         3cEwLuybSJy5RgNBVbsk3HFrKrWbg+s5SFLxWWx6v5gjbraobv8BFodgs84RA1TUiybx
         8wvlY+DBrzz7i+IYZ/fG8vjyNWly48fh5ZQWjCLhzQuBoYMt+ckcnb/GiIKLPGqHmTMR
         H6s2ATHNqRlbPvsQBZJwh0jEIKkumM1yU/gS+DXe538ozDU9zHQll5wun9QYpe4w15+l
         ifVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FlA/WYoLeRABK4x8leOELB1KpW2VXeE/7KRkjFeheIs=;
        b=JSq591wB4XsoDBmkYo8fkPSfEjLwIjuTbAQVrbqYtnjyM4l2QL4dMVVH6iaDz4N2Nq
         gIGSFXo7d/ILjAU9WdURmUDLOcjrZ02X2yUdv2FJQ6PNhwPQhHzaqtFNHahcDFfep0hW
         UOIRT3Gku7g/qaBQtks7CwTc5okn6lzmqlYm7Xx2Rjbr58nWUhSV1SeHNc5kEWs5bkTj
         3XVSPRoKO1W3NKuKDgR/SIsxcSHQcu+mNeQQvmyBXXW8CZs2dmA4ld+xYhq+P0D2bVAX
         LIR/726I9i1DM1Kk4G9q6HtK+/1gLKuomPSEwp6UMB2McGKjJhc2xNbJr0uhdWkZ+Dui
         YMNQ==
X-Gm-Message-State: APjAAAV0hBHWI5Z4JXVPwWzS+9x4F+D30xurh5yZ8wXW6w9We5CPvAvb
        EgnmoCo+/s8+Vk5IYpq1e7F1og==
X-Google-Smtp-Source: APXvYqwrPgGdAOCHvG+Dr9yqtqFxSjTdBheEMm1jF9StVEaJaadS7qR9/JmFNyQStGJT1dxmYiuHuQ==
X-Received: by 2002:a17:90a:2385:: with SMTP id g5mr22958192pje.117.1573857255728;
        Fri, 15 Nov 2019 14:34:15 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:34:15 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 20/20] dmaengine: stm32-dma: check whether length is aligned on FIFO threshold
Date:   Fri, 15 Nov 2019 15:33:56 -0700
Message-Id: <20191115223356.27675-20-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
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
Cc: stable <stable@vger.kernel.org> # 4.19+
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

