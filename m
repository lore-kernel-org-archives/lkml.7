Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA246C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13EA2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fczeMukF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfEFH3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:29:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39814 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfEFH3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:29:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so4718156pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=f7WxjUUjnOPlZM9+bRj5MrZBRrYrZS5QSjQsKajsB4c=;
        b=fczeMukFRjRRR+1aDX01a1Sr2mHi7DtR4Gtz1E36ZgvfNGRxI7VHRp63sJWk5xuUVd
         o0Wb7seFcinpcZpharAZaaHr5ZZGvvzOMV9ME0H6FOdjrsnB9mbgM93u5eeuFSKsbI6j
         NYjZlaRe0WtRif1binGpkerwbW13qWMjK1tvAo/3YmkGInyZMpD9Y32gNvCyAB646HIy
         Z6vrWTbuSTDgmZ2BDBFp/TwHbNsDAHuQJYFoyyKd2YCECrvm4levP/dICyXtI8vJfDDQ
         OxWW8Ms0qtuB4MaRHjZs4uGlgrQRnwXpWURKM/IG96X4PBlpNiPvTTlbvE622E9RtDPk
         X/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=f7WxjUUjnOPlZM9+bRj5MrZBRrYrZS5QSjQsKajsB4c=;
        b=k26I4U2tXB1suramoQWErCbLUfshV3CYBXE25RL0rvyMG+wiScIo1rK8BcelGItKCg
         bJNyI/oKM6q3VxRH2siw//k15YMbJf6VquzpoOEAJgHei1iIz6ikTezKgyiXL1N4OgVS
         lk2+B38zqOyLCz8JLWZnSxiNj0eYTsAJUEYT7OgRJWj3OEa6FMUBNbFCao5BQto78vN9
         gCkYn715b8rtL+QxblRtcXigJFjPl4KzaYYImCMv3c+zbTOLTyWiBIhkvLRy7gKymixW
         1pWsRfGPRuBgVs/dwdy+5e+BOn5JKbIqQhLhe5j97HjC8O6BmWhOIMuM22PZyycmBOm8
         uvSA==
X-Gm-Message-State: APjAAAXLR2vLfuCR4vci86WDa/BZ9UluY+JMzUV6k4JgLpeDZVliaBEo
        j9xK361G/EHswL0CbhcWlIC+2g/6hb62ww==
X-Google-Smtp-Source: APXvYqw0/jP7NTJPqlt/wBZcCyCNPM0vzi6zk1f3mzoj6y3qOVMIOC7nx5Jf7rPfTEARDSVfB5uhLQ==
X-Received: by 2002:a63:e451:: with SMTP id i17mr30530636pgk.312.1557127746838;
        Mon, 06 May 2019 00:29:06 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w38sm21700894pgk.90.2019.05.06.00.29.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 00:29:06 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] dmaengine: sprd: Fix the right place to configure 2-stage transfer
Date:   Mon,  6 May 2019 15:28:32 +0800
Message-Id: <7eb64b3319cfa1859f2912398700d4204553c028.1557127239.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557127239.git.baolin.wang@linaro.org>
References: <cover.1557127239.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557127239.git.baolin.wang@linaro.org>
References: <cover.1557127239.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@unisoc.com>

Move the 2-stage configuration before configuring the link-list mode,
since we will use some 2-stage configuration to fill the link-list
configuration.

Signed-off-by: Eric Long <eric.long@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index a01c232..01abed5 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -911,6 +911,12 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
 		schan->linklist.virt_addr = 0;
 	}
 
+	/* Set channel mode and trigger mode for 2-stage transfer */
+	schan->chn_mode =
+		(flags >> SPRD_DMA_CHN_MODE_SHIFT) & SPRD_DMA_CHN_MODE_MASK;
+	schan->trg_mode =
+		(flags >> SPRD_DMA_TRG_MODE_SHIFT) & SPRD_DMA_TRG_MODE_MASK;
+
 	sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
 	if (!sdesc)
 		return NULL;
@@ -944,12 +950,6 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
 		}
 	}
 
-	/* Set channel mode and trigger mode for 2-stage transfer */
-	schan->chn_mode =
-		(flags >> SPRD_DMA_CHN_MODE_SHIFT) & SPRD_DMA_CHN_MODE_MASK;
-	schan->trg_mode =
-		(flags >> SPRD_DMA_TRG_MODE_SHIFT) & SPRD_DMA_TRG_MODE_MASK;
-
 	ret = sprd_dma_fill_desc(chan, &sdesc->chn_hw, 0, 0, src, dst, len,
 				 dir, flags, slave_cfg);
 	if (ret) {
-- 
1.7.9.5

