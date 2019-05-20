Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD2CC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A235820656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/TmKJQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbfETLcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:32:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43925 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732919AbfETLcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:32:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn7so2434643plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Rhx5bIGIXYyTwXNSrFhH6sXCwPoowbOq8I8g6rhgfcM=;
        b=u/TmKJQVbWXU1jY6nvSgyqY9QzIEzS6idFSTXXT7qz9wsgNBI/s4V17hUgh4Rv7R2Y
         cwuuJfl56c+TBCEGqsc5RRIu34NSt4lHOx8UibOcyvnhXey8lHP7056ZxtHY0B4NseoG
         6152HD/5j7w4ftbZ4++CLib5eBofL1XNbn5oS8Osd8NYxVsBI8Ft9hZDT1zAZ/NwACnM
         BkDXCqfsjhvdPmSFeCmpfO3FxtOu2mbVJWnOjskv6Npuj/95BixXJKam34owM1QCU0dF
         hZkQDeWU7Y0zRyI7nbkB4upO4egh0ZnC/sBYA0i4TH21JKW6sXLUUZFUxv9bWc9DnUq2
         NdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Rhx5bIGIXYyTwXNSrFhH6sXCwPoowbOq8I8g6rhgfcM=;
        b=V05DQUV23LXLTu2kSTAXWBsjqsZSn/GILIknqZ9lmewa/mgr9Q5AKiTfxvLMokMc+B
         xhOm88Agl0p44VvJWxXf673Mq9EkYwmzP0M4SsKU5KNzwZ0q7223diUT14yfeAPKaNO8
         mnpYWVWgDp/E+JuHU4PRjr0oJikB83J1f1k1EZHWQsu4ZvtzXcrNMohPiy6l9s2LZZv5
         Y309elUrhdYYykFnUiu0+smqjUsJagjYDsWYj31YRIAX9WT3ors/f9HJW9fdpgJuCO5M
         MNQuTEAAR3fNGnaXwkZWY55T76sSu36GwcgV2Ovu0mV4I+xE51KvDakLa2+JKnq35ARG
         iteA==
X-Gm-Message-State: APjAAAX7u7MsbfEgwRPdpYAS4MkpPZtkpZ1jbwMt83SysvWnCk0OA/wf
        aWuU5Q7PvGYOdSdHKlQJfi4s36TgxD6Phw==
X-Google-Smtp-Source: APXvYqwgHwuoUVL1ByBfPSEobTX9ErDzyRhrOOJ1I3tJoZIQ3cgXSjtVqIPbUPY7AzkB1zM9IH6mIA==
X-Received: by 2002:a17:902:8ec4:: with SMTP id x4mr65112742plo.249.1558351966882;
        Mon, 20 May 2019 04:32:46 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z124sm21310020pfz.116.2019.05.20.04.32.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 04:32:46 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, wsa+renesas@sang-engineering.com,
        jroedel@suse.de, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/8] dmaengine: imx-sdma: Let the core do the device node validation
Date:   Mon, 20 May 2019 19:32:16 +0800
Message-Id: <77c1171088844b62a50977817103c2cf01fd75ae.1558351667.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558351667.git.baolin.wang@linaro.org>
References: <cover.1558351667.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558351667.git.baolin.wang@linaro.org>
References: <cover.1558351667.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the DMA engine core do the device node validation instead of drivers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/imx-sdma.c                |    9 ++-------
 include/linux/platform_data/dma-imx.h |    1 -
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 99d9f43..ca296f0 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1934,16 +1934,11 @@ static int sdma_init(struct sdma_engine *sdma)
 static bool sdma_filter_fn(struct dma_chan *chan, void *fn_param)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_engine *sdma = sdmac->sdma;
 	struct imx_dma_data *data = fn_param;
 
 	if (!imx_dma_is_general_purpose(chan))
 		return false;
 
-	/* return false if it's not the right device */
-	if (sdma->dev->of_node != data->of_node)
-		return false;
-
 	sdmac->data = *data;
 	chan->private = &sdmac->data;
 
@@ -1971,9 +1966,9 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 	 * be set to sdmac->event_id1.
 	 */
 	data.dma_request2 = 0;
-	data.of_node = ofdma->of_node;
 
-	return dma_request_channel(mask, sdma_filter_fn, &data);
+	return __dma_request_channel(&mask, sdma_filter_fn, &data,
+				     ofdma->of_node);
 }
 
 static int sdma_probe(struct platform_device *pdev)
diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index 9daea8d..7d964e7 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -55,7 +55,6 @@ struct imx_dma_data {
 	int dma_request2; /* secondary DMA request line */
 	enum sdma_peripheral_type peripheral_type;
 	int priority;
-	struct device_node *of_node;
 };
 
 static inline int imx_dma_is_ipu(struct dma_chan *chan)
-- 
1.7.9.5

