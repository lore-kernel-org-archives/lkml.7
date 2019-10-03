Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406B6C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC6C20830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124551;
	bh=3UDV5in8M3RtX+wA9xJxQHeRLPcU7Ft2VvUHYqQ0pFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B88RgB/lYbybUIqqrGlsFHlahtBe8onIXH9FJjOdg/mdP49mnKBifMqfJgj3Md33g
	 hwl9h9CiwunkhXGZYtKTl6zK8ItN8FAhk8aU1+N10e9936v2xNKxXJInbx+Y6/cZol
	 9RElSAq+mqMDqRj5taXmBXsYowTV53WbRqK0l8NM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfJCP5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730881AbfJCP5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:57:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A52A21D81;
        Thu,  3 Oct 2019 15:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118230;
        bh=3UDV5in8M3RtX+wA9xJxQHeRLPcU7Ft2VvUHYqQ0pFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1OAh98GkJ7JddshT5C3TLhBRi9AvG1iGCsXg48F32NXGPhcPlMeMu1zosU5uLFuk
         23HSeTeWD28fNdAXmT0emNuavTh6o1qHNixbTY3IZqZMbU4jwnaf4e7S00CzAdGA2O
         lNeSpHbU+AxBunWrZR9zD2AkrVLmzwo8UXYHYKWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 35/99] dmaengine: bcm2835: Print error in case setting DMA mask fails
Date:   Thu,  3 Oct 2019 17:52:58 +0200
Message-Id: <20191003154311.986985943@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
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



