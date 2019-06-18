Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83426C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566E3206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfFRJOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:14:39 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2111 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfFRJOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:14:38 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45d08ab5c0ad-79f15; Tue, 18 Jun 2019 17:14:04 +0800 (CST)
X-RM-TRANSID: 2ee45d08ab5c0ad-79f15
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25d08ab5bebf-69608;
        Tue, 18 Jun 2019 17:14:04 +0800 (CST)
X-RM-TRANSID: 2ee25d08ab5bebf-69608
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     mchehab@kernel.org
Cc:     sean@mess.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: rc: remove redundant dev_err message
Date:   Tue, 18 Jun 2019 17:13:09 +0800
Message-Id: <1560849189-12031-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/media/rc/meson-ir.c  | 4 +---
 drivers/media/rc/mtk-cir.c   | 4 +---
 drivers/media/rc/sunxi-cir.c | 1 -
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/media/rc/meson-ir.c b/drivers/media/rc/meson-ir.c
index 9e1a978..bdcf9e9 100644
--- a/drivers/media/rc/meson-ir.c
+++ b/drivers/media/rc/meson-ir.c
@@ -113,10 +113,8 @@ static int meson_ir_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ir->reg = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ir->reg)) {
-		dev_err(dev, "failed to map registers\n");
+	if (IS_ERR(ir->reg))
 		return PTR_ERR(ir->reg);
-	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
diff --git a/drivers/media/rc/mtk-cir.c b/drivers/media/rc/mtk-cir.c
index 46101ef..50fb0ae 100644
--- a/drivers/media/rc/mtk-cir.c
+++ b/drivers/media/rc/mtk-cir.c
@@ -320,10 +320,8 @@ static int mtk_ir_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ir->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ir->base)) {
-		dev_err(dev, "failed to map registers\n");
+	if (IS_ERR(ir->base))
 		return PTR_ERR(ir->base);
-	}
 
 	ir->rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW);
 	if (!ir->rc) {
diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index a48f685..aa719d0 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -195,7 +195,6 @@ static int sunxi_ir_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ir->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ir->base)) {
-		dev_err(dev, "failed to map registers\n");
 		ret = PTR_ERR(ir->base);
 		goto exit_clkdisable_clk;
 	}
-- 
1.9.1



