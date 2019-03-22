Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED35CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FA121873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfCVIZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:25:17 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCVIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:25:10 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.35.112]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MmyzH-1ggTMc1sSF-00k9Ob; Fri, 22 Mar 2019 09:24:25 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V3 3/3] hwmon: pwm-fan: Add RPM support via external interrupt
Date:   Fri, 22 Mar 2019 09:24:03 +0100
Message-Id: <1553243043-19486-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553243043-19486-1-git-send-email-stefan.wahren@i2se.com>
References: <1553243043-19486-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:BKJN9Q9q6HffqWUvmt7OCSlaDv3ROlw5ShmcUOhFJduN5DQWANn
 lsG+fl26E3s3wOpv4O1gIyY3a65kxNtz0iEqACc5w4uYzFW9a4r6c7ooJCEQmh8bHudTabx
 TMfairwcAsjo3K5lBPHgY+ill+godecZOWtbDabeL19V8gY18tvXlOLfmvB3rytWzUnq22Z
 5kbJ1nD+9a9q3LFUDqX6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vxz82F/+m+0=:9v0eqPthQ4fRMgFfTHo4qo
 RrQrfjPITyV2BGtZtgxtrbnCOfmZ0WKjhP68S4qt+HVIoi9E5YZKBzHBHBY2TZ7IHsufPf7u4
 IUlIYRF23M2BWq63F1yuc/5O4COXylkKn/+3bvwKVqpdto5NW6Cy5cN8xyFT2O7ufIDRZOonp
 lzzK313KGvkuo8ASIViCQVgrKg3qU3341S6cTImT2YPu9RkYgnubyxncAmXTKhoiesGXZuBP4
 MYiG70zBeUnnonu3at0+IUwonpP5vPR32Hh2wOcoE0ewsp/OnuPN9c6tWZlt7jT/7qgYI+DaC
 h4OvdgITQERXN2lKthiC1wipmDIpB8mDQlaUOmWv7oPihCXYbjWKrZrV4nr+tapJuV6pPGYKU
 iM3eoKKuyf6a5CYa48vNhcjV4ZrzkW7o2LyGvlc68OZRV3lnhBQaGN+mV6FkU4jmO3bA/rhA3
 Lvmqg2S3b1TePDdf/hzAC+UhfQdrrXq1yvU0mOyS5bCiE58pJKkdMBdN7jtBI3hnT1CVpcCOj
 Ayi3pA12CCbPZHV42xSChDGO9UtlZyg2YMPGhy0mEaZTn/IHDIms5GjnHukjl7mmeHwhod/4C
 DNVw6BSvMiUSrda9MgOgR/OHiOreU0hhZwz/Pz0EhUoks4HkMLOLnx3fZ6x26/p/FzCpfqmaJ
 Trx7taELAxgPe9QwCIdNFaL/Vkwq/Sm3DWzgtqDZUmWJtnIQ92V8D7dbBfxbrnk5yt9KCpJb+
 GEz9/3HhhqC0qnfuJQLt/X3Iq/lPbOq/B1/F+o6S3IpgkaqyA/LWecrrnS+OvnHFR8/9jci7L
 /xj78Fu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds RPM support to the pwm-fan driver in order to use with
fancontrol/pwmconfig. This feature is intended for fans with a tachometer
output signal, which generate a defined number of pulses per revolution.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/hwmon/pwm-fan.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 167221c..c8fb6a3 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -18,6 +18,7 @@
 
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -26,6 +27,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
 #include <linux/thermal.h>
+#include <linux/timer.h>
 
 #define MAX_PWM 255
 
