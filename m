Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661ABC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3810B2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgAFPtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:49:10 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:41158 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgAFPtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:49:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5B22AFB03;
        Mon,  6 Jan 2020 16:49:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7Hmxyg6x44up; Mon,  6 Jan 2020 16:49:00 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4330149D3D; Mon,  6 Jan 2020 16:48:56 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] leds: lm3692x: Split out lm3692x_leds_disable
Date:   Mon,  6 Jan 2020 16:48:52 +0100
Message-Id: <79793beed2ef175a64c28700fdd234a007ca39a5.1578324703.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1578324703.git.agx@sigxcpu.org>
References: <cover.1578324703.git.agx@sigxcpu.org>
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
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/leds/leds-lm3692x.c | 42 +++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index f7fdfaee5ac5..1254695d7e94 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -289,6 +289,30 @@ static int lm3692x_leds_enable(struct lm3692x_led *led)
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
@@ -463,23 +487,9 @@ static int lm3692x_remove(struct i2c_client *client)
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

