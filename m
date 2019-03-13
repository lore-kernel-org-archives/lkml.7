Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF66C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C568A2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KaX15mB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfCMU0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:26:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39440 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfCMU0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:26:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so2700028edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=391achGSbEwlOcz+XVWozH1Rc+0QP7rUHnU2cfCzNwc=;
        b=KaX15mB5igIUUWZAPZiEgalxtbUj0wwluQRyzctZsOEbWsvMLuMNrKMDqHmSUkCcIC
         EjxYEa9/hMcYWsYOZ0vT8RdDrtNYks7wU7AZikdqVfMf0hrd8+OAJWZiQVgg95D5zrif
         FFrpNfNy1dOSIcOpm6ykf+iTdYa1wSYSDDNDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=391achGSbEwlOcz+XVWozH1Rc+0QP7rUHnU2cfCzNwc=;
        b=Mi28q3QGt9ZmcrqZXupjnojcYng60Xs583wF3NYo8oyAmVLF1IqN9JZMTdBS3aAr9E
         AWd7mTHh0bm8LOMubrbHWcoLmFjSskQzuT/115S0gNhDsSty+exJAGFlt/HFqKEMytqx
         D/TeHzYj5XckfwTnZkEImQJBuX/Av91TmLvXgf9ZW1kKcOMqRfXN6xCY2iz2H1Pno0Uj
         oU7PDrEg0cwMPgjGN745GrD5Ff7qHf1yp/5fPaPzoEKFwbJ7Cx2hFYEwR02GanSq8mK2
         AHSujPTSQ2NO/hiHbDgvfU0+637qjgZ1HQwIVoz9gXofXjLu9y/6dXsXDTiVxU0B9/Lf
         YnSA==
X-Gm-Message-State: APjAAAVaynwGwk79DB9q76AYMe17dQaT4LDcCxtl2tvVwPu3roty1xDY
        HkSpQLW2/6xJfIOAJ+KqGhJP+g==
X-Google-Smtp-Source: APXvYqxo34nX/yvPeKfKsjxlXoLQsPsg6Z49sS7OtuM8hFIOIE2Jx6+qAVJ254lkSYlnNBjPP4xrGw==
X-Received: by 2002:a50:b613:: with SMTP id b19mr8854964ede.214.1552508783213;
        Wed, 13 Mar 2019 13:26:23 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-119-202.cgn.fibianet.dk. [5.186.119.202])
        by smtp.gmail.com with ESMTPSA id m32sm940170edc.17.2019.03.13.13.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:26:22 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 4/4] leds: netdev trigger: allow setting initial values in device tree
Date:   Wed, 13 Mar 2019 21:26:15 +0100
Message-Id: <20190313202615.22883-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be quite convenient to initialize a netdev-triggered LED with a
device name and setting the rx,tx,link properties from device tree,
instead of having to do that in an init script in userspace.

My main motivation for this is to be able to switch away from the
deprecated CONFIG_CAN_LEDS, so add an example based on that and add a
pointer in the net/can/Kconfig file.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 .../devicetree/bindings/leds/common.txt       | 17 ++++++++++
 drivers/leds/trigger/ledtrig-netdev.c         | 31 +++++++++++++++++++
 drivers/net/can/Kconfig                       |  3 +-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index 7cb88460a47c..4f3a97e73417 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -43,6 +43,23 @@ Optional properties for child nodes:
                 Documentation/ABI/testing/sysfs-class-led-trigger-netdev)
                 to reflect the state and activity of a net device.
 
+                The optional child node netdev can be used to
+                configure initial values for the link, rx, tx and
+                device_name properties. For example, setting
+                linux,default-trigger = "netdev" and adding the child
+                node
+
+                netdev {
+                    rx;
+                    tx;
+                    link;
+                    device-name = "can0";
+                };
+
+                can be used to replace 'linux,default-trigger =
+                "can0-rxtx"' that relies on the deprecated
+                CONFIG_CAN_LEDS.
+
 - led-pattern : Array of integers with default pattern for certain triggers.
                 Each trigger may parse this property differently:
                 - one-shot : two numbers specifying delay on and delay off (in ms),
diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 55153a7e8433..1f7c86df1e91 100644
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
@@ -395,6 +396,35 @@ static void netdev_trig_work(struct work_struct *work)
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
+	if (!of_property_read_string(np, "device-name", &device_name)) {
+		unsigned len = strlen(device_name);
+
+		if (len < IFNAMSIZ)
+			set_device(trigger_data, device_name, len);
+	}
+	set_baseline_state(trigger_data);
+
+	of_node_put(np);
+}
+
 static int netdev_trig_activate(struct led_classdev *led_cdev)
 {
 	struct led_netdev_data *trigger_data;
@@ -418,6 +448,7 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
 	trigger_data->mode = 0;
 	atomic_set(&trigger_data->interval, msecs_to_jiffies(50));
 	trigger_data->last_activity = 0;
+	netdev_trig_of_init(led_cdev, trigger_data);
 
 	led_set_trigger_data(led_cdev, trigger_data);
 
diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e0f0ad7a550a..91703a96b636 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -77,7 +77,8 @@ config CAN_LEDS
 	# everything that this driver is doing. This is marked as broken
 	# because it uses stuff that is intended to be changed or removed.
 	# Please consider switching to the netdev trigger and confirm it
-	# fulfills your needs instead of fixing this driver.
+	# fulfills your needs instead of fixing this driver. See e.g.
+	# Documentation/devicetree/bindings/leds/common.txt
 	depends on BROKEN
 	select LEDS_TRIGGERS
 	---help---
-- 
2.20.1

