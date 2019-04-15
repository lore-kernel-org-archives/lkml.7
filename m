Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015D9C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B4820645
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AFS5IiI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfDOMPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:15:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37514 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfDOMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:15:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id w23so8490711ply.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FU8i9sjlSh306RyY3KlsqQMktsvNVB138smTRNfYHGU=;
        b=AFS5IiI7xOQqGJvdX3jWPeHMgEaddq60Wu+mQTWo9KU//G0mncQiIddMO45w+tjPA+
         Kv3+9yZefuPBQeli3eiNPKZqkd8JNSY4QuxA6x4tLrpRpTL9T89A6scpglan6YaBRyZj
         gChs7FtshKwf/UtqCecWfo393HIOS3cc53Nq54k39Zf5AKKQ7C0w8GCK/RIZFsXU+Ng3
         imk61hg41zMEk1DH96nE5Jn+jGjJAq1Ow+yVNBB13nOVKc3FS9P+Xm+830WtjJYASdp+
         AR0CJWj7vwkz5MWIPEAGve53UGAvZ3V0KUy+v3HUG6rY5S6cd+nnQ0x6Zl7pXuPqfKjL
         dnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FU8i9sjlSh306RyY3KlsqQMktsvNVB138smTRNfYHGU=;
        b=jsXGi6R7h2lFeuXi1Cmvcg/lK1rLxDb2ry+3at98eOKrGzydK1+5uAZjCPBDpe9LoY
         JssRBYV7jNGadLg8BcxzZmHaV8/YjHZ0Ft6DfaMPlPb0HbYxlk57CnseMeXqiD30JroX
         NQ1ZXSzJqubpwtxgilsAuoFsWbDBX+FlbrUd8oHbW5OG+BqlIkV6vjpfh2qHsTLZLzm8
         skIeQ/bWyuu/PCasXUPL9Pd/UmcxG0yV0DUd+plkDTXFfPkIo2RQtAP+15WwXbs49mfA
         7cntMhueYNpEmFboAQHt7wLrL7Yc2fXuwAptwQhvzqoHUcexs5X1OoxVIYBxPP00oIfD
         iatw==
X-Gm-Message-State: APjAAAV8Rb/slZ0CDlQTusevcU/s9TuPkDH8nxx90ZqgiFC4DQuuKVwq
        ZFkPD50y+q3ixdSNAl0nAA8Z3Q==
X-Google-Smtp-Source: APXvYqyjtYWF0hbMw90duq0+/dpp5oFpiJeExGC/I4MZEP6GJXBrPIFhLbOlqjDD1GmeOvdA12BVVg==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr53043634pld.204.1555330540739;
        Mon, 15 Apr 2019 05:15:40 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 6sm64157155pfj.95.2019.04.15.05.15.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 05:15:40 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] dmaengine: sprd: Add interrupt support for 2-stage transfer
Date:   Mon, 15 Apr 2019 20:15:01 +0800
Message-Id: <07c070b4397296a4500d04abe16dfd8a71a2f211.1555330115.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1555330115.git.baolin.wang@linaro.org>
References: <cover.1555330115.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1555330115.git.baolin.wang@linaro.org>
References: <cover.1555330115.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 2-stage transfer, some users like Audio still need transaction interrupt
to notify when the 2-stage transfer is completed. Thus we should enable
2-stage transfer interrupt to support this feature.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index cc9c24d..4c18f44 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -62,6 +62,8 @@
 /* SPRD_DMA_GLB_2STAGE_GRP register definition */
 #define SPRD_DMA_GLB_2STAGE_EN		BIT(24)
 #define SPRD_DMA_GLB_CHN_INT_MASK	GENMASK(23, 20)
+#define SPRD_DMA_GLB_DEST_INT		BIT(22)
+#define SPRD_DMA_GLB_SRC_INT		BIT(20)
 #define SPRD_DMA_GLB_LIST_DONE_TRG	BIT(19)
 #define SPRD_DMA_GLB_TRANS_DONE_TRG	BIT(18)
 #define SPRD_DMA_GLB_BLOCK_DONE_TRG	BIT(17)
@@ -135,6 +137,7 @@
 /* define DMA channel mode & trigger mode mask */
 #define SPRD_DMA_CHN_MODE_MASK		GENMASK(7, 0)
 #define SPRD_DMA_TRG_MODE_MASK		GENMASK(7, 0)
+#define SPRD_DMA_INT_TYPE_MASK		GENMASK(7, 0)
 
 /* define the DMA transfer step type */
 #define SPRD_DMA_NONE_STEP		0
@@ -190,6 +193,7 @@ struct sprd_dma_chn {
 	u32			dev_id;
 	enum sprd_dma_chn_mode	chn_mode;
 	enum sprd_dma_trg_mode	trg_mode;
+	enum sprd_dma_int_type	int_type;
 	struct sprd_dma_desc	*cur_desc;
 };
 
@@ -429,6 +433,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
 		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
+		if (schan->int_type != SPRD_DMA_NO_INT)
+			val |= SPRD_DMA_GLB_SRC_INT;
+
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
 		break;
 
@@ -436,6 +443,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
 		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
+		if (schan->int_type != SPRD_DMA_NO_INT)
+			val |= SPRD_DMA_GLB_SRC_INT;
+
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
 		break;
 
@@ -443,6 +453,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
 			SPRD_DMA_GLB_DEST_CHN_MASK;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
+		if (schan->int_type != SPRD_DMA_NO_INT)
+			val |= SPRD_DMA_GLB_DEST_INT;
+
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
 		break;
 
@@ -450,6 +463,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
 			SPRD_DMA_GLB_DEST_CHN_MASK;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
+		if (schan->int_type != SPRD_DMA_NO_INT)
+			val |= SPRD_DMA_GLB_DEST_INT;
+
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
 		break;
 
@@ -911,11 +927,15 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
 		schan->linklist.virt_addr = 0;
 	}
 
-	/* Set channel mode and trigger mode for 2-stage transfer */
+	/*
+	 * Set channel mode, interrupt mode and trigger mode for 2-stage
+	 * transfer.
+	 */
 	schan->chn_mode =
 		(flags >> SPRD_DMA_CHN_MODE_SHIFT) & SPRD_DMA_CHN_MODE_MASK;
 	schan->trg_mode =
 		(flags >> SPRD_DMA_TRG_MODE_SHIFT) & SPRD_DMA_TRG_MODE_MASK;
+	schan->int_type = flags & SPRD_DMA_INT_TYPE_MASK;
 
 	sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
 	if (!sdesc)
-- 
1.7.9.5

