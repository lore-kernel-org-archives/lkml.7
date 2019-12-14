Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFD5C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A6E206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLNWLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:11:10 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58521 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfLNWKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:10:30 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 070EC40006;
        Sat, 14 Dec 2019 22:10:28 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 07/16] rtc: rv3029: simplify rv3029_alarm_irq_enable
Date:   Sat, 14 Dec 2019 23:10:13 +0100
Message-Id: <20191214221022.622482-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191214221022.622482-1-alexandre.belloni@bootlin.com>
References: <20191214221022.622482-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regmap_update_bits instead of open coding it in
rv3029_alarm_irq_enable.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv3029c2.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index f92fbb4db173..468542e98294 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -399,28 +399,11 @@ static int rv3029_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 static int rv3029_alarm_irq_enable(struct device *dev, unsigned int enable)
 {
-	int ret;
-	u8 controls;
-
-	ret = rv3029_read_regs(dev, RV3029_IRQ_CTRL, &controls, 1);
-	if (ret < 0) {
-		dev_warn(dev, "Read IRQ Control Register error %d\n", ret);
-		return ret;
-	}
-
-	/* enable/disable AIE irq */
-	if (enable)
-		controls |= RV3029_IRQ_CTRL_AIE;
-	else
-		controls &= ~RV3029_IRQ_CTRL_AIE;
-
-	ret = rv3029_write_regs(dev, RV3029_IRQ_CTRL, &controls, 1);
-	if (ret < 0) {
-		dev_err(dev, "can't update INT reg\n");
-		return ret;
-	}
+	struct rv3029_data *rv3029 = dev_get_drvdata(dev);
 
-	return 0;
+	return regmap_update_bits(rv3029->regmap, RV3029_IRQ_CTRL,
+				  RV3029_IRQ_CTRL_AIE,
+				  enable ? RV3029_IRQ_CTRL_AIE : 0);
 }
 
 static int rv3029_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
-- 
2.23.0

