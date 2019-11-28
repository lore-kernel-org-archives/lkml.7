Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC73C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C08216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5Gr5Qjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfK1QuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:24 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:43174 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfK1QuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:19 -0500
Received: by mail-pj1-f65.google.com with SMTP id a10so12094680pju.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zVs3SHcLVbqKmpq6Nb4lGHjdKCb+EPD/oEdMc3bO/jg=;
        b=l5Gr5Qjd9pVo0HxGFV6G8A0yjVBGoSZqzaCCL7mejIdkqCP3emkRfKj8vLMjNdrpI5
         bvYK/b71kLhhQVKEZiOQWGEt7vBsj8dzHZ4K6L1XdXY/KtWmYN0JevpFOi7pDPo80nKm
         XUlORXTdlW4bLLGIlr0oIyukod20PdmH18UUtPTZCj6rCyxonWYBR4EL+oIhrfooYI2G
         9cNOxHLh8rbhaCK5Ek1WiqhGaSM7g9KLuIuUeWE4xtOiN8xNKP0PgNzKpMklVjQJV15q
         g49ojWGv2xVRuHFFcgdRV5TslE85XMW6WJzfxKEMOl5c1eKidIUWEnBJOB1YP5/VeAuJ
         WEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zVs3SHcLVbqKmpq6Nb4lGHjdKCb+EPD/oEdMc3bO/jg=;
        b=PPvkvRDG4ejENDgefK3j++P3Z95p0ULQ1KaPdX/zKDx3FI81vpH4yn4KZ3f4mQR2Pm
         X30F3QK39X1c+/R+ueslfHMdwCLJZKnJGpQTBjwbxRnEDuKBFT669M7REcCe5fA4OpoH
         aUdHommVW5M0Mlo05wn080mVjL1ajg87S/ZxwkW3DrNyUSQMv0NvwTtgRdS3dtvlBgle
         l2sQwNSs5kYcxCxSHyoHKkGCuNzcn/4JqzBmuj1ZRebsAalnfvGFxpqZ1CqhsLRMjQBC
         P/ug9LM3X+oVC5cvJBI/6ni5Ym/u68djzJ2Y2clglZXFR2jUTwf4sfSg5JTAR4xelP7f
         wEjg==
X-Gm-Message-State: APjAAAXpOV2/EdULqH/GrdOVCPtq7HvMbsUzX5xR8Eo5PzPdmd4uSHy+
        ERd6giEieP9lKCgecne/itguSA==
X-Google-Smtp-Source: APXvYqz5iFTxCKBSv+g9xpXEiPFwlT40atPfb9JCN8mALvNzpqC+2vNzcqNyKb0PlddBnmfLwvZVBA==
X-Received: by 2002:a17:902:8bc8:: with SMTP id r8mr10661273plo.189.1574959817142;
        Thu, 28 Nov 2019 08:50:17 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:16 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 14/17] ASoC: stm32: i2s: fix 16 bit format support
Date:   Thu, 28 Nov 2019 09:49:59 -0700
Message-Id: <20191128165002.6234-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olivier Moysan <olivier.moysan@st.com>

commit 0c4c68d6fa1bae74d450e50823c24fcc3cd0b171 upstream

I2S supports 16 bits data in 32 channel length.
However the expected driver behavior, is to
set channel length to 16 bits when data format is 16 bits.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 sound/soc/stm/stm32_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 449bb7049a28..004d83091505 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -501,7 +501,7 @@ static int stm32_i2s_configure(struct snd_soc_dai *cpu_dai,
 	switch (format) {
 	case 16:
 		cfgr = I2S_CGFR_DATLEN_SET(I2S_I2SMOD_DATLEN_16);
-		cfgr_mask = I2S_CGFR_DATLEN_MASK;
+		cfgr_mask = I2S_CGFR_DATLEN_MASK | I2S_CGFR_CHLEN;
 		break;
 	case 32:
 		cfgr = I2S_CGFR_DATLEN_SET(I2S_I2SMOD_DATLEN_32) |
-- 
2.17.1

