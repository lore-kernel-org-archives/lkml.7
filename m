Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703A0C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 11:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB5E2073B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 11:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLYLQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:16:46 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:36566 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfLYLQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 06:16:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id A7A56FB04;
        Wed, 25 Dec 2019 12:16:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xnsbr-uoR8Bh; Wed, 25 Dec 2019 12:16:42 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id BFE7440BFC; Wed, 25 Dec 2019 12:16:39 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] leds: lm3692x: Disable chip on brightness 0
Date:   Wed, 25 Dec 2019 12:16:39 +0100
Message-Id: <e1dc56c07235063a9c0afbfc8c227b92b39ec3d4.1577272495.git.agx@sigxcpu.org>
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

Otherwise there's a noticeable glow even with brightness 0. Also
turning off the regulator can save additional power.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/leds/leds-lm3692x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index d1bd9ae4e7ab..183614744b92 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -117,6 +117,7 @@ struct lm3692x_led {
 	int model_id;
 
 	u8 boost_ctrl, brightness_ctrl;
+	bool enabled;
 };
 
 static const struct reg_default lm3692x_reg_defs[] = {
@@ -170,6 +171,9 @@ static int lm3692x_leds_enable(struct lm3692x_led *led)
 	int enable_state;
 	int ret, reg_ret;
 
+	if (led->enabled)
+		return 0;
+
 	if (led->regulator) {
 		ret = regulator_enable(led->regulator);
 		if (ret) {
@@ -271,6 +275,7 @@ static int lm3692x_leds_enable(struct lm3692x_led *led)
 	ret = regmap_update_bits(led->regmap, LM3692X_EN, LM3692X_ENABLE_MASK,
 				 enable_state | LM3692X_DEVICE_EN);
 
+	led->enabled = true;
 	return ret;
 out:
 	dev_err(&led->client->dev, "Fail writing initialization values\n");
@@ -292,6 +297,9 @@ static int lm3692x_leds_disable(struct lm3692x_led *led)
 {
 	int ret;
 
+	if (!led->enabled)
+		return 0;
+
 	ret = regmap_update_bits(led->regmap, LM3692X_EN, LM3692X_DEVICE_EN, 0);
 	if (ret) {
 		dev_err(&led->client->dev, "Failed to disable regulator: %d\n",
@@ -309,6 +317,7 @@ static int lm3692x_leds_disable(struct lm3692x_led *led)
 				"Failed to disable regulator: %d\n", ret);
 	}
 
+	led->enabled = false;
 	return ret;
 }
 
@@ -322,6 +331,13 @@ static int lm3692x_brightness_set(struct led_classdev *led_cdev,
 
 	mutex_lock(&led->lock);
 
+	if (brt_val == 0) {
+		ret = lm3692x_leds_disable(led);
+		goto out;
+	} else {
+		lm3692x_leds_enable(led);
+	}
+
 	ret = lm3692x_fault_check(led);
 	if (ret) {
 		dev_err(&led->client->dev, "Cannot read/clear faults: %d\n",
-- 
2.23.0

