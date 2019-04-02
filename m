Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D706C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37B82084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbfDBOWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:22:51 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49047 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbfDBOWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:22:49 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.50.84]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N1xZX-1gmtju0Z1V-012Dys; Tue, 02 Apr 2019 16:22:11 +0200
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
Subject: [PATCH V4 3/3] hwmon: pwm-fan: Add RPM support via external interrupt
Date:   Tue,  2 Apr 2019 16:21:50 +0200
Message-Id: <1554214910-29925-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554214910-29925-1-git-send-email-stefan.wahren@i2se.com>
References: <1554214910-29925-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:VVbw+itIWBHwSALd3cnJxz+j1kMPQ1KtlkiVX2ngLCHVNzm5q5j
 8pgMtrE8qh9Hcw6Jum9IRCVpxbI/8z7A1949GY1g4DEn4epFlOBz4zisMd6A+P3SQZK77Db
 l6PxO+YVbK3zaCiSqs2E9Jd0lmLjQKMjVX2LEUJUeKz97oPDJvNi0oUML/IG9dMRChbjlk1
 WtVjf6DxXMETZuuQVNTkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oCUxK+9fLXI=:UNk6Sm8jCMNhgsTrIwGnmL
 F7LxPpAwUOODoZWWjcPPJI7kkfONgWevsj1RI6s0v+Zj2UccjVbX+L2R3/9Xwo0hREXnHqr1w
 Y0Aqpx9TxxmwgkkH/fy3yX/3IQU2ZuyGD4z6Z6GQde3ZK8MhTp4Yt2r1MewYQSEJcP5SwRBYi
 ykFv6v9wjdKk6pw/nN8hUEFsxTAPESeDYnCXrcqPRoEo/vpLqhko3d64BnoMEDakCVQ9ReZXi
 9iJ4K6cvKWHx10B4+Er6nNkdKQb7Q/t0RFLCW/1sjUmrDacMHyh7XqXMMwU00o7tx4HbZnkQm
 ok+LPxuc0hxFYsb/SvSxuqMxS+5DbCUSs9ghS95SHyHscsiirXs2dpasCjWk2HNHFENAHDDM2
 Q0aJL60cf55W/hGhbUV0ffiXplFiQNUac1kep1h338c7ENAxNs9C0tzDP/kS65tJxOGVTFa2c
 0yAKOTrUCh8Fj1bxpqlnLZQhWm82yd6WzCVcm4nmKGwqlOIo9fi1Mv46ZliyUbV4T78wPPN+7
 RBV11YVZKzt4DL05PsoZ+IpnD8AtJN7sQt/VKX/MHf4lw+rwbnnsM1XB7GRhxw4NYmBNOVjL5
 lr+M+z8RYzlEapAb99IOGJ7bpSt+tOogDKvjkdCwMGfuTmQdoeLBftAjlzvvrXJKZp67XW3jN
 YNji9cffipvSVMzIxFswua3PnJ0QD4vyeIJ5c0shht957JCDFphiI8vvN76SH9KAPTcS33mYT
 OchrFPXRi4EYvDxVhZE1+ihyP8WLpmw3rPCzww3B5evX5o7Pm5dTyewKQjQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds RPM support to the pwm-fan driver in order to use with
fancontrol/pwmconfig. This feature is intended for fans with a tachometer
output signal, which generate a defined number of pulses per revolution.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/hwmon/pwm-fan.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 167221c..3245a49 100644
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
+	u8 pulses_per_revolution;
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
+	atomic_inc(&ctx->pulses);
+
+	return IRQ_HANDLED;
+}
+
+static void sample_timer(struct timer_list *t)
+{
+	struct pwm_fan_ctx *ctx = from_timer(ctx, t, rpm_timer);
+	int pulses;
+	u64 tmp;
+
+	pulses = atomic_read(&ctx->pulses);
+	atomic_sub(pulses, &ctx->pulses);
+	tmp = (u64)pulses * ktime_ms_delta(ktime_get(), ctx->sample_start) * 60;
+	do_div(tmp, ctx->pulses_per_revolution * 1000);
+	ctx->rpm = tmp;
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
+		if (ctx->irq <= 0)
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
@@ -261,17 +331,45 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		goto err_reg_disable;
 	}
 
+	timer_setup(&ctx->rpm_timer, sample_timer, 0);
+
+	if (of_property_read_u8(pdev->dev.of_node, "pulses-per-revolution",
+				&ctx->pulses_per_revolution)) {
+		ctx->pulses_per_revolution = 2;
+	}
+
+	if (!ctx->pulses_per_revolution) {
+		dev_err(&pdev->dev, "pulses-per-revolution can't be zero.\n");
+		ret = -EINVAL;
+		goto err_pwm_disable;
+	}
+
+	ctx->irq = platform_get_irq(pdev, 0);
+	if (ctx->irq == -EPROBE_DEFER) {
+		ret = ctx->irq;
+		goto err_pwm_disable;
+	} else if (ctx->irq > 0) {
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
 		dev_err(&pdev->dev, "Failed to register hwmon device\n");
 		ret = PTR_ERR(hwmon);
-		goto err_pwm_disable;
+		goto err_del_timer;
 	}
 
 	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
 	if (ret)
-		return ret;
+		goto err_del_timer;
 
 	ctx->pwm_fan_state = ctx->pwm_fan_max_state;
 	if (IS_ENABLED(CONFIG_THERMAL)) {
@@ -282,7 +380,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"Failed to register pwm-fan as cooling device");
 			ret = PTR_ERR(cdev);
-			goto err_pwm_disable;
+			goto err_del_timer;
 		}
 		ctx->cdev = cdev;
 		thermal_cdev_update(cdev);
@@ -290,6 +388,9 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_del_timer:
+	del_timer_sync(&ctx->rpm_timer);
+
 err_pwm_disable:
 	state.enabled = false;
 	pwm_apply_state(ctx->pwm, &state);
@@ -306,6 +407,8 @@ static int pwm_fan_remove(struct platform_device *pdev)
 	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
 
 	thermal_cooling_device_unregister(ctx->cdev);
+	del_timer_sync(&ctx->rpm_timer);
+
 	if (ctx->pwm_value)
 		pwm_disable(ctx->pwm);
 
-- 
2.7.4