@@ -33,6 +35,14 @@ struct pwm_fan_ctx {
 	struct mutex lock;
 	struct pwm_device *pwm;
 	struct regulator *reg_en;
+
+	int irq;
+	atomic_t pulses;
+	unsigned int rpm;
+	u32 pulses_per_revolution;
+	ktime_t sample_start;
+	struct timer_list rpm_timer;
+
 	unsigned int pwm_value;
 	unsigned int pwm_fan_state;
 	unsigned int pwm_fan_max_state;
@@ -40,6 +50,32 @@ struct pwm_fan_ctx {
 	struct thermal_cooling_device *cdev;
 };
 
+/* This handler assumes self resetting edge triggered interrupt. */
+static irqreturn_t pulse_handler(int irq, void *dev_id)
+{
+	struct pwm_fan_ctx *ctx = dev_id;
+
+	/* Avoid possible overflow */
+	if (atomic_read(&ctx->pulses) < 100000)
+		atomic_inc(&ctx->pulses);
+
+	return IRQ_HANDLED;
+}
+
+static void sample_timer(struct timer_list *t)
+{
+	struct pwm_fan_ctx *ctx = from_timer(ctx, t, rpm_timer);
+	int pulses, sample_ms;
+
+	pulses = atomic_read(&ctx->pulses);
+	atomic_sub(pulses, &ctx->pulses);
+	sample_ms = ktime_ms_delta(ktime_get(), ctx->sample_start);
+	ctx->rpm = pulses * 60 * sample_ms / 1000 / ctx->pulses_per_revolution;
+
+	ctx->sample_start = ktime_get();
+	mod_timer(&ctx->rpm_timer, jiffies + HZ);
+}
+
 static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 {
 	unsigned long period;
@@ -100,15 +136,49 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", ctx->pwm_value);
 }
 
+static ssize_t rpm_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", ctx->rpm);
+}
 
 static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, rpm, 0);
 
 static struct attribute *pwm_fan_attrs[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	NULL,
 };
 
-ATTRIBUTE_GROUPS(pwm_fan);
+static umode_t pwm_fan_attrs_visible(struct kobject *kobj, struct attribute *a,
+				     int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+	struct device_attribute *devattr;
+
+	/* Hide fan_input in case no interrupt is available  */
+	devattr = container_of(a, struct device_attribute, attr);
+	if (devattr == &sensor_dev_attr_fan1_input.dev_attr) {
+		if (ctx->irq < 0)
+			return 0;
+	}
+
+	return a->mode;
+}
+
+static const struct attribute_group pwm_fan_group = {
+	.attrs = pwm_fan_attrs,
+	.is_visible = pwm_fan_attrs_visible,
+};
+
+static const struct attribute_group *pwm_fan_groups[] = {
+	&pwm_fan_group,
+	NULL,
+};
 
 /* thermal cooling device callbacks */
 static int pwm_fan_get_max_state(struct thermal_cooling_device *cdev,
@@ -261,6 +331,32 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		goto err_reg_disable;
 	}
 
+	timer_setup(&ctx->rpm_timer, sample_timer, 0);
+
+	if (of_property_read_u32(pdev->dev.of_node, "pulses-per-revolution",
+				 &ctx->pulses_per_revolution)) {
+		ctx->pulses_per_revolution = 2;
+	}
+
+	if (!ctx->pulses_per_revolution) {
+		dev_err(&pdev->dev, "pulses-per-revolution can't be zero.\n");
+		ret = -EINVAL;
+		goto err_pwm_disable;
+	}
+
+	atomic_set(&ctx->pulses, 0);
+	ctx->irq = platform_get_irq(pdev, 0);
+	if (ctx->irq >= 0) {
+		ret = devm_request_irq(&pdev->dev, ctx->irq, pulse_handler, 0,
+				       pdev->name, ctx);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't get interrupt working.\n");
+			goto err_pwm_disable;
+		}
+		ctx->sample_start = ktime_get();
+		mod_timer(&ctx->rpm_timer, jiffies + HZ);
+	}
+
 	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
 						       ctx, pwm_fan_groups);
 	if (IS_ERR(hwmon)) {
@@ -306,6 +402,8 @@ static int pwm_fan_remove(struct platform_device *pdev)
 	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
 
 	thermal_cooling_device_unregister(ctx->cdev);
+	del_timer_sync(&ctx->rpm_timer);
+
 	if (ctx->pwm_value)
 		pwm_disable(ctx->pwm);
 
-- 
2.7.4

