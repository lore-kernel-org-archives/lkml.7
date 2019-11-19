Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8FDC43141
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFA420862
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142577;
	bh=Fu/I8ZnolOKDPg+/vRX8DzeqchGrL8EOnR20nT0rL9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=snjloeO1Bk4OcJLHDxC2ZRynPFuOkC0bL5uz1H/OzBxf6ERLNVrNMiKhAzSDbrG2W
	 rVhdof30U+ekKCn+ubRFwlgRSSlkG4q8nQPzKz6qI5VukqZMixBt5lLm8E9f3e6Rye
	 nbTRqhmwliGDc2lqlKfXeGtCZJIu1UQ2e6oobv44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbfKSFtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbfKSFte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:49:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E711421783;
        Tue, 19 Nov 2019 05:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142573;
        bh=Fu/I8ZnolOKDPg+/vRX8DzeqchGrL8EOnR20nT0rL9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILbquidxGKaM708GbRP/KweYD9vrtKJH05rEOEczfUHXtYE0o9CbvmfJQHa6DSzFO
         876OZo4JPTui7W6aKIPqO5rDun7fFfZ29FFGPJqhux1xqiOOp2eqqDL6Zv4H95os/l
         OK2NehuhT7KRfWrLhHqEMoZZYRH1evL5cztAFo0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 087/239] rtc: mt6397: fix possible race condition
Date:   Tue, 19 Nov 2019 06:18:07 +0100
Message-Id: <20191119051318.516914131@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit babab2f86440352d24e76118fdd7d40cab5fd7bf ]

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before requesting the IRQ.

Acked-by: Eddie Huang <eddie.huang@mediatek.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-mt6397.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 1a61fa56f3ad7..e82df43e5ca28 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -333,6 +333,10 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
+	rtc->rtc_dev = devm_rtc_allocate_device(rtc->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
 	ret = request_threaded_irq(rtc->irq, NULL,
 				   mtk_rtc_irq_handler_thread,
 				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
@@ -345,11 +349,11 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
-					   &mtk_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc->rtc_dev)) {
+	rtc->rtc_dev->ops = &mtk_rtc_ops;
+
+	ret = rtc_register_device(rtc->rtc_dev);
+	if (ret) {
 		dev_err(&pdev->dev, "register rtc device failed\n");
-		ret = PTR_ERR(rtc->rtc_dev);
 		goto out_free_irq;
 	}
 
@@ -366,7 +370,6 @@ static int mtk_rtc_remove(struct platform_device *pdev)
 {
 	struct mt6397_rtc *rtc = platform_get_drvdata(pdev);
 
-	rtc_device_unregister(rtc->rtc_dev);
 	free_irq(rtc->irq, rtc->rtc_dev);
 	irq_dispose_mapping(rtc->irq);
 
-- 
2.20.1



