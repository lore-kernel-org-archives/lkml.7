Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FDDC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3673420825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0T6x4sW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfDOMPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:15:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39861 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfDOMPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:15:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id a96so8480578pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EPBexP/YCMERN6VOL5fv1yV7pop7BN15G/3B+N0nQ3U=;
        b=k0T6x4sWoWO1mBc+OId0DMBw+LrVnMU9zm0p6EsTYO/gUBNMYZKo11zY+DswnZgNt9
         hvgxI0ywLRGa/hlJyBh506+Le5G4rFLeuxya780+q9eWikKxy5O8aa0W/8gUdOOgE+np
         +FMg36Tr6d8dmrUl4QkCHHOgqLjaCvk6UvWbVIXZXio120GB05/WUAhYgaSyCabsZZei
         sax3hHlC/z6qHbXVkOmlIz+6SZw+rp4CMc2+cxPc5twLByBb1aPExtKsDBTydLG5yAcB
         xFDHS8C7Uzmn04mEefA0Xs6oJBmLCpJyJok+fN94irPRBuLhOmGMbLtslyRZj9czrBwD
         27Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EPBexP/YCMERN6VOL5fv1yV7pop7BN15G/3B+N0nQ3U=;
        b=Ub9fL7skyadLcc5HY5j5/XhSONs+TG+LfTGGctPd//XBlGh+Y+C3o409/sdcaa8tz1
         lH7iLeakwBTgCenTLOZJdxMGmW4X8hXxTmfa+lEs1cv07s4kNNL1TbXP72Qa79FE81gf
         hhJaHTHoSP5H1+TYRNh+sPAHAt9XbAQTKn4qi2LOQ69ypuwQgn3XIjOy6pdUjEA9sb5E
         uzcoZs9ESQC+HbyMgY+8nYR7KAR07Z0HFFSA4nOQQWCRWDpQh1kL98xSQ9VBDs3xWOo0
         mvyBw4ok4bThKR43F5oM3qQKCqIpfg9OOVUciyBitevWyBRvKo4+5gXTLrQjEDbl8d68
         M83Q==
X-Gm-Message-State: APjAAAUcRLfwlbWCpE73ixebeJOT1PDSHPyBH4/ZKf4SOx8BQvKgO4eJ
        gd5cUsPnEeB56Qnyu7QVrdQw7Q==
X-Google-Smtp-Source: APXvYqz6YojtFUUCP32JI2uCJ0plSoSuhQ4QnxncHO0rwmGARrnpkNtjTTtNr1F1bEYZuEEJYILPYg==
X-Received: by 2002:a17:902:d701:: with SMTP id w1mr76553552ply.124.1555330533557;
        Mon, 15 Apr 2019 05:15:33 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 6sm64157155pfj.95.2019.04.15.05.15.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 05:15:32 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] dmaengine: sprd: Fix block length overflow
Date:   Mon, 15 Apr 2019 20:14:59 +0800
Message-Id: <93626039ad49c1c9d5726218b060c2267c1779cf.1555330115.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1555330115.git.baolin.wang@linaro.org>
References: <cover.1555330115.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1555330115.git.baolin.wang@linaro.org>
References: <cover.1555330115.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@unisoc.com>

The maximum value of block length is 0xffff, so if the configured transfer length
is more than 0xffff, that will cause block length overflow to lead a configuration
error.

Thus we can set block length as the maximum burst length to avoid this issue, since
the maximum burst length will not be a big value which is more than 0xffff.

Signed-off-by: Eric Long <eric.long@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 9f99d4b..a64271e 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -778,7 +778,7 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 	temp |= slave_cfg->src_maxburst & SPRD_DMA_FRG_LEN_MASK;
 	hw->frg_len = temp;
 
-	hw->blk_len = len & SPRD_DMA_BLK_LEN_MASK;
+	hw->blk_len = slave_cfg->src_maxburst & SPRD_DMA_BLK_LEN_MASK;
 	hw->trsc_len = len & SPRD_DMA_TRSC_LEN_MASK;
 
 	temp = (dst_step & SPRD_DMA_TRSF_STEP_MASK) << SPRD_DMA_DEST_TRSF_STEP_OFFSET;
-- 
1.7.9.5

