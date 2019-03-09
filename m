Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F352C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A32020851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PN1wFFcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCIBmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:42:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46515 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfCIBmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 20:42:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so15389654pfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 17:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/qjRfyOVmx3bnneqIMlAg6laFbhPIBTKvDaaNaPmIg=;
        b=PN1wFFcsn3sEOa9SJUdl65JD9ihwcIQkwukcwuXIARHX3IgfQW0H5O9yzIv9NMrKMP
         LLynDy+219qmpvQaaKn1bwmrXetUdaotM1RzX15ktX7y6wynJMOekqX1GmBFmNJDjddU
         8f9t5x6fTtfUBA0LrEWL0hFw4WbttH6uGaiyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/qjRfyOVmx3bnneqIMlAg6laFbhPIBTKvDaaNaPmIg=;
        b=J7mNCXm0SAmL/+lfqdui0CJtm98wem3CKpdtZ51uG3oBDsaYG4acJdp0tHhdImS71q
         yOCtTbscoCMSBfK1jBXxCCExmHNZu100bQIzNCpYPqvlqXyVJ9SJIxjOSd2QR7nhA8FU
         YfwJg3+nctPdTfqHSCTWK5RAH1wwtPOGZwJqUiJXGsD906z9L10n5XKw0ltTfxkElg3f
         KzskDXzJouwe7NG8pGcN8zSThsCqZTT5JKo/Fp6ECJFJFe3E8TbIX4gWT2OniRZDQeKU
         2AzCAbkdzL1qNpk6YDWbS3Gjw8RztMlkUMrMC9JJ3zgP49AHoAki3/qz+SHOBrk1zo7r
         AjLA==
X-Gm-Message-State: APjAAAVc1xiNCJoFnEHlOhmh5Dhj+CaVdOLELBfB9Ioqln7rVSK0GO1g
        Vnvt8i8lTPv1CT9PsCXn+tpToQ==
X-Google-Smtp-Source: APXvYqxz22nlphLNWTluwV7N4yRMu8XG5S1p70KzD5OpjhrkxQZdodPIBFaAgpTwVqUSBt7Kokp44Q==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33mr22100108pld.308.1552095764607;
        Fri, 08 Mar 2019 17:42:44 -0800 (PST)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id b15sm17637783pfj.167.2019.03.08.17.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Mar 2019 17:42:44 -0800 (PST)
From:   RaviChandra Sadineni <ravisadineni@chromium.org>
To:     ravisadineni@chromium.org
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        tbroch@google.com
Subject: [PATCH V5] platform/chrome: mfd/cros_ec_dev: Add sysfile to force
Date:   Fri,  8 Mar 2019 17:42:39 -0800
Message-Id: <20190309014239.79938-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <404dd7fe-23de-e5c4-48c2-5cd77a14e72b@collabora.com>
References: <404dd7fe-23de-e5c4-48c2-5cd77a14e72b@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On chromebooks, power_manager daemon normally shuts down(S5) the device
when the battery charge falls below 4% threshold. ChromeOS EC then
normally spends an hour in S5 before hibernating. If the battery charge
falls below critical threshold in the mean time, EC does a battery cutoff
instead of hibernating. On some chromebooks, S5 is optimal enough
resulting in EC hibernating without battery cutoff. This results in
battery deep discharging. This is a bad user experience as battery
has to trickle charge before booting when the AC is plugged in the next
time.

This patch exposes a sysfs file for an userland daemon to suggest EC if it
has to do a battery cutoff instead of hibernating when the system enters
S5 next time.

This attribute is present only if EC supports EC_FEATURE_BATTERY.

Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
---
V5: Expose flag only when EC_FEATURE_BATTERY is supported.
V4: Addressed comments from Enric.
V3: Make battery-cutoff generic and expose 'at-shutdown' flag.
V2: Use kstrtobool() instead of kstrtou8() and add documentation.

.../ABI/testing/sysfs-class-chromeos          | 16 ++++++
 drivers/mfd/cros_ec_dev.c                     |  4 ++
 drivers/platform/chrome/cros_ec_sysfs.c       | 49 +++++++++++++++++++
 include/linux/mfd/cros_ec.h                   |  2 +
 4 files changed, 71 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-chromeos b/Documentation/ABI/testing/sysfs-class-chromeos
