Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89382C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5D821A4A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568067462;
	bh=L0xacNcsY2XpxXNLsk8K58LyQ1BNZxBNfKIvvTCiasE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BCf16AFdkEzi6up4sWVTQh0Bw8djE+19a771pelccdZnBqSFtINxOoB/8rQAFLahD
	 H7lmmb/4aPlqr283BJHQx5rQH4b7mrM+HT61Gia3OMXzFl7ZviwT0dBDigr6XsAOBg
	 r/Jw6v298QLaxADYqoR9EICl2/M4r3XchJTXBRPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406406AbfIIWRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406370AbfIIWRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:17:33 -0400
Received: from sasha-vm.mshome.net (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69EE121D7D;
        Mon,  9 Sep 2019 22:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568067452;
        bh=L0xacNcsY2XpxXNLsk8K58LyQ1BNZxBNfKIvvTCiasE=;
        h=From:To:Cc:Subject:Date:From;
        b=tZZT7625XvUTqgHbQgm6cUenB8wtOPInb9ojr1BtpbUXh0ohJOnLvNIAGYXpMuMU6
         tHNPrJltMA2DGWVSdpcigd5nNo+/0U6mxhPlO46Ex/7EMUPpVgaNRD3heblj+xhG9a
         4fEC0mR0/tTUKQrfOnDpoIPes0r73XKYLqkJCnts=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 1/2] dmaengine: ti: omap-dma: Add cleanup in omap_dma_probe()
Date:   Mon,  9 Sep 2019 11:42:20 -0400
Message-Id: <20190909154221.31473-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 962411b05a6d3342aa649e39cda1704c1fc042c6 ]

If devm_request_irq() fails to disable all interrupts, no cleanup is
performed before retuning the error. To fix this issue, invoke
omap_dma_free() to do the cleanup.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/1565938570-7528-1-git-send-email-wenwen@cs.uga.edu
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/omap-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 1dfc71c90123f..57b6e6ca14a88 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1199,8 +1199,10 @@ static int omap_dma_probe(struct platform_device *pdev)
 
 		rc = devm_request_irq(&pdev->dev, irq, omap_dma_irq,
 				      IRQF_SHARED, "omap-dma-engine", od);
-		if (rc)
+		if (rc) {
+			omap_dma_free(od);
 			return rc;
+		}
 	}
 
 	rc = dma_async_device_register(&od->ddev);
-- 
2.20.1

