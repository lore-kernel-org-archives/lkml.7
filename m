Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3101C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FBC2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gAZudchd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfCNOGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:06:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39770 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfCNOGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:06:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id y9so4664642ljk.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wnGS70l4Lo5YiJ/U+Gaa6s8fW8pNlfL6zRiqocBz2Io=;
        b=gAZudchdjTSQC2qadk1jdUbBirhuP4OKvBdXIRZgSYA4fao3MRdWGrSIF621dRdTrv
         0JAeIvrH5Grh6E1/PSWk6uJPUSuaGE32BCzNYx1NFGKJhwyQnhaJDvTF11KQXGZsK4R0
         7vNDYA416rE/potyhRDJN70Sv7NEUSG+Vg2PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wnGS70l4Lo5YiJ/U+Gaa6s8fW8pNlfL6zRiqocBz2Io=;
        b=dI0zz5FbRYS5F8ved4LtIntGYkOWZyM7TUoSXalCeEvyEjZal+isrbmHVHq+tx1bNF
         sjcjYZZQCvJv/MQeONqZDiR0gcJKt8VYCAXHN9S9hc9sqp7uhKcAyR/lImRjy3N07xKQ
         GePaxX4T+hLcsg7A+IpntisU+tJLbPlvqRNeqsFHuwEnjwTNvC/B1ORy4kk4W99ebyJ0
         KtxFVbLW3pYN6zo/CdlXAgMP/948kevh/gwYHyWgt44XnP02csLkREcMRCg2W5qeWeWO
         Np8Xny2YvjRTy7wsVvBnXtrXYyzQWBubinZIyfgtq+6nskhfgK3zK/LlVdbHtv+LR5F5
         lalw==
X-Gm-Message-State: APjAAAU6xX8SQ2syGeOGvYAdeIUwB99R+vSPDgaZ99/Gzv2mSwTQ2Jnz
        wNXqqiwRiWz1R6Vc5oQJ1ubQWA==
X-Google-Smtp-Source: APXvYqwlKghV2oFtmCOWbIjEQclgy5p4w/3JKImFkwTzlG69USHm46/NXAb3TDzmmqzOV53y44VZiA==
X-Received: by 2002:a2e:3e11:: with SMTP id l17mr790390lja.172.1552572390595;
        Thu, 14 Mar 2019 07:06:30 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t14sm2733709lfe.51.2019.03.14.07.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:06:30 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 6/6] leds: netdev trigger: allow setting initial values in device tree
Date:   Thu, 14 Mar 2019 15:06:19 +0100
Message-Id: <20190314140619.3309-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190314140619.3309-1-linux@rasmusvillemoes.dk>
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be quite convenient to initialize a netdev-triggered LED with a
device name and setting the rx,tx,link properties from device tree,
instead of having to do that in an init script (or udev rule) in
userspace.

My main motivation for this is to be able to switch away from the
deprecated CONFIG_CAN_LEDS. The example added to common.txt
corresponds to switching linux,default-trigger = "can0-rxtx" to
"netdev" and adding the indicated netdev subnode.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 .../devicetree/bindings/leds/common.txt       | 11 +++++++
 drivers/leds/trigger/ledtrig-netdev.c         | 30 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index 7cb88460a47c..f8078c4cf6f8 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -43,6 +43,17 @@ Optional properties for child nodes:
                 Documentation/ABI/testing/sysfs-class-led-trigger-netdev)
                 to reflect the state and activity of a net device.
 
+                The optional child node netdev can be used to
+                configure initial values for the link, rx, tx and
+                device_name properties. For example,
+
+                netdev {
+                    rx;
+                    tx;
+                    link;
+                    device-name = "can0";
+                };
+
 - led-pattern : Array of integers with default pattern for certain triggers.
                 Each trigger may parse this property differently:
                 - one-shot : two numbers specifying delay on and delay off (in ms),
diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index e4a76ce4e4c7..387932cfea55 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/of.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include "../leds.h"
@@ -400,6 +401,33 @@ static void netdev_trig_work(struct work_struct *work)
 			(atomic_read(&trigger_data->interval)*2));
 }
 
+static void netdev_trig_of_init(struct led_classdev *led_cdev,
+				struct led_netdev_data *trigger_data)
+{
+	struct device_node *np = led_cdev->dev->of_node;
+	const char *device_name;
+
+	if (!np)
+		return;
+	np = of_get_child_by_name(np, "netdev");
+	if (!np)
+		return;
+
+	if (of_property_read_bool(np, "link"))
+		__set_bit(NETDEV_LED_LINK, &trigger_data->mode);
+	if (of_property_read_bool(np, "tx"))
+		__set_bit(NETDEV_LED_TX, &trigger_data->mode);
+	if (of_property_read_bool(np, "rx"))
+		__set_bit(NETDEV_LED_RX, &trigger_data->mode);
+	if (!of_property_read_string(np, "device-name", &device_name))
+		netdev_trig_set_device(trigger_data, device_name,
+				       strlen(device_name));
+
+	set_baseline_state(trigger_data);
+
+	of_node_put(np);
+}
+
 static int netdev_trig_activate(struct led_classdev *led_cdev)
 {
 	struct led_netdev_data *trigger_data;
@@ -423,6 +451,8 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
 	trigger_data->mode = 0;
 	atomic_set(&trigger_data->interval, msecs_to_jiffies(50));
 	trigger_data->last_activity = 0;
+	if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER)
+		netdev_trig_of_init(led_cdev, trigger_data);
 
 	led_set_trigger_data(led_cdev, trigger_data);
 
-- 
2.20.1

