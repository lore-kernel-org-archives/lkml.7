Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6E4C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCC72504A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189132;
	bh=fNIicfzKqgNknvOL8kafg05oEuWLA66QXO1DUGfYGHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=atGGcRXFFaQOWvkkZVsUGCSxmdYV7Pps5Qz55cyjaCZiZTX0l6JncT2taRFl3vaTs
	 JRam2xnmv/34k7uCp3yOt09xOMl27J5Abx2TgIsUoQFwZZnTejrF9fpKwkL2uK2XBu
	 +8chvdRlsrMb1KnP/1vBjICTA7ZId3H3bVLsn6/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfE3EFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731238AbfE3DRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:44 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 106302470B;
        Thu, 30 May 2019 03:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186264;
        bh=fNIicfzKqgNknvOL8kafg05oEuWLA66QXO1DUGfYGHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljj529Q7UCyBuSOwseUv/P/i0V/5T0em2AEmcLxMW3ulnFDgSKvUgKbsFNH5WlhYc
         2L1UkjsUaENQpZ3QD/AoXwmpxKK7WGCn/LGz3RerwkorECobtiu2V9bP5ZeC3t1DIP
         TYlVURdqqmp33wH51qLrnbUYIR4YC5Ci9klQeCHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 199/276] rtc: xgene: fix possible race condition
Date:   Wed, 29 May 2019 20:05:57 -0700
Message-Id: <20190530030537.555698648@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a652e00ee1233e251a337c28e18a1da59224e5ce ]

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
struct before requesting the IRQ.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-xgene.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index 153820876a820..2f741f455c30a 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -168,6 +168,10 @@ static int xgene_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(pdata->csr_base))
 		return PTR_ERR(pdata->csr_base);
 
+	pdata->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(pdata->rtc))
+		return PTR_ERR(pdata->rtc);
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "No IRQ resource\n");
@@ -198,15 +202,15 @@ static int xgene_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-					 &xgene_rtc_ops, THIS_MODULE);
-	if (IS_ERR(pdata->rtc)) {
-		clk_disable_unprepare(pdata->clk);
-		return PTR_ERR(pdata->rtc);
-	}
-
 	/* HW does not support update faster than 1 seconds */
 	pdata->rtc->uie_unsupported = 1;
+	pdata->rtc->ops = &xgene_rtc_ops;
+
+	ret = rtc_register_device(pdata->rtc);
+	if (ret) {
+		clk_disable_unprepare(pdata->clk);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.20.1



