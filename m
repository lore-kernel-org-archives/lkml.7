Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1034FC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5B520C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPTCkX6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfEGGKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:10:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37503 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEGGKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:10:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so7736265pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MjWLMAdBW11KI57uPKHpmOc8QO2EQsc2Bw5TFtq2aeM=;
        b=EPTCkX6PIWp6H6mHi0TmZyBHNTkNiDCOjwIvq4y+k7bAcUKgg+aAQYSeUiGtcEFhac
         uMQAb8Ce8bUqBZz0qzb3QD+1St8FT3LKJBOg2WJ79dLdgMiEnyhT6dED9GpA50HiDYXN
         g0cKvEmfcBjAZftLALFM6YJyyLCO2jGotOdpdiT+Jjqk4ZyUCejl/+4S7hjOJBIeAEgH
         EAM3+6a/PJghpLImXKKWgX2TNnpm0v9a0iYFb5ZHU9heUH6Nziw1o22ZNlXNQi/VzWyP
         yMjMvo3QcgAZii1n18z4Ol2nN+x5pdXG7MSREtWPwYDbLaQVwGa4WWigS7aVj5XMz8ac
         hXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MjWLMAdBW11KI57uPKHpmOc8QO2EQsc2Bw5TFtq2aeM=;
        b=mpVanc7tOL9ptBlTkaN5Tkjq9WAZACH4qxgLI3Ale1KheH5n3MEDnJu8xKMvc+Fg4F
         xDIcJDEdZoClc3EW5NQtUdU9bDckqCR5enhe6CmsKq9D2ugNSkyzvK3Nn78uPJgpTNHw
         w6zPDN8/Nf1ob9307TS94PKAPJa5F1IzBA1cmrCOSnRaZ5kYj0Ly4pUOMsaXDdZ2+zWy
         0aYDPJhkwNnuQ3yNVWzMEBCKdMr5CiTTEaikLnFKv/3E2PB5m3vx0wMEAGu1NX5Svea8
         LGx+DOS85qTFuga1XK+sGkTOZy46bW5vw4ZZCFwi3GgB7mVng1I1dPVl8VN0h7BYwicZ
         Z1PQ==
X-Gm-Message-State: APjAAAX5Nzok5wWVJ6zXOznRPQkJ5EWMbF/PD+N06wWNwpqrjtMLD+ky
        W7DPAUbio5UjFUYS4+rj1bvu7Q==
X-Google-Smtp-Source: APXvYqxLVILAxDHZN2kRQScJnvark6ssZgdEGaBWmo/QMwC9MFS0hSHYzRT49kNXNOF1nEGRxtcIsw==
X-Received: by 2002:aa7:90ca:: with SMTP id k10mr1280408pfk.20.1557209438341;
        Mon, 06 May 2019 23:10:38 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:37 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Zubair.Kakakhel@imgtec.com,
        wsa+renesas@sang-engineering.com, jroedel@suse.de,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/8] dmaengine: mxs-dma: Let the core do the device node validation
Date:   Tue,  7 May 2019 14:09:43 +0800
Message-Id: <c9b8865e869b4ca0bfcbaf04a997c4883dd8e15e.1557206859.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the DMA engine core do the device node validation instead of drivers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/mxs-dma.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 22cc7f6..8ce5e79 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -716,7 +716,6 @@ static int __init mxs_dma_init(struct mxs_dma_engine *mxs_dma)
 }
 
 struct mxs_dma_filter_param {
-	struct device_node *of_node;
 	unsigned int chan_id;
 };
 
@@ -727,9 +726,6 @@ static bool mxs_dma_filter_fn(struct dma_chan *chan, void *fn_param)
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
 	int chan_irq;
 
-	if (mxs_dma->dma_device.dev->of_node != param->of_node)
-		return false;
-
 	if (chan->chan_id != param->chan_id)
 		return false;
 
@@ -752,13 +748,13 @@ static struct dma_chan *mxs_dma_xlate(struct of_phandle_args *dma_spec,
 	if (dma_spec->args_count != 1)
 		return NULL;
 
-	param.of_node = ofdma->of_node;
 	param.chan_id = dma_spec->args[0];
 
 	if (param.chan_id >= mxs_dma->nr_channels)
 		return NULL;
 
-	return dma_request_channel(mask, mxs_dma_filter_fn, &param);
+	return __dma_request_channel(&mask, mxs_dma_filter_fn, &param,
+				     ofdma->of_node);
 }
 
 static int __init mxs_dma_probe(struct platform_device *pdev)
-- 
1.7.9.5

