Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B256C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEB120896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDNMin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 08:38:43 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:52411 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDNMim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 08:38:42 -0400
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A301C200008;
        Sun, 14 Apr 2019 12:38:36 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v3 2/2] power: supply: gpio-charger: Add support for charger status.
Date:   Sun, 14 Apr 2019 14:40:39 +0200
Message-Id: <20190414124039.10040-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190414124039.10040-1-contact@artur-rojek.eu>
References: <20190414124039.10040-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce optional support of POWER_SUPPLY_PROP_STATUS for chargers
which provide charging status GPIO.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---

Changes:

v2: no change

v3: rename "status_irq" and "status" fields to "charge_status_irq"
    and "charge_status" accordingly

 drivers/power/supply/gpio-charger.c | 57 +++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 7e4f11d5a230..f99e8f1eef23 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -29,11 +29,13 @@
 
 struct gpio_charger {
 	unsigned int irq;
+	unsigned int charge_status_irq;
 	bool wakeup_enabled;
 
 	struct power_supply *charger;
 	struct power_supply_desc charger_desc;
 	struct gpio_desc *gpiod;
+	struct gpio_desc *charge_status;
 };
 
 static irqreturn_t gpio_charger_irq(int irq, void *devid)
@@ -59,6 +61,12 @@ static int gpio_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = gpiod_get_value_cansleep(gpio_charger->gpiod);
 		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (gpiod_get_value_cansleep(gpio_charger->charge_status))
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -93,8 +101,29 @@ static enum power_supply_type gpio_charger_get_type(struct device *dev)
 	return POWER_SUPPLY_TYPE_UNKNOWN;
 }
 
+static int gpio_charger_get_irq(struct device *dev, void *dev_id,
+				struct gpio_desc *gpio)
+{
+	int ret, irq = gpiod_to_irq(gpio);
+
+	if (irq > 0) {
+		ret = devm_request_any_context_irq(dev, irq, gpio_charger_irq,
+						   IRQF_TRIGGER_RISING |
+						   IRQF_TRIGGER_FALLING,
+						   dev_name(dev),
+						   dev_id);
+		if (ret < 0) {
+			dev_warn(dev, "Failed to request irq: %d\n", ret);
+			irq = 0;
+		}
+	}
+
+	return irq;
+}
+
 static enum power_supply_property gpio_charger_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_STATUS /* Must always be last in the array. */
 };
 
 static int gpio_charger_probe(struct platform_device *pdev)
@@ -104,8 +133,10 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	struct power_supply_config psy_cfg = {};
 	struct gpio_charger *gpio_charger;
 	struct power_supply_desc *charger_desc;
+	struct gpio_desc *charge_status;
+	int charge_status_irq;
 	unsigned long flags;
-	int irq, ret;
+	int ret;
 
 	if (!pdata && !dev->of_node) {
 		dev_err(dev, "No platform data\n");
@@ -151,9 +182,17 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(gpio_charger->gpiod);
 	}
 
+	charge_status = devm_gpiod_get_optional(dev, "charge-status", GPIOD_IN);
+	gpio_charger->charge_status = charge_status;
+	if (IS_ERR(gpio_charger->charge_status))
+		return PTR_ERR(gpio_charger->charge_status);
+
 	charger_desc = &gpio_charger->charger_desc;
 	charger_desc->properties = gpio_charger_properties;
 	charger_desc->num_properties = ARRAY_SIZE(gpio_charger_properties);
+	/* Remove POWER_SUPPLY_PROP_STATUS from the supported properties. */
+	if (!gpio_charger->charge_status)
+		charger_desc->num_properties -= 1;
 	charger_desc->get_property = gpio_charger_get_property;
 
 	psy_cfg.of_node = dev->of_node;
@@ -180,16 +219,12 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	irq = gpiod_to_irq(gpio_charger->gpiod);
-	if (irq > 0) {
-		ret = devm_request_any_context_irq(dev, irq, gpio_charger_irq,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				dev_name(dev), gpio_charger->charger);
-		if (ret < 0)
-			dev_warn(dev, "Failed to request irq: %d\n", ret);
-		else
-			gpio_charger->irq = irq;
-	}
+	gpio_charger->irq = gpio_charger_get_irq(dev, gpio_charger->charger,
+						 gpio_charger->gpiod);
+
+	charge_status_irq = gpio_charger_get_irq(dev, gpio_charger->charger,
+						 gpio_charger->charge_status);
+	gpio_charger->charge_status_irq = charge_status_irq;
 
 	platform_set_drvdata(pdev, gpio_charger);
 
-- 
2.21.0

