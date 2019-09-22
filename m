Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC254C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951B8206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179089;
	bh=3UDV5in8M3RtX+wA9xJxQHeRLPcU7Ft2VvUHYqQ0pFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bSQYnGU0qMDLAoAXCxP9kqkJP97hVzOWcJGVmlfDO/9U5dZLIauq/dSfFWDj7LxCO
	 wPSCjgiEq0MEswwwbw4wDXvizUoXz/eLbcfqvteR862xKOwD57hZTAlWk//ywCVsDD
	 D3RtbUF/AVtdsF0ZegXmovktPbfnORdZt5OVtB5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfIVTEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395253AbfIVTBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 15:01:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C98A214AF;
        Sun, 22 Sep 2019 19:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178867;
        bh=3UDV5in8M3RtX+wA9xJxQHeRLPcU7Ft2VvUHYqQ0pFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TT0EfqsMQ1XhpWLJVBOESzGc6fRTRZdp8f5kapoxf2q3KIWR5L1eyniXCLTXqvSpv
         4ZIBCFIYU7S5hCfQHVIih7gefexdCWCF8E5Jl/tvHljMJlJVoyoex9Wn/lyEu0V0qJ
         klFFUZnlBU9KD86jxWPFFwEfniYluaEgEU5Qnq1o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Wahren <wahrenst@gmx.net>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 03/44] dmaengine: bcm2835: Print error in case setting DMA mask fails
Date:   Sun, 22 Sep 2019 15:00:21 -0400
Message-Id: <20190922190103.4906-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922190103.4906-1-sashal@kernel.org>
References: <20190922190103.4906-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit 72503b25ee363827aafffc3e8d872e6a92a7e422 ]

During enabling of the RPi 4, we found out that the driver doesn't provide
a helpful error message in case setting DMA mask fails. So add one.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Link: https://lore.kernel.org/r/1563297318-4900-1-git-send-email-wahrenst@gmx.net
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/bcm2835-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 996c4b00d323e..d6cdc3be03fcc 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -595,8 +595,10 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-	if (rc)
+	if (rc) {
+		dev_err(&pdev->dev, "Unable to set DMA mask\n");
 		return rc;
+	}
 
 	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
 	if (!od)
-- 
2.20.1

