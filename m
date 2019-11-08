Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6E7C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25242085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214835;
	bh=9lp8kFKHd1OL9uVPSrrIRYlikpXGmBVr/jOZMSrQJck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s9ucJyNeBVGJsm5cqeS0mJzQCrJnymt8g9rhlM2r1UXZEzfUrYeTPZ+g7ZrGwF7t0
	 Jl7DxajcL0hY67R5o71dOHc52GMjWVgqJPv3HbY0za1KEsRQ22+x/Xc1/VZlgdLk9W
	 /nSd4xZDV1uvBjAop4MxErXgH1RrUvxABOT9anmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403824AbfKHMHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:07:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389105AbfKHLlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EF25222C4;
        Fri,  8 Nov 2019 11:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213260;
        bh=9lp8kFKHd1OL9uVPSrrIRYlikpXGmBVr/jOZMSrQJck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y7vDmtHo0T8VJmrIL+wI1v4J9OYgB7dsrJxBjSqLlxu7gLl/Ocx57MiIFCdp62j9X
         VwfNfl5Z4Hm5JyI+rcb6ujFZm5bkI6h7ddSibpZ/yqkhQFOTVb7I3Ab67yYO8Tq4EN
         qx+ovUoywaTH5o49ZthNHcl16Y4fM6v4Ct8Wqftw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 125/205] rtc: mt6397: fix possible race condition
Date:   Fri,  8 Nov 2019 06:36:32 -0500
Message-Id: <20191108113752.12502-125-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 385f8303bb412..e9a25ec4d434f 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -332,6 +332,10 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
+	rtc->rtc_dev = devm_rtc_allocate_device(rtc->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
 	ret = request_threaded_irq(rtc->irq, NULL,
 				   mtk_rtc_irq_handler_thread,
 				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
@@ -344,11 +348,11 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
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
 
@@ -365,7 +369,6 @@ static int mtk_rtc_remove(struct platform_device *pdev)
 {
 	struct mt6397_rtc *rtc = platform_get_drvdata(pdev);
 
-	rtc_device_unregister(rtc->rtc_dev);
 	free_irq(rtc->irq, rtc->rtc_dev);
 	irq_dispose_mapping(rtc->irq);
 
-- 
2.20.1

