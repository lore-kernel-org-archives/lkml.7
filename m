Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C004C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0C3233FF
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfH3Nba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 09:31:30 -0400
Received: from sauhun.de ([88.99.104.3]:54416 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbfH3Nb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:31:29 -0400
Received: from localhost (p54B335BE.dip0.t-ipconnect.de [84.179.53.190])
        by pokefinder.org (Postfix) with ESMTPSA id D3E512C00A0;
        Fri, 30 Aug 2019 15:31:26 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-rtc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] rtc: max77686: convert to devm_i2c_new_dummy_device()
Date:   Fri, 30 Aug 2019 15:31:23 +0200
Message-Id: <20190830133124.21633-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830133124.21633-1-wsa+renesas@sang-engineering.com>
References: <20190830133124.21633-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was about to simplify the call to i2c_unregister_device() when I
realized that converting to devm_i2c_new_dummy_device() will simplify
the driver a lot. So I took this approach.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/rtc/rtc-max77686.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 7a98e0744878..d5a0e27dd0a0 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -690,8 +690,8 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 		goto add_rtc_irq;
 	}
 
-	info->rtc = i2c_new_dummy_device(parent_i2c->adapter,
-					 info->drv_data->rtc_i2c_addr);
+	info->rtc = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
+					      info->drv_data->rtc_i2c_addr);
 	if (IS_ERR(info->rtc)) {
 		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
 		return PTR_ERR(info->rtc);
@@ -702,7 +702,7 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 	if (IS_ERR(info->rtc_regmap)) {
 		ret = PTR_ERR(info->rtc_regmap);
 		dev_err(info->dev, "Failed to allocate RTC regmap: %d\n", ret);
-		goto err_unregister_i2c;
+		return ret;
 	}
 
 add_rtc_irq:
@@ -712,15 +712,10 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 				  &info->rtc_irq_data);
 	if (ret < 0) {
 		dev_err(info->dev, "Failed to add RTC irq chip: %d\n", ret);
-		goto err_unregister_i2c;
+		return ret;
 	}
 
 	return 0;
-
-err_unregister_i2c:
-	if (info->rtc)
-		i2c_unregister_device(info->rtc);
-	return ret;
 }
 
 static int max77686_rtc_probe(struct platform_device *pdev)
@@ -783,8 +778,6 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 
 err_rtc:
 	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
-	if (info->rtc)
-		i2c_unregister_device(info->rtc);
 
 	return ret;
 }
@@ -795,8 +788,6 @@ static int max77686_rtc_remove(struct platform_device *pdev)
 
 	free_irq(info->virq, info);
 	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
-	if (info->rtc)
-		i2c_unregister_device(info->rtc);
 
 	return 0;
 }
-- 
2.20.1

