Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D846BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D79F218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BI0LV8Tt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfCUIVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:21:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45071 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfCUIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:21:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so3694158pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z/xVWk5dO82lfFtPDZKsgcg1B373xfEKm8H/gQlJdy0=;
        b=BI0LV8Tt8sSLmhJe3nAFyPo7lb8y/OS0Gr5C9Lq776TM8mqM3139hGFjSJo6IGbs7D
         P6YmUlG9rivqEbPZ6Ld/k7M38Ptt1WM8J1KiQBqyOJKmv6u4pvz4XV+wC8IS13DhdZ5U
         hgi30t3VQhBFAzs5QJ0r35KnTw639Y688lVjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/xVWk5dO82lfFtPDZKsgcg1B373xfEKm8H/gQlJdy0=;
        b=HDs513riYgOo9bz3tC44Qqifd6GYurdZjz+0h8ysbwKCPDryl4gdOn43HVIhHv1FTd
         l+eYr9vw0gh4v1u8//TUb/W70cxbTJ4bdJiRZctcgP4yTTvEhOqwOxK24Qdg6IW5p6y/
         tI9hCjaM48i/rzsa5Fvg26edjPd+wc/kI/a2i2lyG4FcQ2iV2DZ5fDnlo1ATJCneykqT
         tPG9ggKNiFLHuj3BqWBjMRHc3s9GjBkxPcQBFAMhnWB0yoRCnoAAs+DhXD6AgCw0uX4S
         XFCThle9RIiIgJB45KsFXwYt7KRQYM+ZUwAfN9QitwAU7ERBR7VfYyEpGH8js1gzgGxC
         tcvQ==
X-Gm-Message-State: APjAAAVXguISR9mHz2KNqZsZg3xwEBwbHQmXI+owWrThd8Ci+WViN04S
        AG6+yO1CQlBWtT8KiYVWct5GGg==
X-Google-Smtp-Source: APXvYqzWCnQK3/GdCmEVC61sBBIBJyff2uu2R7M0sbChSWzOx/5oKkQTwWB5oeyLnwr3dEymFKDjBw==
X-Received: by 2002:aa7:82d7:: with SMTP id f23mr2151127pfn.114.1553156484117;
        Thu, 21 Mar 2019 01:21:24 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.234])
        by smtp.gmail.com with ESMTPSA id b138sm6288681pfb.48.2019.03.21.01.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 01:21:23 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 2/4] Input: goodix - Add regulators suppot
Date:   Thu, 21 Mar 2019 13:51:02 +0530
Message-Id: <20190321082104.2874-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190321082104.2874-1-jagan@amarulasolutions.com>
References: <20190321082104.2874-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix CTP controllers require AVDD28, VDDIO regulators for power-on
sequence.

The delay between these regualtor operations as per Power-on Timing
from datasheet[1] is 0 (T1 >= 0 usec).

So, enable and disable these regulators in proper order using normal
regulator functions without any delay in between.

[1] GT5663 Datasheet_English_20151106_Rev.01

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/input/touchscreen/goodix.c | 58 ++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f57d82220a88..de5b80a08f41 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
@@ -47,6 +48,8 @@ struct goodix_ts_data {
 	struct touchscreen_properties prop;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
+	struct regulator *avdd28;
+	struct regulator *vddio;
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
 	u16 id;
@@ -532,6 +535,24 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
 		return -EINVAL;
 	dev = &ts->client->dev;
 
+	ts->avdd28 = devm_regulator_get(dev, "AVDD28");
+	if (IS_ERR(ts->avdd28)) {
+		error = PTR_ERR(ts->avdd28);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev,
+				"Failed to get AVDD28 regulator: %d\n", error);
+		return error;
+	}
+
+	ts->vddio = devm_regulator_get(dev, "VDDIO");
+	if (IS_ERR(ts->vddio)) {
+		error = PTR_ERR(ts->vddio);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev,
+				"Failed to get VDDIO regulator: %d\n", error);
+		return error;
+	}
+
 	/* Get the interrupt GPIO pin number */
 	gpiod = devm_gpiod_get_optional(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
 	if (IS_ERR(gpiod)) {
@@ -764,6 +785,17 @@ static void goodix_config_cb(const struct firmware *cfg, void *ctx)
 	complete_all(&ts->firmware_loading_complete);
 }
 
+static void goodix_disable_regulator(void *arg)
+{
+	struct goodix_ts_data *ts = arg;
+
+	if (!IS_ERR(ts->vddio))
+		regulator_disable(ts->vddio);
+
+	if (!IS_ERR(ts->avdd28))
+		regulator_disable(ts->avdd28);
+}
+
 static int goodix_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
@@ -789,6 +821,32 @@ static int goodix_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
+	error = devm_add_action_or_reset(&client->dev,
+					 goodix_disable_regulator, ts);
+	if (error)
+		return error;
+
+	/* power the controller */
+	if (!IS_ERR(ts->avdd28)) {
+		error = regulator_enable(ts->avdd28);
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to enable AVDD28 regulator: %d\n",
+				error);
+			return error;
+		}
+	}
+
+	if (!IS_ERR(ts->vddio)) {
+		error = regulator_enable(ts->vddio);
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to enable VDDIO regulator: %d\n",
+				error);
+			return error;
+		}
+	}
+
 	if (ts->gpiod_int && ts->gpiod_rst) {
 		/* reset the controller */
 		error = goodix_reset(ts);
-- 
2.18.0.321.gffc6fa0e3

