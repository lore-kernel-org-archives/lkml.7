Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45598CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 19:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06368208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 19:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="YUvI81fL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfJaTDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 15:03:25 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.231]:37675 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729252AbfJaTDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 15:03:25 -0400
X-Greylist: delayed 1291 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Oct 2019 15:03:24 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 5E77FF7E5CF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 13:41:53 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id QFOLijv6kHunhQFOLiD51s; Thu, 31 Oct 2019 13:41:53 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V94B8xdnq24BoAQFYkXN5tfRIqIwmBgiwRAbgoWmaDo=; b=YUvI81fLMwBkZfBILvu52UW2t8
        6HR2nBtZfh5u0eefDjVAu6Vewg2pbkIyvK1wrR4IjbbPa4gYoGdIrDnFCFELQ6Nq9Haub6AC4IvTL
        EcYPOhrIUCHTYQ3npi7ZUCh3GPO9aaoUxBTdzVdZn4XhT5UU0zPYZ+Bx+9ulLiARBPNxsZNu3KS8B
        IN1xI5o7EFFZh5SQ/p5mp6APuM66yEAedHf0LMnKJlZdzF4ifTmGfXSBNZ/aPQD40jyA9t9tB9S9M
        BeydakdIQCd4cTU78Vfv4ZN9adSv3I8F8sixRM4if1jVhgjTzPmcYAN0mb3YYDTY7tgrs9Vjjn0bw
        s4b7hxCw==;
Received: from [191.31.195.127] (port=35710 helo=castello.bz.toradex.local)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iQFOK-0035gz-4p; Thu, 31 Oct 2019 15:41:52 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v4 3/4] power: supply: max17040: Config alert SOC low level threshold from FDT
Date:   Thu, 31 Oct 2019 15:41:33 -0300
Message-Id: <20191031184134.30621-4-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191031184134.30621-1-matheus@castello.eng.br>
References: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
 <20191031184134.30621-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.195.127
X-Source-L: No
X-Exim-ID: 1iQFOK-0035gz-4p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.bz.toradex.local) [191.31.195.127]:35710
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 34
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For configuration of fuel gauge alert for a low level state of charge
interrupt we add a function to config level threshold and a device tree
binding property to set it in flatned device tree node.

Now we can use "maxim,alert-low-soc-level" property with the values from
1% up to 32% to configure alert interrupt threshold.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 88 +++++++++++++++++++++----
 1 file changed, 74 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 75459f76d02c..802575342c72 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -29,6 +29,9 @@
 #define MAX17040_DELAY		1000
 #define MAX17040_BATTERY_FULL	95

+#define MAX17040_ATHD_MASK		0xFFC0
+#define MAX17040_ATHD_DEFAULT_POWER_UP	4
+
 struct max17040_chip {
 	struct i2c_client		*client;
 	struct delayed_work		work;
@@ -43,6 +46,8 @@ struct max17040_chip {
 	int soc;
 	/* State Of Charge */
 	int status;
+	/* Low alert threshold from 32% to 1% of the State of Charge */
+	u32 low_soc_alert_threshold;
 };

 static int max17040_get_property(struct power_supply *psy,
@@ -99,6 +104,22 @@ static void max17040_reset(struct i2c_client *client)
 	max17040_write_reg(client, MAX17040_CMD, 0x0054);
 }

+static int max17040_set_low_soc_threshold_alert(struct i2c_client *client,
+	u32 level)
+{
+	int ret;
+	u16 data;
+
+	level = 32 - level;
+	data = max17040_read_reg(client, MAX17040_RCOMP);
+	/* clear the alrt bit and set LSb 5 bits */
+	data &= MAX17040_ATHD_MASK;
+	data |= level;
+	ret = max17040_write_reg(client, MAX17040_RCOMP, data);
+
+	return ret;
+}
+
 static void max17040_get_vcell(struct i2c_client *client)
 {
 	struct max17040_chip *chip = i2c_get_clientdata(client);
@@ -115,7 +136,6 @@ static void max17040_get_soc(struct i2c_client *client)
 	u16 soc;

 	soc = max17040_read_reg(client, MAX17040_SOC);
-
 	chip->soc = (soc >> 8);
 }

@@ -161,6 +181,24 @@ static void max17040_get_status(struct i2c_client *client)
 		chip->status = POWER_SUPPLY_STATUS_FULL;
 }

+static int max17040_get_of_data(struct max17040_chip *chip)
+{
+	struct device *dev = &chip->client->dev;
+	struct device_node *np = dev->of_node;
+	int ret = 0;
+
+	if (of_property_read_u32(np, "maxim,alert-low-soc-level",
+			&chip->low_soc_alert_threshold)) {
+		chip->low_soc_alert_threshold = MAX17040_ATHD_DEFAULT_POWER_UP;
+	/* check if low_soc_alert_threshold is between 1% and 32% */
+	} else if (chip->low_soc_alert_threshold <= 0 ||
+			chip->low_soc_alert_threshold >= 33){
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static void max17040_check_changes(struct i2c_client *client)
 {
 	max17040_get_vcell(client);
@@ -192,6 +230,10 @@ static irqreturn_t max17040_thread_handler(int id, void *dev)
 	/* send uevent */
 	power_supply_changed(chip->battery);

+	/* reset alert bit */
+	max17040_set_low_soc_threshold_alert(client,
+		chip->low_soc_alert_threshold);
+
 	return IRQ_HANDLED;
 }

@@ -216,6 +258,7 @@ static int max17040_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = client->adapter;
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
+	int ret;

 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
 		return -EIO;
@@ -226,6 +269,12 @@ static int max17040_probe(struct i2c_client *client,

 	chip->client = client;
 	chip->pdata = client->dev.platform_data;
+	ret = max17040_get_of_data(chip);
+	if (ret) {
+		dev_err(&client->dev,
+			"failed: low SOC alert OF data out of bounds\n");
+		return ret;
+	}

 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
@@ -242,20 +291,31 @@ static int max17040_probe(struct i2c_client *client,

 	/* check interrupt */
 	if (client->irq) {
-		int ret;
-		unsigned int flags;
-
-		dev_info(&client->dev, "IRQ: enabled\n");
-		flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
-		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-						max17040_thread_handler, flags,
-						chip->battery->desc->name,
-						chip);
-
-		if (ret) {
-			client->irq = 0;
+		if (of_device_is_compatible(client->dev.of_node,
+			"maxim,max77836-battery")) {
+			ret = max17040_set_low_soc_threshold_alert(client,
+				chip->low_soc_alert_threshold);
+			if (ret) {
+				dev_err(&client->dev,
+					"Failed to set low SOC alert: err %d\n",
+					ret);
+				return ret;
+			}
+
+			dev_info(&client->dev, "IRQ: enabled\n");
+			ret = devm_request_threaded_irq(&client->dev,
+				client->irq, NULL, max17040_thread_handler,
+				(client->flags | IRQF_ONESHOT),
+				chip->battery->desc->name, chip);
+
+			if (ret) {
+				client->irq = 0;
+				dev_warn(&client->dev,
+					"Failed to get IRQ err %d\n", ret);
+			}
+		} else {
 			dev_warn(&client->dev,
-				"Failed to get IRQ err %d\n", ret);
+				"Device not compatible for IRQ");
 		}
 	}

--
2.24.0.rc2

