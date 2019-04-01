Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11332133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfDAQJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:09:12 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:49569 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbfDAQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:08:38 -0400
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B847E10000A;
        Mon,  1 Apr 2019 16:08:36 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 08/12] rtc: pcf85063: add alarm support
Date:   Mon,  1 Apr 2019 18:08:12 +0200
Message-Id: <20190401160816.17859-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
References: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the alarms. The match on the weekday is not used as it it
not necessarily properly set.

The tested RTC shows a behaviour where setting an alarm on the second right
after an alarm that fired is not working, probably because of the circuit
that ensures an alarm only fires once. This is why uie_unsupported is set.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 121 +++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 7519da905128..536db43c84ee 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -11,6 +11,7 @@
 #include <linux/rtc.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 
 /*
@@ -27,11 +28,19 @@
 #define PCF85063_REG_CTRL1_CAP_SEL	BIT(0)
 #define PCF85063_REG_CTRL1_STOP		BIT(5)
 
+#define PCF85063_REG_CTRL2		0x01
+#define PCF85063_CTRL2_AF		BIT(6)
+#define PCF85063_CTRL2_AIE		BIT(7)
+
 #define PCF85063_REG_SC			0x04 /* datetime */
 #define PCF85063_REG_SC_OS		0x80
 
+#define PCF85063_REG_ALM_S		0x0b
+#define PCF85063_AEN			BIT(7)
+
 struct pcf85063_config {
 	struct regmap_config regmap;
+	unsigned has_alarms:1;
 };
 
 struct pcf85063 {
@@ -123,11 +132,103 @@ static int pcf85063_rtc_set_time(struct device *dev, struct rtc_time *tm)
 				  PCF85063_REG_CTRL1_STOP, 0);
 }
 
+static int pcf85063_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct pcf85063 *pcf85063 = dev_get_drvdata(dev);
+	u8 buf[4];
+	unsigned int val;
+	int ret;
+
+	ret = regmap_bulk_read(pcf85063->regmap, PCF85063_REG_ALM_S,
+			       buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	alrm->time.tm_sec = bcd2bin(buf[0]);
+	alrm->time.tm_min = bcd2bin(buf[1]);
+	alrm->time.tm_hour = bcd2bin(buf[2]);
+	alrm->time.tm_mday = bcd2bin(buf[3]);
+
+	ret = regmap_read(pcf85063->regmap, PCF85063_REG_CTRL2, &val);
+	if (ret)
+		return ret;
+
+	alrm->enabled =  !!(val & PCF85063_CTRL2_AIE);
+
+	return 0;
+}
+
+static int pcf85063_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct pcf85063 *pcf85063 = dev_get_drvdata(dev);
+	u8 buf[5];
+	int ret;
+
+	buf[0] = bin2bcd(alrm->time.tm_sec);
+	buf[1] = bin2bcd(alrm->time.tm_min);
+	buf[2] = bin2bcd(alrm->time.tm_hour);
+	buf[3] = bin2bcd(alrm->time.tm_mday);
+	buf[4] = PCF85063_AEN; /* Do not match on week day */
+
+	ret = regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
+				 PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_write(pcf85063->regmap, PCF85063_REG_ALM_S,
+				buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
+				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF,
+				  alrm->enabled ? PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF : PCF85063_CTRL2_AF);
+}
+
+static int pcf85063_rtc_alarm_irq_enable(struct device *dev,
+					 unsigned int enabled)
+{
+	struct pcf85063 *pcf85063 = dev_get_drvdata(dev);
+
+	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
+				  PCF85063_CTRL2_AIE,
+				  enabled ? PCF85063_CTRL2_AIE : 0);
+}
+
+static irqreturn_t pcf85063_rtc_handle_irq(int irq, void *dev_id)
+{
+	struct pcf85063 *pcf85063 = dev_id;
+	unsigned int val;
+	int err;
+
+	err = regmap_read(pcf85063->regmap, PCF85063_REG_CTRL2, &val);
+	if (err)
+		return IRQ_NONE;
+
+	if (val & PCF85063_CTRL2_AF) {
+		rtc_update_irq(pcf85063->rtc, 1, RTC_IRQF | RTC_AF);
+		regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
+				   PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF,
+				   0);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
 static const struct rtc_class_ops pcf85063_rtc_ops = {
 	.read_time	= pcf85063_rtc_read_time,
 	.set_time	= pcf85063_rtc_set_time
 };
 
+static const struct rtc_class_ops pcf85063_rtc_ops_alarm = {
+	.read_time	= pcf85063_rtc_read_time,
+	.set_time	= pcf85063_rtc_set_time,
+	.read_alarm	= pcf85063_rtc_read_alarm,
+	.set_alarm	= pcf85063_rtc_set_alarm,
+	.alarm_irq_enable = pcf85063_rtc_alarm_irq_enable,
+};
+
 static int pcf85063_load_capacitance(struct pcf85063 *pcf85063,
 				     const struct device_node *np)
 {
@@ -157,6 +258,7 @@ static const struct pcf85063_config pcf85063a_config = {
 		.val_bits = 8,
 		.max_register = 0x11,
 	},
+	.has_alarms = 1,
 };
 
 static const struct pcf85063_config pcf85063tp_config = {
@@ -209,6 +311,25 @@ static int pcf85063_probe(struct i2c_client *client)
 	pcf85063->rtc->ops = &pcf85063_rtc_ops;
 	pcf85063->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf85063->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	pcf85063->rtc->uie_unsupported = 1;
+
+	if (config->has_alarms && client->irq > 0) {
+		err = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, pcf85063_rtc_handle_irq,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						"pcf85063", pcf85063);
+		if (err) {
+			dev_warn(&pcf85063->rtc->dev,
+				 "unable to request IRQ, alarms disabled\n");
+		} else {
+			pcf85063->rtc->ops = &pcf85063_rtc_ops_alarm;
+			device_init_wakeup(&client->dev, true);
+			err = dev_pm_set_wake_irq(&client->dev, client->irq);
+			if (err)
+				dev_err(&pcf85063->rtc->dev,
+					"failed to enable irq wake\n");
+		}
+	}
 
 	return rtc_register_device(pcf85063->rtc);
 }
-- 
2.20.1

