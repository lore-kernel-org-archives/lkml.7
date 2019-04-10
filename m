Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECF6C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8A020830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDJU4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:56:10 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42123 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfDJU4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:56:10 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C39D140002;
        Wed, 10 Apr 2019 20:56:07 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/5] rtc: pcf85363: remove unused struct pcf85363 member
Date:   Wed, 10 Apr 2019 22:56:00 +0200
Message-Id: <20190410205604.25262-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcf85363->dev is unused, remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85363.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index a3988079f60a..3905c0ad9d83 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -115,7 +115,6 @@
 static struct i2c_driver pcf85363_driver;
 
 struct pcf85363 {
-	struct device		*dev;
 	struct rtc_device	*rtc;
 	struct regmap		*regmap;
 };
@@ -400,10 +399,9 @@ static int pcf85363_probe(struct i2c_client *client,
 		return PTR_ERR(pcf85363->regmap);
 	}
 
-	pcf85363->dev = &client->dev;
 	i2c_set_clientdata(client, pcf85363);
 
-	pcf85363->rtc = devm_rtc_allocate_device(pcf85363->dev);
+	pcf85363->rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(pcf85363->rtc))
 		return PTR_ERR(pcf85363->rtc);
 
@@ -413,7 +411,7 @@ static int pcf85363_probe(struct i2c_client *client,
 		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
 		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
 				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
-		ret = devm_request_threaded_irq(pcf85363->dev, client->irq,
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, pcf85363_rtc_handle_irq,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						"pcf85363", client);
-- 
2.20.1

