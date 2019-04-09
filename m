Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1AFC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139562084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfDIMf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:35:56 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:55249 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:35:53 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 9E8441C0009;
        Tue,  9 Apr 2019 12:35:50 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] gpio: pca953x: add support for pca6416
Date:   Tue,  9 Apr 2019 14:35:46 +0200
Message-Id: <20190409123546.13960-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409123546.13960-1-alexandre.belloni@bootlin.com>
References: <20190409123546.13960-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP PCA6416, documented at [1], is a variant of the PCA GPIO
expander with 16 GPIOs, and supporting an interrupt.

[1] https://www.nxp.com/docs/en/data-sheet/PCA6416A.pdf

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/gpio/gpio-pca953x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 7e76830b3368..7fb4d51277e4 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -73,6 +73,7 @@
 #define PCA_CHIP_TYPE(x)	((x) & PCA_TYPE_MASK)
 
 static const struct i2c_device_id pca953x_id[] = {
+	{ "pca6416", 16 | PCA953X_TYPE | PCA_INT, },
 	{ "pca9505", 40 | PCA953X_TYPE | PCA_INT, },
 	{ "pca9534", 8  | PCA953X_TYPE | PCA_INT, },
 	{ "pca9535", 16 | PCA953X_TYPE | PCA_INT, },
@@ -1137,6 +1138,7 @@ static int pca953x_resume(struct device *dev)
 #define OF_957X(__nrgpio, __int) (void *)(__nrgpio | PCA957X_TYPE | __int)
 
 static const struct of_device_id pca953x_dt_ids[] = {
+	{ .compatible = "nxp,pca6416", .data = OF_953X(16, PCA_INT), },
 	{ .compatible = "nxp,pca9505", .data = OF_953X(40, PCA_INT), },
 	{ .compatible = "nxp,pca9534", .data = OF_953X( 8, PCA_INT), },
 	{ .compatible = "nxp,pca9535", .data = OF_953X(16, PCA_INT), },
-- 
2.20.1

