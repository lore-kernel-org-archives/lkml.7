Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451EEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 01:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A71B20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 01:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="ZPIF36Rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDOBsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 21:48:18 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.231]:20267 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbfDOBsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 21:48:18 -0400
X-Greylist: delayed 1257 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Apr 2019 21:48:17 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id E29F911F71F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 20:27:19 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id FqP1hav5idnCeFqP1hO6Qj; Sun, 14 Apr 2019 20:27:19 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R1H/zb0qpfuLZ6IzHqM2mtOCJc/6Ct/oVxfuSRZenXs=; b=ZPIF36RhX8vVvv1zPrlaLQIT1
        MCQxb2Mc49otqH+84aJe3M8m0M0GzdybYyuvINnt18tiLAbM3rVXVvtl8rKJrhJaAfy7oN06HKyey
        4jwDJDEc2CibPOtR7Hy1036cBkkCKs3PrwoHQ5EQqKdvoG61WwOSp1xLoj2jccfHOO0TSao0eimPR
        PQB9VVQpNQ3KCio9fmB8NSWnRd6yn+/l4823VWvKR3HkUHo6b5LCaIebaGSELUUzHVHZjIZlncDo5
        ENZd1QFxPg9Xm2nQfLBLlE3ICTkdGklVL+yxGQ7+sEJ7S4USVoF4d1Kdb2VtO+hQ7yrf0Vp0C1AhL
        FFPTCIwVg==;
Received: from [191.191.240.251] (port=33232 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1hFqP1-000Uj7-1F; Sun, 14 Apr 2019 22:27:19 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v2 3/4] power: supply: max17040: Config alert SOC low level threshold from FDT
Date:   Sun, 14 Apr 2019 22:26:34 -0300
Message-Id: <20190415012635.6369-4-matheus@castello.eng.br>
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
X-Exim-ID: 1hFqP1-000Uj7-1F
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.191.240.251]:33232
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 44
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For configuration of fuel gauge alert for a low level state of charge
interrupt we add a function to config level threshold and a device tree
binding property to set it in flatned device tree node.

Now we can use "maxim,alert-soc-level" property with the values from
1 up to 32 to configure alert interrupt threshold.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 56 ++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 8d2f8ed3f44c..f036f272d52f 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -29,6 +29,9 @@
 #define MAX17040_DELAY		1000
 #define MAX17040_BATTERY_FULL	95
 
+#define MAX17040_ATHD_MASK		0xFFE0
+#define MAX17040_ATHD_DEFAULT_POWER_UP	4
+
 struct max17040_chip {
 	struct i2c_client		*client;
 	struct delayed_work		work;
@@ -43,6 +46,8 @@ struct max17040_chip {
 	int soc;
 	/* State Of Charge */
 	int status;
+	/* Alert threshold from 32% to 1% of the State of Charge */
+	u32 alert_threshold;
 };
 
 static int max17040_get_property(struct power_supply *psy,
@@ -119,6 +124,27 @@ static void max17040_get_soc(struct i2c_client *client)
 	chip->soc = (soc >> 8);
 }
 
+static int max17040_set_soc_threshold(struct i2c_client *client, u32 level)
+{
+	int ret;
+	u16 data;
+
+	/* check if level is between 1% and 32% */
+	if (level > 0 && level < 33) {
+		/* alert threshold use LSb 5 bits from RCOMP */
+		level = 32 - level;
+		data = max17040_read_reg(client, MAX17040_RCOMP);
+		data &= MAX17040_ATHD_MASK;
+		data |= level;
+		max17040_write_reg(client, MAX17040_RCOMP, data);
+		ret = 0;
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static void max17040_get_version(struct i2c_client *client)
 {
 	u16 version;
@@ -161,6 +187,16 @@ static void max17040_get_status(struct i2c_client *client)
 		chip->status = POWER_SUPPLY_STATUS_FULL;
 }
 
+static void max17040_get_of_data(struct max17040_chip *chip)
+{
+	struct device *dev = &chip->client->dev;
+	struct device_node *np = dev->of_node;
+
+	if (of_property_read_u32(np, "maxim,alert-soc-level",
+			&chip->alert_threshold))
+		chip->alert_threshold = MAX17040_ATHD_DEFAULT_POWER_UP;
+}
+
 static void max17040_check_changes(struct i2c_client *client)
 {
 	max17040_get_vcell(client);
@@ -226,6 +262,7 @@ static int max17040_probe(struct i2c_client *client,
 
 	chip->client = client;
 	chip->pdata = client->dev.platform_data;
+	max17040_get_of_data(chip);
 
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
@@ -237,16 +274,26 @@ static int max17040_probe(struct i2c_client *client,
 		return PTR_ERR(chip->battery);
 	}
 
+	max17040_reset(client);
+	max17040_get_version(client);
+
 	/* check interrupt */
 	if (client->irq) {
 		int ret;
-		unsigned int flags;
+
+		ret = max17040_set_soc_threshold(client, chip->alert_threshold);
+		if (ret) {
+			dev_err(&client->dev,
+				"Failed to set SOC alert threshold: err %d\n",
+				ret);
+			return ret;
+		}
 
 		dev_info(&client->dev, "IRQ: enabled\n");
-		flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
 
 		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-						max17040_thread_handler, flags,
+						max17040_thread_handler,
+						(client->flags | IRQF_ONESHOT),
 						chip->battery->desc->name,
 						chip);
 
@@ -258,9 +305,6 @@ static int max17040_probe(struct i2c_client *client,
 		}
 	}
 
-	max17040_reset(client);
-	max17040_get_version(client);
-
 	INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
-- 
2.17.0

