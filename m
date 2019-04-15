Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496CBC10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 01:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FCC20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 01:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="r+jxGqJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfDOBwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 21:52:05 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.61]:26769 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbfDOBwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 21:52:04 -0400
X-Greylist: delayed 1494 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Apr 2019 21:52:03 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 76C1F51D0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 20:27:08 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id FqOqh0GfI4FKpFqOqhTtDr; Sun, 14 Apr 2019 20:27:08 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HbUN1dkFsSC6BI7XO52/1sf3MtLPus2m67WaPbKxaeM=; b=r+jxGqJ74k69+sNIaFym6CTH8
        r8SWqWm4a6ZchcL/ZFLH+xYQdxHTv7sguflHZz6firABom7LMFUetp5UvwCSq2jiVQh/1N3VcNsSx
        jiT1b7Q4pYNQXwM2D81sGfkKYU40h5E+Hp+Lh69sP3xOHMecRsd6Ah2VfBYYBT3LSCCAf5vVUMqLL
        8AmKUxA3hMSjOs83WToLbuhCmh5RnfUuFd0wOPd4l8ikdDB4cjNLLdVVth2Seip4FE3Ex8rFaR7Ig
        nfyKpXmhQ3G/5PzLyi2lrAhYLGobLMqtW48g/RICFRcpTbWvYe0VfPZpzYswwH4bDdVH/G2e8Ug+S
        DeyCbMhdQ==;
Received: from [191.191.240.251] (port=33232 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1hFqOp-000Uj7-OV; Sun, 14 Apr 2019 22:27:08 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v2 1/4] power: supply: max17040: Add IRQ handler for low SOC alert
Date:   Sun, 14 Apr 2019 22:26:32 -0300
Message-Id: <20190415012635.6369-2-matheus@castello.eng.br>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190415012635.6369-1-matheus@castello.eng.br>
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.191.240.251
X-Source-L: No
X-Exim-ID: 1hFqOp-000Uj7-OV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.191.240.251]:33232
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 22
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According datasheet max17040 has a pin for alert host for low SOC.
This pin can be used as external interrupt, so we need to check for
interrupts assigned for device and handle it.

In hadler we are checking and storing fuel gauge registers values
and send an uevent to notificate user space, so user space can decide
save work or turn off since the alert demonstrate that the battery may
no have the power to keep the system turned on for much longer.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 69 +++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 91cafc7bed30..8d2f8ed3f44c 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/power_supply.h>
 #include <linux/max17040_battery.h>
 #include <linux/slab.h>
@@ -160,21 +161,40 @@ static void max17040_get_status(struct i2c_client *client)
 		chip->status = POWER_SUPPLY_STATUS_FULL;
 }
 
+static void max17040_check_changes(struct i2c_client *client)
+{
+	max17040_get_vcell(client);
+	max17040_get_soc(client);
+	max17040_get_online(client);
+	max17040_get_status(client);
+}
+
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
 
 	chip = container_of(work, struct max17040_chip, work.work);
-
-	max17040_get_vcell(chip->client);
-	max17040_get_soc(chip->client);
-	max17040_get_online(chip->client);
-	max17040_get_status(chip->client);
+	max17040_check_changes(chip->client);
 
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
 }
 
+static irqreturn_t max17040_thread_handler(int id, void *dev)
+{
+	struct max17040_chip *chip = dev;
+	struct i2c_client *client = chip->client;
+
+	dev_warn(&client->dev, "IRQ: Alert battery low level");
+	/* read registers */
+	max17040_check_changes(chip->client);
+
+	/* send uevent */
+	power_supply_changed(chip->battery);
+
+	return IRQ_HANDLED;
+}
+
 static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -217,6 +237,27 @@ static int max17040_probe(struct i2c_client *client,
 		return PTR_ERR(chip->battery);
 	}
 
+	/* check interrupt */
+	if (client->irq) {
+		int ret;
+		unsigned int flags;
+
+		dev_info(&client->dev, "IRQ: enabled\n");
+		flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
+
+		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+						max17040_thread_handler, flags,
+						chip->battery->desc->name,
+						chip);
+
+		if (ret) {
+			client->irq = 0;
+			if (ret != -EBUSY)
+				dev_warn(&client->dev,
+					"Failed to get IRQ err %d\n", ret);
+		}
+	}
+
 	max17040_reset(client);
 	max17040_get_version(client);
 
@@ -224,6 +265,8 @@ static int max17040_probe(struct i2c_client *client,
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
 
+	device_init_wakeup(&client->dev, 1);
+
 	return 0;
 }
 
@@ -244,6 +287,14 @@ static int max17040_suspend(struct device *dev)
 	struct max17040_chip *chip = i2c_get_clientdata(client);
 
 	cancel_delayed_work(&chip->work);
+
+	if (client->irq) {
+		if (device_may_wakeup(dev))
+			enable_irq_wake(client->irq);
+		else
+			disable_irq_wake(client->irq);
+	}
+
 	return 0;
 }
 
@@ -254,6 +305,14 @@ static int max17040_resume(struct device *dev)
 
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
+
+	if (client->irq) {
+		if (device_may_wakeup(dev))
+			disable_irq_wake(client->irq);
+		else
+			enable_irq_wake(client->irq);
+	}
+
 	return 0;
 }
 
-- 
2.17.0

