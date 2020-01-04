Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352A8C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 10:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17918215A4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 10:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgADKyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 05:54:44 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:40228 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgADKyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 05:54:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6F42AFB03;
        Sat,  4 Jan 2020 11:54:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rftix7xdUw4g; Sat,  4 Jan 2020 11:54:32 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 5232A49AAE; Sat,  4 Jan 2020 11:54:26 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/9] leds: lm3692x: Move lm3692x_init and rename to lm3692x_leds_enable
Date:   Sat,  4 Jan 2020 11:54:23 +0100
Message-Id: <deca6166ac64b2f98d8576cac45602c05e458282.1578134779.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1578134779.git.agx@sigxcpu.org>
References: <cover.1578134779.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves lm3692x_init so it can be used from
lm3692x_brightness_set. Rename to lm3692_leds_enable to pair up
with lm3692x_leds_disable. No functional change.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/leds/leds-lm3692x.c | 70 ++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index 2e24316566f5..2b8f87b829ae 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -165,40 +165,7 @@ static int lm3692x_fault_check(struct lm3692x_led *led)
 	return read_buf;
 }
 
-static int lm3692x_brightness_set(struct led_classdev *led_cdev,
-				enum led_brightness brt_val)
-{
-	struct lm3692x_led *led =
-			container_of(led_cdev, struct lm3692x_led, led_dev);
-	int ret;
-	int led_brightness_lsb = (brt_val >> 5);
-
-	mutex_lock(&led->lock);
-
-	ret = lm3692x_fault_check(led);
-	if (ret) {
-		dev_err(&led->client->dev, "Cannot read/clear faults: %d\n",
-			ret);
-		goto out;
-	}
-
-	ret = regmap_write(led->regmap, LM3692X_BRT_MSB, brt_val);
-	if (ret) {
-		dev_err(&led->client->dev, "Cannot write MSB: %d\n", ret);
-		goto out;
-	}
-
-	ret = regmap_write(led->regmap, LM3692X_BRT_LSB, led_brightness_lsb);
-	if (ret) {
-		dev_err(&led->client->dev, "Cannot write LSB: %d\n", ret);
-		goto out;
-	}
-out:
-	mutex_unlock(&led->lock);
-	return ret;
-}
-
-static int lm3692x_init(struct lm3692x_led *led)
+static int lm3692x_leds_enable(struct lm3692x_led *led)
 {
 	int enable_state;
 	int ret, reg_ret;
@@ -321,6 +288,39 @@ static int lm3692x_init(struct lm3692x_led *led)
 	return ret;
 }
 
+static int lm3692x_brightness_set(struct led_classdev *led_cdev,
+				enum led_brightness brt_val)
+{
+	struct lm3692x_led *led =
+			container_of(led_cdev, struct lm3692x_led, led_dev);
+	int ret;
+	int led_brightness_lsb = (brt_val >> 5);
+
+	mutex_lock(&led->lock);
+
+	ret = lm3692x_fault_check(led);
+	if (ret) {
+		dev_err(&led->client->dev, "Cannot read/clear faults: %d\n",
+			ret);
+		goto out;
+	}
+
+	ret = regmap_write(led->regmap, LM3692X_BRT_MSB, brt_val);
+	if (ret) {
+		dev_err(&led->client->dev, "Cannot write MSB: %d\n", ret);
+		goto out;
+	}
+
+	ret = regmap_write(led->regmap, LM3692X_BRT_LSB, led_brightness_lsb);
+	if (ret) {
+		dev_err(&led->client->dev, "Cannot write LSB: %d\n", ret);
+		goto out;
+	}
+out:
+	mutex_unlock(&led->lock);
+	return ret;
+}
+
 static enum led_brightness lm3692x_max_brightness(struct lm3692x_led *led,
 						  u32 max_cur)
 {
@@ -462,7 +462,7 @@ static int lm3692x_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ret = lm3692x_init(led);
+	ret = lm3692x_leds_enable(led);
 	if (ret)
 		return ret;
 
-- 
2.23.0

