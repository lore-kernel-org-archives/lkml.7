Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0F1C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A012A21A4A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504384AbfIXJob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:44:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58972 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbfIXJo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:44:28 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 80D2A2002C6;
        Tue, 24 Sep 2019 11:44:26 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F15A2000DE;
        Tue, 24 Sep 2019 11:44:22 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D7BF3402ED;
        Tue, 24 Sep 2019 17:44:16 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     thierry.reding@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] pwm: pwm-mxs: Use 'dev' instead of dereferencing it repeatedly
Date:   Tue, 24 Sep 2019 17:42:49 +0800
Message-Id: <1569318169-12327-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569318169-12327-1-git-send-email-Anson.Huang@nxp.com>
References: <1569318169-12327-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper variable dev = &pdev->dev to simply the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-mxs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index b14376b..6255ffc 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -124,11 +124,12 @@ static const struct pwm_ops mxs_pwm_ops = {
 
 static int mxs_pwm_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct mxs_pwm_chip *mxs;
 	int ret;
 
-	mxs = devm_kzalloc(&pdev->dev, sizeof(*mxs), GFP_KERNEL);
+	mxs = devm_kzalloc(dev, sizeof(*mxs), GFP_KERNEL);
 	if (!mxs)
 		return -ENOMEM;
 
@@ -136,23 +137,23 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(mxs->base))
 		return PTR_ERR(mxs->base);
 
-	mxs->clk = devm_clk_get(&pdev->dev, NULL);
+	mxs->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(mxs->clk))
 		return PTR_ERR(mxs->clk);
 
-	mxs->chip.dev = &pdev->dev;
+	mxs->chip.dev = dev;
 	mxs->chip.ops = &mxs_pwm_ops;
 	mxs->chip.base = -1;
 
 	ret = of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.npwm);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
+		dev_err(dev, "failed to get pwm number: %d\n", ret);
 		return ret;
 	}
 
 	ret = pwmchip_add(&mxs->chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
+		dev_err(dev, "failed to add pwm chip %d\n", ret);
 		return ret;
 	}
 
-- 
2.7.4

