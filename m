Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C59AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8F420830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120827;
	bh=FY/EUlQS4N2s2co7PlcvNhQsYjeZ7cSqWMW3E4pyJ4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WoLO+C6KAs0mIIhmT4B43R3p7M1Y1+SeTeHFAHGlwDWhpvZRp+q4Vx3l/SOlF3cNJ
	 r6by1965HvPcztNxjVQRTZTScgB28Eef4wpXn/TdT4hOxuwblT+IWad8HaASigHFnf
	 M9SnCfHXStHUbpK2Qd1dDu0IKpqDlBux9AMVqicw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392492AbfJCQk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392468AbfJCQkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:40:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB818215EA;
        Thu,  3 Oct 2019 16:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120818;
        bh=FY/EUlQS4N2s2co7PlcvNhQsYjeZ7cSqWMW3E4pyJ4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6Ck5/xHAFWVURCcplsXUvOwu8i8RIdtwIHN5Shje4R2KrIJlLY5OB3xtXD63rDX1
         ElZ67yXHRNe/yg4eDIb6fBNQ6OBBlRRurI3vafs3bQIDzKvUJimMcWmBQ9Etuv97K2
         V/HFOCW6LCXP9crqkw2AE9DHjb+ltzWPFKfpC/NU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 049/344] dmaengine: bcm2835: Print error in case setting DMA mask fails
Date:   Thu,  3 Oct 2019 17:50:14 +0200
Message-Id: <20191003154544.987348088@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 8101ff2f05c1c..970f654611bdd 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -871,8 +871,10 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
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



