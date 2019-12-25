Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CE6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 11:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D512073B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 11:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLYLQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:16:45 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:36556 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbfLYLQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 06:16:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id B60ADFB03;
        Wed, 25 Dec 2019 12:16:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l4o1HpI18I6F; Wed, 25 Dec 2019 12:16:41 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B588F40BE3; Wed, 25 Dec 2019 12:16:39 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] leds: lm3692x: Split out lm3692x_leds_disable
Date:   Wed, 25 Dec 2019 12:16:38 +0100
Message-Id: <dce4e011e5172c4ded5f5a41f7b4f1154ac1ff66.1577272495.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1577272495.git.agx@sigxcpu.org>
References: <cover.1577272495.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the relevant parts out of lm3692x_remove() and
call it from there. No functional change.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/leds/leds-lm3692x.c | 42 +++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index 7bf97ee6aa92..d1bd9ae4e7ab 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -288,6 +288,30 @@ static int lm3692x_leds_enable(struct lm3692x_led *led)
 	return ret;
 }
 
+static int lm3692x_leds_disable(struct lm3692x_led *led)
+{
+	int ret;
+
+	ret = regmap_update_bits(led->regmap, LM3692X_EN, LM3692X_DEVICE_EN, 0);
+	if (ret) {
+		dev_err(&led->client->dev, "Failed to disable regulator: %d\n",
+			ret);
+		return ret;
+	}
+
+	if (led->enable_gpio)
+		gpiod_direction_output(led->enable_gpio, 0);
+
+	if (led->regulator) {
+		ret = regulator_disable(led->regulator);
+		if (ret)
+			dev_err(&led->client->dev,
+				"Failed to disable regulator: %d\n", ret);
+	}
+
+	return ret;
+}
+
 static int lm3692x_brightness_set(struct led_classdev *led_cdev,
 				enum led_brightness brt_val)
 {
@@ -474,23 +498,9 @@ static int lm3692x_remove(struct i2c_client *client)
 	struct lm3692x_led *led = i2c_get_clientdata(client);
 	int ret;
 
-	ret = regmap_update_bits(led->regmap, LM3692X_EN, LM3692X_DEVICE_EN, 0);
-	if (ret) {
-		dev_err(&led->client->dev, "Failed to disable regulator: %d\n",
-			ret);
+	ret = lm3692x_leds_disable(led);
+	if (ret)
 		return ret;
-	}
-
-	if (led->enable_gpio)
-		gpiod_direction_output(led->enable_gpio, 0);
-
-	if (led->regulator) {
-		ret = regulator_disable(led->regulator);
-		if (ret)
-			dev_err(&led->client->dev,
-				"Failed to disable regulator: %d\n", ret);
-	}
-
 	mutex_destroy(&led->lock);
 
 	return 0;
-- 
2.23.0

