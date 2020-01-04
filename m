Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D3DC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 10:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D992C2464E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 10:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgADKyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 05:54:55 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:40228 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgADKyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 05:54:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 69018FB02;
        Sat,  4 Jan 2020 11:54:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5zpYTwW8azHf; Sat,  4 Jan 2020 11:54:38 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 49C7149AAD; Sat,  4 Jan 2020 11:54:26 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] leds: lm3692x: Make sure we don't exceed the maximum led current
Date:   Sat,  4 Jan 2020 11:54:22 +0100
Message-Id: <5826b77d42521595e93d01d53475a8881cad1875.1578134779.git.agx@sigxcpu.org>
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

The current is given by the formular from page 12 of
https://www.ti.com/lit/ds/symlink/lm36922.pdf. We use this to limit the
led's max_brightness using the led-max-microamp DT property.

The formula for the lm36923 is identical according to the data sheet.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/leds/leds-lm3692x.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index ff20560a8263..2e24316566f5 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -6,6 +6,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/leds.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -320,11 +321,29 @@ static int lm3692x_init(struct lm3692x_led *led)
 	return ret;
 }
 
+static enum led_brightness lm3692x_max_brightness(struct lm3692x_led *led,
+						  u32 max_cur)
+{
+	u32 max_code;
+
+	/* see p.12 of LM36922 data sheet for brightness formula */
+	if (led->brightness_ctrl & LM3692X_MAP_MODE_EXP) {
+		/*  228 =~ 1.0 / log2(1.003040572) */
+		max_code = ilog2(max_cur/50) * 228;
+	} else {
+		max_code = ((max_cur * 1000) - 37806) / 12195;
+	}
+	if (max_code > 0x7FF)
+		max_code = 0x7FF;
+
+	return max_code >> 3;
+}
+
 static int lm3692x_probe_dt(struct lm3692x_led *led)
 {
 	struct fwnode_handle *child = NULL;
 	struct led_init_data init_data = {};
-	u32 ovp;
+	u32 ovp, max_cur;
 	bool exp_mode;
 	int ret;
 
@@ -397,6 +416,10 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
 		return ret;
 	}
 
+	ret = fwnode_property_read_u32(child, "led-max-microamp", &max_cur);
+	led->led_dev.max_brightness = ret ? LED_FULL :
+		lm3692x_max_brightness(led, max_cur);
+
 	init_data.fwnode = child;
 	init_data.devicename = led->client->name;
 	init_data.default_label = ":";
-- 
2.23.0

