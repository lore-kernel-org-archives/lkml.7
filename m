Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886C9C3276F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 10:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694322464E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 10:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgADKyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 05:54:40 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:40198 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgADKyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 05:54:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 94FB9FB04;
        Sat,  4 Jan 2020 11:54:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6Cyi_4sgB2CE; Sat,  4 Jan 2020 11:54:31 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 3546949AAB; Sat,  4 Jan 2020 11:54:26 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] leds: lm3692x: Allow to configure brigthness mode
Date:   Sat,  4 Jan 2020 11:54:20 +0100
Message-Id: <f70e4ba49de8379c50cd3770e6d8d36d783282df.1578134779.git.agx@sigxcpu.org>
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

Brightness mode is currently hardcoded as linear in the driver. Make
exponential mode configurable via DT.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/leds/leds-lm3692x.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index 28973cc5a6cc..ff20560a8263 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -115,7 +115,7 @@ struct lm3692x_led {
 	int led_enable;
 	int model_id;
 
-	u8 boost_ctrl;
+	u8 boost_ctrl, brightness_ctrl;
 };
 
 static const struct reg_default lm3692x_reg_defs[] = {
@@ -267,8 +267,7 @@ static int lm3692x_init(struct lm3692x_led *led)
 	if (ret)
 		goto out;
 
-	ret = regmap_write(led->regmap, LM3692X_BRT_CTRL,
-			LM3692X_BL_ADJ_POL | LM3692X_RAMP_EN);
+	ret = regmap_write(led->regmap, LM3692X_BRT_CTRL, led->brightness_ctrl);
 	if (ret)
 		goto out;
 
@@ -326,6 +325,7 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
 	struct fwnode_handle *child = NULL;
 	struct led_init_data init_data = {};
 	u32 ovp;
+	bool exp_mode;
 	int ret;
 
 	led->enable_gpio = devm_gpiod_get_optional(&led->client->dev,
@@ -376,6 +376,12 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
 		}
 	}
 
+	led->brightness_ctrl = LM3692X_BL_ADJ_POL | LM3692X_RAMP_EN;
+	exp_mode = device_property_read_bool(&led->client->dev,
+				     "ti,brightness-mapping-exponential");
+	if (exp_mode)
+		led->brightness_ctrl |= LM3692X_MAP_MODE_EXP;
+
 	child = device_get_next_child_node(&led->client->dev, child);
 	if (!child) {
 		dev_err(&led->client->dev, "No LED Child node\n");
-- 
2.23.0

