Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606CEC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35901214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfIXJCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:02:45 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35774 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfIXJCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:02:45 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F3151A00D4;
        Tue, 24 Sep 2019 11:02:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3048E1A0169;
        Tue, 24 Sep 2019 11:02:39 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BB501402ED;
        Tue, 24 Sep 2019 17:02:33 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     thierry.reding@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] pwm: pwm-imx-tpm: Use 'dev' instead of dereferencing it repeatedly
Date:   Tue, 24 Sep 2019 17:01:07 +0800
Message-Id: <1569315667-1525-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper variable dev = &pdev->dev to simply the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-imx-tpm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index e8385c1..4385801 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -337,11 +337,12 @@ static const struct pwm_ops imx_tpm_pwm_ops = {
 
 static int pwm_imx_tpm_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct imx_tpm_pwm_chip *tpm;
 	int ret;
 	u32 val;
 
-	tpm = devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
+	tpm = devm_kzalloc(dev, sizeof(*tpm), GFP_KERNEL);
 	if (!tpm)
 		return -ENOMEM;
 
@@ -351,23 +352,23 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 	if (IS_ERR(tpm->base))
 		return PTR_ERR(tpm->base);
 
-	tpm->clk = devm_clk_get(&pdev->dev, NULL);
+	tpm->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(tpm->clk)) {
 		ret = PTR_ERR(tpm->clk);
 		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"failed to get PWM clock: %d\n", ret);
 		return ret;
 	}
 
 	ret = clk_prepare_enable(tpm->clk);
 	if (ret) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"failed to prepare or enable clock: %d\n", ret);
 		return ret;
 	}
 
-	tpm->chip.dev = &pdev->dev;
+	tpm->chip.dev = dev;
 	tpm->chip.ops = &imx_tpm_pwm_ops;
 	tpm->chip.base = -1;
 	tpm->chip.of_xlate = of_pwm_xlate_with_flags;
@@ -381,7 +382,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(&tpm->chip);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
+		dev_err(dev, "failed to add PWM chip: %d\n", ret);
 		clk_disable_unprepare(tpm->clk);
 	}
 
-- 
2.7.4

