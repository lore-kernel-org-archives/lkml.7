Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CACC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AAA213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfDAQIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:08:22 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33299 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfDAQIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:08:22 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 12B721C0002;
        Mon,  1 Apr 2019 16:08:19 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 01/12] rtc: pcf85063: switch to probe_new
Date:   Mon,  1 Apr 2019 18:08:05 +0200
Message-Id: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct i2c_device_id argument of probe() is not used, so use probe_new()
instead.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index f6ce63c443a0..14a81fa916ca 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -207,8 +207,7 @@ static int pcf85063_load_capacitance(struct i2c_client *client)
 	return rc;
 }
 
-static int pcf85063_probe(struct i2c_client *client,
-				const struct i2c_device_id *id)
+static int pcf85063_probe(struct i2c_client *client)
 {
 	struct rtc_device *rtc;
 	int err;
@@ -236,12 +235,6 @@ static int pcf85063_probe(struct i2c_client *client,
 	return PTR_ERR_OR_ZERO(rtc);
 }
 
-static const struct i2c_device_id pcf85063_id[] = {
-	{ "pcf85063", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, pcf85063_id);
-
 #ifdef CONFIG_OF
 static const struct of_device_id pcf85063_of_match[] = {
 	{ .compatible = "nxp,pcf85063" },
@@ -255,8 +248,7 @@ static struct i2c_driver pcf85063_driver = {
 		.name	= "rtc-pcf85063",
 		.of_match_table = of_match_ptr(pcf85063_of_match),
 	},
-	.probe		= pcf85063_probe,
-	.id_table	= pcf85063_id,
+	.probe_new	= pcf85063_probe,
 };
 
 module_i2c_driver(pcf85063_driver);
-- 
2.20.1