index 5819699d66ec..0927704d1629 100644
--- a/Documentation/ABI/testing/sysfs-class-chromeos
+++ b/Documentation/ABI/testing/sysfs-class-chromeos
@@ -30,3 +30,19 @@ Date:		August 2015
 KernelVersion:	4.2
 Description:
 		Show the information about the EC software and hardware.
+
+What:           /sys/class/chromeos/<ec-device-name>/battery_cuttoff
+Date:           February 2019
+Contact:        Ravi Chandra Sadineni <ravisadineni@chromium.org>
+Description:
+                cros_ec battery cuttoff configuration. Only option
+                currently exposed is 'at-shutdown'.
+
+                'at-shutdown' sends a host command to EC requesting
+                battery cutoff on next shutdown. If AC is plugged
+                in before next shutdown, EC ignores the request and
+                resets the flag.
+
+                Currently EC does not expose a host command to read
+                the status of battery cutoff configuration. Thus this
+                flag is write-only.
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index ed809fc97df8..7580be23dfb3 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -502,6 +502,10 @@ static int ec_device_probe(struct platform_device *pdev)
 				 retval);
 	}
 
+	/* check whether EC_FEATURE_BATTERY is supported. */
+	if (cros_ec_check_features(ec, EC_FEATURE_BATTERY))
+		ec->has_battery = true;
+
 	return 0;
 
 failed:
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index fe0b7614ae1b..3d9ab55dddc0 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -308,14 +308,61 @@ static ssize_t kb_wake_angle_store(struct device *dev,
 	return count;
 }
 
+/* Battery cutoff control */
+static ssize_t battery_cutoff_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct ec_params_battery_cutoff *param;
+	struct cros_ec_command *msg;
+	int ret;
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
+	char *p;
+	int len;
+
+	msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	param = (struct ec_params_battery_cutoff *)msg->data;
+	msg->command = EC_CMD_BATTERY_CUT_OFF + ec->cmd_offset;
+	msg->version = 1;
+	msg->outsize = sizeof(*param);
+	msg->insize = 0;
+
+	p = memchr(buf, '\n', count);
+	len = p ? p - buf : count;
+
+	if (len == 11 && !strncmp(buf, "at-shutdown", len)) {
+		param->flags = EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN;
+	} else {
+		count = -EINVAL;
+		goto exit;
+	}
+
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret < 0)
+		count = ret;
+exit:
+	kfree(msg);
+	return count;
+}
+
 /* Module initialization */
 
 static DEVICE_ATTR_RW(reboot);
 static DEVICE_ATTR_RO(version);
 static DEVICE_ATTR_RO(flashinfo);
 static DEVICE_ATTR_RW(kb_wake_angle);
+/*
+ * Currently EC does not expose a host command to read the status of
+ * battery cutoff configuration. Also there is no requirement to read
+ * the flag from userland. So marking this attribute as write-only.
+ */
+static DEVICE_ATTR_WO(battery_cutoff);
 
 static struct attribute *__ec_attrs[] = {
+	&dev_attr_battery_cutoff.attr,
 	&dev_attr_kb_wake_angle.attr,
 	&dev_attr_reboot.attr,
 	&dev_attr_version.attr,
@@ -331,6 +378,8 @@ static umode_t cros_ec_ctrl_visible(struct kobject *kobj,
 
 	if (a == &dev_attr_kb_wake_angle.attr && !ec->has_kb_wake_angle)
 		return 0;
+	if (a == &dev_attr_battery_cutoff.attr && !ec->has_battery)
+		return 0;
 
 	return a->mode;
 }
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 8f2a8918bfa3..de5280c96bd9 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -192,6 +192,7 @@ struct cros_ec_debugfs;
  * @has_kb_wake_angle: True if at least 2 accelerometer are connected to the EC.
  * @cmd_offset: Offset to apply for each command.
  * @features: Features supported by the EC.
+ * @has_battery: True if EC supports EC_FEATURE_BATTERY.
  */
 struct cros_ec_dev {
 	struct device class_dev;
@@ -202,6 +203,7 @@ struct cros_ec_dev {
 	bool has_kb_wake_angle;
 	u16 cmd_offset;
 	u32 features[2];
+	bool has_battery;
 };
 
 #define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
-- 
2.20.1

