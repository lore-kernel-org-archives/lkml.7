Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7B9C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A64E20718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421020;
	bh=VIMaAfth/Y/IlP5VCI9SmKGkfzw3jp29bSCwyGKtv9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D2C+AXs/4qGtBMN7PQE05iIUyOJBLFxHIoKGL1u6uTPG017ofpJOVGdZ+GCjcsWsn
	 +HcBggNeuwL/dmHxT+fmrXEF5wUg0UQHwP9Ed2w8kDT7PpmO0spzkwSHK54I4hZTGx
	 puIWg7g+IH/w3FFtHZ+q8vpd1bNI9G5ItNOxbnGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbfKVLCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:55736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729321AbfKVLCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:02:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE4822075B;
        Fri, 22 Nov 2019 11:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420537;
        bh=VIMaAfth/Y/IlP5VCI9SmKGkfzw3jp29bSCwyGKtv9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1LF4qptZMUQ2NaL744XdGXQMrTgEi/19rNvMlctP2eY32MHaiOC3ThgQf3ANE9NM9
         tVxsEEKcbK/JPCc662Sxgw1KuQxFxFwYhKmX5CX4YmVhTkS5N1aBTl7iJ4U64qsI5G
         zFc0wDID98ZmAgcCDcCRhS8IOwzR4zJZ67+o4MJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 140/220] dmaengine: rcar-dmac: set scatter/gather max segment size
Date:   Fri, 22 Nov 2019 11:28:25 +0100
Message-Id: <20191122100922.861135736@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 97d49c59e219acac576e16293a6b8cb99302f62f ]

Fix warning when running with CONFIG_DMA_API_DEBUG_SG=y by allocating a
device_dma_parameters structure and filling in the max segment size.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/sh/rcar-dmac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 041ce864097e4..80ff95f75199f 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -198,6 +198,7 @@ struct rcar_dmac {
 	struct dma_device engine;
 	struct device *dev;
 	void __iomem *iomem;
+	struct device_dma_parameters parms;
 
 	unsigned int n_channels;
 	struct rcar_dmac_chan *channels;
@@ -1814,6 +1815,8 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 
 	dmac->dev = &pdev->dev;
 	platform_set_drvdata(pdev, dmac);
+	dmac->dev->dma_parms = &dmac->parms;
+	dma_set_max_seg_size(dmac->dev, RCAR_DMATCR_MASK);
 	dma_set_mask_and_coherent(dmac->dev, DMA_BIT_MASK(40));
 
 	ret = rcar_dmac_parse_of(&pdev->dev, dmac);
-- 
2.20.1



