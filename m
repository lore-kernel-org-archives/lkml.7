Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E0DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1822184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbfDRKBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:01:08 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:49113 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388664AbfDRKBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:01:06 -0400
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 27F5DFF808;
        Thu, 18 Apr 2019 10:01:04 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/7] rtc: jz4740: use dev_pm_set_wake_irq() to simplify code
Date:   Thu, 18 Apr 2019 12:00:43 +0200
Message-Id: <20190418100045.29288-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418100045.29288-1-alexandre.belloni@bootlin.com>
References: <20190418100045.29288-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_pm_set_wake_irq() to set the RTC as a wakeup source for suspend.
This allows to remove the whole dev_pm_ops structure.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-jz4740.c | 37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 91ccb45bb886..fa15ad9fbe13 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/reboot.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
@@ -346,6 +347,12 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
+	ret = dev_pm_set_wake_irq(&pdev->dev, rtc->irq);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set wake irq: %d\n", ret);
+		return ret;
+	}
+
 	rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtc)) {
 		ret = PTR_ERR(rtc->rtc);
@@ -403,35 +410,6 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int jz4740_rtc_suspend(struct device *dev)
-{
-	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
-
-	if (device_may_wakeup(dev))
-		enable_irq_wake(rtc->irq);
-	return 0;
-}
-
-static int jz4740_rtc_resume(struct device *dev)
-{
-	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
-
-	if (device_may_wakeup(dev))
-		disable_irq_wake(rtc->irq);
-	return 0;
-}
-
-static const struct dev_pm_ops jz4740_pm_ops = {
-	.suspend = jz4740_rtc_suspend,
-	.resume  = jz4740_rtc_resume,
-};
-#define JZ4740_RTC_PM_OPS (&jz4740_pm_ops)
-
-#else
-#define JZ4740_RTC_PM_OPS NULL
-#endif  /* CONFIG_PM */
-
 static const struct platform_device_id jz4740_rtc_ids[] = {
 	{ "jz4740-rtc", ID_JZ4740 },
 	{ "jz4780-rtc", ID_JZ4780 },
@@ -443,7 +421,6 @@ static struct platform_driver jz4740_rtc_driver = {
 	.probe	 = jz4740_rtc_probe,
 	.driver	 = {
 		.name  = "jz4740-rtc",
-		.pm    = JZ4740_RTC_PM_OPS,
 		.of_match_table = of_match_ptr(jz4740_rtc_of_match),
 	},
 	.id_table = jz4740_rtc_ids,
-- 
2.20.1

